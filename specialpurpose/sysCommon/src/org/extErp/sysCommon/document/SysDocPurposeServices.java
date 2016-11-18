/**
 * <b>项目名：</b>ofbiz_lims<br/>
 * <b>包名：</b>org.ofbiz.sysCommon.document<br/>
 * <b>文件名：</b>SysDocPurposeServices.java<br/>
 * <b>日期：</b>2013-1-29-下午4:25:26<br/>
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
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

/**
 * 
 * <b>类名称：</b>SysDocPurposeServices<br/>
 * <b>类描述：</b>〈一句话功能简述〉<br/>
 * <b>类详细描述：</b>〈功能详细描述〉<br/>
 * <b>创建人：</b>Administrator<br/>
 * <b>修改人：</b>Administrator<br/>
 * <b>修改时间：</b>2013-1-29 下午4:25:26<br/>
 * <b>修改备注：</b><br/>
 * 
 * @version <br/>
 * 
 */
public class SysDocPurposeServices
{
    public static final String module = SysDocPurposeServices.class.getName();
    public static final String resource = "DocumentUiLabels";
    public static final String resourceError = "DocumentErrorUiLabels";

    /**
     * 创建数据
     * 
     * Create a SysDocPurpose. If no sysDocPurposeId is specified a
     * numeric sysDocPurposeId is retrieved from the SysDocPurpose
     * sequence.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> createSysDocPurpose(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");
        GenericValue gv = null;

        if (result.size() > 0)
            return result;

        String sysDocPurposeId = null;
        try
        {
            sysDocPurposeId = delegator.getNextSeqId("SysDocPurpose");
        } catch (IllegalArgumentException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "appliance.id_generation_failure", locale));
        }

        gv = delegator.makeValue("SysDocPurpose", UtilMisc.toMap("sysDocPurposeId", sysDocPurposeId));
        gv.setNonPKFields(context);
        if (gv.containsKey("fromDate"))
        {
            gv.set("fromDate", UtilDateTime.nowTimestamp());
        }

        try
        {
            gv.create();
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "appliance.create_failure", locale));
        }

        if (gv != null)
        {
            result.put("sysDocPurposeId", sysDocPurposeId);
        }
        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 更新数据
     * 
     * update a SysDocPurpose.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> updateSysDocPurpose(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        String sysDocPurposeId = (String) context.get("sysDocPurposeId");
        GenericValue gv = null;

        try
        {
            gv = delegator.findOne("SysDocPurpose", false, UtilMisc.toMap("sysDocPurposeId", sysDocPurposeId));
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocPurpose.find_failure", locale));
        }
        if (gv != null)
        {
            gv.setNonPKFields(context);
            try
            {
                gv.store();
                result.put("sysDocPurposeId", sysDocPurposeId);
            } catch (GenericEntityException e)
            {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocPurpose.update_failure", locale));
            }
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 删除数据
     * 
     * delete a SysDocPurpose.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> deleteSysDocPurpose(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        String sysDocPurposeId = (String) context.get("sysDocPurposeId");
        GenericValue gv = null;
        try
        {
            gv = delegator.findOne("SysDocPurpose", false, UtilMisc.toMap("sysDocPurposeId", sysDocPurposeId));
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocPurpose.find_failure", locale));
        }
        if (UtilValidate.isNotEmpty(gv))
        {
            try
            {
                gv.remove();
            } catch (GenericEntityException e)
            {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocPurpose.delete_failure", locale));
            }
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }
}
