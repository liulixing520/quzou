<div class="wrap">
    <div id="employee">
        <form action="<#if customer?has_content>updateQzCustomer<#else>createQzCustomer</#if>" name="MyForm" id="MyForm" method="post">
        <#if customer?has_content><input type="hidden" name="partyId" value="${(customer.partyId)!}"/></#if>
        <div class="employee_block">
            <h3>基本信息<em></em></h3>
            <ul class="employee_info">
                <li>
                    <label class="title">登陆用户名：</label>
                    <input class="inp-text kingkong-input name" id="userLoginId" type="text" <#if customer?has_content>readonly="true"</#if>  name="userLoginId" value="${(customer.userLoginId)!}" />
                </li>
                <li>
                    <label class="title">姓名：</label>
                    <input class="inp-text kingkong-input name" id="employeeName" type="text" name="firstName" value="${(customer.firstName)!}" placeholder="姓名"/>
                </li>
                <li>
                	<label class="title">手机：</label>
                    <input class="inp-text kingkong-input phone phoneNumber" type="text" id="telephone" name="telephone" value="${(customer.telephone)!}" placeholder="手机"/>
                </li>
                <li>
                    <label class="title">性别：</label>
                    <label title="F" class="radio <#if "${(customer.gender)!}"=="F">cur</#if>">女</label>
                    <label title="M" class="radio <#if "${(customer.gender)!}"=="M"||!customer?has_content>cur</#if>">男</label>
                    <input class="sex" id="gender" name="gender" type="hidden" value="${(customer.gender)?default("M")!}"/>
                </li>
                <li>
                    <label class="title fl">生日：</label>
                    <input name="birthDate" style="margin-left: 4px;" class="inp-text ff_calendar fl" type="text" value="${(customer.birthDate?string("yyyy-MM-dd"))!}" onchange="$('#constellation').val(autoParseConstellation(this.value))" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" >
                </li>
                <li>
                    <label class="title fl">身高：</label>
                    <input name="height" style="margin-left: 4px;" class="inp-text kingkong-input" type="text" value="${(customer.height)!}" >
                </li>
                <li>
                    <label class="title fl">体重：</label>
                    <input name="weight" style="margin-left: 4px;" class="inp-text kingkong-input" type="text" value="${(customer.weight)!}" >
                </li>
                <li>
                    <label class="title">邮箱：</label>
                    <input class="inp-text kingkong-input name" id="email" type="text" name="email" value="${(customer.email)!}"/>
                </li>
                <li>
                    <label class="title">单位：</label>
                    <input class="inp-text kingkong-input name selectTransferPut" id="companyName" type="text" name="companyName" value="${(customer.companyName)!}"/>
	                    <#if companyList?has_content>
				        <ul class="transferAccountsSelect" id="transferAccountsSelect" style="display: none;max-height:300px">
				          <#list companyList as item>
				            <li title="${(item.companyName)!}" alt="${(item.companyId)!}" style="margin-top: 0px;">
				              <div class="transfer_name">${(item.companyName)!}
				              </div>
				            </li>
				          </#list>
				        </ul>
				      </#if>
                </li>
                <li>
                    <label class="title">计步器号：</label>
                    <input class="inp-text kingkong-input name" id="cardId" type="text" name="cardId" value="${(customer.cardId)!}"/>
                    <input class="inp-text kingkong-input name" id="oldCardId" type="hidden"  value="${(customer.cardId)!}"/>
                </li>
            </ul>
           <div class="gestores_list" style="float: left;margin: 20px 0 0 50px;">
           <#if customer?has_content>
                <a class="submit" href="javascript:" onclick="unbundling()" >解绑</a>
                <a class="submit" href="javascript:" onclick="goCollection()" >补录数据</a>
           </#if>
                <a action="submit" class="submit tj" href="javascript:void(0)" >提交</a>
            </div>
        </div>
        </form>
    </div>
</div>

<script type="text/javascript" src="../images/js/public.js"></script>
<!--弹窗start -->
<script type="text/javascript" src="../images/js/jquery.cm_dialog.js"></script>
<script src="../images/js/std.min.js"></script>

<script type="text/javascript">
    function goCollection(){
        $(this).cm_dialog({
            url: "collectionDialog?cardId=${(customer.cardId)!}&customerId=${(customer.partyId)!}",
            width: '810px',
        });
    };
    function unbundling(){
    	if(confirm("确定解绑该用户?")){
    		var partyId = '${(customer.partyId)!}';
    		$.ajax({
		       url: '<@ofbizUrl>unbundling</@ofbizUrl>',
		       data: {partyId:partyId},
		       type: "POST",
		       async:false,
		       success: function(data) {
		       		alert("解绑成功!");
		       }
		   });
    	}
    };
</script>

<!--表单验证-->
<script type="text/javascript">
	// 手机号码验证
	jQuery.validator.addMethod("isMobile", function(value, element) {
	     var length = value.length;
	    var mobile = /^(((13[0-9]{1})|(14[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
	   return this.optional(element) || (length == 11 && mobile.test(value));
	}, "请正确填写您的手机号码");
	// cardId验证
	jQuery.validator.addMethod("isCardId", function(value, element) {
	     var length = value.length;
	    var cardId = /^\d{10}$/;
	   return this.optional(element) || (length == 10 && cardId.test(value));
	}, "请正确填写十位数字的计步器号");
	
	
	//增加身份证验证
	function isIdCardNo(num) {
	    var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
	    var parityBit = new Array("1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2");
	    var varArray = new Array();
	    var intValue;
	    var lngProduct = 0;
	    var intCheckDigit;
	    var intStrLen = num.length;
	    var idNumber = num;
	    // initialize
	    if ((intStrLen != 15) && (intStrLen != 18)) {
	        return false;
	    }
	    // check and set value
	    for (i = 0; i < intStrLen; i++) {
	        varArray[i] = idNumber.charAt(i);
	        if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
	            return false;
	        } else if (i < 17) {
	            varArray[i] = varArray[i] * factorArr[i];
	        }
	    }

	    if (intStrLen == 18) {
	        //check date
	        var date8 = idNumber.substring(6, 14);
	        if (isDate8(date8) == false) {
	            return false;
	        }
	        // calculate the sum of the products
	        for (i = 0; i < 17; i++) {
	            lngProduct = lngProduct + varArray[i];
	        }
	        // calculate the check digit
	        intCheckDigit = parityBit[lngProduct % 11];
	        // check last digit
	        if (varArray[17] != intCheckDigit) {
	            return false;
	        }
	    }
	    else {        //length is 15
	        //check date
	        var date6 = idNumber.substring(6, 12);
	        if (isDate6(date6) == false) {
	            return false;
	        }
	    }
	    return true;
	}
	function isDate6(sDate) {
	    if (!/^[0-9]{6}$/.test(sDate)) {
	        return false;
	    }
	    var year, month, day;
	    year = sDate.substring(0, 4);
	    month = sDate.substring(4, 6);
	    if (year < 1700 || year > 2500) return false
	    if (month < 1 || month > 12) return false
	    return true
	}

	function isDate8(sDate) {
	    if (!/^[0-9]{8}$/.test(sDate)) {
	        return false;
	    }
	    var year, month, day;
	    year = sDate.substring(0, 4);
	    month = sDate.substring(4, 6);
	    day = sDate.substring(6, 8);
	    var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	    if (year < 1700 || year > 2500) return false
	    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1] = 29;
	    if (month < 1 || month > 12) return false
	    if (day < 1 || day > iaMonthDays[month - 1]) return false
	    return true
	}
	jQuery.validator.addMethod("isIdCardNo", function (value, element) {
        return this.optional(element) || isIdCardNo(value);
    }, "请正确输入您的身份证号码");

	$(document).ready(function(){
		$("#MyForm").validate({
			errorElement : "span",
			onfocusout : false,
			rules:{
				"userLoginId":{		
					required:true,//表示必填，如果有的地方不是必须让用户填写的，可以不加这个规则。
					minlength:2,
					maxlength:20
				},
				"firstName":{		//firstName input的name名称
					required:true,
					minlength:2,
					maxlength:10
				},
				"telephone":{
					required:true,
					isMobile:true
				},
				"companyName":{
					required:true
				},
				"cardId":{
					required:true,
					isCardId:true
				}
			},
			messages:{
				"userLoginId":{
					required:"请输入您的姓名",
					minlength:"您输入的姓名过短，请保持两个字符以上",
					maxlength:"您输入的姓名过长，请保持20个字符以下"
				},
				"firstName":{
					required:"请输入您的姓名",
					minlength:"您输入的姓名过短，请保持两个字符以上",
					maxlength:"您输入的姓名过长，请保持10个字符以下"
				},
				"telephone":{
					required:"请填写您的手机号码",
					isMobile:"请正确输入您的手机号码"
				},
				"companyName":{
					required:"请填写您的单位名称"
				},
				"cardId":{
					required:"请填写您的计步器号",
					isCardId:"请正确填写十位数字的计步器号"
				}
			}
		});

	});

	$(".tj").click(function(){
		 if($("#MyForm").valid()){
		     checkAndSubmit();
		 }else{
		 	return false;
		 }
	});

$(function(){
	/*禁止输入英文或特殊字符*/
	$("body").on("keyup",".phoneNumber",function(){
        var input = $(this);
        var value = input.val();
        if(value == ""){
			return;
		}
        if(!$.isNumeric(value) || value.indexOf(".") !== -1){
            input.val(input.attr("_lastValue"));
        }else{
            input.attr("_lastValue",value);
        }
	});
	/*身份证禁止输入英文或特殊字符*/
	/*$("body").on("keyup","#idCard",function(){
        var input = $(this);
        var value = input.val();
        var length = value.length;
        if(value == ""){
			return;
		}
		if(length < 18){
			 if(!$.isNumeric(value) || value.indexOf(".") !== -1){
	            input.val(input.attr("_lastValue"));
	        }else{
	            input.attr("_lastValue",value);
	        }
		}

	});
	*/
});
</script>
<script type="text/javascript">
    function disabledSubmitButton(){
        $(document.createElement("div")).css({
            top:0,
            left:0,
            width:$(document).width(),
            height:$(document).height(),
            position:"absolute",
            opacity:0.3,
            background:"white",
            zIndex:9999,
            cursor:"not-allowed"
        }).appendTo("body");

        $(document).on("keydown",function(e){
            if(e.keyCode === 8){
                return false;
            }
        });

        $("[action='submit']").addClass("disabled").mousedown(function(){
            return false;
        }).css({
            color:"white",
            background:"#7D7D7D",
            borderColor:"transparent"
        }).get(0).onclick = null;
    }

function initZb(){
	$("#zb").hide();
	$("#jobType").hide();
	var myPosition = $("#position").find("option:selected").text()
	if( myPosition=="美容师" || myPosition =="顾问"){
		$("#zb").show();
	}
}
</script>
<script type="text/javascript">
var constellationArr = [ "水瓶座", "双鱼座", "白羊座", "金牛座", "双子座", "巨蟹座", "狮子座", "处女座", "天秤座", "天蝎座", "射手座", "魔羯座" ];
var constellationEdgeDay = [ 20, 19, 21, 21, 21, 22, 23, 23, 23, 23, 22, 22 ];
function autoParseConstellation(dateStr){
    var date = new Date(dateStr);
    var month = date.getMonth();
    var day = date.getDate();
    if (day < constellationEdgeDay[month]) {
        month = month - 1;
    }
    if (month >= 0) {
        return constellationArr[month];
    }
    //default to return 魔羯
    return constellationArr[11];
}

function checkUserName(){
	var isOk = false;

 	var userLoginId =$("#userLoginId").val();
 	var userLoginReg = /[^\u4E00-\u9FA0]+$/;
 	
 	if(userLoginId){
 		$("#userLoginId").siblings(".error").text("");
 		$.ajax({
	       url: '<@ofbizUrl>checkUserLoginId</@ofbizUrl>',
	       data: {userLoginId:userLoginId},
	       type: "POST",
	       async:false,
	       success: function(data) {
	             if(data.isExist =="N"){
	                isOk=true;
	             }else{
	                $("#userLoginId").siblings(".error").text("该用户名已被注册,请更换!");		
	                $("#userLoginId").siblings(".error").show();		
					$("#userLoginId").focus();
	             }
	       }
	   });
 	}
   return isOk;
}
function checkCardId(){
	var isOk = false;
 	var cardId =$("#cardId").val();
 	var oldCardId =$("#oldCardId").val();
 	
 	if(cardId){
 		if(cardId == oldCardId){
 			isOk=true;
 		}
 		$("#cardId").siblings(".error").text("");
 		$.ajax({
	       url: '<@ofbizUrl>checkCardId</@ofbizUrl>',
	       data: {cardId:cardId},
	       type: "POST",
	       async:false,
	       success: function(data) {
	             if(data.isExist =="N"){
	                isOk=true;
	             }else{
	                $("#cardId").siblings(".error").text("该计步器号已存在,请更换!");		
	                $("#cardId").siblings(".error").show();		
					$("#cardId").focus();
	             }
	       }
	   });
 	}
   return isOk;
}


function checkAndSubmit(){
		<#if !customer?has_content>
	    	if(!checkUserName()){
	    		return false;
	    	}
		</#if>
    	if(!checkCardId()){
    		return false;
    	}
        disabledSubmitButton();
    	document.MyForm.submit();

}

 $(function(){
    $(".employee_info .selectTransferPut").focus(function(){
      $(this).siblings("ul").slideDown();
      $("#isMyself").removeAttr("checked");
    }).click(function(){
      return false;
    });


    $(document).click(function(){
      $(".transferAccountsSelect").slideUp();
    });

    $(".transferAccountsSelect").click(function(){
      return false;
    });
  });

 $(function(){
      $("#transferAccountsSelect").on('click','li',function(){
        $("#companyName").val($(this).attr("title"));
        $(".transferAccountsSelect").hide();
      });
  });
</script>
<script>
  /*
   * 公司下拉列表
  */
  $(function(){
    var transferAccountsSelect     = $("#transferAccountsSelect");
    var transferAccountsSelectData = transferAccountsSelect.clone();

    $("#companyName").on("keyup",function(){
      var value = $.trim($(this).val());

      //----如果值为空,那么写入全部
      if(value.length === 0){
        transferAccountsSelect.html(transferAccountsSelectData.html());
      }
      //----如果值不为空
      else{
        //清空html
        transferAccountsSelect.html("");

        //枚举,找到匹配的li并且克隆之后追加到列表中
        $("li > div.transfer_name",transferAccountsSelectData).each(function(){
          var name = $(this).text();
          var tel = $(this).siblings('div.transfer_tel').text();
          if(name.indexOf(value) !== -1 || tel.indexOf(value) !== -1){
            transferAccountsSelect.append($(this).parent().clone());
          }
        });
      }
    });
  });
</script>
