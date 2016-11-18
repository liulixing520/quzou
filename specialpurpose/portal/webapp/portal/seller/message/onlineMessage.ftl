<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!--
	<link href="css/common20111215.css" rel="stylesheet" type="text/css" media="all">
	<link href="css/common20140922.css" rel="stylesheet" type="text/css" media="all">
	<link href="css/syi_pop.css" rel="stylesheet" type="text/css" media="all">
	-->
	<link href="../seller/css/seller_button.css" rel="stylesheet" type="text/css" media="all">
	<link href="../seller/css/syi_pop.css" rel="stylesheet" type="text/css" media="all">
	<link href="../seller/css/remind.css" rel="stylesheet" type="text/css" media="all">
	<link href="../seller/css/inbox20131128.css" rel="stylesheet" type="text/css" media="all">
	<link href="../seller/css/custom-service.css" rel="stylesheet" type="text/css" media="all">
	<body>
<div class="content">
						
												
					<div class="crumb">
									
																																	
															
				        		<a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">消息</a><span>&gt;</span><a href="/mydhgate/csmsg/leavemsg.do?dhpath=10005,52000,2701">客服留言</a><span>&gt;</span>在线留言
				
				            </div>
				
        <div class="layout clearfix">
            <div class="col-main">
                <div class="col-main-warp">
											<div id="right"><div id="right">
    <form name="LoginLeaveMsgActionForm" id="LoginLeaveMsgActionForm" onsubmit="return login_sub_button();" action="/mydhgate/csmsg/leavemsg.do?act=leavemsg" method="post" 360chrome_form_autofill="2">
                	<div class="page-topic clearfix">
						<h2>发起客服留言 </h2>
        			 </div>
                <div class="page-operate-tip clearfix" id="pageOperateTip">
    				<span class="leftcol-tip">温馨提示：</span>
                    <div class="rightcol-tip">
                    	<p>请尽量详细的描述您的问题，对于您提出的问题，我们将在一个工作日内给出回复。</p>
                    </div>
    			</div>
            <div class="custom-message-list clearfix">
                <div class="list-left">昵称：</div>
                <div class="list-right">
					<input name="nickname" disabled="disabled" class="onlyready" id="nickname" type="text" size="30" maxlength="20" value="sunvsoft">
				</div>
                <div class="list-line"></div>
             	<div class="list-left"><span class="color-f00">*</span>邮箱：</div>
                <div class="list-right"><input disabled="disabled" class="onlyready" type="text" size="30" maxlength="60" value="sr_meng@sunvsoft.com">
					<input name="issend" id="issend" type="checkbox" value=""> <label for="sendEmil">将客服反馈同时发送到此邮箱</label>
					<span class="error-remind" id="emailErr" style="display: none;">请正确填写邮箱</span>
				</div>
                <div class="list-line"></div>
                <div class="list-left"><span class="color-f00">*</span>问题标题：</div>
                <div class="list-right">
					<input name="subject" id="subject" onblur="return checksubject();" type="text" size="50" maxlength="50" value="">
					<span id="subDef">字数不得超过50个汉字</span>
						<span class="error-remind" id="subErr" style="display: none;">请正确填写问题标题</span>
				</div>
                <div class="list-line"></div>
                <div class="list-left"><span class="s-color3">*</span>问题分类：</div>
                <div class="list-right">
					<select name="type" id="typevalue" onchange="loginchecktype();">
						<option value="-2" selected="">&nbsp;&nbsp;-请选择问题分类-&nbsp;&nbsp;</option>
    					        					<option value="b391ef5032c4b9eae04010ac0b644f10" productno="0" orderno="1" islogin="1">平台,信用卡纠纷的证据提交</option>
        				        					<option value="b3922090b1052faee04010ac0b6460a8" productno="0" orderno="0" islogin="0">增值服务</option>
        				        					<option value="b392212beb1d89bfe04010ac0b6461e4" productno="0" orderno="0" islogin="0">敦煌工具</option>
        				        					<option value="EAC9F58197A65435E04010AC0C644433" productno="0" orderno="0" islogin="0">注册认证</option>
        				        					<option value="EACA8DBBAE8750B5E04010AC0C643712" productno="0" orderno="0" islogin="0">资金账户</option>
        				        					<option value="EACAC9F4B42F2DB1E04010AC0C641525" productno="0" orderno="0" islogin="0">其他</option>
        				        					<option value="EACA0FCC7825A38FE04010AC0C647008" productno="0" orderno="0" islogin="0">后台功能</option>
        				        					<option value="EACA58940FD1D23EE04010AC0C6461E4" productno="0" orderno="0" islogin="0">订单交易</option>
        				        					<option value="EACA70E236901C7FE04010AC0C6406E8" productno="0" orderno="0" islogin="0">物流相关</option>
        				        					<option value="EACA9E39C90566D7E04010AC0C6453D7" productno="0" orderno="0" islogin="0">处罚管理</option>
        				        					<option value="EACA80DEE26F694EE04010AC0C642345" productno="0" orderno="0" islogin="0">交易纠纷</option>
        				        					<option value="EACA413FF1CFFFBBE04010AC0C643BFA" productno="0" orderno="0" islogin="0">产品相关.</option>
        				        					<option value="EACAC4C10FF0EA10E04010AC0C640EA9" productno="0" orderno="0" islogin="0">活动与公告</option>
        				        					<option value="EACAC733058C104FE04010AC0C641196" productno="0" orderno="0" islogin="0">技术问题</option>
        				        					<option value="EACA509E406A04CDE04010AC0C645598" productno="0" orderno="0" islogin="0">推广营销</option>
        									</select>
					<span class="operation-remind" id="typetip">请填写问题分类</span>
					<span class="error-remind" id="typeErr" style="display: none;"></span>
					<span class="error-remind" id="loginErr" style="display: none;"></span>
				</div>
				<span id="showRfxno" style="display: none;">
                    <div class="list-line"></div>
                    <div class="list-left"><span class="color-f00">*</span>订单号：</div>
                    <div class="list-right">
    					<input name="rfxno" id="rfxno" onblur="return checkrfxno();" type="text" maxlength="12" value="">
						<span id="rfxnoDef">请您输入订单号，您的问题会更快解决！</span>
    					<span class="error-remind" id="rfxnoErr" style="display: none;">请正确输入订单号</span>
    				</div>
                </span>
				<span id="showItemcode" style="display: none;">
                    <div class="list-line"></div>
                    <div class="list-left"><span class="s-color3">*</span>产品编号：</div>
                    <div class="list-right">
    					<input name="itemcode" class="ly-input1" id="itemcode" onblur="return checkitemcode();" type="text" maxlength="10" value="">
						<span id="itemcodeDef">请您输入产品编号，您的问题会更快解决！</span>
    					<span class="error-remind" id="itemcodeErr" style="display: none;">请正确输入产品号</span>
    				</div>
                </span>
                <div class="list-line"></div>
                <div class="list-left"><span class="color-f00">*</span>问题描述：</div>
                <div class="list-right">
					<textarea name="content" class="question-describe" id="contentinfo" onkeyup="checkMaxInput()" onblur="return checkmessage();"></textarea>
					<span class="error-remind" id="contentErr" style="display: none;">请正确填写问题描述</span>
					<div>您最多录入<strong class="prompt-letter" id="red">0</strong>/1000个汉字</div>
				</div>
                <div class="list-line"></div>
                <div class="list-left">附件：</div>
                <div class="list-right">
					 <input id="authorizationinput" onclick="popuUpload()" type="button" value="上传附件">
					<span class="color-999" style="color: rgb(153, 153, 153);">您最多可以上传4个附件  格式：JPG/GIF/RAR/PDF/DOC/DOCX/TXT  附件大小：1000K</span>
				</div>
				<div id="uploadDiv"></div>
    			                <div class="list-line"></div>
                <div class="list-left">&nbsp;</div>
                <div class="list-right">
					 <div class="custom-message-operate">
						<button class="send-button" id="butt1" type="submit"></button>
						<button class="send-button" id="butt4" style="display: none;" type="submit"></button>
						<a class="greybutton2" id="refresh" onclick="loginrefrButton();" href="javascript:void(0)"><span>重置</span></a>
					 </div>
				</div>   
        </div>
        <input name="act" id="act" type="hidden" value="">	
    	<input name="fileStr" id="fileStr" type="hidden" value="">
    	<input name="filesize" id="filesize" type="hidden" value="0">
    	<input id="showverify" type="hidden" value="false">
    	<input name="nickname" id="nickname" type="hidden" value="sunvsoft">
    	<input name="email" id="email" type="hidden" value="sr_meng@sunvsoft.com">
    </form>
	</div>
    	
	<!--图片上传弹出窗口开始-->
    <script src="/js/csmsg/csmsgupload.js" type="text/javascript"></script>
	<link href="http://image.dhgate.com/2008/web20/seller/uploadjs/uploadify.css?ver=20101207" rel="stylesheet" type="text/css">
    <script src="http://image.dhgate.com/2008/web20/seller/uploadjs/swfobject.js?ver=20101207" type="text/javascript"></script>
	<script src="http://image.dhgate.com/2008/web20/seller/uploadjs/jquery.uploadify.v2.1.0.js?ver=20101218" type="text/javascript"></script>
    <link href="http://image.dhgate.com/2008/web20/seller/css/seller_button.css" rel="stylesheet" type="text/css">
    <link href="http://image.dhgate.com/2008/web20/seller/css/general_popup_box.css" rel="stylesheet" type="text/css">
	<style type="text/css">
		#fileuploadUploader{
        	background:url(http://www.dhresource.com/dhs/mos/image/album/upload.gif) no-repeat 0 0;
        	/*background:url(http://image.dhgate.com/uploadjs/upload.gif) no-repeat 0 0;*/
        	background-position:center;  
        	border:0; 
        	margin:0; 
        	padding:0; 
        	vertical-align:top;
        	width: 125px;
        	height: 30px;
    	}
		#fileQueue{margin-bottom:10px;}
		#fileupload{float:left;width:90px;}
		#wangliguang{overflow:hidden; height:100%;; clear:both;}
		#upload_1 input{background:url(http://image.dhgate.com/uploadjs/btn_cancel.gif) no-repeat 0 0; width:90px; height:30px; border:0; margin:0; padding:0; vertical-align:top;}
		.popup iframe{position:absolute; z-index:-1; top:0; left:-3px; width:410px; height:300px; border:0; opacity:0; filter:alpha(opacity=0);}
    </style>

<div class="popup" id="popupid" style="display: none;">
	<div class="tc_title">
        <dl>
          <dt>上传文件</dt>
          <dd><a onclick="javascript:closeframe();" href="javascript:void(0);"><img alt="关闭" src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif"></a></dd>
        </dl>
	</div>
	<div class="tc_main" id="wangliguang"> 
		<div class="tc_content" id="vmid">
			<div class="box2">
				<div id="fileQueue"></div>  
								<input name="fileupload" id="fileupload" style="width: 120px;" type="file">
				
				<span id="upload_1"> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="button_clear" onclick="javascript:closeframe();" type="button" value="关闭">     			</span>
				<p class="uploadnotice" id="p_allcomplete" style="padding: 8px 0px 8px 33px; color: red; display: none;"></p>
				<!-- 入口参数   -->
				<input name="functionname" id="functionname" type="hidden" value="csmg">  											<!--功能名   	不可以为空-->
				<input name="imagebannername" id="imagebannername" type="hidden" value="sunvsoft">	<!--水印名  现在是用户名-->
				<input name="supplierid" id="supplierid" type="hidden" value="ff808081482fd3fd01485e24266e5056">
				<!--图片上传弹出窗口结束-->
			</div>
		</div>
	</div>
	<iframe></iframe>
</div>


<link href="http://image.dhgate.com/b/manage/css/basic.css" rel="stylesheet" type="text/css" media="screen">
<!-- IE 6 hacks -->
<!--[if lt IE 7]>
<link type="text/css" href="http://image.dhgate.com/b/manage/css/basic_ie.css" rel="stylesheet" media="screen" />
<![endif]-->
    <script src="http://image.dhgate.com/b/manage/js/jquery.simplemodal2.js" type="text/javascript"></script>
	<script src="http://image.dhgate.com/b/manage/js/frame_buyer.js" type="text/javascript"></script>
  <style type="text/css">
	<!--
	#modalContainer{height:auto;width:auto;left:30%;top:10%}ss
	-->	
  </style>
  <link href="http://image.dhgate.com/b/manage/css/syi_pop.css" rel="stylesheet" type="text/css">
  <div id="popcon"></div>
		
	    <script type="text/javascript">
<!--//	
	function showImg(response){
	  	if(response != ""){	 
			var s_value=window.eval("("+response+")");
			if(s_value.result=='1' || s_value.result=='2'){
				var aloneFileInfo = s_value.l_imgmd5 + "|" + s_value.l_imgurl + "|" + s_value.l_localfilename;
				jQuery("#p_allcomplete").html('上传成功!').show();
				addFile(s_value.l_imgmd5, aloneFileInfo);
			}
		}	
  	}
  
  	function isUpload(){
  		var filesize = $("#filesize").val();
		if(filesize>=4) {
			return false;
		}else{
  			return true;
		}
  	}
  	
	/**
 * 验证是不是还可以上传新的图片
 * */
function validateOnSelect(event, ID, fileObj){
	if(fileObj.size > 1020000){
		jQuery("#p_allcomplete").html('附件超过1000K，请重新上传!').show();
		return false;
	}	
	if(fileObj.size ==0){
		jQuery("#p_allcomplete").html('附件不能为空，请重新上传!').show();
		return false;
	}	
	if((fileObj.type).toLowerCase() != ".jpg"
	     && (fileObj.type).toLowerCase() != ".gif"
			&& (fileObj.type).toLowerCase() != ".pdf" 
				&& (fileObj.type).toLowerCase() != ".rar"
					&& (fileObj.type).toLowerCase() != ".doc" 
						&& (fileObj.type).toLowerCase() != ".docx"
							&& (fileObj.type).toLowerCase() != ".txt"){
																						
		jQuery("#p_allcomplete").html('附件格式不正确!').show();
		return false;
	}
	var bool=isUpload();
	if(!bool){
		$("#p_allcomplete").html('上传附件数量已超过4个!').show();
		return false;
	}
	return true;
}

	//添加已经上传的文件
	function addFile(md5, aloneFileInfo){
		var fileStrNew = "";
		var fileStr = $("#fileStr").val();
		if(fileStr != null && fileStr != ""){
			//是否可以添加
			var isAdd = true;
			var arr = fileStr.split("||");
			for(var i = 0; i < arr.length; i ++){
				var childArr = arr[i].split("|");
				if(md5==childArr[0]){
					isAdd = false;
				//	alert("This file has been uploaded.");
					jQuery("#p_allcomplete").html("附件重复上传!").show();
				//	closeframe();
						
				}
			}
			if(isAdd){
				fileStrNew = fileStr + "||" + aloneFileInfo;
			}else{
				fileStrNew = fileStr;
			}
		}else{
			fileStrNew = aloneFileInfo;
		}
		$("#fileStr").val(fileStrNew);
		$("#filesize").val(getUploadedFileSize());
		showUploadedFile();
		
	}
	
	function deleteFile(md5){
		var fileStrNew = "";
		var fileStr = $("#fileStr").val();
		var arr = fileStr.split("||");
		for(var i = 0; i < arr.length; i ++){
			var childArr = arr[i].split("|");
			if(md5!=childArr[0]){
				if(fileStrNew == null || fileStrNew == ""){
					fileStrNew = arr[i];
				}else{
					fileStrNew += "||" + arr[i];
				}
			}
		}
		$("#fileStr").val(fileStrNew);
		$("#filesize").val(getUploadedFileSize());
		showUploadedFile();
	}
	
	function getUploadedFileSize(){
		var kk = 0;
		var fileStr = $("#fileStr").val();
		if(fileStr != null && fileStr != ""){
			var arr = fileStr.split("||");
			filesize = arr.length;
		}
		return filesize;
	}
	
	$(document).ready(function(){
		showUploadedFile();
	});
//-->
</script>	<script type="text/javascript">	
	function showUploadedFile(){
		var uploadDivInfo = "";
		var fileStr = $("#fileStr").val();
		if(fileStr != null && fileStr != ""){
			var arr = fileStr.split("||");
			uploadDivInfo = "<div class='list-line'></div><div class='list-left'>&nbsp;</div><div class='list-right'>";
			for(var i = 0; i < arr.length; i ++){
				var childArr = arr[i].split("|");
				var nameinfo=decodeURIComponent(childArr[2],"UTF-8");
				var aloneFileInfo = "<p class='s-color2'><img src='http://image.dhgate.com/dhs/mob/img/mes/attachment.png' /> " + nameinfo;
				aloneFileInfo += " <a href='javascript:void(0);' class='ly-input5' onclick=\"deleteFile('" + childArr[0] + "');return false;\">删除</a></p>";
				uploadDivInfo += aloneFileInfo; 
			}
			uploadDivInfo += "</div>";
		}
		$("#uploadDiv").html(uploadDivInfo);
		var filesize = $("#filesize").val();
		if(filesize >= 4){
			$("#authorizationinput").hide();
		}else{
			$("#authorizationinput").show();
		}
	}
</script></div>
									</div>
            </div>
	<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#messageLeft")}
            
		</div>
    </div>
</body>
</head>
</html>