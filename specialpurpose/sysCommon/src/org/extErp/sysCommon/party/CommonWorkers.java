package org.extErp.sysCommon.party;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javolution.util.FastList;
import javolution.util.FastMap;
import javolution.util.FastSet;

import org.extErp.sysCommon.security.SecurityServices;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;

public class CommonWorkers
{

    public static final String module = SecurityServices.class.getName();

    /**
     * 按照分类类型得到此类型下的分类组列表
     * 
     * @param delegator
     * @param classificationTypeId
     *            分类类型标识ID
     * @param isUsed
     *            是否可用
     * @return 返回某个类型的分类组列表
     */
    public static List<GenericValue> getClassificationGroupList(Delegator delegator, String classificationTypeId, boolean isUsed)
    {
        List<GenericValue> classificationGroupList = FastList.newInstance();

        List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("classificationTypeId", EntityOperator.EQUALS, classificationTypeId));
        if (!isUsed)
        {
            exprs.add(EntityCondition.makeCondition("isUsed", EntityOperator.EQUALS, "N"));
        }

        try
        {
            classificationGroupList = delegator.findList("ClassificationGroup", EntityCondition.makeCondition(exprs), null, UtilMisc.toList("classificationGroupId"), null, true);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Cannot lookup ClassificationGroup", module);
        }
        return classificationGroupList;
    }

    /**
     * 按照分类组标识查询可用或者不可用的分类项目
     * 
     * @param delegator
     * @param classificationGroupId
     *            分类组ID
     * @param isUsed
     *            是否可用
     * @return 分类组下的可用分类值列表
     */
    public static List<GenericValue> getClassificationValueList(Delegator delegator, String classificationGroupId, boolean isUsed)
    {
        List<GenericValue> classificationValueList = FastList.newInstance();

        List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("classificationGroupId", EntityOperator.EQUALS, classificationGroupId));
        if (!isUsed)
        {
            exprs.add(EntityCondition.makeCondition("isUsed", EntityOperator.EQUALS, "N"));
        }

        try
        {
            classificationValueList = delegator.findList("ClassificationValue", EntityCondition.makeCondition(exprs), null, UtilMisc.toList("classificationValueId"), null, true);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Cannot lookup ClassificationValue", module);
        }
        return classificationValueList;
    }

    /**
     * 查询可用的信用度分类信息
     * 
     * @param delegator
     * @return 可用的信用度分类列表
     */
    public static List<GenericValue> getCreditDegreeList(Delegator delegator)
    {
        List<GenericValue> entities = FastList.newInstance();

        try
        {
            entities = delegator.findList("PartyGrade", EntityCondition.makeCondition(UtilMisc.toMap("gradeTypeId", "EP_GRADE")), null, UtilMisc.toList("gradeId"), null, true);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Cannot lookup PartyGrade", module);
        }
        return entities;
    }

    /**
     * 得到当事人目前的信用度
     * 
     * @param delegator
     * @param partyid
     * @return 返回信用度标识ID
     */
    public static GenericValue getCreditDegree(Delegator delegator, String partyId)
    {
        return getGradeInfo(delegator, partyId, "EP_GRADE");
    }

    /**
     * 得到当事人目前的级别
     * 
     * @param delegator
     * @param partyId
     *            当事人标识ID
     * @param gradeTypeId
     *            分级类型
     * @return 返回级别标识ID
     */
    public static GenericValue getGradeInfo(Delegator delegator, String partyId, String gradeTypeId)
    {
        List<GenericValue> entities = FastList.newInstance();
        try
        {
            List<EntityCondition> list = FastList.newInstance();
            list.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId));
            list.add(EntityCondition.makeCondition("gradeTypeId", EntityOperator.EQUALS, gradeTypeId));
            entities = delegator.findList("PartyGradeTypeAndInfo", EntityCondition.makeCondition(list), null, UtilMisc.toList("gradeId"), null, true);
            entities = EntityUtil.filterByDate(entities);
            return EntityUtil.getFirst(entities);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Cannot lookup PartyGrade", module);
            return null;
        }
    }

    /**
     * 查询可用的企业所有制分类信息
     * 
     * @param delegator
     * @return 可用的企业所有制类型列表
     */
    public static List<GenericValue> getUsedOwnershipList(Delegator delegator)
    {
        List<GenericValue> entities = FastList.newInstance();

        try
        {
            entities = delegator.findList("Ownership", null, null, UtilMisc.toList("ownershipId"), null, true);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Cannot lookup Ownership", module);
        }
        return entities;
    }

    /**
     * 查询可用的行业分类信息
     * 
     * @param delegator
     * @return 可用的行业类型列表
     */
    public static List<GenericValue> getUsedIndustryList(Delegator delegator)
    {
        return getClassificationValueList(delegator, "INDUSTRY_CLASS", true);
    }

    /**
     * 查询可用的地区分类信息
     * 
     * @param delegator
     * @return 可用的区域类型列表
     */
    public static List<GenericValue> getUsedAreaList(Delegator delegator)
    {
        List<GenericValue> entities = FastList.newInstance();

        try
        {
            EntityCondition condition = EntityCondition.makeCondition("pcLevel", "1");
            entities = delegator.findList("ProvinceCity", condition, null, UtilMisc.toList("pcSortId"), null, true);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Cannot lookup ProvinceCity", module);
        }
        return entities;
    }

    /**
     * @param delegator
     * @param partyId
     *            当事人标识ID
     * @param classificationGroupId
     *            分类组标识ID
     * @return 某个当事人的某个分类的当前值.
     */
    public static GenericValue getPartyClassificationExt(Delegator delegator, String partyId, String classificationGroupId)
    {
        GenericValue gv = null;
        List<GenericValue> entities = FastList.newInstance();

        List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId));
        exprs.add(EntityCondition.makeCondition("classificationGroupId", EntityOperator.EQUALS, classificationGroupId));

        try
        {
            entities = delegator.findList("PartyClassificationInfo", EntityCondition.makeCondition(exprs), null, UtilMisc.toList("classificationId"), null, true);
            entities = EntityUtil.filterByDate(entities);
            if (UtilValidate.isNotEmpty(entities))
            {
                GenericValue temp = EntityUtil.getFirst(entities);
                gv = delegator.findOne("PartyClassificationExt", UtilMisc.toMap("classificationId", temp.getString("classificationId")), false);
            }
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Cannot lookup PartyClassificationExt", module);
        }
        return gv;
    }

    /**
     * 按照当事人ID查询企业所属的行业值的ID
     * 
     * @param delegator
     * @param partyId
     *            查询的当事人ID
     * @return 返回查询值
     */
    public static String getPartyIndustryId(Delegator delegator, String partyId)
    {
        GenericValue gv = getPartyClassificationExt(delegator, partyId, "INDUSTRY_CLASS");
        if (UtilValidate.isNotEmpty(gv))
        {
            return gv.getString("classificationValueId");
        }
        return null;
    }

    /**
     * 按照当事人ID查询企业所属的行业名称
     * 
     * @param delegator
     * @param partyId
     *            查询的当事人ID
     * @return 返回查询值
     */
    public static String getPartyIndustryName(Delegator delegator, String partyId)
    {
        GenericValue gv = getPartyClassificationExt(delegator, partyId, "INDUSTRY_CLASS");
        if (UtilValidate.isNotEmpty(gv))
        {
            try
            {
                return delegator.findOne("ClassificationValue", true, UtilMisc.toMap("classificationValueId", gv.getString("classificationValueId")))
                        .get("classificationValueDesc").toString();
            } catch (GenericEntityException e)
            {
                Debug.logError(e.getMessage(), module);
                e.printStackTrace();
            }
        }
        return null;
    }

    /**
     * 按照当事人ID查询企业所属区域名称
     * 
     * @param delegator
     * @param partyId
     *            查询的当事人ID
     * @return 返回查询值
     */
    public static String getPartyProvinceCityName(Delegator delegator, String partyId)
    {
        String cityName = "";
        try
        {
            GenericValue gv;
            gv = delegator.findOne("PartyGroup", false, UtilMisc.toMap("partyId", partyId));

            if (UtilValidate.isNotEmpty(gv) && UtilValidate.isNotEmpty(gv.get("pcId")))
            {
                GenericValue pv = delegator.findOne("ProvinceCity", true, UtilMisc.toMap("pcId", gv.get("pcId").toString()));
                if (UtilValidate.isNotEmpty(gv) && UtilValidate.isNotEmpty(pv.get("pcName")))
                {
                    cityName = pv.get("pcName").toString();
                }
            }
        } catch (GenericEntityException e)
        {
            Debug.logError(e.getMessage(), module);
            e.printStackTrace();
        }
        return cityName;
    }

    /**
     * @param delegator
     * @param country
     * @return
     */
    public static List<GenericValue> getAssociatedStateList(Delegator delegator, String country)
    {
        if (UtilValidate.isEmpty(country))
            return null;
        return getAssociatedStateList(delegator, country, null);
    }

    /**
     * Returns a list of regional geo associations.
     * 
     * @param delegator
     * @param country
     * @param listOrderBy
     * @return
     */
    public static List<GenericValue> getAssociatedStateList(Delegator delegator, String country, String listOrderBy)
    {
        if (UtilValidate.isEmpty(country))
        {
            // Load the system default country
            country = UtilProperties.getPropertyValue("general.properties", "country.geo.id.default");
        }
        EntityCondition stateProvinceFindCond = EntityCondition.makeCondition(EntityCondition.makeCondition("geoIdFrom", country), EntityCondition.makeCondition("geoAssocTypeId",
                "REGIONS"), EntityCondition.makeCondition(EntityOperator.OR, EntityCondition.makeCondition("geoTypeId", "STATE"),
                EntityCondition.makeCondition("geoTypeId", "PROVINCE"), EntityCondition.makeCondition("geoTypeId", "MUNICIPALITY"),
                // 添加城市
                EntityCondition.makeCondition("geoTypeId", "CITY"), EntityCondition.makeCondition("geoTypeId", "COUNTY")));

        if (UtilValidate.isEmpty(listOrderBy))
        {
            listOrderBy = "geoId";
        }
        List<String> sortList = UtilMisc.toList(listOrderBy);

        List<GenericValue> geoList = FastList.newInstance();
        try
        {
            geoList = delegator.findList("GeoAssocAndGeoTo", stateProvinceFindCond, null, sortList, null, false);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Cannot lookup Geo", module);
        }
        return geoList;
    }

    /**
     * 获取省-市-县中文名称
     * 
     * @param delegator
     * @param stateProvinceGeoId
     *            省geoId
     * @param cityGeoId
     *            市geoId
     * @param countyGeoId
     *            县geoId
     * @return
     */
    public static String getAddressGeoAllCn(Delegator delegator, String stateProvinceGeoId, String cityGeoId, String countyGeoId)
    {

        StringBuilder AddressGeoAllCn = new StringBuilder();

        try
        {
            List<String> geoList = FastList.newInstance();
            if (UtilValidate.isNotEmpty(stateProvinceGeoId))
            {
                geoList.add(stateProvinceGeoId);
            }
            if (UtilValidate.isNotEmpty(cityGeoId))
            {
                geoList.add(cityGeoId);
            }
            if (UtilValidate.isNotEmpty(countyGeoId))
            {
                geoList.add(countyGeoId);
            }

            List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("geoId", EntityOperator.IN, geoList));

            EntityConditionList<EntityExpr> condition = EntityCondition.makeCondition(exprs);
            List<GenericValue> tempCol = delegator.findList("Geo", condition, null, null, null, false);
            for (Iterator<GenericValue> iterator = tempCol.iterator(); iterator.hasNext();)
            {
                GenericValue gc = iterator.next();
                AddressGeoAllCn.append(gc.getString("geoName"));
                if (iterator.hasNext())
                {
                    AddressGeoAllCn.append("-");
                }

            }
        } catch (GenericEntityException e)
        {
            Debug.logWarning(e, module);
        }

        return AddressGeoAllCn.length() > 0 ? AddressGeoAllCn.toString() : "";
    }

    /**
     * 按照联系方式对象取得具体内容<br/>
     * 如果是邮件地址则返回邮件地址内容;如果是电话号码则返回完整号码;如果是邮政地址;则返回完整的邮政地址;如果是网址
     * 则返回具体网址<br/>
     * 
     * @param delegator
     * @param cm
     *            联系方式实体
     * @return 联系方式具体内容
     */
    public static String getContactMechString(Delegator delegator, GenericValue cm)
    {
        String result = null;
        if (UtilValidate.isNotEmpty(cm))
        {
            GenericValue gv = null;
            try
            {
                String contactMechTypeId = cm.getString("contactMechTypeId");
                if ("POSTAL_ADDRESS".equals(contactMechTypeId))
                {
		    gv = cm.getRelatedOne("PostalAddress");
                    if (UtilValidate.isNotEmpty(gv))
                    {
                        result = gv.getString("city") + "-" + gv.getString("address1");
                    }
                } else if ("TELECOM_NUMBER".equals(contactMechTypeId))
                {
		    gv = cm.getRelatedOne("TelecomNumber");
                    if (UtilValidate.isNotEmpty(gv))
                    {
                        result = gv.getString("contactNumber");
                    }
                } else
                {
                    String infoString = cm.getString("infoString");
                    if (UtilValidate.isNotEmpty(infoString))
                    {
                        result = infoString;
                    }
                }
            } catch (GenericEntityException e)
            {
                e.printStackTrace();
                Debug.log("获取联系方式内容出错!", module);
                return result;
            }
        }
        return result;
    }

    /**
     * 按照联系方式对象取得具体内容<br/>
     * 如果是邮件地址则返回邮件地址内容;如果是电话号码则返回完整号码;如果是邮政地址;则返回完整的邮政地址;如果是网址
     * 则返回具体网址<br/>
     * 
     * @param delegator
     * @param cm
     *            联系方式实体
     * @return 联系方式具体内容
     */
    public static GenericValue getContactMechGv(Delegator delegator, GenericValue cm)
    {
        GenericValue result = null;
        if (UtilValidate.isNotEmpty(cm))
        {
            GenericValue gv = null;
            try
            {
                String contactMechTypeId = cm.getString("contactMechTypeId");
                if ("POSTAL_ADDRESS".equals(contactMechTypeId))
                {
		    gv = cm.getRelatedOne("PostalAddress");
                    if (UtilValidate.isNotEmpty(gv))
                    {
                        result = gv;
                    }
                } else if ("TELECOM_NUMBER".equals(contactMechTypeId))
                {
		    gv = cm.getRelatedOne("TelecomNumber");
                    if (UtilValidate.isNotEmpty(gv))
                    {
                        result = gv;
                    }
                } else
                {
                    String infoString = cm.getString("infoString");
                    if (UtilValidate.isNotEmpty(infoString))
                    {
                        result = cm;
                    }
                }
            } catch (GenericEntityException e)
            {
                e.printStackTrace();
                Debug.log("获取联系方式内容出错!", module);
                return result;
            }
        }
        return result;
    }

    /**
     * 按照联系方式ID得到联系方式具体信息<br/>
     * 根据联系方式ID返回联系方式内容<br/>
     * 如果是邮件地址则返回邮件地址内容;如果是电话号码则返回完整号码;如果是邮政地址;则返回完整的邮政地址;如果是网址
     * 则返回具体网址<br/>
     * 
     * @param delegator
     * @param cm
     *            联系方式ID
     * @return 联系方式具体内容
     */
    public static String getContactMechStringById(Delegator delegator, String contactMechId)
    {
        try
        {
            GenericValue cm = delegator.findOne("ContactMech", UtilMisc.toMap("contactMechId", contactMechId), true);
            return getContactMechString(delegator, cm);
        } catch (GenericEntityException e)
        {
            e.printStackTrace();
            Debug.log("获取联系方式内容出错!", module);
            return null;
        }

    }

    /**
     * 按照联系方式ID得到联系方式具体信息<br/>
     * 根据联系方式ID返回联系方式内容<br/>
     * 如果是邮件地址则返回邮件地址内容;如果是电话号码则返回完整号码;如果是邮政地址;则返回完整的邮政地址;如果是网址
     * 则返回具体网址<br/>
     * 
     * @param delegator
     * @param cm
     *            联系方式ID
     * @return 联系方式具体内容
     */
    public static GenericValue getContactMechStringByIdExt(Delegator delegator, String contactMechId)
    {
        try
        {
            GenericValue cm = delegator.findOne("ContactMech", UtilMisc.toMap("contactMechId", contactMechId), true);
            return getContactMechGv(delegator, cm);
        } catch (GenericEntityException e)
        {
            e.printStackTrace();
            Debug.log("获取联系方式内容出错!", module);
            return null;
        }
    }

    /**
     * 按照联系方式目的类型得到当事人联系方式内容列表<br/>
     * 根据传入的当事人ID和联系目的类型ID查询对于的联系方式,并将结果以Map返回.<br/>
     * 
     * @param delegator
     * @param partyId
     *            当事人ID
     * @param contactMechPurposeTypeId
     *            目的类型ID
     * @return 结果集
     */
    public static Map<String, String> getContactListByPurpose(Delegator delegator, String partyId, String contactMechPurposeTypeId)
    {
        Map<String, String> result = FastMap.newInstance();
        try
        {
            List<GenericValue> contactMechList = delegator.findByAnd("PartyContactMechPurpose",
                    UtilMisc.toMap("partyId", partyId, "contactMechPurposeTypeId", contactMechPurposeTypeId), null, false);

            contactMechList = EntityUtil.filterByDate(contactMechList);

            String tempString = null;
            for (Iterator<GenericValue> iterator = contactMechList.iterator(); iterator.hasNext();)
            {
                GenericValue gv = iterator.next();
                tempString = CommonWorkers.getContactMechStringById(delegator, gv.getString("contactMechId"));
                if (UtilValidate.isNotEmpty(tempString))
                {
                    result.put(gv.getString("contactMechId"), tempString);
                }
            }
        } catch (Exception e)
        {
            Debug.logError("Get Contact List By Purpose Error ", module);
            e.printStackTrace();
            return result;
        }
        return result;
    }

    /**
     * 按照联系方式目的类型得到当事人联系方式内容列表<br/>
     * 根据传入的当事人ID和联系目的类型ID查询对于的联系方式,并将结果以Map返回.<br/>
     * 
     * @param delegator
     * @param partyId
     *            当事人ID
     * @param contactMechPurposeTypeId
     *            目的类型ID
     * @return 结果集
     */
    public static List<GenericValue> getContactListByPurposeExt(Delegator delegator, String partyId, String contactMechPurposeTypeId)
    {
        List<GenericValue> result = FastList.newInstance();
        try
        {
            List<GenericValue> contactMechList = EntityUtil.filterByDate(delegator.findByAnd("PartyContactMechPurpose",
                    UtilMisc.toMap("partyId", partyId, "contactMechPurposeTypeId", contactMechPurposeTypeId), null, false));

            GenericValue tempGv = null;
            for (Iterator<GenericValue> iterator = contactMechList.iterator(); iterator.hasNext();)
            {
                GenericValue gv = iterator.next();
                tempGv = CommonWorkers.getContactMechStringByIdExt(delegator, gv.getString("contactMechId"));
                if (UtilValidate.isNotEmpty(tempGv))
                {
                    result.add(tempGv);
                }
            }
        } catch (Exception e)
        {
            Debug.logError("Get Contact List By Purpose Error ", module);
            e.printStackTrace();
            return result;
        }
        return result;
    }

    /**
     * 根据传入部门ids获取下级部门ids-List<br/>
     * 
     * @param delegator
     * @param parentGroupIds
     *            部门ids
     * @return 结果集
     */
    public static List<String> getChildPartyGroupByGroupIds(Delegator delegator, String parentGroupIds)
    {
        List<String> result = FastList.newInstance();
        try
        {
            if (UtilValidate.isEmpty(parentGroupIds))
            {
                Debug.logError("Parameter parentGroupIds is NULL,So return is empty List!", module);
                return result;
            }
            List<String> idList = StringUtil.split(parentGroupIds, ",");
	    List<EntityExpr> exprList = FastList.newInstance();
	    exprList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "DEPARTMENT"));
	    exprList.add(EntityCondition.makeCondition("parentPartyId", EntityOperator.IN, idList));
	    EntityConditionList<EntityExpr> assocExprList = EntityCondition.makeCondition(exprList, EntityOperator.AND);
	    List<GenericValue> childListAll = delegator.findList("PartyGroupAndParent", assocExprList, null, null, null, false);
            for (String id : idList)
            {
		List<String> twoList = FastList.newInstance();
		twoList = EntityUtil.getFieldListFromEntityList(childListAll, "partyId", false);
		result.addAll(twoList);
		// 获取第三级-不是最优方案，应该是递归
		List<EntityExpr> exprListThree = FastList.newInstance();
		exprListThree.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "DEPARTMENT"));
		exprListThree.add(EntityCondition.makeCondition("parentPartyId", EntityOperator.IN, twoList));
		EntityConditionList<EntityExpr> assocExprListThree = EntityCondition.makeCondition(exprListThree, EntityOperator.AND);
		List<GenericValue> childListThreeAll = delegator.findList("PartyGroupAndParent", assocExprListThree, null, null, null, false);
		List<String> threeList = FastList.newInstance();
		threeList = EntityUtil.getFieldListFromEntityList(childListThreeAll, "partyId", false);
		result.addAll(threeList);

            }

        } catch (Exception e)
        {
            Debug.logError("Get Contact List By Purpose Error ", module);
            e.printStackTrace();
            return result;
        }
        return result;
    }

    /**
     * 根据传入部门ids获取下级部门ids和当前ids-List<br/>
     * 
     * @param delegator
     * @param parentGroupIds
     *            部门ids
     * @return 结果集
     */
    public static List<String> getChildPartyGroupAndCurrentByGroupIds(Delegator delegator, String parentGroupIds)
    {
        List<String> result = FastList.newInstance();
        try
        {
            if (UtilValidate.isNotEmpty(parentGroupIds))
            {
                result = getChildPartyGroupByGroupIds(delegator, parentGroupIds);
                List<String> idList = StringUtil.split(parentGroupIds, ",");
                result.addAll(idList);
            }
        } catch (Exception e)
        {
            Debug.logError("Get Contact List By Purpose Error ", module);
            e.printStackTrace();
            return result;
        }
        return result;
    }

    /**
     * 根据传入的部门ids获取下面所有的用户partyid
     */
    public static List<String> getUserPartyIdByGroupIds(Delegator delegator,String partyGroupIdStr,List<String> partyGroupIdList)
    {
    	try{
	    	Set<String> groupIdList = FastSet.newInstance();
	    	if(UtilValidate.isNotEmpty(partyGroupIdStr)){
	    		groupIdList.addAll(Arrays.asList(partyGroupIdStr.split(",")));
	    	}
	    	if(UtilValidate.isNotEmpty(partyGroupIdList)){
	    		groupIdList.addAll(partyGroupIdList);
	    	}
	    	if(UtilValidate.isNotEmpty(groupIdList))
	    	{
	    		List<EntityCondition> cdtList = FastList.newInstance();
	    		cdtList.add(EntityCondition.makeCondition("partyIdFrom",EntityOperator.IN,groupIdList));
	    		cdtList.add(EntityCondition.makeCondition("partyRelationshipTypeId","EMPLOYMENT"));
	    		List<GenericValue> users = delegator.findList("PartyRelationship", EntityCondition.makeCondition(cdtList), UtilMisc.toSet("partyIdTo"), null, null, false);
	    		return EntityUtil.getFieldListFromEntityList(users, "partyIdTo", true);
	    	}
    	}catch(Exception e){
    		Debug.logError(e, module);
    	}
    	return FastList.newInstance();
    }
    /**
     * 得到上级单位<br/>
     * 按照传入的partyId得到上级单位<br/>
     * 
     * @param delegator
     * @param partyId
     *            传入的当事人Id
     * @return PartyGroupAndParent视图实体
     */
    public static GenericValue getParentPartyGroup(Delegator delegator, String partyId)
    {
        if (UtilValidate.isNotEmpty(partyId))
        {
            try
            {
                return EntityUtil.getFirst(delegator.findByAnd("PartyGroupAndParent", UtilMisc.toMap("partyId", partyId), null, false));
            } catch (GenericEntityException e)
            {
                Debug.logError("Get PartyGroupAndParent By PartyId Error ", module);
                return null;
            }
        }
        return null;
    }

    /**
     * 得到上级单位名称<br/>
     * 按照当事人ID得到上级单位名称<br/>
     * 
     * @param delegator
     * @param partyId
     *            传入的当事人ID
     * @return 上级结构名称
     */
    public static String getParentPartyGroupName(Delegator delegator, String partyId)
    {
        GenericValue gv = CommonWorkers.getParentPartyGroup(delegator, partyId);
        if (UtilValidate.isNotEmpty(gv))
        {
            return gv.getString("parentGroupName");
        }
        return "";
    }

    /**
     * getPersonName<br/>
     * 查询人的名字,如果有昵称,优先返回,否则返回 姓+名,否则返回人的ID,全没有则为空<br/>
     * 
     * @param delegator
     * @param personPartyId
     *            人的ID
     * @return 人的名字
     */
    public static String getPersonName(Delegator delegator, String personPartyId)
    {
        String name = "";
        try
        {
            if (UtilValidate.isNotEmpty(personPartyId))
            {
                name = personPartyId;
                GenericValue person = delegator.findOne("Person", UtilMisc.toMap("partyId", personPartyId), false);
                if (UtilValidate.isNotEmpty(person))
                {
                    name = person.getString("nickname");
                    if (UtilValidate.isEmpty(name))
                    {
                        name = (UtilValidate.isEmpty(person.getString("lastName")) ? "" : person.getString("lastName"))
                                + (UtilValidate.isEmpty(person.getString("firstName")) ? "" : person.getString("firstName"));
                    }
                }
            }
            return name;
        } catch (GenericEntityException e)
        {
            return name;
        }
    }
}
