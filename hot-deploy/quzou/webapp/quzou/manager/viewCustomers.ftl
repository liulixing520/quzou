<style>
	.tingyong td{
		background:#D3D3D3;
	}
</style>
<div class="main">
	<!--面包屑-->
	<div class="crumb">
    	<ul>
        	<li>
            	<a href="#">赛事名称：</a>
            </li>
            <li>
            	<a href="#">${(competition.cName)!}</a>
            </li>
        </ul>
    </div>

	<div class="clear"></div>
	<div class="wrap2 member_table table pb20">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="nursing">
	        <tr>
	            <th width="3%" class="td_checked"><input type="checkbox" class="checkAll" data-name="1"/></th>
	            <th width="15%">用户名</th>
	            <th width="15%">活动积分</th>
	            <th width="15%">个人积分</th>
	            <th width="36%">单位</th>
	            <th width="16%">电话</th>
	        </tr>
		<#if listIt?has_content>
			<#list listIt as item>
				<tr>
					<td><input type="checkbox" name="competitionId" value="${item.partyId!}" class="checkItem"  data-name="1"/></td>
					<td>${item.userLoginId!}</td>
					<td>${item.integral!}</td>
					<td>${item.integralTotal!}</td>
					<td>${item.companyName!}</td>
					<td>${item.telephone!}</td>
				</tr>
			</#list>
		</#if>
	    </table>

	    <div class="table_control">
	        <div class="t_c_inp">
	            <input type="checkbox" class="checkAll" id="checkAll" data-name="1">
	            <label for="checkAll">全选</label>
	        </div>
	    </div>

			<#assign url="viewCustomers?1=1"/>
			<#if parameters.cId?has_content>
				<#assign url=url+"&cId=${(parameters.cId)!}"/>
			</#if>
			<#assign url=url?replace("viewCustomers","")/>
			<#import "component://quzou/webapp/quzou/includes/htmlFtlMacroLibrary.ftl" as p>
					  <@p.showPage requestUrl1="viewCustomers"
					  requestUrl2=url
					  listSize=listSize viewSize=viewSize viewIndex=viewIndex isAuth=true/>
	</div>
</div>

