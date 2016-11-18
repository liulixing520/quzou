<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">
<#assign actionUrlStr="addBrandmanage">
<#if productStoreBrand?has_content>
	<#assign actionUrlStr="editBrandmanage">
</#if>

<div class="page-content">
    <div class="page-content-area">
        <div class="page-header"><h1>维护品牌</h1></div>
        <div class="row">
            <div class="col-xs-12">
                <form class="form-horizontal" role="form" id="EditStoreCatagory" name="EditStoreCatagory"
                      method="post"
                      action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>"
                      onsubmit="javascript:submitFormDisableSubmits(this)" novalidate="novalidate">
                    <input type="hidden" name="productStoreId" id="productStoreId" value="${(productStore.productStoreId)!}"/>
                    <input type="hidden" name="productStoreBrandId" id="productStoreBrandId" value="${(productStoreBrand.productStoreBrandId)!}"/>
                    
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">品牌名称</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="brandName" name="brandName" placeholder="" value="${(productStoreBrand.brandName)!}">
                        </div>
                    </div>
                    <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">品牌别名</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="brandAlias" name="brandAlias" placeholder="" value="${(productStoreBrand.brandAlias)!}">
                        </div>
                    </div>
                    <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">生效时间</label>

                        <div class="col-sm-4">
                           <span class="view-calendar">
                <input id="effectTime" title="格式: yyyy-MM-dd HH:mm:ss" name="effectTime" maxLength="30" size="25" type="text" value="${(productStoreBrand.effectTime)!}">
                <script type="text/javascript">
                                 jQuery(function () {
            // 时间设置
            jQuery('#effectTime').datetimepicker({
                     showSecond: false,
			          timeFormat: 'HH:mm:ss',
			          stepHour: 1,
			          stepMinute: 1,
			          stepSecond: 1,
			          showOn: 'button',
			          buttonImage: '',
			          buttonText: '',
			          buttonImageOnly: false,
			          dateFormat: 'yy-mm-dd'
            });

        });
      </script>
                <input value="Timestamp" type="hidden">
                </span>
                        </div>
                    </div>
                    <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">失效时间</label>

                        <div class="col-sm-4">
                           <span class="view-calendar">
                <input id="failureTime" title="格式: yyyy-MM-dd HH:mm:ss" name="failureTime" maxLength="30" size="25" type="text" value="${(productStoreBrand.failureTime)!}">
                <script type="text/javascript">
                                 jQuery(function () {
            // 时间设置
            jQuery('#failureTime').datetimepicker({
                     showSecond: true,
			          timeFormat: 'HH:mm:ss',
			          stepHour: 1,
			          stepMinute: 1,
			          stepSecond: 1,
			          showOn: 'button',
			          buttonImage: '',
			          buttonText: '',
			          buttonImageOnly: false,
			          dateFormat: 'yy-mm-dd'
            });

        });
      </script>
                <input value="Timestamp" type="hidden">
                </span>
                        </div>
                    </div>
                    <div class="space-4"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">品牌简介</label>
                        <div class="col-sm-9">
                            <textarea class="form-control limited" id="brandIntroduction" name="brandIntroduction" maxlength="50" style="margin: 0px -0.015625px 0px 0px; height: 52px; width: 450px;">${(productStoreBrand.brandName)!}</textarea>
                        </div>
                    </div>
                   <#-- <div class="space-4"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">上传LOGO照片</label>
                        <div class="col-sm-4">
	                            <input class="form-control" type="file" id="brandLogoImage" name="brandLogoImage" placeholder="" value="${(productStoreBrand.brandName)!}">
                        </div>
                    </div> -->
                    <div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                        &nbsp; &nbsp; &nbsp;
                        <a href="<@ofbizUrl>brandmanage</@ofbizUrl>"
                        <button class="btn" type="button">取消</button>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>


