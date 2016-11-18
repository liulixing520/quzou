	
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
</script>
<div class="page-content" style=" margin:15px; margin-top:5px;">
	<div style="padding-top:15px;">
		<form id='Magazine_gridTb_search' class='form-horizontal' action="<@ofbizUrl>mng_PageSetting</@ofbizUrl>">
							广告级别:
							<select id="gradingType" name="gradingType">
		                          <option value="0" selected>请选择</option>
		                          <option value="1" >首页左</option>
		                          <option value="2" >首页右</option>
		                    </select>
							关键字： <input class="" type="text" id="advertisingZName" style="" name="advertisingZName" placeholder="输入中文广告名称进行查询……" value="${(advertisingZName)!}">
					<input type="submit"  href="javascript:void(0);" class="btn btn-primary" name="Magazine_search" value="查询">
				</form>
	</div>			
    <div class="page-content-area">
        <div class="row">
            <div class="col-xs-12">
                        <table id="sample-table-2"
                               class="table table-bordered table-striped table-condensed">
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    广告级别
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    广告中文名称
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    广告英文名称
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    广告俄文名称
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
                                   <td style="text-align:center;vertical-align:inherit;">
                                   <#if (pages.gradingType)?has_content>
                                       <#if (pages.gradingType) = '1'> 首页左   <#else> 首页右 </#if>
                                   </#if></td>
                                    <td align="center" style="text-align:center;vertical-align:inherit;">
                                     <#if (pages.advertisingZName)!?length gt 15>${(pages.advertisingZName[0..15])?if_exists}..<#else>${pages.advertisingZName?if_exists}</#if>
                                    </td>
                                    <td align="center" style="text-align:center;vertical-align:inherit;">
                                     <#if (pages.advertisingYName)!?length gt 15>${(pages.advertisingYName[0..15])?if_exists}..<#else>${pages.advertisingYName?if_exists}</#if>
                                    </td>
                                    <td align="center" style="text-align:center;vertical-align:inherit;">
                                     <#if (pages.advertisingEName)!?length gt 15>${(pages.advertisingEName[0..15])?if_exists}..<#else>${pages.advertisingEName?if_exists}</#if>
                                    </td>
                                     <td style="text-align:center;vertical-align:inherit;">
                                     <#if (pages.pageJumpImage)!?length gt 80>${(pages.pageJumpImage[0..80])?if_exists}..<#else>${pages.pageJumpImage?if_exists}</#if>
                                     </td>
                                      <td style="text-align:center;vertical-align:inherit;">
                                        <#if (pages.pageLogoImage)?exists>
				                            <br>
				                            <a href="<@ofbizContentUrl>${(pages.pageLogoImage)?if_exists}</@ofbizContentUrl>"
				                               target="_blank"><img alt="Category Image" width="300px" height="100px" src="<@ofbizContentUrl>${(pages.pageLogoImage)?if_exists}</@ofbizContentUrl>" class="cssImgSmall"/></a>
				                        </#if>
                                     <td style="text-align:center;vertical-align:inherit;">
                                     <div class="hidden-sm hidden-xs action-buttons" style="text-align:center;vertical-align:inherit;">
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
    <!-- /.page-content-area -->
</div>
</body>