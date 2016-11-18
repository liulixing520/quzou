function changeProvince2(data){
   jQuery.ajax({
   		type: "POST",
   		url: "/merchant/register/getCitys.do?isblank=true&provinceid=" + data,
   		dataType: "html",
	    success: function(data,status) {
	    			if(data.length < 6){
	    				data = "0|0:请选择县、市地区等";
	    			}
	    			var citysstr = getCitysStr(data);
					resetCitySelect2('citystateform', citysstr);
	    		},
	    error: function (data, status, e) { alert(e);}
	}); 
}
var g_arrProcinceCityList={};
function getCitysStr(content) {
	var strCityList = "";
	var retmeslist = content.split("|");
	if(retmeslist.length==2){
		strCityList = retmeslist[1];
		g_arrProcinceCityList[retmeslist[0]]=$.trim(strCityList);
	}else{
		return "";
	}
	return $.trim(strCityList);
}
//jQuery.ajax({
//type: "POST",
//url : "/merchant/register/sellerregajax.do?act=checkmobile&isblank=true&mobilephone=" + mobilephone_str,
//dataType: "html",
//async: true,
//success: function(data) {
////alert("data  : "+data);
//if(data=="right") {
//	//$("#sendVerifyCode").show();
//	
//	//$("#showVerifyCode").css({"display":"table-row"}); 
//	if ($.browser.msie && ( $.browser.version == '6.0' || $.browser.version == '7.0' )) {
//	     $("#showVerifyCode").show();
//	     $("#sendVerifyCode").show();
//	}else{
//		$("#showVerifyCode").css({"display":"table-row"}); 
//		$("#sendVerifyCode").css({"display":"inline-block"});
//	}				
//	return true;
//} else{
//	$("#mobilephoneTip").html("<span class=\"onError\"><span class=\"rgicon-wrong\"></span><span class=\"marginlf5\">手机号已经使用!</span></span>");
//	$("#sendVerifyCode").hide()
//	return false;
//}
//},
//error: function (data, status, e) {
//alert("操作失败!");
//return false;
//}
//}); 

function changecompany(value){
	   var mobile=$("#mobilephone").val();
	   var email = $("#email").val();
	   var companytypede = $("#companytypede").val();
	   if(companytypede !="21" && $("#companytype").val() =="21"){
		   
		   jQuery.ajax({
		   		type: "POST",
		   		url: "/merchant/register/checkmobile.do?sellerType=1&mobilephone=" + mobile,
		   		async: true,
		   		dataType: "text",
			    success: function(data) {
			    	        if(data =="right"){
			    	        	jQuery.ajax({
			    	    	   		type: "POST",
			    	    	   		url: "/merchant/register/checkmail.do?sellerType=1&email=" + email,
			    	    	   		async: true,
			    	    	   		dataType: "text",
			    	    		    success: function(data) {
			    	    		    	        if(data =="right"){
			    	    		    	        }else{
			    	    		    	        	alert("您修改的用户类型对应的手机号码或常用邮箱关联了3个其它的敦煌网账号！");
			    	    		    	        	$("#companytype").val(companytypede);
			    	    		    	        	return false;
			    	    		    	        }
			    	    		    		},
			    	    		    error: function (data, status, e) { alert(e);}
			    	    		}); 	
			    	        }else{
			    	        }
			    		},
			    error: function (data, status, e) { alert(e);}
			}); 
		   
	   }
	   
	}

function resetCitySelect2(cityselectid, retmes) {
	
	var selObj = document.getElementById(cityselectid);
	if(retmes != "" ){
		selObj.options.length=0;
		var retmeslist = retmes.split("-");
		for(var i=0;i<retmeslist.length;i++){
			var cityinfo = retmeslist[i].split(":");
     		var tid = cityinfo[0];
     		var tname = cityinfo[1];
 			if(cityinfo.length > 2){
 				selObj.options.add(new Option(tname,tid));
 				if (cityinfo[2] == "1") {
 					selObj.options[i].selected = true;
 				}
 			}else{
 				selObj.options.add(new Option(tname,tid));
 			}
		}
	}
}

//做大陆身份证验证，15-18位，年份段限制为1939-2000年期间
function validateIdcard(val) {
	if(val==null)return false;
	
	val = val.toUpperCase();
	
    // 身份证验证长度验证
    if(val.length != 18 && val.length != 15 && val.length != 11 && val.length != 10) {     
        return false;
    }   
    if (val.length == 15 || val.length == 18){
    	//中国大陆身份证验证    	  
    	//身份证地区编号
    	var areaCityList = { 11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",
    				21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",
    				33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",
    				41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",
    				46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",
    				54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",
    				65:" 新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"}; 	
    	//如湖北武汉市江岸区1975-12-31生辰男：15位- 420102 751231 215 ；18位 - 420102 19751231 2115 或 420102 19751231 211x 
    				
	    var strBirthday = "1900/01/01";
    	if(val.length == 15){    		
	    	var isIDCard15=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
		   	if(!isIDCard15.test(val)) {
		   		 return false;
		   	}
		   	strBirthday = "19" + val.substr(6,2)+"/" + val.substr(8,2)+"/"+val.substr(10,2);
	   	}else{	   		
	    	var isIDCard18=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])(\d{4}|\d{3}X)$/;
		   	if(!isIDCard18.test(val)) {
		   		 return false;
		   	}		   
		    strBirthday = val.substr(6,4)+ "/"+ val.substr(10,2)+"/"+ val.substr(12,2);
	   	}  
	   	//生日校验
	   	var dBirthday = new Date(strBirthday);
	   	var bmonth = dBirthday.getMonth()+1 ;
	   	if(bmonth < 10) bmonth= ""+"0"+ bmonth;	   	
	   	
	   	var bday = dBirthday.getDate();
	   	if(bday<10)bday = "" +"0"+bday;
	   	
		if( strBirthday != (dBirthday.getFullYear()+"/"+ bmonth + "/" + bday ) ){
			return false; 
		}	
		//出生日期在1939年到2000年之间。	   
	    if ( dBirthday < new Date("1939/01/01") || dBirthday > new Date("1999/12/31")) {
	    	return false;
	    }	
	    //地区校验   	
    }else if (val.length == 10 || val.length == 11) {
    	//香港的身份证 
		//身份证号码的结构，可以用XYabcdef(z)表示。「X」可能是「空格」或是一个英文字母，「Y」则必定是英文字母。
		//「abcdef」代表一个六位数字，而「z」是作为检码之用，它的可能选择是0,1,2,...,9,A(代表10)。
    	var patn = new RegExp("^[A-Za-z]{1,2}[0-9]{6}[(][0-9aA][)]+$");
	   	if(patn.test(val)) { 
	   		return true;
	   	}
	   	//1.	台湾身份证总共有10位数字。第一位是字母。后面九位是数字。 台湾省份证的第一位的字母代表地区分别以A——Z表示
	   	//2.	第二位数字代表性别 男性是1，女性是2
	   	//3.	第三位到第九位为任意的一串数字
	   	//4.	第十位为验证码。 第十位数字

	   	var patn1 = new RegExp("^[A-Za-z]{1}[1-2]{1}[0-9]{8}$");
	   	if(patn1.test(val)) { 
	   		return true;
	   	}
	   	return false;
    }
	
	return true;
}
function checkChinese(val, elem) {
	var len;
    var i;
    len = 0;
    var reg = /^[\u4e00-\u9fa5]+$/i; 
  	if (!reg.test(val)) {
      return false;
    }
    return true;
}
//检查联系人姓名
function checkLinkName(val) {
	val=encodeURIComponent(val);
	jQuery.ajax({
   		type: "POST",
   		url: "/merchant/register/checkRealname.do?actionType=2&realname="+val,
   		dataType: "json",
		async:false,
	    success: function(data, status) {
	    	var msg_val = data.msg;
	    	//alert(msg_val);
	    	if (msg_val == 'yes') {
    	    	alert("请输入正确的身份证姓名");
				document.getElementById("fullname").focus();
     		} 
	    },
	    error: function (data, status, e) {
           alert("操作失败!");
       	}
	});
}
function Companycontactuscontentforminfo(){
     //alert("run this is 0");
     
	 var idcard = document.getElementById("idcard");
	 var fullname = document.getElementById("fullname");
	 var validateDate = $("#okmodifycheck");
	 
	 if(validateDate.length!=0){
		 if(fullname.value =="" || fullname.value.length ==0){
			     alert("身份证姓名为空！必须输入");
				fullname.focus();
				return false;
		 }
		 
		 if(idcard.value =="" || idcard.value.length ==0){
			     alert("身份证号为空！必须输入");
				idcard.focus();
				return false;
		}
		if(!validateIdcard(idcard.value)){
				 alert("请输入正确的身份证号");
				idcard.focus();
				return false;
		}
		if(!checkChinese(fullname.value)){
				alert("请输入正确的身份证姓名");
				fullname.focus();
				return false;
		} 
		if(fullname.value.length <= 1){
				alert("请输入正确的身份证姓名");
				fullname.focus();
			    return false;
		}
	 }
//	var companytype = document.getElementById("companytype");
//	if(companytype.value =="" ){
//		alert("请选择用户类型");
//			companytype.focus();
//		    return false;
//	}

     var number = document.getElementById('telnum');
     if(number.value !="" && number.value !="null" && number.value !="电话号码")
	     if(number.value.length > 13 || number.value.length < 6){
    	    alert("请输入正确的电话号码！");
        	number.focus();
    	    return false;
    	 } else {
    	 	 if(!validateNumber(number.value)){		    
    		    alert("电话号码必须为数字！");
    	    	number.focus();
    	    	return false;
    		 }	
    	 }
	 var area = document.getElementById('telareacode');
	 if(number.value !="" && number.value !="null" && number.value !="电话号码"){
	 	if(area.value.length==0){
    	    alert("区号为空！必须输入 ");
        	area.focus();
        	return false;
    	 } else if(area.value.length > 4 || area.value.length < 3){
    	    alert("地区区号填写错误");
        	area.focus();
        	return false;
    	 }
    	 if (area.value != "" && area.value!="区号") {
    		 if(!validateNumber(area.value)){		    
    		    alert("地区区号必须为数字");
    	    	area.focus();
    	    	return false;
    		 }	 
    	 }	 
	 
	 }

	 //区号和号码相关CHECK
	 if(area.value.length != 0 &&　area.value !="区号"){
	 	if(number.value.length == 0 ||number.value=="电话号码" ){
	 		alert("电话号码为空！必须输入电话号码");
	    	number.focus();
	    	return false;
	 	}
	 }
	 
	 //传真相关CHECK
	 var faxareacode = document.getElementById('faxareacode');
	 var faxnum = document.getElementById('faxnum');	 
	 if (faxareacode.value.length > 0 && faxareacode.value !="区号") {
		 if(faxareacode.value.length > 4 || faxareacode.value.length < 3){
		    alert("传真区号的位数不正确");
	    	faxareacode.focus();
	    	return false;
		 }
		 if (faxareacode.value != "") {
			 if(!validateNumber(area.value)){		    
			    alert("传真区号必须为数字");
		    	faxareacode.focus();
		    	return false;
			 }	 
		 }
	 }

	 
	 //区号和号码相关CHECK
	 if(faxareacode.value.length != 0　&& faxareacode.value !="区号"){
	 	if(faxnum.value.length == 0 || faxnum.value == "电话号码"){
	 		alert("传真号码为空！必须输入传真号码");
	    	faxnum.focus();
	    	return false;
	 	}
	 }
	 
	 if(faxnum.value.length != 0 &&　faxnum.value!="电话号码"){
	 	if(faxareacode.value.length == 0  || faxareacode.value=="区号"){
	 		alert("传真区号为空！必须输入传真区号");
	    	faxareacode.focus();
	    	return false;
	 	}
	 }
	 if (faxareacode.value != "" && faxareacode.value!="区号"　) {
		 if(!validateNumber(faxareacode.value)){		    
		    alert("传真区号必须为数字");
	    	faxareacode.focus();
	    	return false;
		 }	 
	 }	 
	 if (faxnum.value != ""  && faxnum.value !="电话号码") {
		 if(!validateNumber(faxnum.value)){		    
		    alert("传真号码必须为数字");
	    	faxnum.focus();
	    	return false;
		 }	 
	 }
	 var detailaddress1value=document.getElementById('mailingaddress').value;
	 if(detailaddress1value.length>50){
	    alert("详细地址，字数过多");
    	document.getElementById('mailingaddress').focus();
    	return false;
	 }
	 //邮编必须为数字
	 var zip = document.getElementById('zipinfo');
	 if (zip.value != "") {
		 if(!validateNumber(zip.value)){
		    //alert("$text.message.companycontactuscontent.zip");
		    alert("邮编必须为数字");
	    	zip.focus();
	    	return false;
		 } 
		 if(zip.value.length != 6) {
		    alert("邮编必须为6位数字");
	    	zip.focus();
	    	return false;		 
		 }	 
	 }
	 
	 //MSN必须为MAIL地址
	 var msn = document.getElementById('msn');
	 if (msn.value != "") {
		 if(!validateMail(msn.value)){
		    alert("MSN格式不正确");
	    	msn.focus();
	    	return false;
		 }	 
	 }
	 //qq号码必须为数字
	 var qq = document.getElementById('qq');
	 if (qq!=null &&qq.value != "") {
		 if(!validateNumber(qq.value)){
		    alert("qq必须为数字");
	    	qq.focus();
	    	return false;
		 }
		 if (qq.value.length > 15 || qq.value.length < 5) {
		    alert("qq的位数不正确");
	    	qq.focus();
	    	return false;
		 }
 	 }
 	 $("#buttonsave")[0].disabled=true;	
     document.getElementById('CompanycontactuscontentForm').submit(); 
}

function validateNumber(val){
	if(!val)
		return false;
   	var patn = /^[0-9]+$/;
   	if(patn.test(val)) 
   		return true;
   	return false; 	
}



	//置指定字段为修改状态
function modifyRegInfo(strName, bmodify){
	var strValue = "";
	if(bmodify){
		$("#span_" +　strName).hide();						
		$("#span_e" +　strName).show();
		$("#md_" +　strName).attr("checked", true);
		if(strName=="idcard"){
			$("#" +　strName).focus();
		}else{
			$("#" +　strName).val($("#b_" +　strName).html()).focus();	
		}
		
	}else{
		$("#span_" +　strName).show();
		$("#md_" +　strName).attr("checked", false);
		$("#span_e" +　strName).hide();
		if(strName!="idcard"){
			$("#" +　strName).val($("#b_" +　strName).html());
		}
	}
	
}

function needValue(){
	var idCardVal = $("#idcard").val().replace(/\s/g, '');
	if(idCardVal.length>8){
		idCardVal = idCardVal.replace(/^\d{4}(\w+)\w{4}$/, function(m, n){
				return m.replace(n, n.replace(/\d/g, '*'));
			});
	}
	$("#b_idcard").html(idCardVal);
}
$(document).ready(function(e){
	needValue();
	hideTicpBox('viewTips','hideTipsBox');
});


function validateMail(val){
	if(!val)
		return false;
   	var patn = new RegExp("^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$");
   	if(patn.test(val)) 
   		return true;
    return false; 	
}
//传真：国家区号 地区区号 电话号码 ： faxcountrycode faxareacode faxnum
function checkfaxareacode(){
	var fax_err = "<span class=\"onfocus02\">请输入您的传真以便于我们的工作人员与您联系</span>";
	var fax_err1 = "请正确输入您的传真区号！";
	var faxareacode_obj=$("#faxareacode");
	var bool=validateFaxAreaCode(faxareacode_obj.val(),faxareacode_obj);
	if(!bool){
		faxareacode_obj.val("");
		alert(fax_err1);
		faxareacode_obj.focus();
	}else{
		//$("#faxTip").html("<img src='http://image.dhgate.com/2009/factory/register/img/d.gif' />");
	}
}
function checkfaxnum(){
	var faxnum_err1 = "请正确输入您的传真！";
	var faxnum_obj=$("#faxnum");
	var bool=validateFaxNum(faxnum_obj.val(),faxnum_obj);
	if(!bool){
		faxnum_obj.val("");
		alert(faxnum_err1);
		faxnum_obj.focus();
	}else{
		//$("#faxTip").html("<img src='http://image.dhgate.com/2009/factory/register/img/d.gif' />");
	}
}

//电话：国家区号 地区区号 电话号码 ： telcountrycode telareacode telnum
function checktelareacode(){
	var telareacode_err = "<span class=\"onfocus02\">请输入您的电话以便于我们的工作人员与您联系</span>";
	var telareacode_err1 = "请正确输入您的电话区号！";
	var telareacode_obj=$("#telareacode");
	var bool=validateFaxAreaCode(telareacode_obj.val(),telareacode_obj);
	if(!bool){
		telareacode_obj.val("");
		alert(telareacode_err1);
		telareacode_obj.focus();
	}else{
		//$("#phoneTip").html("<img src='http://image.dhgate.com/2009/factory/register/img/d.gif' />");
	}
}
function checktelnum(){
	var telnum_err1 = "请正确输入您的电话！";
	var telnum_obj=$("#telnum");
	var bool=validateFaxNum(telnum_obj.val(),telnum_obj);
	if(!bool){
		telnum_obj.val("");
		alert(telnum_err1);
		telnum_obj.focus();
	}else{
		//$("#faxTip").html("<img src='http://image.dhgate.com/2009/factory/register/img/d.gif' />");
	}
}
function focusInput(obj,str){
	if(obj.value==str){
		obj.value="";
	}
}
function validateFaxCountryCode(val, elem) {
	if (val.length == 0) {
		return true;
	} 
	if (!validateNumber(val, elem)) {
		return false;
	}
	if (val.length < 2 || val.length > 4) {
		return false;
	}
	return true;
}
function validateFaxAreaCode(val, elem) {
	if (val.length == 0) {
		return true;
	}
	if (!validateNumber(val, elem)) {
		return false;
	}	
	if (val.length < 3 || val.length > 4) {
		return false;
	}
	return true;
}
function validateFaxNum(val, elem) {
	if (val.length == 0) {
		return true;
	}
	if (!validateNumber(val, elem)) {
		return false;
	}	
	if (val.length < 6 || val.length > 13) {
		return false;
	}
	return true;
}
	
//展开或者收起温馨提示
function hideTicpBox(ticpTargetId,ticpBoxId){
	var ticpTargetId = $("#"+ticpTargetId),
		ticpBoxId = $("#"+ticpBoxId),
		ticpBoxIdHieight = ticpBoxId.height();

	ticpBoxId.addClass("addheight");
	ticpTargetId.addClass("viewshow")
	ticpTargetId.text('展开');		
	ticpTargetId.click(function(){
		if(ticpBoxId.hasClass('addheight') == '' ){
			ticpBoxId.addClass("addheight");
			ticpTargetId.addClass("viewshow")
			ticpTargetId.text('展开');
		}else{
			ticpBoxId.removeClass("addheight");
			ticpTargetId.removeClass("viewshow")
			ticpTargetId.text('收起');
		}
	 });
	if(ticpBoxIdHieight>24){
		ticpTargetId.show();
	}else{
		ticpTargetId.hide();
	}
}