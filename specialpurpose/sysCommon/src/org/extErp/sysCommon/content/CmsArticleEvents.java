package org.extErp.sysCommon.content;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;
import net.sf.json.JSONObject;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;

public class CmsArticleEvents
{
    public static final String module = CmsArticleEvents.class.getName();
    private static String IMAGE_FOLDER = UtilProperties.getPropertyValue("lims.properties", "content.uploadfile.article");

    /**
     * 附件上传
     * 
     * @param request
     * @param response
     * @return
     */
    public static String uploadImage(HttpServletRequest request, HttpServletResponse response)
    {
        try
        {
            IMAGE_FOLDER = request.getSession().getServletContext().getRealPath("/") + "/images/upload";
            Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
            toJsonObject(
                    UtilMisc.toMap(
                            "err",
                            "",
                            "msg",
                            UtilMisc.toMap(
                                    "url",
                                    request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"
                                            + context.get("filePath"), "localname", context.get("fileName"), "id", "1")), response);

        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
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
    public static String createCmsArticle(HttpServletRequest request, HttpServletResponse response)
    {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
        try
        {
            Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
            context.put("contentImg", context.get("filePath"));
            context.put("userLogin", userLogin);
            ModelService pService = dispatcher.getDispatchContext().getModelService("createCmsArticle");
            context = pService.makeValid(context, ModelService.IN_PARAM);
            dispatcher.runSync(pService.name, context);

            toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindCmsArticle"), response);

        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
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
    public static String updateCmsArticle(HttpServletRequest request, HttpServletResponse response)
    {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
        try
        {
            Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
            context.put("contentImg", context.get("filePath"));
            context.put("userLogin", userLogin);
            ModelService pService = dispatcher.getDispatchContext().getModelService("updateCmsArticle");
            context = pService.makeValid(context, ModelService.IN_PARAM);
            dispatcher.runSync(pService.name, context);
            toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindCmsArticle"), response);

        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
            return ModelService.RESPOND_ERROR;
        }

        return ModelService.RESPOND_SUCCESS;
    }

    /**
     * 广告添加时附件处理
     * 
     * @param request
     * @param response
     * @return
     */
    public static String createAdvertise(HttpServletRequest request, HttpServletResponse response)
    {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
        try
        {
            Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
            context.put("contentImg", context.get("filePath"));
            context.put("userLogin", userLogin);

            ModelService pService = dispatcher.getDispatchContext().getModelService("createAdvertise");
            Map<String, Object> context1 = pService.makeValid(context, ModelService.IN_PARAM);
            Map<String, Object> rsMap = dispatcher.runSync(pService.name, context1);

            ModelService ser = dispatcher.getDispatchContext().getModelService("createAdvertiseImg");
            String imgsInfo = (String) context.get("imgsInfo");
            String[] items = imgsInfo.split("@ITEM@");
            for (String item : items)
            {
                String[] data = item.split("@PROP@");
                Map<String, Object> context2 = ser.makeValid(context, ModelService.IN_PARAM);
                context2.put("adId", rsMap.get("adId"));
                context2.put("imgTitle", data[0]);
                context2.put("imgUrl", data[1]);
                context2.put("href", data[2]);
                context2.put("orderNum", data[3]);
                context2.put("status", "1");
                dispatcher.runSync(ser.name, context2);
            }
            toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindAdvertise"), response);

        } catch (Exception e)
        {
            Debug.logError(e.getMessage(), module);
            return ModelService.RESPOND_ERROR;
        }

        return ModelService.RESPOND_SUCCESS;
    }

    /**
     * 广告更新时附件处理
     * 
     * @param request
     * @param response
     * @return
     */
    public static String updateAdvertise(HttpServletRequest request, HttpServletResponse response)
    {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
        try
        {
            Map<String, Object> context = UtilFileUpload.uploadFile(IMAGE_FOLDER, request);
            context.put("contentImg", context.get("filePath"));
            context.put("userLogin", userLogin);

            // 检查旧有Id数目
            String adImgIdsStr = context.get("advertiseImgId").toString();
            String[] imgIds = adImgIdsStr.split(";");
            List<String> validImgIds = new ArrayList<String>();
            for (String s : imgIds)
            {
                if (null != s && !"".equals(s.trim()))
                {
                    validImgIds.add(s);
                }
            }
            // 获取提交的img数目
            String imgsInfo = (String) context.get("imgsInfo");
            String[] items = imgsInfo.split("@ITEM@");
            // 处理照片信息
            ModelService serUpdate;
            ModelService serCreate;
            ModelService serDelete;
            String[] data = null;
            Map<String, Object> context2 = null;
            if (items.length == validImgIds.size())
            {
                serUpdate = dispatcher.getDispatchContext().getModelService("updateAdvertiseImg");
                for (String item : items)
                {
                    data = item.split("@PROP@");
                    context2 = serUpdate.makeValid(context, ModelService.IN_PARAM);
                    context2.put("adId", context.get("adId"));
                    context2.put("imgTitle", data[0]);
                    context2.put("imgUrl", data[1]);
                    context2.put("href", data[2]);
                    context2.put("orderNum", data[3]);
                    context2.put("status", "1");
                    context2.put("advertiseImgId", data[4]);
                    dispatcher.runSync(serUpdate.name, context2);
                }
            } else if (items.length > validImgIds.size())
            {
                serUpdate = dispatcher.getDispatchContext().getModelService("updateAdvertiseImg");
                serCreate = dispatcher.getDispatchContext().getModelService("createAdvertiseImg");
                for (int i = 0; i < items.length; i++)
                {
                    data = items[i].split("@PROP@");
                    if (i < validImgIds.size())
                    {
                        context2 = serUpdate.makeValid(context, ModelService.IN_PARAM);
                        context2.put("adId", context.get("adId"));
                        context2.put("imgTitle", data[0]);
                        context2.put("imgUrl", data[1]);
                        context2.put("href", data[2]);
                        context2.put("orderNum", data[3]);
                        context2.put("status", "1");
                        context2.put("advertiseImgId", data[4]);
                        dispatcher.runSync(serUpdate.name, context2);
                    } else
                    {
                        context2 = serCreate.makeValid(context, ModelService.IN_PARAM);
                        context2.put("adId", context.get("adId"));
                        context2.put("imgTitle", data[0]);
                        context2.put("imgUrl", data[1]);
                        context2.put("href", data[2]);
                        context2.put("orderNum", data[3]);
                        context2.put("status", "1");
                        dispatcher.runSync(serCreate.name, context2);
                    }
                }
            } else
            {
                serUpdate = dispatcher.getDispatchContext().getModelService("updateAdvertiseImg");
                serDelete = dispatcher.getDispatchContext().getModelService("deleteAdvertiseImg");
                for (int i = 0; i < validImgIds.size(); i++)
                {
                    if (i < items.length)
                    {
                        data = items[i].split("@PROP@");
                        context2 = serUpdate.makeValid(context, ModelService.IN_PARAM);
                        context2.put("adId", context.get("adId"));
                        context2.put("imgTitle", data[0]);
                        context2.put("imgUrl", data[1]);
                        context2.put("href", data[2]);
                        context2.put("orderNum", data[3]);
                        context2.put("status", "1");
                        context2.put("advertiseImgId", data[4]);
                        dispatcher.runSync(serUpdate.name, context2);
                    } else
                    {
                        // context2 = serDelete.makeValid(context,
                        // ModelService.IN_PARAM);
                        context2.clear();
                        context2.put("advertiseImgId", validImgIds.get(i));
                        dispatcher.runSync(serDelete.name, context2);
                    }
                }
            }
            toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "FindAdvertise"), response);

        } catch (Exception e)
        {
            e.printStackTrace();
            Debug.logError(e.getMessage(), module);
            return ModelService.RESPOND_ERROR;
        }

        return ModelService.RESPOND_SUCCESS;
    }

    public static String createOrUpdateFriendLink(HttpServletRequest request, HttpServletResponse response)
    {
        Delegator delegator = (GenericDelegator) request.getAttribute("delegator");
        try
        {
            Object contentId = request.getParameter("contentId");
            Object contentName = request.getParameter("contentName");
            Object descriptionObj = request.getParameter("description");
            String description = "";
            if (UtilValidate.isNotEmpty(descriptionObj))
            {
                description = (String) descriptionObj;
                if (description.toLowerCase().startsWith("http:") || description.toLowerCase().startsWith("https:") || description.toLowerCase().startsWith("/"))
                {} else
                {
                    description = "http://" + description.trim();
                }
            }

            Map<String, Object> field = FastMap.newInstance();
            field.put("contentId", contentId);
            if (UtilValidate.isNotEmpty(contentId))
            {
                GenericValue gv = delegator.findOne("Content", field, false);
                gv.set("contentName", contentName);
                gv.set("description", description);
                gv.store();
                toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "SetFriendLink"), response);
                return "dialogSuccess";
            } else
            {
                contentId = delegator.getNextSeqId("Content");
                GenericValue friendLink = delegator.makeValue("Content");
                friendLink.set("contentId", contentId);
                friendLink.set("contentName", contentName);
                friendLink.set("description", description);
                friendLink.set("contentTypeId", "FRIEND_LINK");
                friendLink.create();
                toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "callbackType", "closeCurrent", "navTabId", "SetFriendLink"), response);
            }
        } catch (Exception e)
        {
            toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "操作失败"), response);
        }
        return "success";
    }

    public static String deleteFriendLink(HttpServletRequest request, HttpServletResponse response)
    {
        Delegator delegator = (GenericDelegator) request.getAttribute("delegator");
        try
        {
            Object contentId = request.getParameter("contentId");
            Map<String, Object> field = FastMap.newInstance();
            field.put("contentId", contentId);
            if (UtilValidate.isNotEmpty(contentId))
            {
                GenericValue gv = delegator.findOne("Content", field, false);
                gv.remove();
                toJsonObject(UtilMisc.toMap("statusCode", "200", "message", "操作成功", "navTabId", "SetFriendLink"), response);
            }
        } catch (Exception e)
        {
            toJsonObject(UtilMisc.toMap("statusCode", "300", "message", "操作失败"), response);
        }
        return "success";
    }

    public static void toJsonObject(Map<?, ?> attrMap, HttpServletResponse response)
    {
        JSONObject json = JSONObject.fromObject(attrMap);
        String jsonStr = json.toString();
        if (jsonStr == null)
        {
            Debug.logError("JSON Object was empty; fatal error!", module);
        }
        // set the X-JSON content type
        response.setContentType("text/html");
        // jsonStr.length is not reliable for unicode characters
        try
        {
            response.setContentLength(jsonStr.getBytes("UTF8").length);
        } catch (UnsupportedEncodingException e)
        {
            Debug.logError("Problems with Json encoding", module);
        }
        // return the JSON String
        Writer out;
        try
        {
            out = response.getWriter();
            out.write(jsonStr);
            out.flush();
        } catch (IOException e)
        {
            Debug.logError("Unable to get response writer", module);
        }
    }

    public static void toJsonObjectList(List<?> attrList, HttpServletResponse response)
    {
        String jsonStr = "[";
        for (Object attrMap : attrList)
        {
            JSONObject json = JSONObject.fromObject(attrMap);
            jsonStr = jsonStr + json.toString() + ',';
        }
        jsonStr = jsonStr + "{ } ]";
        if (UtilValidate.isEmpty(jsonStr))
        {
            Debug.logError("JSON Object was empty; fatal error!", module);
        }
        // set the X-JSON content type
        response.setContentType("application/json");
        // jsonStr.length is not reliable for unicode characters
        try
        {
            response.setContentLength(jsonStr.getBytes("UTF8").length);
        } catch (UnsupportedEncodingException e)
        {
            Debug.logError("Problems with Json encoding", module);
        }
        // return the JSON String
        Writer out;
        try
        {
            out = response.getWriter();
            out.write(jsonStr);
            out.flush();
        } catch (IOException e)
        {
            Debug.logError("Unable to get response writer", module);
        }
    }
}
