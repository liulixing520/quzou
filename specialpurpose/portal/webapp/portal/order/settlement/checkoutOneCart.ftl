
<#assign innerCart = (requestAttributes.optShoppingCart)!/>
<#assign productStoreId= innerCart.getProductStoreId()/>
<#--<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>-->
<#assign productStore = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStore(productStoreId, delegator)?if_exists />
<#assign productStorePrefix = Static["org.ofbiz.base.util.UtilHttpExt"].getProductStorePrefix(request,productStoreId)?if_exists />
	<table class="orderbox">
            <tbody>
                <tr>
                    <th width="20%" colspan="7" style="background:#bbb; color:#fff; float:left">
                        <span style="float:left">
                        <@htmlTemplate.storeNameMac storeName=productStore.storeName dxStoreId=innerCart.dxStoreId!/>
                        &nbsp;${uiLabelMap.PortalUserPayProductDetails}</span>
                    	<span style="float:right">${uiLabelMap.PortalUserPayShipmentMethod}：
                            <select name="${productStorePrefix}shipping_method" productStoreId="${productStoreId!}" autocomplete='off' onchange="setShippingMethod(this)">
                            	<option value="">请选择发货方式</option>
                                <#list carrierShipmentMethodList as carrierShipmentMethod>
                                    <#assign shippingMethod = carrierShipmentMethod.shipmentMethodTypeId + "@" + carrierShipmentMethod.partyId>
                                    <#assign ifChosed = Static["org.ofbiz.ebiz.util.EbizStringUtil"].compareStr(shippingMethod, chosenShippingMethod?default("N@A"))/>
                                    <option value="${shippingMethod}" <#if ifChosed> selected</#if>>
                                      <#if shoppingCart.getShippingContactMechId()?exists>
                                        <#assign shippingEst = shippingEstWpr.getShippingEstimate(carrierShipmentMethod)?default(-1)>
                                      </#if>
                                       <#assign shipmentMethodType = delegator.findOne("ShipmentMethodType",{"shipmentMethodTypeId":carrierShipmentMethod.shipmentMethodTypeId},true)>
				                         <#assign partyGroup = delegator.findOne("PartyGroup",{"partyId":carrierShipmentMethod.partyId},true)!>
				                         <#if partyGroup?has_content>${partyGroup.groupName}</#if>
                                    </option>
                              	</#list>
                            </select>
                        </span>
                  	</th>
                </tr>  
                <tr>
                    <th width="10%">${uiLabelMap.PortalUserMoreProductImage}</th>
                    <th width="27%">${uiLabelMap.PortalUserProductName}</th>
                    <th width="8%">${uiLabelMap.PortalUserProductsNumber}</th>
                    <th width="11%">${uiLabelMap.PortalUserCarRollup}</th>
                    <th width="13%">${uiLabelMap.PortalUserPaySellersAdjustment}</th>
                 <#--   <th>${uiLabelMap.PortalUserPayCoupon}</th> -->
                </tr>
                <#list innerCart.items() as cartLine>

          <#assign cartLineIndex = innerCart.getItemIndex(cartLine) />
          		<#assign cartLineProdName=""/>
          	<#if cartLine.getProductId()?exists>
                    <#-- product item -->
                    <#-- start code to display a small image of the product -->
                    <#if cartLine.getParentProductId()?exists>
                      <#assign parentProductId = cartLine.getParentProductId() />
                    <#else>
                      <#assign parentProductId = cartLine.getProductId() />
                    </#if>
                    <#assign smallImageUrl = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(cartLine.getProduct(), "SMALL_IMAGE_URL", locale, dispatcher)?if_exists />
                    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg" /></#if>
                    <#--
                    <#if smallImageUrl?string?has_content>
                      <a href="<@ofbizCatalogAltUrl productId=parentProductId/>"  target="_blank">
                        <img src="<@ofbizContentUrl>${requestAttributes.contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>" alt="Product Image" class="imageborder" />
                      </a>
                    </#if>
                    -->
                    <#-- end code to display a small image of the product -->
                    <#-- ${cartLineIndex} - -->
                    <#assign cartLineProdName="${cartLine.getProductId()} - ${cartLine.getName()?if_exists} : ${cartLine.getDescription()?if_exists}"/>


                    <#-- if inventory is not required check to see if it is out of stock and needs to have a message shown about that... -->
                    <#assign itemProduct = cartLine.getProduct() />
                    <#assign isStoreInventoryNotRequiredAndNotAvailable = Static["org.ofbiz.product.store.ProductStoreWorker"].isStoreInventoryRequiredAndAvailable(request, itemProduct, cartLine.getQuantity(), false, false) />
                    <#if isStoreInventoryNotRequiredAndNotAvailable && itemProduct.inventoryMessage?has_content>
                        (${itemProduct.inventoryMessage})
                    </#if>

                  <#else>
                    <#-- this is a non-product item -->
                    <#assign cartLineProdName="${cartLine.getItemTypeDescription()?if_exists}: ${cartLine.getName()?if_exists}"/>
                  </#if>
                  
                <tr>
                    <td rowspan="1">
                    	<#assign product=delegator.findOne("Product", {"productId" : cartLine.getProductId()}, true)?if_exists/>
                    	<a href="<@ofbizCatalogAltUrl productId=product.productId/>"><img src="${product.smallImageUrl!'/images/defaultImage.jpg'}" width="80px" height="80px"/></a>
                    </td>
                    <td class="alignleft">
                    <a href="<@ofbizCatalogAltUrl productId=product.productId/>">
                   <#--${cartLineProdName!}--> 
                   
                   
                     <#-- 判断商品语种-->
 					<#assign product=cartLine.getProduct() />
						<#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
														${productName!}
                   
                   
                    </a>
                    </td>
                    <td>${cartLine.getQuantity()?string.number}</td>
                    <td><strong><@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=innerCart.getCurrency()/></strong></td>

                    
                    <td rowspan="1">
                        <strong><@ofbizCurrency amount=cartLine.getOtherAdjustments() isoCode=innerCart.getCurrency()/></strong>
                    </td>
                <#--  <td rowspan="1">


                        <a class="enterlink" href="javascript:void(0);">Enter a coupon code</a>

                        <div class="enterbox" style="display:none;">
                            <input class="inputcoupon" type="text" id="couponcode_1466435272" value="">
                            <input class="btn-addcoupon" type="button" value="Add a Coupon"
                                   onClick="submittor.submit('addOrderCoupon','1466435272');">
                        </div>

                    </td> -->  
                </tr>
              </#list>
               
               <tr>
                    <td width="10%" colspan="7" style="text-align:right; padding-right:10px; line-height:25px;">${uiLabelMap.PortalUserPaySubtotals}：<@ofbizCurrency amount=innerCart.getDisplaySubTotal() isoCode=innerCart.getCurrency()/><p>${uiLabelMap.PortalUserPayShippingCharge}：<@ofbizCurrency amount=innerCart.getTotalShipping() isoCode=innerCart.getCurrency()/></p></td>
                </tr>

                </tbody>
            </table> 
 <script language='javascript'>
 //选择配送方式
var setShippingMethod = function(obj){
	var shipMethod = $(obj).val();
	var productStoreId = $(obj).attr("productStoreId");
	/*
	if(shipMethod==''||shipMethod=='undefined'){
		shipMethod = 'NO_SHIPPING@_NA_';
	}
	*/
	var url = "<@ofbizUrl>setShippingMethod</@ofbizUrl>";
	var param = {'shipping_method':shipMethod,productStoreId:productStoreId};
	$.post(url,param,function(data){
		if(data.info){
			alert(data.info)
		}else{
			location.reload();
		}
	}, 'json');
}
//调用最新数据，刷新页面显示
var refreshData = function(){
	var url = "<@ofbizUrl>getNewestAmountData</@ofbizUrl>";
	var param = {};
	$.post(url,param,function(data){
	
		var SPZE = data.SPZE;//商品总额
		if(SPZE=='0'){SPZE='0.00'}
		SPZE = formatShow(SPZE);
		
		var YHJE = data.YHJE;//优惠金额
		if(YHJE=='0'){YHJE='0.00'}
		YHJE = formatShow(YHJE);
		
		var ZJ_YF = data.ZJ_YF;//总计-运费
		if(ZJ_YF=='0'){ZJ_YF='0.00'}
		ZJ_YF = formatShow(ZJ_YF);
		
		var YF = data.YF;//运费
		if(YF=='0'){YF='0.00'}
		YF = formatShow(YF);
		
		$("span[name=SPZE]").html("￥"+SPZE);
		$("span[name=YHJE]").html("￥"+YHJE);
		$("span[name=ZJ_YF]").html("￥"+ZJ_YF);
		$("span[name=YF]").html("￥"+YF);
		var ZZZF = data.ZZZF;//最终支付
		$("#totalNeedPay").val(ZZZF);
		
		var usedCardAmount = '0';
		var usedACCTAmount = '0';
		
		if($("#usedCardAmount").val()!='' && typeof( $("#usedCardAmount").val() )!='undefined'){
			usedCardAmount = $("#usedCardAmount").val();
		}
		if($("#usedACCTAmount").val()!='' && $("#usedACCTAmount").val()!='undefined'){
			usedACCTAmount = $("#usedACCTAmount").val();
		}
		ZZZF = (parseFloat(ZZZF)-parseFloat(usedCardAmount)-parseFloat(usedACCTAmount)).toFixed(2);
		if(ZZZF==0){
			ZZZF='0.00';
		}else if(ZZZF<0){
			alert("账户余额与会员卡余额支付额超出了总支付额，请重新设置！");
			$("#usedCardAmount").val("");
			$("#cardPayAmount").val("￥0.00");
			$("#usedACCTAmount").val("");
			$("#ACCTPayAmount").val("￥0.00");
			ZZZF = data.ZZZF;
		}else{
			usedCardAmount = formatShow(usedCardAmount);
			$("#cardPayAmount").html("￥"+usedCardAmount);
			usedACCTAmount = formatShow(usedACCTAmount);
			$("#ACCTPayAmount").html("￥"+usedACCTAmount);
		}
		
		
		ZZZF = formatShow(ZZZF);
		$("span[name=ZZZF]").html("￥"+ZZZF);
	}, 'json');
}

 </script>           