package org.extErp.sysCommon.crm;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.extErp.sysCommon.party.CommonWorkers;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.DelegatorFactory;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.party.contact.ContactHelper;
import org.ofbiz.party.party.PartyWorker;


public class CrmUtils
{
    public static final String module = CrmUtils.class.getName();

    /**
     * 通过ID查找一个联系人的相关信息[Party,Person,Phones,Mobiles,Emails]
     * 
     * @param delegator
     * @param partyId
     *            联系人的ID
     * @return
     */
    public static Map<String, Object> getContactPartyOtherValues(Delegator delegator, String partyId)
    {
        Map<String, Object> result = FastMap.newInstance();

        try
        {
            GenericValue party = delegator.findOne("Party", UtilMisc.toMap("partyId", partyId), false);

            if (party != null)
            {
                result.put("party", party);

                try
                {
                    GenericValue person = delegator.findOne("Person", UtilMisc.toMap("partyId", partyId), false);
                    if (person != null)
                    {
                        result.put("person", person);
                    }
                } catch (GenericEntityException e)
                {
                    Debug.logWarning(e, "Problems getting Person entity", module);
                }

                Map<String, String> phones = CrmUtils.getContactMechStringByPurpose(delegator, party, "PRIMARY_PHONE");
                if (UtilValidate.isNotEmpty(phones))
                {
                    result.put("phones", phones);
                }

                Map<String, String> mobiles = CrmUtils.getContactMechStringByPurpose(delegator, party, "PHONE_MOBILE");
                if (UtilValidate.isNotEmpty(mobiles))
                {
                    result.put("mobiles", mobiles);
                }

                Map<String, String> emails = CrmUtils.getContactMechStringByPurpose(delegator, party, "PRIMARY_EMAIL");
                if (UtilValidate.isNotEmpty(emails))
                {
                    result.put("emails", emails);
                }
            }
        } catch (GenericEntityException e)
        {
            Debug.logWarning(e, "Problems getting Party entity", module);
        }

        return result;
    }

    /**
     * 查询某个委托方的所有联系人信息
     * 
     * @param delegator
     * @param partyId
     * @return
     */
    public static Map<String, Map<String, Object>> getAllActiveEntrustingContactPersonsInfo(Delegator delegator, String partyId)
    {
        Map<String, Map<String, Object>> result = FastMap.newInstance();
        List<GenericValue> prList = getActiveEntrustingPartyRelationships(delegator, partyId);
        if (UtilValidate.isNotEmpty(prList))
        {
            List<String> partyIdList = EntityUtil.getFieldListFromEntityList(prList, "partyIdFrom", true);
            for (String id : partyIdList)
            {
                Map<String, Object> values = getContactPartyOtherValues(delegator, id);
                if (UtilValidate.isNotEmpty(values))
                {
                    result.put(id, values);
                }
            }
        }
        return result;
    }

    /**
     * 查询某个委托方指定角色的所有联系人信息
     * 
     * @param delegator
     * @param partyId
     * @param roleTypeIdFrom
     * @return
     */
    public static Map<String, Map<String, Object>> getActiveEntrustingContactPersonsInfo(Delegator delegator, String partyId, String roleTypeIdFrom)
    {
        Map<String, Map<String, Object>> result = FastMap.newInstance();
        List<GenericValue> prList = getActiveEntrustingPartyRelationships(delegator, partyId, roleTypeIdFrom);
        if (UtilValidate.isNotEmpty(prList))
        {
            List<String> partyIdList = EntityUtil.getFieldListFromEntityList(prList, "partyIdFrom", true);
            for (String id : partyIdList)
            {
                Map<String, Object> values = getContactPartyOtherValues(delegator, id);
                if (UtilValidate.isNotEmpty(values))
                {
                    result.put(id, values);
                }
            }
        }
        return result;
    }

    /**
     * 查询某个委托方指定角色的联系人关系列表
     * 
     * @param delegator
     * @param partyId
     *            委托方ID
     * @param roleTypeIdFrom
     *            联系人角色ID
     * @return
     */
    public static List<GenericValue> getActiveEntrustingPartyRelationships(Delegator delegator, String partyId, String roleTypeIdFrom)
    {
        return getActivePartyRelationships(delegator, partyId, roleTypeIdFrom, "ENTRUSTING_PARTY", "CUSTOMER_CONTACT_REL");
    }

    /**
     * 查询某个委托方所有的联系人关系列表
     * 
     * @param delegator
     * @param partyId
     *            委托方ID
     * @return
     */
    public static List<GenericValue> getActiveEntrustingPartyRelationships(Delegator delegator, String partyId)
    {
        return getActivePartyRelationships(delegator, partyId, "ENTRUSTING_PARTY", "CUSTOMER_CONTACT_REL");
    }

    /**
     * 按照当事人ID和角色ID,联系人角色ID,类型ID,查到到所有到这个联系人的 关系列表
     * 
     * @param delegator
     * @param partyIdTo
     *            要查找的当事人ID
     * @param partyRelationshipTypeId
     *            联系类型ID
     * @param roleTypeIdFrom
     *            要查找的联系人角色类型ID
     * @param roleTypeIdTo
     *            要查找的当事人角色类型ID
     * @return
     */
    public static List<GenericValue> getActivePartyRelationships(Delegator delegator, String partyIdTo, String roleTypeIdFrom, String roleTypeIdTo, String partyRelationshipTypeId)
    {
        Map<String, Object> partyRelationshipValues = FastMap.newInstance();
        partyRelationshipValues.put("partyIdTo", partyIdTo);
        partyRelationshipValues.put("roleTypeIdFrom", roleTypeIdFrom);
        partyRelationshipValues.put("roleTypeIdTo", roleTypeIdTo);
        partyRelationshipValues.put("partyRelationshipTypeId", partyRelationshipTypeId);

        return getActivePartyRelationships(delegator, partyRelationshipValues);
    }

    /**
     * 按照当事人ID和角色ID,类型ID,查到到所有到这个联系人的 关系列表
     * 
     * @param delegator
     * @param partyIdTo
     *            要查找的当事人ID
     * @param partyRelationshipTypeId
     *            联系类型ID
     * @param roleTypeIdTo
     *            要查找的当事人角色类型ID
     * @return
     */
    public static List<GenericValue> getActivePartyRelationships(Delegator delegator, String partyIdTo, String roleTypeIdTo, String partyRelationshipTypeId)
    {
        Map<String, Object> partyRelationshipValues = FastMap.newInstance();
        partyRelationshipValues.put("partyIdTo", partyIdTo);
        partyRelationshipValues.put("roleTypeIdTo", roleTypeIdTo);
        partyRelationshipValues.put("partyRelationshipTypeId", partyRelationshipTypeId);

        return getActivePartyRelationships(delegator, partyRelationshipValues);
    }

    /**
     * 按照当事人ID和关系类型ID,查到到所有到这个联系人的 关系列表
     * 
     * @param delegator
     * @param partyIdTo
     *            要查找的当事人ID
     * @param partyRelationshipTypeId
     *            联系类型ID
     * @return
     */
    public static List<GenericValue> getActivePartyRelationships(Delegator delegator, String partyIdTo, String partyRelationshipTypeId)
    {
        Map<String, Object> partyRelationshipValues = FastMap.newInstance();
        partyRelationshipValues.put("partyIdTo", partyIdTo);
        partyRelationshipValues.put("partyRelationshipTypeId", partyRelationshipTypeId);

        return getActivePartyRelationships(delegator, partyIdTo);
    }

    /**
     * 按照当事人ID,查到到所有到这个联系人的 关系列表
     * 
     * @param delegator
     * @param partyIdTo
     *            要查找的当事人ID
     * @return
     */
    public static List<GenericValue> getActivePartyRelationships(Delegator delegator, String partyIdTo)
    {
        Map<String, Object> partyRelationshipValues = FastMap.newInstance();
        partyRelationshipValues.put("partyIdTo", partyIdTo);

        return getActivePartyRelationships(delegator, partyRelationshipValues);
    }

    /**
     * 按照参数查找的可用当事人关系列表
     * 
     * @param delegator
     * @param partyRelationshipValues
     * @return
     */
    public static List<GenericValue> getActivePartyRelationships(Delegator delegator, Map<String, Object> partyRelationshipValues)
    {
        String partyIdFrom = (String) partyRelationshipValues.get("partyIdFrom");
        String partyIdTo = (String) partyRelationshipValues.get("partyIdTo");
        String roleTypeIdFrom = (String) partyRelationshipValues.get("roleTypeIdFrom");
        String roleTypeIdTo = (String) partyRelationshipValues.get("roleTypeIdTo");
        String partyRelationshipTypeId = (String) partyRelationshipValues.get("partyRelationshipTypeId");
        Timestamp fromDate = UtilDateTime.nowTimestamp();

        List<EntityCondition> condList = FastList.newInstance();
        if (UtilValidate.isNotEmpty(partyIdFrom))
        {
            condList.add(EntityCondition.makeCondition("partyIdFrom", partyIdFrom));
        }
        if (UtilValidate.isNotEmpty(partyIdTo))
        {
            condList.add(EntityCondition.makeCondition("partyIdTo", partyIdTo));
        }
        if (UtilValidate.isNotEmpty(roleTypeIdTo))
        {
            condList.add(EntityCondition.makeCondition("roleTypeIdTo", roleTypeIdTo));
        }
        if (UtilValidate.isNotEmpty(roleTypeIdFrom))
        {
            condList.add(EntityCondition.makeCondition("roleTypeIdFrom", roleTypeIdFrom));
        }
        if (UtilValidate.isNotEmpty(partyRelationshipTypeId))
        {
            condList.add(EntityCondition.makeCondition("partyRelationshipTypeId", partyRelationshipTypeId));
        }

        condList.add(EntityCondition.makeCondition("fromDate", EntityOperator.LESS_THAN_EQUAL_TO, fromDate));
        EntityCondition thruCond = EntityCondition.makeCondition(
                UtilMisc.toList(EntityCondition.makeCondition("thruDate", null), EntityCondition.makeCondition("thruDate", EntityOperator.GREATER_THAN, fromDate)),
                EntityOperator.OR);
        condList.add(thruCond);
        EntityCondition condition = EntityCondition.makeCondition(condList);

        List<GenericValue> partyRelationships = null;
        try
        {
            partyRelationships = delegator.findList("PartyRelationship", condition, null, null, null, false);
        } catch (GenericEntityException e)
        {
            Debug.logError(e, "Problem finding PartyRelationships. ", module);
            return null;
        }
        if (UtilValidate.isNotEmpty(partyRelationships))
        {
            return partyRelationships;
        } else
        {
            return null;
        }
    }

    public static List<GenericValue> getPartiesByRoleTypeId(Delegator delegator, String roleTypeId)
    {
        List<GenericValue> result = FastList.newInstance();

        try
        {
            result = delegator.findList("PartyRole", EntityCondition.makeCondition("roleTypeId", roleTypeId), UtilMisc.toSet("partyId"), UtilMisc.toList("partyId"), null, false);
        } catch (GenericEntityException e)
        {
            e.printStackTrace();
            Debug.log("No parties with role of " + roleTypeId);
            return result;
        }

        return result;
    }

    /**
     * 根据委托方ID得到基本信息<br/>
     * 根据委托方ID得到委托方的基本信息,证书信息,以及各种联系方式联系人信息.<br/>
     * 
     * @param request
     * @param partyId
     * @return
     */
    public static Map<String, Object> getInfoValuesById(ServletRequest request, String partyId)
    {
        Map<String, Object> result = FastMap.newInstance();
        Delegator delegator = DelegatorFactory.getDelegator(request.getParameter("delegator"));
        try
        {
            GenericValue party = delegator.findOne("Party", UtilMisc.toMap("partyId", partyId), false);
            if (UtilValidate.isNotEmpty(party))
            {
                // 查询委托方基本信息,用map存储返回的结果,pg中包含partyGroup,以及法人名称和地址
                Map<String, Object> pg = FastMap.newInstance();
                pg.putAll(PartyWorker.getPartyOtherValues(request, partyId, "party", "person", "partyGroup"));
                pg.put("officialName", CrmUtils.getPartyName(delegator, partyId, "OFFICIAL_NAME"));
                pg.put("localtion", CrmUtils.getContactMechStringByPurpose(delegator, party, "GENERAL_LOCATION"));
                // 查询证书基本信息,用map存储返回的结果,cert中包含证书名称和证书地址
                Map<String, Object> cert = FastMap.newInstance();
                cert.put("certName", CrmUtils.getPartyNameList(delegator, partyId, "CERTIFICATE_NAME"));
                cert.put("localtion", CrmUtils.getContactMechStringByPurpose(delegator, party, "CERTIFICATE_LOCATION"));
                // 查询联系人及其联系信息
                Map<String, Object> cps = FastMap.newInstance();
                cps.put("manager", CrmUtils.getActiveEntrustingContactPersonsInfo(delegator, partyId, "EP_MANAGER"));
                cps.put("sender", CrmUtils.getActiveEntrustingContactPersonsInfo(delegator, partyId, "EP_SENDER"));
                cps.put("payer", CrmUtils.getActiveEntrustingContactPersonsInfo(delegator, partyId, "EP_PAYER"));

                result.put("pg", pg);
                result.put("cert", cert);
                result.put("cps", cps);
            }
        } catch (GenericEntityException e)
        {
            e.printStackTrace();
            Debug.log(e.getMessage(), module);
        }

        return result;
    }

    /**
     * 按照当事人ID查询某种类型的名字的默认值<br/>
     * 按照当事人ID和名字类型ID查询名字默认值,比如查询某个当事人的别名、证书名称、法人名称等<br/>
     * 名字类型ID,可以是 OFFICIAL_NAME(法人名称), ALIAS_NAME(别名),
     * CERTIFICATE_NAME(证书名称).
     * 
     * @param delegator
     * @param partyId
     *            当事人ID
     * @param nameTypeId
     * 
     * @return 名字默认值
     */
    public static GenericValue getPartyName(Delegator delegator, String partyId, String nameTypeId)
    {
        return EntityUtil.getFirst(CrmUtils.getPartyNameList(delegator, partyId, nameTypeId));
    }

    /**
     * 按照当事人ID查询某种类型的名字列表<br/>
     * 按照当事人ID和名字类型ID查询名字列表,比如查询某个当事人的别名、证书名称、法人名称等<br/>
     * 名字类型ID,可以是 OFFICIAL_NAME(法人名称), ALIAS_NAME(别名),
     * CERTIFICATE_NAME(证书名称).
     * 
     * @param delegator
     * @param partyId
     *            当事人ID
     * @param nameTypeId
     * 
     * @return 名字列表
     */
    public static List<GenericValue> getPartyNameList(Delegator delegator, String partyId, String nameTypeId)
    {
        if (UtilValidate.isEmpty(partyId) || UtilValidate.isEmpty(nameTypeId))
        {
            return null;
        }

        try
        {
            Map<String, String> pnFindMap = UtilMisc.toMap("partyId", partyId, "nameTypeId", nameTypeId);
            List<GenericValue> allPNs = EntityUtil.filterByDate(delegator.findByAnd("PartyName", pnFindMap, null, false));
            return allPNs;
        } catch (Exception e)
        {
            e.printStackTrace();
            Debug.log("", module);
            return null;
        }
    }

    /**
     * 按照当事人ID查询名字列表<br/>
     * 
     * @param delegator
     * @param partyId
     *            当事人ID
     * 
     * @return 名字列表
     */
    public static List<GenericValue> getAllPartyNameList(Delegator delegator, String partyId)
    {
        try
        {
            Map<String, String> pnFindMap = UtilMisc.toMap("partyId", partyId);
            List<GenericValue> allPNs = EntityUtil.filterByDate(delegator.findByAnd("PartyName", pnFindMap, null, false));
            return allPNs;
        } catch (Exception e)
        {
            e.printStackTrace();
            Debug.log("", module);
            return null;
        }
    }

    /**
     * 得到客户主要联系人列表<br/>
     * 按照客户ID得到客户联系人列表<br/>
     * 
     * @param delegator
     * @param partyId
     *            客户ID
     * @param roleTypeIdFrom
     *            联系人角色ID
     * @return 联系人实体列表
     */
    public static List<GenericValue> getContactPersonList(Delegator delegator, String partyId, String roleTypeIdFrom)
    {
        List<GenericValue> result = FastList.newInstance();
        List<GenericValue> temGenericValues = CrmUtils.getActiveEntrustingPartyRelationships(delegator, partyId, roleTypeIdFrom);
        if (UtilValidate.isNotEmpty(temGenericValues))
        {
            Iterator<GenericValue> it = temGenericValues.iterator();
            GenericValue tmp = null;
            while (it.hasNext())
            {
                GenericValue genericValue = it.next();
                try
                {
                    tmp = delegator.findOne("Person", UtilMisc.toMap("partyId", genericValue.getString("partyIdFrom")), false);
                    result.add(tmp);
                } catch (GenericEntityException e)
                {
                    e.printStackTrace();
                    Debug.logError(e.getMessage(), module);
                }
            }
        }
        return result;
    }

    /**
     * 按照当事人ID得到客户最新的业务联系人信息<br/>
     * 按照当事人ID得到客户最新的业务联系人信息,以json返回.<br/>
     * 
     * @param delegator
     * @param partyId
     *            当事人客户ID
     * @return 信息集
     */
    public static Map<String, Object> getLastSaleInfo(Delegator delegator, String partyId)
    {
        Map<String, Object> result = FastMap.newInstance();
        try
        {

            GenericValue gv = EntityUtil.getFirst(EntityUtil.filterByDate(delegator.findByAnd("PartyRelationship",
                    UtilMisc.toMap("partyIdTo", partyId, "roleTypeIdFrom", "SALES_REP", "roleTypeIdTo", "ENTRUSTING_PARTY", "partyRelationshipTypeId", "CUSTOMER_CONTACT_REL"),
                    UtilMisc.toList("-fromDate"), false)));
            if (UtilValidate.isEmpty(gv))
            {
                return result;
            }
            String personId = gv.getString("partyIdFrom");
            Map<String, Object> cpovMap = CrmUtils.getContactPartyOtherValues(delegator, personId);
            if (UtilValidate.isNotEmpty(cpovMap))
            {
                if (UtilValidate.isNotEmpty(cpovMap.get("person")))
                {
                    String personPartyId = ((GenericValue) cpovMap.get("person")).getString("partyId");
                    String personName = ((GenericValue) cpovMap.get("person")).getString("nickname");
                    String personPost = ((GenericValue) cpovMap.get("person")).getString("personalTitle");
                    result.put("personPartyId", personPartyId);
                    result.put("personName", personName);
                    result.put("personPost", personPost);
                }
                String personTelno = (String) cpovMap.get("phone");
                String personMobile = (String) cpovMap.get("mobile");
                String personEmail = (String) cpovMap.get("email");

                result.put("personTelno", personTelno);
                result.put("personMobile", personMobile);
                result.put("personEmail", personEmail);
            }
        } catch (GenericEntityException e)
        {
            Debug.logError(e.getMessage(), module);
            e.printStackTrace();
        }
        return result;
    }

    /**
     * getContactMechStringByPurpose<br/>
     * 根据当事人和联系方式目的查询联系方式的字符串结果<br/>
     * 
     * @param delegator
     * @param party
     *            当事人ID
     * @param purposeTypeId
     *            联系方式目的
     * @return 结果集
     */
    public static Map<String, String> getContactMechStringByPurpose(Delegator delegator, GenericValue party, String purposeTypeId)
    {
        Map<String, String> result = FastMap.newInstance();
        Collection<GenericValue> gvList = ContactHelper.getContactMechByPurpose(party, purposeTypeId, false);
        for (Iterator<GenericValue> iterator = gvList.iterator(); iterator.hasNext();)
        {
            GenericValue genericValue = iterator.next();
            result.put(genericValue.getString("contactMechId"), CommonWorkers.getContactMechString(delegator, genericValue));
        }
        return result;
    }

    /**
     * getAgencyList<br/>
     * 查找某一个委托方的所有可用代理<br/>
     * 
     * @param delegator
     * @param partyId
     *            委托方Id
     * @return 可用代理的List
     */
    public static List<GenericValue> getAgencyList(Delegator delegator, String partyId)
    {
        if (UtilValidate.isNotEmpty(partyId))
        {
            List<GenericValue> result = FastList.newInstance();
            List<GenericValue> relList = getActivePartyRelationships(delegator, partyId, "AGENT", "ENTRUSTING_PARTY", "AGENT");
            if (UtilValidate.isNotEmpty(relList))
            {
                for (GenericValue rel : relList)
                {
                    GenericValue partyGroup = null;
                    try
                    {
                        partyGroup = delegator.findOne("PartyGroup", UtilMisc.toMap("partyId", rel.getString("partyIdFrom")), false);
                        if (UtilValidate.isNotEmpty(partyGroup))
                        {
                            result.add(partyGroup);
                        }
                    } catch (GenericEntityException e)
                    {
                        Debug.logError("Do not find a party group with id=" + partyId, module);
                    }
                }
            }
            return result;
        }
        return null;
    }
}
