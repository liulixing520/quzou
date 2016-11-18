<#-- variable setup -->
<#assign price = priceMap?if_exists />
<#assign productImageList = productImageList?if_exists />

<#assign optProduct = optProductMap?if_exists />


<#-- virtual product javascript -->
${virtualJavaScript?if_exists}
${virtualVariantJavaScript?if_exists}

<script type="text/javascript">
//<![CDATA[
    var detailImageUrl = null;
    function setAddProductId(name) {
        document.addform.add_product_id.value = name;
        if (document.addform.quantity == null) return;
        if (name == '' || name == 'NULL' || isVirtual(name) == true) {
            document.addform.quantity.disabled = true;
            var elem = document.getElementById('product_id_display');
            var txt = document.createTextNode('');
            if(elem.hasChildNodes()) {
                elem.replaceChild(txt, elem.firstChild);
            } else {
                elem.appendChild(txt);
            }
        } else {
            document.addform.quantity.disabled = false;
            var elem = document.getElementById('product_id_display');
            var txt = document.createTextNode(name);
            if(elem.hasChildNodes()) {
                elem.replaceChild(txt, elem.firstChild);
            } else {
                elem.appendChild(txt);
            }
        }
    }
    function setVariantPrice(sku) {
        if (sku == '' || sku == 'NULL' || isVirtual(sku) == true) {
            var elem = document.getElementById('variant_price_display');
            var txt = document.createTextNode('');
            if(elem.hasChildNodes()) {
                elem.replaceChild(txt, elem.firstChild);
            } else {
                elem.appendChild(txt);
            }
        }
        else {
            var elem = document.getElementById('variant_price_display');
            var price = getVariantPrice(sku);
            var txt = document.createTextNode(price);
            if(elem.hasChildNodes()) {
                elem.replaceChild(txt, elem.firstChild);
            } else {
                elem.appendChild(txt);
            }
        }
    }
    function isVirtual(product) {
        var isVirtual = false;
        <#if virtualJavaScript?exists>
        for (i = 0; i < VIR.length; i++) {
            if (VIR[i] == product) {
                isVirtual = true;
            }
        }
        </#if>
        return isVirtual;
    }
    function addItem() {
       if (document.addform.add_product_id.value == 'NULL') {
           showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllRequiredOptions}");
           return;
       } else {
           if (isVirtual(document.addform.add_product_id.value)) {
               document.location = '<@ofbizUrl>product?category_id=${categoryId?if_exists}&amp;product_id=</@ofbizUrl>' + document.addform.add_product_id.value;
               return;
           } else {
               document.addform.submit();
           }
       }
    }

    function popupDetail(specificDetailImageUrl) {
        if( specificDetailImageUrl ) {
            detailImageUrl = specificDetailImageUrl;
        }
        else {
            var defaultDetailImage = "${firstDetailImage?default(mainDetailImageUrl?default("_NONE_"))}";
            if (defaultDetailImage == null || defaultDetailImage == "null" || defaultDetailImage == "") {
               defaultDetailImage = "_NONE_";
            }

            if (detailImageUrl == null || detailImageUrl == "null") {
                detailImageUrl = defaultDetailImage;
            }
        }

        if (detailImageUrl == "_NONE_") {
            hack = document.createElement('span');
            hack.innerHTML="${uiLabelMap.CommonNoDetailImageAvailableToDisplay}";
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonNoDetailImageAvailableToDisplay}");
            return;
        }
        detailImageUrl = detailImageUrl.replace(/\&\#47;/g, "/");
        popUp("<@ofbizUrl>detailImage?detail=" + detailImageUrl + "</@ofbizUrl>", 'detailImage', '600', '600');
    }

    function toggleAmt(toggle) {
        if (toggle == 'Y') {
            changeObjectVisibility("add_amount", "visible");
        }

        if (toggle == 'N') {
            changeObjectVisibility("add_amount", "hidden");
        }
    }

    function findIndex(name) {
        for (i = 0; i < OPT.length; i++) {
            if (OPT[i] == name) {
                return i;
            }
        }
        return -1;
    }

    function getList(name, index, src) {
        currentFeatureIndex = findIndex(name);

        if (currentFeatureIndex == 0) {
            // set the images for the first selection
            if (IMG[index] != null) {
                if (document.images['mainImage'] != null) {
                    document.images['mainImage'].src = IMG[index];
                    detailImageUrl = DET[index];
                }
            }

            // set the drop down index for swatch selection
            document.forms["addform"].elements[name].selectedIndex = (index*1)+1;
        }

        if (currentFeatureIndex < (OPT.length-1)) {
            // eval the next list if there are more
            var selectedValue = document.forms["addform"].elements[name].options[(index*1)+1].value;
            if (index == -1) {
              <#if featureOrderFirst?exists>
                var Variable1 = eval("list" + "${featureOrderFirst}" + "()");
              </#if>
            } else {
                var Variable1 = eval("list" + OPT[(currentFeatureIndex+1)] + selectedValue + "()");
            }
            // set the product ID to NULL to trigger the alerts
            setAddProductId('NULL');

            // set the variant price to NULL
            setVariantPrice('NULL');
        } else {
            // this is the final selection -- locate the selected index of the last selection
            var indexSelected = document.forms["addform"].elements[name].selectedIndex;

            // using the selected index locate the sku
            var sku = document.forms["addform"].elements[name].options[indexSelected].value;
            
            // display alternative packaging dropdown
            ajaxUpdateArea("product_uom", "<@ofbizUrl>ProductUomDropDownOnly</@ofbizUrl>", "productId=" + sku);

            // set the product ID
            setAddProductId(sku);

            // set the variant price
            setVariantPrice(sku);

            // check for amount box
            toggleAmt(checkAmtReq(sku));
        }
    }

    function validate(x){
        var msg=new Array();
        msg[0]="Please use correct date format [yyyy-mm-dd]";

        var y=x.split("-");
        if(y.length!=3){ showAlert(msg[0]);return false; }
        if((y[2].length>2)||(parseInt(y[2])>31)) { showAlert(msg[0]); return false; }
        if(y[2].length==1){ y[2]="0"+y[2]; }
        if((y[1].length>2)||(parseInt(y[1])>12)){ showAlert(msg[0]); return false; }
        if(y[1].length==1){ y[1]="0"+y[1]; }
        if(y[0].length>4){ showAlert(msg[0]); return false; }
        if(y[0].length<4) {
            if(y[0].length==2) {
                y[0]="20"+y[0];
            } else {
                showAlert(msg[0]);
                return false;
            }
        }
        return (y[0]+"-"+y[1]+"-"+y[2]);
    }

    function showAlert(msg){
        showErrorAlert("${uiLabelMap.CommonErrorMessage2}", msg);
    }

    function additemSubmit(){
        <#if product.productTypeId?if_exists == "ASSET_USAGE" || product.productTypeId?if_exists == "ASSET_USAGE_OUT_IN">
        newdatevalue = validate(document.addform.reservStart.value);
        if (newdatevalue == false) {
            document.addform.reservStart.focus();
        } else {
            document.addform.reservStart.value = newdatevalue;
            document.addform.submit();
        }
        <#else>
        document.addform.submit();
        </#if>
    }

    function addShoplistSubmit(){
        <#if product.productTypeId?if_exists == "ASSET_USAGE" || product.productTypeId?if_exists == "ASSET_USAGE_OUT_IN">
        if (document.addToShoppingList.reservStartStr.value == "") {
            document.addToShoppingList.submit();
        } else {
            newdatevalue = validate(document.addToShoppingList.reservStartStr.value);
            if (newdatevalue == false) {
                document.addToShoppingList.reservStartStr.focus();
            } else {
                document.addToShoppingList.reservStartStr.value = newdatevalue;
                // document.addToShoppingList.reservStart.value = ;
                document.addToShoppingList.reservStartStr.value.slice(0,9)+" 00:00:00.000000000";
                document.addToShoppingList.submit();
            }
        }
        <#else>
        document.addToShoppingList.submit();
        </#if>
    }

    <#if product.virtualVariantMethodEnum?if_exists == "VV_FEATURETREE" && featureLists?has_content>
        function checkRadioButton() {
            var block1 = document.getElementById("addCart1");
            var block2 = document.getElementById("addCart2");
            <#list featureLists as featureList>
                <#list featureList as feature>
                    <#if feature_index == 0>
                        var myList = document.getElementById("FT${feature.productFeatureTypeId}");
                         if (myList.options[0].selected == true){
                             block1.style.display = "none";
                             block2.style.display = "block";
                             return;
                         }
                        <#break>
                    </#if>
                </#list>
            </#list>
            block1.style.display = "block";
            block2.style.display = "none";
        }
    </#if>
    
    function displayProductVirtualVariantId(variantId) {
        if(variantId){
            document.addform.product_id.value = variantId;
        }else{
            document.addform.product_id.value = '';
            variantId = '';
        }
        
        var elem = document.getElementById('product_id_display');
        var txt = document.createTextNode(variantId);
        if(elem.hasChildNodes()) {
            elem.replaceChild(txt, elem.firstChild);
        } else {
            elem.appendChild(txt);
        }
        
        var priceElem = document.getElementById('variant_price_display');
        var price = getVariantPrice(variantId);
        var priceTxt = null;
        if(price){
            priceTxt = document.createTextNode(price);
        }else{
            priceTxt = document.createTextNode('');
        }
        if(priceElem.hasChildNodes()) {
            priceElem.replaceChild(priceTxt, priceElem.firstChild);
        } else {
            priceElem.appendChild(priceTxt);
        }
    }
//]]>
$(function(){
    $('a[id^=productTag_]').click(function(){
        var id = $(this).attr('id');
        var ids = id.split('_');
        var productTagStr = ids[1];
        if (productTagStr) {
            $('#productTagStr').val(productTagStr);
            $('#productTagsearchform').submit();
        }
    });
})
 </script>
 
 
<#macro showUnavailableVarients>
  <#if unavailableVariants?exists>
    <ul>
      <#list unavailableVariants as prod>
        <#assign features = prod.getRelated("ProductFeatureAppl", null, null, false)/>
        <li>
          <#list features as feature>
            <em>${feature.getRelatedOne("ProductFeature", false).description}</em><#if feature_has_next>, </#if>
          </#list>
          <span>${uiLabelMap.ProductItemOutOfStock}</span>
        </li>
      </#list>
    </ul>
  </#if>
</#macro>


<!-- 商品基本信息 显示 -->
      <div class="col-main">
        <div class="main-wrap util-clearfix">
          <h1 class="product-name" itemprop="name">
          <!-- 商品名称-->
          <font><h2>${productContentWrapper.get("PRODUCT_NAME")?if_exists}</h2>
           </font>
          </h1>
           
          <div class="product-star-order"> <span id="product-star" class="product-star"> <span class="ui-rating"> <span class="ui-rating-star"> <span style="width:99.0%;"><font>额定 </font><span><font>4.9 </font></span><font>/ 5的基础上 </font><span><font>59 </font></span><font>顾客评论 </font></span> </span> </span> <b><font>100.0% </font></b><font>的买家喜欢这个产品! (59票) </font></span> <span class="orders-count"> <b><font>216 </font></b><font>订单 </font></span> </div>
          <div class="product-info-wrap">
           <div class="product-info">
           
            <!-- <form action="" class="buy-now-form" id="buy-now-form" name="buyNowForm"> -->
            
            <form  method="post" action="<@ofbizUrl>additem</@ofbizUrl>" name="addform"  style="margin: 0;">
                
                 <!--  123456789 --> 
                 <#assign inStock  = true />
		            <#assign commentEnable = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("order.properties", "order.item.comment.enable")>
		            <!--  <#if commentEnable.equals("Y")>
		                <#assign orderItemAttr = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("order.properties", "order.item.attr.prefix")>
		                ${uiLabelMap.CommonComment}&nbsp;<input type="text" name="${orderItemAttr}comment"/>
		            </#if> -->  
		            <#-- Variant Selection --> 
		            <#if product.isVirtual?if_exists?upper_case == "Y">
		              <#if product.virtualVariantMethodEnum?if_exists == "VV_FEATURETREE" && featureLists?has_content>
		                <#list featureLists as featureList>
		                    <#list featureList as feature>
		                        <#if feature_index == 0>
		                            <div>${feature.description}: <select id="FT${feature.productFeatureTypeId}" name="FT${feature.productFeatureTypeId}" onchange="javascript:checkRadioButton();">
		                            <option value="select" selected="selected">${uiLabelMap.EcommerceSelectOption}</option>
		                        <#else>
		                            <option value="${feature.productFeatureId}">${feature.description} <#if feature.price?exists>(+ <@ofbizCurrency amount=feature.price?string isoCode=feature.currencyUomId />)</#if></option>
		                        </#if>
		                    </#list>
		                    </select>
		                    </div>
		                </#list>
		                  <input type="hidden" name="add_product_id" value="${product.productId}" />
		                <div id="addCart1" style="display:none;">
		                  <span style="white-space: nowrap;"><strong>${uiLabelMap.CommonQuantity}:</strong></span>&nbsp;
		                  <input type="text" size="5" name="quantity" value="1" />
		                  <a href="javascript:javascript:addItem();" class="buttontext"><span style="white-space: nowrap;">${uiLabelMap.OrderAddToCart}</span></a>
		                  &nbsp;
		                </div>
		                <div id="addCart2" style="display:block;">
		                  <span style="white-space: nowrap;"><strong>${uiLabelMap.CommonQuantity}:</strong></span>&nbsp;
		                  <input type="text" size="5" value="1" disabled="disabled" />
		                  <a href="javascript:showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllFeaturesFirst}");" class="buttontext"><span style="white-space: nowrap;">${uiLabelMap.OrderAddToCart}</span></a>
		                  &nbsp;
		                </div>
		              </#if>
		              <#if !product.virtualVariantMethodEnum?exists || product.virtualVariantMethodEnum == "VV_VARIANTTREE">
		               <#if variantTree?exists && (variantTree.size() &gt; 0)>
		                <#list featureSet as currentType>
		                  <div>
		                    <select name="FT${currentType}" onchange="javascript:getList(this.name, (this.selectedIndex-1), 1);">
		                      <option>${featureTypes.get(currentType)}</option>
		                    </select>
		                  </div>
		                </#list>
		                <span id="product_uom"></span>
		                <input type="hidden" name="product_id" value="${product.productId}"/>
		                <input type="hidden" name="add_product_id" value="NULL"/>
		                <div>
		                  <strong><span id="product_id_display"> </span></strong>
		                  <strong><div id="variant_price_display"> </div></strong>
		                </div>
		              <#else>
		                <input type="hidden" name="add_product_id" value="NULL"/>
		                <#assign inStock = false />
		              </#if>
		             </#if>
		            <#else>
		              <input type="hidden" name="add_product_id" value="${product.productId}" />
		              <#if mainProducts?has_content>
		                <input type="hidden" name="product_id" value=""/>
		                <select name="productVariantId" onchange="javascript:displayProductVirtualVariantId(this.value);">
		                    <option value="">Select Unit Of Measure</option>
		                    <#list mainProducts as mainProduct>
		                        <option value="${mainProduct.productId}">${mainProduct.uomDesc} : ${mainProduct.piecesIncluded}</option>
		                    </#list>
		                </select><br/>
		                <div>
		                  <strong><span id="product_id_display"> </span></strong>
		                  <strong><div id="variant_price_display"> </div></strong>
		                </div>
		              </#if>
		              <#if (availableInventory?exists) && (availableInventory <= 0)>
		                <#assign inStock = false />
		              </#if>
		            </#if>
               <!--  123456789 -->
                
                <input type="hidden" name="objectId" value="2030389613">
                <input type="hidden" value="wholesaleProduct">
                <input type="hidden" name="from" value="aliexpress">
                <input type="hidden" name="countryCode" value="US" id="hid-country-code">
                <input type="hidden" name="shippingCompany" value="SGP" id="hid-shipping-company">
                <input type="hidden" name="" id="objectStockpile" value="">
                <input type="hidden" name="aeOrderFrom" value="main_detail">
                <input type="hidden" id="hid-product-id" value="2030389613">
                <!-- esi -->
                <div id="product-info-price-pnl">
                  <input type="hidden" id="sku-price-store" autocomplete="off">
                  <input type="hidden" id="bulk-order-store">
                  <input type="hidden" id="act-sku-bulk-price-store">
                  <dl class="product-info-current">
                    <dt>                            
                    <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-137" rel="137">价格: </font></dt>
                    <dd>
                      <div class="current-price">
					                  <#-- for prices:
                  - if price < competitivePrice, show competitive or "Compare At" price
                  - if price < listPrice, show list price
                  - if price < defaultPrice and defaultPrice < listPrice, show default
                  - if isSale show price with salePrice style and print "On Sale!"
                     -->
		          <#if price.competitivePrice?exists && price.price?exists && price.price &lt; price.competitivePrice>
		           <div>${uiLabelMap.ProductCompareAtPrice}: <span class="basePrice"><@ofbizCurrency amount=price.competitivePrice isoCode=price.currencyUsed /></span></div>
		         </#if>
		          <#if price.listPrice?exists && price.price?exists && price.price &lt; price.listPrice>
		          <div>${uiLabelMap.ProductListPrice}: <span class="basePrice"><@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed /></span></div>
		          </#if>
		          <#if price.listPrice?exists && price.defaultPrice?exists && price.price?exists && price.price &lt; price.defaultPrice && price.defaultPrice &lt; price.listPrice>
		         <div>${uiLabelMap.ProductRegularPrice}: <span class="basePrice"><@ofbizCurrency amount=price.defaultPrice isoCode=price.currencyUsed /></span></div>
		        </#if>
		          <#if price.specialPromoPrice?exists>
		            <div>${uiLabelMap.ProductSpecialPromoPrice}: <span class="basePrice"><@ofbizCurrency amount=price.specialPromoPrice isoCode=price.currencyUsed /></span></div>
		           </#if>

				  
                      <!-- <div id="product-price" class="ui-cost notranslate"> <b> <span>
                        <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-138" rel="138">美元 </font></span><span id="sku-price"><span itemprop="lowPrice">
                        <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-139" rel="139">86.99 </font></span>
                        <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-140" rel="140">- - - - - - </font><span itemprop="highPrice">
                        <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-141" rel="141">91.99 </font></span></span> </b>
                        <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-142" rel="142"> /块 </font></div>
                        <div class="unit-disc sub-info"> </div>
                      </div> -->
					  
					  
					<div id="product-price" class="ui-cost notranslate">
		             <strong>
		              <#if price.isSale?exists && price.isSale>
		              <span  class="salePrice">${uiLabelMap.OrderOnSale}!</span>
		                <#assign priceStyle = "salePrice" />
		              <#else>
		                <#assign priceStyle = "regularPrice" />
		              </#if>
	                 
                 <#if "Y" = product.isVirtual?if_exists> ${uiLabelMap.CommonFrom} </#if><span class="${priceStyle}"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed /></span>
                 <#if product.productTypeId?if_exists == "ASSET_USAGE" || product.productTypeId?if_exists == "ASSET_USAGE_OUT_IN">
                <#if product.reserv2ndPPPerc?exists && product.reserv2ndPPPerc != 0><br /><span class="${priceStyle}">${uiLabelMap.ProductReserv2ndPPPerc}<#if !product.reservNthPPPerc?exists || product.reservNthPPPerc == 0>${uiLabelMap.CommonUntil} ${product.reservMaxPersons?if_exists}</#if> <@ofbizCurrency amount=product.reserv2ndPPPerc*price.price/100 isoCode=price.currencyUsed /></span></#if>
                <#if product.reservNthPPPerc?exists &&product.reservNthPPPerc != 0><br /><span class="${priceStyle}">${uiLabelMap.ProductReservNthPPPerc} <#if !product.reserv2ndPPPerc?exists || product.reserv2ndPPPerc == 0>${uiLabelMap.ProductReservSecond} <#else> ${uiLabelMap.ProductReservThird} </#if> ${uiLabelMap.CommonUntil} ${product.reservMaxPersons?if_exists}, ${uiLabelMap.ProductEach}: <@ofbizCurrency amount=product.reservNthPPPerc*price.price/100 isoCode=price.currencyUsed /></span></#if>
                <#if (!product.reserv2ndPPPerc?exists || product.reserv2ndPPPerc == 0) && (!product.reservNthPPPerc?exists || product.reservNthPPPerc == 0)><br />${uiLabelMap.ProductMaximum} ${product.reservMaxPersons?if_exists} ${uiLabelMap.ProductPersons}.</#if>
                 </#if>
		             </strong>
		          </div>
		          <#if price.listPrice?exists && price.price?exists && price.price &lt; price.listPrice>
		            <#assign priceSaved = price.listPrice - price.price />
		            <#assign percentSaved = (priceSaved / price.listPrice) * 100 />
		            <div>${uiLabelMap.OrderSave}: <span class="basePrice"><@ofbizCurrency amount=priceSaved isoCode=price.currencyUsed /> (${percentSaved?int}%)</span></div>
		          </#if>
		          <#-- show price details ("showPriceDetails" field can be set in the screen definition) -->
		          <#if (showPriceDetails?exists && showPriceDetails?default("N") == "Y")>
		              <#if price.orderItemPriceInfos?exists>
		                  <#list price.orderItemPriceInfos as orderItemPriceInfo>
		                      <div>${orderItemPriceInfo.description?if_exists}</div>
		                  </#list>
		              </#if>
		          </#if>  
					  
					  
					  
					  
					  
					  
					  
                      <div class="price-sub-info"> </div>
                    </dd>
                  </dl>
                </div>
                <div class="product-info-operation">
                  <dl class="product-info-shipping">
                    <dt><font>运输: </font></dt>
                    <dd>
                      <div id="product-info-shipping" class="product-info-shipping-pnl util-clearfix 

notranslate" data-widget-cid="widget-13"> <span id="shipping-cost"><span class="shipping-cost"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-144" rel="144">免费送货 </font></span><span class="shipping-to"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-145" rel="145">来 </font></span></span> <a id="shipping-link" class="shipping-link" rel="nofollow" href="javascript:void(0);" tabindex="-1"><span id="shipping-country"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-146" rel="146">俄罗斯 </font></span> <span class="shipping-via"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-147" rel="147">通过 </font></span> <span id="shipping-company"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-148" rel="148">EMS</font></span></a> </div>
                      <div id="product-info-shipping-sub" class="sub-info" style="display: block;"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-149" rel="149">预计交货时间: </font><span id="shipping-delivery-day"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-150" rel="150">15-60 </font></span><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-151" rel="151">天(船在4个工作日) </font></div>
                    </dd>
                  </dl>
                  <div id="product-info-sku" data-widget-cid="widget-11">
                    <dl class="product-info-size">
                      <dt class="pp-dt-ln sku-title"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-152" rel="152">
                      
                                <#-- example of showing a certain type of feature with the product -->
          <#if sizeProductFeatureAndAppls?has_content>
           
              <#if (sizeProductFeatureAndAppls?size == 1)>
               ${uiLabelMap.OrderSizeAvailableSingle}:
              <#else>
               ${uiLabelMap.OrderSizeAvailableMultiple}:
              </#if>
              </font></dt>
                      <dd>
                        <ul id="sku-sku2" class="sku-attr sku-checkbox">
                          <#list sizeProductFeatureAndAppls as sizeProductFeatureAndAppl>
                      <li><a class="sku-value attr-checkbox" id="sku-1-200003982" href="javascript:void(0)"><span><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-153" rel="153">
                        ${sizeProductFeatureAndAppl.description?default(sizeProductFeatureAndAppl.abbrev?default(sizeProductFeatureAndAppl.productFeatureId))}
                      <#if sizeProductFeatureAndAppl_has_next> </#if></font></span></a></li>
	              </#list>	   
	          </#if>       
                         <!--<li><a class="sku-value attr-checkbox" id="sku-1-200003982" href="javascript:void

(0)"><span><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-153" rel="153">标准与礼物 </font></span></a></li>
                          <li><a class="sku-value attr-checkbox" id="sku-1-200003983" href="javascript:void

(0)"><span><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-154" rel="154">添加前开放的情况下 </font></span></a></li>
                          <li><a class="sku-value attr-checkbox" id="sku-1-200003984" href="javascript:void

(0)"><span><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-155" rel="155">添加侧开放的情况下 </font></span></a></li> -->

                        </ul>
                        <div class="msg-error sku-msg-error" style="display:none;"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-156" rel="156"> 请选择一个包 </font></div>
                      </dd>
                    </dl>
                    <dl class="product-info-size">
                      <dt class="pp-dt-ln sku-title"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-157" rel="157"> 颜色: </font></dt>
                      <dd>
                        <ul id="sku-sku3" class="sku-attr sku-checkbox">
                          <li><a class="sku-value attr-checkbox" id="sku-2-29" href="javascript:void

(0)"><span><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-158" rel="158">白色的 </font></span></a></li>
                          <li><a class="sku-value attr-checkbox" id="sku-2-193" href="javascript:void

(0)"><span><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-159" rel="159">黑色的 </font></span></a></li>
                        </ul>
                        <div class="msg-error sku-msg-error" style="display:none;"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-160" rel="160"> 请选择一个颜色 </font></div>
                      </dd>
                    </dl>
                  </div>
                  <dl id="product-info-quantity" class="product-info-quantity" data-widget-cid="widget-12">
                    <dt><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-161" rel="161">
                    
                                              
             <!--  123456789 -->
             <!--  123456789 -->
   
                      <span>数量: </font></dt>
                    <dd>
                       <!-- <input name="quantity" id="quantity" value="1" size="4" maxLength="4" type="text" <#if product.isVirtual!?upper_case == "Y">disabled="disabled"</#if> /></span> -->
                      <input id="product-info-txt-quantity" name="quantity" id="quantity" type="number" value="1" min="1" max="9999" maxlength="5" class="ui-textfield ui-textfield-system" autocomplete="off">
                      <span id="product-info-unit" class="lbl-unit sub-info"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-162" rel="162">块 </font></span>
                      <input type="hidden" id="oddUnitName_id" value="piece">
                      <input type="hidden" id="multiUnitName_id" value="pieces">
                    </dd>
                  </dl>

                  <div class="product-info-action">
                  

                   <div class="buy-now">
                         <a id="buy-now" class="buy-now-btn" href="#" tabindex="-1" data-widget-cid="widget-17">
                        <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-169" rel="169">现在购买 </font></a>
                        <a id="add-to-cart" class="add-to-cart-btn" href="#">
                          <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-170" rel="170">添加到购物车</a>
                    </span> 


            
            <!--  123456789 -->
            <!--  添加 到购物车     -->
            
                    </div> 
                    
                    
                   
                  </div>
                </div>
                
              
                
              </form>
              
              
              <dl class="store-promotion" style="display:none">
                <dt><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-175" rel="175">商店促销: </font></dt>
                <dd><span id="seller-coupon" data-widget-cid="widget-32"><a class="store-promotion-item"></a>
                  <div id="seller-coupon-result">
                    <div id="sc-result-body"></div>
                    <a href="javascript:;" class="ui-close"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-176" rel="176">关闭 </font></a></div>
                  </span></dd>
              </dl>
              <!-- store promotion coupon and fixeddisscount -->
              <div id="seller-promise-list" data-widget-cid="widget-21" style="display: block;">
                <dl class="return-policy util-clearfix">
                  <dt><font> </font></dt>
                  <dd>
                    <div class="s-serve sp-1"></div>
                  </dd>
                </dl>
                <dl class="s-seller-guarantees util-clearfix" id="serve-guarantees-detail">
                  <dt><font></font></dt>
                  <dd class="util-clearfix">
                    <div class="s-serve sp-5"> <a rel="nofollow" href="" hidefocus="true" target="_blank"><em><font></font></em><span class="sp-brief"><span class="promise-time-cont"><font></font></span><font> </font></span>
                      <div class="ui-balloon ui-balloon-tl"><font></font><i><span class="promise-time-cont"><font>60 </font></span><font>天 </font></i> <span class="ui-balloon-arrow"></span> </div>
                      </a> </div>
                    <div class="s-serve-line"></div>
                    <div class="s-serve sp-2"> <a rel="" hidefocus="true" target="_blank"></span>
                      <div class="ui-balloon ui-balloon-tl"><font></font><i><font></font></i><font></font><span class="ui-balloon-arrow"></span> </div>
                      </a> </div>
                  </dd>
                </dl>
              </div>

            </div>
            
            <!-- wish list args -->
            <input id="usaeServer" name="usaeServer" type="hidden" value="http://us.ae.alibaba.com">
            <input id="transactionbp" name="transactionbp" type="hidden" value="">
            <input id="_csrf_token" name="_csrf_token" type="hidden" value="ag8b10hpz5ov">
            <input type="hidden" id="serverTime" value="1414203651142">
          </div>



			<!-- seller-info-wrap  开始 -->
			<div class="seller-info-wrap">
			    <div class="seller-info">
			 <#if optProduct?has_content  > 
				<div class="seller">
				 <div class="title"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-198" rel="198">店铺：</font></div>
				 
				 <div class="company-name notranslate">
				 <input type="hidden" id="hid_storeId" value="712948">
				  <a class="store-lnk" target="_blank" href="#" title="BlackPeach Digital Co.,LTD"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-199" rel="199">
				  
				  		<#list optProduct   as optProductOut>			
					     <!--  ${optProductOut.storeName} -->
					      ${optProductOut.companyName}
					      <!-- ${optProductOut.title}
					     ${optProductOut.subtitle}	-->
					  </#list></font></a>
				  </div>
				  
				 <address>
				   <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-200" rel="200">中国(大陆)(北京)</font>
				 </address>
				    <input type="hidden" id="hid-feedback-url" value="#">
				 
				<div class="seller-score">
				    <a class="seller-score-lnk" target="_blank" href="#" rel="nofollow" title="Feedback Score 10465">
					<b><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-201" rel="201">2014年</font></b>
				    </a>    
				    <a class="seller-level-lnk" target="_blank" href="#" rel="nofollow">
					<img alt="" src="../images/25-ss.gif" title="This is the Feedback Symbol for Feedback Scores from 10000-19999.">
				    </a>  
				</div>
			</#if>
			
				  
				</div>
			
				<div class="contact">
				 <div class="title"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-206" rel="206">联系卖家</font></div>
				 
				    <a class="contact-mail" target="_blank" href="#?productId=2030389613&amp;messageType=product&amp;memberType=seller&amp;refer=#" 
				     title="Click &quot;Contact Now&quot; to send an inquiry direct to the supplier's Message Center." rel="nofollow">
				     <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-207" rel="207">联系现在</font>
				    </a>
				 
				  <div class="title"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-208" rel="208">卖家在网上</font></div>
				 
				   <div class="im-list-main" id="im-list-main">
					    <div class="im-contact-list ">
						<b><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-209" rel="209">服务中心</font></b>
						<p>
						 <a data-role="atm" data-memberid="8pctgRBMALN1PoP0SVjs6k9h7M1gvR+S" rel="nofollow" href="javascript:;" data-onlinetext="Chris" data-offlinetext="Chris" data-from="11" data-id1="2030389613" data-widget-cid="widget-39" title="Leave me a message" class="atm16grey"><font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-210" rel="210">北京叁角弈</font></a>
						</p>
					    </div>      
				   </div>
			
				</div>
				 </div>
			</div>
			<!-- seller-info-wrap  结束 -->

        </div>
      </div>
      <div class="col-sub">
        <div id="img" class="img-350" data-widget-cid="widget-23">
        
        			<link href="../images/css/base.css" rel="stylesheet" type="text/css" />
					<script type="text/javascript" src="../images/js/jquery-1.4.2.min.js"></script>
					<script type="text/javascript" src="../images/js/jquery.jqzoom.js"></script>
					<script type="text/javascript" src="../images/js/base.js"></script>
					  
           <!--跑马灯的大图片  放大镜的效果  开始 -->
           <div  class="ui-image-viewer" id="magnifier" itemprop="image" data-widget-cid="widget-22">
            <div  id="preview" class="spec-preview">  
                  <span class="jqzoom"> <img jqimg="/images/defaultImage.jpg"  src="/images/defaultImage.jpg" style="width: 350px; height: 262.5px;">
             </div>
            <div  class="ui-image-viewer-loading" style="width: 350px; height: 350px; overflow: hidden; display: none;">
              <div  class="ui-image-viewer-loading-mask"></div>
              <div  class="ui-image-viewer-loading-whirl"></div>
            </div>   
            <!--   跑马灯的大图片  放大镜的效果  End -->
           
            <a class="ui-magnifier-glass" href="" style="width: 232px; height: 232px; position: absolute; left: 117px; top: -1px; display: none;"></a></div>
          <div class="ui-image-viewer-viewport" style="width: 530px; height: 530px; z-index: 99; display: none; position: absolute; left: 362px; top: 0px;" data-widget-cid="widget-45">
            <div class="ui-image-viewer-image-wrap" data-role="imageWrap" style="width: 800px; height: 798px; font-size: 697px; position: absolute; left: -271px; top: -1px;"> <a class="ui-image-viewer-image-frame" href=""><img src="../images/no01.jpg"></a> </div>
          </div>

          <ul class="image-nav util-clearfix">
<li class="image-nav-item">
				      <#assign productAdditionalImage1  = productContentWrapper.get("ADDITIONAL_IMAGE_1")?if_exists /> 
				                <#if productAdditionalImage1?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage1?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage1?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>" src="<@ofbizContentUrl>${productAdditionalImage1?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>				                      
				                    </div>
				                </#if>
				      </span>
				      </li>
				     <li class="image-nav-item"><#assign productAdditionalImage2  = productContentWrapper.get("ADDITIONAL_IMAGE_2")?if_exists /> 
				                <#if productAdditionalImage2?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage2?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage2?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>" src="<@ofbizContentUrl>${productAdditionalImage2?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>
				                    </div>
				                </#if>
				      </span>
				      </li>
				      <li class="image-nav-item"><#assign productAdditionalImage3  = productContentWrapper.get("ADDITIONAL_IMAGE_3")?if_exists /> 
				                <#if productAdditionalImage3?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage3?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage3?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>" src="<@ofbizContentUrl>${productAdditionalImage3?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>
				                    </div>
				                </#if> 
				      </span>
				      </li>
				      <li class="image-nav-item"><#assign productAdditionalImage4  = productContentWrapper.get("ADDITIONAL_IMAGE_4")?if_exists /> 
				                <#if productAdditionalImage4?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage4?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage4?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>"  src="<@ofbizContentUrl>${productAdditionalImage4?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>
				                    </div>
				                </#if> 
				      </span>
				      </li>
				       <li class="image-nav-item"><#assign productAdditionalImage5  = productContentWrapper.get("ADDITIONAL_IMAGE_5")?if_exists /> 
				                <#if productAdditionalImage5?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage5?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage5?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>"  src="<@ofbizContentUrl>${productAdditionalImage5?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>
				                    </div>
				                </#if> 
				      </span>
				      </li>     
				      <li class="image-nav-item"><#assign productAdditionalImage6  = productContentWrapper.get("ADDITIONAL_IMAGE_6")?if_exists /> 
				                <#if productAdditionalImage6?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage6?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage6?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>"  src="<@ofbizContentUrl>${productAdditionalImage6?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>
				                    </div>
				                </#if> 
				      </span>
				      </li>     
				      <li class="image-nav-item"><#assign productAdditionalImage7  = productContentWrapper.get("ADDITIONAL_IMAGE_7")?if_exists /> 
				                <#if productAdditionalImage7?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage7?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage7?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>"  src="<@ofbizContentUrl>${productAdditionalImage7?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>
				                    </div>
				                </#if> 
				      </span>
				      </li>
				      <li class="image-nav-item"><#assign productAdditionalImage8  = productContentWrapper.get("ADDITIONAL_IMAGE_8")?if_exists /> 
				                <#if productAdditionalImage8?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage8?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage8?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>"  src="<@ofbizContentUrl>${productAdditionalImage8?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>
				                    </div>
				                </#if> 
				      </span>
				      </li>
				        <li class="image-nav-item"><#assign productAdditionalImage9  = productContentWrapper.get("ADDITIONAL_IMAGE_9")?if_exists /> 
				                <#if productAdditionalImage9?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage9?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage9?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>"  src="<@ofbizContentUrl>${productAdditionalImage9?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);" /></a>
				                    </div>
				                </#if> 
				      </span>
				      </li>
				        <li class="image-nav-item"><#assign productAdditionalImage10  = productContentWrapper.get("ADDITIONAL_IMAGE_10")?if_exists /> 
				                <#if productAdditionalImage10?string?has_content>
				                    <div class="additionalImage">
				                        <a href="javascript:void(0);" swapDetail="<@ofbizContentUrl>${productAdditionalImage10?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>"><img bimg="<@ofbizContentUrl>${productAdditionalImage10?replace("original.jpeg", "1600x1200.jpeg")}</@ofbizContentUrl>" src="<@ofbizContentUrl>${productAdditionalImage10?replace("original.jpeg", "small.jpeg")}</@ofbizContentUrl>" vspace="5" hspace="5" class="cssImgXLarge" alt="" onmousemove="preview(this);"/></a>
				                    </div>
				                </#if> 
				      </span>
				      </li>
          </ul>
        </div>

      </div>

      
      
      
      
      