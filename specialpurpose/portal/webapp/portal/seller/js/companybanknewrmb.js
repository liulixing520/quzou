
//置指定字段为修改状态
//function modifyRegInfo(strName, bmodify, bconfirm){
//	var strValue = "";
//	if(bmodify){
//		$("#span_" +　strName).hide();						
//		$("#span_e" +　strName).show();
//		$("#md_" +　strName).attr("checked", true);
//		$("#" +　strName).val($("#b_" +　strName).html()).focus();
//		
//		if(bconfirm){
//			//如果是需要校验的字段，清空确认字段内容
//			$("#tr_con_" + strName).show();
//			$("#con_" +　strName).val("");
//		}
//	}else{
//		$("#span_" +　strName).show();
//		$("#" +　strName).val($("#b_" +　strName).html());
//		$("#md_" +　strName).attr("checked", false);
//		$("#span_e" +　strName).hide();
//		if(bconfirm){
//			$("#tr_con_" + strName).hide();
//		}
//	}
//}
//人民币用户信息校验
var g_bSubmit = false;

$(document).ready(function(){
	$("#submitSpan").click(
		function(){
			if(checkReqModifyRAData()){
				$("#mdform").submit();
			}
		}
	);
});
$(function(){
	$("#mdrequestBg").css({ opacity: .7 });
    var extArray = [];
    extArray.push('jpg');
    extArray.push('jpeg');
    extArray.push('gif');
    for(var i=1; i<5; i++){
		initUplodfiy("other", "pic_file"+i, extArray,i);
	}
});
var uploadIndexArray = [];
function upLoadProductPic(imgIndex){
	//alert("upLoadProductPic"+imgIndex);
	if(imgIndex==null){
		uploadIndexArray = [];
		$.each($(".pic_files"),function(index,pic_file){
			if(($(pic_file).val()=="")&&($(pic_file).attr("needUpload")=="true")){
				uploadIndexArray.push(index+1);
				uploadIndexArray.sort();
				uploadIndexArray.reverse();
			}
		});
		imgIndex=uploadIndexArray.pop();
	}
	//alert(uploadIndexArray);
	//alert(imgIndex);
	//if( imgIndex >4)return;	
	
	var strInputId = "pic_file" + imgIndex	;
	$("#loadingImg"+imgIndex).css("display","block");
	jQuery("#" + strInputId).uploadifyUpload();
	//alert(4);
}
function initUplodfiy(fname, fid, extArray,imgIndex){
	var uuid = jQuery("#uuid").val();
    var fileExt = '*.' + extArray.join(';*.') + ';';
    var fileDesc = extArray.join(',');
    var queueID="custom-queue"+imgIndex;
	jQuery('#'+fid).uploadify({
		'uploader': '../assets/js/userset/uploadalbums.swf',
        'script': 'http://upload.dhgate.com/resourceServ',
        'cancelImg': 'http://image.dhgate.com/2008/web20/seller/uploadjs/cancel.png',
        'folder': 'uploaddify',
        'scriptAccess': 'always',
        'multi' : false,
	    //'simUploadLimit' : 1,
	    'auto' : true,
	    'sizeLimit'   : 200000,
	    'method': 'GET',
	    //'displayData' : 'speed',
	    'fileExt': fileExt,
        'fileDesc':fileDesc,
        'queueID':queueID,
        'displayData':'',
	    'removeCompleted' : false,
	    'scriptData' :{functionname:fname,isunique:'0',uuid:uuid},
	    'onSelect':function(event,ID,fileObj){
	    	$("#idcardpic" + imgIndex).val("");
	    	$("#idcardpic" + imgIndex).attr("needUpload","true");
	    	$("#custom-queue"+imgIndex).show();
	    	initSmallPicShow(imgIndex);
	    },
	    'onComplete'  : function(event, ID, fileObj, response, data) {
	      	var respObj = JSON.parse(response);
	      	//todo 判断非空返回
	      	$("#img"+imgIndex).attr("src","http://image.dhgate.com/"+respObj.c_url);
	      	$("#idcardpic" + imgIndex).val(respObj.c_url);
	      	$("#idcardpic" + imgIndex).attr("needUpload","false");
	      	$("#loadingImg"+imgIndex).css("display","none");
	      	//alert(uploadIndexArray);
			var nextImgIndex=uploadIndexArray.pop();
			//alert(nextImgIndex);
			if(nextImgIndex){
				upLoadProductPic(nextImgIndex);
			}
			$("#custom-queue"+imgIndex).hide();
			return false;
	    }
	});
}

function initSmallPicShow(imgIndex){
	$("#img"+imgIndex).attr("src","http://www.dhresource.com/dhs/mos/image/capital-account/space.png");
}

function evalData(data){
	var returnStr=decodeURIComponent(data);
	var returndata=eval('('+returnStr+')');
	return returndata;
}
//申请修改表单校验
function checkReqModifyRAData(){
	
	if($("#bankAccountId").val()==""){
		$("#mdreasonTip").html("系统错误,获取卡号失败");
		return false;
	}
	
	if($("#mdreason").val()==""){
		$("#mdreasonTip").html("请选择修改账户的原因");
		return false;
	}
	//3次密码输入错误，则需上传银行明细图片
	if($("#mdreason").val()=="04"){
		if($("#reqeustType").val()==2){
			$("#idcardpic3").val("");
		}else{
			if($("#idcardpic3").val()==''){
				$("#mdreasonTip").html("请上传银行账户明细图片");
				return false;
			}
		}
	}
	
	if($("#mdreason").val()=="00"){
//		if($("#mdremark").val()=="" || $("#mdremark").val()=="请输入您要修改的内容"){
//			$("#mdreasonTip").html("请填写修改账户的原因");
//			$("#mdremark").focus();
//			return false;
//		}else{
//			if($("#mdremark").val().length >50){
//				$("#mdreasonTip").html("修改账户的原因不能超过50个字！");
//				$("#mdremark").focus();
//				return false;
//			}
//		}
		$("#mdremark").val("");
	}else{
		$("#mdremark").val("");
	}
	//alert($("#idcardpic1").val());
	//alert($("#idcardpic2").val());
	if($("#idcardpic1").val()==''||$("#idcardpic2").val()==''){
		$("#mdreasonTip").html("请上传注册人身份证件正反面图片");
		return false;
	}
	//美元修改原因为2开户人，则需上传正反面图片
	if($("#reqeustType").val()==2){
		if($("#mdreason").val()=="01"||$("#mdreason").val()=="03"||$("#mdreason").val()=="05"){
			if($("#idcardpic3").val()==''||$("#idcardpic4").val()==''){
				$("#mdreasonTip").html("请上传修改后开户人身份证件正反面图片");
				return false;
			}
		}else{
			$("#idcardpic3").val("");
			$("#idcardpic4").val("");
		}
	}
	return true;
}

function showMdReasonMark(strValue,type){
	if(strValue=='00'){		
		//$("#mdremark").show().val("请输入您要修改的内容");
		//$("#mdremarkTip").html("您还能输入50个字符。");
	}else{
		//$("#mdremark").hide().val("");
		//$("#mdremarkTip").html("");
	}
	
	//如果美元银行账户，选择01开户人，则显示上传修改后开户人身份证件正反图片
	if(type == 2){
		if(strValue=='01'||strValue=='05'||strValue=='03'){	
			$("#idcardpicdiv").show();
		}else{
			$("#idcardpicdiv").hide();
		}
	}
}

//检查联系人姓名
function checkLinkName(val, elem) {
	//要求大于一个汉字
	if(val.length <= 1){
		return false;
	}
	
	var arr = ["先生","小姐","女士","哥哥","妹妹","姐姐","弟弟","经理","老师","秘书","总监"] ;
	for(var i = 0 ;i<arr.length;i++){
		if (val.indexOf(arr[i]) >= 0) { 
			return false;
		} 
	}
	return true;
}

//-->