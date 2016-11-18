	
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
		$(".breadcrumb").append("<li class='active'>网站管理</li><li class='active'>首页面设置</li>")
	}); 
</script>
<body background="../../images/allbg.gif" topMargin="8" leftMargin="8">
<div class="page-content">
    <div class="page-content-area">
        <div class="page-header" style="height:60px;clear:both;">
            <h1 style="float:left; padding-top:8px;">
                广告管理
            </h1>
                        <a style="float:left; margin-left:10px;font-size:14px; color:#f00; line-height:40px;" href="<@ofbizUrl>create_mng_Pages</@ofbizUrl>"
                        <button class="" type="button" style="">
                           [新增]
                        </button>
                        </a>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <form class="form-horizontal" role="form" method="post" action="<@ofbizUrl>mng_PageSetting</@ofbizUrl>">
                    <div style="float:left; width:150px; padding-top:5px;"><label style="padding-right:10px;">广告级别</label>
                    <#--<input   type="text" id="gradingType" style="width:60px;padding-top:5px;" name="gradingType" placeholder="" value="${(gradingType)!}">-->
                   
                    <select id="gradingType" name="gradingType">
                          <option value="0" selected>请选择</option>
                          <option value="1" >首页左</option>
                          <option value="2" >首页右</option>
                    </select>
                    </div>
                    <div class="form-group" style="float:left;">
                        <label class="col-sm-2 control-label no-padding-right" style="width:80px; padding-top:10px;">关键字</label>

                        <div class="col-sm-9" style="width:400px;">
                            <input class="col-xs-10 col-sm-5" type="text" id="advertisingName" style="width:250px; margin-top:5px;" name="advertisingName" placeholder="输入广告名称进行查询……" value="${(advertisingName)!}">
                             &nbsp; &nbsp; &nbsp;<input class="btn" type="submit" value=" 查询">
                        </div>
                    </div>

                </form>

               <!-- <h3 class="header smaller lighter blue">广告列表
                </h3>-->

                <!-- <div class="table-responsive"> -->
                <!-- <div class="dataTables_borderWrap"> -->
                <div>
                    <div id="sample-table-2_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <table id="sample-table-2"
                               class="table-bordered"
                               role="grid" aria-describedby="sample-table-2_info" align="center">
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    广告级别
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    广告名称
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    链接地址
                                </th>
                                                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    图片文件
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="" style="text-align:center;">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            
                            <tbody>
						 		<#if PageSetterList?has_content>
						        <#list PageSetterList as pages>
                                <tr class="odd">
                                   <td style="text-align:center;">
                                   <#if (pages.gradingType)?has_content>
                                       <#if (pages.gradingType) = '1'> 首页左   <#else> 首页右 </#if>
                                   </#if></td>
                                    <td style="text-align:center;">${(pages.advertisingName)!}</td>
                                     <td style="text-align:center;">
                                     <#if pages.pageJumpImage?length gt 80>${(pages.pageJumpImage[0..80])?if_exists}..<#else>${pages.pageJumpImage?if_exists}</#if>
                                     </td>
                                      <td style="text-align:center;">
                                        <#if (pages.pageLogoImage)?exists>
				                            <br>
				                            <a href="<@ofbizContentUrl>${(pages.pageLogoImage)?if_exists}</@ofbizContentUrl>"
				                               target="_blank"><img alt="Category Image" width="300px" height="100px" src="<@ofbizContentUrl>${(pages.pageLogoImage)?if_exists}</@ofbizContentUrl>" class="cssImgSmall"/></a>
				                        </#if>
                                     <td>
                                     <div class="hidden-sm hidden-xs action-buttons" style="text-align:center;">
                                   <!--   <a class="blue" href="#"> <i class="ace-icon fa fa-search-plus bigger-130"></i> </a> -->
                                     <a class="green" href="<@ofbizUrl>create_mng_Pages</@ofbizUrl>?pageSettingId=${(pages.pageSettingId)!}"> <i class="ace-icon fa fa-pencil bigger-130"></i> </a>
                                     <a class="red" href="javascript:document.ListProductStoreBranddeleteLink_${(pages.pageSettingId)!}.submit()"> <i class="ace-icon fa fa-trash-o bigger-130"></i> </a> 
                                     
                   <form onsubmit="javascript:submitFormDisableSubmits(this)" method="post" name="ListProductStoreBranddeleteLink_${(pages.pageSettingId)!}" action="<@ofbizUrl>removePagemanage</@ofbizUrl>">
					<input name="pageSettingId" value="${(pages.pageSettingId)!}" type="hidden">
						<input name="VIEW_INDEX_1" value="0" type="hidden">
						<input name="VIEW_SIZE_1" value="20" type="hidden">
				   </form>
                                     </div>
                                     
                                     
                                     
             </td>
              
              

              
                                </tr>
                                </#list>
        </#if>	
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>
</body>