<#if requestAttributes.errorMessageList?has_content><#assign errorMessageList=requestAttributes.errorMessageList></#if>
<#if requestAttributes.eventMessageList?has_content><#assign eventMessageList=requestAttributes.eventMessageList></#if>
<#if requestAttributes.serviceValidationException?exists><#assign serviceValidationException = requestAttributes.serviceValidationException></#if>
<#if requestAttributes.uiLabelMap?has_content><#assign uiLabelMap = requestAttributes.uiLabelMap></#if>

<#if !errorMessage?has_content>
  <#assign errorMessage = requestAttributes._ERROR_MESSAGE_?if_exists>
</#if>
<#if !errorMessageList?has_content>
  <#assign errorMessageList = requestAttributes._ERROR_MESSAGE_LIST_?if_exists>
</#if>
<#if !eventMessage?has_content>
  <#assign eventMessage = requestAttributes._EVENT_MESSAGE_?if_exists>
</#if>
<#if !eventMessageList?has_content>
  <#assign eventMessageList = requestAttributes._EVENT_MESSAGE_LIST_?if_exists>
</#if>


<#if (errorMessage?has_content || errorMessageList?has_content) ||  (eventMessage?has_content || eventMessageList?has_content)>
<script type="text/javascript">
    $(function(){
        var ht='<div class="xiaohaoDialog" style="min-height:150px;"> \
                    <div class="xiaohaoDialog_title"><a class="ri" href="javascript:"><img id="cm_closeMsg_cancel" src="/ofcupload/images/images/Images/close_icon.gif"></a>提示</div> \
                        <div class="centerContent"> \
                            <div class="sureConsume">'+
                                <#if eventMessage?has_content>
                                    "<p>${eventMessage}</p>"
                                </#if>
                                <#if eventMessageList?has_content>
                                  <#list eventMessageList as eventMsg>
                                    "<p>${eventMsg}</p>"
                                  </#list>
                                </#if>
                                <#if errorMessage?has_content>
                                     "<p>${errorMessage}</p>"
                                </#if>
                                <#if errorMessageList?has_content>
                                  <#list errorMessageList as errorMsg>
                                    "<p>${errorMsg}</p>"
                                  </#list>
                                </#if>
                            +'</div> \
                        </div> \
                        <div class="fr mt20"> \
                            <div class="com_btn com_btn_red fl mr20" style="border: 1px solid transparent"> \
                                <a class="close" href="javascript:void(0)">确定</a> \
                            </div> \
                        </div> \
                    </div>';
        var option = {
            html: ht,
            width: '410px'
        };
        $(this).cm_dialog(option);
    });
</script>
</#if>
