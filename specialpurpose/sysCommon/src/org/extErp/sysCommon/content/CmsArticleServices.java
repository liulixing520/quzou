package org.extErp.sysCommon.content;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;

import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

public class CmsArticleServices
{

    public static final String module = CmsArticleServices.class.getName();
    public static final String LABEL_RESOURCE = "CmsUiLabels";

    /**
     * 保存文章
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> createCmsArticle(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{

	    Delegator delegator = dctx.getDelegator();
	    String articleId = delegator.getNextSeqId("CmsArticle");
	    GenericValue gv = delegator.makeValue("CmsArticle", UtilMisc.toMap("articleId", articleId));
	    gv.setNonPKFields(context);
	    gv.create();
	    result.put("articleId", articleId);
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;

    }

    /**
     * 更新文章
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updateCmsArticle(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String articleId = (String) context.get("articleId");
	GenericValue gv = delegator.findOne("CmsArticle", UtilMisc.toMap("articleId", articleId), false);
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.setNonPKFields(context);
	    gv.store();
	}
	return result;
    }

    /**
     * 删除文章
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> deleteCmsArticle(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String articleId = (String) context.get("articleId");
	GenericValue gv = delegator.findOne("CmsArticle", UtilMisc.toMap("articleId", articleId), false);
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.remove();
	}

	return result;
    }

    /**
     * 保存文章分类
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> createContentCategory(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String catalogId = delegator.getNextSeqId("CmsCatalog");
	    GenericValue gv = delegator.makeValue("CmsCatalog", UtilMisc.toMap("catalogId", catalogId));
	    gv.setNonPKFields(context);
	    gv.create();
	    result.put("catalogId", catalogId);
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;

    }

    /**
     * 更新文章分类
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updateContentCategory(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map result = ServiceUtil.returnSuccess();
	String catalogId = (String) context.get("catalogId");
	GenericValue gv = delegator.findOne("CmsCatalog", UtilMisc.toMap("catalogId", catalogId), false);
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.setNonPKFields(context);
	    gv.store();
	}
	return result;

    }

    /**
     * 删除文章分类
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> deleteContentCategory(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = ServiceUtil.returnSuccess();
	Delegator delegator = dctx.getDelegator();
	String catalogId = (String) context.get("catalogId");
	GenericValue gv = delegator.findOne("CmsCatalog", UtilMisc.toMap("catalogId", catalogId), false);
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.remove();
	}
	// ShopUtil.returnAjaxInfo(result, context);
	return result;
    }

    /**
     * 批量删除文章分类
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> deleteContentCategoryAll(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = ServiceUtil.returnSuccess();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String ids = (String) context.get("ids");
	    if (ids != null && ids.length() > 0)
	    {
		String[] catalogId = ids.split(",");
		for (int i = 0; i < catalogId.length; i++)
		{

		    GenericValue gv = delegator.findOne("CmsCatalog", UtilMisc.toMap("catalogId", catalogId[i]), false);
		    if (UtilValidate.isNotEmpty(gv))
		    {
			gv.remove();
		    }
		}
	    }
	} catch (Exception e)
	{
	    // e.printStackTrace();
	}

	return result;
    }

    /**
     * 保存广告
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> createAdvertise(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String adId = delegator.getNextSeqId("CmsAdvertise");
	GenericValue gv = delegator.makeValue("CmsAdvertise", UtilMisc.toMap("adId", adId));
	gv.setNonPKFields(context);
	gv.create();
	result.put("adId", adId);
	/*
	 * String advertiseImgId =
	 * delegator.getNextSeqId("CmsAdvertiseImg"); GenericValue img
	 * = delegator.makeValue("CmsAdvertiseImg",
	 * UtilMisc.toMap("advertiseImgId", advertiseImgId));
	 * img.setNonPKFields(context); img.create();
	 */
	insOrUpdAdvertiseImg(delegator, context);
	return result;

    }

    /**
     * 保存广告图片
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> createAdvertiseImg(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();

	// delegator.removeByCondition("CmsAdvertiseImg",
	// EntityCondition.makeCondition("adId",
	// context.get("adId")));

	String advertiseImgId = delegator.getNextSeqId("CmsAdvertiseImg");
	GenericValue img = delegator.makeValue("CmsAdvertiseImg", UtilMisc.toMap("advertiseImgId", advertiseImgId));
	img.setNonPKFields(context);
	img.create();
	result.put("advertiseImgId", advertiseImgId);
	insOrUpdAdvertiseImg(delegator, context);
	return result;

    }

    public static void insOrUpdAdvertiseImg(Delegator delegator, Map<String, ? extends Object> context)
    {
	Object imgUrl = context.get("imgUrl");
    }

    /**
     * 更新广告
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updateAdvertise(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String articleId = (String) context.get("adId");
	GenericValue gv = delegator.findOne("CmsAdvertise", UtilMisc.toMap("adId", articleId), false);
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.setNonPKFields(context);
	    gv.store();
	}
	return result;
    }

    /**
     * 更新广告图片
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> updateAdvertiseImg(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String advertiseImgId = (String) context.get("advertiseImgId");
	GenericValue gv = delegator.findOne("CmsAdvertiseImg", UtilMisc.toMap("advertiseImgId", advertiseImgId), false);
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.setNonPKFields(context);
	    gv.store();
	}
	return result;
    }

    /**
     * 删除广告
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> deleteAdvertise(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String articleId = (String) context.get("adId");
	try
	{
	    List<EntityExpr> exprs = FastList.newInstance();
	    exprs.add(EntityCondition.makeCondition("adId", EntityOperator.EQUALS, articleId));
	    EntityFindOptions opts = new EntityFindOptions();
	    opts.setMaxRows(6);
	    opts.setFetchSize(6);
	    List<GenericValue> list = delegator.findList("CmsAdvertiseImg", EntityCondition.makeCondition(exprs, EntityOperator.AND), null, null, opts, false);
	    if (list.size() != 0)
	    {
		for (GenericValue imgGv : list)
		{
		    imgGv.remove();
		}
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	GenericValue gv = delegator.findOne("CmsAdvertise", UtilMisc.toMap("adId", articleId), false);
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.remove();
	}
	return result;
    }

    public static Map<String, Object> deleteAdvertiseImg(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String advertiseImgId = (String) context.get("advertiseImgId");
	try
	{
	    List<EntityExpr> exprs = FastList.newInstance();
	    exprs.add(EntityCondition.makeCondition("advertiseImgId", EntityOperator.EQUALS, advertiseImgId));
	    EntityFindOptions opts = new EntityFindOptions();
	    opts.setMaxRows(1);
	    opts.setFetchSize(1);
	    List<GenericValue> list = delegator.findList("CmsAdvertiseImg", EntityCondition.makeCondition(exprs, EntityOperator.AND), null, null, opts, false);
	    if (list.size() != 0)
	    {
		for (GenericValue imgGv : list)
		{
		    imgGv.remove();
		}
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;
    }
}
