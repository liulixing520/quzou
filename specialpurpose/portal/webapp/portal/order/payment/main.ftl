<div class="order-content">
    <div id="header" class="header" style="border:none;">
        <ul class="status steps-two">
            <li class="status-one">${uiLabelMap.PortalUserPayPlaceOrders}</li>
            <li class="status-two">${uiLabelMap.PortalUserPayPaidOrders}</li>
            <li class="status-three">${uiLabelMap.PortalUserPayPaymentSuccess}</li>
        </ul>
    </div>
    <div class="shangpin">
        <h2 style="font-size:18px; font-weight:bold; margin-bottom:8px;">${uiLabelMap.PortalUserOrderInformation}</h2>
    <#--<#if shoppingCartMap?has_content>
        <#list shoppingCartMap.getShoppingCartList() as innerCart>
        &lt;#&ndash;
            <@oneShoppingCart innerCartMap=shoppingCartMap innerCart=innerCart /> &ndash;&gt;
        ${setRequestAttribute("optShoppingCart",innerCart)}
        ${screens.render("component://portal/widget/OrderScreens.xml#checkoutOneCart")}
        </#list>
    </#if>
    </div>

    <#assign cartCurrency= "USD"/>
    <#if shoppingCartMap.getShoppingCartList()?has_content>
    <#assign cartCurrency = shoppingCartMap.getShoppingCartList().get(0).getCurrency()/>
    </#if>
    <div class="total">
    <i style="font-style:normal; display:block;">项目小计: <@ofbizCurrency amount=shoppingCartMap.getDisplaySubTotal() isoCode=cartCurrency/></i>
    <i style="font-style:normal; display:block;">运输成本: <@ofbizCurrency amount=shoppingCartMap.getTotalShipping() isoCode=cartCurrency/></i>
    <strong class="bigsize">总计: <span class="red"><@ofbizCurrency amount=shoppingCartMap.getGrandTotal() isoCode=cartCurrency/></span></strong>
    <strong class="red"><@ofbizCurrency amount=shoppingCartMap.getGrandTotal() isoCode=cartCurrency/></strong><br>
    </div>-->
        <table class="orderbox">
            <thead>
            <tr>
                <th class="center">${uiLabelMap.PortalUserOrderNumber}</th>
                <#-- 
                <th>商品列表</th>
                -->
                <th class="hidden-xs">${uiLabelMap.PortalUserQuantity}</th>
                <th class="hidden-480">${uiLabelMap.PortalUserCarTotal}</th>
                <th class="hidden-480">${uiLabelMap.PortalUserPayLogistics}</th>
                <th>${uiLabelMap.PortalUserPaySellersAdjustment}</th>
            </tr>
            </thead>

            <tbody>
            <#assign totalPay = Static["java.math.BigDecimal"].ZERO/>
            <#assign totalCurrency = "USD"/>
            <#assign payMethod="">
            <#if orderList?has_content>
            
            	<#list orderList as orderHeader>
            		<#--assign orderHeader = Static["org.ofbiz.order.order.OrderReadHelper"].getOrderHeader(delegator,orderId)/-->
            		<#assign orh = Static["org.ofbiz.order.order.OrderReadHelper"].getHelper(orderHeader)/>
            		<#-- assign orderContactMechValueMaps=Static["org.ofbiz.party.contact.ContactMechWorker"].getOrderContactMechValueMaps(delegator, orderId)/ -->
            		<#assign shipGroups = orh.getOrderItemShipGroups()/>
            		<#assign totalOrderItemsQuantity= orh.getTotalOrderItemsQuantity()>
            		<tr>
                		<td class="center">${orderHeader.orderId!}</td>
                		<#-- 
                		<td>未命名</td>
                		-->
                		<td class="hidden-xs">${totalOrderItemsQuantity}${uiLabelMap.PortalUserCarNumber}</td>
                		<td class="hidden-480"><@ofbizCurrency amount=orh.getOrderGrandTotal() isoCode=orh.getCurrency()/></td>
                		<td class="hidden-480">
                			<#if shipGroups?has_content>
                				<#assign shipGroup = shipGroups.get(0)/>
                 				<#assign shipmentMethodType = shipGroup.getRelatedOne("ShipmentMethodType", false)?if_exists>
                    			<#assign shipGroupAddress = shipGroup.getRelatedOne("PostalAddress", false)?if_exists>
                    			<#if shipmentMethodType?has_content>
                    				${shipmentMethodType.get("description",locale)!}
                    			</#if>
                    			<#if shipGroupAddress?has_content>
	                    			${shipGroupAddress.toName!}
	                    			<br>
					                ${shipGroupAddress.address1!}
				                </#if>
                    		</#if>
                    		
                    		<#--
                    		FREE!
                    		<br>
                    		China Post Air Mail
                    		<br>
                    		20-33 Estimated
                    		<br>
                    		Delivery:
                    		<br>
                    		Supplier ships within 2 Estimated Delivery
                    		
                    		<#list orderContactMechValueMaps as orderContactMechValueMap>
					          <#assign contactMech = orderContactMechValueMap.contactMech>
					          <#assign contactMechPurpose = orderContactMechValueMap.contactMechPurposeType>
					          <#if contactMech.contactMechTypeId == "POSTAL_ADDRESS">
				                <#assign postalAddress = orderContactMechValueMap.postalAddress>
				                <#if postalAddress?has_content>
				                	${postalAddress.toName}
				                	${postalAddress.address1?if_exists}
				                </#if>
				              </#if>
					        </#list>
					        -->
                		</td>
                		<td><@ofbizCurrency amount=orh.getOrderAdjustmentsTotal() isoCode=orh.getCurrency()/></td>
            		</tr>
            		<#assign totalPay=totalPay.add(orh.getOrderGrandTotal())/>
            		<#assign totalCurrency=orh.getCurrency()/>
            		<#if !payMethod??>
	            		<#assign payMethodGv=Static["org.ofbiz.entity.util.EntityUtil"].getFirst(orh.getPaymentPreferences())/>
	            		<#assign payMethod=payMethodGv.paymentMethodTypeId/>
            		</#if>
            	</#list>
            </#if>
            </tbody>
        </table>
    </div>
    <div style="text-align:center;clear:both;margin-top:35px;">
		<#if payMethod == "EXT_COD"> 
    		 <a href="main" class="e_list">继续购物</a>
    	<#else>
   			<a href="javascript:submitpayment()" class="e_list">${uiLabelMap.PortalUserPayConfirmPayment}</a>
   		</#if>
       	<input value="hehe" type="button" style="display:none" id="submitpayment"/>
    </div>

<div style="clear:both"></div>
<link rel="stylesheet" href="/portal/seller/images/product/easydialog.css" type="text/css"/>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.min.js"></script>
<style type="text/css">
.easyDialog_wrapper{width:500px;}
</style>
<div id="imgBox" style="display:none">
	<div style="text-align:center; padding:15px 0; padding-bottom:28px; color:#ff7f00;font-size:18px;font-weight:bold;">${uiLabelMap.Pleasemake}</div>
	<div class="easyDialog_footer" style="padding-left:100px; padding-bottom:10px;">
	<#--<a href="<@ofbizUrl>paymentSuccess</@ofbizUrl>" class="btn_highlight" style="float:left; margin-left:20px; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">&nbsp;&nbsp; ${uiLabelMap.Pleasecompletion} &nbsp;&nbsp;</a>-->
	<a href="javascript:checkpayment()" class="btn_highlight" style="float:left; margin-left:20px; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">&nbsp;&nbsp; ${uiLabelMap.Pleasecompletion} &nbsp;&nbsp;</a>
	<a href="javascript:checkpayment();" class="btn_normal" style="float:left; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">${uiLabelMap.Pleaseproblems}</a>
	</div>
</div>
<script>
var $ = function(){
	return document.getElementById(arguments[0]);
};
var btnFn = function( e ){
	alert( e.target );
	return false;
};
$('submitpayment').onclick = function(){
	easyDialog.open({
		container : {
			header : '${uiLabelMap.Pleaseorder}',
			content : $('imgBox').innerHTML
		}
	});
	jQuery("#closeBtn").attr("href","javascript:checkpayment()");
};
var orderIdList = '';
<#list orderIdList![] as orderId>
	<#if orderId_index==0>
		orderIdList+="${orderId}";
	<#else>
		orderIdList+=",${orderId}";
	</#if>
</#list>
	function checkpayment(){
		jQuery.ajax({
            type: "get",//使用get方法访问后台
            url: "<@ofbizUrl>checkPaymentStatus</@ofbizUrl>",//要访问的后台地址
            data:{orderIdList:orderIdList},//要发送的数据
            dataType: "json",//返回json格式的数据
            success: function (msg) {//msg为返回的数据，在这里做数据绑定
            	if(msg.info||_ERROR_MESSAGE_||_ERROR_MESSAGE_LIST_){
            		alert(msg.info||_ERROR_MESSAGE_||_ERROR_MESSAGE_LIST_);
            	}else{
                	location='<@ofbizUrl>paymentSuccess</@ofbizUrl>';
                }
            },
            error :function(msg){
            	alert(msg);
            }
      });
/**原：	jQuery.ajax({
            type: "get",//使用get方法访问后台
            url: "<@ofbizUrl>payeaseCheck</@ofbizUrl>",//要访问的后台地址
            data:"",//要发送的数据
            dataType: "json",//返回json格式的数据
            success: function (msg) {//msg为返回的数据，在这里做数据绑定
                alert(msg);
            },
            error :function(msg){
            	//alert(msg['responseText']);
            	if(msg['responseText'].substr(msg['responseText'].indexOf('retStatus')+12,5)=='error'){
            		alert("支付失败！ 请重新支付");
            		javascript:easyDialog.close();
            	}else{
            		location='<@ofbizUrl>paymentSuccess</@ofbizUrl>';
            	}
            }
      });*/
}

	function submitpayment(){
	 	//window.open ("<@ofbizUrl>zfd</@ofbizUrl>");
	  	$('submitpayment').onclick();
	  	window.open("checkPaymentMethod");
	  	/*
		jQuery.ajax({
	    	type: "get",//使用get方法访问后台
	        url: "<@ofbizUrl>checkPaymentMethod</@ofbizUrl>",//要访问的后台地址
	        data: "",//要发送的数据
	        success: function (msg) {//msg为返回的数据，在这里做数据绑定
	        },
	        error :function(msg){
	     	}
	  	});
	  	*/
		/**原：
		jQuery.ajax({
            type: "get",//使用get方法访问后台
            url: "<@ofbizUrl>callPayease</@ofbizUrl>",//要访问的后台地址
            data: "",//要发送的数据
            success: function (msg) {//msg为返回的数据，在这里做数据绑定
                //$('imgBox').innerHTML+=msg;
                jQuery(document.body).append(msg);
                //document.getElementsByName("form")[0].submit();
                $('submitpayment').onclick();
            }
      	});*/
	}

</script>
    <#--paymentSuccess-->

<#--
    <h2 style="font-size:18px; font-weight:bold; margin-bottom:8px;">${uiLabelMap.PortalUserPayment}</h2>

    <div id="tabId" style="width:100%">
        <div class="tabT">
            <ul class="tab">
                <li id="tabId1" class="current" onclick="tab('tabId1','tabC1');">VISA</li>
                <li id="tabId2" onclick="tab('tabId2','tabC2');">MasterCard</li>
                <li id="tabId3" onclick="tab('tabId3','tabC3');">American Express</li>
            </ul>
        </div>
        <div id="tabC1" class="show" >
            <form class="form-horizontal" role="form" action="<@ofbizUrl>paymentSuccess</@ofbizUrl>">
                <p>${uiLabelMap.PortalUserPayYouNeedPay}：<span class="summer"><@ofbizCurrency amount=totalPay isoCode=totalCurrency/></span></p>
                <table width=100%>
                    <tr>
                        <td width="25%" class="right"><label>${uiLabelMap.PortalUserPayCardNo}：</label></td>
                        <td width="75%"><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayValidDate}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayVerifyCode}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayBillingAddress}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayContactPerson}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayZipCode}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayTelephone}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayAddress}：</label></td>
                        <td ><input type="text"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" class="e_list" value="${uiLabelMap.PortalUserPayConfirmPayment}"></input>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div id="tabC2" class="hidden">
            <form class="form-horizontal" role="form">
                <p>${uiLabelMap.PortalUserPayYouNeedPay}：<span class="summer"><@ofbizCurrency amount=totalPay isoCode=totalCurrency/></span></p>
                <table width=100%>
                    <tr>
                        <td width="25%" class="right"><label>${uiLabelMap.PortalUserPayCardNo}：</label></td>
                        <td width="75%"><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayValidDate}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayVerifyCode}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayBillingAddress}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayContactPerson}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayZipCode}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayTelephone}：</label></td>
                        <td><input type="text"/></td>
                    </tr>
                    <tr>
                        <td class="right"><label>${uiLabelMap.PortalUserPayAddress}：</label></td>
                        <td ><input type="text"/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <a  onclick="#"/>${uiLabelMap.PortalUserPayConfirmPayment}</a>
                            
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div id="tabC3" class="hidden">
            <p>Please wait under development......</p>&lt;#&ndash; 正在开发中请稍后…… &ndash;&gt;
        </div>
    </div>
    <div style="clear:both;"></div>
</div>

<script type="text/javascript" language="javascript">
    function tab(tabId, tabC) {
        var len = document.getElementById('tabId').getElementsByTagName('li').length;
        for (i = 1; i <= len; i++) {
            if ("tabId" + i == tabId) {
                document.getElementById(tabId).className = "current";
            } else {
                document.getElementById("tabId" + i).className = "";
            }
            if ("tabC" + i == tabC) {
                document.getElementById(tabC).className = "show";
            } else {
                document.getElementById("tabC" + i).className = "hidden";
            }
        }
    }
</script>-->
