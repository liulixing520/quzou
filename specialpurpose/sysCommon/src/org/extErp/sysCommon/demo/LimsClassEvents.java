
package org.extErp.sysCommon.demo;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.extErp.sysCommon.document.DocumentHelper;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class LimsClassEvents
{
    public static final String module = LimsClassEvents.class.getName();
    public static final String DCT_PPS = "LimsClass";// 需要维护种子数据到Syscdoc下

    /**
     * 
     * createLimsClass(附件上传)<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String createLimsClass(HttpServletRequest request, HttpServletResponse response)
    {

	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	boolean beganTransaction = false;
	try
	{
	    beganTransaction = TransactionUtil.begin();
	    Map<String, Object> entityMap = FastMap.newInstance();
	    String relatedIdValue = delegator.getNextSeqId("LimsClass");
	    // 上传资源并生成关联
	    Map<String, Object> uploadMap = DocumentHelper.uploadSysDocByPurpose(request, DCT_PPS, relatedIdValue);
	    if (ServiceUtil.isError(uploadMap))
	    {
		throw new Exception(ServiceUtil.getErrorMessage(uploadMap));
	    }
	    // 回写到实体
	    ModelService pService = dispatcher.getDispatchContext().getModelService("createLimsClass");
	    entityMap = pService.makeValid(uploadMap, ModelService.IN_PARAM);
	    entityMap.put("userLogin", userLogin);
	    entityMap.put("classId", relatedIdValue);
	    dispatcher.runSync(pService.name, entityMap);

	} catch (Exception e)
	{
	    try
	    {
		TransactionUtil.rollback(beganTransaction, e.getLocalizedMessage(), e);
	    } catch (GenericTransactionException e1)
	    {
		e1.printStackTrace();
	    }
	    Debug.logError(e, e.getLocalizedMessage(), module);
	} finally
	{
	    try
	    {
		TransactionUtil.commit(beganTransaction);
	    } catch (GenericTransactionException e)
	    {
		e.printStackTrace();
	    }
	}
	return ModelService.RESPOND_SUCCESS;
    }
    /**
     * 
     * updateLimsClass(附件上传)<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String updateLimsClass(HttpServletRequest request, HttpServletResponse response)
    {

	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");

	boolean beganTransaction = false;
	try
	{
	    beganTransaction = TransactionUtil.begin();

	    Map<String, Object> uploadResult = DocumentHelper.uploadSysDocByPurpose(request, DCT_PPS, null);// 更新的时候,不需要当前实体主键传入,会从表单中自动获取
	    if (UtilValidate.isEmpty(uploadResult))
	    {
		Debug.logError("上传文件失败", module);
		return "error";
	    }

	    uploadResult.put("userLogin", userLogin);
	    ModelService pService = dispatcher.getDispatchContext().getModelService("updateLimsClass");
	    uploadResult = pService.makeValid(uploadResult, ModelService.IN_PARAM);
	    dispatcher.runSync(pService.name, uploadResult);
	} catch (Exception e)
	{
	    try
	    {
		TransactionUtil.rollback(beganTransaction, e.getLocalizedMessage(), e);
	    } catch (GenericTransactionException e1)
	    {
		e1.printStackTrace();
	    }
	    Debug.logError(e, e.getLocalizedMessage(), module);
	} finally
	{
	    try
	    {
		TransactionUtil.commit(beganTransaction);
	    } catch (GenericTransactionException e)
	    {
		e.printStackTrace();
	    }
	}
	return ModelService.RESPOND_SUCCESS;
    }

    /**
     * 
     * importLimsClass(excel上传)<br/>
     * 
     * @param request
     * @param response
     * @return
     */
    public static String importLimsClass(HttpServletRequest request, HttpServletResponse response)
    {

	LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
	GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	boolean beganTransaction = false;

	try
	{
	    beganTransaction = TransactionUtil.begin();
	    List<Map> entityList = org.extErp.sysCommon.util.OfbizExtUtil.importExcel(request, UtilMisc.toList("className,classTeacher,sortNo"));
	    for (int i = 0; i < entityList.size(); i++)
	    {
		Map<String, Object> entityMap = FastMap.newInstance();
		entityMap.putAll(entityList.get(i));
		ModelService pService = dispatcher.getDispatchContext().getModelService("createLimsClass");
		entityMap = pService.makeValid(entityMap, ModelService.IN_PARAM);
		entityMap.put("userLogin", userLogin);
		dispatcher.runSync(pService.name, entityMap);
	    }

	} catch (Exception e)
	{
	    try
	    {
		TransactionUtil.rollback(beganTransaction, e.getLocalizedMessage(), e);
	    } catch (GenericTransactionException e1)
	    {
		e1.printStackTrace();
	    }
	    request.setAttribute("_ERROR_MESSAGE_", "导入失败，请检查是否有重复");
	    return ModelService.RESPOND_ERROR;
	} finally
	{
	    try
	    {
		TransactionUtil.commit(beganTransaction);
	    } catch (GenericTransactionException e)
	    {
		e.printStackTrace();
	    }
	}
	return ModelService.RESPOND_SUCCESS;
    }
}
