<#macro button id value disabled onclick class="operationbtn">
<#--if disabled=="N">disabled</#-->
<span class="operationbtn-left" ><input type="button" id="${id}" class="${class}" value="${value}" ${disabled} onclick=${onclick}></span>                 
</#macro>

<#macro simpleButton id value disabled class="operationbtn">
<span class="operationbtn-left" ><input type="button" id="${id}" class="${class}" value="${value}" ${disabled} ></span>                 
</#macro>


