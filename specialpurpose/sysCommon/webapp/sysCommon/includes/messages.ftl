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
<div id='errorDiv' style="display:none">11</div>
<script language='javascript'>
var errorStr="";
var successStr="";
var eventStr="";
function errorDialog(info){
	var thisDialog=$('#errorDiv').dialog({
		modal : true,
		autoOpen: false,
		open : function() {
			thisDialog.html(info);
		},buttons: {  
			"确定": function () {  thisDialog.dialog('close');},   
            "关闭": function () { thisDialog.dialog('close');} 
        },  
		close: function () { thisDialog.dialog( 'remove' ) ; },  
		width :  '300',
		height : '200',
		title : '提示'
	});
	thisDialog.dialog("open"); 
}
<#-- display the error messages -->
<#if (errorMessage?has_content || errorMessageList?has_content)>
  
    <#if errorMessage?has_content>
     	errorStr="${errorMessage}";
    </#if>
    <#if errorMessageList?has_content>
      <#list errorMessageList as errorMsg>
      	errorStr+="${errorMsg}";
      </#list>
    </#if>
   errorDialog(errorStr);  
</#if>

<#-- display the event messages -->
<#if (eventMessage?has_content || eventMessageList?has_content)>
    <#if eventMessage?has_content>
      eventStr="${eventMessage}";
    </#if>
    <#if eventMessageList?has_content>
      <#list eventMessageList as eventMsg>
        eventStr+="${eventMsg}";
      </#list>
    </#if>
    errorDialog(eventStr);  
</#if>
</script>
