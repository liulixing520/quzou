import org.ofbiz.service.ServiceUtil
import org.ofbiz.base.util.UtilProperties
import org.ofbiz.common.login.LoginServices

module="modifyCurrentUserPassword.groovy"

if(!userLogin)
{
	request.setAttribute("rtMsg","登陆超时，请退出重新登录系统！")
	return "success"
}

currentPassword = parameters.password
newPassword = parameters.newPassword
newPasswordVerify = parameters.newPasswordVerify

if(!currentPassword || !newPassword || !newPasswordVerify)
{
	request.setAttribute("rtMsg","修改密码失败，数据丢失！")
	return "success"
}

if(!newPassword.trim().equals(newPasswordVerify.trim()))
{
	request.setAttribute("rtMsg","两次密码输入不一致！")
	return "success"
}

passwordMatches = LoginServices.checkPassword(userLogin.currentPassword, "true".equals(UtilProperties.getPropertyValue("security.properties", "password.encrypt")),currentPassword)

if(!passwordMatches)
{
	request.setAttribute("rtMsg","旧密码不正确！")
	return "success"
}
serviceParam = [:]
serviceParam.userLogin = userLogin
serviceParam.userLoginId = userLogin.userLoginId
serviceParam.currentPassword = currentPassword
serviceParam.newPassword = newPassword.trim()
serviceParam.newPasswordVerify = newPasswordVerify.trim()

result = dispatcher.runSync("updatePassword",serviceParam)

if(ServiceUtil.isSuccess(result))
{
	request.setAttribute("rtMsg","修改成功！")
	return "success"
}

else
{
	request.setAttribute("rtMsg",ServiceUtil.getErrorMessage(result))
	return "success"
}