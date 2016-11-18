//字母或数字,1到200位
var regexEnum = 
{
  zipcode:"^\\d{6}$",						//邮编
  mobile:"^(\\d{0}|[0-9]{11})$",     			//手机
  number:"^[0-9]*$",                     //数字
  phoneno:"^\\d*$",								//电话
  email:"^([\\w-.]+)@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.)|(([\\w-]+.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(]?)$"
}
var oncorrect = "<img src='http://image.dhgate.com/2009/factory/register/img/d.gif' />";


$(function(){
	initform();
	
	
	$("#save-eng").find("#saveEnBtn").click(function(){
		jQuery.formValidator.pageIsValid("saveForm");
	});
	
	
	
	$("#save-ch").find("#saveCnBtn").click(function(){
		jQuery.formValidator.pageIsValid("saveCnForm");
	});
	
	
	
	//英文地址列表 按钮效果
	$("#addEnAddrBtn").click(function(){
		showGlobal_save_eng(false,"","","","China","","","","","","","","","add");
	});
	$("#englishAddrList .deleteBtn").livequery("click",function(){
		if(!confirm("你确认删除该地址吗?")){
			return;
		}
		$(this).removeClass();
		var tr=$(this).parents("tr");
		var adressId=tr.find(".addressId").val();
		$.post("/merchant/deladdress.do",{
			isblank:"true",
			adressId:adressId
		},function(data){
			var evaldata=evalData(data);
			if(evaldata.status=="success"){
				tr.remove();
				updateLastNo();
			}
		});
	});
	$("#englishAddrList .modifyBtn").livequery("click",function(){
		var tr=$(this).parents("tr");
		var defaultAdd=tr.find(".defaultAdd").html();
		var addressId=tr.find(".addressId").val();
		var address=tr.find(".address").html();
		var city=tr.find(".city").html();
		var state=tr.find(".state").html();
		var country=tr.find(".country").html();
		var county=tr.find(".county").html();
		var sellerName=tr.find(".sellerName").html();
		var postalcode=tr.find(".postalcode").html();
		var mobilephone=tr.find(".mobilephone").html();
		var phone=tr.find(".phone").html();
		var email=tr.find("#save-emailshow").val();
		var companyname=tr.find("#save-companynameshow").val();
		var act="modify";
		
		showGlobal_save_eng(defaultAdd,address,city,state,country,county,sellerName,postalcode,mobilephone,phone,addressId,companyname,email,act);
	});
	//中文列表，按钮效果
	$("#showAddChinaAddrBtn").click(function(){
		showGlobal_save_ch(false,"","","","中国","","","","","","","","","add");
	});
	$("#show-ch .modifyCnBtn").livequery("click",function(){
		var tr=$(this).parents("tr");
		var defaultAdd=tr.find(".defaultAdd").html();//更多中文地址使用
		var addressId=tr.find(".addressId").val();
		var address=tr.find(".address").html();
		var city=tr.find(".city").html();
		var state=tr.find(".state").html();
		var country=tr.find(".country").html();
		var county=tr.find(".county").html();
		var sellerName=tr.find(".sellerName").html();
		var postalcode=tr.find(".postalcode").html();
		var mobilephone=tr.find(".mobilephone").html();
		var phone=tr.find(".phone").html();
		var email=tr.find("#cn-emailshow").val();
		var companyname=tr.find("#cn-companynameshow").val();
		var act="modify";
		showGlobal_save_ch(defaultAdd,address,city,state,country,county,sellerName,postalcode,mobilephone,phone,addressId,companyname,email,act);
	});
	$("#show-ch .delCnBtn").livequery("click",function(){
		if(!confirm("你确认删除该地址吗?")){
			return;
		}
		$(this).removeClass();
		var tr=$(this).parents("tr");
		var adressId=tr.find(".addressId").val();
		$.post("/merchant/deladdress.do",{
			isblank:"true",
			adressId:adressId
		},function(data){
			var evaldata=evalData(data);
			if(evaldata.status=="success"){
				tr.remove();
				updateCnLastNo();
			}
		});
	});
	//公用效果
	$(".noshade-pop-close").click(function(){
		$.modal.close();
		setTimeout("reInitform()",500);
	});
	$(".greybutton1").click(function(){
		$.modal.close();
		setTimeout("reInitform()",500);
	});	
});

function reInitform(){
	initform();
}

function initform(){
	
//保存层global_save_eng 表单及验证效果
	$.formValidator.initConfig({validatorgroup:"saveForm",
		errorfocus:false,
	    onsuccess:function(){
	    	var address=$("#save-eng").find("#save-address").val();
	    	var cityid=$("#save-eng").find("#save-city").find("option:selected").val();
	    	var stateid=$("#save-eng").find("#save-state").find("option:selected").val();
	    	var country=$("#save-eng").find("#save-country").val();
	    	var countyid=$("#save-eng").find("#save-county").find("option:selected").val();
	    	
	    	var city=$("#save-eng").find("#save-city").find("option:selected").text();
	    	var state=$("#save-eng").find("#save-state").find("option:selected").text();
	    	var county=$("#save-eng").find("#save-county").find("option:selected").text();
	    	
	    	var sellerName=$("#save-eng").find("#save-contactname").val();
	    	var postalcode=$("#save-eng").find("#save-zipcode").val();
	    	var mobilephone=$("#save-eng").find("#save-mobilephone").val();
	    	var telephoneregion=$("#save-eng").find("#save-quhao").val();
	    	var telephonenumber=$("#save-eng").find("#save-number").val();
	    	var telephoneext=$("#save-eng").find("#save-fenji").val();
	    	var adressId=$("#save-eng").find("#save-adressId").val();
	    	var companyname=$("#save-eng").find("#save-companyname").val();
	    	var email=$("#save-eng").find("#save-email").val();
	    	var act=$("#save-eng").find("#save-act").val();
	    	var phone=telephoneregion+"-"+telephonenumber+"-"+telephoneext;
	    	var isdefault=false;
	    	if($("#save-eng").find("#save-check_default").attr("checked")==true){
	    		isdefault=true;
	    	}
	    	var url = "";
	    	if(act == "add"){url = "/merchant/addaddress.do"}
	    	if(act == "modify"){url = "/merchant/modifyaddress.do"}
	    	
	    	$.post(url,{
	    		act:act,
	    		isblank:"true",
	    		address:address,
	    		city:cityid,
	    		state:stateid,
	    		country:country,
	    		county:countyid,
	    		contactname:sellerName,
	    		zipcode:postalcode,
	    		telephoneregion:telephoneregion,
	    		telephonenumber:telephonenumber,
	    		telephoneext:telephoneext,
	    		mobilephone:mobilephone,
	    		adressId:adressId,
	    		companyname:companyname,
	    		email:email,
	    		isdefault:isdefault,
	    		languagetype:"0"
	    	},function(data){
	    		var evaldata=evalData(data);
				if(evaldata.status=="success"){
			    	if(act=="modify"){
			    		var tr=$("#englishAddrList .addressId[value="+adressId+"]").parents("tr");
			    		if(isdefault=="1"){
			    			$.each($("#englishAddrList").find(".defaultAdd"),function(key,value){		    				
				    			$(value).html("");
				    		});
			    			tr.find(".defaultAdd").html("【默认地址】");
			    		}else{
			    			tr.find(".defaultAdd").html("");
			    		}
			    		
						tr.find(".address").html(address);
						tr.find(".city").html(city);
						tr.find(".state").html(state);
						tr.find(".country").html(country);
	                    tr.find(".county").html(county);
						tr.find(".sellerName").html(sellerName);
						tr.find(".postalcode").html(postalcode);
						tr.find(".mobilephone").html(mobilephone);
						tr.find(".phone").html(telephoneregion+"-"+telephonenumber+"-"+telephoneext);
						tr.find("#save-companyname").val(companyname);
						tr.find("#save-email").val(email);
						if(mobilephone!=""){
							tr.find(".mobilephone86").css("display","inline-block");
						}else{
							tr.find(".mobilephone86").css("display","none");
						}
			    	}else if(act=="add"){
			    		addressId=evaldata.addressId;
			    		if(isdefault==true){
			    			$.each($("#englishAddrList").find(".defaultAdd"),function(key,value){
				    			$(value).html("");
				    		});
			    		}
			    		$("#englishAddrList").append(getEnHtmlChar(isdefault,address,city,state,country,county,sellerName,postalcode,phone,mobilephone,addressId,companyname,email));
			    		updateLastNo();
			    	}
	    			$.modal.close();
	    			setTimeout("reInitform()",500);
	    		}
	    	});
			return false;
		}
	});
	
	
	$("#save-eng").find("#save-contactname").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入联系人姓名!",
		oncorrect:oncorrect,
		validatorgroup:"saveForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	
	$("#save-eng").find("#save-state").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入省或直辖市!",
		oncorrect:oncorrect,
		tipid:"save-statecityTip",
		validatorgroup:"saveForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	
	$("#save-eng").find("#save-city").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入城市名!",
		tipid:"save-statecityTip",
		oncorrect:oncorrect,
		validatorgroup:"saveForm"
	}).inputValidator({
	   min:1,
	   onerror:"市不能为空,请确认!"
	});
	
	$("#save-eng").find("#save-address").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入详细地址!",
		oncorrect:oncorrect,
		validatorgroup:"saveForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	
	$("#save-eng").find("#save-zipcode").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入邮政编码!",
		oncorrect:oncorrect,
		validatorgroup:"saveForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).regexValidator({
		regexp:"zipcode",
		datatype:"enum",
		onerror:"请输入正确的邮编!"
	});
	
	$("#save-eng").find("#save-quhao").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入区号!",
		oncorrect:oncorrect,
		tipid:"save-phoneTip",
		validatorgroup:"saveForm"
	}).regexValidator({
		regexp:"^\\d{3,4}$",
		onerror:"地区区号不正确"
	});
	$("#save-eng").find("#save-number").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入电话号码!",
		oncorrect:oncorrect,
		tipid:"save-phoneTip",
		validatorgroup:"saveForm"
	}).regexValidator({
        regexp:"^\\d{7,8}$",
		onerror:"电话号码不正确"
	});
	$("#save-eng").find("#save-fenji").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入分机号!",
		oncorrect:oncorrect,
		tipid:"save-phoneTip",
		validatorgroup:"saveForm"
	}).regexValidator({
        regexp:"^\\d{1,4}$",
		onerror:"分机号码不正确"
	});
	
	$("#save-eng").find("#save-mobilephone").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入手机号码!",
		oncorrect:oncorrect,
		validatorgroup:"saveForm"
	}).inputValidator({
		min:1,
		empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
		onerror:"不能为空,请确认!"
	}).regexValidator({
		regexp:"mobile",
		datatype:"enum",
		onerror:"请输入正确的手机号码!"
	});
	$("#save-eng").find("#save-companyname").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入公司名称!",
		oncorrect:oncorrect,
		validatorgroup:"saveForm"
	}).inputValidator({
		min:1,
		empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
		onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	$("#save-eng").find("#save-email").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入电子邮箱!",
		oncorrect:oncorrect,
		validatorgroup:"saveForm"
	}).inputValidator({
		min:1,
		empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
		onerror:"不能为空,请确认!"
	}).regexValidator({
		regexp:"email",
		datatype:"enum",
		onerror:"请输入正确的邮箱!"
	});
//中文层global_save_ch 表单及验证效果
	$.formValidator.initConfig({validatorgroup:"saveCnForm",
		errorfocus:false,
	    onsuccess:function(){
	    	var isdefault=false;
	    	if($("#save-ch").find("#cn-check_default").attr("checked")==true){
	    		isdefault=true;
	    	}
	    	var address=$("#save-ch").find("#cn-address").val();
	    	var cityid=$("#save-ch").find("#cn-city").find("option:selected").val();
	    	var stateid=$("#save-ch").find("#cn-province").find("option:selected").val();
	    	var country=$("#save-ch").find("#cn-country").val();
	    	var countyid=$("#save-ch").find("#cn-county").find("option:selected").val();
	    	
	    	var city=$("#save-ch").find("#cn-city").find("option:selected").text();
	    	var state=$("#save-ch").find("#cn-province").find("option:selected").text();
	    	var county=$("#save-ch").find("#cn-county").find("option:selected").text();
	    	
	    	var sellerName=$("#save-ch").find("#cn-contactname").val();
	    	var postalcode=$("#save-ch").find("#cn-postcode").val();
	    	var telephoneregion=$("#save-ch").find("#cn-quhao").val();
	    	var telephonenumber=$("#save-ch").find("#cn-number").val();
	    	var telephoneext=$("#save-ch").find("#cn-fenji").val();
	    	var mobilephone=$("#save-ch").find("#cn-mobile").val();
	    	var companyname=$("#save-ch").find("#cn-companyname").val();
	    	var email=$("#save-ch").find("#cn-email").val();
	    	var adressId=$("#save-ch").find("#cn-adressId").val();
	    	var act=$("#save-ch").find("#cn-act").val();
	    	var phone=telephoneregion+"-"+telephonenumber+"-"+telephoneext;
	    	var url = "";
	    	if(act == "add"){url = "/merchant/addaddress.do"}
	    	if(act == "modify"){url = "/merchant/modifyaddress.do"}
	    	$.post(url,{
	    		act:act,
	    		isblank:"true",
	    		address:address,
	    		isdefault:isdefault,
	    		city:cityid,
	    		state:stateid,
	    		country:country,
	    		county:countyid,
	    		contactname:sellerName,
	    		zipcode:postalcode,
	    		telephoneregion:telephoneregion,
	    		telephonenumber:telephonenumber,
	    		telephoneext:telephoneext,
	    		mobilephone:mobilephone,
	    		companyname:companyname,
	    		email:email,
	    		adressId:adressId,
	    		languagetype:"1"
	    	},function(data){
	    		var evaldata=evalData(data);
				if(evaldata.status=="success"){
			    	if(act=="modify"){
			    		var tr=$("#chAddrList .addressId[value="+adressId+"]").parents("tr");
			    		if(isdefault=="1"){
			    			$.each($("#chAddrList").find(".defaultAdd"),function(key,value){
				    			$(value).html("");
				    		});
			    			tr.find(".defaultAdd").html("【默认地址】");
			    		}else{
			    			tr.find(".defaultAdd").html("");
			    		}
						tr.find(".address").html(address);
						tr.find(".city").html(city);
						tr.find(".state").html(state);
						tr.find(".country").html(country);
						tr.find(".county").html(county);
						tr.find(".sellerName").html(sellerName);
						tr.find(".postalcode").html(postalcode);
						tr.find(".mobilephone").html(mobilephone);
				    	tr.find("#cn-companyname").val(companyname);
				    	tr.find("#cn-email").val(email);
						tr.find(".phone").html(telephoneregion+"-"+telephonenumber+"-"+telephoneext);
						if(mobilephone!=""){
							tr.find(".mobilephone86").css("display","inline-block");
						}else{
							tr.find(".mobilephone86").css("display","none");
						}
						
			    	}else if(act=="add"){
			    		addressId=evaldata.addressId;
			    		if(isdefault==true){
			    			$.each($("#chAddrList").find(".defaultAdd"),function(key,value){
				    			$(value).html("");
				    		});
			    		}
			    		$("#chAddrList").append(getChHtmlChar(isdefault,address,city,state,country,county,sellerName,postalcode,phone,mobilephone,addressId,companyname,email));
			    		updateCnLastNo();
			    	}
	    			$.modal.close();
	    			setTimeout("reInitform()",1000);
	    		}
	    	});
			return false;
		}
	});
	
	$("#save-ch").find("#cn-contactname").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入联系人姓名!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "不能输入无效字符！", 
		fun:checkValidChar
	});
	
	$("#save-ch").find("#cn-province").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入省!",
		oncorrect:oncorrect,
		tipid:"cn-provincecityTip",
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,
	   onerror:"省不能为空,请确认!"
	});
	$("#save-ch").find("#cn-city").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入市!",
		oncorrect:oncorrect,
		tipid:"cn-provincecityTip",
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,
	   onerror:"市不能为空，请确认!"
	});
	
	/*
	global_save_ch.find("#save-city").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入城市名!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	*/
	$("#save-ch").find("#cn-address").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入详细地址!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "不能输入无效字符！", 
		fun:checkValidChar
	});
	
	$("#save-ch").find("#cn-postcode").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入邮政编码!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).regexValidator({
		regexp:"zipcode",
		datatype:"enum",
		onerror:"请输入正确的邮编!"
	});
	
	
	$("#save-ch").find("#cn-quhao").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入区号!",
		oncorrect:oncorrect,
		tipid:"cn-phoneTip",
		validatorgroup:"saveCnForm"
	}).regexValidator({
		regexp:"^\\d{3,4}$",
		onerror:"地区区号不正确"
	});
	$("#save-ch").find("#cn-number").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入电话号码!",
		oncorrect:oncorrect,
		tipid:"cn-phoneTip",
		validatorgroup:"saveCnForm"
	}).regexValidator({
        regexp:"^\\d{7,8}$",
		onerror:"电话号码不正确"
	});
	$("#save-ch").find("#cn-fenji").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入分机号!",
		oncorrect:oncorrect,
		tipid:"cn-phoneTip",
		validatorgroup:"saveCnForm"
	}).regexValidator({
        regexp:"^\\d{1,4}$",
		onerror:"分机号码不正确"
	});

	
	$("#save-ch").find("#cn-mobile").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入手机号码!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).inputValidator({
		min:1,
		empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
		onerror:"不能为空,请确认!"
	}).regexValidator({
		regexp:"mobile",
		datatype:"enum",
		onerror:"请输入正确的手机号码!"
	});
	$("#save-ch").find("#cn-companyname").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入公司名称!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).inputValidator({
		min:1,
		empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
		onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "不能输入无效字符!", 
		fun:checkValidChar
	});
	$("#save-ch").find("#cn-email").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入电子邮箱!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).inputValidator({
		min:1,
		empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
		onerror:"不能为空,请确认!"
	}).regexValidator({
		regexp:"email",
		datatype:"enum",
		onerror:"请输入正确的邮箱!"
	});
}

function checkDefaultBox(ischeck){
	$("#save-eng").find("#save-check_default").attr("checked",ischeck);
}
//英文保存层global_save_eng 显示效果
function showGlobal_save_eng(defaultAdd,address,city,state,country,county,sellerName,postalcode,mobilephone,phone,addressId,companyname,email,act){
	if(defaultAdd){
		setTimeout("checkDefaultBox(true)",500);
	}else{
		setTimeout("checkDefaultBox(false)",500);
	}
	
	$("#save-eng").find("#save-address").val(address);
	$("#save-eng").find("#save-city").val(city);
	$("#save-eng").find("#save-state").val(state);
	changeCnSelectProvinceen(state,city,county);
	//global_save_eng.find("#save-country").val(country);
	
	$("#save-eng").find("#save-county").val(county);
	changeEnSelectCounty(city,county);
	$("#save-eng").find("#save-contactname").val(sellerName);
	$("#save-eng").find("#save-zipcode").val(postalcode);
	if(mobilephone){
		$("#save-eng").find("#save-mobilephone").val(mobilephone);
	}else{
		$("#save-eng").find("#save-mobilephone").val("");
	}
	$("#save-eng").find("#save-quhao").val(phone.split("-")[0]);
	$("#save-eng").find("#save-number").val(phone.split("-")[1]);
	$("#save-eng").find("#save-fenji").val(phone.split("-")[2]);
	$("#save-eng").find("#save-adressId").val(addressId);
	$("#save-eng").find("#save-companyname").val(companyname);
	$("#save-eng").find("#save-email").val(email);
	$("#save-eng").find("#save-act").val(act);
	$.each($("#save-eng").find("span[id$='Tip']"),function(key,value){
		$(value).html("");
		$(value).removeClass();
	});
	$("#save-eng-wraper").modal({close:false});
}
//中文保存层global_save_ch 显示效果
function showGlobal_save_ch(defaultAdd,address,city,state,country,county,sellerName,postalcode,mobilephone,phone,addressId,companyname,email,act){
	if(defaultAdd){
		$("#save-ch").find("#cn-check_default").attr("checked",true);
	}else{
		$("#save-ch").find("#cn-check_default").attr("checked",false);
	}
	
	$("#save-ch").find("#cn-address").val(address);
	$("#save-ch").find("#cn-city").val(city);
	$("#save-ch").find("#cn-province").val(state);
	changeCnSelectProvince(state,city,county);
	//global_save_ch.find("#cn-country").val(country);
	$("#save-ch").find("#cn-county").val(county);
	changeCnSelectCounty(city,county);
	$("#save-ch").find("#cn-contactname").val(sellerName);
	$("#save-ch").find("#cn-postcode").val(postalcode);
	if(mobilephone){
		$("#save-ch").find("#cn-mobile").val(mobilephone);
	}else{
		$("#save-ch").find("#cn-mobile").val("");
	}
	$("#save-ch").find("#cn-quhao").val(phone.split("-")[0]);
	$("#save-ch").find("#cn-number").val(phone.split("-")[1]);
	$("#save-ch").find("#cn-fenji").val(phone.split("-")[2]);
	$("#save-ch").find("#cn-adressId").val(addressId);
	$("#save-ch").find("#cn-companyname").val(companyname);
	$("#save-ch").find("#cn-email").val(email);
	$("#save-ch").find("#cn-act").val(act);
	$.each($("#save-ch").find("span[id$='Tip']"),function(key,value){
		$(value).html("");
	});
	$("#save-cn-wraper").modal({close:false});
}
//拼接英文列表地址行串
function getEnHtmlChar(isdefault,address,city,state,country,county,sellerName,postalcode,phone,mobilephone,addressId,companyname,email){
	var html="";
	html+="<tr>";
	html+="	<td class=\"align-left\">";
	if(isdefault==true){
		html+="		<span style=\"color:#7d0000;\" class=\"defaultAdd\">【默认地址】</span><input type=\"hidden\" class=\"addressId\" value=\""+addressId+"\" />";
	}else{
		html+="		<span style=\"color:#7d0000;\" class=\"defaultAdd\"></span><input type=\"hidden\" class=\"addressId\" value=\""+addressId+"\" />";
	}
	html+="		<span class=\"address\">"+address+"</span>,";
	if(county == ''||county == null){
		html+="<span class=\"county\">"+county+"</span>";
	}else{
		html+="<span class=\"county\">"+county+"</span>,";
	}
	html+="<span class=\"city\">"+city+"</span>, <span class=\"state\">"+state+"</span>, <span class=\"country\">"+country+"</span>";
	html+="	</td>";
	html+="	<td><span class=\"sellerName\">"+sellerName+"</span></td>";
	html+="	<td><span class=\"postalcode\">"+postalcode+"</span></td>";
	html+="	<td class=\"align-left\">";
	html+="		<span>+86-</span><span class=\"phone\">"+phone+"</span>";
	if(mobilephone&&mobilephone!=""){
		html+="		<br/><span class=\"mobilephone86\">+86-</span><span class=\"mobilephone\">"+mobilephone+"</span>";
	}else{
		html+="		<br/><span class=\"mobilephone86\" style=\"display:none;\">+86-</span><span class=\"mobilephone\"></span>";
	}
	html+="	</td>";
	html+="	<td><a href=\"javascript:void(0)\" class=\"modifyBtn\">修改</a> <a href=\"javascript:void(0)\" class=\"deleteBtn\">删除</a></td>";
	html+="<input type=\"hidden\" value=\""+email+"\" id=\"save-emailshow\"/><input type=\"hidden\" value=\""+companyname+"\" id=\"save-companynameshow\"/>";
	html+="</tr>";
	return html;
}
//拼接中文地址列表
function getChHtmlChar(isdefault,address,city,state,country,county ,sellerName,postalcode,phone,mobilephone,addressId,companyname,email){
	var html="";
	html+="<tr>";
	html+="	<td class=\"align-left\">";
	if(isdefault==true){
		html+="		<span style=\"color:#7d0000;\" class=\"defaultAdd\">【默认地址】</span><input type=\"hidden\" class=\"addressId\" value=\""+addressId+"\" />";
	}else{
		html+="		<span style=\"color:#7d0000;\" class=\"defaultAdd\"></span><input type=\"hidden\" class=\"addressId\" value=\""+addressId+"\" />";
	}
	html+="    <span class=\"address\">"+address+"</span>,";
	if(county == ''||county == null){
		html+="<span class=\"county\">"+county+"</span>";
	}else{
		html+="<span class=\"county\">"+county+"</span>,";
	}
	html+=	" <span class=\"city\">"+city+"</span>, <span class=\"state\">"+state+"</span>, <span class=\"country\">"+country+"</span></td>";
	html+="	<td><span class=\"sellerName\">"+sellerName+"</span></td>";
	html+="	<td><span class=\"postalcode\">"+postalcode+"</span></td>";
	html+="	<td class=\"align-left\"><span>+86-</span><span class=\"phone\">"+phone+"</span><br/>";
	if(mobilephone&&mobilephone!=""){
		html+="		<span class=\"mobilephone86\">+86-</span><span class=\"mobilephone\">"+mobilephone+"</span></td>";
	}else{
		html+="		<span class=\"mobilephone86\" style=\"display:none;\">+86-</span><span class=\"mobilephone\">"+mobilephone+"</span></td>";
	}
	html+="	<td><a href=\"javascript:void(0)\" class=\"modifyCnBtn\">修改</a> <a href=\"javascript:void(0)\" class=\"delCnBtn\">删除</a></td>";
	html+="<input type=\"hidden\" value=\""+email+"\" id=\"cn-emailshow\"/><input type=\"hidden\" value=\""+companyname+"\" id=\"cn-companynameshow\"/>";
	html+="</tr>";
	return html;
}
function trim(instr){  
    return instr.replace(/(^-*)|(\-$)/g, "");  
}
//当中文地址列表新增或减少数据的时候，更新页面相关的显示效果
function updateCnLastNo(){
	var listSize=6-$("#chAddrList tr").size();
	$("#lastNoCn").html(listSize);
	if(listSize<1){
		$("#addCnAddrBtnWapper").css("display","none");	
	}else{
		$("#addCnAddrBtnWapper").css("display","block");
	}
}
//当英文地址列表新增或减少数据的时候，更新页面相关的显示效果
function updateLastNo(){
	var listSize=6-$("#englishAddrList tr").size();
	$("#lastNo").html(listSize);
	if(listSize<1){
		$("#addEnAddrBtnWapper").css("display","none");	
	}else{
		$("#addEnAddrBtnWapper").css("display","block");
	}
}
function evalData(data){
	var returnStr=decodeURIComponent(data);
	var returndata=eval('('+returnStr+')');
	return returndata;
}
//中文省市关联
function changeProvince(provinceid){
	if(provinceid == "" ){
		document.getElementById('cn-city').options.length=0;
		return;
	}
		
	if(g_arrProcinceCityList[provinceid] == null){
	   	jQuery.ajax({
	   		type: "POST",
	   		url: "/merchant/register/getCitys.do?isblank=true&provinceid=" + provinceid,
	   		dataType: "text",
		    success: function(data,status) {		   
		    	var citysstr = getCitysStr(data);
				resetCitySelect('cn-city', citysstr);
		    },
		    error: function (data, status, e) { alert(e);}
		}); 
	}else{
		resetCitySelect('cn-city', g_arrProcinceCityList[provinceid]);
	}
	
	if(provinceid == "64C1EDCCA357BC5BE040007F01004020"||provinceid == "64C1EDCCA365BC5BE040007F01004020"
		||provinceid == "64C1EDCCA366BC5BE040007F01004020"||provinceid == "64C1EDCCA36BBC5BE040007F01004020"
		||provinceid == "64C1EDCCA373BC5BE040007F01004020"||provinceid == "64C1EDCCA374BC5BE040007F01004020"
		||provinceid == "64C1EDCCA372BC5BE040007F01004020"){
		$("#save-ch").find("#cn-county").val("");
		$("#save-ch").find("#cn-county").text("");
	}
}

//英文（拼音）省市关联
function changeProvinceEn(provinceid){
	if(provinceid == "" ){
		document.getElementById('save-city').options.length=0;
		return;
	}
		
	if(g_arrProcinceCityEnList[provinceid] == null){
	   	jQuery.ajax({
	   		type: "POST",
	   		url: "/merchant/getEncities.do?isblank=true&provinceid=" + provinceid,
	   		dataType: "text",
		    success: function(data,status) {		   
		    	var citysstr = getCitysStren(data);
				resetCitySelect('save-city', citysstr);
		    },
		    error: function (data, status, e) { alert(e);}
		}); 
	}else{
		resetCitySelect('save-city', g_arrProcinceCityEnList[provinceid]);
	}
	
	if(provinceid == "64C1EDCCA357BC5BE040007F01004020"||provinceid == "64C1EDCCA365BC5BE040007F01004020"
		||provinceid == "64C1EDCCA366BC5BE040007F01004020"||provinceid == "64C1EDCCA36BBC5BE040007F01004020"
		||provinceid == "64C1EDCCA373BC5BE040007F01004020"||provinceid == "64C1EDCCA374BC5BE040007F01004020"
		||provinceid == "64C1EDCCA372BC5BE040007F01004020"){
		$("#save-eng").find("#save-county").val("");
		$("#save-eng").find("#save-county").text("");
	}
}

//中文市县关联
function changeCity(cityid){
	if(cityid == "" ){
		document.getElementById('cn-county').options.length=0;
		return;
	}
		
	if(g_arrProcinceCityList[cityid] == null){
	   	jQuery.ajax({
	   		type: "POST",
	   		url: "/merchant/getCounties.do?isblank=true&cityid=" + cityid,
	   		dataType: "text",
		    success: function(data,status) {		   
		    	var countiesstr = getCountiesStr(data);
		    	resetCountySelect('cn-county', countiesstr);
		    },
		    error: function (data, status, e) { alert(e);}
		}); 
	}else{
		resetCountySelect('cn-county', g_arrProcinceCityList[cityid]);
	}
}

//英文市县关联
function changeCityEn(cityid){
	if(cityid == "" ){
		document.getElementById('save-county').options.length=0;
		return;
	}
		
	if(g_arrProcinceCityEnList[cityid] == null){
	   	jQuery.ajax({
	   		type: "POST",
	   		url: "/merchant/getCounties.do?isblank=true&cityid=" + cityid,
	   		dataType: "text",
		    success: function(data,status) {		   
		    	var countiesstr = getCountiesStren(data);
		    	resetCountySelecten('save-county', countiesstr);
		    },
		    error: function (data, status, e) { alert(e);}
		}); 
	}else{
		resetCountySelecten('save-county', g_arrProcinceCityEnList[cityid]);
	}
}
//中文关联存储
var g_arrProcinceCityList={};
//英文关联存储
var g_arrProcinceCityEnList={};

function resetCitySelect(cityselectid, retmes) {
	var selObj = document.getElementById(cityselectid);
	if(retmes != null && retmes != "" && selObj != null ){
		selObj.options.length=0;
		var retmeslist = retmes.split("-");
		for(var i=0;i<retmeslist.length;i++){
			var cityinfo = retmeslist[i].split(":");
     		var tid = cityinfo[0];
     		if(tid=="''")tid = "";
     		
     		var tname = cityinfo[1].Trim();     		
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

function resetCountySelect(cityselectid, retmes) {
	var selObj = document.getElementById(cityselectid);
	var retmeslist = retmes.split("-");
	if(retmes != null && retmes != "" && selObj != null ){
		$("#save-ch").find("#cn-county").attr("disabled",false);
		selObj.options.length=0;
		for(var i=0;i<retmeslist.length;i++){
			var cityinfo = retmeslist[i].split(":");
     		var tid = cityinfo[0];
     		if(tid=="''")tid = "";
     		var tname = cityinfo[1].Trim(); 
 			selObj.options.add(new Option(tname,tid));
		}
		if(retmeslist.length>1){
			selObj.options[1].selected = true;
		}else{
			selObj.options[0].selected = true;
		}
	}else{
		$("#save-ch").find("#cn-county").val("");  
		$("#save-ch").find("#cn-county").text("");
		$("#save-ch").find("#cn-county").attr("disabled","true");
	}
}


function resetCountySelecten(cityselectid, retmes) {
	var selObj = document.getElementById(cityselectid);
	var retmeslist = retmes.split("-");
	if(retmes != null && retmes != "" && selObj != null ){
		$("#save-eng").find("#save-county").attr("disabled",false);
		selObj.options.length=0;
		for(var i=0;i<retmeslist.length;i++){
			var cityinfo = retmeslist[i].split(":");
     		var tid = cityinfo[0];
     		if(tid=="''")tid = "";
     		
     		var tname = cityinfo[2].Trim(); 
 			selObj.options.add(new Option(tname,tid));
		}
		if(retmeslist.length>1){
			selObj.options[1].selected = true;
		}else{
			selObj.options[0].selected = true;
		}
	}else{
		$("#save-eng").find("#save-county").val("");  
		$("#save-eng").find("#save-county").text("");  
		$("#save-eng").find("#save-county").attr("disabled","true");
	}
}
function getCitysStr(content) {
	var strCityList = "";
	var retmeslist = content.split("|");
	if(retmeslist.length==2){
		strCityList = retmeslist[1];
		g_arrProcinceCityList[retmeslist[0]]=strCityList.Trim();
	}else{
		return "";
	}
	return strCityList.Trim();
}

function getCitysStren(content) {
	var strCityList = "";
	var retmeslist = content.split("|");
	if(retmeslist.length==2){
		strCityList = retmeslist[1];
		g_arrProcinceCityEnList[retmeslist[0]]=strCityList.Trim();
	}else{
		return "";
	}
	return strCityList.Trim();
}
function getCountiesStr(content) {
	var strCountyList = "";
	var retmeslist = content.split("|");
	strCountyList = retmeslist[1];
	g_arrProcinceCityList[retmeslist[0]]=strCountyList.Trim();
	return strCountyList.Trim();
}

function getCountiesStren(content) {
	var strCountyList = "";
	var retmeslist = content.split("|");
	strCountyList = retmeslist[1];
	g_arrProcinceCityEnList[retmeslist[0]]=strCountyList.Trim();
	return strCountyList.Trim();
}

String.prototype.Trim=function(){return this.replace(/(^\s+|\s+$)/g,"")};

String.prototype.format = function()
{
    var args = arguments;
    return this.replace(/\{(\d+)\}/g,              
        function(m,i){
            return args[i];
    });
}


//修改英文层的省市a
function changeCnSelectProvinceen(state,city){
	if(state==""){
		return;
	}
	select($("#save-state"),state);
	$("#save-state").change();
	setTimeout("changCityen(\""+city+"\")",500);
}
//修改英文层的省市b
function select(select,optionHtml){
	var count=select.find("option").length;
	for(var i=0;i<count;i++){
		if(select[0].options[i].text == optionHtml){
			select[0].options[i].selected = true;
			break;
		}
	}
}
//修改英文层的省市c
function changCityen(city){
	select($("#save-city"),city);
	$("#save-city").change();
}


//修改中文层的省市a
function changeCnSelectProvince(state,city){
	if(state==""){
		return;
	}
	select($("#cn-province"),state);
	$("#cn-province").change();
	setTimeout("changCity(\""+city+"\")",500);
}
//修改中文层的省市b

//修改中文层的省市c
function changCity(city){
	select($("#cn-city"),city);
	$("#cn-city").change();
	
}




//修改中文层的市县a
function changeCnSelectCounty(city,county){
	if(city==""){
		return;
	}
	selectCounty($("#cn-city"),city);
	$("#cn-city").change();
	setTimeout("changCounty(\""+county+"\")",500);
}
//修改中文层的市县b
function selectCounty(select,optionHtml){
	var count=select.find("option").length;
	for(var i=0;i<count;i++){
		if(select[0].options[i].text == optionHtml){
			select[0].options[i].selected = true;
			break;
		}
	}
}
//修改中文层的市县c
function changCounty(county){
	selectCounty($("#cn-county"),county);
	$("#cn-county").change();
}



//修改英文层的市县a
function changeEnSelectCounty(city,county){
	if(city==""){
		return;
	}
	selectCounty($("#save-city"),city);
	$("#save-city").change();
	setTimeout("changCountyen(\""+county+"\")",500);
}
//修改英文层的市县b

//修改英文层的市县c
function changCountyen(county){
	selectCounty($("#save-county"),county);
	$("#save-county").change();
}

//判断英文或数字同时禁止非法字符
function checkEngNum(str){
	var len;
    var i;
    var pattern = /[\~\!\@\#\$\%\^\&\*\+\<\>\/\?\;\:\"\\]/; 
    if(str.match(pattern)){
    	return false;
    }
    len = 0;
    for (i=0;i<str.length;i++){
    	//alert(str+"          "+str.charCodeAt(i))
		if (str.charCodeAt(i)>255){
			return false;
		}
		if(str.charCodeAt(i)==37
			||str.charCodeAt(i)==38
			||str.charCodeAt(i)==60
			||str.charCodeAt(i)==92
			){
			return false;
		}
    }
    return true;
}
//判断是否是英文，不是英文则返回true
function checkNoEng(str){
	//alert(str)
	var len;
    var i;
    len = 0;
    for (i=0;i<str.length;i++){
        //alert(str.charCodeAt(i));
		if (str.charCodeAt(i)>64){
			return false;
		}
    }
    return true;
}
//判断中文非法字符
function checkValidChar(str){
	var len;
    var i;
    len = 0;
    for (i=0;i<str.length;i++){
		if(str.charCodeAt(i)==37
			||str.charCodeAt(i)==38
			||str.charCodeAt(i)==60
			||str.charCodeAt(i)==92
			){
			return false;
		}
    }}