package org.ofbiz.quzou;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class QzCompetitionServices {
	public static final String module = QzCompetitionServices.class.getName();
	public static final String resource = "quzouUiLabels";
	public static final String resourceError = "quzouErrorUiLabels";

	/**
	 * 创建数据
	 * 
	 * Create a MemberBase. If no memberId is specified a numeric memberId is
	 * retrieved from the MemberBase sequence.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static Map<String, Object> createQzCompetition(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		GenericValue userLogin = (GenericValue)context.get("userLogin");
		GenericValue gv = null;

		if (result.size() > 0)
			return result;

		String cId = null;
		try {
			if (UtilValidate.isNotEmpty(context.get("cId"))) {
				cId = context.get("cId").toString();
			} else {
				cId = delegator.getNextSeqId("QzCompetition");
			}
		} catch (IllegalArgumentException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCompetition.id_generation_failure", locale));
		}

		gv = delegator.makeValue("QzCompetition", UtilMisc.toMap("cId", cId));
		gv.setNonPKFields(context);
		
		/**上传图片**/
		Map<String, Object> map = FastMap.newInstance();
		map.put("mediumFile", context.get("mediumFile"));
		map.put("_mediumFile_fileName", context.get("_mediumFile_fileName"));
		map.put("mediumFileBase64", context.get("mediumFileBase64"));
		map.put("userLogin", userLogin);
		Map<String, Object> rsMap = FastMap.newInstance();
		try {
			rsMap = dispatcher.runSync("uploadedFileSimple", map);
		} catch (GenericServiceException e1) {
			e1.printStackTrace();
		}
		gv.set("cPic", rsMap.get("imagePath"));
		gv.set("status", "0");
		gv.set("isShow", "0");//默认首页不展示
		gv.set("publishDate", UtilDateTime.nowTimestamp());
		try {
			gv.create();
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCompetition.create_failure", locale));
		}

		if (gv != null) {
			result.put("cId", cId);
		}
		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}

	/**
	 * 更新数据
	 * 
	 * update a MemberBase.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static Map<String, Object> updateQzCompetition(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		LocalDispatcher dispatcher = dctx.getDispatcher();
		GenericValue userLogin = (GenericValue)context.get("userLogin");

		String cId = (String) context.get("cId");
		GenericValue gv = null;

		try {
			gv = delegator.findOne("QzCompetition", false, UtilMisc.toMap("cId", cId));
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCompetition.find_failure", locale));
		}
		/**上传图片**/
		Map<String, Object> map = FastMap.newInstance();
		map.put("mediumFile", context.get("mediumFile"));
		map.put("_mediumFile_fileName", context.get("_mediumFile_fileName"));
		map.put("mediumFileBase64", context.get("mediumFileBase64"));
		map.put("userLogin", userLogin);
		Map<String, Object> rsMap = FastMap.newInstance();
		try {
			rsMap = dispatcher.runSync("uploadedFileSimple", map);
		} catch (GenericServiceException e1) {
			e1.printStackTrace();
		}
		if(UtilValidate.isNotEmpty(rsMap.get("imagePath"))){
			gv.set("cPic", rsMap.get("imagePath"));
		}
		if (gv != null) {
			gv.setNonPKFields(context);
			try {
				gv.store();
				// result.put("memberId", memberId);
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
				return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCompetition.update_failure", locale));
			}
		}
		

		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}
	
	/**
	 * 批量修改赛事
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> updateBatchCompetition(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		try {
			List<String> idList = StringUtil.split((String) context.get("ids"), ",");
			for (int i = 0; i < idList.size(); i++) {
				Map<String, Object> map=FastMap.newInstance();
				ModelService pService = dispatcher.getDispatchContext().getModelService("updateQzCompetition");
				map = pService.makeValid(context,ModelService.IN_PARAM);
				map.put("cId", idList.get(i));
				map.put("userLogin", userLogin);
				dispatcher.runSync("updateQzCompetition", map);
			}
		} catch (Exception e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCompetition.delete_failure", locale));
		}

		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}

	/**
	 * 删除数据
	 * 
	 * delete a MemberBase.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static Map<String, Object> deleteQzCompetition(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		Locale locale = (Locale) context.get("locale");

		String cId = (String) context.get("cId");
		GenericValue gv = null;

		try {
			gv = delegator.findOne("QzCompetition", false, UtilMisc.toMap("cId", cId));
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCompetition.find_failure", locale));
		}
		if (UtilValidate.isNotEmpty(gv)) {
			try {
				gv.put("thruDate", UtilDateTime.nowTimestamp());
				gv.store();
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
				return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCompetition.delete_failure", locale));
			}
		}

		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}

	/**
	 * 批量删除数据
	 * 
	 * delete a MemberBase.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static Map<String, Object> deleteAllQzCompetition(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		try {
			List<String> idList = StringUtil.split((String) context.get("ids"), ",");
			for (int i = 0; i < idList.size(); i++) {
				dispatcher.runSync("deleteQzCompetition", UtilMisc.toMap("cId", idList.get(i), "userLogin", userLogin));
			}
		} catch (Exception e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "QzCompetition.delete_failure", locale));
		}

		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}
	
	/**定时任务，每天都会去修改状态为已开始或已结束
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> updateCompeStatus(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		LocalDispatcher dispatcher = dctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		List<EntityExpr> cdtList = UtilMisc.toList(
                EntityCondition.makeCondition("startDate", EntityOperator.EQUALS, new java.sql.Date(UtilDateTime.getDayStart(UtilDateTime.nowTimestamp()).getTime()))
                );
		
		try {
			List<GenericValue> list = delegator.findList("QzCompetition", EntityCondition.makeCondition(cdtList), null, null, null, false);
			for (GenericValue gv : list) {
				gv.set("status", "1");
			}
			delegator.storeAll(list);
		} catch (GenericEntityException e) {
			e.printStackTrace();
		}

		List<EntityExpr> cdtList2 = UtilMisc.toList(
                EntityCondition.makeCondition("endDate", EntityOperator.EQUALS, new java.sql.Date(UtilDateTime.getDayStart(UtilDateTime.nowTimestamp()).getTime()))
                );
		
		try {
			List<GenericValue> list = delegator.findList("QzCompetition", EntityCondition.makeCondition(cdtList2), null, null, null, false);
			for (GenericValue gv : list) {
				gv.set("status", "2");
			}
			delegator.storeAll(list);
		} catch (GenericEntityException e) {
			e.printStackTrace();
		}
		result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
		return result;
	}
	
	
}
