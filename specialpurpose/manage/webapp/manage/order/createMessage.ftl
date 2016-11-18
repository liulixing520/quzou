<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">
<#assign actionUrlStr="addMessage">
<#if MessageSet?has_content>
	<#assign actionUrlStr="editMessage">
</#if>

<div class="page-content">
    <div class="page-content-area">
        <div class="page-header">
        <#if MessageSet?has_content>
        <h1>维护公告</h1></div>
        <#else>
        <h1>创建公告</h1></div>
        </#if>
        <div class="row">
            <div class="col-xs-12">
                <form class="form-horizontal" role="form" id="EditStoreCatagory" name="EditStoreCatagory"
                      method="post"
                      action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>"
                      onsubmit="javascript:submitFormDisableSubmits(this)" novalidate="novalidate">
                    <input type="hidden" name="messageId" id="messageId" value="${(MessageSet.messageId)!}"/>
                    
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">公告标题</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="messageTitle" name="messageTitle" placeholder="" value="${(MessageSet.messageTitle)!}">
                        </div>
                        <#--<font color="red" style="padding-top:7px; float:left;">注:首页=1、二级页=2</font>-->
                    </div>
                  
                   <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">公告内容</label>

                        <div class="col-sm-4">
                            <!--<input class="form-control" type="textarea" id="messageContent" name="messageContent" placeholder="" value="${(MessageSet.messageContent)!}">-->
                            <textarea class="form-control" style="width:417px; height:170px;" id="messageContent" name="messageContent" placeholder="">${(MessageSet.messageContent)!}</textarea>
                        </div>
                    </div>
                   
                   <#--  <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">生效时间</label>

                        <div class="col-sm-4">
                           <span class="view-calendar">
                <input id="startTime" title="格式: yyyy-MM-dd HH:mm:ss" name="startTime" maxLength="30" size="25" type="text" value="${(MessageSet.startTime)!}">
                <script type="text/javascript">
                                 jQuery(function () {
            // 时间设置
            jQuery('#startTime').datetimepicker({
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
                    </div>-->
                    <div class="space-4"></div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">失效时间</label>

                        <div class="col-sm-4">
                           <span class="view-calendar">
                <input id="failureTime" title="格式: yyyy-MM-dd HH:mm:ss" name="failureTime" maxLength="30" size="25" type="text" value="${(MessageSet.failureTime)!}">
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
                        <a href="<@ofbizUrl>mng_announcementSetting</@ofbizUrl>"
                        <button class="btn" type="button">取消</button>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>


