<script type="text/javascript" src="/sysCommon/images/uploadify/scripts/swfobject.js"></script>
<script type="text/javascript" src="/sysCommon/images/uploadify/scripts/jquery.uploadify.v2.1.0.js"></script>
<link href="/sysCommon/images/uploadify/css/uploadify.css" type="text/css" rel="stylesheet"></link>
<script type="text/javascript">
	function initUploadifyBtn(){
		var fileInfo = '*.xls;*.xlsx';
		$("#uploadBtn").uploadify({
			'uploader':'/sysCommon/images/uploadify/scripts/uploadify.swf',
			'cancelImg':'/sysCommon/images/uploadify/cancel.png',
			'script':('<@ofbizUrl>uploadExcel?inType=${parameters.inType!}_${parameters.cId!}</@ofbizUrl>'),
			'folder': 'UploadFile',
			'queueID': 'fileQueue',
			'auto': true,
			'multi': false,
			'onSelect': function(file){
					$("#info").html("正在解析中...");
					$("#logId").show();
			},
			'onComplete': function(event,queueId,fileObj,response,data){
				var jsonObj = jQuery.parseJSON(response);
				var err = jsonObj.err;
				var log = jsonObj.log;
				if(err){
					err = ReplaceAll(err,"★","<br/>");
					$("#info").html(err);
				}else if(log){
					log = ReplaceAll(log,"★","<br/>");
					$("#info").html("重名人员名单<br/>"+log);
				}else{
					var filePath = jsonObj.filePath;
					if(filePath){
						$("#info").html("解析完成。");
					}
				}
				return false;
			},
	    	//'onUploadSuccess': 'myUplaodifyComplete',
			//'fileQueue': 'fileQueue',
			'fileExt': fileInfo,
			'fileDesc': fileInfo
		});
	}
	function saveEnterpriseQual(){
		$.ajax({
			url:'saveEnterpriseQual',
			type:'post',
			data:$("#editEnterpriseQual").serialize(),
			success:function(r){
				if(r.info||r._ERROR_MESSAGE_||r._ERROR_MESSAGE_LIST_){
					alert(r.info||r._ERROR_MESSAGE_||r._ERROR_MESSAGE_LIST_);
				}else{
					alert("保存成功");
					history.go(-1);
				}
			}
		});
	}
	$(function(){
		initUploadifyBtn();
	});
	
	function ReplaceAll(str,sptr,sptr1){
		while(str.indexOf(sptr)>=0){
			str = str.replace(sptr,sptr1);
		}
		return str;
	}
</script>

<div class="CommonDialogContent">
		<div class="CommonDialog_title"><a class="ri" href="javascript:"><img id="cm_closeMsg_cancel" src="../images/images/Images/close_icon.gif"></a>导入<#if parameters.inType == 'team'>[团队管理导入.xls]<#elseif parameters.inType == 'customer'>[计步器绑定模板.xls]<#elseif parameters.inType =='customerAndCompet'>[参赛团队导入模板.xls]</#if></div>
		<div class="filter_attr">
            <dl class="clear-fix item">
            	<dt>
                	<span>选择文件</span>
                </dt>
                <dd>
                	 <input id="uploadBtn" type="file"/>
                </dd>
           </dl>
           <dl class="clear-fix item">
            	<dt>
                	<span></span>
                </dt>
                <dd>
                	<div id="fileQueue"></div>
                </dd>
            </dl>
           <dl class="clear-fix item" id="logId" style="display:none;">
            	<dt>
                	<span>日志</span>
                </dt>
                <dd>
                	<span id="info" style="color:red;"></span>
                </dd>
            </dl>
        </div>
        <div class="fr mt20">
			  <div class="com_btn com_btn_red fl mr20" style="border: 1px solid transparent">
				<a class="close" href="javascript:void(0)" onclick="parent.location.reload();">确定</a>
			  </div>
	     </div>
</div>

