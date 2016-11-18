/**
 * <b>项目名：</b>ofbiz_lims<br/>
 * <b>包名：</b>org.ofbiz.sysCommon.document<br/>
 * <b>文件名：</b>SysDocRefServices.java<br/>
 * <b>日期：</b>2013-1-29-下午4:33:32<br/>
 * <b>Copyright 2012-2015 北京远航科峰软件技术有限公司. All Rights Reserved.<br/>
 *
 */
package org.extErp.sysCommon.document;

import java.util.Locale;
import java.util.Map;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

/**
 * 
 * <b>类名称：</b>SysDocRefServices<br/>
 * <b>类描述：</b>〈一句话功能简述〉<br/>
 * <b>类详细描述：</b>〈功能详细描述〉<br/>
 * <b>创建人：</b>Administrator<br/>
 * <b>修改人：</b>Administrator<br/>
 * <b>修改时间：</b>2013-1-29 下午4:33:32<br/>
 * <b>修改备注：</b><br/>
 * 
 * @version <br/>
 * 
 */
public class SysDocRefServices
{
    public static final String module = SysDocRefServices.class.getName();
    public static final String resource = "DocumentUiLabels";
    public static final String resourceError = "DocumentErrorUiLabels";

    /**
     * 创建数据
     * 
     * Create a SysDocRef.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> createSysDocRef(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");
        GenericValue gv = null;

        if (result.size() > 0)
            return result;

        String sysDocRefId = null;
        try
        {
            sysDocRefId = delegator.getNextSeqId("SysDocRef");
        } catch (IllegalArgumentException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocRef.id_generation_failure", locale));
        }
        gv = delegator.makeValue("SysDocRef", UtilMisc.toMap("sysDocRefId", sysDocRefId));
        gv.setNonPKFields(context);
        gv.set("fromDate", UtilDateTime.nowTimestamp());

        try
        {
            gv.create();
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "sysdocref.create_failure", locale));
        }
        if (gv != null)
        {
            result.put("sysDocRefId", sysDocRefId);
        }
        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 更新数据
     * 
     * update a SysDocRef.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> updateSysDocRef(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        GenericValue gv = null;

        try
        {
            String sysDocRefId = (String) context.get("sysDocRefId");
            gv = delegator.findOne("SysDocRef", UtilMisc.toMap("sysDocRefId", sysDocRefId), false);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "sysdocref.find_failure", locale));
        }
        if (gv != null)
        {
            gv.setNonPKFields(context);
            try
            {
                gv.store();
            } catch (GenericEntityException e)
            {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "sysdocref.update_failure", locale));
            }
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 删除数据
     * 
     * delete a SysDocRef.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> deleteSysDocRef(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        GenericValue gv = null;
        try
        {
            String sysDocRefId = (String) context.get("sysDocRefId");

            gv = delegator.findOne("SysDocRef", UtilMisc.toMap("sysDocRefId", sysDocRefId), false);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "sysdocref.find_failure", locale));
        }
        if (UtilValidate.isNotEmpty(gv))
        {
            try
            {
                gv.remove();
            } catch (GenericEntityException e)
            {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "sysdocref.delete_failure", locale));
            }
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 过期数据
     * 
     * update a SysDocSource.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> deactivateSysDocRef(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        LocalDispatcher dispatcher = dctx.getDispatcher();
        Locale locale = (Locale) context.get("locale");

        ModelService modelService = null;
        try
        {
            modelService = dispatcher.getDispatchContext().getModelService("updateSysDocRef");
        } catch (GenericServiceException e)
        {
            Debug.logError("Error getting model service for serviceName, 'updateSysDocRef'. " + e.toString(), module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "error_modelservice_for_srv_name", locale));
        }
        Map<String, Object> inMap = modelService.makeValid(context, ModelService.IN_PARAM);
        inMap.put("thruDate", UtilDateTime.nowTimestamp());

        return updateSysDocRef(dctx, inMap);
    }

    /**
     * deactivateSysDocRefIfExists<br/>
     * 按照sysDocPurposeId,relatedIdValue查询,如果有这条记录,则使之过期<br/>
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> deactivateSysDocRefIfExists(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        if (result.size() > 0)
        {
            return result;
        }

        String sysDocPurposeId = (String) context.get("sysDocPurposeId");
        String relatedIdValue = (String) context.get("relatedIdValue");

        GenericValue tempVal = DocumentWorkers.findSysDocRef(sysDocPurposeId, relatedIdValue, delegator);
        if (tempVal != null)
        {
            Map<String, Object> deactivateSdrCtx = FastMap.newInstance();
            deactivateSdrCtx.put("sysDocRefId", tempVal.getString("sysDocRefId"));
            deactivateSdrCtx.put("userLogin", context.get("userLogin"));
            try
            {
                Map<String, Object> deactivateSdrResult = dctx.getDispatcher().runSync("deactivateSysDocRef", deactivateSdrCtx);
                if (ServiceUtil.isError(deactivateSdrResult))
                {
                    return deactivateSdrResult;
                }
            } catch (GenericServiceException e)
            {
                Debug.logWarning(e.getMessage(), module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "error_modelservice_for_srv_name", locale));
            }
        }
        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    public static Map<String, Object> reBuildSysDocRef(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        // 如果原来有这个实体同用途的关联,则过期掉
        try
        {
            Map<String, Object> deactivateSysDocRefIfExistscontext = FastMap.newInstance();
            deactivateSysDocRefIfExistscontext.put("sysDocPurposeId", context.get("sysDocPurposeId"));
            deactivateSysDocRefIfExistscontext.put("relatedIdValue", context.get("relatedIdValue"));
            deactivateSysDocRefIfExistscontext.put("userLogin", context.get("userLogin"));

            ModelService deactivateSysDocRefIfExistsService = dispatcher.getDispatchContext().getModelService("deactivateSysDocRefIfExists");
            deactivateSysDocRefIfExistscontext = deactivateSysDocRefIfExistsService.makeValid(deactivateSysDocRefIfExistscontext, ModelService.IN_PARAM);

            dispatcher.runSync(deactivateSysDocRefIfExistsService.name, deactivateSysDocRefIfExistscontext);
        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError(e.getMessage());
        }

        // 创建新的实体关联
        try
        {
            Map<String, Object> createSysDocRefcontext = FastMap.newInstance();
            createSysDocRefcontext.put("sysDocSourceId", context.get("sysDocSourceId"));
            createSysDocRefcontext.put("sysDocPurposeId", context.get("sysDocPurposeId"));
            createSysDocRefcontext.put("relatedIdValue", context.get("relatedIdValue"));
            createSysDocRefcontext.put("userLogin", context.get("userLogin"));

            ModelService createSysDocRefService = dispatcher.getDispatchContext().getModelService("createSysDocRef");
            createSysDocRefcontext = createSysDocRefService.makeValid(createSysDocRefcontext, ModelService.IN_PARAM);

            Map<String, Object> createSysDocRef = dispatcher.runSync(createSysDocRefService.name, createSysDocRefcontext);
            if (ServiceUtil.isSuccess(createSysDocRef))
            {
                result.put("sysDocRefId", createSysDocRef.get("sysDocRefId"));
            }
        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError(e.getMessage());
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }
}
