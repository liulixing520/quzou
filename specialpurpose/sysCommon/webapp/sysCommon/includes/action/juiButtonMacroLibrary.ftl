<#macro button id value disabled onclick class="operationbtn">
<#--if disabled=="N">disabled</#-->
<span class="operationbtn-left" ><input type="button" id="${id}" class="${class}" value="${value}" ${disabled} onclick=${onclick}></span>                 
</#macro>

<#macro simpleButton id value disabled class="operationbtn">
<span class="operationbtn-left" ><input type="button" id="${id}" class="${class}" value="${value}" ${disabled} ></span>                 
</#macro>
<#macro juiButton id value disabled class="button"  href="#" title="">
<#assign targets =target?split("@")>
<li><a class="${class}" href="${href}" target="${targets[0]}"  width="<#if (targets?size)==1>${targets[1]!}</#if>" height="<#if (targets?size==2)>${targets[2]!}</#if>"   title="${title}"  id="${id}"><span>${value}</span></a></li>
<li class="line">line</li>
</#macro>