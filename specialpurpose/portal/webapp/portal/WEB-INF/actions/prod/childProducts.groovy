import javolution.util.FastMap;
import javolution.util.FastList;
import java.util.List;
import java.util.Set;

import net.sf.json.JSONObject;

import org.ofbiz.entity.*;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;
import org.ofbiz.order.shoppingcart.ShoppingCart;
productId = parameters.productId;
String  firstProductId="";
int length = 0;
resultMap = [:];

Locale locale= org.ofbiz.base.util.UtilHttp.getLocale(session);
if(UtilValidate.isNotEmpty(productId)){
	try {
		beganTransaction = TransactionUtil.begin();
		mainProduct = delegator.findByPrimaryKey("Product", UtilMisc.toMap("productId", productId)); 
		mainInventory = dispatcher.runSync("getProductInventoryAvailable", [productId: productId]); 
		mainInventoryNum=0;
		if(mainInventory){
			mainInventoryNum=mainInventory.availableToPromiseTotal;
		}
		//productAssocs = EntityUtil.filterByDate(delegator.findByAnd("ProductAssoc", [productId:productId,productAssocTypeId:'PRODUCT_VARIANT']));
		productAssocs = delegator.findByAnd("ProductAssoc", [productId:productId,productAssocTypeId:'PRODUCT_VARIANT']);
		length = productAssocs.size();
		childList =  FastList.newInstance();
		featureCategoryList= FastList.newInstance();
		for(pa in productAssocs){
			childProductMap = FastMap.newInstance();
			//child proudct
			product = delegator.findByPrimaryKey("Product", UtilMisc.toMap("productId", pa.productIdTo));
			features = delegator.findByAnd("ProductFeatureAppl",[productId:pa.productIdTo]);
			System.out.println("******"+features);
			featuresMap = FastMap.newInstance();
			if(UtilValidate.isNotEmpty(features)){
				for(pf in features){
					feature = delegator.findByPrimaryKey("ProductFeature",UtilMisc.toMap("productFeatureId", pf.productFeatureId));
					GenericValue featureCategory=delegator.findByPrimaryKey("ProductFeatureCategory",UtilMisc.toMap("productFeatureCategoryId", feature.productFeatureCategoryId));
					//获取多语言特征分类名称
					String descriptionCate=featureCategory.description;
					/*
					if(locale.getLanguage()=="zh"){ 
						descriptionCate=featureCategory.descriptionZh;
					}else if(locale.getLanguage()=="ru"){
						descriptionCate=featureCategory.descriptionRu;
					}else{
						descriptionCate=featureCategory.description;
					}*/
					featureCategory.put("description",descriptionCate);
					if(!featureCategoryList.contains(featureCategory)){
						featureCategoryList.add(featureCategory);
					}
					Map featureMap = FastMap.newInstance();
					featureMap.put("productFeatureId",feature.productFeatureId);
					//featureMap.put("productFeatureTypeId",feature.productFeatureTypeId);
					featureMap.put("productFeatureTypeId",feature.productFeatureCategoryId);
					//获取多语言特征名称
					String descriptionFeature=feature.description; 
					/*
					if(locale.getLanguage().equals("zh")){  
						descriptionFeature=feature.descriptionZh;
					}else if(locale.getLanguage().equals("ru")){
						descriptionFeature=feature.descriptionRu;
					}else{
						descriptionFeature=feature.description;
					}*/
					featureMap.put("description",descriptionFeature);
					featuresMap.put(featureCategory.productFeatureCategoryId,featureMap);
				}
				childProductMap.put("productFeature",featuresMap);
			}
			//price
			//多币种获取价格
			cart = ShoppingCartEvents.getCartObject(request);
			String selectedCurrencyUomId=  (request.getSession().getAttribute("currencyUom")!=null)?request.getSession().getAttribute("currencyUom"):cart.getCurrency();
			context.currencyUomId_ = selectedCurrencyUomId
			
			priceMap = FastMap.newInstance();
			String productPrice="";
			marketPrices = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", [productId:pa.productIdTo,currencyUomId:selectedCurrencyUomId,productPriceTypeId:'LIST_PRICE']));
			if(UtilValidate.isNotEmpty(marketPrices))
				priceMap.put("listPrice",marketPrices[0].price);
			
			prices = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", [productId:pa.productIdTo,currencyUomId:selectedCurrencyUomId,productPriceTypeId:'DEFAULT_PRICE']));
			if(UtilValidate.isNotEmpty(prices))
				priceMap.put("defaultPrice",org.ofbiz.base.util.UtilFormatOut.formatCurrency(prices[0].price,selectedCurrencyUomId,locale));
			childProductMap.put("productPrice",priceMap);
			//childProductMap.putAll(product);
			childProductMap.put("isVirtual",product.isVirtual);
			childProductMap.put("productName",mainProduct.internalName);
			childProductMap.put("brandName",mainProduct.brandName);
			childProductMap.put("productId",product.productId);
			childProductMap.put("isVirtual",product.isVirtual);
			childProductMap.put("reviewed","N");
			childProductMap.put("reviewAvgRating","0");
			childProductMap.put("reviewTotalNums","0");
			childProductMap.put("isVariant","Y");
			childProductMap.put("showReview","N");
			childProductMap.put("imgUrl",product.smallImageUrl);//子商品图片
			try{
				resultInventory = dispatcher.runSync("getProductInventoryAvailable", [productId: pa.productIdTo]); 
				System.out.println("*****"+resultInventory.availableToPromiseTotal);
				if(resultInventory){
					childProductMap.put("inventoryNum",resultInventory.availableToPromiseTotal);
				}
				else{
					childProductMap.put("inventoryNum",0);
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
		//request.setAttribute("variant",childList);
		resultMap.put("variant",childList);
		context.childList=childList;
		context.featureCategoryList=featureCategoryList;
		context.mainInventoryNum=mainInventoryNum;
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
	if(UtilValidate.isNotEmpty(resultMap)){
		JSONObject json = JSONObject.fromObject(resultMap);
		String jsonStr = json.toString();
		if (jsonStr != null)
		{
			context.productJsonStr="("+jsonStr+")";
		}
	}
