<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">
<#assign actionUrlStr="addPagemanage">
<#if pageSetting?has_content>
	<#assign actionUrlStr="editPagemanage">
</#if>

<div class="page-content">
    <div class="page-content-area">
        
        <div class="row">
            <div class="col-xs-12">
                <form class="form-horizontal" role="form" id="EditStoreCatagory" name="EditStoreCatagory"
                      method="post"
                      action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>"
                      onsubmit="javascript:submitFormDisableSubmits(this)" novalidate="novalidate">
                    <input type="hidden" name="pageSettingId" id="pageSettingId" value="${(PageSetting.pageSettingId)!}"/>
                    <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">广告级别</label>

                        <div class="col-sm-4">
                        <script type="text/javascript">
                        
					    function searchWhere(obj){
					        geoId=jQuery("#"+obj+"  option:selected").val();
                              $("#gradingType").val(geoId);				
						}
					    </script>
                    <#if PageSetting?has_content>
                      <select id="gradingType" name="gradingType" onchange="searchWhere(this.id);" >
                      <#if PageSetting.gradingType = '1'>
			                          <option value="1" selected>首页左</option>
			                          <option value="2" >首页右</option>
			          <#else>
			                          <option value="1" >首页左</option>
			                          <option value="2" selected>首页右</option>
                      </#if>
			          </select>
			        <#else>
                    <select id="gradingType" name="gradingType" onchange = "searchWhere(this.id);">
                          <option selected>选择</option>
                          <option value="1" >首页左</option>
                          <option value="2" >首页右</option>
                    </select>
                    </#if>
                        </div>
                    </div>
                    <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">广告中文名称</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="advertisingZName" name="advertisingZName" placeholder="" value="${(PageSetting.advertisingZName)!}">
                        </div>
                    </div>
                    <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">广告英文名称</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="advertisingYName" name="advertisingYName" placeholder="" value="${(PageSetting.advertisingYName)!}">
                        </div>
                    </div>
                    <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">广告俄文名称</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="advertisingEName" name="advertisingEName" placeholder="" value="${(PageSetting.advertisingEName)!}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">链接地址</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="pageJumpImage" name="pageJumpImage" placeholder="" value="${(PageSetting.pageJumpImage)!}">
                        </div>
                    </div>
                    
                               

                    <div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                        &nbsp; &nbsp; &nbsp;
                        <a href="<@ofbizUrl>mng_PageSetting</@ofbizUrl>"
                        <button class="btn" type="button">取消</button>
                        </a>
                    </div>
                </form>
            </div>
        </div>
  </div>  
    <!-- /.page-content-area -->
</div>

<#if pageSettingId?has_content>
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <h3>${uiLabelMap.ProductCategoryUploadImage}</h3>
        </div>
        <div class="screenlet-body">
            <form method="post" enctype="multipart/form-data"
                  action="<@ofbizUrl>uploadMessageImage?pageSettingId=${pageSettingId?if_exists}&amp;upload_file_type=pageLogoImage</@ofbizUrl>"
                  name="imageUploadForm">
                <input type="file" size="50" name="pageLogoImage" style="float:left"/>
                <input type="submit" class="smallSubmit" value="${uiLabelMap.ProductUploadImage}" style="float:left"/>
            </form>
        </div>
        <br/><br/>
        <td width="20%" valign="top" class="label">
        ${uiLabelMap.ProductCategoryImageUrl}
        </td>
        <td>&nbsp;</td>
         <input type="text" name="pageLogoImage" value="${(pageSetting.pageLogoImage)?default('')}"size="60" maxlength="255"/>
         <#if (pageSetting.pageLogoImage)?exists>
            <br>
            <a href="<@ofbizContentUrl>${(pageSetting.pageLogoImage)?if_exists}</@ofbizContentUrl>"
               target="_blank"><img alt="Category Image" width="200px" height="200px"
                                    src="<@ofbizContentUrl>${(pageSetting.pageLogoImage)?if_exists}</@ofbizContentUrl>"
                                    class="cssImgSmall"/></a>
        </#if>
    </div>
</#if>





