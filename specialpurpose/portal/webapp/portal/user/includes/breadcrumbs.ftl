<ul class="breadcrumb">
    <li>
        <i class="ace-icon fa fa-home home-icon"></i>
        <a href="userMain">${uiLabelMap.PortalHome}</a>
    </li>
    
<#if Navigation1?has_content>
	<li class='active'>${(Navigation1)!}</li>
</#if>

<#if Navigation2?has_content>
		<li class='active'>${(Navigation2)!}</li>
</#if>
    <#if Navigation3?has_content>
		<li class='active'>${(Navigation3)!}</li>
</#if> 
<#if Navigation4?has_content>
		<li class='active'>${(Navigation4)!}</li>
</#if>
</ul>
