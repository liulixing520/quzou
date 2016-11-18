package org.extErp.sysCommon.party;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastMap;

import org.extErp.sysCommon.content.UtilFileUpload;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.base.util.string.FlexibleStringExpander;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;


public class PartyEvents
{
    public static final String module = PartyEvents.class.getName();
    private static final String OFBIZ_HOME_PATH = System.getProperty("ofbiz.home");

    /**
     * 保存系统用户
     * 
     * @param request
     * @param response
     * @return
     */
    public static String createPersonExt(HttpServletRequest request, HttpServletResponse response)
    {
	HttpSession session = request.getSession();
	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
	boolean beganTransaction = false;// 事务处理
	try
	{
	    beganTransaction = TransactionUtil.begin();
	    Map<String, Object> context = FastMap.newInstance();
	    
	    context.put("locale", request.getLocale());
	    String path = FlexibleStringExpander.expandString(UtilProperties.getPropertyValue("lims.properties", "original.record.template.server.path"), context);
	    Map<String, Object> paramMap = UtilFileUpload.uploadFile(OFBIZ_HOME_PATH + path, request);
	    ModelService modelService = dispatcher.getDispatchContext().getModelService("createPersonExt");
	    Map<String, Object> personMap = modelService.makeValid(paramMap, ModelService.IN_PARAM);
	    personMap.put("userLogin", userLogin);
	    if (UtilValidate.isNotEmpty(paramMap.get("filePath")))
	    {
		String urlPath = FlexibleStringExpander.expandString(UtilProperties.getPropertyValue("lims.properties", "original.record.template.url.prefix"), context);
		personMap.put("ufmFilePath", urlPath + paramMap.get("filePath"));
	    }
	    Map<String, Object> personResult = dispatcher.runSync("createPersonExt", personMap);
	    TransactionUtil.commit(beganTransaction);
	} catch (Exception e)
	{
	    e.printStackTrace();
	    try
	    {
		TransactionUtil.rollback(beganTransaction, "", e);
	    } catch (GenericTransactionException e1)
	    {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	    }
	    ServiceUtil.setMessages(request, "添加失败", null, null);
	}

	return "success";
    }

    /**
     * 编辑系统用户
     * 
     * @param request
     * @param response
     * @return
     */
    public static String updatePersonExt(HttpServletRequest request, HttpServletResponse response)
    {
	HttpSession session = request.getSession();
	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
	boolean beganTransaction = false;// 事务处理
	try
	{
	    beganTransaction = TransactionUtil.begin();
	    Map<String, Object> context = FastMap.newInstance();
	    context.put("locale", request.getLocale());
	    String path = FlexibleStringExpander.expandString(UtilProperties.getPropertyValue("lims.properties", "original.record.template.server.path"), context);
	    Map<String, Object> paramMap = UtilFileUpload.uploadFile(OFBIZ_HOME_PATH + path, request);
	    ModelService modelService = dispatcher.getDispatchContext().getModelService("updatePersonExt");
	    Map<String, Object> personMap = modelService.makeValid(paramMap, ModelService.IN_PARAM);
	    personMap.put("userLogin", userLogin);
	    if (UtilValidate.isNotEmpty(paramMap.get("filePath")))
	    {
		String urlPath = FlexibleStringExpander.expandString(UtilProperties.getPropertyValue("lims.properties", "original.record.template.url.prefix"), context);
		personMap.put("ufmFilePath", urlPath + paramMap.get("filePath"));
	    }
	    Map<String, Object> personResult = dispatcher.runSync("updatePersonExt", personMap);
	    TransactionUtil.commit(beganTransaction);
	} catch (Exception e)
	{
	    e.printStackTrace();
	    try
	    {
		TransactionUtil.rollback(beganTransaction, "", e);
	    } catch (GenericTransactionException e1)
	    {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	    }
	    ServiceUtil.setMessages(request, "编辑失败", null, null);
	}

	return "success";
    }
}
