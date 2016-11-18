/**
 * <b>项目名：</b>ofbiz_lims<br/>
 * <b>包名：</b>org.ofbiz.sysCommon.document<br/>
 * <b>文件名：</b>DocumentHelper.java<br/>
 * <b>日期：</b>2013-1-30-上午9:24:00<br/>
 * <b>Copyright 2012-2015 北京远航科峰软件技术有限公司. All Rights Reserved.<br/>
 *
 */
package org.extErp.sysCommon.document;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import javolution.util.FastMap;

import org.extErp.sysCommon.content.UtilFileUpload;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;


/**
 * 
 * <b>类名称：</b>DocumentHelper<br/>
 * <b>类描述：</b>〈一句话功能简述〉<br/>
 * <b>类详细描述：</b>〈功能详细描述〉<br/>
 * <b>创建人：</b>Administrator<br/>
 * <b>修改人：</b>Administrator<br/>
 * <b>修改时间：</b>2013-1-30 上午9:24:00<br/>
 * <b>修改备注：</b><br/>
 * 
 * @version <br/>
 * 
 */
public class DocumentHelper
{
    public static String module = DocumentHelper.class.getName();
    private static final String OFBIZ_HOME_PATH = System.getProperty("ofbiz.home");

    /**
     * uploadSysDocByPurpose<br/>
     * 按照文章目的上传资源[,如果原来有,则过期掉原来的]<br/>
     * 
     * @param sysDocPurposeId
     *            文档目的
     * @param relatedIdValue
     *            实体主键
     * @param folder
     *            默认目录
     * @param request
     *            请求参数
     * @return
     */
    public static Map<String, Object> uploadSysDocByPurpose(HttpServletRequest request, String sysDocPurposeId, String relatedIdValue)
    {
        Map<String, Object> uploadSysDocSourceFileResult = FastMap.newInstance();
        HttpSession session = request.getSession();
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
        Delegator delegator = (Delegator) request.getAttribute("delegator");

        GenericValue sysDocPurpose = null;
        try
        {
            sysDocPurpose = delegator.findOne("SysDocPurpose", UtilMisc.toMap("sysDocPurposeId", sysDocPurposeId), false);
        } catch (GenericEntityException e)
        {
            Debug.logError(e.getMessage(), module);
            return null;
        }

        try
        {
            String mimeTypeId = null;
            if (sysDocPurpose != null)
            {
                String path = sysDocPurpose.getString("path");
                if (UtilValidate.isEmpty(path))
                {
                    path = sysDocPurposeId;
                }

                String inApp = sysDocPurpose.getString("inApp");
                String folder = DocumentUtils.getFilePath(request, "sysCommon", "temp.file.relative.path", path, inApp);

                if (UtilValidate.isNotEmpty(sysDocPurpose.getString("mimeTypeId")))
                {
                    mimeTypeId = sysDocPurpose.getString("mimeTypeId");
                }
                uploadSysDocSourceFileResult = uploadSysDocSourceFile(mimeTypeId, folder, request);
                if (UtilValidate.isEmpty(uploadSysDocSourceFileResult))
                {
                    Debug.logError("上传文件失败", module);
                    return null;
                }
                if (UtilValidate.isEmpty(uploadSysDocSourceFileResult.get("sysDocSourceId")))
                {
                    // 如果没有生成Doc,则是没有文件上传,只对参数进行了处理
                    return uploadSysDocSourceFileResult;
                }

                if (UtilValidate.isEmpty(relatedIdValue))
                {
                    // 如果没有传入relatedIdValue,则说明是更新原有数据.则过期掉旧的
                    relatedIdValue = (String) uploadSysDocSourceFileResult.get(sysDocPurpose.getString("relatedDetailId"));

                    Map<String, Object> deactivateSysDocRefIfExistscontext = FastMap.newInstance();
                    deactivateSysDocRefIfExistscontext.put("sysDocPurposeId", sysDocPurposeId);
                    deactivateSysDocRefIfExistscontext.put("relatedIdValue", relatedIdValue);
                    deactivateSysDocRefIfExistscontext.put("userLogin", userLogin);

                    ModelService deactivateSysDocRefIfExistsService = dispatcher.getDispatchContext().getModelService("deactivateSysDocRefIfExists");
                    deactivateSysDocRefIfExistscontext = deactivateSysDocRefIfExistsService.makeValid(deactivateSysDocRefIfExistscontext, ModelService.IN_PARAM);

                    dispatcher.runSync(deactivateSysDocRefIfExistsService.name, deactivateSysDocRefIfExistscontext);
                }
                // 创建新的实体关联
                Map<String, Object> createSysDocRefcontext = FastMap.newInstance();
                createSysDocRefcontext.put("sysDocSourceId", uploadSysDocSourceFileResult.get("sysDocSourceId"));
                createSysDocRefcontext.put("sysDocPurposeId", sysDocPurposeId);
                createSysDocRefcontext.put("relatedIdValue", relatedIdValue);
                createSysDocRefcontext.put("userLogin", userLogin);

                ModelService createSysDocRefService = dispatcher.getDispatchContext().getModelService("createSysDocRef");
                createSysDocRefcontext = createSysDocRefService.makeValid(createSysDocRefcontext, ModelService.IN_PARAM);

                dispatcher.runSync(createSysDocRefService.name, createSysDocRefcontext);
                // add by wangyg-若为inapp，返回url
                if (UtilValidate.isNotEmpty(inApp) && "Y".equals(inApp))
                {
                    uploadSysDocSourceFileResult.put("inAppPath", DocumentUtils.getDocUrlByPurpose(request, sysDocPurposeId, relatedIdValue));
                }
            }
        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
            return null;
        }
        return uploadSysDocSourceFileResult;
    }

    public static Map<String, Object> uploadSysDocSourceFile(String folder, HttpServletRequest request)
    {
        return uploadSysDocSourceFile(null, folder, request);
    }

    /**
     * uploadSysDocSourceFile<br/>
     * 上传文件为SysDocSource<br/>
     * 
     * @param folder
     *            上传到的目录
     * @param request
     * 
     * @return 返回结果集合Map.
     * 
     * @throws Exception
     */

    public static Map<String, Object> uploadSysDocSourceFile(String mimeTypeId, String folder, HttpServletRequest request)
    {
        HttpSession session = request.getSession();
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");

        Map<String, Object> uploadResult = FastMap.newInstance();
        try
        {
            uploadResult = UtilFileUpload.uploadFile(folder, request);
            // uploadResult = UtilFileUpload.uploadFile(mimeTypeId,
            // folder, request);
        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
            return null;
        }

        Map<String, Object> result = FastMap.newInstance();
        if (UtilValidate.isEmpty(uploadResult))
        {
            Debug.logError("上传文件错误.", module);
            return null;
        }

        if (UtilValidate.isNotEmpty(uploadResult.get("fileName")))
        {
            // 只有上传了新文件才建立这个关联.
            try
            {
                String fileName = (String) uploadResult.get("fileName");
                String filePath = (String) uploadResult.get("filePath");
                String contentType = (String) uploadResult.get("contentType");

                Map<String, Object> context = FastMap.newInstance();
                context.put("userLogin", userLogin);
                context.put("createdByUserLogin", userLogin.getString("userLoginId"));
                context.put("docName", fileName);
                context.put("objectInfo", filePath);
                context.put("mimeTypeId", contentType);

                ModelService service = dispatcher.getDispatchContext().getModelService("createSysDocSource");
                context = service.makeValid(context, ModelService.IN_PARAM);
                result = dispatcher.runSync(service.name, context);
            } catch (GenericServiceException e)
            {
                Debug.logError(e.getMessage(), module);
                return null;
            }

            if (ServiceUtil.isSuccess(result))
            {
                uploadResult.putAll(result);
            }
        }
        return uploadResult;
    }
}
