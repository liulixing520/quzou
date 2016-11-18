/**
 * <b>项目名：</b>ofbiz_lims<br/>
 * <b>包名：</b>org.ofbiz.sysCommon.document<br/>
 * <b>文件名：</b>SysDocSourceServices.java<br/>
 * <b>日期：</b>2013-1-29-上午11:27:40<br/>
 * <b>Copyright 2012-2015 北京远航科峰软件技术有限公司. All Rights Reserved.<br/>
 *
 */
package org.extErp.sysCommon.document;

import java.util.Locale;
import java.util.Map;

import javolution.util.FastMap;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;
import org.extErp.sysCommon.content.UtilFileUpload;
import org.ofbiz.base.util.Debug;
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
 * <b>类名称：</b>SysDocSourceServices<br/>
 * <b>类描述：</b>文档服务的java实现<br/>
 * <b>类详细描述：</b>文档类型的实体的CRUD<br/>
 * <b>创建人：</b>WangYi<br/>
 * <b>修改人：</b>WangYi<br/>
 * <b>修改时间：</b>2013-1-29 上午11:27:40<br/>
 * <b>修改备注：</b><br/>
 * 
 * @version 1.0<br/>
 * 
 */
public class SysDocSourceServices
{
    public static final String module = SysDocSourceServices.class.getName();
    public static final String resource = "DocumentUiLabels";
    public static final String resourceError = "DocumentErrorUiLabels";

    /**
     * 创建数据
     * 
     * Create a SysDocSource. If no sysDocSourceId is specified a
     * numeric sysDocSourceId is retrieved from the SysDocSource
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
    public static Map<String, Object> createSysDocSource(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");
        GenericValue gv = null;

        if (result.size() > 0)
            return result;

        String sysDocSourceId = null;
        try
        {
            sysDocSourceId = delegator.getNextSeqId("SysDocSource");
        } catch (IllegalArgumentException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocSource.id_generation_failure", locale));
        }

        gv = delegator.makeValue("SysDocSource", UtilMisc.toMap("sysDocSourceId", sysDocSourceId));
        gv.setNonPKFields(context);

        try
        {
            gv.create();
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocSource.create_failure", locale));
        }

        if (gv != null)
        {
            result.put("sysDocSourceId", sysDocSourceId);
        }
        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 更新数据
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
    public static Map<String, Object> updateSysDocSource(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        String sysDocSourceId = (String) context.get("sysDocSourceId");
        GenericValue gv = null;

        try
        {
            gv = delegator.findOne("SysDocSource", false, UtilMisc.toMap("sysDocSourceId", sysDocSourceId));
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocSource.find_failure", locale));
        }
        if (gv != null)
        {
            gv.setNonPKFields(context);
            try
            {
                gv.store();
                result.put("sysDocSourceId", sysDocSourceId);
            } catch (GenericEntityException e)
            {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocSource.update_failure", locale));
            }
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * 删除数据
     * 
     * delete a SysDocSource.
     * 
     * @param dctx
     *            The DispatchContext that this service is operating
     *            in.
     * @param context
     *            Map containing the input parameters.
     * @return Map with the result of the service, the output
     *         parameters.
     */
    public static Map<String, Object> deleteSysDocSource(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");

        String sysDocSourceId = (String) context.get("sysDocSourceId");
        GenericValue gv = null;
        try
        {
            gv = delegator.findOne("SysDocSource", false, UtilMisc.toMap("sysDocSourceId", sysDocSourceId));
        } catch (GenericEntityException e)
        {
            Debug.logError(e, module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocSource.find_failure", locale));
        }
        if (UtilValidate.isNotEmpty(gv))
        {
            try
            {
                gv.remove();
            } catch (GenericEntityException e)
            {
                Debug.logError(e, module);
                return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocSource.delete_failure", locale));
            }
        }

        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
        return result;
    }

    /**
     * uploadAndCreateSysDocSource<br/>
     * 上传文件到指定文件夹,并按照日期归档,生成系统文档资源.<br/>
     * 
     * @param dctx
     * @param context
     * @return
     */
    public static Map<String, Object> uploadAndCreateSysDocSource(DispatchContext dctx, Map<String, ? extends Object> context)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = dctx.getDelegator();
        Locale locale = (Locale) context.get("locale");
        GenericValue userLogin = (GenericValue) context.get("userLogin");
        if (UtilValidate.isNotEmpty(context.get("fileItem")))
        {
            String folder = (String) context.get("folder");
            FileItem fileItem = (FileItem) context.get("fileItem");
            if (UtilValidate.isNotEmpty(fileItem))
            {
                try
                {
                    String baseName = FilenameUtils.getBaseName(fileItem.getName());
                    String filePath = UtilFileUpload.saveFileItemToFile(fileItem, folder);

                    if (UtilValidate.isNotEmpty(filePath))
                    {
                        String sysDocSourceId = delegator.getNextSeqId("SysDocSource");
                        GenericValue gv = delegator.create("SysDocSource", UtilMisc.toMap("sysDocSourceId", sysDocSourceId, "docName", baseName, "createdByUserLogin",
                                userLogin.getString("userLoginId"), "objectInfo", filePath, "mimeTypeId", fileItem.getContentType()));

                        result.put("sysDocSource", gv);
                        result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
                        return result;
                    }
                } catch (Exception e)
                {
                    Debug.logError(e, module);
                    return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocSource.create_failure", locale));
                }
            }

        }

        return ServiceUtil.returnError(UtilProperties.getMessage(resourceError, "SysDocSource.non_file_upload", locale));
    }
}
