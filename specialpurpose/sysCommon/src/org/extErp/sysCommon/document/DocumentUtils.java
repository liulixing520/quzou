/**
 * <b>项目名：</b>ofbiz_lims<br/>
 * <b>包名：</b>org.ofbiz.sysCommon.document<br/>
 * <b>文件名：</b>DocumentUtils.java<br/>
 * <b>日期：</b>2013-1-30-上午9:24:17<br/>
 * <b>Copyright 2012-2015 北京远航科峰软件技术有限公司. All Rights Reserved.<br/>
 *
 */
package org.extErp.sysCommon.document;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.base.util.string.FlexibleStringExpander;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;

/**
 * 
 * <b>类名称：</b>DocumentUtils<br/>
 * <b>类描述：</b>〈一句话功能简述〉<br/>
 * <b>类详细描述：</b>〈功能详细描述〉<br/>
 * <b>创建人：</b>Administrator<br/>
 * <b>修改人：</b>Administrator<br/>
 * <b>修改时间：</b>2013-1-30 上午9:24:17<br/>
 * <b>修改备注：</b><br/>
 * 
 * @version <br/>
 * 
 */
public class DocumentUtils
{

    public static final String module = DocumentUtils.class.getName();
    private static final String OFBIZ_HOME_PATH = System.getProperty("ofbiz.home");

    /**
     * getFilePath<br/>
     * 根据传入的参数取得文件系统中的实际目录路径<br/>
     * 
     * @param request
     * @param resource
     *            资源名称
     * @param name
     *            属性名称
     * @param path
     *            存储目录
     * @param inApp
     *            是否存储在本应用下
     * @return 实际路径
     */
    public static String getFilePath(HttpServletRequest request, String resource, String name, String path, String inApp)
    {
        Map<String, Object> context = FastMap.newInstance();
        context.put("locale", request.getLocale());

        String result = null;
        if ("Y".equals(inApp))
        {
            result = request.getSession().getServletContext().getRealPath("/") + "images/upload";
        } else
        {
            result = OFBIZ_HOME_PATH + "/" + FlexibleStringExpander.expandString(UtilProperties.getPropertyValue(resource, name), context);
        }
        if (!result.endsWith("/"))
        {
            result += "/";
        }
        result += path;
        if (!result.endsWith("/"))
        {
            result += "/";
        }

        return result;
    }

    /**
     * getPurposeBaseFolderPath<br/>
     * 根据传入的参数取得文件系统中的实际目录路径<br/>
     * 
     * @param request
     * @param sysDocPurposeId
     *            资源目的类型
     * @param name
     * @return 实际路径
     */
    public static String getPurposeBaseFolderPath(HttpServletRequest request, String sysDocPurposeId)
    {
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        String result = "";

        try
        {
            GenericValue purpose = delegator.findOne("SysDocPurpose", UtilMisc.toMap("sysDocPurposeId", sysDocPurposeId), true);
            if (purpose != null)
            {
                String path = purpose.getString("path");
                if (UtilValidate.isEmpty(path))
                {
                    path = sysDocPurposeId;
                }
                String inApp = purpose.getString("inApp");
                result = getFilePath(request, "sysCommon", "temp.file.relative.path", path, inApp);
            }
        } catch (GenericEntityException e)
        {
            Debug.logError(e.getLocalizedMessage(), module);
            e.printStackTrace();
        }

        return result;
    }

    public static String getPurposeBaseFolder(HttpServletRequest request, String sysDocPurposeId)
    {
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        String result = "";

        try
        {
            GenericValue purpose = delegator.findOne("SysDocPurpose", UtilMisc.toMap("sysDocPurposeId", sysDocPurposeId), true);
            if (purpose != null)
            {
                String inApp = purpose.getString("inApp");
                if (UtilValidate.isNotEmpty(inApp) && "Y".equals(inApp))
                {
                    String path = purpose.getString("path");
                    if (UtilValidate.isEmpty(path))
                    {
                        path = sysDocPurposeId;
                    }

		    result = UtilHttp.getServerRootUrl(request) + "/" + purpose.getString("appName") + "/images/upload/" + path + "/";
                }
            }
        } catch (GenericEntityException e)
        {
            Debug.logError(e.getLocalizedMessage(), module);
            e.printStackTrace();
        }

        return result;
    }

    public static String getDocUrlByPurpose(HttpServletRequest request, String sysDocPurposeId, String relatedIdValue)
    {
        Delegator delegator = (Delegator) request.getAttribute("delegator");

        String result = "";
        GenericValue docInfo = DocumentWorkers.findSysDocRef(sysDocPurposeId, relatedIdValue, delegator);
        if (docInfo != null)
        {
            result = getPurposeBaseFolder(request, sysDocPurposeId) + docInfo.getString("objectInfo");
        }

        return result;
    }

    /**
     * getDocNameByPurpose<br/>
     * 根据传入的参数取得附件名称<br/>
     * 
     * @param request
     * @param sysDocPurposeId
     * @param relatedIdValue
     * @return
     */
    public static String getDocNameByPurpose(HttpServletRequest request, String sysDocPurposeId, String relatedIdValue)
    {
        Delegator delegator = (Delegator) request.getAttribute("delegator");

        String result = "";

        GenericValue docInfo = DocumentWorkers.findSysDocRef(sysDocPurposeId, relatedIdValue, delegator);
        if (docInfo != null)
        {
            result = docInfo.getString("docName");
        }

        return result;
    }

    /**
     * getContentDisposition<br/>
     * 根据浏览器agent返回Http报头Content Disposition<br/>
     * 
     * @param fileName
     *            文件名
     * @param agent
     *            浏览器agent
     * @return ContentDisposition
     */
    public static String getContentDisposition(String fileName, String agent)
    {
        String newFileName = null;
        String contentDisposition = null;
        try
        {
            newFileName = URLEncoder.encode(fileName, "UTF8");
            contentDisposition = "attachment;filename=" + newFileName;

            if (agent != null)
            {
                if (agent.toUpperCase().indexOf("MSIE") > -1)
                {
                    // Internet Explorer mode
                    contentDisposition = "attachment;filename=" + newFileName;
                } else if (agent.toUpperCase().indexOf("APPLEWEBKIT") > -1)
                {
                    // Chrome mode
                    newFileName = MimeUtility.encodeText(fileName, "UTF8", "B");
                    contentDisposition = "attachment;filename=" + newFileName;
                } else if (agent.toUpperCase().indexOf("OPERA") != -1)
                {
                    // Opera mode
                    newFileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
                    contentDisposition = "attachment;filename*=UTF-8''" + newFileName;
                } else if (agent.toUpperCase().indexOf("MOZILLA") != -1)
                {
                    // FireFox mode
                    contentDisposition = "attachment;filename*=UTF-8''" + newFileName;
                } else if (agent.toUpperCase().indexOf("SAFARI") != -1)
                {
                    // Safari mode
                    newFileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
                    contentDisposition = "attachment;filename=" + newFileName;
                }
            }
        } catch (UnsupportedEncodingException e)
        {
            Debug.logError(e.getMessage(), module);
        }
        return contentDisposition;
    }
}
