<script src="/portal/images/js/jquery-1.11.1.js" type="text/javascript"></script>

<script src="/portal/images/validate/jquery.metadata.js" type="text/javascript"></script>
<script src="/portal/images/validate/jquery.validate.js" type="text/javascript"></script>

<script src="/portal/images/validate/checkIdCard.js" type="text/javascript"></script>
<script src="/portal/images/validate/additional-methods.js" type="text/javascript"></script>
<script src="/sysCommon/images/js/common.js" type="text/javascript"></script>
<link href="../images/css/registe_com.css" rel="stylesheet" type="text/css" />
<script>
    function validateInputForm(){
        $('#inputForm').validate({
            errorPlacement: function(error, element) {
                element.parents("tr").removeClass("tr-normal").removeClass("tr-ok").addClass("tr-error");
            },
            success : function(label, element) {
                $(element).parents("tr").removeClass("tr-normal").removeClass("tr-error").addClass("tr-ok");;
            },
            rules: {

                username: {
                    required: true,
                    //alphanumeric:true,
                    minlength: 6
                },
                password: {
                    required: true,
                    minlength: 4
                },
                passwordVerify: {
                    required: true,
                    minlength: 4,
                    equalTo:"#password"
                },
                
                
                personBankCode: {
                    required: true
                },
                personBankId: {
                    required: true
                },
                personBankUserName: {
                    required: true
                },
                personBankAddress: {
                    required: true
                },
                personProvince: {
                    required: true
                },
                //personCity: {
                //    required: true
                //},
                mobilePhone: {
                    required: true,
                    checkMobile:true
                },
                phoneCaptchaCode:{
                    required:true
                }
            }
        });
	}
	
	function validateEnterpriseRegisterForm(){
	
	
        $("#EnterpriseRegisterForm").validate({
            errorPlacement: function(error, element){
                element.parents("tr").removeClass("tr-normal").removeClass("tr-ok").addClass("tr-error");
            },
            success : function(label, element) {
                $(element).parents("tr").removeClass("tr-normal").removeClass("tr-error").addClass("tr-ok");;
            },
            rules: {
                username: {
                    required: true,
                    //alphanumeric:true,
                    minlength: 6
                },
                password: {
                    required: true,
                    minlength: 4
                },
                passwordVerify: {
                    required: true,
                    minlength: 4,
                    equalTo:"#enterprisePassword"
                },
                groupName: {
                    required: true
                },
                
                bankCode: {
                    required: true
                },
                bankId: {
                    required: true
                },
                bankUserName: {
                    required: true
                },
                bankAddress: {
                    required: true         
                },
                
                province: {
                    required: true
                },
                //city: {
                //    required: true
                //},
                
                
                
                imageCaptchaCode: {
                    required: true
                },
                mobilePhone: {
                    required: true,
                    checkMobile: true
                },
                phoneCaptchaCode:{
                    required: true
                }
            }
        })
    }
    
    
    
function register(){
	validateInputForm();
	var form = $("#inputForm");
	var myValidator = jQuery(form).validate().form();
	if(myValidator == false)return;
	//验证用户名
	var isUser = checkUniqueExisted('personUsername');
	if(isUser == true)return;
	
	//比对验证码
	var isOK = checkRegRandomCode('personImageCode');
	if(isOK == false)return;
	//验证手机号码
	var isPhone = checkPhone('mobilePhone');
	if(isPhone == true)return;
	
	var username = $("#personUsername").val();
	var password = $("#password").val();
	var passwordVerify = $("#passwordVerifyCust").val();
	var mobilePhone = $("#mobilePhone").val();
	var phoneCaptchaCode = $("#personCaptchaCode").val();
	
	
	var bankCode = $("#personBankCode").val();
	var bankId = $("#personBankId").val();
	var bankUserName = $("#personBankUserName").val();
	var bankAddress = $("#personBankAddress").val();
	
	var bankProvince = $("#personProvince").val();
	var bankCity = $("#personCity").val();
	var storeName = $("#storeName").val();
	
		$.ajax({
	      url: '/portal/control/createseller',
	      type: "POST",
	      async : false,
	      data: {
	          usePrimaryEmailUsername:'Y',USE_ADDRESS:'false',sellerType:'PERSONAL_SELLER',CUSTOMER_EMAIL:username,PASSWORD:password,CONFIRM_PASSWORD:passwordVerify,
	          storeName:storeName,mobilePhone:mobilePhone,phoneCaptchaCode:phoneCaptchaCode,bankCode:bankCode,
	          bankId:bankId,bankUserName:bankUserName,bankAddress:bankAddress,bankProvince:bankProvince,bankCity:bankCity
	      },
	      success: function(data) {
	      	  //var _IS_REGISTER_ = data._IS_REGISTER_;
	      	  var _IS_REGISTER_="TRUE";
	      	  if(_IS_REGISTER_=="TRUE"){
		      	  alert("供应商注册成功!");
		          location.href="/portal/control/main";
	      	  }else{
	      	  	console.log(data);
	      	  	for(var i = 0 ; i <data._ERROR_MESSAGE_LIST_.length;i++){
	      	  		alert(data._ERROR_MESSAGE_LIST_[i]);
	      	  	}
	      	  	
	      	  }
	          
	      }
	  });
	
}



function registerGYS(){
	validateEnterpriseRegisterForm();
	var form = $("#EnterpriseRegisterForm");
	var myValidator = jQuery(form).validate().form();
	if(myValidator == false)return;
	//验证用户名
	var isUser = checkUniqueExisted('enterpriseUsername');
	if(isUser == true)return;
	//验证手机号码
	var isPhone = checkPhone('enterprisePhone');
	if(isPhone == true)return;
	//比对验证码
	var isOK = checkRegRandomCode('enterpriseImageCode');
	if(isOK == false)return;
	
	var username = $("#enterpriseUsername").val();
	var password = $("#enterprisePassword").val();
	var passwordVerify = $("#passwordVerify").val();
	var groupName = $("#groupName").val();
	var mobilePhone = $("#enterprisePhone").val();
	var phoneCaptchaCode = $("#enterpriseCaptchaCode").val();
	
	var bankCode = $("#bankCode").val();
	var bankId = $("#bankId").val();
	var bankUserName = $("#bankUserName").val();
	var bankAddress = $("#bankAddress").val();
	
	var bankProvince = $("#province").val();
	var bankCity = $("#city").val();
	var storeName = $("#storeNameGys").val();
		$.ajax({
	      url: '/portal/control/createseller',
	      type: "POST",
	      async : false,
	      data: {
	          usePrimaryEmailUsername:'Y',USE_ADDRESS:'false',sellerType:'ENTERPRISE_SELLER',CUSTOMER_EMAIL:username,PASSWORD:password,CONFIRM_PASSWORD:passwordVerify,groupName:groupName,
	          storeName:storeName,mobilePhone:mobilePhone,phoneCaptchaCode:phoneCaptchaCode,bankCode:bankCode,
	          bankId:bankId,bankUserName:bankUserName,bankAddress:bankAddress,bankProvince:bankProvince,bankCity:bankCity
	      },
	      success: function(data) {
	      	 //var _IS_REGISTER_ = data._IS_REGISTER_;
	      	  var _IS_REGISTER_="TRUE";
	      	  if(_IS_REGISTER_=="TRUE"){
		      	  alert("供应商注册成功!");
		          location.href="/portal/control/main";
	      	  }else{
	      	  	console.log(data);
	      	  	for(var i = 0 ; i <data._ERROR_MESSAGE_LIST_.length;i++){
	      	  		alert(data._ERROR_MESSAGE_LIST_[i]);
	      	  	}
	      	  }
	      }
	  });
	
	
}
</script>

 <div class="page" style="margin-top:20px;margin-bottom:-40px">	
 <div class="form-head" style="height:50px;">
      <a href="<@ofbizUrl>main</@ofbizUrl>" style="float:left;">
      	<img src="../images/logo-1x.png" style="border:none;"/></a>
      <h2 style="margin-bottom:10px; float:left;">填写注册信息</h2>
      <div style="margin-top:20px;">已经是会员？<a href="/portal/control/buyerlogin">登录</a></div>
 </div> 
	<div id="content" >
            <div >
                <div id="reg-tab-list">
                    <ul>
                        <li class="reg-tab-li reg-choose" onclick="changeRegisteTab('#company-tab', this)">${uiLabelMap.EnterPriseRegisterSeller}</li>
                        <li class="reg-tab-li" onclick="changeRegisteTab('#phone-tab', this)">${uiLabelMap.PersonalRegisterSeller}</li>
                        <div class="clear"></div>
                    </ul>
                </div>


                <div id="phone-tab" class="tab-part fd-clr" style="display: none;">
                    <div class="form-part">
                        <form action="#" method="post" id="inputForm">
                            <table>
                                <tbody>
                                
                                <tr class="tr-normal">
                                    <td class="col1">
                                        <p>${uiLabelMap.UserName}<span class="required">*</span></p>
                                    </td>

                                    <td class="col2">
                                        <input class="text" name="username" id="personUsername" onblur="checkUniqueExisted('personUsername')">
                                    </td>

                                    <td colspan="2" class="col3">
                                        <p class="normal">${uiLabelMap.UserNameSuggest}</p>

                                        <p class="error">${uiLabelMap.UserNameErrorMessage}</p>

                                        <p class="ok">${uiLabelMap.UserNameTip}</p>
                                    </td>
                                </tr>
                                 <tr class="tr-normal">
                                    <td class="col1">
                                        <p>${uiLabelMap.Password}<span class="required">*</span></p>
                                    </td>

                                    <td class="col2"><input class="text" type="password" id="password" name="password" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal"></p>

                                        <p class="error">${uiLabelMap.PasswordErrorMessage}</p>

                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.PasswordVerify}<span class="required">*</span></td>
                                    <td class="col2"><input class="text" type="password" id="passwordVerifyCust" name="passwordVerify" value=""></td>
                                    <td class="col3" colspan="2"><p class="normal"></p>
                                    <p class="error">${uiLabelMap.RegisterRequired},且和密码一致.</p>
                                    <p class="ok">&nbsp;</p></td>
                                </tr>
                                
                                <tr class="tr-normal">
                                    <td class="col1">店铺名称<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="storeName" id="storeName" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请填写正确的店铺名称</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">银行账号<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankCode" id="personBankCode" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请正确填写银行账户信息</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                
                                <tr class="tr-normal">
                                    <td class="col1">开户行<span class="required">*</span></td>

                                    <td class="col2">
                                    <#if bankList?has_content>
                                    	<select name="bankId" style="width:196px;" id="personBankId">
                                    		<#list bankList as item>
                                    			<option value="${(item.baseId)!}">${(item.bankName)!}</option>
                                    		</#list>
                                    	</select>
                                    </#if>
                                    </td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请选择开户行</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">银行收款人<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankUserName" id="personBankUserName" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请填写银行收款人信息</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">开户行所在地<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankAddress" id="personBankAddress" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请填写开户行所在地</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                
                                
                                <tr class="tr-normal">
                                    <td class="col1">开户行所在省份<span class="required">*</span></td>
                                    <td class="col2">
                                    	 <select id="personProvince" name="bankProvince"  onchange="getArea(this,'','personCity',null);" style="width: 274">
	                                    	<#assign stateAssocs = Static["org.extErp.sysCommon.party.CommonWorkers"].getAssociatedStateList(delegator,'CHN')>
											<#list stateAssocs as stateAssoc>
											    <option value='${stateAssoc.geoId}' <#if entity?has_content &&entity.provinceId?has_content&&stateAssoc.geoId==entity.provinceId>selected</#if> >${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
											</#list>
	                                    </select>
                                    </td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请选择开户行所在省份</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
								<tr class="tr-normal">
                                    <td class="col1">开户行所在城市<span class="required">*</span></td>
                                    <td class="col2">
	                                   <select id="personCity" name="bankCity" style="width: 274"></select>
                                    </td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请选择开户行所在城市</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                
								<tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.VerifyCode}<span class="required">*</span></td>
                                    <td class="col2">
                                        <input class="text" id="personImageCode" name="imageCaptchaCode">

                                    </td>
                                    <td>
                                        <img class="randomCode_img" style="margin-left: 8px;vertical-align: bottom;" src="/control/captcha.jpg?captchaCodeId=captchaImage&unique=${nowTimestamp.getTime()}" height="30px" onclick="this.src='/control/captcha.jpg?captchaCodeId=captchaImage&unique='+Date.now()">
                                    </td>
                                    <td class="col3" style="margin-left: 0px;">
                                        <p class="normal"></p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.MobilePhone}<span class="required">*</span></td>

                                    <td class="col2">
                                        <div>
                                            <input class="text" id="mobilePhone" name="mobilePhone">
                                        </div>
                                    </td>
                                    <td>
                                        <p class="tip PersonGetVerifyCode">
                                            <input type="button" class="button" onclick="sendRegisterSms('person')" id="PersonGetVerifyCode" value="${uiLabelMap.GetVerifyCode}"/>
                                            
                                        </p>
                                    </td>
                                    <#--
                                    <td>
                                        <p class="tip"><a class="button" onclick="sendRegisterSms('person')" target="_self"><span id="PersonGetVerifyCode">${uiLabelMap.GetVerifyCode}</span></a>
                                        </p>
                                    </td>
                                        -->
                                    <td class="col3">
                                        <p class="normal"></p>

                                        <p class="error">${uiLabelMap.PhoneNumberCheck}</p>

                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>

                                <tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.PhoneVerifyCode}<span class="required">*</span></td>

                                    <td class="col2"><input class="text" id="personCaptchaCode" name="phoneCaptchaCode"></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal"></p>

                                        <p class="error">${uiLabelMap.PhoneCodeErrorMessage}</p>

                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="col1"></td>

                                    <td class="col2"><button id="submit1" onclick="register()" class="submit" style="margin-left:-2px;" name="submit" type="button">${uiLabelMap.RegisterNow}</button></td>

                                    <td class="col3"></td>
                                </tr>
                                </tbody>
                            </table>

                            <div class="agreement">
                                <div>
                                    <a href="#" target="_blank">${uiLabelMap.RegisterAgreement}</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="info-part">
                        <table>
                            <tr>
                                <td >
                                    <p><img src="../images/regTip.png" ></p>
                                </td>
                            </tr>
                            <tr><td><p>${uiLabelMap.PersonRegisterLineOne}</p></td></tr>
                            <tr><td><p>${uiLabelMap.RegisterLineTwo}</p></td></tr>
                            <tr><td><p>${uiLabelMap.SellerRegisterLineThree}</p></td></tr>
                            <tr><td><p>${uiLabelMap.RegisterLineFour}</p></td></tr>
                            <tr><td><p>${uiLabelMap.RegisterLineFive}</p></td></tr>
                            <tr><td><p>${uiLabelMap.PersonRegisterLineSix}</p></td></tr>

                        </table>

                    </div>
                </div>


                <div id="company-tab" class="tab-part fd-clr">
                    <div class="form-part">
                        <form action="<@ofbizUrl>registerEnterpriseSeller</@ofbizUrl>" method="post" id="EnterpriseRegisterForm">
                            <table>
                                <tbody>
                                <tr class="tr-normal">
                                    <td class="col1">
                                        <p class="suggestfix">${uiLabelMap.EnterpriseUserName}<span class="required">*</span></p>
                                    </td>

                                    <td class="col2">
                                        <input class="text" type="text" name="username" value="" id="enterpriseUsername" onblur="checkUniqueExisted('enterpriseUsername')">
                                    </td>

                                    <td colspan="2" class="col3">
                                        <p class="normal">${uiLabelMap.UserNameSuggest}</p>

                                        <p class="error">${uiLabelMap.UserNameErrorMessage}</p>

                                        <p class="ok">${uiLabelMap.UserNameTip}</p>
                                    </td>
                                </tr>

                                <tr class="tr-normal">
                                    <td class="col1">
                                        <p>${uiLabelMap.Password}<span class="required">*</span></p>
                                    </td>

                                    <td class="col2"><input class="text text2" type="password" id="enterprisePassword" name="password" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal"></p>
                                        <p class="error">${uiLabelMap.PasswordErrorMessage}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>

                                <tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.PasswordVerify}<span class="required">*</span></td>

                                    <td class="col2"><input class="text" id="passwordVerify" type="password" name="passwordVerify" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal"></p>
                                        <p class="error">${uiLabelMap.RegisterRequired},${uiLabelMap.PasswordVerifyTip}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
								<tr class="tr-normal">
                                    <td class="col1">店铺名称<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="storeName" id="storeNameGys" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请填写正确的店铺名称</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.GroupName}<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="groupName" id="groupName" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">${uiLabelMap.GroupNameTip}</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
								
								
								
								
								<tr class="tr-normal">
                                    <td class="col1">银行账号<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankCode" id="bankCode" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请正确填写银行账户信息</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                
                                <tr class="tr-normal">
                                    <td class="col1">开户行<span class="required">*</span></td>
                                    <td class="col2">
	                                    <#if bankList?has_content>
	                                    	<select name="bankId" style="width:196px;" id="bankId">
	                                    		<#list bankList as item>
	                                    			<option value="${(item.baseId)!}">${(item.bankName)!}</option>
	                                    		</#list>
	                                    	</select>
	                                    </#if>
                                    </td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请选择开户行</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">银行收款人<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankUserName" id="bankUserName" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请填写银行收款人信息</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                <tr class="tr-normal">
                                    <td class="col1">开户行所在地<span class="required">*</span></td>

                                    <td class="col2"><input class="text" type="text" name="bankAddress" id="bankAddress" value=""></td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请填写开户行所在地</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
								

								
								
								
								<tr class="tr-normal">
                                    <td class="col1">开户行所在省份<span class="required">*</span></td>
                                    <td class="col2">
                                    	<select id="province" name="province"  onchange="getArea(this,'','city','');" style="width: 274">	
                                    		<option>选择省份</option>
                                    		<#assign stateAssocs = Static["org.extErp.sysCommon.party.CommonWorkers"].getAssociatedStateList(delegator,'CHN')>
											<#list stateAssocs as stateAssoc>
											    <option value='${stateAssoc.geoId}' <#if entity?has_content &&entity.provinceId?has_content&&stateAssoc.geoId==entity.provinceId>selected</#if> >${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
											</#list>
										</select>	
                                    </td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请选择开户行所在省份</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
								<tr class="tr-normal">
                                    <td class="col1">开户行所在城市<span class="required">*</span></td>
                                    <td class="col2">
	                                    <select id="city" name="city" style="width: 274"><option>选择城市</option></select>
                                    </td>

                                    <td class="col3" colspan="2">
                                        <p class="normal">请选择开户行所在城市</p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
								
								
								
								
								
								
								
                                <tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.VerifyCode}<span class="required">*</span></td>
                                    <td class="col2">
                                        <input class="text" id="enterpriseImageCode" name="imageCaptchaCode">

                                    </td>
                                    <td>
                                        <img class="randomCode_img" style="margin-left: 8px;vertical-align: bottom;" src="/portal/control/captcha.jpg?captchaCodeId=captchaImage&unique=${nowTimestamp.getTime()}" height="30px" onclick="this.src='/portal/control/captcha.jpg?captchaCodeId=captchaImage&unique='+Date.now()">
                                    </td>
                                    <td class="col3" style="margin-left: 0px;">
                                        <p class="normal"></p>
                                        <p class="error">${uiLabelMap.RegisterRequired}</p>
                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <table>
                                <tbody>
                                <tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.MobilePhone}<span class="required">*</span></td>

                                    <td class="col2">
                                        <div>
                                             <input class="text text2 bizMobile" type="text" id="enterprisePhone" name="mobilePhone" value="">
                                        </div>
                                    </td>
                                    
                                    <td>
                                        <input type="button" class="button" onclick="sendRegisterSms('enterprise')" id="EnterpriseGetVerifyCode" value="${uiLabelMap.GetVerifyCode}"/>
                                    </td>
                                    <#--
                                    <td>
                                        <p class="tip"><a class="button" onclick="sendRegisterSms('enterprise')" target="_self"><span id="EnterpriseGetVerifyCode">${uiLabelMap.GetVerifyCode}</span></a>
                                        </p>
                                    </td>
                                        -->
                                    <td class="col3">
                                        <p class="normal"></p>

                                        <p class="error">${uiLabelMap.PhoneNumberCheck}</p>

                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <table class="valtable">
                                <tbody>
                                <tr class="tr-normal">
                                    <td class="col1">${uiLabelMap.PhoneVerifyCode}<span class="required">*</span></td>

                                    <td class="col2"><input class="text text2" type="text" name="phoneCaptchaCode" id="enterpriseCaptchaCode" value="" style="width:85px;"></td>

                                    <td class="col3">
                                        <p class="normal"></p>

                                        <p class="error">${uiLabelMap.PhoneCodeErrorMessage}</p>

                                        <p class="ok">&nbsp;</p>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <table>
                                <tbody>
                                <tr>
                                    <td class="col1"></td>

                                    <td class="col2" style="width:168px;"><button class="submit" style="margin-left:-2px;" name="submit" type="button" onclick="registerGYS()">${uiLabelMap.RegisterNow}</button></td>

                                    <td class="col3"></td>
                                </tr>
                                </tbody>
                            </table>

                            <div class="agreement">
                                <div>
                                    <a href="#" target="_blank">${uiLabelMap.RegisterAgreement}</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="info-part">
                        <table>
                            <tr>
                                <td >
                                    <p><img src="../images/regTip.png" ></p>
                                </td>
                            </tr>
                            <tr><td><p>${uiLabelMap.EnterpriseRegisterLineOne}</p></td></tr>
                            <tr><td><p>${uiLabelMap.RegisterLineTwo}</p></td></tr>
                            <tr><td><p>${uiLabelMap.SellerRegisterLineThree}</p></td></tr>
                            <tr><td><p>${uiLabelMap.RegisterLineFour}</p></td></tr>
                            <tr><td><p>${uiLabelMap.RegisterLineFive}</p></td></tr>
                            <tr><td><p>${uiLabelMap.EnterpriseRegisterLineSix}</p></td></tr>
                        </table>

                    </div>
                </div>
            </div>
        </div>
 </div>        
<script type="text/javascript">
    function changeRegisteTab(id, obj){
        $("#content").find(".tab-part").hide();
        $("#content").find(id).show();
        $("#reg-tab-list").find(".reg-tab-li").removeClass("reg-choose");
        $("#reg-tab-list").find(obj).addClass("reg-choose");
    }

    function sendRegisterSms(type){

        var mobilePhone = '';
        if(type=="person"){
        	var isOK = checkRegRandomCode("personImageCode");
			if(isOK == false)return;
			
            mobilePhone = $('#mobilePhone').val();
            if(!$("#inputForm").validate().element($("#mobilePhone"))){
                return;
            }
            //验证手机号码
			var isPhone = checkPhone('mobilePhone');
			if(isPhone == true)return;
        } else {
        	var isOK = checkRegRandomCode('enterpriseImageCode');
			if(isOK == false)return;
			
            mobilePhone = $('#enterprisePhone').val();
            if(!$("#EnterpriseRegisterForm").validate().element($("#enterprisePhone"))){
                return;
            }
            //验证手机号码
			var isPhone = checkPhone('enterprisePhone');
			if(isPhone == true)return;
        }
        min(type);
        $.post('<@ofbizUrl>sendRegisterSms</@ofbizUrl>','mobilePhone='+mobilePhone,function(data){
            if(data.isSend && data.isSend == 'success'){
                if(type == "person"){
                    $('#mobilePhone').attr("readonly","readonly");
                }else{
                    $("#enterprisePhone").attr("readonly", "readonly");
                }
                alert("${StringUtil.wrapString(uiLabelMap.SendMessageSuccess)}");
               
            }else{
                alert("${StringUtil.wrapString(uiLabelMap.SendMessageFailed)}");
            }
        });
    }

    var time=60;

function min(type){
    if(time != 0){
        --time;
        if(type=="person"){
            $("#PersonGetVerifyCode").val(parseInt(time)+"s后重新获取");
            $("#PersonGetVerifyCode").attr("disabled","true");
            $("#PersonGetVerifyCode").attr("style","color: #CBC8C8;");
            
        } else {
            $("#EnterpriseGetVerifyCode").val(parseInt(time)+"s后重新获取");
            $("#EnterpriseGetVerifyCode").attr("disabled","true");
            $("#EnterpriseGetVerifyCode").attr("style","color: #CBC8C8;");
        }
        setTimeout("min('"+ type +"')", 1000);
    }else{
        time=60;
        if(type=="person"){
            $("#PersonGetVerifyCode").val("${StringUtil.wrapString(uiLabelMap.GetVerifyCode)!}");
            $("#PersonGetVerifyCode").removeAttr("disabled");
            $("#PersonGetVerifyCode").removeAttr("style");
            $("#mobilePhone").removeAttr("readonly");
        } else {
            $("#EnterpriseGetVerifyCode").val("${StringUtil.wrapString(uiLabelMap.GetVerifyCode)!}");
            $("#EnterpriseGetVerifyCode").removeAttr("disabled");
            $("#EnterpriseGetVerifyCode").removeAttr("style");
            $("#enterprisePhone").removeAttr("readonly");
        }
    }
}

    function checkUniqueExisted(id){
        var existed = false;
        var findValue = $("#"+id).val();
        if (!findValue || (findValue && findValue.length<4)) return existed;
        $.ajax({
            url: '/portal/control/checkKeywordExisted',
            data: {
                'entityName':'UserLogin',
                'findKey':'userLoginId',
                'findValue':findValue
            },
            type: "POST",
            async:false,
            dataType: "json",
            success: function(data) {
                if(data.existed =="Y"){
                    alert("用户名已存在, 请更换");
                    existed = true;
                }
            },
            error: function(req, s, err){
                if(console) console.log(['checkUniqueExisted.ftl', req, s, err]);
            }
        });
        return existed;
    }
    
    //手机号码唯一验证
    	function checkPhone(id){
		    var existed = false;
		    var findValue = $("#"+id).val();
		    if (!findValue || (findValue && findValue.length!=11)) return true;
		    $.ajax({
		        url: '/control/checkPhone',
		        data: {'phone':findValue},
		        type: "POST",
		        async:false,
		        dataType: "json",
		        success: function(data) {
		            if(data.message =="Y"){
		                alert("手机号码已存在, 请更换");
		                existed = true;
		            }
		        },
		        error: function(req, s, err){
		            if(console) console.log(['checkUniqueExisted.ftl', req, s, err]);
		        }
		    });
		    return existed;
		}
		
function changeVerifyCodeReg2(){
	$(".randomCode_img").attr("src", ('/portal/control/captcha.jpg?captchaCodeId=captchaImage&unique=' + Date.now()));
}		
		
function checkRegRandomCode(id){
            var isOK = true;
            var randomCode =  $("#"+id).val();
            if(randomCode == ''){
                isOK = false;
                alert("请输入验证码");
            }
            if(isOK){
                $.ajax({
                    url: '/portal/control/checkRandomCode',
                    type: "POST",
                    async : false,
                    data: {
                        randomCode : randomCode
                    },
                    success: function(data) {
                        var isError=data;
                        if(isError != "success"){
                            isOK = false;
                            alert("验证码错误!");
                            changeVerifyCodeReg2();
                        }
                    }
                });
            }
            return isOK;
  }
</script>


