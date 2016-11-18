import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastMap;
import javolution.util.FastList;
import org.ofbiz.entity.condition.*;
import org.ofbiz.base.util.UtilMisc;
// Put the result of CategoryWorker.getRelatedCategories into the separateRootType function as attribute.
// The separateRootType function will return the list of category of given catalog.
// PLEASE NOTE : The structure of the list of separateRootType function is according to the JSON_DATA plugin of the jsTree.

completedTree = FastList.newInstance();
void separateRootType(roots,level) {
   if(roots) {
	   level++;
	   roots.each { root ->
		   prodCateMap = FastMap.newInstance();
		   geoGV = delegator.findByPrimaryKey("Geo", ["geoId" : root.geoIdTo]);
		   prodCateMap.put("geoGv", geoGV);
		   prodCateMap.put("lev", level);
		   completedTree.add(prodCateMap);
	   }
   }
}
try{
   categoryAndExprs = FastList.newInstance();
   categoryAndExprs.add(EntityCondition.makeCondition("geoId", EntityOperator.EQUALS, "CHN"));
   geoList = delegator.find("GeoAssoc", EntityCondition.makeCondition(categoryAndExprs, EntityOperator.AND), null, null, null, null);
   while ((geoAssoc = geoList.next())) {
	   lev = 1;
	   geoMap = FastMap.newInstance();
	   geo = delegator.findByPrimaryKey("Geo", ["geoId" : geoAssoc.geoIdTo]);
	   geoMap.put("geoGv", geo);
	   geoMap.put("lev", lev);
	   geos = delegator.findByAnd("GeoAssoc", ["geoId" : geoAssoc.geoIdTo]);
	   if (geos) {geoMap.put("childCount", geos.size());}else geoMap.put("childCount", 0);
	   completedTree.add(geoMap);
	   if (geos) {
		   separateRootType(geos,lev);
	   }
   }
}catch(Exception e){
   
}
finally{
   
   geoList.close();
}
// The complete tree list for the category tree
context.geoList = completedTree;