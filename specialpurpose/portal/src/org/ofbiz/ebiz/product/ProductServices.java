package org.ofbiz.ebiz.product;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;

public class ProductServices {
	public static final String module = ProductServices.class.getName();
	private static String IMAGE_FOLDER = UtilProperties.getPropertyValue("productUpload.properties", "product.uploadfile.images");
	private static String ofbizHome = System.getProperty("ofbiz.home");
	public static final String LABEL_RESOURCE = "ShopMgrUiLabels";

	/**
	 * 新建商品
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String createProduct(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		String productId = "";
		boolean beganTransaction = false;
		try {
			beganTransaction = TransactionUtil.begin();
			Map<String, Object> context = UtilHttp.getParameterMap(request);
			context.put("userLogin", userLogin);
			context.put("featureIds", UtilHttp.makeParamMapWithPrefix(request, "valId_", null));
			context.put("productFeatureIds", UtilHttp.makeParamMapWithPrefix(request, "vvv[", null));
			context.put("spPriceMap", UtilHttp.makeParamMapWithPrefix(request, "sp_price_", null));// 子商品零售价
			context.put("spZhPriceMap", UtilHttp.makeParamMapWithPrefix(request, "sp_ZhPrice_", null));// 子商品人民币零售价
			context.put("spRuPriceMap", UtilHttp.makeParamMapWithPrefix(request, "sp_RuPrice_", null));// 子商品卢比零售价
			context.put("spInventoryMap", UtilHttp.makeParamMapWithPrefix(request, "sp_inventory_", null));// 子商品库存数量
			context.put("goodsNoMap", UtilHttp.makeParamMapWithPrefix(request, "sp_goodsNo_", null));
			context.put("imgUrlMap", UtilHttp.makeParamMapWithPrefix(request, "imgUrl_", null));// 子商品图片
			// context.put("orderNumMap",
			// UtilHttp.makeParamMapWithPrefix(request,"orderNum_",null));
			context.put("idMap", UtilHttp.makeParamMapWithPrefix(request, "[new]", null));
			context.put("filePathMap", UtilHttp.makeParamMapWithPrefix(request, "[path]", null));
			context.put("imgAlthMap", UtilHttp.makeParamMapWithPrefix(request, "[imgalt]", null));
			context.put("imgSeqMap", UtilHttp.makeParamMapWithPrefix(request, "[imgseq]", null));
			context.put("hasPriceMap", UtilHttp.makeParamMapWithPrefix(request, "hasPri_", null));
			context.put("priceMap", UtilHttp.makeParamMapWithPrefix(request, "price_", null));
			context.put("priceFromDateMap", UtilHttp.makeParamMapWithPrefix(request, "priceFromDate_", null));
			context.put("priceThruDateMap", UtilHttp.makeParamMapWithPrefix(request, "priceThruDate_", null));
			context.put("priceNameMap", UtilHttp.makeParamMapWithPrefix(request, "priceName_", null));
			context.put("currencyUomIdMap", UtilHttp.makeParamMapWithPrefix(request, "currencyUomId_", null));
			context.put("attribs", UtilHttp.makeParamMapWithPrefix(request, "attr_", null));
			ModelService pService = dispatcher.getDispatchContext().getModelService("createShopProduct");
			context = pService.makeValid(context, ModelService.IN_PARAM);
			Map<String, Object> res = dispatcher.runSync(pService.name, context);
			productId = (String) res.get("productId");
		} catch (Exception e) {
			try {
				e.printStackTrace();
				// only rollback the transaction if we started one...
				TransactionUtil.rollback(beganTransaction, "Error looking up entity values in WebTools Entity Data Maintenance", e);
			} catch (Exception e2) {
				Debug.logError(e2, "Could not rollback transaction: " + e2.toString(), module);
			}

			Debug.logError(e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		} finally {
			// only commit the transaction if we started one... this will throw
			// an exception if it fails
			try {
				TransactionUtil.commit(beganTransaction);
			} catch (GenericEntityException e2) {

				Debug.logError(e2, "Could not commit transaction: " + e2.toString(), module);
				return ModelService.RESPOND_ERROR;
			}
		}
		request.setAttribute("productId", productId);
		return ModelService.RESPOND_SUCCESS;
	}

	/**
	 * 修改商品
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String updateProduct(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		boolean beganTransaction = false;
		try {
			beganTransaction = TransactionUtil.begin();
			Map<String, Object> context = UtilHttp.getParameterMap(request);
			context.put("userLogin", userLogin);
			context.put("featureIds", UtilHttp.makeParamMapWithPrefix(request, "valId_", null));
			context.put("productFeatureIds", UtilHttp.makeParamMapWithPrefix(request, "vvv[", null));
			context.put("spPriceMap", UtilHttp.makeParamMapWithPrefix(request, "sp_price_", null));// 子商品零售价
			context.put("spZhPriceMap", UtilHttp.makeParamMapWithPrefix(request, "sp_ZhPrice_", null));// 子商品人民币零售价
			context.put("spRuPriceMap", UtilHttp.makeParamMapWithPrefix(request, "sp_RuPrice_", null));// 子商品卢比零售价
			context.put("imgUrlMap", UtilHttp.makeParamMapWithPrefix(request, "imgUrl_", null));// 子商品图片
			context.put("goodsNoMap", UtilHttp.makeParamMapWithPrefix(request, "sp_goodsNo_", null));
			context.put("orderNumMap", UtilHttp.makeParamMapWithPrefix(request, "orderNum_", null));
			context.put("idMap", UtilHttp.makeParamMapWithPrefix(request, "[new]", null));
			context.put("oldIdMap", UtilHttp.makeParamMapWithPrefix(request, "[old]", null));
			context.put("filePathMap", UtilHttp.makeParamMapWithPrefix(request, "[path]", null));
			context.put("imgAlthMap", UtilHttp.makeParamMapWithPrefix(request, "[imgalt]", null));
			context.put("imgSeqMap", UtilHttp.makeParamMapWithPrefix(request, "[imgseq]", null));
			context.put("hasPriceMap", UtilHttp.makeParamMapWithPrefix(request, "hasPri_", null));
			context.put("priceMap", UtilHttp.makeParamMapWithPrefix(request, "price_", null));
			context.put("priceFromDateMap", UtilHttp.makeParamMapWithPrefix(request, "priceFromDate_", null));
			context.put("priceThruDateMap", UtilHttp.makeParamMapWithPrefix(request, "priceThruDate_", null));
			context.put("priceNameMap", UtilHttp.makeParamMapWithPrefix(request, "priceName_", null));
			context.put("attribs", UtilHttp.makeParamMapWithPrefix(request, "attr_", null));
			ModelService pService = dispatcher.getDispatchContext().getModelService("updateShopProduct");
			context = pService.makeValid(context, ModelService.IN_PARAM);
			Debug.logError(">>>>>>>>>>>>>>>>>>>>>:"+context.get("productNameZh"), module);
			dispatcher.runSync(pService.name, context);

		} catch (Exception e) {
			try {
				// only rollback the transaction if we started one...
				TransactionUtil.rollback(beganTransaction, "Error looking up entity values in WebTools Entity Data Maintenance", e);
			} catch (GenericEntityException e2) {
				Debug.logError(e2, "Could not rollback transaction: " + e2.toString(), module);
			}

			Debug.logError(e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		} finally {
			// only commit the transaction if we started one... this will throw
			// an exception if it fails
			try {
				TransactionUtil.commit(beganTransaction);
			} catch (GenericEntityException e2) {

				Debug.logError(e2, "Could not commit transaction: " + e2.toString(), module);
				return ModelService.RESPOND_ERROR;
			}
		}

		return ModelService.RESPOND_SUCCESS;
	}

	/**
	 * 新增商品品牌时附件处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String uploadProductImage(HttpServletRequest request, HttpServletResponse response) {
		try {
			// IMAGE_FOLDER=request.getRealPath("/");
			String imageFilePath = ofbizHome + IMAGE_FOLDER;
			String imageUrlPrefix = UtilProperties.getPropertyValue("productUpload", "image.url.prefix");
			String imgFor = request.getParameter("imgFor");
			Map<String, Object> context = uploadFile(imageFilePath, request);
			Map<String, Object> resMap = FastMap.newInstance();
			// resMap.put("filePath",
			// /*request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+*/request.getContextPath()+"/"+context.get("filePath"));
			resMap.put("filePath", imageUrlPrefix + "/" + context.get("filePath"));
			resMap.put("imgFor", imgFor);
			response.setContentType("text/json; charset=UTF-8");
			toJsonObject(resMap, response);
		} catch (Exception e) {
			Debug.logError("When Create Product Brand Happen " + e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}

		return ModelService.RESPOND_SUCCESS;
	}

	public static void toJsonObject(Map<String, Object> attrMap, HttpServletResponse response) {
		JSONObject json = JSONObject.fromObject(attrMap);
		String jsonStr = json.toString();
		if (jsonStr == null) {
			Debug.logError("JSON Object was empty; fatal error!", module);
		}
		// set the X-JSON content type
		response.setContentType("text/html");
		// jsonStr.length is not reliable for unicode characters
		try {
			response.setContentLength(jsonStr.getBytes("UTF8").length);
		} catch (UnsupportedEncodingException e) {
			Debug.logError("Problems with Json encoding", module);
		}
		// return the JSON String
		Writer out;
		try {
			out = response.getWriter();
			out.write(jsonStr);
			out.flush();
		} catch (IOException e) {
			Debug.logError("Unable to get response writer", module);
		}
	}

	/**
	 * 规格附件处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String uploadProductFeatureImage(HttpServletRequest request, HttpServletResponse response) {
		GenericDelegator delegator = (GenericDelegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		try {
			String imgFor = request.getParameter("imgFor");
			String imageUrlPrefix = UtilProperties.getPropertyValue("productUpload", "product.uploadfile.feature");
			String imageFilePath = ofbizHome + imageUrlPrefix;
			Map<String, Object> context = uploadFile(imageFilePath, request);
			String filePath = (String) context.get("filePath");
			String productStoreId = ProductStoreWorker.getProductStoreId(request);
			GenericValue productStoreImageSetting = delegator.findByPrimaryKey("ProductStoreImageSetting", UtilMisc.toMap("productStoreId", productStoreId, "imageTypeId", "SPR_IMGTP_PRDFT"));
			if (UtilValidate.isNotEmpty(productStoreImageSetting)) {
				String imageScaleTypeId = productStoreImageSetting.getString("imageScaleTypeId");
				Double height = productStoreImageSetting.getDouble("height");
				Double width = productStoreImageSetting.getDouble("width");
				if (UtilValidate.isEmpty(height))
					height = new Double(30);
				if (UtilValidate.isEmpty(width))
					width = new Double(30);
				// 等比
				if ("SPR_IMGSCLTP_01".equals(imageScaleTypeId)) {
					ImageUtil.scale3(imageFilePath + filePath, imageFilePath + filePath, height.intValue(), width.intValue(), true);
				}
				// 裁剪
				else if ("SPR_IMGSCLTP_02".equals(imageScaleTypeId)) {
					ImageUtil.cutMiddle(imageFilePath + filePath, imageFilePath + filePath, height.intValue(), width.intValue());
				}
				String openWatermark = productStoreImageSetting.getString("openWatermark");
				if ("Y".equals(openWatermark)) {
					GenericValue productStoreWatermarkSetting = delegator.findByPrimaryKey("ProductStoreWatermarkSetting", UtilMisc.toMap("productStoreId", productStoreId, "imageTypeId", "SPR_IMGTP_ALL"));
					if (UtilValidate.isNotEmpty(productStoreWatermarkSetting)) {
						String watermarkTypeId = productStoreWatermarkSetting.getString("watermarkTypeId");
						// text
						if ("SPR_WMTYPE_TXT".equals(watermarkTypeId)) {
							Map<String, Object> addTextWaterMarkerMap = new HashMap<String, Object>();
							addTextWaterMarkerMap.put("userLogin", userLogin);
							addTextWaterMarkerMap.put("imageIn", imageFilePath + filePath);
							addTextWaterMarkerMap.put("imageResult", imageFilePath + filePath);
							addTextWaterMarkerMap.put("position", productStoreWatermarkSetting.getString("watermarkPositionId"));
							addTextWaterMarkerMap.put("alpha", productStoreWatermarkSetting.getString("imageTransparency"));
							addTextWaterMarkerMap.put("fontName", productStoreWatermarkSetting.getString("textFont"));
							addTextWaterMarkerMap.put("waterMarkerContent", productStoreWatermarkSetting.getString("watermarkText"));
							addTextWaterMarkerMap.put("color", productStoreWatermarkSetting.getString("textFontColor"));
							addTextWaterMarkerMap.put("shadowColor", productStoreWatermarkSetting.getString("fontShadowColor"));
							addTextWaterMarkerMap.put("fontSize", productStoreWatermarkSetting.getString("textFontSize"));
							ModelService pService = dispatcher.getDispatchContext().getModelService("addTextWaterMarker");
							addTextWaterMarkerMap = pService.makeValid(addTextWaterMarkerMap, ModelService.IN_PARAM);
							Map<String, Object> resultGv = dispatcher.runSync(pService.name, addTextWaterMarkerMap);
						}
						// image
						else if ("SPR_WMTYPE_PIC".equals(watermarkTypeId)) {
							String imageWaterUrl = UtilProperties.getPropertyValue("productUpload", "product.uploadfile.water");
							String imageWaterUrlPrefix = UtilProperties.getPropertyValue("productUpload", "water.url.prefix");
							String waterPath = ofbizHome + imageWaterUrl + productStoreWatermarkSetting.getString("watermarkImageUrl").replace(imageWaterUrlPrefix + "/", "");
							Map<String, Object> addImgWaterMarkerMap = new HashMap<String, Object>();
							addImgWaterMarkerMap.put("userLogin", userLogin);
							addImgWaterMarkerMap.put("waterMarkerContent", waterPath);
							addImgWaterMarkerMap.put("imageIn", imageFilePath + filePath);
							addImgWaterMarkerMap.put("imageResult", imageFilePath + filePath);
							addImgWaterMarkerMap.put("position", productStoreWatermarkSetting.getString("watermarkPositionId"));
							addImgWaterMarkerMap.put("alpha", productStoreWatermarkSetting.getString("imageTransparency"));
							ModelService pService = dispatcher.getDispatchContext().getModelService("addImgWaterMarker");
							addImgWaterMarkerMap = pService.makeValid(addImgWaterMarkerMap, ModelService.IN_PARAM);
							Map<String, Object> resultGv = dispatcher.runSync(pService.name, addImgWaterMarkerMap);
						}
					}
				}
			}
			Map<String, Object> resMap = FastMap.newInstance();
			resMap.put("filePath", UtilProperties.getPropertyValue("productUpload", "image.feature.url.prefix") + "/" + filePath);
			resMap.put("imgFor", imgFor);
			response.setContentType("text/json; charset=UTF-8");
			toJsonObject(resMap, response);
		} catch (Exception e) {
			Debug.logError("When Create upload Product Feature Image Happen " + e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}

		return ModelService.RESPOND_SUCCESS;
	}

	public static Map<String, Object> createProductListImage(DispatchContext dctx, Map<String, ? extends Object> context) {
		Debug.logInfo("start to createProductListImage", module);
		Delegator delegator = dctx.getDelegator();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		Map result = new HashMap();
		boolean beganTransaction = false;
		try {
			beganTransaction = TransactionUtil.begin();
			String nowDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
			String imageFilePath = ofbizHome + IMAGE_FOLDER;
			String imageUrlPrefix = UtilProperties.getPropertyValue("productUpload", "image.url.prefix");
			String productId = (String) context.get("productId");
			String contentAssocId = (String) context.get("contentAssocId");
			String filePath = (String) context.get("filePath");
			String description = (String) context.get("description");
			String productStoreId = (String) context.get("productStoreId");
			String oldPath = filePath;
			oldPath = imageFilePath + oldPath.replace(imageUrlPrefix + "/", "");

			filePath = filePath.replace(imageUrlPrefix, "");

			EntityConditionList<EntityExpr> condition = EntityCondition.makeCondition(UtilMisc.toList(EntityCondition.makeCondition("productStoreId", EntityOperator.EQUALS, productStoreId), EntityCondition.makeCondition("imageTypeId", EntityOperator.NOT_IN, UtilMisc.toList("SPR_IMGTP_ALL", "SPR_IMGTP_PRDFT"))), EntityOperator.AND);
			List<GenericValue> productStoreImageSettings = delegator.findList("ProductStoreImageSetting", condition, null, null, null, true);
			Debug.logInfo("start to deal for", module);
			for (GenericValue productStoreImageSetting : productStoreImageSettings) {

				String listPath = "";

				// List Image
				listPath = imageFilePath + "dealimage" + "/" + nowDay + "/" + productStoreImageSetting.getString("imageTypeId") + "_" + filePath.substring(filePath.lastIndexOf("/") + 1);
				String pth = listPath.substring(0, listPath.lastIndexOf("/"));
				File saveFilePath = new File(pth);
				if (!saveFilePath.exists()) {
					saveFilePath.mkdirs();
				}
				// GenericValue productStoreImageSetting =
				// delegator.findByPrimaryKey("ProductStoreImageSetting",
				// UtilMisc.toMap("productStoreId", productStoreId,
				// "imageTypeId", "SPR_IMGTP_PRDLST"));
				if (UtilValidate.isNotEmpty(productStoreImageSetting)) {
					String imageScaleTypeId = productStoreImageSetting.getString("imageScaleTypeId");
					Double height = productStoreImageSetting.getDouble("height");
					Double width = productStoreImageSetting.getDouble("width");
					if (UtilValidate.isEmpty(height))
						height = new Double(30);
					if (UtilValidate.isEmpty(width))
						width = new Double(30);
					String openWatermark = productStoreImageSetting.getString("openWatermark");
					if (UtilValidate.isNotEmpty(productStoreImageSetting)) {
						// 等比
						if ("SPR_IMGSCLTP_01".equals(imageScaleTypeId)) {
							ImageUtil.scale3(oldPath, listPath, height.intValue(), width.intValue(), true);
						}
						// 裁剪
						else if ("SPR_IMGSCLTP_02".equals(imageScaleTypeId)) {
							ImageUtil.cutMiddle(oldPath, listPath, height.intValue(), width.intValue());
						}
						if ("Y".equals(openWatermark)) {
							GenericValue productStoreWatermarkSetting = delegator.findByPrimaryKey("ProductStoreWatermarkSetting", UtilMisc.toMap("productStoreId", productStoreId, "imageTypeId", "SPR_IMGTP_ALL"));
							if (UtilValidate.isNotEmpty(productStoreWatermarkSetting)) {
								String watermarkTypeId = productStoreWatermarkSetting.getString("watermarkTypeId");
								// text
								if ("SPR_WMTYPE_TXT".equals(watermarkTypeId)) {
									Map<String, Object> addTextWaterMarkerMap = new HashMap<String, Object>();
									addTextWaterMarkerMap.put("userLogin", userLogin);
									addTextWaterMarkerMap.put("imageIn", listPath);
									addTextWaterMarkerMap.put("imageResult", listPath);
									addTextWaterMarkerMap.put("position", productStoreWatermarkSetting.getString("watermarkPositionId"));
									addTextWaterMarkerMap.put("alpha", productStoreWatermarkSetting.getString("imageTransparency"));
									addTextWaterMarkerMap.put("fontName", productStoreWatermarkSetting.getString("textFont"));
									addTextWaterMarkerMap.put("waterMarkerContent", productStoreWatermarkSetting.getString("watermarkText"));
									addTextWaterMarkerMap.put("color", productStoreWatermarkSetting.getString("textFontColor"));
									addTextWaterMarkerMap.put("shadowColor", productStoreWatermarkSetting.getString("fontShadowColor"));
									addTextWaterMarkerMap.put("fontSize", productStoreWatermarkSetting.getString("textFontSize"));
									ModelService pService = dispatcher.getDispatchContext().getModelService("addTextWaterMarker");
									addTextWaterMarkerMap = pService.makeValid(addTextWaterMarkerMap, ModelService.IN_PARAM);
									Map<String, Object> resultGv = dispatcher.runSync(pService.name, addTextWaterMarkerMap);
								}
								// image
								else if ("SPR_WMTYPE_PIC".equals(watermarkTypeId)) {
									String imageWaterUrl = UtilProperties.getPropertyValue("productUpload", "product.uploadfile.water");
									String imageWaterUrlPrefix = UtilProperties.getPropertyValue("productUpload", "water.url.prefix");
									String waterPath = ofbizHome + imageWaterUrl + productStoreWatermarkSetting.getString("watermarkImageUrl").replace(imageWaterUrlPrefix + "/", "");
									Map<String, Object> addImgWaterMarkerMap = new HashMap<String, Object>();
									addImgWaterMarkerMap.put("userLogin", userLogin);
									addImgWaterMarkerMap.put("waterMarkerContent", waterPath);
									addImgWaterMarkerMap.put("imageIn", listPath);
									addImgWaterMarkerMap.put("imageResult", listPath);
									addImgWaterMarkerMap.put("position", productStoreWatermarkSetting.getString("watermarkPositionId"));
									addImgWaterMarkerMap.put("alpha", productStoreWatermarkSetting.getString("imageTransparency"));
									ModelService pService = dispatcher.getDispatchContext().getModelService("addImgWaterMarker");
									addImgWaterMarkerMap = pService.makeValid(addImgWaterMarkerMap, ModelService.IN_PARAM);
									Map<String, Object> resultGv = dispatcher.runSync(pService.name, addImgWaterMarkerMap);
								}
							}
						}
					}
				}
				Map<String, Object> createContentMap = new HashMap<String, Object>();
				createContentMap.put("userLogin", userLogin);
				createContentMap.put("contentName", imageUrlPrefix + "/" + "dealimage" + "/" + nowDay + "/" + productStoreImageSetting.getString("imageTypeId") + "_" + filePath.substring(filePath.lastIndexOf("/") + 1));
				createContentMap.put("description", description);
				createContentMap.put("contentTypeId", "DOCUMENT");
				ModelService pService = dispatcher.getDispatchContext().getModelService("createContent");
				createContentMap = pService.makeValid(createContentMap, ModelService.IN_PARAM);
				Map<String, Object> resultGv = dispatcher.runSync(pService.name, createContentMap);
				String contentId = (String) resultGv.get("contentId");

				Map<String, Object> createContentPurposeMap = new HashMap<String, Object>();
				createContentPurposeMap.put("userLogin", userLogin);
				createContentPurposeMap.put("contentId", contentId);
				GenericValue enumGv = delegator.findOne("Enumeration", UtilMisc.toMap("enumId", productStoreImageSetting.getString("imageTypeId")), false);
				createContentPurposeMap.put("contentPurposeTypeId", enumGv.getString("enumCode"));// Enumeration.enumCode
				pService = dispatcher.getDispatchContext().getModelService("createContentPurpose");
				createContentPurposeMap = pService.makeValid(createContentPurposeMap, ModelService.IN_PARAM);
				resultGv = dispatcher.runSync(pService.name, createContentPurposeMap);

				/*
				 * 
				 * Map<String, Object> createProductContentMap = new
				 * HashMap<String, Object>();
				 * createProductContentMap.put("userLogin", userLogin);
				 * createProductContentMap.put("contentId", contentId);
				 * createProductContentMap.put("productId", productId);
				 * createProductContentMap.put("productContentTypeId", "IMAGE");
				 * createProductContentMap.put("fromDate",
				 * UtilDateTime.nowTimestamp());
				 * createProductContentMap.put("contentTypeId", "DOCUMENT");
				 * pService = dispatcher.getDispatchContext().getModelService(
				 * "createProductContent"); createContentMap =
				 * pService.makeValid(createProductContentMap,
				 * ModelService.IN_PARAM); resultGv =
				 * dispatcher.runSync(pService.name, createProductContentMap);
				 */

				Map<String, Object> createContentAssocMap = new HashMap<String, Object>();
				createContentAssocMap.put("userLogin", userLogin);
				createContentAssocMap.put("contentIdTo", contentId);
				createContentAssocMap.put("contentIdFrom", contentAssocId);
				createContentAssocMap.put("fromDate", UtilDateTime.nowTimestamp());
				createContentAssocMap.put("contentAssocTypeId", "TREE_CHILD");
				pService = dispatcher.getDispatchContext().getModelService("createContentAssoc");
				createContentAssocMap = pService.makeValid(createContentAssocMap, ModelService.IN_PARAM);
				resultGv = dispatcher.runSync(pService.name, createContentAssocMap);
			}

			//

			/*
			 * //Cart Image listPath = imageFilePath + "cart" + nowDay +
			 * filePath.substring(filePath.lastIndexOf("/")); pth =
			 * listPath.substring(0, listPath.lastIndexOf("/")); saveFilePath =
			 * new File(pth); if (!saveFilePath.exists()) {
			 * saveFilePath.mkdirs();} GenericValue productStoreImageSettingCart
			 * = delegator.findByPrimaryKey("ProductStoreImageSetting",
			 * UtilMisc.toMap("productStoreId", productStoreId, "imageTypeId",
			 * "SPR_IMGTP_SPCT"));
			 * if(UtilValidate.isNotEmpty(productStoreImageSettingCart)){ String
			 * imageScaleTypeId =
			 * productStoreImageSettingCart.getString("imageScaleTypeId");
			 * Double height = productStoreImageSettingCart.getDouble("height");
			 * Double width = productStoreImageSettingCart.getDouble("width");
			 * if(UtilValidate.isEmpty(height)) height = new Double(30);
			 * if(UtilValidate.isEmpty(width)) width = new Double(30); String
			 * openWatermark =
			 * productStoreImageSetting.getString("openWatermark");
			 * if(UtilValidate.isNotEmpty(productStoreImageSetting)){ //等比
			 * if("SPR_IMGSCLTP_01".equals(imageScaleTypeId)){
			 * ImageUtil.scale2(oldPath, listPath, height.intValue(),
			 * width.intValue(), true); } //裁剪 else
			 * if("SPR_IMGSCLTP_02".equals(imageScaleTypeId)){
			 * ImageUtil.cutMiddle(oldPath, listPath, height.intValue(),
			 * width.intValue()); } if("Y".equals(openWatermark)){ GenericValue
			 * productStoreWatermarkSetting =
			 * delegator.findByPrimaryKey("ProductStoreWatermarkSetting",
			 * UtilMisc.toMap("productStoreId", productStoreId, "imageTypeId",
			 * "SPR_IMGTP_ALL"));
			 * if(UtilValidate.isNotEmpty(productStoreWatermarkSetting)){ String
			 * watermarkTypeId =
			 * productStoreWatermarkSetting.getString("watermarkTypeId"); //text
			 * if("SPR_WMTYPE_TXT".equals(watermarkTypeId)){ Map<String, Object>
			 * addTextWaterMarkerMap = new HashMap<String, Object>();
			 * addTextWaterMarkerMap.put("userLogin", userLogin);
			 * addTextWaterMarkerMap.put("imageIn", listPath);
			 * addTextWaterMarkerMap.put("imageResult", listPath);
			 * addTextWaterMarkerMap.put("position",
			 * productStoreWatermarkSetting.getString("watermarkPositionId"));
			 * addTextWaterMarkerMap.put("alpha",
			 * productStoreWatermarkSetting.getString("imageTransparency"));
			 * addTextWaterMarkerMap.put("fontName",
			 * productStoreWatermarkSetting.getString("textFont"));
			 * addTextWaterMarkerMap.put("waterMarkerContent",
			 * productStoreWatermarkSetting.getString("watermarkText"));
			 * addTextWaterMarkerMap.put("color",
			 * productStoreWatermarkSetting.getString("textFontColor"));
			 * addTextWaterMarkerMap.put("shadowColor",
			 * productStoreWatermarkSetting.getString("fontShadowColor"));
			 * addTextWaterMarkerMap.put("fontSize",
			 * productStoreWatermarkSetting.getString("textFontSize"));
			 * ModelService pServices =
			 * dispatcher.getDispatchContext().getModelService
			 * ("addTextWaterMarker"); addTextWaterMarkerMap =
			 * pServices.makeValid(addTextWaterMarkerMap,
			 * ModelService.IN_PARAM); Map<String, Object> resultGvs =
			 * dispatcher.runSync(pServices.name, addTextWaterMarkerMap); }
			 * //image else if("SPR_WMTYPE_PIC".equals(watermarkTypeId)){ String
			 * imageWaterUrl = UtilProperties.getPropertyValue("productUpload",
			 * "product.uploadfile.water"); String imageWaterUrlPrefix =
			 * UtilProperties.getPropertyValue("productUpload",
			 * "water.url.prefix"); String waterPath = ofbizHome + imageWaterUrl
			 * +
			 * productStoreWatermarkSetting.getString("watermarkImageUrl").replace
			 * (imageWaterUrlPrefix+"/", ""); Map<String, Object>
			 * addImgWaterMarkerMap = new HashMap<String, Object>();
			 * addImgWaterMarkerMap.put("userLogin", userLogin);
			 * addImgWaterMarkerMap.put("waterMarkerContent", waterPath);
			 * addImgWaterMarkerMap.put("imageIn", listPath);
			 * addImgWaterMarkerMap.put("imageResult", listPath);
			 * addImgWaterMarkerMap.put("position",
			 * productStoreWatermarkSetting.getString("watermarkPositionId"));
			 * addImgWaterMarkerMap.put("alpha",
			 * productStoreWatermarkSetting.getString("imageTransparency"));
			 * ModelService pServices =
			 * dispatcher.getDispatchContext().getModelService
			 * ("addImgWaterMarker"); addImgWaterMarkerMap =
			 * pServices.makeValid(addImgWaterMarkerMap, ModelService.IN_PARAM);
			 * Map<String, Object> resultGvs =
			 * dispatcher.runSync(pServices.name, addImgWaterMarkerMap); } } } }
			 * } Map<String, Object> createContentCartMap = new HashMap<String,
			 * Object>(); createContentCartMap.put("userLogin", userLogin);
			 * createContentCartMap.put("contentName", imageUrlPrefix+ "/cart" +
			 * filePath); createContentCartMap.put("description", description);
			 * createContentCartMap.put("contentTypeId", "DOCUMENT"); pService =
			 * dispatcher.getDispatchContext().getModelService("createContent");
			 * createContentCartMap = pService.makeValid(createContentCartMap,
			 * ModelService.IN_PARAM); resultGv =
			 * dispatcher.runSync(pService.name, createContentCartMap);
			 * contentId = (String)resultGv.get("contentId");
			 * 
			 * Map<String, Object> createContentPurposeCartMap = new
			 * HashMap<String, Object>();
			 * createContentPurposeCartMap.put("userLogin", userLogin);
			 * createContentPurposeCartMap.put("contentId", contentId);
			 * createContentPurposeCartMap.put("contentPurposeTypeId",
			 * "EB_PROD_CART"); pService =
			 * dispatcher.getDispatchContext().getModelService
			 * ("createContentPurpose"); createContentPurposeCartMap =
			 * pService.makeValid(createContentPurposeCartMap,
			 * ModelService.IN_PARAM); resultGv =
			 * dispatcher.runSync(pService.name, createContentPurposeCartMap);
			 * 
			 * Map<String, Object> createProductContentCartMap = new
			 * HashMap<String, Object>();
			 * createProductContentCartMap.put("userLogin", userLogin);
			 * createProductContentCartMap.put("contentId", contentId);
			 * createProductContentCartMap.put("productId", productId);
			 * createProductContentCartMap.put("productContentTypeId", "IMAGE");
			 * createProductContentCartMap.put("fromDate",
			 * UtilDateTime.nowTimestamp());
			 * createProductContentCartMap.put("contentTypeId", "DOCUMENT");
			 * pService = dispatcher.getDispatchContext().getModelService(
			 * "createProductContent"); createProductContentCartMap =
			 * pService.makeValid(createProductContentCartMap,
			 * ModelService.IN_PARAM); resultGv =
			 * dispatcher.runSync(pService.name, createProductContentCartMap);
			 * 
			 * Map<String, Object> createContentAssocCartMap = new
			 * HashMap<String, Object>();
			 * createContentAssocCartMap.put("userLogin", userLogin);
			 * createContentAssocCartMap.put("contentIdTo", contentId);
			 * createContentAssocCartMap.put("contentIdFrom", contentAssocId);
			 * createContentAssocCartMap.put("fromDate",
			 * UtilDateTime.nowTimestamp());
			 * createContentAssocCartMap.put("contentAssocTypeId",
			 * "TREE_CHILD"); pService =
			 * dispatcher.getDispatchContext().getModelService
			 * ("createContentAssoc"); createContentAssocCartMap =
			 * pService.makeValid(createContentAssocCartMap,
			 * ModelService.IN_PARAM); resultGv =
			 * dispatcher.runSync(pService.name, createContentAssocCartMap);
			 */

		} catch (Exception e) {
			try {
				// only rollback the transaction if we started one...
				TransactionUtil.rollback(beganTransaction, "Error looking up entity values in WebTools Entity Data Maintenance", e);
			} catch (GenericEntityException e2) {
				Debug.logError(e2, "Could not rollback transaction: " + e2.toString(), "GetContentLookupList.groovy");
			}
			String errMsg = "Error creating new virtual product from variant products: " + e.toString();
			Debug.logError(e, errMsg, module);
		} finally {
			// only commit the transaction if we started one... this will throw
			// an exception if it fails
			try {
				TransactionUtil.commit(beganTransaction);
			} catch (GenericEntityException e2) {
				Debug.logError(e2, "Could not commit transaction: " + e2.toString(), module);
			}
		}
		result.put("successMessage", "操作成功");
		return result;
	}

	/**
	 * public static String importProductFromFile(HttpServletRequest request,
	 * HttpServletResponse response) { LocalDispatcher dispatcher =
	 * (LocalDispatcher) request.getAttribute("dispatcher"); GenericValue
	 * userLogin = (GenericValue)
	 * request.getSession().getAttribute("userLogin"); try {
	 * //IMAGE_FOLDER=request.getRealPath("/"); String excelUrlPrefix =
	 * UtilProperties.getPropertyValue("productUpload",
	 * "product.uploadfile.excel"); String imageFilePath = ofbizHome +
	 * excelUrlPrefix; Map<String, Object> context =
	 * UtilFileUpload.uploadFile(imageFilePath, request); String filePath =
	 * imageFilePath + context.get("filePath"); Workbook book = null; try { book
	 * = new XSSFWorkbook(filePath); } catch (Exception ex) { book = new
	 * HSSFWorkbook(new FileInputStream(filePath)); } pyCidKeyEntitys =
	 * delegator.findByAnd("TypeAttribute",["attributeName":"年份"]);
	 * if(pyCidKeyEntitys){ keyEntity = EntityUtil.getFirst(pyCidKeyEntitys);
	 * if(keyEntity) pyCidKey = keyEntity.attributeId; } int goodsNoNum = -1;
	 * int InventoryNum = -1; int productNameNum = -1; int typeNum = -1; int
	 * categoryNum = -1; int varietyNum = -1; int yearNum = -1; int priceNum =
	 * -1; int placeNum = -1; int gradeNum = -1; int otherNum = -1; int dateNum
	 * = -1; int temperatureNum = -1; int alcoholDegreeNum = -1; int
	 * lifePeriodNum = -1; int salepriceNum = -1; Sheet sheet =
	 * book.getSheetAt(0); int sheetLastRowNumber = sheet.getLastRowNum(); Row
	 * row = sheet.getRow(0); if (row != null) { for (int m = 0; m <
	 * row.getLastCellNum(); m++) { Cell cell = row.getCell(m);
	 * cell.setCellType(HSSFCell.CELL_TYPE_STRING); String cellStr =
	 * cell.getRichStringCellValue().toString(); if ("货号".equals(cellStr)) {
	 * goodsNoNum = m; } if ("库存".equals(cellStr)) { InventoryNum = m; } if
	 * ("名称".equals(cellStr)) { productNameNum = m; } if ("类型".equals(cellStr))
	 * { typeNum = m; } if ("分类".equals(cellStr)) { categoryNum = m; } if
	 * ("品种".equals(cellStr)) { varietyNum = m; } if ("年份".equals(cellStr)) {
	 * yearNum = m; } if ("价格".equals(cellStr)) { priceNum = m; } if
	 * ("原产地".equals(cellStr)) { placeNum = m; } if ("等级".equals(cellStr)) {
	 * gradeNum = m; } if ("其他".equals(cellStr)) { otherNum = m; } if
	 * ("灌装日期".equals(cellStr)) { dateNum = m; } if ("饮用温度".equals(cellStr)) {
	 * temperatureNum = m; } if ("酒精度".equals(cellStr)) { alcoholDegreeNum = m;
	 * } if ("保质期".equals(cellStr)) { lifePeriodNum = m; } if
	 * ("销售价".equals(cellStr)) { salepriceNum = m; } } }
	 * 
	 * for (int j = 1; j <= sheetLastRowNumber; j++) { row = sheet.getRow(j); if
	 * (row != null) { System.out.println("货号 = " + row.getCell(goodsNoNum) +
	 * "    " + "库存 = " + row.getCell(InventoryNum) + "    " + "名称 = " +
	 * row.getCell(productNameNum) + "    " + "类型 = " + row.getCell(typeNum) +
	 * "    " + "分类 = " + row.getCell(categoryNum) + "    " + "品种 = " +
	 * row.getCell(varietyNum) + "    " + "年份 = " + row.getCell(yearNum) +
	 * "    " + "价格 = " + row.getCell(priceNum) + "    " + "原产地 = " +
	 * row.getCell(placeNum) + "    " + "等级 = " + row.getCell(gradeNum) + "    "
	 * + "其他 = " + row.getCell(otherNum) + "    " + "灌装日期 = " +
	 * row.getCell(dateNum) + "    " + "饮用温度 = " + row.getCell(temperatureNum) +
	 * "    " + "酒精度 = " + row.getCell(alcoholDegreeNum) + "    " + "保质期 = " +
	 * row.getCell(lifePeriodNum) + "    " + "销售价 = " +
	 * row.getCell(salepriceNum) + "    "
	 * 
	 * ); for (int m = 0; m < row.getLastCellNum(); m++) { Cell cell =
	 * row.getCell(m); System.out.println("==========cell===========" + cell); }
	 * } } } catch (Exception e) {
	 * Debug.logError("When Create Product Brand Happen "+e.getMessage(),
	 * module); return ModelService.RESPOND_ERROR; }
	 * 
	 * return ModelService.RESPOND_SUCCESS; }
	 */
	/*
	 * public static Map<String, Object> updateShopProduct(DispatchContext dctx,
	 * Map<String, ? extends Object> context) {
	 * 
	 * Delegator delegator = dctx.getDelegator(); LocalDispatcher dispatcher =
	 * dctx.getDispatcher(); GenericValue userLogin = (GenericValue)
	 * context.get("userLogin"); Map result = new HashMap(); boolean
	 * beganTransaction = false; try { beganTransaction =
	 * TransactionUtil.begin();
	 * 
	 * String callingMethodName = "updateShopProduct"; String checkAction =
	 * "UPDATE"; String productId = (String)context.get("productId");
	 * GenericValue lookedUpValue = delegator.findOne("Product", false,
	 * UtilMisc.toMap("productId", productId));
	 * 
	 * String attrTypeId = lookedUpValue.getString("productTypeId");
	 * 
	 * Object productTypeCategoryId = context.get("productTypeCategoryId");
	 * Object primaryProductCategoryId = null; if (productTypeCategoryId != null
	 * && !productTypeCategoryId.equals("")) {
	 * lookedUpValue.set("primaryProductCategoryId", productTypeCategoryId);
	 * primaryProductCategoryId = productTypeCategoryId; } else {
	 * productTypeCategoryId =
	 * lookedUpValue.getString("primaryProductCategoryId"); }
	 * lookedUpValue.setNonPKFields(context); Timestamp nowstamp =
	 * UtilDateTime.nowTimestamp(); lookedUpValue.set("lastModifiedDate",
	 * nowstamp); lookedUpValue.set("lastModifiedByUserLogin",
	 * userLogin.get("userLoginId"));
	 * 
	 * Object saleable = context.get("saleable"); if (saleable != null &&
	 * saleable.equals("N")) { lookedUpValue.set("salesDiscontinuationDate",
	 * nowstamp); } Object goodType = context.get("goodType"); if (goodType !=
	 * null && goodType.equals("sigleGood")) { lookedUpValue.set("isVirtual",
	 * "N"); } else { lookedUpValue.set("isVirtual", "Y"); } Object
	 * paraSalesDiscontinuationDateObject =
	 * context.get("salesDiscontinuationDate"); if
	 * (paraSalesDiscontinuationDateObject != null) { try { Timestamp
	 * salesDiscontinuationDate = DateTimeUtils.toTimestamp((String)
	 * paraSalesDiscontinuationDateObject);
	 * lookedUpValue.set("salesDiscontinuationDate", salesDiscontinuationDate);
	 * } catch (Exception e1) {
	 * 
	 * } } lookedUpValue.store(); // 主分类 List<GenericValue> mainCategorys =
	 * delegator.findByAnd("ProductCategoryMember", UtilMisc.toMap("productId",
	 * productId, "disType", "main")); if (mainCategorys != null &&
	 * mainCategorys.size() > 0) { for (GenericValue mainCategory :
	 * mainCategorys) { String productCategoryId =
	 * mainCategory.getString("productCategoryId"); if
	 * (productCategoryId.equals(primaryProductCategoryId)) { GenericValue
	 * mainCategoryMember = delegator.makeValue("ProductCategoryMember");
	 * mainCategoryMember.set("productId", productId);
	 * mainCategoryMember.set("productCategoryId", primaryProductCategoryId);
	 * mainCategoryMember.set("fromDate", nowstamp);
	 * mainCategoryMember.set("disType", "main"); mainCategoryMember.create();
	 * mainCategory.set("thruDate", nowstamp); mainCategory.store(); } } } else
	 * { GenericValue mainCategoryMember =
	 * delegator.makeValue("ProductCategoryMember");
	 * mainCategoryMember.set("productId", productId);
	 * mainCategoryMember.set("productCategoryId", primaryProductCategoryId);
	 * mainCategoryMember.set("fromDate", nowstamp);
	 * mainCategoryMember.set("disType", "main"); mainCategoryMember.create(); }
	 * 
	 * // 属性 Object attribs = context.get("attribs"); if (attribs != null) { for
	 * (Map.Entry<String, String> m : ((Map<String, String>)
	 * attribs).entrySet()) { String key = m.getKey(); String value =
	 * m.getValue(); GenericValue productAttribute =
	 * delegator.findOne("ProductAttribute", UtilMisc.toMap("productId",
	 * productId, "attrName", key), false); if (productAttribute != null) {
	 * productAttribute.set("attrValue", value); productAttribute.store(); }
	 * else { GenericValue newProductAttibute =
	 * delegator.makeValue("ProductAttribute");
	 * newProductAttibute.set("productId", productId);
	 * newProductAttibute.set("attrName", key);
	 * newProductAttibute.set("attrValue", value); newProductAttibute.create();
	 * } } } else { delegator.removeByAnd("ProductAttribute",
	 * UtilMisc.toMap("productId", productId)); } // 关联产品 List<GenericValue>
	 * productAssocList = delegator.findByAnd("ProductAssoc",
	 * UtilMisc.toMap("productId", productId, "productAssocTypeId",
	 * "ALSO_BOUGHT")); if (productAssocList != null && productAssocList.size()
	 * > 0) { delegator.removeAll(productAssocList, true); } Object
	 * product_assocs = context.get("product_assocs"); if (product_assocs !=
	 * null) { for (String productIdTo : (List<String>) product_assocs) {
	 * GenericValue productAssoc = delegator.makeValue("ProductAssoc");
	 * productAssoc.set("productId", productId); productAssoc.set("productIdTo",
	 * productIdTo); productAssoc.set("fromDate", nowstamp);
	 * productAssoc.set("productAssocTypeId", "ALSO_BOUGHT");
	 * productAssoc.create(); } } // 关联配件 List<GenericValue> productConfigList =
	 * delegator.findByAnd("ProductAssoc", UtilMisc.toMap("productId",
	 * productId, "productAssocTypeId", "PRODUCT_ACCESSORY")); if
	 * (productConfigList != null) { delegator.removeAll(productConfigList,
	 * true); } Object product_configs = context.get("product_configs"); if
	 * (product_assocs != null) { for (String productIdTo : (List<String>)
	 * product_configs) { GenericValue productAssoc =
	 * delegator.makeValue("ProductAssoc"); productAssoc.set("productId",
	 * productId); productAssoc.set("productIdTo", productIdTo);
	 * productAssoc.set("fromDate", nowstamp);
	 * productAssoc.set("productAssocTypeId", "PRODUCT_ACCESSORY");
	 * productAssoc.create(); } } // 扩展分类 List<GenericValue>
	 * productCategoryMemberList = delegator.findByAnd("ProductCategoryMember",
	 * UtilMisc.toMap("productId", productId, "disType", "other")); if
	 * (productCategoryMemberList != null) {
	 * delegator.removeAll(productCategoryMemberList, true); } Object
	 * product_categorys = context.get("product_categorys"); if
	 * (product_categorys != null) { for (String productCategoryId :
	 * (List<String>) product_categorys) { GenericValue productCategoryMember =
	 * delegator.makeValue("ProductCategoryMember");
	 * productCategoryMember.set("productId", productId);
	 * productCategoryMember.set("productCategoryId", productCategoryId);
	 * productCategoryMember.set("fromDate", nowstamp);
	 * productCategoryMember.set("disType", "other");
	 * productCategoryMember.create(); } } // 类型分类 List<GenericValue>
	 * typeCategorys = delegator.findByAnd("ProductCategoryMember",
	 * UtilMisc.toMap("productId", productId, "disType", "type"));
	 * 
	 * if (typeCategorys != null) { typeCategorys =
	 * EntityUtil.filterByDate(typeCategorys); for (GenericValue typeCategory :
	 * typeCategorys) { String productCategoryId =
	 * typeCategory.getString("productCategoryId"); if (productCategoryId !=
	 * null && !productCategoryId.equals(productTypeCategoryId)) { GenericValue
	 * typeCategoryMember = delegator.makeValue("ProductCategoryMember");
	 * typeCategoryMember.set("productId", productId);
	 * typeCategoryMember.set("productCategoryId", productCategoryId);
	 * typeCategoryMember.set("fromDate", nowstamp);
	 * typeCategoryMember.set("disType", "type"); typeCategoryMember.create();
	 * typeCategory.set("thruDate", nowstamp); typeCategory.store(); } } } else
	 * { GenericValue typeCategoryMember =
	 * delegator.makeValue("ProductCategoryMember");
	 * typeCategoryMember.set("productId", productId);
	 * typeCategoryMember.set("productCategoryId", productTypeCategoryId);
	 * typeCategoryMember.set("fromDate", nowstamp);
	 * typeCategoryMember.set("disType", "type"); typeCategoryMember.create(); }
	 * // 规格 if (goodType.equals("specGood")) { Object featureIds =
	 * context.get("featureIds"); if (featureIds != null) { List<GenericValue>
	 * pfGvList = delegator.findByAnd("ProductFeatureAppl",
	 * UtilMisc.toMap("productId", productId, "productFeatureApplTypeId",
	 * "SELECTABLE_FEATURE")); List<String> pfidList =
	 * EntityUtil.getFieldListFromEntityList(pfGvList, "productFeatureId",
	 * true); for (Object productFeatureId : ((Map) featureIds).values()) { if
	 * (pfidList.contains(productFeatureId)) {
	 * pfidList.remove(productFeatureId); } else { GenericValue
	 * productFeatureAppl = delegator.makeValue("ProductFeatureAppl");
	 * productFeatureAppl.set("productId", productId);
	 * productFeatureAppl.set("productFeatureId", productFeatureId);
	 * productFeatureAppl.set("fromDate", nowstamp);
	 * productFeatureAppl.set("productFeatureApplTypeId", "SELECTABLE_FEATURE");
	 * productFeatureAppl.create(); } } if (pfidList != null && pfidList.size()
	 * > 0) { List<GenericValue> removeList =
	 * delegator.findList("ProductFeatureAppl",
	 * EntityCondition.makeCondition(UtilMisc
	 * .toList(EntityCondition.makeCondition("productId", productId),
	 * EntityCondition.makeCondition("productFeatureId", EntityOperator.IN,
	 * pfidList))), null, null, null, false); removeList =
	 * EntityUtil.filterByDate(removeList); if (removeList != null) { for
	 * (GenericValue remove : removeList) { remove.set("thruDate", nowstamp);
	 * remove.store(); } } } } Object productFeatureIds =
	 * context.get("productFeatureIds"); if (productFeatureIds != null) {
	 * FastMap<String, List<String>> groupIdMap = FastMap.newInstance();
	 * FastMap<String, String> existsGroupIdMap = FastMap.newInstance(); for
	 * (Map.Entry<String, String> entry : ((Map<String, String>)
	 * productFeatureIds).entrySet()) { String pfId = entry.getKey(); String
	 * productFeatureId = entry.getValue(); if (productFeatureId != null) {
	 * String isOne = pfId.substring(0, pfId.indexOf("]")); if
	 * (pfId.contains("valId")) { if (groupIdMap.containsKey(isOne)) {
	 * List<String> isOneList = (List<String>) groupIdMap.get(isOne);
	 * isOneList.add(productFeatureId); groupIdMap.put(isOne, isOneList); } else
	 * { List<String> a = FastList.newInstance(); a.add(productFeatureId);
	 * groupIdMap.put(isOne, a); } } if (pfId.contains("[cid]")) {
	 * existsGroupIdMap.put(isOne, productFeatureId); } } } if
	 * (existsGroupIdMap.size() > 0) { for (Map.Entry<String, String> entry :
	 * existsGroupIdMap.entrySet()) { String k = entry.getKey(); String pId =
	 * entry.getValue(); List<GenericValue> gvlist =
	 * delegator.findByAnd("ProductFeatureAppl", UtilMisc.toMap("productId",
	 * pId)); gvlist = EntityUtil.filterByDate(gvlist); List<String> ids =
	 * EntityUtil.getFieldListFromEntityList(gvlist, "productFeatureId", true);
	 * 
	 * List<String> groupIdMap_k = groupIdMap.get(k); for (String
	 * productFeatureId : groupIdMap_k) { if (ids.contains(productFeatureId)) {
	 * ids.remove(productFeatureId); } else { GenericValue productFeatureAppl =
	 * delegator.makeValue("ProductFeatureAppl");
	 * productFeatureAppl.set("productId", pId);
	 * productFeatureAppl.set("productFeatureId", productFeatureId);
	 * productFeatureAppl.set("fromDate", nowstamp);
	 * productFeatureAppl.set("productFeatureApplTypeId", "SELECTABLE_FEATURE");
	 * productFeatureAppl.create(); } } if (ids != null && ids.size() > 0) {
	 * delegator.storeByCondition("ProductFeatureAppl",
	 * UtilMisc.toMap("thruDate", nowstamp),
	 * EntityCondition.makeCondition(UtilMisc
	 * .toList(EntityCondition.makeCondition("productId", pId),
	 * EntityCondition.makeCondition("productFeatureId", EntityOperator.IN,
	 * ids)))); } } } for (Map.Entry<String, List<String>> entry :
	 * groupIdMap.entrySet()) { String k = entry.getKey(); List<String> v =
	 * entry.getValue(); String flag = "N"; for (Map.Entry<String, String>
	 * entryExt : existsGroupIdMap.entrySet()) { String ke = entryExt.getKey();
	 * String va = entryExt.getValue(); if (k.equals(ke)) { flag = "Y"; } } if
	 * (flag.equals("N")) { StringBuilder productFeatureIdList = new
	 * StringBuilder(""); for (String pfValue : v) {
	 * productFeatureIdList.append("|" + pfValue); } ModelService pService =
	 * dispatcher.getDispatchContext().getModelService("quickAddVariant");
	 * Map<String, Object> createVariantParams = pService.makeValid(context,
	 * ModelService.IN_PARAM); createVariantParams.put("productVariantId",
	 * delegator.getNextSeqId("Product")); createVariantParams.put("productId",
	 * productId); createVariantParams.put("productFeatureIds",
	 * productFeatureIdList.toString()); Map<String,Object> orderNumMap =
	 * (Map<String,Object>) context.get("orderNumMap"); Object sequenceNumObj =
	 * orderNumMap.get(k); Long sequenceNum = null; try{ if(sequenceNumObj
	 * instanceof String) sequenceNum = Long.valueOf((String)sequenceNumObj);
	 * createVariantParams.put("sequenceNum", sequenceNum); }catch(Exception e){
	 * } Map<String, Object> resultGv = dispatcher.runSync(pService.name,
	 * createVariantParams); String vId = (String)
	 * resultGv.get("productVariantId"); GenericValue p =
	 * delegator.findOne("Product", false, UtilMisc.toMap("productId", vId));
	 * p.set("goodsNo", sequenceNum); p.store(); productFeatureIdList = null;
	 * 
	 * Object currencyUomId = context.get("currencyUomId"); // 市场价 937
	 * Map<String, Object> marketPriceMap = (Map<String, Object>)
	 * context.get("marketPriceMap"); Object marketPriceObj =
	 * marketPriceMap.get(k); if (marketPriceObj != null) { Map<String, Object>
	 * productPriceCtx = FastMap.newInstance(); productPriceCtx.put("productId",
	 * createVariantParams.get("productVariantId"));
	 * productPriceCtx.put("productPriceTypeId", "LIST_PRICE");
	 * productPriceCtx.put("fromDate", nowstamp);
	 * productPriceCtx.put("productPricePurposeId", "PURCHASE");
	 * productPriceCtx.put("currencyUomId", "USD"); if (currencyUomId != null) {
	 * productPriceCtx.put("currencyUomId", currencyUomId); }
	 * productPriceCtx.put("productStoreGroupId", "_NA_");
	 * productPriceCtx.put("price", new BigDecimal(marketPriceObj.toString()));
	 * dispatcher.runSync("createShopProductPrice", productPriceCtx); } // 成本价
	 * Map<String, Object> averageCostPriceMap = (Map<String, Object>)
	 * context.get("averageCostPriceMap"); Object averageCostPriceObj =
	 * averageCostPriceMap.get(k); if (averageCostPriceObj != null) {
	 * Map<String, Object> productPriceCtx = FastMap.newInstance();
	 * productPriceCtx.put("productId",
	 * createVariantParams.get("productVariantId"));
	 * productPriceCtx.put("productPriceTypeId", "AVERAGE_COST");
	 * productPriceCtx.put("fromDate", nowstamp);
	 * productPriceCtx.put("productPricePurposeId", "PURCHASE");
	 * productPriceCtx.put("currencyUomId", "USD"); if (currencyUomId != null) {
	 * productPriceCtx.put("currencyUomId", currencyUomId); }
	 * productPriceCtx.put("productStoreGroupId", "_NA_");
	 * productPriceCtx.put("price", new
	 * BigDecimal(averageCostPriceObj.toString()));
	 * dispatcher.runSync("createShopProductPrice", productPriceCtx); } // 零售价
	 * Map<String, Object> spPriceMap = (Map<String, Object>)
	 * context.get("spPriceMap"); Object spPriceObj = spPriceMap.get(k); if
	 * (averageCostPriceObj != null) { Map<String, Object> productPriceCtx =
	 * FastMap.newInstance(); productPriceCtx.put("productId",
	 * createVariantParams.get("productVariantId"));
	 * productPriceCtx.put("productPriceTypeId", "DEFAULT_PRICE");
	 * productPriceCtx.put("fromDate", nowstamp);
	 * productPriceCtx.put("productPricePurposeId", "PURCHASE");
	 * productPriceCtx.put("currencyUomId", "USD"); if (currencyUomId != null) {
	 * productPriceCtx.put("currencyUomId", currencyUomId); }
	 * productPriceCtx.put("productStoreGroupId", "_NA_");
	 * productPriceCtx.put("price", new BigDecimal(spPriceObj.toString()));
	 * dispatcher.runSync("createShopProductPrice", productPriceCtx); } } } } }
	 * // 图片 Map<String, String> listImg = (Map<String, String>)
	 * context.get("listImg"); Object idMap = context.get("idMap"); Map<String,
	 * Object> filePathMap = (Map<String, Object>) context.get("filePathMap");
	 * Map<String, Object> imgAlthMap = (Map<String, Object>)
	 * context.get("imgAlthMap"); Map<String, Object> imgSeqMap = (Map<String,
	 * Object>) context.get("imgSeqMap");
	 * 
	 * if (idMap != null) { for (Map.Entry<String, String> entry : ((Map<String,
	 * String>) idMap).entrySet()) { String id = entry.getKey(); String idValue
	 * = entry.getValue();
	 * 
	 * Map<String, Object> contentCtx = FastMap.newInstance();
	 * contentCtx.put("contentName", filePathMap.get(id));
	 * contentCtx.put("description", imgAlthMap.get(id));
	 * contentCtx.put("contentTypeId", "DOCUMENT"); Map<String, Object>
	 * createContentMap = dispatcher.runSync("createContent", contentCtx);
	 * Object contentId = createContentMap.get("contentId");
	 * 
	 * Map<String, Object> contentPurposeCtx = FastMap.newInstance();
	 * contentPurposeCtx.put("contentId", contentId);
	 * contentPurposeCtx.put("contentPurposeTypeId", "EB_PRODIMG_INFO");
	 * dispatcher.runSync("createContentPurpose", contentPurposeCtx);
	 * 
	 * Map<String, Object> productContentCtx = FastMap.newInstance();
	 * productContentCtx.put("contentId", contentId);
	 * productContentCtx.put("fromDate", nowstamp);
	 * productContentCtx.put("productId", productId); Object sequenceNumObj =
	 * imgSeqMap.get(id); if(sequenceNumObj!=null){
	 * productContentCtx.put("sequenceNum", Long.valueOf((String)
	 * sequenceNumObj)); } productContentCtx.put("productContentTypeId",
	 * "IMAGE"); productContentCtx.put("extendFlag", "N");
	 * 
	 * if(listImg!=null && id.equals(listImg)){
	 * productContentCtx.put("extendFlag", "Y");
	 * 
	 * Map<String, Object> productListImagetx = FastMap.newInstance();
	 * productListImagetx.put("productId", productId);
	 * productListImagetx.put("contentAssocId", contentId);
	 * productListImagetx.put("filePath", filePathMap.get(id));
	 * productListImagetx.put("description", filePathMap.get(id));
	 * productListImagetx.put("productStoreId", context.get("productStoreId"));
	 * dispatcher.runSync("createProductListImage", productListImagetx); }
	 * dispatcher.runSync("createProductContent", productContentCtx); } } //
	 * 1012 } catch (Exception e) { try {
	 * TransactionUtil.rollback(beganTransaction,
	 * "Error looking up entity values in WebTools Entity Data Maintenance", e);
	 * } catch (GenericEntityException e2) { } String errMsg =
	 * "Error creating new virtual product from variant products: " +
	 * e.toString(); Debug.logError(e, errMsg, module); } finally { try {
	 * TransactionUtil.commit(beganTransaction); } catch (GenericEntityException
	 * e2) { } } return result; }
	 */
	/**
	 * 附件处理
	 * 
	 * @param imageFolder
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static Map<String, Object> uploadFile(String imageFolder, HttpServletRequest request) throws Exception {

		Map<String, Object> context = FastMap.newInstance();
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);

		try {

			List<FileItem> items = upload.parseRequest(request);

			Iterator<FileItem> it = items.iterator();

			while (it.hasNext()) {
				FileItem fileItem = it.next();
				if (fileItem.isFormField()) {
					String fieldName = fileItem.getFieldName();
					String fieldValue = fileItem.getString("UTF-8");

					if (!context.containsKey(fieldName)) {
						context.put(fieldName, fieldValue);
					} else {
						String old = (String) context.get(fieldName);
						context.put(fieldName, old + ";" + fieldValue);
					}

				} else {

					if (fileItem.getSize() > 0) {

						String fileFullName = fileItem.getName();
						String fileName = fileFullName.substring(fileFullName.lastIndexOf("\\") + 1, fileFullName.lastIndexOf("."));
						String extendName = fileFullName.substring(fileFullName.lastIndexOf("."));
						String nowDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
						String uuid = UtilUUID.uuidTomini();
						String filePath = nowDay;
						File saveFilePath = new File(imageFolder + filePath);
						if (!saveFilePath.exists()) {
							saveFilePath.mkdirs();
						}
						filePath = filePath + "/" + uuid + extendName.toLowerCase();
						File saveFile = new File(imageFolder + filePath);
						if (!saveFile.exists()) {
							saveFile.createNewFile();
						}

						fileItem.write(saveFile);
						context.put("fileName", fileName);
						context.put("filePath", filePath);
					}

				}
			}

		} catch (Exception e) {
			Debug.log("wangyungang" + e.getMessage(), module);
			throw e;

		}

		return context;
	}

}
