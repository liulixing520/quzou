/**
 * <b>项目名：</b>ofbiz_lims<br/>
 * <b>包名：</b>org.ofbiz.sysCommon.document<br/>
 * <b>文件名：</b>DocumentWorkers.java<br/>
 * <b>日期：</b>2013-1-30-上午9:23:39<br/>
 * <b>Copyright 2012-2015 北京远航科峰软件技术有限公司. All Rights Reserved.<br/>
 *
 */
package org.extErp.sysCommon.document;

import java.util.List;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;

/**
 * 
 * <b>类名称：</b>DocumentWorkers<br/>
 * <b>类描述：</b>〈一句话功能简述〉<br/>
 * <b>类详细描述：</b>〈功能详细描述〉<br/>
 * <b>创建人：</b>Administrator<br/>
 * <b>修改人：</b>Administrator<br/>
 * <b>修改时间：</b>2013-1-30 上午9:23:39<br/>
 * <b>修改备注：</b><br/>
 * 
 * @version <br/>
 * 
 */
public class DocumentWorkers
{
    public static String module = DocumentWorkers.class.getName();

    /**
     * findSysDocRef 查找文档信息<br/>
     * 按照文档用途和调用实体的ID查询某个文档的信息<br/>
     * 
     * @param sysDocPurposeId
     *            文档目的ID
     * @param relatedIdValue
     *            关联实体主键ID值
     * @param delegator
     * @return 返回查到的文档关联信息
     */
    public static GenericValue findSysDocRef(String sysDocPurposeId, String relatedIdValue, Delegator delegator)
    {
        return EntityUtil.getFirst(findSysDocRefList(sysDocPurposeId, relatedIdValue, delegator));
    }

    /**
     * findSysDocRefList 查找文档信息列表<br/>
     * 按照文档用途和调用实体的ID查询一系列文档的信息<br/>
     * 
     * @param sysDocPurposeId
     *            文档目的ID
     * @param relatedIdValue
     *            关联实体主键ID值
     * @param delegator
     * @return 返回查到的文档关联信息
     */
    public static List<GenericValue> findSysDocRefList(String sysDocPurposeId, String relatedIdValue, Delegator delegator)
    {
        try
        {
	    List<GenericValue> sdraList = delegator.findByAnd("SysDocRefAllInfo", UtilMisc.toMap("sysDocPurposeId", sysDocPurposeId, "relatedIdValue", relatedIdValue));
            sdraList = EntityUtil.filterByDate(sdraList);
            return sdraList;
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Error while finding latest SysDocRef for sysDocPurpose with ID [" + sysDocPurposeId + "] Entity pk value [" + relatedIdValue + "]: " + e.toString(),
                    module);
            return null;
        }
    }
}
