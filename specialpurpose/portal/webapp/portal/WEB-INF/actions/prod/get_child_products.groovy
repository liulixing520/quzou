import javolution.util.FastMap;
import javolution.util.FastList;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.base.util.*;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.entity.transaction.TransactionUtil;
productId = parameters.productId;
int length = 0;
resultMap = [:];
if(UtilValidate.isNotEmpty(productId)){
	try {
		beganTransaction = TransactionUtil.begin();
		//productAssocs = EntityUtil.filterByDate(delegator.findByAnd("ProductAssoc", [productId:productId,productAssocTypeId:'PRODUCT_VARIANT']));
		productAssocs = delegator.findByAnd("ProductAssoc", [productId:productId,productAssocTypeId:'PRODUCT_VARIANT']);
		length = productAssocs.size();
		childList =  FastList.newInstance();
		for(pa in productAssocs){
			childProductMap = FastMap.newInstance();
			//child proudct
			product = delegator.findByPrimaryKey("Product", UtilMisc.toMap("productId", pa.productIdTo));
			childProductMap.put("product",product);
			//spec
			//productSpecs = delegator.findByAnd("ProductAssoc", [productId:productId,productAssocTypeId:'PRODUCT_VARIANT']);
			features = product.getRelated("ProductFeatureAppl");
			if(UtilValidate.isNotEmpty(features)){
				String featureStr = "";
				for(pf in features){
					feature = pf.getRelatedOne("ProductFeature");
					if(UtilValidate.isNotEmpty(featureStr))
						featureStr = featureStr + "," + feature.description; 
					else
						featureStr = featureStr + feature.description; 
					}
			childProductMap.put("features",featureStr);
			}
			//price
			marketPrices = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", [productId:pa.productIdTo,productPriceTypeId:'LIST_PRICE']));
			if(UtilValidate.isNotEmpty(marketPrices))
				childProductMap.put("marketPrice",marketPrices[0]);
			avergeCostPrices = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", [productId:pa.productIdTo,productPriceTypeId:'AVERAGE_COST']));
			if(UtilValidate.isNotEmpty(avergeCostPrices))
				childProductMap.put("avergeCostPrice",avergeCostPrices[0]);
			prices = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", [productId:pa.productIdTo,productPriceTypeId:'DEFAULT_PRICE']));
			if(UtilValidate.isNotEmpty(prices))
				childProductMap.put("priceGv",prices[0]);
			try{
				resultInventory = dispatcher.runSync("getProductInventoryAvailable", [productId: pa.productIdTo]);
				if(resultInventory){
					childProductMap.put("productInventory",resultInventory.availableToPromiseTotal);
				}
				else{
					childProductMap.put("productInventory",0);
				}
			}catch(Exception e){
			}
			productCalculatedInfo = delegator.findByPrimaryKey("ProductCalculatedInfo", UtilMisc.toMap("productId", pa.productIdTo));
			if(productCalculatedInfo)
				childProductMap.put("totalQuantityOrdered",productCalculatedInfo.productCalculatedInfo?productCalculatedInfo.productCalculatedInfo:0);
			else
				childProductMap.put("totalQuantityOrdered",0);
			
			
			childList.add(childProductMap);
		}
		request.setAttribute("data",childList);
		resultMap.put("data",childList);
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
	resultMap.put("length",length);
	org.ofbiz.ebiz.product.JsonUtil.toJsonObject(resultMap,response);
		return "none";