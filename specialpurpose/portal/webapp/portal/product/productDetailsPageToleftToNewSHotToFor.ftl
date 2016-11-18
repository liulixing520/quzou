

<#if productIds?has_content>            
 <#assign productIndex = 0> 
			<#list productIds as productId>
			     <#if (productIndex <5)>
					${setRequestAttribute("optProductId", productId)}
					${screens.render(showproductNewsScreen)}
					${setRequestAttribute("optProductId", "")}
					
				 </#if>
			   <#assign productIndex = productIndex + 1>
			</#list>
			           
	
</#if> 



