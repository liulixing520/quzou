import org.ofbiz.product.product.ProductWorker;
import org.ofbiz.entity.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;
import net.sf.json.JSONObject;

println ">>>>>>>>>>>>"+add_product_id
if ("Y".equals(product.isVirtual)) {
	productVirtualVariantMethod = ProductWorker.getProductVirtualVariantMethod(delegator, productId)

    if ("VV_FEATURETREE".equals(productVirtualVariantMethod)) {
        context.featureLists = ProductWorker.getSelectableProductFeaturesByTypesAndSeq(product);
    } else {
        productAssocs = delegator.findByAnd("ProductAssoc", [productId:productId,productAssocTypeId:'PRODUCT_VARIANT']);
        productIdTos = EntityUtil.getFieldListFromEntityList(productAssocs, "productIdTo", true)
        
        featureGvList = delegator.findList("ProductFeatureAndAppl",EntityCondition.makeCondition([EntityCondition.makeCondition("productId",EntityOperator.IN,productIdTos), EntityCondition.makeCondition("productFeatureApplTypeId","STANDARD_FEATURE")]),null,["sequenceNum", "productFeatureTypeId"],null,true)
        productFeatureCategoryIdSet = EntityUtil.getFieldListFromEntityList(featureGvList, "productFeatureCategoryId", true)
        childrenIdSet = EntityUtil.getFieldListFromEntityList(featureGvList, "productId", true)
        featuresMap = [:]
		defaultFeatureCombine = [:]
		cateFeatureInfo = [:]
        defaultProductInfo = null
        for(childrenId in childrenIdSet){
        	childProductMap = [:]
			//cart = ShoppingCartEvents.getCartObject(request);
			//String selectedCurrencyUomId=  (request.getSession().getAttribute("currencyUom")!=null)?request.getSession().getAttribute("currencyUom"):cart.getCurrency();
			selectedCurrencyUomId=  'CNY'
			context.currencyUomId_ = selectedCurrencyUomId
			
			product = delegator.findOne("Product",true,[productId:childrenId])
			priceMap = [:]
			String productPrice="";
			marketPrices = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", [productId:childrenId,currencyUomId:selectedCurrencyUomId,productPriceTypeId:'LIST_PRICE']));
			if(marketPrices)
				priceMap.put("listPrice",marketPrices[0].price);
			
			prices = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice", [productId:childrenId,currencyUomId:selectedCurrencyUomId,productPriceTypeId:'DEFAULT_PRICE']));
			if(prices)
				priceMap.put("defaultPrice",org.ofbiz.base.util.UtilFormatOut.formatCurrency(prices[0].price,selectedCurrencyUomId,locale));
			childProductMap.put("productPrice",priceMap);
			childProductMap.put("isVirtual",product.isVirtual);
			childProductMap.put("productName",product.internalName);
			childProductMap.put("brandName",product.brandName);
			childProductMap.put("productId",product.productId);
			childProductMap.put("isVirtual",product.isVirtual);
			childProductMap.put("reviewed","N");
			childProductMap.put("reviewAvgRating","0");
			childProductMap.put("reviewTotalNums","0");
			childProductMap.put("isVariant","Y");
			childProductMap.put("showReview","N");
			//childProductMap.put("imgUrl",product.smallImageUrl);//子商品图片
			try{
				resultInventory = dispatcher.runSync("getProductInventoryAvailable", [productId:childrenId]); 
				System.out.println("*****"+resultInventory.availableToPromiseTotal);
				if(resultInventory){
					childProductMap.put("inventoryNum",resultInventory.availableToPromiseTotal);
				}
				else{
					childProductMap.put("inventoryNum",0);
				}
			}catch(Exception e){
				e.printStackTrace()
			}
			productCalculatedInfo = delegator.findByPrimaryKey("ProductCalculatedInfo",["productId": childrenId]);
			if(productCalculatedInfo)
				childProductMap.put("totalQuantityOrdered",productCalculatedInfo.productCalculatedInfo?productCalculatedInfo.productCalculatedInfo:0);
			else
				childProductMap.put("totalQuantityOrdered",0);

			isDefault = false
			if(add_product_id && add_product_id == childrenId){
				defaultProductInfo = childProductMap
				isDefault = true
			}else if(!defaultProductInfo && !add_product_id){
				defaultProductInfo = childProductMap
				isDefault = true
			}
			
        	entries = EntityUtil.filterByAnd(featureGvList,["productId":childrenId])
        	entryMap = featuresMap
        	max = productFeatureCategoryIdSet.size()
        	for(i = 0; i < max; i++){
        	 	productFeatureCategoryId = productFeatureCategoryIdSet[i]
        		entry = EntityUtil.filterByAnd(entries,["productFeatureCategoryId":productFeatureCategoryId])
        		key = entry[0].productFeatureId
        		if(i!=max-1){
	        		if(entryMap.containsKey(key)){
	        			entryMap = entryMap[key]
	        		}else{
	        			entryMap[key] = [:]
	        			entryMap = entryMap[key]
	        		}
        		}else{
    				entryMap[key] = childProductMap
        		}
        		//默认选中的特征
        		if(isDefault){
        			defaultFeatureCombine[productFeatureCategoryIdSet[i]] = key
        		}
        		//搜集特征值集合
        		cateFeatureEntry = [:]
        		cateGv = delegator.findOne("ProductFeatureCategory",true,["productFeatureCategoryId":productFeatureCategoryId])
        		cateFeatureEntry.name = cateGv.description
        		filterFeatures = EntityUtil.filterByAnd(featureGvList,["productFeatureCategoryId":productFeatureCategoryId])
				featureIds = EntityUtil.getFieldListFromEntityList(filterFeatures, "productFeatureId", true)
        		cateFeatureEntry.featureIds = featureIds
        		cateFeatureInfo[productFeatureCategoryId] = cateFeatureEntry
        	}
        }
        context.featuresMap = featuresMap
        context.productFeatureCategoryIdSet = productFeatureCategoryIdSet
        context.childrenIdSet = childrenIdSet
        context.defaultProductInfo = defaultProductInfo
        context.defaultFeatureCombine = defaultFeatureCombine
        context.cateFeatureInfo = cateFeatureInfo
        
        JSONObject featuresMapJson = JSONObject.fromObject(featuresMap);
		String featuresMapJsonStr = featuresMapJson.toString();
		if (featuresMapJsonStr != null)
		{
			context.featuresMapJsonStr="("+featuresMapJsonStr+")";
		}
        JSONObject defaultFeatureCombineJson = JSONObject.fromObject(defaultFeatureCombine);
		String defaultFeatureCombineJsonStr = defaultFeatureCombineJson.toString();
		if (defaultFeatureCombineJsonStr != null)
		{
			context.defaultFeatureCombineJsonStr="("+defaultFeatureCombineJsonStr+")";
		}
		
 	}           
}