<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">

<#assign actionUrlStr="createHelpClass">
<#if helpClassification?has_content>
	<#assign actionUrlStr="editorHelpClass">
</#if>
		<#if helpClassification?has_content>
      <#assign temp = "编辑帮助分类">  
        <#else>
      <#assign temp = "创建帮助分类">  
        </#if>
<script type="text/javascript">
 $(function(){ 
		$(".breadcrumb").append("<li class='active'>网站管理</li><li class='active'>首页管理</li><li class='active'>temp</li>  
")
	}); 
</script>
<div class="page-content">
    <div class="page-content-area">
        <div class="row">
            <div class="col-xs-12">
                <form class="form-horizontal" role="form" id="EditStoreCatagory" name="EditStoreCatagory"
                      method="post"
                      action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>"
                      onsubmit="javascript:submitFormDisableSubmits(this)" novalidate="novalidate">
                    <input type="hidden" name="helpClassId" id="helpClassId" value="${(helpClassification.helpClassId)!}"/>
                    
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">分类名称:</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="classificationName" name="classificationName" placeholder="" value="${(helpClassification.classificationName)!}">
                        </div>
                    </div>
                  
                    <div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                        &nbsp; &nbsp; &nbsp;
                        <a href="<@ofbizUrl>mng_helpclass</@ofbizUrl>"
                        <button class="btn" type="button">取消</button>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>


