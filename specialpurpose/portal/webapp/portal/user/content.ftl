<script type="text/javascript">
	function changeContent(obj,status){
		if(status){
			$("#orderTable tr[valign=middle]").hide();
			$("#orderTable tr[name=TR_"+status+"]").show();
		}else{
			$("#orderTable tr[valign=middle]").show();
		}
		$("ul.tab-list-show li").removeClass("on");
		$("ul.tab-list-show li").removeClass("first");
		var liEle = $(obj).parent();
		liEle.addClass("on");
		liEle.addClass("first");
	}
</script>
<div style="overflow:hidden;">
	<div class="content my_order">
		<div class="user_infro clearfix">
			<span class="photo"><img src="http://i3.chunboimg.com/group1/M00/00/55/Cv4IdVTHJm-ATwyZAAAaKbvsZVc474_80_80.jpg" alt=""></span>
			<div class="user_detail">
				<p class="member">
					<#if sessionAttributes.autoName?has_content>
						<a class="name" href="<@ofbizUrl>userMain</@ofbizUrl>">${sessionAttributes.autoName?html}</a>
					<#else>
						<a href="<@ofbizUrl>login</@ofbizUrl>">${uiLabelMap.PortalLogin}</a>
					</#if>
					赚得佣金：<a href="<@ofbizUrl>login</@ofbizUrl>"> 200元 </a> 
					<!-- 普通会员 -->
				</p>
				<p class="enter_time">2015年01月26日注册</p>
				<p class="enter_time">导购推广页:<@ofbizUrl>${userLogin.partyId}</@ofbizUrl></p>
				<p class="credits">
					<!--
					<a href="http://chunbo.com/points/index.html" class="first">积分：0积分（价值¥0元）</a>
					<a href="http://chunbo.com/coupons/index.html">代金券：张</a>
					<a href="http://chunbo.com/giftcard/index.html">春播卡：¥0</a>
					<a href="http://chunbo.com/balance/index.html">余额：¥0元</a>
				    -->
				</p>
			</div>
		</div>
		<div class="order_show">
			<div class="tab_wrap">
				<ul class="tab-list-show">
					<li class="on first"><a href="javascript:void(0);" onclick="changeContent(this);">我的订单</a></li>
					<li><a href="javascript:void(0);" onclick="changeContent(this,'ORDER_CREATED');">待付款（${orderList3!0}）</a></li>
					<li><a href="javascript:void(0);" onclick="changeContent(this,'ORDER_APPROVED');">待发货（${orderList2!0}）</a></li>
					<li><a href="javascript:void(0);" onclick="changeContent(this,'ORDER_SENT');">待收货（${orderList5!0}）</a></li>
					<li><a href="javascript:void(0);" onclick="changeContent(this,'ORDER_COMPLETED');">待评价（${orderList4!0}）</a></li>
					<li><a href="javascript:void(0);" onclick="changeContent(this,'ORDER_CANCELLED');">已取消订单</a></li>
					<#--
						ORDER_CREATED 待付款
						ORDER_APPROVED 待发货
						ORDER_SENT 已发货
						ORDER_COMPLETED 已收货
					-->
				</ul>
			</div>	
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
			</div>
			<!-- 全部订单 -->
			<#--<div class="tab_content" id="order_list">
				<div class="order_item">
					<h3 class="title">
						<span>下单时间：2015-02-03</span>
						<span>总价：¥12</span>
						<span>送至：北京北京市西城区红莲大厦</span>
						<span class="right">订单号：36738243</span>
					</h3>
					<div class="status">
						<p class="status_title wait_to_send">已取消</p>
						<div class="check_status">
							<a href="javascript:void(0);">
								订单详情
							</a>
						</div>
						<div class="logistics_infor loading-m" style="display: none;">
							<p class="loading-txt">加载中，请稍后…</p>
						</div>
					</div>
					<ul class="item clearfix">
						<li class="item_pic">
							<a href="javascript:void(0);" target="_blank">
							<img src="home_files/Cv4IbFSx9JCAaQB1AAW_5YtKQjQ183_120_120.jpg" alt="">
							</a>
						</li>
						<li class="item_infor">
							<p class="item_title">纯天然 真空急冻 保持原味</p>
							<p class="item_name">
							<a href="javascript:void(0);" target="_blank">清脆冻干苹果脆片18g</a>
							</p>
						</li>
						<li class="item_num">
						×1</li>
						<li class="item_price">
						¥12</li>
						<li class="item_trace show_goods">
						<div class="comment_pop_wrap">
						<a href="javascript:void(0);" onclick="add_cart_fly($(this),'http://i2.chunboimg.com/group1/M00/00/2A/Cv4IbFSx9JCAaQB1AAW_5YtKQjQ183_120_120.jpg',1825,1,698258,0)" class="border_btn">再次购买</a>
						</div>
						</li>
					</ul>
				</div>
				删除确认框
				<span class="pop_box">
					<span class="msg">你确定要继续吗？</span>
					<span class="pop_box_btns"><a href="" class="pop-cancue">取消</a><a href="" class="btn_yes">确定</a></span>
					<span class="sj_icon"></span>
				</span>
			</div>
		</div>-->
		<div class="collect recent_browse">
			<div class="tab_wrap">
				<ul class="tab">
					<li class="on first"><a href="javascript:;">最近浏览</a></li>
				</ul>
			</div>
			<div style="display: block;" class="luobo_wrap tab_content" id="history_list">
				<a href="javascript:;" class="left_btn left_btn_disable" onclick="aLeft(this);"></a>
				<a href="javascript:;" class="right_btn" onclick="aRight(this)"></a>
				<div class="lunbo">
					<ul class="clearfix">
						<#if userLogin??>
							<#assign visitHistories = delegator.findByAnd("ProductVisit",{"partyId":userLogin.partyId},["-fromDate"],false)?if_exists/>
							<#assign visitProdIds = Static["org.ofbiz.entity.util.EntityUtil"].getFieldListFromEntityList(visitHistories![],"productId",true)?if_exists/>               
						</#if>
						<#list visitProdIds![] as productId>
							<#assign product = delegator.findOne("Product",false,{"productId":productId})?if_exists/>
							<li>
								<a href="/portal/products/p_${productId}" class="img" target="_blank">
								<#assign imgMap = Static["org.ofbiz.ebiz.product.ProductHelper"].getProdImgPaths(productId,"EB_PRODIMG_INFO",delegator)/>
						    	<#assign flag=imgMap.flag />
						     	<#assign imgList = imgMap.imgPathList/>
								<img src="${(imgList?first)!}">
								</a>
								<p class="name">
								暂无描述
								</p>
								<h4>
								<a href="/portal/products/p_${productId}" target="_blank">
						          	<#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
									${productName!}
								</a>
								</h4>
								<p class="price">
								<strong>
									<#assign prices = delegator.findByAnd("ProductPrice",{"productId":productId},["currencyUomId"],false)?if_exists />
									<#if prices?size &gt; 0>
										<@ofbizCurrency amount=prices[0].price isoCode=prices[0].currencyUomId />
									<#else>
										暂无报价
									</#if>
								</strong>
								</p>
								<p class="num">
									<#assign quantityUomId = product.quantityUomId!>
									<#assign uom = delegator.findOne("Uom",true,{"uomId":quantityUomId!})?if_exists>
									${(uom.description)!'销售单位'}
								</p>
							</li>
						</#list>
						<#--
						<li>
						<a href="http://chunbo.com/product/3293.html" class="img" target="_blank">
						<img src="">
						</a>
						<p class="name">
						大自然的味道</p>
						<h4>
						<a href="http://chunbo.com/product/3293.html" target="_blank">
						有机红颜草莓</a>
						</h4>
						<p class="price">
						<strong>
						¥ 28.9</strong>
						</p>
						<p class="num">
						400g</p>
						</li>
						<li>
						<a href="http://chunbo.com/product/3293.html" class="img" target="_blank">
						<img src="">
						</a>
						<p class="name">
						大自然的味道</p>
						<h4>
						<a href="http://chunbo.com/product/3293.html" target="_blank">
						有机红颜草莓</a>
						</h4>
						<p class="price">
						<strong>
						¥ 28.9</strong>
						</p>
						<p class="num">
						400g</p>
						</li>
						-->
					</ul>
				</div>
			</div>
			<#--
			<div style="display: none;" class="luobo_wrap tab_content" id="already_list">
				<a href="javascript:;" class="left_btn left_btn_disable" onclick="aLeft(this);"></a>
				<a href="javascript:;" class="right_btn" onclick="aRight(this)"></a>
				<div class="lunbo">
					<ul class="clearfix">
					</ul>
				</div>
			</div>
			<div style="display: none;" class="luobo_wrap tab_content" id="hot_list">
				<a href="javascript:;" class="left_btn left_btn_disable" onclick="aLeft(this);">
				</a>
				<a href="javascript:;" class="right_btn" onclick="aRight(this)">
				</a>
				<div class="lunbo">
					<ul class="clearfix">
					</ul>
				</div>
			</div>
			-->
		</div>
	</div>
</div>