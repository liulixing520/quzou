<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<script src="/portal/images/js/jquery.pagination.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">
<link rel="stylesheet" href="/portal/images/css/pagination.css" type="text/css"/>
<link rel="stylesheet" href="/portal/images/seller/css/skin5.css" type="text/css"/>
<style type="text/css">
.nav-tabs li{list-style:none;}
.nav-tabs li.current a{background:#b3d9ff; color:#000; font-weight:bold;}
</style>

   <div class="content my_account">
	<h2 class="title" style='font-size:20px'>收藏的店铺</h2>
     	<table class="points_table tab_content" cellspacing="0" width="100%">
   		<tbody> 
    		<tr class="header-row-2"> 
            	<td class="sort-order"> 
            		<label class="position-relative">
              			<input type="checkbox" class="ace" />
              			<span class="lbl"></span> 
              		</label>
            	</td>
            	<td>${uiLabelMap.ProductNameCf}</td>
            	<#-- <td>${uiLabelMap.CommonAmount}</td> -->
            	<td>${uiLabelMap.CommonDate}</td>
            	<#-- <td>${uiLabelMap.CommonStatus}</td> -->
            	<td>${uiLabelMap.OrderActions}</td> 
    		</tr>
    		
    	<#if shoppingListItems?has_content>
    	<#list shoppingListItems as shoppingListItem>
    	<#assign product = delegator.findOne("Product", Static["org.ofbiz.base.util.UtilMisc"].toMap("productId", shoppingListItem.productId), true) />  
        
        <tr>
            <td class="center"><label class="position-relative">
              <input type="checkbox" class="ace" />
              <span class="lbl"></span> </label>
            </td>
            <td><a class="blue" href="../products/p_${shoppingListItem.productId}">
               <#if product?has_content>
    	              ${product.internalName!}
               </#if> 
                                        
                <#-- <#if proList?has_content>
    	        <#list proList as pro>
    	           <#if (pro.productId==shoppingListItem.productId)>
    	              ${pro.internalName}
    	           </#if>
    	        </#list>
               </#if>  -->
                            
            </a></td>
           <#--  <td class="hidden-480">${(shoppingListItem.modifiedPrice)!}</td> -->
            <td>${(shoppingListItem.lastUpdatedStamp.toString())!}</td>
            <#-- <td>${uiLabelMap.HascollectionsCf}</td>     -->
            <td>
            	<div class="hidden-sm hidden-xs action-buttons"> 
            		<#-- <#if orderHeader.statusId?has_content>
            			<#if orderHeader.statusId == "ORDER_SENT">
            				|<a class="red" href="<@ofbizUrl>user_myorder?orderId=${orderHeader.orderId}&amp;statusId2=ORDER_COMPLETED&amp;statusId=${orderHeader.statusId}</@ofbizUrl>">${uiLabelMap.PortalUserHasReceipt}</i> </a>
            			</#if>
            			<#if orderHeader.statusId == "ORDER_CREATED">
            				|<a class="red" href="<@ofbizUrl>user_myorder?orderId=${orderHeader.orderId}&amp;statusId2=ORDER_CANCELLED&amp;statusId=${orderHeader.statusId}</@ofbizUrl>">${uiLabelMap.PortalUserQuXiao}</i> </a>
            			</#if>
            			<#if orderHeader.statusId == "ORDER_APPROVED">
            				|<a class="red" href="<@ofbizUrl>user_myorder?orderId=${orderHeader.orderId}&amp;statusId2=ORDER_CANCELLED&amp;statusId=${orderHeader.statusId}</@ofbizUrl>">${uiLabelMap.PortalUserQuXiao}</i> </a>
            			</#if>
            			<#if orderHeader.statusId == "ORDER_COMPLETED">
            				|<a class="red" href="#">${uiLabelMap.PortalUserDelete}</i> </a>
            			</#if>
            			<#if orderHeader.statusId == "ORDER_REJECTED">
            				|<a class="red" href="#">${uiLabelMap.PortalUserDelete}</i> </a>
            			</#if>
            			<#if orderHeader.statusId == "ORDER_CANCELLED">
            				|<a class="red" href="#">${uiLabelMap.PortalUserDelete}</i> </a>
            			</#if> 
            		</#if> -->
            		 <script type="text/javascript">
						 function oncheckDel(){
			                  window.location.href="<@ofbizUrl>delProductFromFavoriteList?productId=</@ofbizUrl>"+${shoppingListItem.productId};	                   
		                 }
	                </script> 
            		<a class="red" onclick="oncheckDel();" >${uiLabelMap.PortalUserDelete}</i> </a>
            	</div>
            </td>
          </tr>
        </#list>
        </#if>	 
   	   </tbody> 
  </table>
  </div>
</div>
  </div>
