// JavaScript Document
$(function(){
	$("label.radio").click(function(){
		$(this).addClass("cur").siblings("label").removeClass("cur");
		$(this).siblings("input[type=hidden]").val($(this).attr("title"));
	});
})
$.fn.extend({
	kingkongInput : function(){
		return $(this).each(function(index, element) {
            $(this).find("i").click(function(){
				$(this).hide().siblings("input").focus();
			});
			$(this).find("input").focus(function(){
				$(this).siblings("i").hide();
			});
			$(this).find("input").blur(function(){
				var val  =$(this).val();
				if(val==""){
					$(this).siblings("i").show();
				}
			});
        });	
	}
})
	//美容师、美容师顾问检索方法
	function jsjbr(t,b){
		var m="";
		if(b=="1"){//美容师检索
			m = $("#BEAUTICIAN").val();	
		}else{//顾问检索
			m = $("#CONSULTANT").val();
		}
		var a=$(t).parent().children("input").val();
		$(t).parent().parent().children("ul").children("li").each(function () {
			if(m.indexOf($(this).attr("id"))<0){
				if($(this).text().indexOf(a)>=0){
					$(this).css("display","block");
				}else if(a=="搜索名称"){
					$(this).css("display","block");
				}else{
					$(this).css("display","none");				
				}				
			}
		})
	}

//;$(function(){
//	function appendTenantid(){
//	     //附加上多租户的 tenantid
//	     var userloginid = $(".userloginid.need-tenantid");
//	     var tenantid= userloginid.data('tenantid');
//	     if(tenantid !=="" &&  tenantid !==null && tenantid !== undefined){
//	         tenantid = "@" + tenantid;
//	         userloginid.val(userloginid.val().replace(/(@.*$)|$/,tenantid));
//		 }
//	}
//	
//	$(".userloginid.need-tenantid").change(function(){
//		appendTenantid();
//	});
//	$(".userloginid.need-tenantid").blur(function(){
//		appendTenantid();
//	});
//});