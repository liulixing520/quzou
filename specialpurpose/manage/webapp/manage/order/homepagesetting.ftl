
<#--<#assign FCK=JspTaglibs["/WEB-INF/tags/FCKeditor.tld"]>-->
<#assign baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()/>
<script src="/manage/manager/images/uploadify/scripts/swfobject.js" type="text/javascript"></script>
<script src="/manage/manager/images/uploadify/scripts/jquery.uploadify.v2.1.0.js" type="text/javascript"></script>
<script src="/manage/manager/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/manage/images/js/jquery.ui.dialog.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>

<link rel="stylesheet"  href="/manage/manager/images/uploadify/css/uploadify.css" type="text/css">
<link rel="stylesheet"  href="/manage/manager/images/product/syi20130506.css" type="text/css">
<link rel="stylesheet"  href="/manage/manager/images/product/weddingTemplate.css" type="text/css">
<link rel="stylesheet"  href="/manage/manager/images/product/codemirror.css" type="text/css">


<script type="text/javascript">
function submitFormDisableSubmits(form) {
    for (var i=0;i<form.length;i++) {
        var formel = form.elements[i];
        if (formel.type == "submit") {
            submitFormDisableButton(formel);
            var formName = form.name;
            var formelName = formel.name;
            var timeoutString = "submitFormEnableButtonByName('" + formName + "', '" + formelName + "')";
            var t = setTimeout(timeoutString, 1500);
        }
    }
}
 $(function(){ 
		$(".breadcrumb").append("<li class='active'>网站管理</li><li class='active'>首页管理</li><li class='active'>底部信息</li>")
	}); 
</script>

<script type="text/javascript">
  function getTagId(obj){
  for(var i = 1;i<=2;i++){
	if(i == obj){
	document.getElementById("active"+i).style.display="block"
	}else
	document.getElementById("dis"+i).style.display="none"
	}
  }
</script>
<body background="../../images/allbg.gif" topMargin="8" leftMargin="8">
<div class="page-content">
    <div class="page-content-area">
        <font>底部信息</font>
        <div class="page-header" style="height:60px;clear:both;">
                        <a style="float:right; margin-left:10px;font-size:14px; color:#f00; line-height:40px;" href="<@ofbizUrl>create_mng_HelpClassInfo</@ofbizUrl>"
                        <button class="" type="button" style="">
                           [新增]
                        </button>
                        </a>
        </div>

        <div class="row">
                    <div id="sample-table-2_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <table id="sample-table-2" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="sample-table-2_info" align="center">
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center; width:200px" >
                                    帮助分类
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="" style="text-align:center; width:200px">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            
                          <tbody>
						 	<#if HelpInformationList?has_content>
						        <#list HelpInformationList as hilist>
                                <tr class="odd">
                                     <#assign helpClassification = delegator.findOne("HelpClassification", {"helpClassId" : hilist.helpClassId}, true)>
                                     <td style="text-align:center;">${(helpClassification.classificationName)!}</td>
	                                 <td>    <div class="hidden-sm hidden-xs action-buttons" style="text-align:center;">
	                                     <a class="green" href="<@ofbizUrl>create_mng_HelpClassInfo</@ofbizUrl>?helpPageInfoId=${(hilist.helpPageInfoId)!}" title="编辑"> <i class="ace-icon fa fa-pencil bigger-130"></i> </a>
	                                     <a class="red" href="javascript:document.ListHelpClassdeleteLink_${(hilist.helpPageInfoId)!}.submit()" title="删除"> <i class="ace-icon fa fa-trash-o bigger-130"></i> </a> 
						                   <form onsubmit="javascript:submitFormDisableSubmits(this)" method="post" name="ListHelpClassdeleteLink_${(hilist.helpPageInfoId)!}" action="<@ofbizUrl>removeHelpInfo</@ofbizUrl>">
											<input name="helpPageInfoId" value="${(hilist.helpPageInfoId)!}" type="hidden">
												<input name="VIEW_INDEX_1" value="0" type="hidden">
												<input name="VIEW_SIZE_1" value="20" type="hidden">
										   </form>
	                                     </div></td>
                                </tr>
                                </#list>
                             </#if>	
                           </tbody>
                        </table>
                    </div>
                </div>
     </div>
   </div>     
</body>