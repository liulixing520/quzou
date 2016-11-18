<div class="accountBalanceInfor">
	<table cellspacing="0" cellpadding="0" border="0" width="100%" class="table" style="margin-top:0px;">
		<tbody>
			<tr>
	            <th>团队</th>
	        </tr> 
	        <#if competiAndDeptViewList??>
	        	<#list competiAndDeptViewList as competiAndDept>
			        <tr>
			        	<td>${competiAndDept.deptName!}</td>
			        </tr>
	        	</#list>
	        </#if>
        </tbody>
	</table>
</div>

