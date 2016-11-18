package org.ofbiz.management;

import java.math.BigDecimal;
import java.nio.ByteBuffer;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javolution.util.FastList;
import javolution.util.FastMap;
import javolution.util.FastSet;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.entity.util.EntityUtil;
//import org.ofbiz.management.utils.Finder;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

public class ProductServices {

	public static final String module = ProductServices.class.getName();
	public static final String resource = "ManagementUiLabels";

	public static Map<String, Object> getProductFeatureList(
			DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = dctx.getDelegator();

		String productCategoryId = (String) context.get("productCategoryId");
		List<Map> featureList = FastList.newInstance();
		try {
			List<GenericValue> productFeatureCategoryAppl = delegator
					.findByAnd("ProductFeatureCategoryAppl", UtilMisc.toMap(
							"productCategoryId", productCategoryId));

			// 没有规格
			if (null == productFeatureCategoryAppl
					|| productFeatureCategoryAppl.size() < 1) {
				result = ServiceUtil
						.returnSuccess("no product feature catagoryAppl");
				result.put("list", featureList);
				return result;
			}

			List<String> productFeatureCategoryIdList = FastList.newInstance();
			for (GenericValue productCategoryAppl : productFeatureCategoryAppl) {
				productFeatureCategoryIdList.add(productCategoryAppl
						.getString("productFeatureCategoryId"));
			}

			List<EntityExpr> exprs = FastList.newInstance();
			exprs.add(EntityCondition.makeCondition("productFeatureCategoryId",
					EntityOperator.IN, productFeatureCategoryIdList));

			List<GenericValue> productFeatureList = delegator.findList(
					"ProductFeature",
					EntityCondition.makeCondition(exprs, EntityOperator.AND),
					null, null, null, false);

			Map productFeatureVo = null;

			for (GenericValue productFeature : productFeatureList) {
				productFeatureVo = FastMap.newInstance();
				productFeatureVo.put("productFeature", productFeature);
				productFeatureVo.put("productFeatureType", productFeature
						.getRelatedOne("ProductFeatureType", true));
				productFeatureVo.put("productFeatureCategory", productFeature
						.getRelatedOne("ProductFeatureCategory", true));
				featureList.add(productFeatureVo);
			}

			result.put("list", featureList);

			return result;
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}
	}

	/**
	 * 创建虚拟产品
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> createVirtualProduct(
			DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		Timestamp nowTimestamp = UtilDateTime.nowTimestamp();

		// get the various IN attributes
		String variantProductIdsBag = (String) context
				.get("variantProductIdsBag");
		String productFeatureIdOne = (String) context
				.get("productFeatureIdOne");
		// String categoryAllId = (String) context.get("categoryAllId");
		String productCategoryId = (String) context.get("productCategoryId");

		Locale locale = (Locale) context.get("locale");

		Map<String, Object> successResult = ServiceUtil.returnSuccess();

		try {
			// Generate new virtual productId, prefix with "VP", put in
			// successResult
			String productId = (String) context.get("productId");

			if (UtilValidate.isEmpty(productId)) {
				productId = "VP" + delegator.getNextSeqId("Product");
				// Create new virtual product...
				GenericValue product = delegator.makeValue("Product");
				product.set("productId", productId);
				product.set("primaryProductCategoryId", productCategoryId);
				// product.set("categoryAllId", categoryAllId);
				// set: isVirtual=Y, isVariant=N, productTypeId=FINISHED_GOOD,
				// introductionDate=now
				product.set("isVirtual", "Y");
				product.set("isVariant", "N");
				product.set("productTypeId", "FINISHED_GOOD");
				product.set("introductionDate", nowTimestamp);
				// set all to Y: returnable, taxable, chargeShipping,
				// autoCreateKeywords, includeInPromotions
				product.set("returnable", "Y");
				product.set("taxable", "Y");
				product.set("chargeShipping", "Y");
				product.set("autoCreateKeywords", "Y");
				product.set("includeInPromotions", "Y");
				// in it goes!
				product.create();

				GenericValue productCategoryMember = delegator.makeValue(
						"ProductCategoryMember", UtilMisc.toMap(
								"productCategoryId", productCategoryId,
								"productId", productId));
				productCategoryMember.set("fromDate", nowTimestamp);
				delegator.create(productCategoryMember);
			}
			successResult.put("productId", productId);

			// separate variantProductIdsBag into a Set of variantProductIds
			// note: can be comma, tab, or white-space delimited
			Set<String> prelimVariantProductIds = FastSet.newInstance();
			List<String> splitIds = Arrays.asList(variantProductIdsBag
					.split("[,\\p{Space}]"));
			Debug.logInfo("Variants: bag=" + variantProductIdsBag, module);
			Debug.logInfo("Variants: split=" + splitIds, module);
			prelimVariantProductIds.addAll(splitIds);
			// note: should support both direct productIds and
			// GoodIdentification entries (what to do if more than one GoodID?
			// Add all?

			Map<String, GenericValue> variantProductsById = FastMap
					.newInstance();
			for (String variantProductId : prelimVariantProductIds) {
				if (UtilValidate.isEmpty(variantProductId)) {
					// not sure why this happens, but seems to from time to time
					// with the split method
					continue;
				}
				// is a Product.productId?
				GenericValue variantProduct = delegator.findOne("Product",
						UtilMisc.toMap("productId", variantProductId), false);
				if (variantProduct != null) {
					variantProductsById.put(variantProductId, variantProduct);
				}
			}

			// Attach productFeatureIdOne, Two, Three to the new virtual and all
			// variant products as a standard feature
			Set<String> featureProductIds = FastSet.newInstance();
			featureProductIds.add(productId);
			featureProductIds.addAll(variantProductsById.keySet());
			Set<String> productFeatureIds = new HashSet<String>();

			if (!UtilValidate.isEmpty(productFeatureIdOne))
				productFeatureIds.add(productFeatureIdOne);

			for (String featureProductId : featureProductIds) {
				for (String productFeatureId : productFeatureIds) {
					if (UtilValidate.isNotEmpty(productFeatureId)) {
						GenericValue productFeatureAppl = delegator.makeValue(
								"ProductFeatureAppl", UtilMisc.toMap(
										"productId", featureProductId,
										"productFeatureId", productFeatureId,
										"productFeatureApplTypeId",
										"STANDARD_FEATURE", "fromDate",
										nowTimestamp));
						productFeatureAppl.create();
					}
				}
			}

			for (GenericValue variantProduct : variantProductsById.values()) {
				// for each variant product set: isVirtual=N, isVariant=Y,
				// introductionDate=now
				variantProduct.set("isVirtual", "N");
				variantProduct.set("isVariant", "Y");
				variantProduct.set("introductionDate", nowTimestamp);
				variantProduct.store();

				// for each variant product create associate with the new
				// virtual as a PRODUCT_VARIANT
				GenericValue productAssoc = delegator.makeValue("ProductAssoc",
						UtilMisc.toMap("productId", productId, "productIdTo",
								variantProduct.get("productId"),
								"productAssocTypeId", "PRODUCT_VARIANT",
								"fromDate", nowTimestamp));
				productAssoc.create();
			}
		} catch (GenericEntityException e) {
			String errMsg = "Error creating new virtual product from variant products: "
					+ e.toString();
			Debug.logError(e, errMsg, module);
			return ServiceUtil.returnError(errMsg);
		}
		return successResult;
	}

	/**
	 * 创建虚拟产品
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> updateVirtualProduct(
			DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		Timestamp nowTimestamp = UtilDateTime.nowTimestamp();

		// get the various IN attributes
		String variantProductIdsBag = (String) context
				.get("variantProductIdsBag");
		String productFeatureIdOne = (String) context
				.get("productFeatureIdOne");
		// String categoryAllId = (String) context.get("categoryAllId");
		String productCategoryId = (String) context.get("productCategoryId");
		String productId = (String) context.get("productId");

		Map<String, Object> successResult = ServiceUtil.returnSuccess();

		try {
			GenericValue product = delegator.findOne("Product", false,
					UtilMisc.toMap("productId", productId));
			String oldProductCategoryId = product
					.getString("primaryProductCategoryId");
			product.set("primaryProductCategoryId", productCategoryId);
			// product.set("categoryAllId", categoryAllId);
			product.store();

			delegator.removeByAnd("ProductCategoryMember", UtilMisc.toMap(
					"productId", productId, "productCategoryId",
					oldProductCategoryId));

			GenericValue productCategoryMember = delegator.makeValue(
					"ProductCategoryMember", UtilMisc.toMap(
							"productCategoryId", productCategoryId,
							"productId", productId));
			productCategoryMember.set("fromDate", nowTimestamp);
			delegator.create(productCategoryMember);

			successResult.put("productId", productId);

			Set<String> prelimVariantProductIds = FastSet.newInstance();
			List<String> splitIds = Arrays.asList(variantProductIdsBag
					.split("[,\\p{Space}]"));
			Debug.logInfo("Variants: bag=" + variantProductIdsBag, module);
			Debug.logInfo("Variants: split=" + splitIds, module);
			prelimVariantProductIds.addAll(splitIds);
			// note: should support both direct productIds and
			// GoodIdentification entries (what to do if more than one GoodID?
			// Add all?
			delegator.removeByAnd("ProductAssoc",
					UtilMisc.toMap("productId", productId));
			Map<String, GenericValue> variantProductsById = FastMap
					.newInstance();
			for (String variantProductId : prelimVariantProductIds) {
				if (UtilValidate.isEmpty(variantProductId)) {
					// not sure why this happens, but seems to from time to time
					// with the split method
					continue;
				}
				// is a Product.productId?
				GenericValue variantProduct = delegator.findOne("Product",
						UtilMisc.toMap("productId", variantProductId), false);
				if (variantProduct != null) {
					variantProductsById.put(variantProductId, variantProduct);
				}
			}

			// Attach productFeatureIdOne, Two, Three to the new virtual and all
			// variant products as a standard feature
			Set<String> featureProductIds = FastSet.newInstance();
			featureProductIds.add(productId);
			featureProductIds.addAll(variantProductsById.keySet());
			Set<String> productFeatureIds = new HashSet<String>();

			if (!UtilValidate.isEmpty(productFeatureIdOne))
				productFeatureIds.add(productFeatureIdOne);
			if (UtilValidate.isNotEmpty(featureProductIds)
					& UtilValidate.isNotEmpty(productFeatureIds)) {
				delegator.removeByAnd("ProductFeatureAppl",
						UtilMisc.toMap("productId", productId));
			}

			for (String featureProductId : featureProductIds) {
				for (String productFeatureId : productFeatureIds) {
					if (UtilValidate.isNotEmpty(productFeatureId)) {
						GenericValue productFeatureAppl = delegator.makeValue(
								"ProductFeatureAppl", UtilMisc.toMap(
										"productId", featureProductId,
										"productFeatureId", productFeatureId,
										"productFeatureApplTypeId",
										"STANDARD_FEATURE", "fromDate",
										nowTimestamp));
						productFeatureAppl.create();
					}
				}
			}

			for (GenericValue variantProduct : variantProductsById.values()) {
				// for each variant product set: isVirtual=N, isVariant=Y,
				// introductionDate=now
				variantProduct.set("isVirtual", "N");
				variantProduct.set("isVariant", "Y");
				variantProduct.set("introductionDate", nowTimestamp);
				variantProduct.store();

				// for each variant product create associate with the new
				// virtual as a PRODUCT_VARIANT
				GenericValue productAssoc = delegator.makeValue("ProductAssoc",
						UtilMisc.toMap("productId", productId, "productIdTo",
								variantProduct.get("productId"),
								"productAssocTypeId", "PRODUCT_VARIANT",
								"fromDate", nowTimestamp));
				productAssoc.create();
			}
		} catch (GenericEntityException e) {
			String errMsg = "Error creating new virtual product from variant products: "
					+ e.toString();
			Debug.logError(e, errMsg, module);
			return ServiceUtil.returnError(errMsg);
		}
		return successResult;
	}

	/**
	 * 传入产品分类Id 新建单一产品 根据所在产品分类，自动生成feature 关键词？一次输入
	 */
	public static Map<String, Object> createEcProduct(DispatchContext dctx,
			Map<String, ? extends Object> context) {
		Map result = ServiceUtil.returnSuccess();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		GenericValue userLogin = (GenericValue) context.get("userLogin");

		Timestamp now = UtilDateTime.nowTimestamp();

		String productCategoryId = (String) context.get("productCategoryId");
		BigDecimal listPrice = (BigDecimal) context.get("listPrice");
		BigDecimal defaultPrice = (BigDecimal) context.get("defaultPrice");
		String keywords = (String) context.get("keywords");
		List tagIds = (List) context.get("tagIds");
		String productFeatureIdList = (String) context
				.get("productFeatureIdList");

		try {
			String productId = delegator.getNextSeqId("Product");
			GenericValue product = delegator.makeValue("Product",
					UtilMisc.toMap("productId", productId));
			product.setNonPKFields(context);
			product.set("primaryProductCategoryId", productCategoryId);
			product.set("isNewStyle", "N");
			product.set("isBestSelling", "N");
			product.set("isMostPopular", "N");
			product.set("isPromotion", "N");
			product.set("createdDate", UtilDateTime.nowTimestamp());
			product.set("createdByUserLogin",
					userLogin.getString("userLoginId"));
			if (UtilValidate.isNotEmpty(tagIds)) {
				for (int i = 0; i < tagIds.size(); i++) {
					String tag = (String) tagIds.get(i);
					if ("isNewStyle".equals(tag)) {
						product.set("isNewStyle", "Y");
					}// 新款
					if ("isBestSelling".equals(tag)) {
						product.set("isBestSelling", "Y");
					}// 热销
					if ("isMostPopular".equals(tag)) {
						product.set("isMostPopular", "Y");
					}// 新款
					if ("isPromotion".equals(tag)) {
						product.set("isPromotion", "Y");
					}// 新款
				}
			}
			delegator.create(product);
			if (UtilValidate.isNotEmpty(listPrice)) {
				GenericValue listPriceGv = delegator.makeValue("ProductPrice",
						UtilMisc.toMap("productId", productId,
								"productPriceTypeId", "LIST_PRICE"));
				listPriceGv.set("productPricePurposeId", "PURCHASE");
				listPriceGv.set("currencyUomId", "CNY");
				listPriceGv.set("productStoreGroupId", "_NA_");
				listPriceGv.set("fromDate", now);
				listPriceGv.set("price", listPrice);
				delegator.create(listPriceGv);
			}

			if (UtilValidate.isNotEmpty(defaultPrice)) {
				GenericValue defaultPriceGv = delegator.makeValue(
						"ProductPrice", UtilMisc.toMap("productId", productId,
								"productPriceTypeId", "DEFAULT_PRICE"));
				defaultPriceGv.set("productPricePurposeId", "PURCHASE");
				defaultPriceGv.set("currencyUomId", "CNY");
				defaultPriceGv.set("productStoreGroupId", "_NA_");
				defaultPriceGv.set("fromDate", now);
				defaultPriceGv.set("price", defaultPrice);
				delegator.create(defaultPriceGv);
			}

			GenericValue productCategoryMember = delegator.makeValue(
					"ProductCategoryMember", UtilMisc.toMap(
							"productCategoryId", productCategoryId,
							"productId", productId));
			productCategoryMember.set("fromDate", now);
			delegator.create(productCategoryMember);

			if (UtilValidate.isNotEmpty(productFeatureIdList)) {
				String[] productFeatureIdListArray = productFeatureIdList
						.split(";");
				for (String productFeatureId : productFeatureIdListArray) {
					GenericValue productFeatureAppl = delegator.makeValue(
							"ProductFeatureAppl", UtilMisc.toMap(
									"productFeatureId", productFeatureId,
									"productId", productId));
					productFeatureAppl.set("fromDate", now);
					productFeatureAppl.set("productFeatureApplTypeId",
							"STANDARD_FEATURE");
					delegator.create(productFeatureAppl);
				}
			}

			// List<GenericValue> productFeatureCategoryApplList =
			// delegator.findByAnd("ProductFeatureCategoryAppl",UtilMisc.toMap("productCategoryId",
			// productCategoryId));
			//
			// for(GenericValue productFeatureCategoryAppl:
			// productFeatureCategoryApplList){
			// String productFeatureCategoryId
			// =productFeatureCategoryAppl.getString("productFeatureCategoryId");
			//
			// List<GenericValue> productFeatureList =
			// delegator.findByAnd("ProductFeature",UtilMisc.toMap("productFeatureCategoryId",
			// productFeatureCategoryId));
			//
			// for(GenericValue productFeature: productFeatureList){
			// String productFeatureId=
			// productFeature.getString("productFeatureId");
			// GenericValue productFeatureAppl
			// =delegator.makeValue("ProductFeatureAppl",
			// UtilMisc.toMap("productFeatureId",
			// productFeatureId,"productId",productId));
			// productFeatureAppl.set("fromDate", now);
			// productFeatureAppl.set("productFeatureApplTypeId",
			// "STANDARD_FEATURE");
			// delegator.create(productFeatureAppl);
			//
			// }
			// }
			//

			if (UtilValidate.isNotEmpty(keywords)) {
				dispatcher.runSync("createEcProductKeywords", UtilMisc.toMap(
						"userLogin", userLogin, "keywords", keywords,
						"productId", productId));
			}
			result.put("productId", productId);
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		} catch (GenericServiceException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}

		return result;
	}

	/**
	 * 传入产品分类Id 修改单一产品
	 */
	public static Map<String, Object> updateEcProduct(DispatchContext dctx,
			Map<String, ? extends Object> context) {
		Map result = ServiceUtil.returnSuccess();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		GenericValue userLogin = (GenericValue) context.get("userLogin");

		Timestamp now = UtilDateTime.nowTimestamp();

		String productId = (String) context.get("productId");
		String productCategoryId = (String) context.get("productCategoryId");
		BigDecimal listPrice = (BigDecimal) context.get("listPrice");
		BigDecimal defaultPrice = (BigDecimal) context.get("defaultPrice");
		String keywords = (String) context.get("keywords");
		List tagIds = (List) context.get("tagIds");
		String productFeatureIdList = (String) context
				.get("productFeatureIdList");

		try {

			GenericValue product = delegator.makeValue("Product",
					UtilMisc.toMap("productId", productId));
			product.setNonPKFields(context);
			product.set("primaryProductCategoryId", productCategoryId);
			product.set("isNewStyle", "N");
			product.set("isBestSelling", "N");
			product.set("isMostPopular", "N");
			product.set("isPromotion", "N");
			if (UtilValidate.isNotEmpty(tagIds)) {
				for (int i = 0; i < tagIds.size(); i++) {
					String tag = (String) tagIds.get(i);
					if ("isNewStyle".equals(tag)) {
						product.set("isNewStyle", "Y");
					}// 新款
					if ("isBestSelling".equals(tag)) {
						product.set("isBestSelling", "Y");
					}// 热销
					if ("isMostPopular".equals(tag)) {
						product.set("isMostPopular", "Y");
					}// 新款
					if ("isPromotion".equals(tag)) {
						product.set("isPromotion", "Y");
					}// 新款
				}
			}
			delegator.store(product);
			if (UtilValidate.isNotEmpty(listPrice)) {
				List<GenericValue> listPriceGvInfo = delegator.findByAnd(
						"ProductPrice", UtilMisc.toMap("productId", productId,
								"productPriceTypeId", "LIST_PRICE"));

				if (UtilValidate.isNotEmpty(listPriceGvInfo)) {
					GenericValue listPriceGv = EntityUtil
							.getFirst(listPriceGvInfo);
					listPriceGv.set("price", listPrice);
					delegator.store(listPriceGv);
				} else {
					GenericValue listPriceGv = delegator.makeValue(
							"ProductPrice", UtilMisc.toMap("productId",
									productId, "productPriceTypeId",
									"LIST_PRICE"));
					listPriceGv.set("productPricePurposeId", "PURCHASE");
					listPriceGv.set("currencyUomId", "CNY");
					listPriceGv.set("productStoreGroupId", "_NA_");
					listPriceGv.set("fromDate", now);
					listPriceGv.set("price", listPrice);
					delegator.create(listPriceGv);
				}

			}

			if (UtilValidate.isNotEmpty(defaultPrice)) {
				List<GenericValue> defaultPriceGvInfo = delegator.findByAnd(
						"ProductPrice", UtilMisc.toMap("productId", productId,
								"productPriceTypeId", "DEFAULT_PRICE"));

				if (UtilValidate.isNotEmpty(defaultPriceGvInfo)) {
					GenericValue defaultPriceGv = EntityUtil
							.getFirst(defaultPriceGvInfo);
					defaultPriceGv.set("price", defaultPrice);
					delegator.store(defaultPriceGv);
				} else {
					GenericValue defaultPriceGv = delegator.makeValue(
							"ProductPrice", UtilMisc.toMap("productId",
									productId, "productPriceTypeId",
									"DEFAULT_PRICE"));
					defaultPriceGv.set("productPricePurposeId", "PURCHASE");
					defaultPriceGv.set("currencyUomId", "CNY");
					defaultPriceGv.set("productStoreGroupId", "_NA_");
					defaultPriceGv.set("fromDate", now);
					defaultPriceGv.set("price", defaultPrice);
					delegator.create(defaultPriceGv);
				}
			}

			delegator.removeByAnd("ProductCategoryMember", UtilMisc.toMap(
					"productCategoryId", productCategoryId, "productId",
					productId));
			GenericValue productCategoryMember = delegator.makeValue(
					"ProductCategoryMember", UtilMisc.toMap(
							"productCategoryId", productCategoryId,
							"productId", productId));
			productCategoryMember.set("fromDate", now);
			delegator.create(productCategoryMember);

			if (UtilValidate.isNotEmpty(productFeatureIdList)) {
				delegator.removeByAnd("ProductFeatureAppl",
						UtilMisc.toMap("productId", productId));

				String[] productFeatureIdListArray = productFeatureIdList
						.split(";");
				for (String productFeatureId : productFeatureIdListArray) {
					GenericValue productFeatureAppl = delegator.makeValue(
							"ProductFeatureAppl", UtilMisc.toMap(
									"productFeatureId", productFeatureId,
									"productId", productId));
					productFeatureAppl.set("fromDate", now);
					productFeatureAppl.set("productFeatureApplTypeId",
							"STANDARD_FEATURE");
					delegator.create(productFeatureAppl);
				}
			}

			// List<GenericValue> productFeatureCategoryApplList =
			// delegator.findByAnd("ProductFeatureCategoryAppl",UtilMisc.toMap("productCategoryId",
			// productCategoryId));
			//
			// for(GenericValue productFeatureCategoryAppl:
			// productFeatureCategoryApplList){
			// String productFeatureCategoryId
			// =productFeatureCategoryAppl.getString("productFeatureCategoryId");
			//
			// List<GenericValue> productFeatureList =
			// delegator.findByAnd("ProductFeature",UtilMisc.toMap("productFeatureCategoryId",
			// productFeatureCategoryId));
			//
			// for(GenericValue productFeature: productFeatureList){
			// String productFeatureId=
			// productFeature.getString("productFeatureId");
			// GenericValue productFeatureAppl
			// =delegator.makeValue("ProductFeatureAppl",
			// UtilMisc.toMap("productFeatureId",
			// productFeatureId,"productId",productId));
			// productFeatureAppl.set("fromDate", now);
			// productFeatureAppl.set("productFeatureApplTypeId",
			// "STANDARD_FEATURE");
			// delegator.create(productFeatureAppl);
			//
			// }
			// }
			//

			if (UtilValidate.isNotEmpty(keywords)) {
				dispatcher.runSync("createEcProductKeywords", UtilMisc.toMap(
						"userLogin", userLogin, "keywords", keywords,
						"productId", productId));
			}
			result.put("productId", productId);
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		} catch (GenericServiceException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}

		return result;
	}

	public static Map<String, Object> createEcProductKeywords(
			DispatchContext dctx, Map<String, ? extends Object> context) {
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		GenericValue userLogin = (GenericValue) context.get("userLogin");

		String productId = (String) context.get("productId");

		String keywords = (String) context.get("keywords");

		try {
			delegator.removeByAnd("ProductKeyword",
					UtilMisc.toMap("productId", productId));
			String[] keywordsArray = keywords.split(" ");

			for (int i = 0; i < keywordsArray.length; i++) {
				String keyword = keywordsArray[i];
				if (UtilValidate.isNotEmpty(keyword)) {
					GenericValue productKeyword = delegator.makeValue(
							"ProductKeyword", UtilMisc.toMap("productId",
									productId, "keywordTypeId", "KWT_KEYWORD"));
					productKeyword.set("keyword", keyword);
					delegator.createOrStore(productKeyword);
				}

			}

		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}

		return ServiceUtil.returnSuccess();
	}

	/**
	 * 传入多个单一产品Id 新建虚拟产品 根据所在产品分类，自动生成feature
	 */
	public static Map<String, Object> createEcVirtualProduct(
			DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		Timestamp now = UtilDateTime.nowTimestamp();
		String productIdList = (String) context.get("productIdList");
		String productCategoryId = (String) context.get("productCategoryId");
		BigDecimal listPrice = (BigDecimal) context.get("listPrice");
		BigDecimal defaultPrice = (BigDecimal) context.get("defaultPrice");

		try {

			String productId = delegator.getNextSeqId("Product");
			GenericValue product = delegator.makeValue("Product",
					UtilMisc.toMap("productId", productId));
			product.setNonPKFields(context);
			delegator.create(product);

			GenericValue listPriceGv = delegator.makeValue("ProductPrice",
					UtilMisc.toMap("productId", productId,
							"productPriceTypeId", "LIST_PRICE"), false);
			listPriceGv.set("productPricePurposeId", "PURCHASE");
			listPriceGv.set("currencyUomId", "CNY");
			listPriceGv.set("productStoreGroupId", "_NA_");
			listPriceGv.set("fromDate", now);
			listPriceGv.set("price", listPrice);
			delegator.create(listPriceGv);

			GenericValue defaultPriceGv = delegator.makeValue("ProductPrice",
					UtilMisc.toMap("productId", productId,
							"productPriceTypeId", "DEFAULT_PRICE"), false);
			defaultPriceGv.set("productPricePurposeId", "PURCHASE");
			defaultPriceGv.set("currencyUomId", "CNY");
			defaultPriceGv.set("productStoreGroupId", "_NA_");
			defaultPriceGv.set("fromDate", now);
			listPriceGv.set("price", defaultPrice);
			delegator.create(defaultPriceGv);

			GenericValue productCategoryMember = delegator.makeValue(
					"ProductCategoryMember", UtilMisc.toMap(
							"productCategoryId", productCategoryId,
							"productId", productId));
			productCategoryMember.set("fromDate", now);
			delegator.create(productCategoryMember);

			String[] productIdArray = productIdList.split(";");
			for (String productIdTo : productIdArray) {
				GenericValue productAssoc = delegator.makeValue("ProductAssoc",
						UtilMisc.toMap("productIdTo", productIdTo, "productId",
								productId));
				productAssoc.set("productAssocTypeId", "PRODUCT_VARIANT");
				productAssoc.set("fromDate", now);
				delegator.create(productAssoc);
			}

			//
			// List<GenericValue> productFeatureCategoryApplList =
			// delegator.findByAnd("ProductFeatureCategoryAppl",UtilMisc.toMap("productCategoryId",
			// productCategoryId));
			//
			// for(GenericValue productFeatureCategoryAppl:
			// productFeatureCategoryApplList){
			// String productFeatureCategoryId
			// =productFeatureCategoryAppl.getString("productFeatureCategoryId");
			//
			// List<GenericValue> productFeatureList =
			// delegator.findByAnd("ProductFeature",UtilMisc.toMap("productFeatureCategoryId",
			// productFeatureCategoryId));
			//
			// for(GenericValue productFeature: productFeatureList){
			// String productFeatureId=
			// productFeature.getString("productFeatureId");
			// GenericValue productFeatureAppl
			// =delegator.makeValue("ProductFeatureAppl",
			// UtilMisc.toMap("productFeatureId",
			// productFeatureId,"productId",productId));
			// productFeatureAppl.set("fromDate", now);
			// productFeatureAppl.set("productFeatureApplTypeId",
			// "STANDARD_FEATURE");
			// delegator.create(productFeatureAppl);
			//
			// }
			// }
			//
			//

		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}

		return ServiceUtil.returnSuccess();
	}

	/**
	 * 强制下架
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> forcedOffTheShelfProduct(
			DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		String productId = (String) context.get("productId");

		try {
			GenericValue product = delegator.findOne("Product",
					UtilMisc.toMap("productId", productId), false);
			product.set("salesDiscontinuationDate", UtilDateTime.nowTimestamp());
			product.set("isForcedOffTheShelf", "Y");
			delegator.store(product);
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}

		return ServiceUtil.returnSuccess();
	}

	/**
	 * 下架
	 */
	// public static Map<String, Object> offTheShelfStoreProduct(DispatchContext
	// dctx, Map<String, ? extends Object> context) {
	// LocalDispatcher dispatcher = dctx.getDispatcher();
	// Delegator delegator = dctx.getDelegator();
	// GenericValue userLogin = (GenericValue) context.get("userLogin");
	// String productId = (String) context.get("productId");
	//
	// try {
	// GenericValue product = delegator.findOne("Product",
	// UtilMisc.toMap("productId", productId), false);
	// product.set("salesDiscontinuationDate", UtilDateTime.nowTimestamp());
	// product.set("introductionDate", null);
	// delegator.store(product);
	// } catch (GenericEntityException e) {
	// Debug.logError(e, module);
	// return ServiceUtil.returnError(e.getMessage());
	// }
	//
	// return ServiceUtil.returnSuccess();
	// }

	/**
	 * 上架
	 */
	// public static Map<String, Object> onTheShelfStoreProduct(DispatchContext
	// dctx, Map<String, ? extends Object> context) {
	// Delegator delegator = dctx.getDelegator();
	// String productId = (String) context.get("productId");
	//
	// try {
	// GenericValue product = delegator.findOne("Product",
	// UtilMisc.toMap("productId", productId), false);
	// product.set("introductionDate", UtilDateTime.nowTimestamp());
	// product.set("salesDiscontinuationDate", null);
	//
	// delegator.store(product);
	// } catch (GenericEntityException e) {
	// Debug.logError(e, module);
	// return ServiceUtil.returnError(e.getMessage());
	// }
	//
	// return ServiceUtil.returnSuccess();
	// }

	/**
	 * 上传产品图片
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> createProductContentImage(
			DispatchContext dctx, Map<String, Object> context) {
		Map result = ServiceUtil.returnSuccess();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();

		String productId = (String) context.get("productId");

		try {
			String contentId = delegator.getNextSeqId("Content");
			GenericValue content = delegator.makeValue("Content",
					UtilMisc.toMap("contentId", contentId));
			content.set("statusId", "CTNT_IN_PROGRESS"); // CTNT_PUBLISHED
															// CTNT_DEACTIVATED
			content.set("contentTypeId", "IMAGE_FRAME");

			ByteBuffer imageDataBytes = (ByteBuffer) context
					.get("uploadedFile");
			// String _uploadedFile_contentType = (String)
			// context.get("_uploadedFile_contentType");
			String _uploadedFile_fileName = (String) context
					.get("_uploadedFile_fileName");
			if (UtilValidate.isNotEmpty(imageDataBytes)
					&& UtilValidate.isNotEmpty(_uploadedFile_fileName)) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("projectId", contentId);
				map.put("uploadedFile", imageDataBytes);
				map.put("_uploadedFile_fileName", _uploadedFile_fileName);
				Map<String, Object> resultInfo = dispatcher.runSync(
						"uploadedFile", map);
				String imagePath = (String) resultInfo.get("imagePath");
				content.set("description", imagePath);
			}
			delegator.create(content);

			// <ProductContent productId="SV-1000" contentId="SV-1000-ALT"
			// productContentTypeId="ALTERNATIVE_URL"
			// fromDate="2001-05-13 12:00:00.0"/>

			GenericValue productContent = delegator.makeValue("ProductContent",
					UtilMisc.toMap("contentId", contentId));
			productContent.set("productId", productId);
			productContent.set("productContentTypeId", "ALTERNATIVE_URL");
			productContent.set("fromDate", UtilDateTime.nowTimestamp());
			delegator.create(productContent);

			result.put("productId", productId);
			return result;
		} catch (GenericEntityException e) {
			Debug.logError(e, "createProductContent: " + e.getMessage(), module);
			return ServiceUtil.returnError(e.getMessage());

		} catch (GenericServiceException e) {
			Debug.logError(e, "createProductContent: " + e.getMessage(), module);
			return ServiceUtil.returnError(e.getMessage());
		}
	}

	public static Map<String, Object> updateProductContentImage(
			DispatchContext dctx, Map<String, Object> context) {
		Map result = ServiceUtil.returnSuccess();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();

		String contentId = (String) context.get("contentId");
		String productId = (String) context.get("productId");

		try {

			GenericValue content = delegator.findOne("Content",
					UtilMisc.toMap("contentId", contentId), false);

			ByteBuffer imageDataBytes = (ByteBuffer) context
					.get("uploadedFile");
			// String _uploadedFile_contentType = (String)
			// context.get("_uploadedFile_contentType");
			String _uploadedFile_fileName = (String) context
					.get("_uploadedFile_fileName");
			if (UtilValidate.isNotEmpty(imageDataBytes)) {

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("projectId", contentId);
				map.put("uploadedFile", imageDataBytes);
				map.put("_uploadedFile_fileName", _uploadedFile_fileName);
				Map<String, Object> resultInfo = dispatcher.runSync(
						"uploadedFile", map);
				String imagePath = (String) resultInfo.get("imagePath");
				content.set("description", imagePath);
			}
			delegator.store(content);
			result.put("productId", productId);
			return result;
		} catch (GenericEntityException e) {
			Debug.logError(e, "updateProductContentImage: " + e.getMessage(),
					module);

			return ServiceUtil.returnError(e.getMessage());

		} catch (GenericServiceException e) {
			Debug.logError(e, "updateProductContentImage: " + e.getMessage(),
					module);

			return ServiceUtil.returnError(e.getMessage());
		}
	}

	public static Map<String, Object> deleteProductContentImage(
			DispatchContext dctx, Map<String, Object> context) {
		Map result = ServiceUtil.returnSuccess();
		Delegator delegator = dctx.getDelegator();
		String contentId = (String) context.get("contentId");
		String productId = (String) context.get("productId");
		try {

			delegator.removeByAnd("ProductContent", UtilMisc.toMap("contentId",
					contentId, "productId", productId));

			// GenericValue content =delegator.findOne("Content",
			// UtilMisc.toMap("contentId",contentId),false);
			// delegator.removeValue(content);

			result.put("productId", productId);
			return result;
		} catch (GenericEntityException e) {
			Debug.logError(e, "deleteProductContentImage: " + e.getMessage(),
					module);

			return ServiceUtil.returnError(e.getMessage());

		}
	}

	/**
	 * 接受库存 如果没有库位就新建,有库存就直接操作该库位的数量 每个产品只有一个库位就可以了
	 */
	public static Map<String, Object> receiveEcInventoryProduct(
			DispatchContext dctx, Map<String, ? extends Object> context) {
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		String productId = (String) context.get("productId");
		// String productStoreId = (String) context.get("productStoreId");
		BigDecimal quantityAccepted = (BigDecimal) context
				.get("quantityAccepted");// 已接受的数量
		BigDecimal quantityRejected = (BigDecimal) context
				.get("quantityRejected");
		if (UtilValidate.isEmpty(quantityRejected)) {
			quantityRejected = BigDecimal.ZERO;
		}
		try {
			// 最好根据店铺Id带出一个仓库Id
			// String facilityId = (String) context.get("facilityId");
			// String ownerPartyId="";

			List<GenericValue> inventoryItemList = delegator.findByAnd(
					"InventoryItem", UtilMisc.toMap("productId", productId));

			if (UtilValidate.isNotEmpty(inventoryItemList)) {
				GenericValue inventoryItem = EntityUtil
						.getFirst(inventoryItemList);

				String inventoryItemId = inventoryItem
						.getString("inventoryItemId");

				Map inventory_context = FastMap.newInstance();
				inventory_context.put("userLogin", userLogin);
				inventory_context.put("inventoryItemId", inventoryItemId);

				// inventory_context.put("varianceReasonId",
				// "VAR_RECIVE_WAREHOUSE");
				inventory_context
						.put("availableToPromiseVar", quantityAccepted);
				inventory_context.put("quantityOnHandVar", quantityAccepted);

				dispatcher.runSync("createPhysicalInventoryAndVariance",
						inventory_context);
			} else {
				GenericValue product = delegator.findOne("Product",
						UtilMisc.toMap("productId", productId), false);

				String ownerProductStoreId = product
						.getString("ownerProductStoreId");
				if (UtilValidate.isEmpty(ownerProductStoreId)) {
					ownerProductStoreId = "9000";
				}
				GenericValue productStore = delegator.findOne("ProductStore",
						UtilMisc.toMap("productStoreId", ownerProductStoreId),
						false);
				String facilityId = productStore
						.getString("inventoryFacilityId");

				String itemDescription = product.getString("productName");
				Timestamp datetimeReceived = UtilDateTime.nowTimestamp();

				Map service_context = FastMap.newInstance();
				service_context.put("userLogin", userLogin);
				service_context.put("facilityId", facilityId);
				service_context.put("productId", productId);
				service_context.put("itemDescription", itemDescription);

				// 库存明细类型 NON_SERIAL_INV_ITEM 非序列化 SERIALIZED_INV_ITEM 序列化
				service_context.put("inventoryItemTypeId",
						"NON_SERIAL_INV_ITEM");

				// service_context.put("ownerPartyId", ownerPartyId);//拥有者
				service_context.put("datetimeReceived", datetimeReceived);

				service_context.put("quantityAccepted", quantityAccepted);
				service_context.put("quantityRejected", quantityRejected);
				// unitCost 每单价
				dispatcher.runSync("receiveInventoryProduct", service_context);
			}

		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		} catch (GenericServiceException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}

		return ServiceUtil.returnSuccess();
	}

	/**
	 * 获取全部分类，放置到一个集合中
	 */
	@SuppressWarnings("deprecation")
	public static Map<String, Object> getAllProductCategory(DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		String prodCatalogId = (String) context.get("prodCatalogId");
		List<Map<String, Object>> mapList = FastList.newInstance();
		Map<String, Object> result = ServiceUtil.returnSuccess();
		
		List<String> orderBy = FastList.newInstance();
		orderBy.add("sequenceId");
		
		try {
			List<GenericValue> catalogCategoryList = delegator.findByAnd(
					"ProdCatalogCategoryAndSeq",
					UtilMisc.toMap("prodCatalogId", prodCatalogId),orderBy);

			for (GenericValue catalogCategory : catalogCategoryList) {
				GenericValue category = delegator
						.findByPrimaryKey("ProductCategory", UtilMisc.toMap(
								"productCategoryId",
								catalogCategory.getString("productCategoryId")));
				Map<String, Object> map = FastMap.newInstance();
				map.put("productCategoryId",
						category.getString("productCategoryId"));
				map.put("categoryName", category.getString("categoryName"));
				map.put("primaryParentCategoryId", "parent");
				mapList.add(map);
				int i = 1;
				// 计算他的下级。放入集合中，然后递归查找下级的下级
				mapList.addAll(getLoverCategory(
						category.getString("productCategoryId"), delegator, i));

			}
			result.put("categoryList", mapList);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
		}
		return result;
	}

	@SuppressWarnings("deprecation")
	public static List<Map<String, Object>> getLoverCategory(
			String productCategoryId, Delegator delegator, int i)
			throws GenericEntityException {
		List<Map<String, Object>> mapList = FastList.newInstance();
		List<String> orderBy = FastList.newInstance();
		orderBy.add("sequenceId");
		List<GenericValue> categoryList = delegator.findByAnd(
				"ProductCategoryRollupAndChild",
				UtilMisc.toMap("parentProductCategoryId", productCategoryId),orderBy);
		String nbspStr = "";
		for (int z = 0; z < i; z++) {
			// nbspStr+="&nbsp;&nbsp;";
			nbspStr += "　　";
		}
		for (GenericValue category : categoryList) {
			Map<String, Object> map = FastMap.newInstance();
			map.put("productCategoryId",
					category.getString("productCategoryId"));
			map.put("categoryName",
					nbspStr + category.getString("categoryName")); // 此处计算加几个空格
			map.put("primaryParentCategoryId",
					category.getString("primaryParentCategoryId"));
			mapList.add(map);
			mapList.addAll(getLoverCategory(
					category.getString("productCategoryId"), delegator, i + 1));

		}
		return mapList;
	}
	
	
	
	/**
	 * 获取全部已通过审批的分类，放置到一个集合中
	 */
	@SuppressWarnings({ "deprecation", "rawtypes", "unchecked" })
	public static Map<String, Object> getAllShenPiProductCategory(DispatchContext dctx, Map<String, ? extends Object> context) {
		Delegator delegator = dctx.getDelegator();
		List<Map<String, Object>> mapList = FastList.newInstance();
		Map<String, Object> result = ServiceUtil.returnSuccess();
		String productStoreId = (String) context.get("productStoreId");
		String statusId = (String) context.get("statusId");
		String productCategoryId = (String) context.get("productCategoryId");
		List<String> orderBy = FastList.newInstance();
		orderBy.add("sequenceId");
		try {
			List<GenericValue> catalogCategoryList = FastList.newInstance();
			if(UtilValidate.isEmpty(productCategoryId)){
				GenericValue storeCatalog = EntityUtil.getFirst(delegator.findByAnd("ProductStoreCatalog", 
						UtilMisc.toMap("productStoreId", productStoreId)));
				Map findMap = UtilMisc.toMap("parentProductCategoryId", storeCatalog.getString("prodCatalogId"));
				findMap.put("productStoreId", productStoreId);
				if(UtilValidate.isNotEmpty(statusId)){
					findMap.put("statusId", statusId);
				}
				//顶级分类
				catalogCategoryList = delegator.findByAnd("ProductCategoryRollupStoreAndChild",findMap,orderBy);
			}else{
				catalogCategoryList = delegator.findByAnd("ProductCategoryRollupStoreAndChild",
						UtilMisc.toMap("productCategoryId", productCategoryId,"productStoreId", productStoreId),orderBy);
			}

			for (GenericValue catalogCategory : catalogCategoryList) {
				
				if(UtilValidate.isEmpty(productCategoryId)){
							Map<String, Object> map = FastMap.newInstance();
							map.put("productCategoryId",catalogCategory.getString("productCategoryId"));
							map.put("categoryName", catalogCategory.getString("categoryName"));
							map.put("primaryParentCategoryId", catalogCategory.getString("parentProductCategoryId"));
							map.put("statusId", catalogCategory.getString("statusId"));
							mapList.add(map);
				}
				
				Map findMap = UtilMisc.toMap("parentProductCategoryId", catalogCategory.getString("productCategoryId"));
				findMap.put("productStoreId", productStoreId);
				if(UtilValidate.isNotEmpty(statusId)){
					findMap.put("statusId", statusId);
				}
				//次级分类
				List<GenericValue> categoryList = delegator
						.findByAnd("ProductCategoryRollupStoreAndChild", findMap,orderBy);
				
				for(GenericValue subCategory: categoryList){
					Map<String, Object> map = FastMap.newInstance();
					
					map.put("productCategoryId",subCategory.getString("productCategoryId"));
					map.put("categoryName","　　"+subCategory.getString("categoryName"));
					map.put("primaryParentCategoryId", catalogCategory.getString("productCategoryId"));
					map.put("statusId", subCategory.getString("statusId"));
					mapList.add(map);
					int i = 2;
					// 计算他的下级。放入集合中，然后递归查找下级的下级
					mapList.addAll(getLoverShenPiCategory(subCategory.getString("productCategoryId"), delegator, i,statusId,productStoreId));
				}
			}
			result.put("categoryList", mapList);
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
		}
		return result;
	}

	@SuppressWarnings({ "deprecation", "rawtypes", "unchecked" })
	public static List<Map<String, Object>> getLoverShenPiCategory(String productCategoryId, Delegator delegator, int i,String statusId,String productStoreId) throws GenericEntityException {
		List<Map<String, Object>> mapList = FastList.newInstance();
		List<String> orderBy = FastList.newInstance();
		orderBy.add("sequenceId");
		
		Map findMap = UtilMisc.toMap("parentProductCategoryId", productCategoryId);
		findMap.put("productStoreId", productStoreId);
		if(UtilValidate.isNotEmpty(statusId)){
			findMap.put("statusId", statusId);
		}
		List<GenericValue> categoryList = delegator.findByAnd("ProductCategoryRollupStoreAndChild",findMap,orderBy);
		String nbspStr = "";
		for (int z = 0; z < i; z++) {
			// nbspStr+="&nbsp;&nbsp;";
			nbspStr += "　　";
		}
		for (GenericValue category : categoryList) {
			Map<String, Object> map = FastMap.newInstance();
			map.put("productCategoryId",category.getString("productCategoryId"));
			map.put("categoryName",nbspStr + category.getString("categoryName")); // 此处计算加几个空格
			map.put("primaryParentCategoryId",category.getString("parentProductCategoryId"));
			map.put("statusId", category.getString("statusId"));
			mapList.add(map);
			mapList.addAll(getLoverShenPiCategory(category.getString("productCategoryId"), delegator, i + 1,statusId,productStoreId));

		}
		return mapList;
	}
	
	/**
	 * 判断该产品是否是下架产品
	 * 
	 * @param delegator
	 * @param productId
	 * @return
	 */
	public static boolean isOffTheShelfProduct(Delegator delegator,
			String productId) {

		boolean isOffTheShelfProduct = false;
		Timestamp nowTimestamp = UtilDateTime.nowTimestamp();

		try {
			GenericValue product = delegator.findOne("Product",
					UtilMisc.toMap("productId", productId), true);
			if (UtilValidate.isNotEmpty(product.get("introductionDate"))) {
				isOffTheShelfProduct = nowTimestamp.before(product
						.getTimestamp("introductionDate"));
			}
			if (UtilValidate
					.isNotEmpty(product.get("salesDiscontinuationDate"))) {
				isOffTheShelfProduct = nowTimestamp.after(product
						.getTimestamp("salesDiscontinuationDate"));
			}

		} catch (GenericEntityException e) {
			Debug.log(e.getMessage());
		}

		return isOffTheShelfProduct;

	}

	/**
	 * 产品库存
	 * 
	 * @param delegator
	 * @param productId
	 * @return
	 */
	public static BigDecimal getProductInventoryATP(Delegator delegator,
			String productId) {
		BigDecimal availableToPromiseTotal = BigDecimal.ZERO;
		try {
			List<GenericValue> inventoryItemList = delegator.findByAnd(
					"InventoryItem", UtilMisc.toMap("productId", productId));
			if (UtilValidate.isNotEmpty(inventoryItemList)) {
				GenericValue inventoryItem = EntityUtil
						.getFirst(inventoryItemList);
				availableToPromiseTotal = inventoryItem
						.getBigDecimal("availableToPromiseTotal");
			}
		} catch (GenericEntityException e) {
			Debug.log(e.getMessage());
		}

		return availableToPromiseTotal;

	}
	
	/**
	 * 按照多个一级分类查询分类下的商品，（用于商城首页的图片滚动）
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String,Object> getProductInfoByCategory(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String,Object> result = ServiceUtil.returnSuccess();
		List<Map<String,Object>> resultList = FastList.newInstance();
		Delegator delegator = dctx.getDelegator();
		String[] categorys = ((String)context.get("categoryIds")).split(";"); //需要查询得一级目录列表
		int productSize = (Integer)context.get("productSize");					//每个以及分类需要查询多少个商品数量
		Debug.log("===得到的目录是："+context.get("categoryIds"));
		EntityFindOptions findOpts = new EntityFindOptions(true,
				EntityFindOptions.TYPE_SCROLL_INSENSITIVE,
				EntityFindOptions.CONCUR_READ_ONLY, false);
		
		//先查询每个目录下的子分类的商品
		for (String categoryId : categorys) {
			/**
			 * 结构{一级分类，二级分类list，查询的商品列表list}
			 */
			Map<String,Object> proMap = FastMap.newInstance();
			List<GenericValue> subGenList = FastList.newInstance();
			List<EntityCondition> condition = FastList.newInstance();  
			EntityListIterator eli = null;  
        	
	        try {
	        	//查询以及分类下有多少个自分类
				List<GenericValue> subCategorys = delegator.findByAnd("ProductCategoryRollup", UtilMisc.toMap("parentProductCategoryId",categoryId));
				if(subCategorys.size()>=8){
					//如果子分类超过8个，只取前8个
					subCategorys = subCategorys.subList(0, 8);
				}
				
				List<String> subCategoryId = FastList.newInstance();	//子分类列表，用于查询
				//拼接查询条件  分类 in (xxx,xxx,xxx)
				for (GenericValue subCategory : subCategorys) {
					subCategoryId.add(subCategory.getString("productCategoryId"));
					subGenList.add(delegator.findOne("ProductCategory", false, UtilMisc.toMap("productCategoryId",subCategory.getString("productCategoryId"))));
				}
				proMap.put("subCategoryList", subGenList);	//二级分类的list放入map
				Debug.log("===＝＝子目录是："+ subCategoryId );
				
				//条件
				condition.add(EntityCondition.makeCondition("productCategoryId", EntityOperator.IN, subCategoryId));
	       
	        	List<GenericValue> list = null;  
	        	int viewSize = productSize;  
	    		int dataSize = 0;  
	    		int viewIndex = 0;  
	    		        
	            int lowIndex = viewIndex * viewSize + 1;  
	            int highIndex = (viewIndex + 1) * viewSize; 
	            
	            Debug.log("===＝＝查询条件是。。："+ EntityCondition.makeCondition(condition) );
	            eli = delegator.find("ProductAndCategoryMember", EntityCondition.makeCondition(condition), null, null, UtilMisc.toList("-introductionDate"), findOpts);  
	            
//	            list = eli.getPartialList(lowIndex, viewSize);  
//	            eli.last();  
//	            dataSize = eli.currentIndex();  
	            
	            dataSize = eli.getResultsSizeAfterPartialList();
	            Debug.log("======getResultsSizeAfterPartialList 长度=" + dataSize);
	            Debug.log("======lowIndex =" + lowIndex);
	            Debug.log("======viewSize =" + viewSize);
	            //eli.beforeFirst();
	            if (dataSize > viewSize) {
	            	Debug.log("＝＝＝＝＝＝＝＝走getPartialList");
	            	list = eli.getPartialList(lowIndex,viewSize);
				} else if (dataSize > 0) {
					Debug.log("＝＝＝＝＝＝＝＝走getCompleteList");
					list = eli.getCompleteList();
				}
	            
	            proMap.put("list", list);	//list放进map
	            GenericValue category = delegator.findOne("ProductCategory", false, UtilMisc.toMap("productCategoryId",categoryId));
	            proMap.put("category", category);	//一级分类的信息放入map
	            resultList.add(proMap);
	            Debug.log("===＝＝map是。。："+ proMap);
	            
	            if (eli != null) {  
	                 eli.close();  
	            }
	            
	        } catch (GenericEntityException e) {  
	            Debug.logError(e.getMessage().toString(), module);  
	        } 
		}
		
		result.put("productList", resultList);
		
		return result;
	}
}
