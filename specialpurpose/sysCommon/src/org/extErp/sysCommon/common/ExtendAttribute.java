package org.extErp.sysCommon.common;

import java.util.List;
import java.util.Map;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;

public class ExtendAttribute
{
    /**
     * 保存扩展属性
     * 
     * @param delegator
     * @param paramMap
     *            前台输入参数
     * @param relEntityId
     *            关联实体ID
     * @throws GenericEntityException
     */
    public static void saveExtendAttributeValue(Delegator delegator, Map<String, Object> paramMap, String relEntityId) throws GenericEntityException
    {
	// 保存扩展属性
	String splitStr = "^&&&^";
	List<GenericValue> toBeStored = FastList.newInstance();
	for (Map.Entry mapEntry : paramMap.entrySet())
	{
	    String key = mapEntry.getKey().toString();
	    if (key.indexOf(splitStr) > 0)
	    {
		GenericValue gv = delegator.makeValue("ExtendAttributeValue");
		Map extMap = UtilMisc.toMap("extendAttributeId", key.substring(key.indexOf(splitStr) + splitStr.length(), key.length()), "relEntityName",
			key.substring(0, key.indexOf(splitStr)), "relEntityId", relEntityId, "extendAttributeValue", mapEntry.getValue().toString());
		gv.putAll(extMap);
		toBeStored.add(gv);
		// gv.create();
	    }
	    delegator.storeAll(toBeStored);// 批量新增
	}
    }

    /**
     * 更新扩展属性
     * 
     * @param delegator
     * @param paramMap
     *            前台输入参数
     * @param relEntityId
     *            关联实体ID
     * @throws GenericEntityException
     */
    public static void updateExtendAttributeValue(Delegator delegator, Map<String, Object> paramMap, String relEntityId) throws GenericEntityException
    {
	// 更新扩展属性
	String splitStr = "^&&&^";
	List<GenericValue> toBeStored = FastList.newInstance();
	for (Map.Entry mapEntry : paramMap.entrySet())
	{
	    String key = mapEntry.getKey().toString();
	    if (key.indexOf(splitStr) > 0)
	    {
		GenericValue gv = delegator.makeValue("ExtendAttributeValue");
		Map extMap = UtilMisc.toMap("extendAttributeId", key.substring(key.indexOf(splitStr) + splitStr.length(), key.length()), "relEntityName",
			key.substring(0, key.indexOf(splitStr)), "relEntityId", relEntityId, "extendAttributeValue", mapEntry.getValue().toString());
		gv.putAll(extMap);
		// gv.store();
		toBeStored.add(gv);
	    }
	    delegator.storeAll(toBeStored);// 批量修改
	}
    }
}
