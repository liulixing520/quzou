<#macro oneShoppingCart innerCartMap innerCart>
	<#assign productStore = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStore(innerCart.getProductStoreId(), delegator)?if_exists />

<table class="orderbox">
                <tbody>
                <tr>
                    <th width="10%" colspan="7" style="background:#bbb; color:#fff;">
                    <@htmlTemplate.storeNameMac storeName=productStore.storeName dxStoreId=innerCart.dxStoreId!/>
                    &nbsp;${uiLabelMap.PortalUserPayProductDetails}</th>
                </tr>
                <tr>
                    <th width="10%">${uiLabelMap.PortalUserMoreProductImage}</th>
                    <th width="27%">${uiLabelMap.PortalUserProductName}</th>
                    <th width="8%">${uiLabelMap.PortalUserProductsNumber}</th>
                    <th width="11%">${uiLabelMap.PortalUserCarRollup}</th>
                    <th width="15%">${uiLabelMap.PortalUserPayLogistics}</th>
                    <th width="13%">${uiLabelMap.PortalUserPaySellersAdjustment}</th>
                    <th>${uiLabelMap.PortalUserPayCoupon}</th>
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
                    <td rowspan="1"><img src="" width="80px" height="80px"/></td>
                    <td class="alignleft">${cartLineProdName!}
                    </td>
                    <td>${cartLine.getQuantity()?string.number}</td>
                    <td><strong><@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=innerCart.getCurrency()/></strong></td>

                    <td rowspan="1" class="alignleft">
                        <strong class="green">Free shipping</strong><strong>EMS</strong>
                        <p>Delivery: estimated between November 26 to December 9 Tuesday married (seller ships in 2 days) </p>
                    </td>
                    <td rowspan="1">
                        <strong><@ofbizCurrency amount=cartLine.getOtherAdjustments() isoCode=innerCart.getCurrency()/></strong>
                    </td>
                    <td rowspan="1">


                        <a class="enterlink" href="javascript:void(0);">Enter a coupon code</a>

                        <div class="enterbox" style="display:none;">
                            <input class="inputcoupon" type="text" id="couponcode_1466435272" value="">
                            <input class="btn-addcoupon" type="button" value="Add a Coupon"
                                   onClick="submittor.submit('addOrderCoupon','1466435272');">
                        </div>

                    </td>
                </tr>
              </#list>
               
               <tr>
                    <td width="10%" colspan="7" style="text-align:right; padding-right:10px; line-height:25px;">${uiLabelMap.PortalUserPaySubtotals}：<@ofbizCurrency amount=innerCart.getDisplaySubTotal() isoCode=innerCart.getCurrency()/><p>${uiLabelMap.PortalUserPayShippingCharge}：<@ofbizCurrency amount=innerCart.getTotalShipping() isoCode=innerCart.getCurrency()/></p></td>
                </tr>

                </tbody>
            </table> 
</#macro>


    <div class="order-content">
        <!--top-->
        <div id="header" class="header" style="border:none;">
            <ul class="status steps-one">
                <li class="status-one">${uiLabelMap.PortalUserPayPlaceOrders}</li>
                <li class="status-two">${uiLabelMap.PortalUserPayPaidOrders}</li>
                <li class="status-three">${uiLabelMap.PortalUserPayPaymentSuccess}</li>
            </ul>
         <#--<div class="order_content_first_left">填写核对订单信息</div>
		        <div class="order_content_first_right">
		        	<div class="order_content_first_right_one">1.${uiLabelMap.PortalUserPayPlaceOrders}</div>
		            <div class="order_content_first_right_two">2.${uiLabelMap.PortalUserPayPaidOrders}</div>
		            <div class="order_content_first_right_three">3.${uiLabelMap.PortalUserPayPaymentSuccess}</div>
		        </div>
		    </div> -->
        </div>
		<form method="post" action="<@ofbizUrl>processorderWithOptions</@ofbizUrl>" name="checkoutform" onsubmit='return checkform()'>
        <!--收货地址-->
        <div class="dhpay-warp">
            <#--<h3 class="dhpay-title">${uiLabelMap.PortalUserPayShipAddress}&nbsp;&nbsp;[<a href="javascript:void(0)" id="user_Address" target="_blank">${uiLabelMap.CommonAdd}</a>]</h3>-->
		<h3 class="dhpay-title">${uiLabelMap.PortalUserPayShipAddress}&nbsp;&nbsp; [<a href="javascript:void(0)" id="user_Address">${uiLabelMap.CommonAdd}</a>]</h3>
            	<ul class="balance-data">
            	<#if shippingContactMechList?has_content>
                 
                 <#list shippingContactMechList as shippingContactMech>
                   <#assign shippingAddress = shippingContactMech.getRelatedOne("PostalAddress", false)>
                   <#assign checkThisAddress = (shoppingCartMap.getShippingContactMechId()?default("") == shippingAddress.contactMechId)/>
                    <li class="total-balance"><input name="shipping_contact_mech_id" type="radio" style="float:left;" onclick="checkThis(this);" value="${shippingAddress.contactMechId}"
                                                     <#if checkThisAddress>checked="checked"</#if>/>
                         <span style="margin-left:20px;">
                         <#assign AddressGeoAllCn =Static["org.ofbiz.system.ContactMechTools"].
                            getAddressGeoAllCn(delegator,shippingAddress.stateProvinceGeoId,shippingAddress.cityGeoId,shippingAddress.countyGeoId)>
                         <#if shippingAddress.toName?has_content><b>${uiLabelMap.CommonTo}:</b>&nbsp;${shippingAddress.toName!} &nbsp;&nbsp;</#if>
                         <#if shippingAddress.attnName?has_content><b>${uiLabelMap.PartyAddrAttnName}:</b>&nbsp;${shippingAddress.attnName!}&nbsp;&nbsp;</#if>
                         <#if shippingAddress.address1?has_content>${AddressGeoAllCn!}${shippingAddress.address1!}&nbsp;&nbsp;</#if>
                         <#-- <#if shippingAddress.address2?has_content>${shippingAddress.address2}&nbsp;&nbsp;</#if> -->
                         <#-- <#if shippingAddress.city?has_content>${shippingAddress.city}</#if>-->
                         <#-- <#if shippingAddress.stateProvinceGeoId?has_content>&nbsp;&nbsp;${shippingAddress.stateProvinceGeoId}</#if>-->
                         <#if shippingAddress.postalCode?has_content>&nbsp;&nbsp;${shippingAddress.postalCode!}</#if>
                         <#-- <#if shippingAddress.countryGeoId?has_content>&nbsp;&nbsp;${shippingAddress.countryGeoId}</#if>-->
                         <#--<a target="_blank" href="<@ofbizUrl>user_EditAddress?contactMechId=${shippingContactMech.contactMechId}</@ofbizUrl>" style="margin-left:20px;">${uiLabelMap.PortalUserPayEditor}</a></li>
                         <a target="_blank" href="javascript:edite('${shippingContactMech_index}')" style="margin-left:20px;">${uiLabelMap.PortalUserPayEditor}</a>--></li>
                         </span>
                 </#list>
               <script>
		    	var addresslist=new Array();
		      	 <#list shippingContactMechList as shippingContactMech>
						<#assign shippingAddress = shippingContactMech.getRelatedOne("PostalAddress", false)>
						var addre = [];
						<#if shippingAddress.toName?has_content>addre.toName="${StringUtil.wrapString(shippingAddress.toName)}"</#if>
		                  <#if shippingAddress.attnName?has_content>addre.attnName="${StringUtil.wrapString(shippingAddress.attnName)}"</#if>
		                  <#if shippingAddress.address1?has_content>addre.address1='${StringUtil.wrapString(AddressGeoAllCn)} ${StringUtil.wrapString(shippingAddress.address1)}'</#if>
		                  <#if shippingAddress.address2?has_content>addre.address2='${StringUtil.wrapString(shippingAddress.address2)}'</#if>
		                  <#if shippingAddress.city?has_content>addre.city='${StringUtil.wrapString(shippingAddress.city)}'</#if>
		                  <#if shippingAddress.stateProvinceGeoId?has_content>addre.stateProvinceGeoId='${StringUtil.wrapString(shippingAddress.stateProvinceGeoId)}'</#if>
		                  <#if shippingAddress.postalCode?has_content>addre.postalCode='${StringUtil.wrapString(shippingAddress.postalCode)}'</#if>
		                  <#if shippingAddress.countryGeoId?has_content>addre.countryGeoId='${StringUtil.wrapString(shippingAddress.countryGeoId)}'</#if>
						addre.contactMechId='${shippingContactMech.contactMechId}';
						addresslist[${shippingContactMech_index}]=addre;
		      	 </#list>
		      </script>
               </#if> 
               </ul>
        </div>
		<div class="dhpay-warp">
			<#if shoppingCartMap?has_content>
			<#assign checkOutPaymentId = shoppingCartMap.getCheckOutPaymentId()!>
			</#if>
			<#if (checkOutPaymentId!) == "">
				<#assign checkOutPaymentId="EXT_PAYEASE"/>
			</#if>
            <h3 class="dhpay-title">${uiLabelMap.PortalUserPayment}</h3>
            <ul class="balance-data">
				<li class="total-balance">
					<input type="radio" name="checkOutPaymentId" value="EXT_COD" <#if "EXT_COD" == checkOutPaymentId!>checked="checked"</#if>/>
                    <span style="margin-left:20px;">货到付款</span>
				</li>
				<li class="total-balance">
					<input type="radio" name="checkOutPaymentId" value="EXT_ABCPAY" <#if "EXT_ABCPAY" == checkOutPaymentId!>checked="checked"</#if>/>
                    <span style="margin-left:20px;">农业银行网银</span>
				</li>
				<li class="total-balance">
					<input type="radio" name="checkOutPaymentId" value="EXT_ALIPAY" <#if "EXT_ALIPAY" == checkOutPaymentId!>checked="checked"</#if>/>
                    <span style="margin-left:20px;">支付宝</span>
				</li>
				<li class="total-balance">
					<input type="radio" name="checkOutPaymentId" value="EXT_NETPAY" <#if "EXT_NETPAY" == checkOutPaymentId!>checked="checked"</#if>/>
                    <span style="margin-left:20px;">银联用户支付</span>
				</li>
			</ul>
		</div>
        <!--商品-->
        <div class="shangpin">
            <h2 style="margin-top:25px; font-size:18px; font-weight:bold; margin-bottom:8px;">${uiLabelMap.PortalUserOrderInformation}</h2>
			<#assign cartCurrency= "USD"/>
			<#if shoppingCartMap?has_content>
                	<#list shoppingCartMap.getShoppingCartList() as innerCart>
                	<#if (innerCart.size()>0)>
                	<#--
                		<@oneShoppingCart innerCartMap=shoppingCartMap innerCart=innerCart /> -->
                	  
                		${setRequestAttribute("optShoppingCart",innerCart)}
                		${screens.render("component://portal/widget/OrderScreens.xml#checkoutOneCart")}
                		<#assign cartCurrency = innerCart.getCurrency()/>
                	</#if>
                	</#list>
                </#if>


            <div class="total" style="line-height:25px;">
                <i style="font-style:normal; display:block;">${uiLabelMap.PortalUserPayItemSubtotals}: <@ofbizCurrency amount=shoppingCartMap.getDisplaySubTotal() isoCode=cartCurrency/></i>
                <i style="font-style:normal; display:block;">${uiLabelMap.PortalUserCarShippingCosts}: <@ofbizCurrency amount=shoppingCartMap.getTotalShipping() isoCode=cartCurrency/></i>
                <strong class="bigsize">${uiLabelMap.PortalUserCarTotal}: <span class="red"><@ofbizCurrency amount=shoppingCartMap.getGrandTotal() isoCode=cartCurrency/></span></strong>
                <#--<strong class="red"><@ofbizCurrency amount=shoppingCartMap.getGrandTotal() isoCode=cartCurrency/></strong> -->
                <br>
            </div>
        </div>
        <!---->
        <div class="row">
            <#-- <a class="c_list" href="<@ofbizUrl>processorderWithOptions</@ofbizUrl>">${uiLabelMap.PortalUserPayContinuedPayment}</a>-->
            <#-- <a class="c_list" onclick="javascript:document.checkoutform.submit();"/>${uiLabelMap.PortalUserPayContinuedPayment}</a>-->
            <input  type="submit" class="c_list" value="${uiLabelMap.PortalUserPayContinuedPayment}"/> 
        </div>
        </form>
<link rel="stylesheet" href="/portal/seller/images/product/easydialog.css" type="text/css"/>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.min.js"></script>
<style>
.easyDialog_wrapper{width:500px}
</style>
<#assign actionUrlStr="user_checkoutAddress">
<#assign postalAddress = (mechMap.postalAddress)!/>
<div id="imgBox" style="display:none">
<form method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>" name="editcontactmechform"
              id="editcontactmechform" class="basic-form"
              onsubmit="javascript:submitFormDisableSubmits(this)">
            <input type="hidden" name="contactMechId" id="updateAddress_contactMechId"
                   value="${(mechMap.postalAddress.contactMechId)?default(request.getParameter('contactMechId')?if_exists)}">
            <input type="hidden" name="userLoginId" id="updateAddress_userLoginId">
            <input type="hidden" name="contactMechPurposeTypeId" id="contactMechPurposeTypeId" value="SHIPPING_LOCATION">
            <input type="hidden" name="partyId" id="updateAddress_partyId"
                   value="${request.getParameter('partyId')?if_exists}">
            <table cellspacing="0" class="basic-table">
                <tbody>
                <tr>
                    <td class="label" nowrap>${uiLabelMap.PartyAttentionName}</td>
                    <td>
                        <input type="text" size="50" maxlength="100" name="attnName" 
                               value="${(mechMap.postalAddress.attnName)?default(request.getParameter('attnName')?if_exists)}"/>
                    </td>
                </tr>
                <tr>
                    <td class="label" nowrap>收件人电话</td>
                    <td>
                        <input type="text" maxlength="11" class="new-input" name="mobileExd" id="address_mobile" value="${(postalAddress.mobileExd)!}">
                    </td>
                </tr>
                <tr>
                    <td class="label" nowrap>地区</td>
                    <td>
                        <#if postalAddress??&&postalAddress.stateProvinceGeoId??>
							<#assign geo = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.stateProvinceGeoId})>
						</#if>
						<select name="stateProvinceGeoId" id="address_province" class="new-select" style="width:100px;" onchange="getArea(this, '', 'address_city', 'address_area')">
		                	<option value="">请选择</option>
		                	<#assign stateAssocs = Static["org.ofbiz.system.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
							<#list stateAssocs as stateAssoc>
								<option <#if (postalAddress.stateProvinceGeoId)?? && postalAddress.stateProvinceGeoId==stateAssoc.geoId>selected</#if> value="${stateAssoc.geoId}">${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
							</#list>
		                </select>
		                <#if (postalAddress.stateProvinceGeoId)??>
							<#assign cityAssocs = delegator.findByAnd("GeoAssoc",{"geoId":postalAddress.stateProvinceGeoId})/>
						</#if>
						<#if (postalAddress.cityGeoId)??>
							<#assign geoCity = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.cityGeoId})/>
						</#if>
						<select name="cityGeoId" id="address_city" class="new-select" style="width:100px;" onchange="getArea(this, '', 'address_area', 'null')">
		                	<#if cityAssocs??>
								<#list cityAssocs as cityAssoc>
									<#assign city = delegator.findByPrimaryKey("Geo",{"geoId":cityAssoc.geoIdTo})/>
									<option <#if (postalAddress.cityGeoId)?? && postalAddress.cityGeoId==city.geoId>selected</#if> value="${city.geoId}">${city.geoName?default(city.geoId)}</option>
								</#list>
							</#if>
		            	</select>
		            	<#if (postalAddress.cityGeoId)??>
							<#assign countyAssocs = delegator.findByAnd("GeoAssoc",{"geoId":postalAddress.cityGeoId})/>
						</#if>
						<#if (postalAddress.countyGeoId)??>
							<#assign geoCounty = delegator.findByPrimaryKey("Geo",{"geoId":postalAddress.countyGeoId})/>
						</#if>
						<select class="new-select" name="countyGeoId" id="address_area" style="width:100px;">
		                	<#if countyAssocs??>
								<#list countyAssocs as countyAssoc>
									<#assign county = delegator.findByPrimaryKey("Geo",{"geoId":countyAssoc.geoIdTo})/>
									<option <#if (postalAddress.countyGeoId)?? && postalAddress.countyGeoId==county.geoId>selected</#if> value="${county.geoId}">${county.geoName?default(county.geoId)}</option>
								</#list>
							</#if>
		            	</select>
                    </td>
                </tr>
                <tr>
                    <td class="label" nowrap>${uiLabelMap.PartyAddressLine1} *</td>
                    <td>
                        <input type="text" size="50" maxlength="255" name="address1"
                               value="${(mechMap.postalAddress.address1)?default(request.getParameter('address1')?if_exists)}"/>
                    </td>
                </tr>
                <#--<tr>
                    <td class="label" nowrap>${uiLabelMap.CommonCountry}</td>

                    <td>
                        <select name="countryGeoId" id="editcontactmechform_countryGeoId">
                        ${screens.render("component://common/widget/CommonScreens.xml#countries")}
                        <#if ((mechMap.postalAddress)?exists) && ((mechMap.postalAddress.countryGeoId)?exists)>
                            <#assign defaultCountryGeoId = mechMap.postalAddress.countryGeoId>
                        <#else>
                            <#assign defaultCountryGeoId = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "country.geo.id.default")>
                        </#if>
                            <option selected="selected" value="${defaultCountryGeoId}">
                            <#assign countryGeo = delegator.findOne("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",defaultCountryGeoId), false)>
                                    ${countryGeo.get("geoName",locale)}
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="label" nowrap>${uiLabelMap.PartyCity} *</td>
                    <td>
                        <input type="text" size="50" maxlength="100" name="city"
                               value="${(mechMap.postalAddress.city)?default(request.getParameter('city')?if_exists)}"/>
                    </td>
                </tr>-->
                <tr>
                    <td class="label" nowrap>${uiLabelMap.PartyZipCode} *</td>
                    <td>
                        <input type="text" size="30" maxlength="60" name="postalCode"
                               value="${(mechMap.postalAddress.postalCode)?default(request.getParameter('postalCode')?if_exists)}"/>
                    </td>
                </tr>
                </tbody>
            </table>
     <div class="easyDialog_footer">
   	<a href="javascript:easyDialog.close();" class="btn_normal">${uiLabelMap.CommonGoBack}</a>
    <#--<a href="javascript:document.editcontactmechform.submit()" class="btn_highlight">${uiLabelMap.CommonSave}</a>-->
    <input value="${uiLabelMap.CommonSave}" type="submit" class="btn_highlight"/>
    </div>
    </form>
</div>

<script>
/*
var $ = function(){
	return document.getElementById(arguments[0]);
};
*/
var btnFn = function( e ){
	alert( e.target );
	return false;
};
$('#user_Address').bind("click",function(){
	easyDialog.open({
		container : {
			header : '${uiLabelMap.PortalUserAddressManagement}',
			content : $('#imgBox').html()
		}
	});
	if(testedit==0){
		document.getElementsByName('editcontactmechform')[1].reset();
	}
	testedit=0;
});
var testedit=0;
function edite(id){
document.getElementById('user_Address').onclick();
document.getElementsByName('editcontactmechform')[1].action='/portal/control/user_checkoutupdateAddress';
for(var i in addresslist[id]){
	document.getElementsByName(i)[1].value=addresslist[id][i];
}
testedit=1;
}
function checkform(){
	var a= document.getElementsByName('shipping_contact_mech_id').length
	if(a<1){
	 alert("需要新建一个收货地址！");
	 return false;
	}
}
	// 设置省县市,传入出发的对象this,请求地址,表单ID,替换内容的name
	function getArea(thisObj, url, replaceDivId, childAreaDiv) {
		$.ajax({
			url:'ajaxArea',
			type:'POST',
			data:{parentId:thisObj.value},
			success:function(r){
				if ( r.areaList ) {
					var areaList = r.areaList;
					var optStr = '<option value="">请选择</option>';
					$.each(areaList,function(i,obj){
						optStr += '<option value="'+obj.geoId+'">'+obj.geoName+'</option>';
					});
					$(thisObj).next().html(optStr);
					if(childAreaDiv=='null'){}else{
						$(thisObj).next().next().html('');
					}
				}
			}
		});
	}
	var existsShippingContactMechId = undefined;
	<#if shoppingCartMap??>
		<#assign existsShippingContactMechId = shoppingCartMap.getShippingContactMechId()?if_exists/>
		<#if existsShippingContactMechId??>
			existsShippingContactMechId = '${existsShippingContactMechId}';
		</#if>
	</#if>
	function checkThis(obj){
		if(!existsShippingContactMechId || existsShippingContactMechId!=obj.value){
			$.ajax({
				url:'setShippingContactMechId',
				type:'post',
				data:{shippingContactMechId:obj.value},
				success:function(r){
					if(r.info){
						alert(r.info);
					}else{
						location.reload();
					}
				}
			});
		}
	}
</script>
        
    </div>
