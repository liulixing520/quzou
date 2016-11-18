package org.ofbiz.system;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;
import javolution.util.FastSet;

import org.ofbiz.base.util.Debug;
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
public class ContactMechTools {
	public static final String module = ContactMechTools.class.getName();
	/**
	 * 获取首选地址、电话、邮箱地址 PRIMARY_PHONE PRIMARY_EMAIL PRIMARY_LOCATION
	 * @param delegator
	 * @param partyId
	 * @param showOld
	 * @param contactMechTypeId
	 * @return
	 */
	public static Map<String, Object> getPrimaryPartyContactMechValueMaps(Delegator delegator, String partyId, boolean showOld) {
        List<Map<String, Object>> partyContactMechValueMaps = FastList.newInstance();

        List<GenericValue> allPartyContactMechs = null;
        Map partyContactMechValueMap=new HashMap();
        try {
        	List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("contactMechPurposeTypeId", EntityOperator.IN,
        			 UtilMisc.toList("PRIMARY_PHONE", "PRIMARY_EMAIL","PRIMARY_LOCATION","PHONE_MOBILE")),
            EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId));
            EntityConditionList condition = EntityCondition.makeCondition(exprs, EntityOperator.AND);

            List<GenericValue> tempCol =  delegator.findList("PartyContactDetailByPurposeAndCity",condition, null, null, null, false);

            if (!showOld) tempCol = EntityUtil.filterByDate(tempCol, true);
            allPartyContactMechs = tempCol;
        } catch (GenericEntityException e) {
            Debug.logWarning(e, module);
        }

       
        for (GenericValue contactMech: allPartyContactMechs) {
         
            
                try {
                    if ("PRIMARY_LOCATION".equals(contactMech.getString("contactMechPurposeTypeId"))) {
                        partyContactMechValueMap.put("postalAddress", contactMech);
                    } else if ("PRIMARY_PHONE".equals(contactMech.getString("contactMechPurposeTypeId"))) {
                        partyContactMechValueMap.put("telecomNumber", contactMech);
                    } else if ("PHONE_MOBILE".equals(contactMech.getString("contactMechPurposeTypeId"))) {
                        partyContactMechValueMap.put("mobileNumber", contactMech);
                    }else if("EMAIL_ADDRESS".equals(contactMech.getString("contactMechTypeId"))){
                    	partyContactMechValueMap.put("emailAddress", contactMech);
                    }
                } catch (Exception e) {
                    Debug.logWarning(e, module);
                }
              
        }

        return partyContactMechValueMap;
    }
	 public static List<GenericValue> getAssociatedStateList(Delegator delegator, String country) {
		 	if(UtilValidate.isEmpty(country)) return null;
	        return getAssociatedStateList(delegator, country, null);
	    }

	    /**
	     * Returns a list of regional geo associations.
	     */
	    public static List<GenericValue> getAssociatedStateList(Delegator delegator, String country, String listOrderBy) {
	        if (UtilValidate.isEmpty(country)) {
	            // Load the system default country
	            country = UtilProperties.getPropertyValue("general.properties", "country.geo.id.default");
	        }
	        EntityCondition stateProvinceFindCond = EntityCondition.makeCondition(
	                EntityCondition.makeCondition("geoIdFrom", country),
	                EntityCondition.makeCondition("geoAssocTypeId", "REGIONS"),
	                EntityCondition.makeCondition(EntityOperator.OR,
	                        EntityCondition.makeCondition("geoTypeId", "STATE"),
	                        EntityCondition.makeCondition("geoTypeId", "PROVINCE"),
	                        EntityCondition.makeCondition("geoTypeId", "MUNICIPALITY"),
	                        //添加城市
	                        EntityCondition.makeCondition("geoTypeId", "COUNTY_CITY"),
	                        EntityCondition.makeCondition("geoTypeId", "CITY"),
	                        EntityCondition.makeCondition("geoTypeId", "COUNTY")));

	        if (UtilValidate.isEmpty(listOrderBy)) {
	            listOrderBy = "geoId";
	        }
	        List<String> sortList = UtilMisc.toList(listOrderBy);

	        List<GenericValue> geoList = FastList.newInstance();
	        try {
	            geoList = delegator.findList("GeoAssocAndGeoTo", stateProvinceFindCond, null, sortList, null, true);
	        } catch (GenericEntityException e) {
	            Debug.logError(e, "Cannot lookup Geo", module);
	        }
	        return geoList;
	    }
	    public static List<GenericValue> getPartyPostalContactMech(Delegator delegator, String partyId, boolean showOld) {
	    	return  getPartyPostalContactMech( delegator,  partyId,  showOld,null,null);
	    }
	    /**
		 * 获取收货地址
		 * @param delegator
		 * @param partyId
		 * @param showOld
		 * @param contactMechTypeId 
		 * @param contactMechPurposeTypeId
		 * @return
		 */
		public static List<GenericValue> getPartyPostalContactMech(Delegator delegator, String partyId, boolean showOld,String contactMechId,String contactMechPurposeTypeId) {
	        List<Map<String, Object>> partyContactMechValueMaps = FastList.newInstance();

	        List<GenericValue> allPartyContactMechs = null;
	        Map partyContactMechValueMap=new HashMap();
	        try {
	        	List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("contactMechPurposeTypeId", EntityOperator.IN,
	        			 UtilMisc.toList(contactMechPurposeTypeId!=null?contactMechPurposeTypeId:"SHIPPING_LOCATION")));
	        	if(partyId!=null){
	        		exprs.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId));
	        	}
	        	if(contactMechId!=null){
	        		exprs.add(EntityCondition.makeCondition("contactMechId", EntityOperator.EQUALS, contactMechId));
	        	}
	            EntityConditionList condition = EntityCondition.makeCondition(exprs, EntityOperator.AND);

	            List<GenericValue> tempCol =  delegator.findList("PartyContactDetailByPurposeAndCity",condition, null, null, null, false);

	            if (!showOld) tempCol = EntityUtil.filterByDate(tempCol, true);
	            allPartyContactMechs = tempCol;
	        } catch (GenericEntityException e) {
	            Debug.logWarning(e, module);
	        }


	        return allPartyContactMechs;
	    }
		/**
		 * 获取仓库发货地址
		 * @param delegator
		 * @param facilityId
		 * @param showOld
		 * @param contactMechTypeId 
		 * @param contactMechPurposeTypeId
		 * @return
		 */
		public static List<GenericValue> getFacilityPostalContactMech(Delegator delegator, String facilityId, boolean showOld,String contactMechId,String contactMechPurposeTypeId) {
	        List<Map<String, Object>> facilityContactMechValueMaps = FastList.newInstance();

	        List<GenericValue> allFacilityContactMechs = null;
	        Map facilityContactMechValueMap=new HashMap();
	        try {
	        	List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("contactMechPurposeTypeId", EntityOperator.IN,
	        			 UtilMisc.toList(contactMechPurposeTypeId!=null?contactMechPurposeTypeId:"SHIP_ORIG_LOCATION")));
	        	if(facilityId!=null){
	        		exprs.add(EntityCondition.makeCondition("facilityId", EntityOperator.EQUALS, facilityId));
	        	}
	        	if(contactMechId!=null){
	        		exprs.add(EntityCondition.makeCondition("contactMechId", EntityOperator.EQUALS, contactMechId));
	        	}
	            EntityConditionList condition = EntityCondition.makeCondition(exprs, EntityOperator.AND);

	            List<GenericValue> tempCol =  delegator.findList("FacilityContactDetailByPurposeAndCity",condition, null, null, null, false);

	            if (!showOld) tempCol = EntityUtil.filterByDate(tempCol, true);
	            allFacilityContactMechs = tempCol;
	        } catch (GenericEntityException e) {
	            Debug.logWarning(e, module);
	        }


	        return allFacilityContactMechs;
	    }
		/**
		 * 获取省-市-县中文名称
		 * @param delegator
		 * @param partyId
		 * @param showOld
		 * @param contactMechTypeId
		 * @return
		 */
		public static String getAddressGeoAllCn(Delegator delegator,String stateProvinceGeoId,String cityGeoId,String countyGeoId) {
	        
	        String AddressGeoAllCn="";
	        try {
	        	List<EntityExpr> exprs = UtilMisc.toList(EntityCondition.makeCondition("geoId", EntityOperator.IN,
	        			 UtilMisc.toList(stateProvinceGeoId,cityGeoId,countyGeoId)));
	        	
	            EntityConditionList condition = EntityCondition.makeCondition(exprs);
	            List<GenericValue> tempCol =  delegator.findList("Geo",condition, null, null, null, false);
	            for(GenericValue gc:tempCol){
	            	AddressGeoAllCn+=gc.getString("geoName")+"-";
	            }
	        } catch (GenericEntityException e) {
	            Debug.logWarning(e, module);
	        }
	        return (AddressGeoAllCn.length()>0)?AddressGeoAllCn.substring(0,AddressGeoAllCn.length()-1):AddressGeoAllCn;
	    }
		
		/*
		 * 获取收货地址信息列表
		 */
		public static List<Map<String, Object>> getPartyContactMechValueMaps(Delegator delegator, String partyId, boolean showOld, String contactMechTypeId) {
	        List<Map<String, Object>> partyContactMechValueMaps = FastList.newInstance();

	        List<GenericValue> allPartyContactMechs = null;

	        try {
	            List<GenericValue> tempCols = delegator.findByAnd("PartyContactMechPurpose", UtilMisc.toMap("partyId", partyId,"contactMechPurposeTypeId","SHIPPING_LOCATION"));
	            FastSet contactMechSet = FastSet.newInstance();
	            for(GenericValue tempCol:tempCols){
	            	contactMechSet.add(tempCol.getString("contactMechId"));
	            }
	            EntityCondition condition_1 = EntityCondition.makeCondition(UtilMisc.toMap("partyId", partyId));
	            EntityCondition condition_2 = EntityCondition.makeCondition("contactMechId",EntityOperator.IN,contactMechSet);
	            tempCols = delegator.findList("PartyContactMech", EntityCondition.makeCondition(UtilMisc.toList(condition_1,condition_2)), null, null, null, false);
	            if (contactMechTypeId != null) {
	                List<GenericValue> tempColTemp = FastList.newInstance();
	                for (GenericValue partyContactMech: tempCols) {
	                    GenericValue contactMech = delegator.getRelatedOne("ContactMech", partyContactMech);
	                    if (contactMech != null && contactMechTypeId.equals(contactMech.getString("contactMechTypeId"))) {
	                        tempColTemp.add(partyContactMech);
	                    }

	                }
	                tempCols = tempColTemp;
	            }
	            if (!showOld) tempCols = EntityUtil.filterByDate(tempCols, true);
	            allPartyContactMechs = tempCols;
	        } catch (GenericEntityException e) {
	            Debug.logWarning(e, module);
	        }

	        if (allPartyContactMechs == null) return partyContactMechValueMaps;

	        for (GenericValue partyContactMech: allPartyContactMechs) {
	            GenericValue contactMech = null;

	            try {
	                contactMech = partyContactMech.getRelatedOne("ContactMech");
	            } catch (GenericEntityException e) {
	                Debug.logWarning(e, module);
	            }
	            if (contactMech != null) {
	                Map<String, Object> partyContactMechValueMap = FastMap.newInstance();

	                partyContactMechValueMaps.add(partyContactMechValueMap);
	                partyContactMechValueMap.put("contactMech", contactMech);
	                partyContactMechValueMap.put("partyContactMech", partyContactMech);

	                try {
	                    partyContactMechValueMap.put("contactMechType", contactMech.getRelatedOneCache("ContactMechType"));
	                } catch (GenericEntityException e) {
	                    Debug.logWarning(e, module);
	                }

	                try {
	                    List<GenericValue> partyContactMechPurposes = partyContactMech.getRelated("PartyContactMechPurpose");

	                    if (!showOld) partyContactMechPurposes = EntityUtil.filterByDate(partyContactMechPurposes, true);
	                    partyContactMechValueMap.put("partyContactMechPurposes", partyContactMechPurposes);
	                } catch (GenericEntityException e) {
	                    Debug.logWarning(e, module);
	                }

	                try {
	                    if ("POSTAL_ADDRESS".equals(contactMech.getString("contactMechTypeId"))) {
	                        partyContactMechValueMap.put("postalAddress", contactMech.getRelatedOne("PostalAddress"));
	                    } else if ("TELECOM_NUMBER".equals(contactMech.getString("contactMechTypeId"))) {
	                        partyContactMechValueMap.put("telecomNumber", contactMech.getRelatedOne("TelecomNumber"));
	                    }
	                } catch (GenericEntityException e) {
	                    Debug.logWarning(e, module);
	                }
	            }
	        }

	        return partyContactMechValueMaps;
	    }
}
