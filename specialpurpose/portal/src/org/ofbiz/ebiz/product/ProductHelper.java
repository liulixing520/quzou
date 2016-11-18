package org.ofbiz.ebiz.product;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;
import javolution.util.FastSet;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityJoinOperator;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.order.shoppingcart.ShoppingCart;
import org.ofbiz.order.shoppingcart.ShoppingCartEvents;
import org.ofbiz.order.shoppingcart.product.ProductPromoWorker;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceValidationException;

public class ProductHelper {

	public static final String module = ProductHelper.class.getName();

	/**
	 * 根据产品分类包含的产品，从产品标识集合中增加或移除
	 * 
	 * @param productCategoryIdSet
	 * @param productIdSet
	 * @param delegator
	 * @param nowTimestamp
	 * @param include
	 *            true增加或false移除
	 * @throws GenericEntityException
	 */
	public static void getAllProductIds(Set<String> productCategoryIdSet, Set<String> productIdSet, Delegator delegator, Timestamp nowTimestamp, boolean include) throws GenericEntityException {
		Iterator<String> productCategoryIdIter = productCategoryIdSet.iterator();
		while (productCategoryIdIter.hasNext()) {
			String productCategoryId = productCategoryIdIter.next();
			// get all product category memebers, filter by date
			List<GenericValue> productCategoryMembers = delegator.findByAndCache("ProductCategoryMember", UtilMisc.toMap("productCategoryId", productCategoryId));
			productCategoryMembers = EntityUtil.filterByDate(productCategoryMembers, nowTimestamp);
			Iterator<GenericValue> productCategoryMemberIter = productCategoryMembers.iterator();
			while (productCategoryMemberIter.hasNext()) {
				GenericValue productCategoryMember = productCategoryMemberIter.next();
				String productId = productCategoryMember.getString("productId");
				if (include) {
					productIdSet.add(productId);
				} else {
					productIdSet.remove(productId);
				}
			}
		}
	}

	/**
	 * 根据产品属性名称查询属性值
	 * 
	 * @param delegator
	 * @param productId
	 *            产品ID
	 * @param attrName
	 *            属性名称
	 * @return 如果属性值存在则返回这个属性值否则返回""
	 */
	public static String getProductAttrValueByName(GenericDelegator delegator, String productId, String attrName) {
		String result = null;
		try {
			// TODO 属性查询可能不准确,需要先求得产品所在类别才能找到列表的属性,因为不同类别可能有相同名称的属性.
			GenericValue attributeType = EntityUtil.getOnly(delegator.findByAnd("TypeAttribute", UtilMisc.toMap("attributeName", attrName)));
			if (UtilValidate.isNotEmpty(attributeType)) {
				String attributeId = attributeType.getString("attributeId");
				if ("SELECT".equals(attributeType.getString("entryWay"))) {
					GenericValue attrGv = EntityUtil.getOnly(delegator.findByAnd("ProductAttribute", UtilMisc.toMap("productId", productId, "attrName", attributeId)));
					if (UtilValidate.isNotEmpty(attrGv) && UtilValidate.isNotEmpty(attrGv.getString("attrValue"))) {
						GenericValue resultGv = EntityUtil.getOnly(delegator.findByAnd("AttrOptionalValue", UtilMisc.toMap("optionalId", attrGv.getString("attrValue"), "attributeId", attributeId)));
						if (UtilValidate.isNotEmpty(resultGv)) {
							result = resultGv.getString("optionalName");
						}
					}
				} else {
					GenericValue resultGv = EntityUtil.getOnly(delegator.findByAnd("ProductAttribute", UtilMisc.toMap("productId", productId, "attrName", attributeId)));
					if (UtilValidate.isNotEmpty(resultGv)) {
						result = resultGv.getString("attrValue");
					}
				}
			}
		} catch (GenericEntityException e) {
			Debug.logError(e, ProductHelper.class.getName());
			return result;
		}
		return result;
	}

	/**
	 * 根据产品属性名称查询可选属性值对象
	 * 
	 * @param delegator
	 * @param productId
	 *            产品ID
	 * @param attrName
	 *            属性名称
	 * @return 如果属性值存在则返回这个属性值对象否则返回null
	 */
	public static GenericValue getProductAttrOptionalValue(GenericDelegator delegator, String productId, String attrName) {
		GenericValue result = null;
		try {
			GenericValue attributeType = EntityUtil.getOnly(delegator.findByAnd("TypeAttribute", UtilMisc.toMap("attributeName", attrName, "entryWay", "SELECT")));
			if (UtilValidate.isNotEmpty(attributeType)) {
				String attributeId = attributeType.getString("attributeId");
				GenericValue attrGv = EntityUtil.getOnly(delegator.findByAnd("ProductAttribute", UtilMisc.toMap("productId", productId, "attrName", attributeId)));
				if (UtilValidate.isNotEmpty(attrGv) && UtilValidate.isNotEmpty(attrGv.getString("attrValue"))) {
					result = EntityUtil.getOnly(delegator.findByAnd("AttrOptionalValue", UtilMisc.toMap("optionalId", attrGv.getString("attrValue"), "attributeId", attributeId)));
				}
			}
		} catch (GenericEntityException e) {
			Debug.logError(e, ProductHelper.class.getName());
			return result;
		}
		return result;
	}

	/**
	 * 根据产品ID查询当前所属的产品类型分类对象
	 * 
	 * @param delegator
	 * @param productId
	 *            产品ID
	 * @return 如果当前时间属于某个分类,则返回这个分类对象,否则返回null
	 */
	public static GenericValue getProductTypeCategoryValue(GenericDelegator delegator, String productId) {
		GenericValue result = null;
		try {
			// TODO: 查询产品所属的类型类别.
			// List<GenericValue> gvList =
			// delegator.findByAnd("ProductCategoryAndMember",
			// UtilMisc.toMap("productId", productId, "productCategoryTypeId",
			// "TYPE_CATEGORY", "disType", "type"));
			// 2012-09-14 WuHK改变查询条件为productCategoryTypeId
			// CATALOG_CATEGORY/SEARCH_CATEGORY
			List<GenericValue> gvList = delegator.findList(
					"ProductCategoryAndMember",
					EntityCondition.makeCondition(
							UtilMisc.toList(EntityCondition.makeCondition("productId", EntityOperator.EQUALS, productId), EntityCondition.makeCondition("disType", EntityOperator.EQUALS, "type"),
									EntityCondition.makeCondition("productCategoryTypeId", EntityOperator.IN, UtilMisc.toList("CATALOG_CATEGORY", "SEARCH_CATEGORY"))), EntityOperator.AND), null, null, null, false);
			GenericValue gv = EntityUtil.getOnly(EntityUtil.filterByDate(gvList, new Date()));
			result = gv;
		} catch (GenericEntityException e) {
			Debug.logError(e, ProductHelper.class.getName());
			return result;
		}
		return result;
	}

	public static Map<String, Object> findPrice(Map args, Object product, LocalDispatcher dispatcher) {
		Map result = FastMap.newInstance();
		args.put("product", product);
		try {
			result = dispatcher.runSync("calculateProductPrice", args);
		} catch (ServiceValidationException e) {
			e.printStackTrace();
		} catch (GenericServiceException e) {
			e.printStackTrace();
		}
		return result;
	}

	public static int getReviewsCounts(String productId, LocalDispatcher dispatcher) {
		int reviews = 0;
		Delegator delegator = dispatcher.getDelegator();
		try {
			GenericValue product = delegator.findByPrimaryKeyCache("Product", UtilMisc.toMap("productId", productId));
			List<GenericValue> productReview = product.getRelatedCache("ProductReview");
			reviews = productReview.size();
		} catch (GenericEntityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reviews;
	}

	public static String createProdConsultation(HttpServletRequest req, HttpServletResponse res) {
		LocalDispatcher dispatcher = (LocalDispatcher) req.getAttribute("dispatcher");
		Delegator delegator = (Delegator) req.getAttribute("delegator");
		String productId = req.getParameter("productId");
		String content = req.getParameter("content");
		GenericValue userLogin = (GenericValue) req.getSession().getAttribute("userLogin");
		String partyIdFrom = UtilValidate.isNotEmpty(userLogin) ? (String) userLogin.get("partyId") : "_NA_";

		Map context = FastMap.newInstance();
		context.put("productId", productId);
		context.put("content", content);
		context.put("partyIdFrom", partyIdFrom);
		context.put("communicationEventTypeId", "WEB_SITE_COMMUNICATI");
		context.put("statusId", "COM_PENDING");
		context.put("ontactMechTypeId", "ELECTRONIC_ADDRESS");
		context.put("contentMimeTypeId", "application/msword");
		context.put("isReplied", "N");

		if (UtilValidate.isNotEmpty(productId)) {
			req.setAttribute("product_id", productId);
		}
		try {
			if (UtilValidate.isNotEmpty(userLogin)) {
				context.put("userLogin", userLogin);
			} else {
				context.put("userLogin", delegator.findByPrimaryKeyCache("UserLogin", UtilMisc.toMap("userLoginId", "system")));
			}
			Map resultMap = dispatcher.runSync("createCommunicationEvent", context);
			GenericValue successInfo = delegator.findOne("Enumeration", false, UtilMisc.toMap("enumId", "COMMUNI_SUCC_INFO"));
			if (UtilValidate.isNotEmpty(successInfo)) {
				req.setAttribute("successMSG", successInfo.getString("description"));
			}
			/*
			 * if (resultMap.get("communicationEventId") != null) { context =
			 * FastMap.newInstance(); context.put("productId", productId);
			 * context.put("userLogin", userLogin);
			 * context.put("communicationEventId",
			 * resultMap.get("communicationEventId"));
			 * dispatcher.runSync("createCommunicationEventProduct", context); }
			 */
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public static String createAFavorite(HttpServletRequest req, HttpServletResponse res) {
		LocalDispatcher dispatcher = (LocalDispatcher) req.getAttribute("dispatcher");
		String productId = req.getParameter("productId");
		GenericValue userLogin = (GenericValue) req.getSession().getAttribute("userLogin");
		String partyId = (String) userLogin.get("partyId");
		GenericDelegator delegator = (GenericDelegator) req.getAttribute("delegator");
		String productStoreId = ProductStoreWorker.getProductStoreId(req);

		EntityCondition cdt;
		List cdtList = FastList.newInstance();
		cdt = EntityCondition.makeCondition("shoppingListTypeId", EntityOperator.EQUALS, "SLT_WISH_LIST");
		cdtList.add(cdt);
		cdt = EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId);
		cdtList.add(cdt);
		cdt = EntityCondition.makeCondition("productId", EntityOperator.EQUALS, productId);
		cdtList.add(cdt);
		cdt = EntityCondition.makeCondition(cdtList, EntityJoinOperator.AND);

		try {
			List result = delegator.findList("ShoppingListAndItem", cdt, null, null, null, false);
			if (!(result == null || result.size() == 0)) {
				req.setAttribute("ifSuccess", "0");
			} else {
				Map reslutMap = dispatcher.runSync("addFavorite", UtilMisc.toMap("productId", productId, "userLogin", userLogin, "productStoreId", productStoreId));
				if (reslutMap.get("flag").equals("1")) {
					req.setAttribute("ifSuccess", "1");
				} else {
					req.setAttribute("ifSuccess", "2");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("ifSuccess", "2");
		}
		return "success";
	}

	/**
	 * 积分换购
	 */
	public static String rewardAmdiscProductList(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");

		String pageNumStr = request.getParameter("pageNum");
		String pageSizeStr = request.getParameter("pageSize");
		int pageSize = 9;
		int pageNum = 1;
		if (UtilValidate.isNotEmpty(pageNumStr)) {
			pageNum = Integer.parseInt(pageNumStr);
		}
		if (UtilValidate.isNotEmpty(pageSizeStr)) {
			pageSize = Integer.parseInt(pageSizeStr);
		}

		try {
			GenericValue productStore = ProductStoreWorker.getProductStore(request);
			List<GenericValue> productPromos = delegator.findByAnd("ProductStorePromoAppl", UtilMisc.toMap("productStoreId", productStore.getString("productStoreId")));
			List<String> productPromoIds = FastList.newInstance();
			for (GenericValue productPromo : productPromos) {
				if (UtilValidate.isNotEmpty(productPromo.getString("productPromoId"))) {
					productPromoIds.add(productPromo.getString("productPromoId"));
				}
			}
			List<GenericValue> productPromoActions = null;
			EntityCondition condition = EntityCondition.makeCondition(EntityCondition.makeCondition("productPromoActionEnumId", EntityOperator.EQUALS, "PROMO_REWARD_AMDISC"), EntityOperator.AND, EntityCondition.makeCondition("productPromoId", EntityOperator.IN, productPromoIds));
			if (UtilValidate.isNotEmpty(productPromoIds)) {
				productPromoActions = delegator.findList("ProductPromoAction", condition, null, null, null, false);
			}
			Set<String> productIdsSet = FastSet.newInstance();
			for (GenericValue productPromoAction : productPromoActions) {
				Set<String> productIdsPerAction = ProductPromoWorker.getPromoRuleActionProductIds(productPromoAction, delegator, UtilDateTime.nowTimestamp());
				productIdsSet.addAll(productIdsPerAction);
			}
			List<String> productIdsList = FastList.newInstance();
			if (UtilValidate.isNotEmpty(productIdsSet)) {
				productIdsList.addAll(productIdsList);
			}
			List<GenericValue> productTotal = delegator.findList("Product", EntityCondition.makeCondition("productId", EntityOperator.IN, productIdsList), null, UtilMisc.toList("productId"), null, false);

			// cut page
			List<GenericValue> productList = FastList.newInstance();
			int totalPage = 1;
			int startIndex = 0;
			int endIndex = 0;
			if (productTotal.size() % pageSize == 0) {
				totalPage = productTotal.size() / pageSize;
			} else {
				totalPage = productTotal.size() / pageSize + 1;
			}
			if (totalPage != 0) {
				if (totalPage < pageNum) {
					startIndex = pageSize * (totalPage - 1);
					endIndex = productTotal.size() - 1;
				} else {
					startIndex = pageSize * (pageNum - 1);
					endIndex = (totalPage > pageNum) ? pageSize * pageNum - 1 : productTotal.size() - 1;
				}
			}
			for (int i = 0; i < productTotal.size(); i++) {
				if (i >= startIndex && i <= endIndex) {
					productList.add(productTotal.get(i));
				}
			}

			Map resultMap = FastMap.newInstance();
			resultMap.put("totalNum", productTotal.size());
			resultMap.put("totalPage", totalPage);
			resultMap.put("pageNum", pageNum);
			resultMap.put("productList", productList);
			request.setAttribute("rewardAmdiscData", resultMap);
		} catch (Exception e) {
			Debug.logError(e, module);
			return "error";
		}
		return "success";
	}

	/**
	 * 改变购物车addreturn的值
	 */
	public static String changeCartAddReturn(HttpServletRequest request, HttpServletResponse response) {
		// Get the parameters as a MAP, remove the productId and quantity
		// params.
		Map<String, Object> paramMap = UtilHttp.getCombinedMap(request);
		// set the productId parameter into attribute to prevention of missing
		if (paramMap.containsKey("ADD_PRODUCT_ID")) {
			request.setAttribute("ADD_PRODUCT_ID", paramMap.remove("ADD_PRODUCT_ID"));
		} else if (paramMap.containsKey("add_product_id")) {
			Object object = paramMap.remove("add_product_id");
			try {
				request.setAttribute("add_product_id", object);
			} catch (ClassCastException e) {
				List<String> productList = UtilGenerics.checkList(object);
				request.setAttribute("add_product_id", productList.get(0));
			}
		}
		ShoppingCartEvents.getCartObject(request).setViewCartOnAdd(true);
		return "success";
	}

	public static String usedMemberCardAmount(HttpServletRequest request, HttpServletResponse response) {
		String usedCardAmount = request.getParameter("usedCardAmount");
		try {
			ShoppingCart cart = ShoppingCartEvents.getCartObject(request);
			// BigDecimal lastPayAmount =
			// cart.getApGrandTotal(usedCardAmount);
			// request.setAttribute("lastPayAmount", lastPayAmount);
			request.setAttribute("flag", "1");
		} catch (Exception e) {
			Debug.logError(e, module);
			request.setAttribute("flag", "0");
		}
		return "success";
	}

	/**
	 * @param productId
	 *            商品标识
	 * @param imgType
	 *            图片类型：EB_PROD_LIST列表图、EB_PROD_CART购物车图、EB_PROD_INFO产品信息图
	 * @param delegator
	 * @return 返回标志flag：1、找到对应请求的图片;2、或者该类型图片设置的默认图片；3、没有对应图片用商品详情图替代；4、
	 *         前三者都找不到时候使用系统默认图片
	 * @return 图片路径列表imgPathList
	 */

	public static Map<String, Object> getProdImgPaths(String productId, String imgType, Delegator delegator) {
		Map returnMap = FastMap.newInstance();
		List<String> imgPathList = FastList.newInstance();
		returnMap.put("flag", "3");
		returnMap.put("imgPathList", imgPathList);
		if (UtilValidate.isNotEmpty(productId) && UtilValidate.isNotEmpty(delegator)) {
			try {
				if (imgType.equals("EB_PRODIMG_INFO")) {
					EntityCondition condition_1 = EntityCondition.makeCondition("productId", productId);
					EntityCondition condition_2 = EntityCondition.makeCondition("productContentTypeId", "IMAGE");
					List<GenericValue> productContentObjs = delegator.findList("ProductContent", EntityCondition.makeCondition(UtilMisc.toList(condition_1, condition_2)), null, UtilMisc.toList("sequenceNum"), null, false);
					returnMap = getImgFromProductContentObjs(productContentObjs, "1", delegator, returnMap, imgType);
					if (UtilValidate.isEmpty(imgPathList)) {
						// productInfo img not found
						returnMap = getDefaultImg(delegator, returnMap, imgType);
					}
				} else {
					// List<GenericValue> productContentObjs =
					// delegator.findByAnd("ProductContent",
					// UtilMisc.toMap("productId", productId,
					// "productContentTypeId",
					// "IMAGE","extendFlag","Y"));
					// add by wangyg
					List<GenericValue> productContentObjs = delegator.findByAnd("ProductContent", UtilMisc.toMap("productId", productId, "productContentTypeId", "IMAGE"));
					if (productContentObjs.size() > 0) {
						List<GenericValue> contentAssocs = delegator.findByAnd("ContentAssoc", UtilMisc.toMap("contentId", productContentObjs.get(0).getString("contentId")));
						if (UtilValidate.isNotEmpty(contentAssocs)) {
							for (GenericValue contentAssoc : contentAssocs) {
								List<GenericValue> contentPurposeObjs = delegator.findByAnd("ContentPurpose", UtilMisc.toMap("contentId", contentAssoc.getString("contentIdTo")));
								for (GenericValue contentPurposeObj : contentPurposeObjs) {
									if (contentPurposeObj.getString("contentPurposeTypeId").equals(imgType)) {
										GenericValue contentObj = delegator.findOne("Content", false, UtilMisc.toMap("contentId", contentAssoc.getString("contentIdTo")));
										if (UtilValidate.isNotEmpty(contentObj) && UtilValidate.isNotEmpty(contentObj.getString("contentName"))) {
											returnMap.put("flag", "1");
											imgPathList.add(contentObj.getString("contentName"));
											break;
										}
									}
								}
							}
						}
					}
					if (UtilValidate.isEmpty(imgPathList)) {
						// productInfo img not found
						returnMap = getDefaultImg(delegator, returnMap, imgType);
					}
					// use productInfo Img
					if (UtilValidate.isEmpty(imgPathList) && productContentObjs.size() > 0) {
						GenericValue contentObj = productContentObjs.get(0).getRelatedOne("Content");
						imgPathList.add(contentObj.getString("contentName"));
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (UtilValidate.isEmpty(imgPathList)) {
			imgPathList.add("/itea/images/wine.jpg");
		}
		return returnMap;
	}

	/**
	 * @param productContentObjs
	 *            遍历的图片关联实体记录
	 * @param tatgetFlag
	 *            目标图片类型代码设置returnMap。flag值用：1、对应图片；2、商品详情图；3、系统默认图片
	 * @param delegator
	 * @param returnMap
	 * @param imgType
	 *            图片类型：EB_PROD_LIST列表图、EB_PROD_CART购物车图、EB_PROD_INFO产品信息图
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> getImgFromProductContentObjs(List<GenericValue> productContentObjs, String tatgetFlag, Delegator delegator, Map<String, Object> returnMap, String imgType) throws Exception {
		List<String> imgPathList = (FastList<String>) returnMap.get("imgPathList");
		for (GenericValue productContentObj : productContentObjs) {
			List<GenericValue> contentPurposeObjs = delegator.findByAnd("ContentPurpose", UtilMisc.toMap("contentId", productContentObj.getString("contentId")));
			for (GenericValue contentPurposeObj : contentPurposeObjs) {
				if (contentPurposeObj.getString("contentPurposeTypeId").equals(imgType)) {
					GenericValue contentObj = delegator.findOne("Content", false, UtilMisc.toMap("contentId", productContentObj.getString("contentId")));
					if (UtilValidate.isNotEmpty(contentObj) && UtilValidate.isNotEmpty(contentObj.getString("contentName"))) {
						returnMap.put("flag", tatgetFlag);
						imgPathList.add(contentObj.getString("contentName"));
						break;
					}
				}
			}
		}
		return returnMap;
	}

	/**
	 * @param delegator
	 * @param returnMap
	 * @param imgType
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> getDefaultImg(Delegator delegator, Map<String, Object> returnMap, String imgType) throws GenericEntityException {
		List<String> imgPathList = (FastList<String>) returnMap.get("imgPathList");
		List<GenericValue> productStoreImageSettings = delegator.findByAnd("ProductStoreImageSetting", UtilMisc.toMap("imageTypeId", imgType));
		if (productStoreImageSettings.size() > 0) {
			for (GenericValue productStoreImageSetting : productStoreImageSettings) {
				if (UtilValidate.isNotEmpty(productStoreImageSetting.getString("defaultImageUrl"))) {
					returnMap.put("flag", "3");
					imgPathList.add(productStoreImageSetting.getString("defaultImageUrl"));
				}
			}
		}
		return returnMap;
	}

	/**
	 * add by WuHK 2012-09-26
	 * 
	 * @param delegator
	 * @param productId
	 * @return
	 */
	public static String getProdFeaturesDesc(Delegator delegator, String productId) {
		StringBuilder sb = new StringBuilder("");
		try {
			if (UtilValidate.isNotEmpty(productId)) {
				GenericValue product = delegator.findByPrimaryKey("Product", UtilMisc.toMap("productId", productId));
				if (UtilValidate.isNotEmpty(product)) {
					List<GenericValue> features = product.getRelated("ProductFeatureAppl");
					if (UtilValidate.isNotEmpty(features)) {
						for (GenericValue productfeatureAppl : features) {
							GenericValue feature = productfeatureAppl.getRelatedOne("ProductFeature");
							if (UtilValidate.isNotEmpty(feature.getString("description"))) {
								sb.append(feature.getString("description") + ",");
							}
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String returnStr = sb.toString();
		if (!returnStr.trim().equals("")) {
			returnStr = returnStr.substring(0, returnStr.length() - 1);
		}
		return returnStr;
	}

	public static String ifSaleRewardProduct(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String productId = (String) request.getAttribute("productId");
		if (productId == null) {
			productId = (String) request.getSession().getAttribute("productId");
		} else {
			request.getSession().setAttribute("productId", productId);
		}
		try {
			GenericValue product = delegator.findOne("Product", false, UtilMisc.toMap("productId", productId));
			if (UtilValidate.isNotEmpty(product)) {
				if (UtilValidate.isNotEmpty(product.getString("isSaleReward")) && product.getString("isSaleReward").equals("Y")) {
					request.setAttribute("loginMSG", "您所查看的商品需要使用您的账户积分进行交易，请先登录!");
					return "saleReward";
				}
			}
		} catch (Exception e) {
			Debug.logError(e, module);
		}
		return "ordinary";
	}

	// 检查品牌参数是否存在
	public static String hasBrandParams(HttpServletRequest request, HttpServletResponse response) {
		String brandName = request.getParameter("brandName");
		if (brandName != null) {
			return "success";
		} else {
			return "error";
		}
	}

	public static String getMutilLanguageFeature(GenericValue gv, String language) {
		String descrption = "";
		if (gv != null) {
			if (language.equals("zh")) {
				descrption = gv.getString("feature.descriptionZh");
			} else if (language.equals("ru")) {
				descrption = gv.getString("feature.descriptionRu");
			} else {
				descrption = gv.getString("feature.description");
			}
		}
		return descrption;
	}

	public static List<GenericValue> getChoseFeatureValues(Delegator delegator, String productId, String productFeatureCategoryId) {
		List<Object> featureIdList = getChoseFeatureIds(delegator, productId, productFeatureCategoryId);
		try {
			return delegator.findList("ProductFeature", EntityCondition.makeCondition("productFeatureId", EntityOperator.IN, featureIdList), null, null, null, false);
		} catch (Exception e) {
			Debug.logError(e, module);
			return null;
		}
	}

	public static List<Object> getChoseFeatureIds(Delegator delegator, String productId, String productFeatureCategoryId) {
		List<Object> returnList = null;
		if (delegator == null || productId == null || productFeatureCategoryId == null) {
			return returnList;
		}
		try {
			List<GenericValue> productAssoc = delegator.findByAnd("ProductAssoc", UtilMisc.toMap("productId", productId, "productAssocTypeId", "PRODUCT_VARIANT"), UtilMisc.toList("sequenceNum ASC"), false);
			productAssoc = EntityUtil.filterByDate(productAssoc);
			if (productAssoc != null && productAssoc.size() > 0) {
				List<Object> productIdList = EntityUtil.getFieldListFromEntityList(productAssoc, "productIdTo", true);
				List<GenericValue> appls = delegator.findList("ProductFeatureAndAppl",
						EntityCondition.makeCondition(UtilMisc.toList(EntityCondition.makeCondition("productFeatureCategoryId", productFeatureCategoryId), EntityCondition.makeCondition("productId", EntityOperator.IN, productIdList))), null, null, null, false);
				if (appls != null) {
					appls = EntityUtil.filterByDate(appls);
					if (appls.size() > 0) {
						returnList = EntityUtil.getFieldListFromEntityList(appls, "productFeatureId", true);
					}
				}
			}
		} catch (Exception e) {
			Debug.logError(e, module);
			return returnList;
		}
		return returnList;
	}

}
