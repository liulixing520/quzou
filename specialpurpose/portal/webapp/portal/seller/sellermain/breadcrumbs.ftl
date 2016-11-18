<ul class="breadcrumb">
    <li>
        <i class="ace-icon fa fa-home home-icon"></i>
        <a href="<@ofbizUrl>sellerIndex</@ofbizUrl>">首页</a>
    </li>
    <!--
    	<li class="active">仪表盘</li>
    -->
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