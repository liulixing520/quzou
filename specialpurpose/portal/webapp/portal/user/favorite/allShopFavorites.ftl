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
<script type="text/javascript">
	$(function(){
		startId=$("#orderStatus").val();
		$("li").remove(".current");
		if(startId==""){
			$("#li1").attr("class", "current"); 
		}else{
			$("#"+startId).attr("class", "current");
		}
		function pageselectCallback(page_id, jq) {
               //alert(page_id); 回调函数，进一步使用请参阅说明文档
               //TranUrl(page_id);
        }
        $("#Pagination").pagination("${listSize}", {
               callback: pageselectCallback,//PageCallback() 为翻页调用次函数。
               prev_text: " 上一页",
               next_text: "下一页 ",
               items_per_page: 10, //每页的数据个数
               num_display_entries: 4, //两侧首尾分页条目数
               current_page:"${viewIndex}",   //当前页码
               num_edge_entries: 2, //连续分页主体部分分页条目数
               link_to:"?page=__id__"
        });
         function  TranUrl(page_id){
         	var url=location.href;
         	//var startOrderDate=$("#start_order_time").val();
         	//var endOrderDate=$("#end_order_time").val();
         	var statusId=$("#orderStatus").val();
         	if(statusId.length>0){
         		url=url+"statusId="+statusId
         	}
			location.href=url+"&page="+page_id;
         }
	})

</script>
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
            	<td>${uiLabelMap.SerialnumberCf}</td>
            	<#-- <td><a class="sort-order" href="">${uiLabelMap.CommonAmount}</a></td> -->
            	<td>${uiLabelMap.CommonDate}</td>
            	<#-- <td><a class="sort-order" href="">${uiLabelMap.CommonStatus}</a></td> -->
            	<td>${uiLabelMap.OrderActions}</td> 
    		</tr>
    		
            <#if prssList?has_content>
    	       <#list prssList as prss>
    	    <tr>
            <td class="center"><label class="position-relative">
              <input type="checkbox" class="ace" />
              <span class="lbl"></span> </label>
            </td>
            	<#-- http://localhost:8080/portal/control/sellerhome?productStoreId=10001 -->
				 <script type="text/javascript">
					 function oncheckP(){
		                  window.location.href="<@ofbizUrl>../control/sellerhome?productStoreId=</@ofbizUrl>"+${prss.productStoreId};	                   
	                 }
                </script>                

    	         <td><a class="blue" onclick="oncheckP();" >
    	                 ${(prss.storeName)!}
    	               </a>         
                 </td>                    
 

            <!-- <td class="hidden-480">11</td> -->
            <td>${(prss.lastUpdatedStamp.toString())!}</td>
            <#-- <td>${uiLabelMap.HascollectionsCf}</td>  --> 
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
			                  window.location.href="<@ofbizUrl>delProductStoreFromFavoriteList?productStoreId=</@ofbizUrl>"+${prss.productStoreId};	                   
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
  
    <!-- /.page-content-area -->
</div>