<#if productLabtList?has_content>
	<#list productLabtList as productLab>
		<input type="checkbox" value="${productLab.labId?if_exists}" name="productLabIds" 
		<#if productLabMemberList?has_content>
			<#list productLabMemberList as productLabMember>
				<#if productLab.labId == productLabMember.labId>
					checked="checked"
				</#if>
  	  		</#list>
		</#if>
		>${productLab.labName?if_exists}&nbsp;&nbsp;
	</#list>
</#if>