
<script type="text/javascript">
    $(function () {
    	$(".breadcrumb").append("<li class='active'>${uiLabelMap.TransactionCf}</li><li class='active'>${uiLabelMap.PortalUserOrder}</li>")
        startId = $("#orderStatus").val();
        $("li").remove(".current");
        if (startId == "") {
            $("#li1").attr("class", "current");
        } else {
            $("#" + startId).attr("class", "current");
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
            current_page: "${viewIndex}",   //当前页码
            num_edge_entries: 2, //连续分页主体部分分页条目数
            link_to: "?page=__id__"
        });
        function TranUrl(page_id) {
            var url = location.href;
            //var startOrderDate=$("#start_order_time").val();
            //var endOrderDate=$("#end_order_time").val();
            var statusId = $("#orderStatus").val();
            if (statusId.length > 0) {
                url = url + "statusId=" + statusId
            }
            location.href = url + "&page=" + page_id;
        }
    })

</script>
<form id="pagerForm" method="post" action="user_myorder">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	<input type="hidden" id="productStoreId"  value='${productStoreId!}'/>

<div class="content my_order">
            <h3 class="title" style='font-size:20px'>我的订单</h3>
            <div class="order_show">
                <div class="tab_wrap">
                    <ul class="tab-list-show">
	                <li id="li1" class="<#if statusId=='all'>on</#if> first"><a href="<@ofbizUrl>user_myorder</@ofbizUrl>"> <span
	                		id="shelfProductNum"> ${uiLabelMap.PortalUserAllOrders}&nbsp; </span> </a></li>
			        <li id="ORDER_CREATED" class='<#if statusId=='ORDER_CREATED'>on</#if>'><a href="<@ofbizUrl>user_myorder?statusId=ORDER_CREATED</@ofbizUrl>"> <span
			                id="shelfProductNum"> ${uiLabelMap.PortalUserPendingPayment}&nbsp; </span> </a></li>
			        <li id="ORDER_APPROVED" class='<#if statusId=='ORDER_APPROVED'>on</#if>'><a href="<@ofbizUrl>user_myorder?statusId=ORDER_APPROVED</@ofbizUrl>"> <span
			                id="auditFailProductNum"> ${uiLabelMap.PortalUserBeShipped}&nbsp;</span> </a></li>
			        <li id="ORDER_SENT" class='<#if statusId=='ORDER_SENT'>on</#if>'><a href="<@ofbizUrl>user_myorder?statusId=ORDER_SENT</@ofbizUrl>"> <span
			                id="downShelfProductNum"> ${uiLabelMap.PortalUserShipmentsIn} &nbsp;</span> </a></li>
			        <li id="ORDER_COMPLETED" class='<#if statusId=='ORDER_COMPLETED'>on</#if>'><a href="<@ofbizUrl>user_myorder?statusId=ORDER_COMPLETED</@ofbizUrl>"> <span
			                id="auditFailProductNum2"> ${uiLabelMap.PortalUserCompleted} &nbsp;</span> </a></li>
			       <!-- <li id="ORDER_REJECTED"><a href="<@ofbizUrl>user_myorder?statusId=ORDER_REJECTED</@ofbizUrl>"> <span
			                id="downShelfProductNum2"> ${uiLabelMap.PortalUserRefunded}&nbsp;</span> </a></li> -->
			        <li id="ORDER_CANCELLED" class='<#if statusId=='ORDER_CANCELLED'>on</#if>'><a href="<@ofbizUrl>user_myorder?statusId=ORDER_CANCELLED</@ofbizUrl>"> <span
			                id="downShelfProductNum2"> ${uiLabelMap.PortalUserCancelled}&nbsp;</span> </a></li>
                    	
                    </ul>
                </div>
                <div style="display: block;" class="tab_content">
                <#if orderHeaderList??>
                            <#list orderHeaderList as orderHeader>
                                <#assign status = orderHeader.getRelatedOne("StatusItem", true) />
	                           <div class="order_item">
		                            <h3 class="title">
		                                <span>下单时间：${orderHeader.orderDate?string("YYYY-MM-dd HH:mm:ss")}</span>
		                                <span>总价：<@ofbizCurrency amount=orderHeader.grandTotal isoCode=orderHeader.currencyUom /></span>
		                                <span>送至：
		                                		 <#assign orderContactMechValueMaps = Static["org.ofbiz.party.contact.ContactMechWorker"].getOrderContactMechValueMaps(delegator, orderHeader.orderId)>
												<#list orderContactMechValueMaps as orderContactMechValueMap>
							          				<#assign contactMech = orderContactMechValueMap.contactMech>
							          				<#assign contactMechPurpose = orderContactMechValueMap.contactMechPurposeType>
							          				<#if contactMech.contactMechTypeId == "POSTAL_ADDRESS">
							                			<#assign postalAddress = orderContactMechValueMap.postalAddress>
												      	<#assign AddressGeoAllCn =Static["org.ofbiz.system.ContactMechTools"].
												                            getAddressGeoAllCn(delegator,postalAddress.stateProvinceGeoId,postalAddress.cityGeoId,postalAddress.countyGeoId)>
							          					<#if postalAddress?has_content>
							                			${AddressGeoAllCn?if_exists} ${(postalAddress.address1)?if_exists}
							                			</#if>
							                		</#if>
							                	</#list>		
		                                </span>
		                                <span class="right">订单号：  ${orderHeader.orderId}</span>
		                            </h3>
	                           <div class="status">
					             	<p class="status_title wait_to_send">
					             	<#if orderHeader.statusId?has_content>
					             		<span class="fr">${status.get("description",locale)}</span>
	                                            
					             	</p>
					                <div class="check_status">
					                	<#if orderHeader.statusId == "ORDER_SENT">
	                                                <a 
	                                                    href="<@ofbizUrl>user_myorder?orderId=${orderHeader.orderId}&amp;statusId2=ORDER_COMPLETED&amp;statusId=${orderHeader.statusId}</@ofbizUrl>">${uiLabelMap.PortalUserHasReceipt}</i> </a>
	                                            </#if>
	                                            <#if orderHeader.statusId == "ORDER_PROCESSING">
	                                            	<#if !orderHeader.applyForRefund??>
	                                                	<a  href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=applyForRefund</@ofbizUrl>">申请退款</i></a>
	                                            	<#else>
	                                                	<a  href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=cancelRefund</@ofbizUrl>">取消申请</i></a>
	                                                </#if>
	                                            </#if>
	                                            <#if orderHeader.statusId == "ORDER_CREATED">
	                                                <a 
	                                                    href="<@ofbizUrl>user_myorder?orderId=${orderHeader.orderId}&amp;statusId2=ORDER_CANCELLED&amp;statusId=${orderHeader.statusId}</@ofbizUrl>">${uiLabelMap.PortalUserQuXiao}</i> </a>
	                                                <#--<a  href="<@ofbizUrl>user_payorder?orderId=${orderHeader.orderId}</@ofbizUrl>">${uiLabelMap.PortalPayment}</i></a>-->
	                                                <a  href="javascript:submitpayment('${orderHeader.orderId}')">${uiLabelMap.PortalPayment}</i></a>
	                                            </#if>
	                                            
	                                            <#if orderHeader.statusId == "ORDER_APPROVED">
	                                            	<#if !orderHeader.applyForRefund??>
	                                                	<a  href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=applyForRefund</@ofbizUrl>">${uiLabelMap.PortalPaymentApplyRefund}</i></a><#-- 申请退款-->
	                                            	<#else>
	                                                	<a  href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=cancelRefund</@ofbizUrl>">${uiLabelMap.PortalPaymentCancellationRequest}</i></a><#-- 取消申请-->
	                                                </#if>
	                                                <#--><a  href="<@ofbizUrl>user_myorder?orderId=${orderHeader.orderId}&amp;statusId2=ORDER_CANCELLED&amp;statusId=${orderHeader.statusId}</@ofbizUrl>">${uiLabelMap.PortalUserQuXiao}</i> </a>-->
	                                            </#if>
	                                            <#if orderHeader.statusId == "ORDER_SENT">
	                                            	<#if !orderHeader.applyForRefund??>
	                                                	<a  href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=applyForRefund</@ofbizUrl>">${uiLabelMap.PortalPaymentApplyRefund}</i></a><#--申请退款 -->
	                                            	<#else>
	                                                	<a  href="<@ofbizUrl>orderRemark?orderId=${orderHeader.orderId}&operName=cancelRefund</@ofbizUrl>">${uiLabelMap.PortalPaymentCancellationRequest}</i></a><#--取消申请 -->
	                                                </#if>
	                                            </#if>
	                                            <#if orderHeader.statusId == "ORDER_COMPLETED">
	                                            	<a  href="<@ofbizUrl>user_makeReturn?orderId=${orderHeader.orderId}</@ofbizUrl>">${uiLabelMap.OrderRequestReturn}</i> </a>
	                                                <a  href="#">${uiLabelMap.PortalUserDelete}</i> </a>
	                                            </#if>
	                                            <#if orderHeader.statusId == "ORDER_REJECTED">
	                                                <a  href="#">${uiLabelMap.PortalUserDelete}</i> </a>
	                                            </#if>
	                                            <#if orderHeader.statusId == "ORDER_CANCELLED">
	                                                <a  href="#">${uiLabelMap.PortalUserDelete}</i> </a>
	                                            </#if>
	                                        </#if>
					                	<a href="<@ofbizUrl>user_myorderdetails?orderId=${orderHeader.orderId}</@ofbizUrl>">订单详情</a>
					                </div>
	                           </div>       
		                           <#assign orderItem=delegator.findByAnd("OrderItem",{"orderId":orderHeader.orderId})?if_exists>
		                            <#list orderItem as orderItem>  
                                        <#assign product = orderItem.getRelatedOne("Product", true)>
	                                <ul class="item clearfix">
				                        <li class="item_pic">
				                            <a href="<@ofbizUrl>user_myorderdetails?orderId=${orderHeader.orderId}</@ofbizUrl>" target="_blank">
				                                <img src="${product.smallImageUrl!}" alt="">
				                            </a>
				                        </li>
				                        <li class="item_infor">
		                            		<!-- <p class="item_title">   ${product.productName!}                           </p>-->
	                            			<p class="item_name">
	                            				<a href="<@ofbizUrl>user_myorderdetails?orderId=${orderHeader.orderId}</@ofbizUrl>" target="_blank">  ${product.productName!}                            </a>
	                           				 </p>
	                                     </li>
	                        			<li class="item_num"> × ${orderItem.quantity}</li>
	                        			<li class="item_price"> <@ofbizCurrency amount=orderItem.unitPrice isoCode=currencyUomId/></li>
	                                    <li class="item_trace show_goods">
	                            			<div class="comment_pop_wrap">
	                                         	<a href="javascript:void(0);" onclick="add_cart_fly($(this),'http://i3.chunboimg.com/group1/M00/00/2A/Cv4IbFSx9JCAaQB1AAW_5YtKQjQ183_120_120.jpg',1825,1,698258,0)" class="border_btn">再次购买</a>
	                            			</div>
	                        			</li>
	                    			</ul>     
	                    			</#list>
	                    		</div>
			                        
	                               
	                            </div>
							</#list>
							<#include "component://portal/webapp/portal/includes/sellerpagination.ftl"/>      
							<@paginationSimple  listSize viewSize viewIndex  'user_myorder' 'user_myorder' parameters.sortField!/>
                        </#if>
                 </div>
           
				<span class="pop_box">
				    <span class="msg">你确定要继续吗？</span>
				    <span class="pop_box_btns"><a href="" class="pop-cancue">取消</a><a href="" class="btn_yes">确定</a></span>
				    <span class="sj_icon"></span>
				</span>               
		</div>
        </div>
    </div>




    
<input value="hehe" type="button" style="display:none"  onclick="dakai()" id="submitpayment"/>
<link rel="stylesheet" href="/portal/seller/images/product/easydialog.css" type="text/css"/>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.min.js"></script>
<style type="text/css">
.easyDialog_wrapper{width:500px;}
</style>
<div id="imgBox" style="display:none">
	<div style="text-align:center; padding:15px 0; padding-bottom:28px; color:#ff7f00;font-size:18px;font-weight:bold;">${uiLabelMap.Pleasemake}</div>
	<div class="easyDialog_footer" style="padding-left:100px; padding-bottom:10px;">
	<a href="javascript:checkpayment();" class="btn_highlight" style="float:left; margin-left:20px; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">&nbsp;&nbsp; ${uiLabelMap.Pleasecompletion} &nbsp;&nbsp;</a>
	<a href="javascript:checkpayment();" class="btn_normal" style="float:left; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">${uiLabelMap.Pleaseproblems}</a>
	</div>
</div>
<script>
function checkpayment(){
	jQuery.ajax({
            type: "get",//使用get方法访问后台
            url: "<@ofbizUrl>payeaseCheck</@ofbizUrl>",//要访问的后台地址
            data:"",//要发送的数据
            dataType: "json",//返回json格式的数据
            success: function (msg) {//msg为返回的数据，在这里做数据绑定
                location.reload();
            },
            error :function(msg){
            	location.reload();
            }
      });
}

var btnFn = function( e ){
	alert( e.target );
	return false;
};
function dakai(){
	easyDialog.open({
		container : {
			header : '${uiLabelMap.Pleaseorder}',
			content : $('#imgBox').html()
		}
	});
	//$("#closeBtn").attr("href","javascript:location.reload()");
	jQuery("#closeBtn").attr("href","javascript:checkpayment()");
};


function submitpayment(oderID){

window.open ("<@ofbizUrl>zfd</@ofbizUrl>");
document.getElementById('submitpayment').click();

jQuery.ajax({
            type: "get",//使用get方法访问后台
            url: "<@ofbizUrl>user_payorder?orderId="+oderID+"</@ofbizUrl>",//要访问的后台地址
            data: "",//要发送的数据
            success: function (msg) {//msg为返回的数据，在这里做数据绑定
            },
            error :function(msg){
             }
      });
/*原：
window.open("<@ofbizUrl>user_payorder?orderId="+oderID+"</@ofbizUrl>");
document.getElementById('submitpayment').click();
*/
}

</script>
    <!-- /.page-content-area -->
</div>