//字母或数字,1到200位
var regexEnum = 
{
  zipcode:"^(\\d{6}|\\d{5}|\\d{9})|(\\w{1,20})$",							//邮编
  mobile:"^(\\d{0}|[0-9]{11})$",     			//手机
  tel:"^(\(\d{3,4}\)|\d{3,4}-)?\d{7,8}$",//固话
  number:"^[0-9]*$",                     //数字
  phoneno:"^\\d*$"								//电话
}
  

var oncorrect = "<img src='http://image.dhgate.com/2009/factory/register/img/d.gif' />";


$(function(){
	initform();
	
	
	$("#add-english").find("#saveAddress").click(function(){
		jQuery.formValidator.pageIsValid("addForm");
	});
	
	
	
	$("#save-eng").find("#saveEnBtn").click(function(){
		jQuery.formValidator.pageIsValid("saveForm");
	});
	
	
	
	$("#save-ch").find("#saveCnBtn").click(function(){
		jQuery.formValidator.pageIsValid("saveCnForm");
	});
	
	
	
	//英文地址列表 按钮效果
	$("#addEnAddrBtn").click(function(){
		showGlobal_save_eng(false,"","","","China","","","","","","add");
	});
	$("#englishAddrList .deleteBtn").livequery("click",function(){
		if(!confirm("你确认删除该地址吗?")){
			return;
		}
		$(this).removeClass();
		var tr=$(this).parents("tr");
		var adressId=tr.find(".addressId").val();
		$.post("/mydhgate/order/refund/selleraddressajax.do",{
			act:"delete",
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
		var sellerName=tr.find(".sellerName").html();
		var postalcode=tr.find(".postalcode").html();
		var mobilephone=tr.find(".mobilephone").html();
		var phone=tr.find(".phone").html();
		var act="modify";
		
		showGlobal_save_eng(defaultAdd,address,city,state,country,sellerName,postalcode,mobilephone,phone,addressId,act);
	});
	//中文列表，按钮效果
	$("#showAddChinaAddrBtn").click(function(){
		showGlobal_save_ch(false,"","","","China","","","","","","add");
	});
	$("#show-ch .modifyCnBtn").livequery("click",function(){
		var tr=$(this).parents("tr");
		var defaultAdd=""//tr.find(".defaultAdd").html();更多中文地址使用
		var addressId=tr.find(".addressId").val();
		var address=tr.find(".address").html();
		var city=tr.find(".city").html();
		var state=tr.find(".state").html();
		var country=tr.find(".country").html();
		var sellerName=tr.find(".sellerName").html();
		var postalcode=tr.find(".postalcode").html();
		var mobilephone=tr.find(".mobilephone").html();
		var phone=tr.find(".phone").html();
		var act="modify";
		showGlobal_save_ch(defaultAdd,address,city,state,country,sellerName,postalcode,mobilephone,phone,addressId,act);
	});
	$("#show-ch .delCnBtn").livequery("click",function(){
		if(!confirm("你确认删除该地址吗?")){
			return;
		}
		$(this).removeClass();
		var tr=$(this).parents("tr");
		var adressId=tr.find(".addressId").val();
		$.post("/mydhgate/order/refund/selleraddressajax.do",{
			act:"delete",
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
});

function reInitform(){
	initform();
}

function initform(){
	//添加层global_add_eng 表单及验证效果
	$.formValidator.initConfig({validatorgroup:"addForm",
		errorfocus:false,
	    onsuccess:function(){
	    	$("#saveAddressA").css("display","none");
	    	$("#save-savingBtn").css("display","inline-block");
	    	var isdefault=false;
	    	if($("#add-english").find("#check_default").attr("checked")==true){
	    		isdefault=true;
	    	}
	    	var address=$("#add-english").find("#address").val();
	    	var city=$("#add-english").find("#city").val();
	    	var state=$("#add-english").find("#state").val();
	    	var country=$("#add-english").find("#add-country").val();
	    	var sellerName=$("#add-english").find("#contactname").val();
	    	var postalcode=$("#add-english").find("#zipcode").val();
	    	var phone=$("#add-english").find("#tel-phone").val();
	    	var mobilephone=$("#add-english").find("#mobilephone").val();
	    	
	    	$.post("/mydhgate/order/refund/selleraddressajax.do",{
	    		act:"add",
	    		isblank:"true",
	    		address:address,
	    		city:city,
	    		state:state,
	    		country:country,
	    		contactname:sellerName,
	    		zipcode:postalcode,
	    		phone:phone,
	    		mobilephone:mobilephone,
	    		check_default:isdefault
	    	},function(data){
	    		$("#saveAddressA").css("display","inline-block");
	    		$("#save-savingBtn").css("display","none");
	    		var evaldata=evalData(data);
	    		if(evaldata.status=="success"){
	    			var addressId=evaldata.addressId;
			    	if(isdefault==true){
			    		$.each($(".defaultAdd"),function(key,value){
			    			$(value).html("");
			    		});
			    	}
			    	$("#englishAddrList").append(getEnHtmlChar(isdefault,address,city,state,country,sellerName,postalcode,phone,mobilephone,addressId));
					updateLastNo();
	    		}
	    	});
			return false;
		}
	});
	
	
	$("#add-english").find("#contactname").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入联系人姓名!",
		oncorrect:oncorrect,
		validatorgroup:"addForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	
	$("#add-english").find("#state").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入省或直辖市!",
		oncorrect:oncorrect,
		validatorgroup:"addForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	
	$("#add-english").find("#city").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入城市名!",
		oncorrect:oncorrect,
		validatorgroup:"addForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	
	$("#add-english").find("#address").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入详细地址!",
		oncorrect:oncorrect,
		validatorgroup:"addForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).functionValidator({
		onerror: "请输入英文或数字！", 
		fun:checkEngNum
	});
	
	$("#add-english").find("#zipcode").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入邮政编码!",
		oncorrect:oncorrect,
		validatorgroup:"addForm"
	}).inputValidator({
	   min:1,
	   empty:{leftempty:false,rightempty:false,emptyerror:"两边不能有空符号!"},
	   onerror:"不能为空,请确认!"
	}).regexValidator({
		regexp:"zipcode",
		datatype:"enum",
		onerror:"请输入正确的邮编!"
	}).functionValidator({
		onerror: "请输入5或9位邮编", 
		fun:function(num){
			//
			var country = $('#add-country'),val = country.val();
 
			if(val == 'United States'){
				if(num.length == 5 || num.length == 9){
					return true;
				}else{
					return false;
				}
			}
			return true;
		}
	}).functionValidator({
		onerror: "请输入正确的邮编!", 
		fun:function(num){			//
			var country = $('#add-country'),val = country.val();
			
			 if(val == 'China'){
				if(num.length == 6){
					return true;
				}else{
					return false;
				}
			}
			
			return true;
		}
	});
	
	
	$("#add-english").find("#tel-phone").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入联系电话!",
		oncorrect:oncorrect,
		tipid:"phoneTip",
		validatorgroup:"addForm"
	}).inputValidator({
	   min:1,max:30,
	   empty:{leftempty:false,rightempty:false,emptyerror:"联系电话为1到30位!"},
	   onerror:"联系电话为1到30位!"
	}).functionValidator({
		onerror: "请输入正确的联系电话!", 
		fun:checkNoEng
	});
	
	$("#add-english").find("#mobilephone").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入手机号码!",
		oncorrect:oncorrect,
		validatorgroup:"addForm"
	}).regexValidator({
		regexp:"mobile",
		datatype:"enum",
		onerror:"请输入正确的手机号码!"
	});

//保存层global_save_eng 表单及验证效果
	$.formValidator.initConfig({validatorgroup:"saveForm",
		errorfocus:false,
	    onsuccess:function(){
	    	var address=$("#save-eng").find("#save-address").val();
	    	var city=$("#save-eng").find("#save-city").val();
	    	var state=$("#save-eng").find("#save-state").val();
	    	var country=$("#save-eng").find("#save-country").val();
	    	var sellerName=$("#save-eng").find("#save-contactname").val();
	    	var postalcode=$("#save-eng").find("#save-zipcode").val();
	    	var phone=$("#save-eng").find("#save-tel-phone").val();
	    	var mobilephone=$("#save-eng").find("#save-mobilephone").val();
	    	var adressId=$("#save-eng").find("#save-adressId").val();
	    	var act=$("#save-eng").find("#save-act").val();
	    	var isdefault=false;
	    	if($("#save-eng").find("#save-check_default").attr("checked")==true){
	    		isdefault=true;
	    	}
	    	$.post("/mydhgate/order/refund/selleraddressajax.do",{
	    		act:act,
	    		isblank:"true",
	    		address:address,
	    		city:city,
	    		state:state,
	    		country:country,
	    		contactname:sellerName,
	    		zipcode:postalcode,
	    		phone:phone,
	    		mobilephone:mobilephone,
	    		adressId:adressId,
	    		check_default:isdefault
	    	},function(data){
	    		var evaldata=evalData(data);
				if(evaldata.status=="success"){
			    	if(act=="modify"){
			    		var tr=$("#englishAddrList .addressId[value="+adressId+"]").parents("tr");
			    		if(isdefault==true){
			    			$.each($(".defaultAdd"),function(key,value){
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
						tr.find(".sellerName").html(sellerName);
						tr.find(".postalcode").html(postalcode);
						tr.find(".mobilephone").html(mobilephone);
						tr.find(".phone").html(phone);
						if(mobilephone!=""){
							tr.find(".mobilephone86").css("display","inline-block");
						}else{
							tr.find(".mobilephone86").css("display","none");
						}
			    	}else if(act=="add"){
			    		addressId=evaldata.addressId;
			    		if(isdefault==true){
			    			$.each($(".defaultAdd"),function(key,value){
				    			$(value).html("");
				    		});
			    		}
			    		$("#englishAddrList").append(getEnHtmlChar(isdefault,address,city,state,country,sellerName,postalcode,phone,mobilephone,addressId));
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
	}).functionValidator({
		onerror: "请输入5或9位邮编", 
		fun:function(num){
			//
			var country = $('#save-country'),val = country.val();
 
			if(val == 'United States'){
				if(num.length == 5 || num.length == 9){
					return true;
				}else{
					return false;
				}
			}
			return true;
		}
	}).functionValidator({
		onerror: "请输入正确的邮编!", 
		fun:function(num){			//
			var country = $('#save-country'),val = country.val();
			
			 if(val == 'China'){
				if(num.length == 6){
					return true;
				}else{
					return false;
				}
			}
			
			return true;
		}
	});
	
	
	$("#save-eng").find("#save-tel-phone").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入联系电话!",
		oncorrect:oncorrect,
		tipid:"save-phoneTip",
		validatorgroup:"saveForm"
	}).inputValidator({
	   min:1,max:30,
	   empty:{leftempty:false,rightempty:false,emptyerror:"联系电话为1到30位!"},
	   onerror:"联系电话为1到30位!"
	}).functionValidator({
		onerror: "请输入正确的联系电话!", 
		fun:checkNoEng
	});
	
	$("#save-eng").find("#save-mobilephone").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入手机号码!",
		oncorrect:oncorrect,
		validatorgroup:"saveForm"
	}).regexValidator({
		regexp:"mobile",
		datatype:"enum",
		onerror:"请输入正确的手机号码!"
	});
//中文层global_save_ch 表单及验证效果
	$.formValidator.initConfig({validatorgroup:"saveCnForm",
		errorfocus:false,
	    onsuccess:function(){
	    	var isdefault=false;
	    	//if(global_save_ch.find("#cn-check_default").attr("checked")==true){添加更多中文地址使用
	    	//	isdefault=true;
	    	//}
	    	var address=$("#save-ch").find("#cn-address").val();
	    	var city=$("#save-ch").find("#cn-city").find("option:selected").text();
	    	var state=$("#save-ch").find("#cn-province").find("option:selected").text();
	    	var country=$("#save-ch").find("#cn-country").val();
	    	var sellerName=$("#save-ch").find("#cn-contactname").val();
	    	var postalcode=$("#save-ch").find("#cn-postcode").val();
	    	var phone=$("#save-ch").find("#cn-tel-phone").val();
	    	var mobilephone=$("#save-ch").find("#cn-mobile").val();
	    	var adressId=$("#save-ch").find("#cn-adressId").val();
	    	var act=$("#save-ch").find("#cn-act").val();
	    	
	    	$.post("/mydhgate/order/refund/selleraddressajax.do",{
	    		act:act,
	    		isblank:"true",
	    		address:address,
	    		check_default:isdefault,
	    		city:city,
	    		state:state,
	    		country:country,
	    		contactname:sellerName,
	    		zipcode:postalcode,
	    		phone:phone,
	    		mobilephone:mobilephone,
	    		adressId:adressId,
	    		allowChinese:"yes"
	    	},function(data){
	    		var evaldata=evalData(data);
				if(evaldata.status=="success"){
			    	if(act=="modify"){
			    		var tr=$("#chAddrList .addressId[value="+adressId+"]").parents("tr");
			    		if(isdefault==true){
			    			$.each($(".defaultAdd"),function(key,value){
				    			$(value).html("");
				    		});
			    			tr.find(".defaultAdd").html("【默认地址】");
			    		}
						tr.find(".address").html(address);
						tr.find(".city").html(city);
						tr.find(".state").html(state);
						tr.find(".country").html(country);
						tr.find(".sellerName").html(sellerName);
						tr.find(".postalcode").html(postalcode);
						tr.find(".mobilephone").html(mobilephone);
						tr.find(".phone").html(phone);
						if(mobilephone!=""){
							tr.find(".mobilephone86").css("display","inline-block");
						}else{
							tr.find(".mobilephone86").css("display","none");
						}
						
			    	}else if(act=="add"){
			    		addressId=evaldata.addressId;
			    		if(isdefault==true){
			    			$.each($(".defaultAdd"),function(key,value){
				    			$(value).html("");
				    		});
			    		}
			    		$("#chAddrList").append(getChHtmlChar(isdefault,address,city,state,country,sellerName,postalcode,phone,mobilephone,addressId));
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
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,
	   onerror:"省不能为空,请确认!"
	});
	$("#save-ch").find("#cn-city").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入市!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,
	   onerror:"市不能为空,请确认!"
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
	
	
	$("#save-ch").find("#cn-tel-phone").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入联系电话!",
		oncorrect:oncorrect,
		tipid:"cn-phoneTip",
		validatorgroup:"saveCnForm"
	}).inputValidator({
	   min:1,max:30,
	   empty:{leftempty:false,rightempty:false,emptyerror:"联系电话为1到30位!"},
	   onerror:"联系电话为1到30位!"
	}).functionValidator({
		onerror: "请输入正确的联系电话!", 
		fun:checkNoEng
	});
	
	$("#save-ch").find("#cn-mobile").formValidator({
		onshow:"&nbsp;",
		onfocus:"请输入手机号码!",
		oncorrect:oncorrect,
		validatorgroup:"saveCnForm"
	}).regexValidator({
		regexp:"mobile",
		datatype:"enum",
		onerror:"请输入正确的手机号码!"
	});
}
//添加层global_add_eng 清空
function showGlobal_add_eng(){
	$("#add-english").find("#check_default").attr("checked",false);
	$("#add-english").find("#address").val("");
	$("#add-english").find("#city").val("");
	$("#add-english").find("#state").val("");
	//global_save_eng.find("#save-country").val(country);
	$("#add-english").find("#contactname").val("");
	$("#add-english").find("#zipcode").val("");
	$("#add-english").find("#mobilephone").val("");
	$("#add-english").find("#tel-phone").val("");
	$.each($("#add-english").find("span[id$='Tip']"),function(key,value){
		$(value).html("");
	});
}
function checkDefaultBox(ischeck){
	$("#save-eng").find("#save-check_default").attr("checked",ischeck);
}
//英文保存层global_save_eng 显示效果
function showGlobal_save_eng(defaultAdd,address,city,state,country,sellerName,postalcode,mobilephone,phone,addressId,act){
	if(defaultAdd){
		setTimeout("checkDefaultBox(true)",500);
	}else{
		setTimeout("checkDefaultBox(false)",500);
	}
	
	$("#save-eng").find("#save-address").val(address);
	$("#save-eng").find("#save-city").val(city);
	$("#save-eng").find("#save-state").val(state);
	$("#save-eng").find("#save-country").val(country);
	//global_save_eng.find("#save-country").val(country);
	$("#save-eng").find("#save-contactname").val(sellerName);
	$("#save-eng").find("#save-zipcode").val(postalcode);
	if(mobilephone){
		$("#save-eng").find("#save-mobilephone").val(mobilephone);
	}else{
		$("#save-eng").find("#save-mobilephone").val("");
	}
	$("#save-eng").find("#save-tel-phone").val(phone);
	$("#save-eng").find("#save-adressId").val(addressId);
	$("#save-eng").find("#save-act").val(act);
	$.each($("#save-eng").find("span[id$='Tip']"),function(key,value){
		$(value).html("");
		$(value).removeClass();
	});
	if(act=="modify"){
		$("#save-eng").find(".noshade-pop-title span").html("修改退货地址:");
	}else{
		$("#save-eng").find(".noshade-pop-title span").html("添加退货地址:");
	}
	$("#save-eng-wraper").modal({close:false});
}
//中文保存层global_save_ch 显示效果
function showGlobal_save_ch(defaultAdd,address,city,state,country,sellerName,postalcode,mobilephone,phone,addressId,act){
	//if(defaultAdd){将来加更多中文地址的时候会用到
	//	global_save_ch.find("#save-check_default").attr("checked",true);
	//}else{
	//	global_save_ch.find("#save-check_default").attr("checked",false);
	//}
	
	$("#save-ch").find("#cn-address").val(address);
	//global_save_ch.find("#cn-city").val(city);
	//global_save_ch.find("#cn-province").val(state);
	changeCnSelectProvince(state,city);
	//global_save_ch.find("#cn-country").val(country);
	$("#save-ch").find("#cn-contactname").val(sellerName);
	$("#save-ch").find("#cn-postcode").val(postalcode);
	if(mobilephone){
		$("#save-ch").find("#cn-mobile").val(mobilephone);
	}else{
		$("#save-ch").find("#cn-mobile").val("");
	}
	$("#save-ch").find("#cn-tel-phone").val(phone);
	$("#save-ch").find("#cn-adressId").val(addressId);
	$("#save-ch").find("#cn-act").val(act);
	$.each($("#save-ch").find("span[id$='Tip']"),function(key,value){
		$(value).html("");
	});
	if(act=="modify"){
		$("#save-ch").find(".noshade-pop-title span").html("修改退货地址:");
	}else{
		$("#save-ch").find(".noshade-pop-title span").html("添加退货地址:");
	}
	$("#save-cn-wraper").modal({close:false});
}
//拼接英文列表地址行串
function getEnHtmlChar(isdefault,address,city,state,country,sellerName,postalcode,phone,mobilephone,addressId){
	var html="";
	html+="<tr>";
	html+="	<td class=\"align-left\">";
	if(isdefault==true){
		html+="		<span style=\"color:#7d0000;\" class=\"defaultAdd\">【默认地址】</span><input type=\"hidden\" class=\"addressId\" value=\""+addressId+"\" />";
	}else{
		html+="		<span style=\"color:#7d0000;\" class=\"defaultAdd\"></span><input type=\"hidden\" class=\"addressId\" value=\""+addressId+"\" />";
	}
	html+="		<span class=\"address\">"+address+"</span>, <span class=\"city\">"+city+"</span>, <span class=\"state\">"+state+"</span>, <span class=\"country\">"+country+"</span>";
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
	html+="</tr>";
	return html;
}
//拼接中文地址列表
function getChHtmlChar(isdefault,address,city,state,country,sellerName,postalcode,phone,mobilephone,addressId){
	var html="";
	html+="<tr>";
	html+="	<td class=\"align-left\"><span class=\"address\">"+address+"</span>, <span class=\"city\">"+city+"</span>, <span class=\"state\">"+state+"</span>, <span class=\"country\">"+country+"</span></td>";
	html+="	<td><span class=\"sellerName\">"+sellerName+"</span></td>";
	html+="	<td><span class=\"postalcode\">"+postalcode+"</span></td>";
	html+="	<td class=\"align-left\"><span>+86-</span><span class=\"phone\">"+phone+"</span><br/>";
	if(mobilephone&&mobilephone!=""){
		html+="		<span class=\"mobilephone86\">+86-</span><span class=\"mobilephone\">"+mobilephone+"</span></td>";
	}else{
		html+="		<span class=\"mobilephone86\" style=\"display:none;\">+86-</span><span class=\"mobilephone\">"+mobilephone+"</span></td>";
	}
	html+="	<td><input type=\"hidden\" class=\"addressId\" value=\""+addressId+"\" /><a href=\"javascript:void(0)\" class=\"modifyCnBtn\">修改</a> <a href=\"javascript:void(0)\" class=\"delCnBtn\">删除</a></td>";
	html+="</tr>";
	return html;
}
function trim(instr){  
    return instr.replace(/(^-*)|(\-$)/g, "");  
}
//拆分电话 将带"-"的电话格式拆分为数组
var splitCharA="- ";
var splitCharB="-";
//当中文地址列表新增或减少数据的时候，更新页面相关的显示效果
function updateCnLastNo(){
	var listSize=$("#chAddrList tr").size();
	if(listSize>1){
		$("#show-ch").css("display","block");
		$("#add-chinese").css("display","none");
	}else{
		$("#show-ch").css("display","none");
		$("#add-chinese").css("display","block");
	}
}
//当英文地址列表新增或减少数据的时候，更新页面相关的显示效果
function updateLastNo(){
	var listSize=5-$("#englishAddrList tr").size();
	$("#lastNo").html(listSize);
	if(listSize<1){
		$("#addEnAddrBtnWapper").css("display","none");
	}else{
		$("#addEnAddrBtnWapper").css("display","block");
	}
	if(listSize==4){
		$("#add-english").css("display","block");
		showGlobal_add_eng();
		$("#show-eng").css("display","none");
	}else{
		$("#add-english").css("display","none");
		$("#show-eng").css("display","block");
	}
}
function evalData(data){
	var returnStr=decodeURIComponent(data);
	var returndata=eval('('+returnStr+')');
	return returndata;
}
function changeProvince(provinceid){
	if(provinceid == "" ){
		document.getElementById('cn-city').options.length=0;
		return;
	}
		
	if(g_arrProcinceCityList[provinceid] == null){
	   	jQuery.ajax({
	   		type: "POST",
	   		url: "/usr/sellerregister.do?act=getcitys&isblank=true&provinceid=" + provinceid,
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
}
var g_arrProcinceCityList={};
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

String.prototype.Trim=function(){return this.replace(/(^\s+|\s+$)/g,"")};

String.prototype.format = function()
{
    var args = arguments;
    return this.replace(/\{(\d+)\}/g,              
        function(m,i){
            return args[i];
    });
}

//修改中文层的省市a
function changeCnSelectProvince(state,city){
	if(state==""){
		return;
	}
	select($("#cn-province"),state)
	$("#cn-province").change();
	setTimeout("changCity(\""+city+"\")",500);
}
//修改中文层的省市b
function select(select,optionHtml){
	var count=select.find("option").length;
	for(var i=0;i<count;i++){
		if(select[0].options[i].text == optionHtml){
			select[0].options[i].selected = true;
			break;
		}
	}
}
//修改中文层的省市c
function changCity(city){
	select($("#cn-city"),city)
	$("#cn-city").change();
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
    }
    return true;
}

function setZipCode(){
	var country=$("#save-eng").find("#save-country").val();
	if(country=="China"){
		$("#save-zipcode").attr({'maxlength':'6'});
	}else if(country=="United States"){
		$("#save-zipcode").attr({'maxlength':'9'});
	}else{
		$("#save-zipcode").attr({'maxlength':'20'});
	}
	$("#save-zipcode").val('');
}