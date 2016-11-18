
package org.extErp.sysCommon.system;

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

public class DesignFormServices
{
    public static final String module = DesignFormServices.class.getName();
    public static final String resource = "SystemUiLabels";
    public static final String resourceError = "SystemErrorUiLabels";

    /**
     * 创建数据
     * 
     * Create a DesignForm. If no designFormId is specified a numeric
     * designFormId is retrieved from the DesignForm sequence.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> createDesignForm(DispatchContext dctx, Map<String, ? extends Object> context)
    {
	Map<String, Object> result = FastMap.newInstance();
	Delegator delegator = dctx.getDelegator();
	Locale locale = (Locale) context.get("locale");
	GenericValue gv = null;

	if (result.size() > 0)
	    return result;

	String designFormId = null;
	try
	{
	    if (UtilValidate.isNotEmpty(context.get("designFormId")))
	    {
		designFormId = context.get("designFormId").toString();
	    } else
	    {
		designFormId = delegator.getNextSeqId("DesignForm");
	    }
	} catch (IllegalArgumentException e)
	{
	    Debug.logError(e, module);
	    return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "designform.id_generation_failure", locale));
	}

	gv = delegator.makeValue("DesignForm", UtilMisc.toMap("designFormId", designFormId));
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
	    return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "designform.create_failure", locale));
	}

	if (gv != null)
	{
	    result.put("designFormId", designFormId);
	}
	result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
	return result;
    }

    /**
     * 更新数据
     * 
     * update a DesignForm.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> updateDesignForm(DispatchContext dctx, Map<String, ? extends Object> context)
    {
	Map<String, Object> result = FastMap.newInstance();
	Delegator delegator = dctx.getDelegator();
	Locale locale = (Locale) context.get("locale");

	String designFormId = (String) context.get("designFormId");
	GenericValue gv = null;

	try
	{
	    gv = delegator.findOne("DesignForm", false, UtilMisc.toMap("designFormId", designFormId));
	} catch (GenericEntityException e)
	{
	    Debug.logError(e, module);
	    return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "designform.find_failure", locale));
	}
	if (gv != null)
	{
	    gv.setNonPKFields(context);
	    try
	    {
		gv.store();
		result.put("designFormId", designFormId);
	    } catch (GenericEntityException e)
	    {
		Debug.logError(e, module);
		return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "designform.update_failure", locale));
	    }
	}

	result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
	return result;
    }

    /**
     * 删除数据
     * 
     * delete a DesignForm.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> deleteDesignForm(DispatchContext dctx, Map<String, ? extends Object> context)
    {
	Map<String, Object> result = FastMap.newInstance();
	Delegator delegator = dctx.getDelegator();
	Locale locale = (Locale) context.get("locale");

	String designFormId = (String) context.get("designFormId");
	GenericValue gv = null;
	try
	{
	    gv = delegator.findOne("DesignForm", false, UtilMisc.toMap("designFormId", designFormId));
	} catch (GenericEntityException e)
	{
	    Debug.logError(e, module);
	    return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "designform.find_failure", locale));
	}
	if (UtilValidate.isNotEmpty(gv))
	{
	    try
	    {
		gv.remove();
	    } catch (GenericEntityException e)
	    {
		Debug.logError(e, module);
		return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "designform.delete_failure", locale));
	    }
	}

	result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
	return result;
    }
}
