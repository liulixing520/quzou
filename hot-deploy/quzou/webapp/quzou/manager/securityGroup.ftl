<div class="main">
	<!--筛选-->
	<div class="wrap2">
		<div class="filter_stock">
		<form name="securityGroupForm" action="securityGroup" method="get">
	     </form>
	    </div>
	</div>
	<!--筛选END-->
	<!--表单-->
	<div class="wrap2 member_table table pb20">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	            <th width="25%">安全组ID</th>
	            <th width="25%">用户名</th>
	            <th width="25%">操作</th>
	        </tr>
	        <#if listIt?has_content>
	        <tr>
	        <#list listIt as item>
	        	
	            <td>
	            	<#assign enums = delegator.findOne("Enumeration", {"enumId" :item.groupId }, true)?if_exists>
	            	${(enums.description)!}</td>
	            <td>${(item.userLoginId)!}</td>
	            <td><a href="delSecurityGroup?groupId=${(item.groupId)!}&userLoginId=${(item.userLoginId)!}" >删除</a></td>
	        </tr>
	        </#list>
	        </#if>
	    </table>

	    <!--
	    <div class="table_control">
	    	<div class="t_c_inp">
	        	<input type="checkbox" class="checkAll" id="checkAll" data-name="4">
	            <label for="checkAll">全选</label>
	        </div>
	    </div> -->
		<#assign url="securityGroup?1=1"/>
		<#if parameters.groupId?has_content>
			<#assign url=url+"&groupId=${(parameters.groupId)!}"/>
		</#if>
		<#assign url=url?replace("securityGroup","")/>
			<#import "component://quzou/webapp/quzou/includes/htmlFtlMacroLibrary.ftl" as p>
			  <@p.showPage requestUrl1="securityGroup"
			  requestUrl2=url
			  listSize=listSize viewSize=viewSize viewIndex=viewIndex isAuth=true/>
</div>
