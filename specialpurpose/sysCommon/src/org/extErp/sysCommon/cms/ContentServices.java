package org.extErp.sysCommon.cms;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;

import net.sf.json.JSONObject;

import org.extErp.sysCommon.content.UtilFileUpload;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class ContentServices {

	public static final String module = ContentServices.class.getName();
	public static final String LABEL_RESOURCE = "CmsUiLabels";
	private static String IMAGE_FOLDER = UtilProperties.getPropertyValue("contentUpload.properties", "content.uploadfile.article");

	/**
	 * 保存文章分类
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> createContentCategory(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		try {
			Delegator delegator = dctx.getDelegator();
			String catalogId = delegator.getNextSeqId("CmsCatalog");
			GenericValue gv = delegator.makeValue("CmsCatalog", UtilMisc.toMap("catalogId", catalogId));
			gv.setNonPKFields(context);
			gv.create();
			result.put("catalogId", catalogId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}

	/**
	 * 更新文章分类
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> updateContentCategory(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Delegator delegator = dctx.getDelegator();
		Map result = ServiceUtil.returnSuccess();
		String catalogId = (String) context.get("catalogId");
		GenericValue gv = delegator.findByPrimaryKey("CmsCatalog", UtilMisc.toMap("catalogId", catalogId));
		if (UtilValidate.isNotEmpty(gv)) {
			gv.setNonPKFields(context);
			gv.store();
		}
		return result;

	}

	/**
	 * 删除文章分类
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> deleteContentCategory(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = ServiceUtil.returnSuccess();
		Delegator delegator = dctx.getDelegator();
		String catalogId = (String) context.get("catalogId");
		GenericValue gv = delegator.findByPrimaryKey("CmsCatalog", UtilMisc.toMap("catalogId", catalogId));
		if (UtilValidate.isNotEmpty(gv)) {
			gv.remove();
		}
		// ShopUtil.returnAjaxInfo(result, context);
		return result;
	}

	/**
	 * 批量删除文章分类
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> deleteContentCategoryAll(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = ServiceUtil.returnSuccess();
		try {
			Delegator delegator = dctx.getDelegator();
			String orderIndexs = (String) context.get("orderIndexs");
			if (orderIndexs != null && orderIndexs.length() > 0) {
				String[] catalogId = orderIndexs.split(",");
				for (int i = 0; i < catalogId.length; i++) {

					GenericValue gv = delegator.findByPrimaryKey("CmsCatalog", UtilMisc.toMap("catalogId", catalogId[i]));
					if (UtilValidate.isNotEmpty(gv)) {
						gv.remove();
					}
				}
			}
		} catch (Exception e) {
			// e.printStackTrace();
		}

		return result;
	}

	/**
	 * 保存广告
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> createAdvertise(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();
		String adId = delegator.getNextSeqId("CmsAdvertise");
		GenericValue gv = delegator.makeValue("CmsAdvertise", UtilMisc.toMap("adId", adId));
		gv.setNonPKFields(context);
		gv.create();
		result.put("adId", adId);
		/*
		 * String advertiseImgId = delegator.getNextSeqId("CmsAdvertiseImg");
		 * GenericValue img = delegator.makeValue("CmsAdvertiseImg",
		 * UtilMisc.toMap("advertiseImgId", advertiseImgId));
		 * img.setNonPKFields(context); img.create();
		 */
		insOrUpdAdvertiseImg(delegator, context);
		return result;

	}

	/**
	 * 保存广告图片
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> createAdvertiseImg(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();

		// delegator.removeByCondition("CmsAdvertiseImg",
		// EntityCondition.makeCondition("adId", context.get("adId")));

		String advertiseImgId = delegator.getNextSeqId("CmsAdvertiseImg");
		GenericValue img = delegator.makeValue("CmsAdvertiseImg", UtilMisc.toMap("advertiseImgId", advertiseImgId));
		img.setNonPKFields(context);
		img.create();
		result.put("advertiseImgId", advertiseImgId);
		insOrUpdAdvertiseImg(delegator, context);
		return result;

	}

	public static void insOrUpdAdvertiseImg(Delegator delegator, Map<String, ? extends Object> context) {
		Object imgUrl = context.get("imgUrl");
		System.out.println(imgUrl);
	}

	/**
	 * 更新广告
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> updateAdvertise(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();
		String articleId = (String) context.get("adId");
		GenericValue gv = delegator.findByPrimaryKey("CmsAdvertise", UtilMisc.toMap("adId", articleId));
		if (UtilValidate.isNotEmpty(gv)) {
			gv.setNonPKFields(context);
			gv.store();
		}
		return result;
	}

	/**
	 * 更新广告图片
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> updateAdvertiseImg(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();
		String advertiseImgId = (String) context.get("advertiseImgId");
		GenericValue gv = delegator.findByPrimaryKey("CmsAdvertiseImg", UtilMisc.toMap("advertiseImgId", advertiseImgId));
		if (UtilValidate.isNotEmpty(gv)) {
			gv.setNonPKFields(context);
			gv.store();
		}
		return result;
	}

	/**
	 * 删除广告
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
	public static Map<String, Object> deleteAdvertise(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();
		String articleId = (String) context.get("adId");
		try {
			List<EntityExpr> exprs = FastList.newInstance();
			exprs.add(EntityCondition.makeCondition("adId", EntityOperator.EQUALS, articleId));
			EntityFindOptions opts = new EntityFindOptions();
			opts.setMaxRows(6);
			opts.setFetchSize(6);
			List<GenericValue> list = delegator.findList("CmsAdvertiseImg", EntityCondition.makeCondition(exprs, EntityOperator.AND), null, null, opts, false);
			if (list.size() != 0) {
				for (GenericValue imgGv : list) {
					imgGv.remove();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		GenericValue gv = delegator.findByPrimaryKey("CmsAdvertise", UtilMisc.toMap("adId", articleId));
		if (UtilValidate.isNotEmpty(gv)) {
			gv.remove();
		}
		return result;
	}

	public static Map<String, Object> deleteAdvertiseImg(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map result = new HashMap();
		Delegator delegator = dctx.getDelegator();
		String advertiseImgId = (String) context.get("advertiseImgId");
		try {
			List<EntityExpr> exprs = FastList.newInstance();
			exprs.add(EntityCondition.makeCondition("advertiseImgId", EntityOperator.EQUALS, advertiseImgId));
			EntityFindOptions opts = new EntityFindOptions();
			opts.setMaxRows(1);
			opts.setFetchSize(1);
			List<GenericValue> list = delegator.findList("CmsAdvertiseImg", EntityCondition.makeCondition(exprs, EntityOperator.AND), null, null, opts, false);
			if (list.size() != 0) {
				for (GenericValue imgGv : list) {
					imgGv.remove();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	/**
	 * 附件上传
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String uploadImage(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		try {
			IMAGE_FOLDER = request.getRealPath("/")+"images\\";
			Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
			//toJsonObject(UtilMisc.toMap("err", "", "msg", UtilMisc.toMap("url", request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/images/" + context.get("filePath"), "localname", context.get("fileName"), "id", "1")), response);
			toJsonObject(UtilMisc.toMap("err", "", "msg", UtilMisc.toMap("url",request.getContextPath() + "/images/" + context.get("filePath"), "localname", context.get("fileName"), "id", "1")), response);

		} catch (Exception e) {
			Debug.logError("wangyungang" + e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}
		return ModelService.RESPOND_SUCCESS;
	}

	/**
	 * 新增文章时附件处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String createContent(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		try {
			Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
			context.put("contentImg", context.get("filePath"));
			context.put("userLogin", userLogin);
			ModelService pService = dispatcher.getDispatchContext().getModelService("createCmsArticle");
			context = pService.makeValid(context, ModelService.IN_PARAM);
			dispatcher.runSync(pService.name, context);

			toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindContent"), response);

		} catch (Exception e) {
			Debug.logError("wangyungang" + e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}
		return ModelService.RESPOND_SUCCESS;
	}

	/**
	 * 修改文章时附件处理
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	public static String updateCmsArticle(HttpServletRequest request, HttpServletResponse response) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		try {
			Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
			context.put("contentImg", context.get("filePath"));
			context.put("userLogin", userLogin);
			ModelService pService = dispatcher.getDispatchContext().getModelService("updateCmsArticle");
			context = pService.makeValid(context, ModelService.IN_PARAM);
			dispatcher.runSync(pService.name, context);
			toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindContent"), response);

		} catch (Exception e) {
			Debug.logError(e.getMessage(), module);
			return ModelService.RESPOND_ERROR;
		}

		return ModelService.RESPOND_SUCCESS;
	}

	public static void toJsonObject(Map attrMap, HttpServletResponse response) {
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
}
