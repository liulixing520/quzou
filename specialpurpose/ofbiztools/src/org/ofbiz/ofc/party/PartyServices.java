package org.ofbiz.ofc.party;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javolution.util.FastList;

import org.ofbiz.base.crypto.HashCrypt;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.common.authentication.AuthHelper;
import org.ofbiz.common.authentication.api.AuthenticatorException;
import org.ofbiz.common.login.LoginServices;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

public class PartyServices {
	public static final String module = LoginServices.class.getName();
    public static final String resource = "SecurityextUiLabels";
	
	
	 public static Map<String, Object> updatePassword(DispatchContext ctx, Map<String, ?> context) {
	        Delegator delegator = ctx.getDelegator();
	        LocalDispatcher dispatcher = ctx.getDispatcher();
	        GenericValue loggedInUserLogin = (GenericValue) context.get("userLogin");
	        Locale locale = (Locale) context.get("locale");
	        Map<String, Object> result = ServiceUtil.returnSuccess(UtilProperties.getMessage(resource, "loginevents.password_was_changed_with_success", locale));

	        boolean useEncryption = "true".equals(UtilProperties.getPropertyValue("security.properties", "password.encrypt"));
	        boolean adminUser = false;

	        String userLoginId = (String) context.get("userLoginId");
	        String errMsg = null;
	        
	        try {
				Map map = dispatcher.runSync("validateSmsCheckNumber", 
						UtilMisc.toMap("mobiles", context.get("oldMobilePhone"),"checkNumber", context.get("phoneCaptchaCode")));
				String isSuccess = (String) map.get("isSuccess");
				if(!isSuccess.equals("Y")){
					return ServiceUtil.returnError("手机短信验证码不正确");
				}
	        } catch (GenericServiceException e1) {
				return ServiceUtil.returnError("check Phone error");
			}
	        
	        if (UtilValidate.isEmpty(userLoginId)) {
	            userLoginId = loggedInUserLogin.getString("userLoginId");
	        }
	        
	        String currentPassword = (String) context.get("currPassword");
	        String newPassword = (String) context.get("newPassword");
	        String newPasswordVerify = (String) context.get("newPasswordVerify");
	        String passwordHint = (String) context.get("passwordHint");

	        GenericValue userLoginToUpdate = null;

	        try {
	            userLoginToUpdate = delegator.findOne("UserLogin", false, "userLoginId", userLoginId);
	        } catch (GenericEntityException e) {
	            Map<String, String> messageMap = UtilMisc.toMap("errorMessage", e.getMessage());
	            errMsg = UtilProperties.getMessage(resource,"loginservices.could_not_change_password_read_failure", messageMap, locale);
	            return ServiceUtil.returnError(errMsg);
	        }

	        if (userLoginToUpdate == null) {
	            // this may be a full external authenticator; first try authenticating
	            boolean authenticated = false;
	            try {
	                authenticated = AuthHelper.authenticate(userLoginId, currentPassword, true);
	            } catch (AuthenticatorException e) {
	                // safe to ingore this; but we'll log it just in case
	                Debug.logWarning(e, e.getMessage(), module);
	            }

	            // call update password if auth passed
	            if (authenticated) {
	                try {
	                    AuthHelper.updatePassword(userLoginId, currentPassword, newPassword);
	                } catch (AuthenticatorException e) {
	                    Debug.logError(e, e.getMessage(), module);
	                    Map<String, String> messageMap = UtilMisc.toMap("userLoginId", userLoginId);
	                    errMsg = UtilProperties.getMessage(resource,"loginservices.could_not_change_password_userlogin_with_id_not_exist", messageMap, locale);
	                    return ServiceUtil.returnError(errMsg);
	                }
	                //result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
	                result.put("updatedUserLogin", userLoginToUpdate);
	                return result;
	            } else {
	                Map<String, String> messageMap = UtilMisc.toMap("userLoginId", userLoginId);
	                errMsg = UtilProperties.getMessage(resource,"loginservices.could_not_change_password_userlogin_with_id_not_exist", messageMap, locale);
	                return ServiceUtil.returnError(errMsg);
	            }
	        }

	        if ("true".equals(UtilProperties.getPropertyValue("security.properties", "password.lowercase"))) {
	            currentPassword = currentPassword.toLowerCase();
	            newPassword = newPassword.toLowerCase();
	            newPasswordVerify = newPasswordVerify.toLowerCase();
	        }

	        List<String> errorMessageList = FastList.newInstance();
	        if (newPassword != null) {
	            LoginServices.checkNewPassword(userLoginToUpdate, currentPassword, newPassword, newPasswordVerify,
	                passwordHint, errorMessageList, adminUser, locale);
	        }

	        if (errorMessageList.size() > 0) {
	            return ServiceUtil.returnError(errorMessageList);
	        }

	        String externalAuthId = userLoginToUpdate.getString("externalAuthId");
	        if (UtilValidate.isNotEmpty(externalAuthId)) {
	            // external auth is set; don't update the database record
	            try {
	                AuthHelper.updatePassword(externalAuthId, currentPassword, newPassword);
	            } catch (AuthenticatorException e) {
	                Debug.logError(e, e.getMessage(), module);
	                Map<String, String> messageMap = UtilMisc.toMap("errorMessage", e.getMessage());
	                errMsg = UtilProperties.getMessage(resource,"loginservices.could_not_change_password_write_failure", messageMap, locale);
	                return ServiceUtil.returnError(errMsg);
	            }
	        } else {
	            userLoginToUpdate.set("currentPassword", useEncryption ? HashCrypt.cryptUTF8(LoginServices.getHashType(), null, newPassword) : newPassword, false);
	            userLoginToUpdate.set("passwordHint", passwordHint, false);
	            userLoginToUpdate.set("requirePasswordChange", "N");

	            try {
	                userLoginToUpdate.store();
	                LoginServices.createUserLoginPasswordHistory(delegator,userLoginId, newPassword);
	            } catch (GenericEntityException e) {
	                Map<String, String> messageMap = UtilMisc.toMap("errorMessage", e.getMessage());
	                errMsg = UtilProperties.getMessage(resource,"loginservices.could_not_change_password_write_failure", messageMap, locale);
	                return ServiceUtil.returnError(errMsg);
	            }
	        }

	        //result.put(ModelService.RESPONSE_MESSAGE, ModelService.RESPOND_SUCCESS);
	        result.put("updatedUserLogin", userLoginToUpdate);
	        return result;
	    }
}
