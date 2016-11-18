package org.ofbiz.ofc.security;

import java.util.List;
import java.util.Map;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

/**
 * 
 * @author apple/mf1389004071 <br/>
 * 2014年11月10日 -|- 下午5:13:19
 */
public class SecurityServices {
    public static final String module = SecurityServices.class.getName();

    /**
     * 删除安全组
     * 
     */
//    public static Map<String, Object> deleteSecurityGroupOfc(DispatchContext dctx,Map<String, ? extends Object> context) {
//        Map<String, Object> result = ServiceUtil.returnSuccess();
//        try {
//            Delegator delegator = dctx.getDelegator();
//            String groupId = (String) context.get("groupId");
//            
//            GenericValue gv =delegator.findOne("SecurityGroup",  UtilMisc.toMap("groupId", groupId), false);
//            if(UtilValidate.isNotEmpty(gv.getString("groupTypeEnumId"))&&("SGT_MNGMNT".equals(gv.getString("groupTypeEnumId"))||"SGT_ORIGIN".equals(gv.getString("groupTypeEnumId")))){
//                return ServiceUtil.returnError("安全组不允许修改");
//            }
//            gv.set("removed", "Y");
//            delegator.createOrStore(gv);
//        } catch (GenericEntityException e) {
//            
//            Debug.logError(e.getMessage(), module);
//            return ServiceUtil.returnError("创建安全组失败"+e.getMessage());
//        }
//        return result;
//    }
//  
    public static Map<String, Object> deleteSecurityGroupOfc(DispatchContext dctx,Map<String, ? extends Object> context) {
        return private_deleteSecurityGroupOfc(dctx, context);
    }
    private static Map<String, Object> private_deleteSecurityGroupOfc(DispatchContext dctx,Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        try {
            Delegator delegator = dctx.getDelegator();
            String groupId = (String) context.get("groupId");

            GenericValue gv =delegator.findOne("SecurityGroup",  UtilMisc.toMap("groupId", groupId), false);
            if(UtilValidate.isNotEmpty(gv.getString("groupTypeEnumId"))&&("SGT_MNGMNT".equals(gv.getString("groupTypeEnumId"))||"SGT_ORIGIN".equals(gv.getString("groupTypeEnumId")))){
                return ServiceUtil.returnError("安全组不允许修改");
            }
            gv.set("removed", "Y");
            delegator.createOrStore(gv);
        } catch (GenericEntityException e) {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError("创建安全组失败"+e.getMessage());
        }
        return result;
    }
    /**
     * 删除权限
     * 
     */
    public static Map<String, Object> deleteSecurityPermissionOfc(DispatchContext dctx,Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        try {
            Delegator delegator = dctx.getDelegator();
            String permissionId = (String) context.get("permissionId");
            GenericValue gv =delegator.findOne("SecurityPermission",  UtilMisc.toMap("permissionId", permissionId), false);
            gv.set("removed", "Y");
            delegator.createOrStore(gv);
            delegator.removeByAnd("SecurityGroupPermission", UtilMisc.toMap("permissionId", permissionId));
        } catch (GenericEntityException e) {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError("删除权限"+e.getMessage());
        }
        return result;
    }
    
    /**
     * 新建权限
     * 
     */
    public static Map<String, Object> createSecurityPermissionOfc(DispatchContext dctx,Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        try {
            GenericValue userLogin = (GenericValue) context.get("userLogin");
            Delegator delegator = dctx.getDelegator();
            String permissionId = (String) context.get("permissionId");
            
            GenericValue gv =delegator.makeValue("SecurityPermission",  UtilMisc.toMap("permissionId", permissionId));
            gv.setNonPKFields(context);
            gv.set("removed", "N");
            delegator.createOrStore(gv);
            
            GenericValue systemGv =delegator.findOne("Enumeration", UtilMisc.toMap("enumId", "SYSTEM_AUTH_SET"), true);
            String groupId =systemGv.getString("enumCode");
            dispatcher.runSync("addSecurityPermissionToSecurityGroupOfc", UtilMisc.toMap("userLogin",userLogin,"groupId", groupId,"permissionId", permissionId));
        } catch (GenericEntityException e) {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError("新建权限"+e.getMessage());
        } catch (GenericServiceException e) {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError("新建权限到原始安全组"+e.getMessage());
        }
        return result;
    }
    /**
     * 批量新增和删除权限
     * 
     */
    public static Map<String, Object> storeSecurityPermissionToSecurityGroupOfc(DispatchContext dctx,Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        try {
            Delegator delegator = dctx.getDelegator();
            GenericValue userLogin = (GenericValue) context.get("userLogin");
            String groupId = (String) context.get("groupId");
            String permissionIdListString = (String) context.get("permissionIdList");

            String[] permissionIdList={};
            if(UtilValidate.isNotEmpty(context.get("permissionIdList"))){
                permissionIdList = permissionIdListString.split(",");
            }
            List<GenericValue> oldPermissionList =delegator.findByAnd("SecurityGroupPermission",  UtilMisc.toMap("groupId", groupId),UtilMisc.toList("groupId"),false);
            
            List<String> addPermissionIdList=FastList.newInstance();
            for(int i=0;i<permissionIdList.length;i++){
                String newPermissionId =permissionIdList[i];
                if(!containsPermission(newPermissionId,oldPermissionList)){
                    addPermissionIdList.add(newPermissionId);
                }
                
            }
            List<String> removePermissionIdList=FastList.newInstance();
            for(GenericValue oldGv:oldPermissionList){
                String oldPermissionId =oldGv.getString("permissionId");
                if(!equalsPermission(oldPermissionId,permissionIdList)){
                    removePermissionIdList.add(oldPermissionId);
                }
            }
            
            
            for(String addPermissionId:addPermissionIdList){
                dispatcher.runSync("addSecurityPermissionToSecurityGroupOfc", UtilMisc.toMap("userLogin",userLogin,"groupId", groupId,"permissionId", addPermissionId));
            }
            for(String removePermissionId:removePermissionIdList){
                dispatcher.runSync("removeSecurityPermissionFromSecurityGroupOfc", UtilMisc.toMap("userLogin",userLogin,"groupId", groupId,"permissionId", removePermissionId));
                //delegator.removeByAnd("SecurityGroupPermission", UtilMisc.toMap("groupId", groupId,"permissionId", removePermissionId));
                
            }
            
            
        } catch (GenericEntityException e) {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError("批量新增和删除权限"+e.getMessage());
        } catch (GenericServiceException e) {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError("批量新增和删除权限"+e.getMessage());
        }
        return result;
    }
    //包含权限
    private static boolean containsPermission(String newPermissionId,List<GenericValue> oldPermissionList){
        for(GenericValue oldGv:oldPermissionList){
            String oldPermissionId =oldGv.getString("permissionId");
            if(oldPermissionId.equals(newPermissionId)){
                return true;
            }
        }
        return false;
        
    }
    //包含权限
    private static boolean equalsPermission(String oldPermissionId,String[] newPermissionList){
            for(String newPermissionId:newPermissionList){
                if(oldPermissionId.equals(newPermissionId)){
                    return true;
                }
            }
            return false;
            
        }
    
    
    
    
    
    /**
     * 批量新增和删除角色
     * 
     */
    public static Map<String, Object> storePartyGroupRole(DispatchContext dctx,Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        try {
            Delegator delegator = dctx.getDelegator();
            GenericValue userLogin = (GenericValue) context.get("userLogin");
            String partyId = (String) context.get("partyId");
            String roleTypeIdListString = (String) context.get("roleIdList");
            if(UtilValidate.isNotEmpty(roleTypeIdListString)){
                
            }
            String[] roleTypeIdList={};
            if(UtilValidate.isNotEmpty(roleTypeIdListString)){
                roleTypeIdList=roleTypeIdListString.split(",");
            }
            List<GenericValue> oldRoleIdList =delegator.findByAnd("PartyRole",  UtilMisc.toMap("partyId", partyId),UtilMisc.toList("partyId"),false);
            
            List<String> addRoleTypeIdList=FastList.newInstance();
            for(int i=0;i<roleTypeIdList.length;i++){
                String newRoleId =roleTypeIdList[i];
                if(!containsRoleType(newRoleId,oldRoleIdList)){
                    addRoleTypeIdList.add(newRoleId);
                }
                
            }
            List<String> removeRoleTypeIdList=FastList.newInstance();
            for(GenericValue oldGv:oldRoleIdList){
                String oldRoleTypeId =oldGv.getString("roleTypeId");
                if("OWNER".equals(oldRoleTypeId)||"_NA_".equals(oldRoleTypeId)){
                   continue;
                }
                    if(!equalsRoleType(oldRoleTypeId,roleTypeIdList)){
                        removeRoleTypeIdList.add(oldRoleTypeId);
                    }
                
                
            }
            
            for(String addRoleTypeId:addRoleTypeIdList){
                dispatcher.runSync("createPartyRole", UtilMisc.toMap("userLogin",userLogin,"partyId", partyId,"roleTypeId", addRoleTypeId));
            }
            for(String removeRoleTypeId:removeRoleTypeIdList){
                dispatcher.runSync("deletePartyRole", UtilMisc.toMap("userLogin",userLogin,"partyId", partyId,"roleTypeId", removeRoleTypeId));
                
            }
            
            
        } catch (GenericEntityException e) {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError("批量新增和删除角色"+e.getMessage());
        } catch (GenericServiceException e) {
            Debug.logError(e.getMessage(), module);
            return ServiceUtil.returnError("批量新增和删除角色"+e.getMessage());
        }
        return result;
    }
    
    
    //包含角色
        private static boolean containsRoleType(String newId,List<GenericValue> oldPermissionList){
            for(GenericValue oldGv:oldPermissionList){
                String oldId =oldGv.getString("roleTypeId");
                if(oldId.equals(newId)){
                    return true;
                }
            }
            return false;
            
        }
        //包含角色
        private static boolean equalsRoleType(String oldId,String[] newList){
                for(String newId:newList){
                    if(oldId.equals(newId)){
                        return true;
                    }
                }
                return false;
                
            }
    
}
