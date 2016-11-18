import javolution.util.FastMap;
import javolution.util.FastList;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.base.util.*;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.entity.transaction.TransactionUtil;
parentGeoId = parameters.parentGeoId;
regionPath = parameters.regionPath;
try {
	regionGrade = Integer.valueOf((String)parameters.get("regionGrade")).intValue();
} catch (NumberFormatException nfe) {
		regionGrade = 1;
}
int length = 0;
if(UtilValidate.isNotEmpty(parentGeoId)){
	try {
		beganTransaction = TransactionUtil.begin();
		geoAssocs = delegator.findByAnd("GeoAssoc", [geoId:parentGeoId,geoAssocTypeId:'REGIONS'],['-sequenceNum']);
		length = geoAssocs.size();
		childList =  FastList.newInstance();
		for(geoAssoc in geoAssocs){
			childProductMap = FastMap.newInstance();
			//child geo
			geo = delegator.findByPrimaryKey("Geo", UtilMisc.toMap("geoId", geoAssoc.geoIdTo));
			childProductMap.put("geo",geo);
			childProductMap.put("geoAssoc",geoAssoc);
			childProductMap.put("regionPath",regionPath+geo.geoId+",");
			childProductMap.put("regionGrade",regionGrade+1);
			childList.add(childProductMap);
		}
		request.setAttribute("data",childList);
	} catch (GenericEntityException e) {
	Debug.logError(e, "Failure in operation, rolling back transaction", "GetContentLookupList.groovy");
	try {
		// only rollback the transaction if we started one...
		TransactionUtil.rollback(beganTransaction, "Error looking up entity values in WebTools Entity Data Maintenance", e);
	} catch (GenericEntityException e2) {
		Debug.logError(e2, "Could not rollback transaction: " + e2.toString(), "GetContentLookupList.groovy");
	}
	// after rolling back, rethrow the exception
	throw e;
	} finally {
		// only commit the transaction if we started one... this will throw an exception if it fails
		TransactionUtil.commit(beganTransaction);
	}
}
	request.setAttribute("length",length);