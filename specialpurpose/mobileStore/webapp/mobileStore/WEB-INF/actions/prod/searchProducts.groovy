/*
cid	0	分类
expandName	
expressionKey	属性筛选
keyword	2	
page	2
region	2库存 区域
regionName	
resourceType	search
resourceValue	
self	配送京东/ 第三方 1 2
sid	eb93dd665f8a2b18e78b8032693d3bba
sort	6
stock   有货
*/
import java.util.Map
import org.ofbiz.base.util.*
import org.ofbiz.product.catalog.*
import org.ofbiz.product.feature.*
import org.ofbiz.product.product.*
import java.lang.Math
import javolution.util.*

import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil
import javolution.util.FastList
import java.math.BigDecimal
import java.util.Collections
import java.util.Comparator
import org.ofbiz.ebiz.product.ProductHelper

List addChildCategories(parents) {
    if(parents) {
        childsList = []
        parents.each { category ->
        	cList = delegator.findByAnd("ProductCategory", ['primaryParentCategoryId':category.productCategoryId])
        	if(cList && cList.size()>0){
        		childsList = childsList+cList
        	}
        }
        if(childsList.size()==0){
        	return parents
        }else{
        	return parents + addChildCategories(childsList)
        }
    }else{
    	root = delegator.findList("ProductCategory", EntityCondition.makeCondition('primaryParentCategoryId','PortalRootCat'), null, null, null, false)
    	return addChildCategories(root)
    }
}
Map getSuperiorCategories(categoryInfo) {
	superiorCategoriesMap = [:]
    if(categoryInfo) {
    	category = categoryInfo[categoryInfo.keySet()[0]]
		parentCategoryId = category.primaryParentCategoryId
		leval = category.leval
		if(leval<=3 && parentCategoryId && parentCategoryId!='PortalRootCat'){
        	parentCategory = delegator.findOne("ProductCategory",false, ['productCategoryId':parentCategoryId])
        	if(parentCategory){
	        	superiorCategoriesMap[parentCategoryId] = ['categoryName':parentCategory.categoryName,'primaryParentCategoryId':parentCategory.primaryParentCategoryId,'leval':(1+leval),'child':categoryInfo]
				if(parentCategory.primaryParentCategoryId){
					return getSuperiorCategories(superiorCategoriesMap)
				}else{
					return superiorCategoriesMap
				}
			}
		}
    }
    return categoryInfo
}
Map getChildrenOnly(parentId){
	returnMap = [:]
	children = delegator.findList("ProductCategory", EntityCondition.makeCondition('primaryParentCategoryId',parentId), null, null, null, false)
	if(children && children.size()>0){
		children.each{ category->
			returnMap[category.productCategoryId] = ['categoryName':category.categoryName,'primaryParentCategoryId':parentId]
		}
	}
	return returnMap
}

int filterCategoryTree(cateTree){
	treeDepth = 1
	flag = false
	rootKeys = cateTree.keySet().iterator()
    while (rootKeys.hasNext()){
        k1 = rootKeys.next()
        v1 = cateTree[k1]
        if(v1.child && v1.child.size()>0){
			child1 = v1.child
			childKeySet = child1.keySet()
			v1.childKeySet = childKeySet
			firstKeys = childKeySet.iterator()
			while(firstKeys.hasNext()){
				k2 = firstKeys.next()
				v2 = child1[k2]
				if(v2.child && v2.child.size()>0){
					child2 = v2.child
					v2.childKeySet = child2.keySet()
					if(treeDepth<3)treeDepth=3
				}else{
					firstKeys.remove()
					flag = true
				}
			}
			if(treeDepth<2)treeDepth=2
		}else{
			rootKeys.remove()
		}
  	}
  	if(flag){
  		return 0
  	}else{
  		return treeDepth
  	}
}

cdtList = []
sortList = ["productName"]
needFilterAttr = false
filterMap = [:]
allCategories = []
if(parameters.expressionKey && parameters.expressionKey != ''){
	attriKVs = parameters.expressionKey
	attriKVArr = attriKVs.split(",")
	attriKVArr.each{attriKV->
		attr_k_v = attriKV.split(":")
		if(attr_k_v.length==2){
			//filterKey = attr_k_v[0]
			//filterVal = attr_k_v[1]
			filterMap[attr_k_v[0]] = attr_k_v[1]
			if(!needFilterAttr)
				needFilterAttr = true
		}
	}
}
if(parameters.cid && parameters.cid != ''){
	cids = ['noSuchCid']
	productCategory = delegator.findOne("ProductCategory",false, ['productCategoryId':parameters.cid])
	if(productCategory){
		cGvs = addChildCategories([productCategory])
		cids = cids + EntityUtil.getFieldListFromEntityList(cGvs, "productCategoryId", true)
		allCategories = [parameters.cid]
	}
	cdtList.add(EntityCondition.makeCondition('primaryProductCategoryId',EntityOperator.IN,cids))
}
if(parameters.keyword && parameters.keyword != ''){
	keyConds = [EntityCondition.makeCondition('productName',EntityOperator.LIKE,'%'+parameters.keyword+'%'),EntityCondition.makeCondition('internalName',EntityOperator.LIKE,'%'+parameters.keyword+'%'),EntityCondition.makeCondition('productNameZh',EntityOperator.LIKE,'%'+parameters.keyword+'%')]
	cdtList.add(EntityCondition.makeCondition(keyConds,EntityOperator.OR))
}
roughList = delegator.findList("FilterProductView",EntityCondition.makeCondition(cdtList),null,null,null,false)
totalProdInfoList = []
showProdInfoList = []
allAttries = [:]

needCollectCategories = true
if(allCategories.size()>0){
	needCollectCategories = false
}

if(roughList && roughList.size()>0){
	roughList.each { prod ->
		def prodInfo = [:]
		prodInfo.productName = prod.internalName?prod.internalName:(prod.productNameZh?prod.productNameZh:prod.productNameRu)
		prodInfo.productId = prod.productId
		primaryProductCategoryId = prod.primaryProductCategoryId
		
		//图片
		imgMap = ProductHelper.getProdImgPaths(prod.productId,"EB_PRODIMG_INFO",delegator)
	    flag=imgMap.flag
		if(flag=='1' && imgMap.imgPathList)prodInfo.imgPath = imgMap.imgPathList[0]
		
		//库存
		stockResult = dispatcher.runSync("getProductInventoryAvailable", UtilMisc.toMap("productId", prod.productId))
		if(stockResult && stockResult.availableToPromiseTotal){
			prodInfo.stock = stockResult.availableToPromiseTotal
		}else{
			prodInfo.stock = 0
		}
		//库存过滤
		if(parameters.stock && parameters.stock != '' && prodInfo.stock <= 0){
			
		}else{
			//价格
			priceList = EntityUtil.filterByDate(delegator.findByAnd("ProductPrice",['productId':prod.productId,'productPriceTypeId':'DEFAULT_PRICE'], ["fromDate"]))
			if(priceList && priceList.size()>0){
				cnyPrice = EntityUtil.filterByAnd(priceList,["currencyUomId":"CNY"])
				//usdPrice = EntityUtil.filterByAnd(priceList,["currencyUomId":"USD"])
				//rurPrice = EntityUtil.filterByAnd(priceList,["currencyUomId":"RUB"])
				if(cnyPrice && cnyPrice.size()>0 && cnyPrice[0].price)
					prodInfo.price = cnyPrice[0].price
				else
					prodInfo.price = BigDecimal.ZERO
			}else{
				prodInfo.price = BigDecimal.ZERO
			}
			//销量
			productCalculatedInfo = delegator.findOne("ProductCalculatedInfo",["productId" : prod.productId], false)
			if(productCalculatedInfo && productCalculatedInfo.totalQuantityOrdered){
				prodInfo.saleQuantity = productCalculatedInfo.totalQuantityOrdered
			}else{
				prodInfo.saleQuantity = BigDecimal.ZERO
			}
			
			//属性
			prodAttries = delegator.findByAnd("ProductAttribute",['productId':prod.productId])
			attrInfo = [:]
			
			meetShowCond = true
			if(needFilterAttr){
				meetShowCond = false
			}
			if(prodAttries && prodAttries.size()>0){
				prodAttries.each { prodAttr ->
					attrName = prodAttr.attrName
					attrValue = prodAttr.attrValue
					attrInfo[attrName] = attrValue
					if(needFilterAttr && filterMap[attrName] && filterMap[attrName] == attrValue){
						meetShowCond = true
					}
					if(allAttries.containsKey(attrName)){
						attrValList = allAttries[attrName]
						if(!attrValList.contains(attrValue)){
							attrValList.add(attrValue)
							allAttries[attrName] = attrValList
						}
					}else{
						tempList = []
						tempList.add(attrValue)
						allAttries[attrName] = tempList
					}
				}
			}
			prodInfo.attrInfo = attrInfo
			totalProdInfoList.add(prodInfo)
			if(meetShowCond)showProdInfoList.add(prodInfo)
			if(needCollectCategories){
				if(primaryProductCategoryId && !allCategories.contains(primaryProductCategoryId)){
					allCategories.add(primaryProductCategoryId)
				}
			}
		}
	}

	if(parameters.sort && parameters.sort != ''){
		sort = parameters.sort
		if(sort=='0'){sortList=["productName"]}//相关度
		if(sort=='1'){
			//销量
			Collections.sort(showProdInfoList, new Comparator<Map<String, Object>>() {
				public int compare(Map<String, Object> b1, Map<String, Object> b2) {
					return ((BigDecimal) b1.saleQuantity).compareTo((BigDecimal) b2.saleQuantity)
				}
			})
		}
		if(sort=='2'){
			//价格高低
			Collections.sort(showProdInfoList, new Comparator<Map<String, Object>>() {
				public int compare(Map<String, Object> b1, Map<String, Object> b2) {
					return ((BigDecimal) b2.price).compareTo((BigDecimal) b1.price)
				}
			})
		}
		if(sort=='3'){
			//价格低高
			Collections.sort(showProdInfoList, new Comparator<Map<String, Object>>() {
				public int compare(Map<String, Object> b1, Map<String, Object> b2) {
					return ((BigDecimal) b1.price).compareTo((BigDecimal) b2.price)
				}
			})
		}
		if(sort=='4'){
			//评价数 销量暂代 
			Collections.sort(showProdInfoList, new Comparator<Map<String, Object>>() {
				public int compare(Map<String, Object> b1, Map<String, Object> b2) {
					return ((BigDecimal) b1.saleQuantity).compareTo((BigDecimal) b2.saleQuantity)
				}
			})
		}
	}
	session = request.getSession()
	session.setAttribute("totalProdInfoList",totalProdInfoList)
	session.setAttribute("showProdInfoList",showProdInfoList)
	totalPage = 1
	showListSize = showProdInfoList.size()
	if(showListSize>15){
		showProdInfoList = showProdInfoList[0..14]
		totalPage = (int)showListSize/15
		if(showListSize%15!=0)totalPage++
	}
	
	//分类筛选数据整理
	allCategoriesTree = [:]
	if(allCategories.size()>0){
		allCategories.each{ categoryId->
			superierCategoryMap = [:]
			//向上找
    		category = delegator.findOne("ProductCategory",false, ['productCategoryId':categoryId])
			if(category){
				superierCategoryMap[categoryId] = ['categoryName':category.categoryName,'primaryParentCategoryId':category.primaryParentCategoryId,'leval':1]
				if(category.primaryParentCategoryId && category.primaryParentCategoryId!='PortalRootCat'){
					superierCategoryMap = getSuperiorCategories(superierCategoryMap)
				}
				//只处理3层目录
				if(superierCategoryMap){
					//superierCategoryMap.each{ k1,v1->
					for(k1 in superierCategoryMap.keySet()){
						v1 = superierCategoryMap[k1]
						if(!allCategoriesTree.containsKey(k1)){
							allCategoriesTree[k1] = v1
						}
						treeVal1 = allCategoriesTree[k1]
						treeChild1 = treeVal1.child
						vChild1 = v1.child
						if(!vChild1){
							vChild1 = getChildrenOnly(k1)
						}
						if(vChild1.size()>0){
							if(treeChild1 && treeChild1.size()>0){
								//第二层比对
								//vChild1.each{ k2,v2->
								for(k2 in vChild1.keySet()){
									v2 = vChild1[k2]
									if(!treeChild1.containsKey(k2)){
										treeChild1[k2] = v2
									}
									//第三层对比
									treeVal2 = treeChild1[k2]
									treeChild2 = treeVal2.child
									vChild2 = v2.child
									if(!vChild2){
										vChild2 = getChildrenOnly(k2)
									}
									if(vChild2.size()>0){
										if(treeChild2 && treeChild2.size()>0){
											//vChild2.each{ k3,v3->
											for(k3 in vChild2.keySet()){
												v3 = vChild1[k3]
												if(treeChild2.containsKey(k3)){
													//已存在
												}else{
													treeChild2[k3] = v3
												}
											}
										}else{
											treeVal2.child = vChild2
										}
									}
								}
							}else{
								treeVal1.child = vChild1
							}
						}
					}
				}
			}
		}
	}
	treeDepth = filterCategoryTree(allCategoriesTree)
    while(treeDepth == 0){
    	treeDepth = filterCategoryTree(allCategoriesTree)
    }
    
	if(allCategoriesTree.size()==1 && treeDepth == 3){
		allCategoriesTree = allCategoriesTree[allCategoriesTree.keySet()[0]].child
	}
	
	context.allAttries = allAttries
	context.attrieHeads = allAttries.keySet()
	context.allCategoriesTree = allCategoriesTree
	context.allCateHeads = allCategoriesTree.keySet()
	context.showProdInfoList = showProdInfoList
	context.filterAttrMap = filterMap
	context.totalPage = totalPage
} 
