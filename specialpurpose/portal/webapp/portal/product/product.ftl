<style>
tr3 .btn a {
    color: #737373;
    display: inline-block;
    font-size: 14px;
    font-weight: bold;
    text-align: center;
    width: 13px;
}
a {
    color: #666;
}
a {
    color: #777;
    text-decoration: none;
    outline: medium none;
}


#feature span, #COLOR span {
    cursor: pointer;
}
.tr3 p span {
    color: #000;
}
.btn {
    cursor: pointer;
}
.tr3 .btn span input {
    width: 57px;
    text-align: center;
    height: 24px;
    margin: 0px 7px;
    line-height: 24px;
}
.border-i {
    border: 1px solid #D6D5D5;
}
article, audio, blockquote, body, button, canvas, caption, code, datalist, dd, details, div, dl, dt, embed, fieldset, figcaption, figure, form, h1, h2, h3, h4, h5, h6, hr, html, input, legend, li, menu, ol, p, pre, section, table, td, textarea, th, tr, ul, video, img {
    margin: 0px;
    padding: 0px;
}
.top .top-right .tr3 .tr3_taste em {
    display: block;
    float: left;
    height: 18px;
    margin-top: 7px;
    overflow: hidden;
    width: 40px;
}
.top em {
    font-style: normal;
}
em {
    font-style: normal;
}
.top .top-right .tr3 .tr3_taste {
    overflow: hidden;
}
	.top .top-right .tr3 .tr3_taste p {
    float: left;
    margin-bottom: 5px;
    width: 747px;
}
.tr3 p {
    margin-bottom: 5px;
}
#feature span, #COLOR span {
    border-radius: 2px;
    cursor: pointer;
}
.tr3 .scolor {
    border: 2px solid #E85E5E;
}
.tr3 p span {
    padding: 4px 8px;
    border: 2px solid #D6D6D6;
    margin: 2px 10px 2px 0px;
    color: #000;
    display: inline-block;
    background-color: #FFF;
}
</style>


<#-- variable setup -->
<#assign price = priceMap?if_exists />
<#assign productImageList = productImageList?if_exists />
<#assign productStore1 = productStore?if_exists />
<#assign baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()/>



<#-- virtual product javascript -->
${virtualJavaScript?if_exists}
${virtualVariantJavaScript?if_exists}
<script type="text/javascript">
                    //判断正整数
					function checkRate(obj){
					  if(isNaN(obj.value)){
						obj.value=(obj.value+"").substr(0,(obj.value+"").length-1);
						if(obj.value.length<1)
						obj.value=1;
						return;
					  }
					  var str = obj.value+"";
					  if(str.indexOf(".")>-1){
					    obj.value=(obj.value+"").substr(0,(obj.value+"").length-1);
					    if(obj.value.length<1)
						obj.value=1;
					    return;
					  }

					 }
	            	function checkRatenull(obj){
	            		if(obj.value.length<1)
						obj.value=1;
	            	}
$(document).ready(function(){
        $(".jqzoom").imagezoom();
        $("#thumblist li a").click(function(){
            $(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
            $(".jqzoom").attr('src',$(this).find("img").attr("src"));
            $(".jqzoom").attr('rel',$(this).find("img").attr("src"));
        });

    });
                    </script>

<script type="text/javascript">

/*
 * 点击购买数量增减
 */
function updateNum(o,productId,defaultPrice,weight,isYCS,supplierPartyId) {
    var id = o.id;
    var reco = parseInt($("#buyNums").attr("quantity"));
    var maxReorder = parseInt($("#buyNums").attr("maxReorder"));
    var aviNum = parseInt($("#inventory").attr("aviNum"));
    var buyNum = parseInt($("#buyNums").val());
    if ("reduce" == $.trim(id)) {
	if (buyNum > reco) {
	    $("#buyNums").attr("value", buyNum - 1);
	    $("#buyNums").val(buyNum - 1);
	    buyNum=buyNum-1;
	}else{
	    $("#feature").find("em[class='red']").html("您所购买的商品不能小于最低限购量！");
	    $("#feature").find("em[class='red']").attr("style", "display:block;");
	    inventoryCompare(aviNum,reco);
	    dishiqi();
	}
    } else if ("add" == $.trim(id)&& aviNum > 0) {
	$("#buyNums").attr("value", buyNum + 1);
	$("#buyNums").val(buyNum + 1);
	buyNum=buyNum+1;
    }
    if (maxReorder==0 && buyNum>aviNum && aviNum> 0) {
	    $("#feature").find("em[class='red']").html("您所填写的商品数量超过库存量！");
	    $("#feature").find("em[class='red']").attr("style", "display:block;");
	    inventoryCompare(aviNum,aviNum);
    	    dishiqi();
	} else if (maxReorder!=0) {
	    if((maxReorder>aviNum ||maxReorder==aviNum) && buyNum>aviNum && aviNum > 0){
		$("#feature").find("em[class='red']").html("您所填写的商品数量超过库存量！");
		$("#feature").find("em[class='red']").attr("style", "display:block;");
		inventoryCompare(aviNum,aviNum);
		dishiqi();
	    }else if(maxReorder<aviNum && buyNum>maxReorder && aviNum > 0){
		$("#feature").find("em[class='red']").html("您所购买的商品不能大于最高限购量！");
		$("#feature").find("em[class='red']").attr("style", "display:block;");
		inventoryCompare(aviNum,maxReorder);
		dishiqi();
	    }
	}
  //运费变量
	var quality = $("#buyNums").val();
	var provinceId = $("#province").attr("value");
	var cityId = $("#city").attr("value");
	var sectionId = $("#section").attr("value");
	$.post("/shipmentcast",
			{'status':'shipcast_select',
			'productId':productId,
			'defaultPrice':defaultPrice,
			'weight':weight,
			'quality':quality,
			'provinceId':provinceId,
			'cityId':cityId,
			'sectionId':sectionId,
			'isYCS':isYCS,
			'supplierPartyId':supplierPartyId
			},
			function(data){
		var jsonObj = eval("("+data+")");
		var shipmentCast = jsonObj.shipmentCast;
		$("#shipmentCast").html("快递：￥"+shipmentCast);
	});
}

function dishiqi(){
    var t = 2;
    setInterval(function() {
	if (t == 1) {
	    $("#feature").find("em[class='red']").attr("style", "display:none;");
	}
	t--;
    }, 1000); //启动1秒定时
}

function inventoryCompare(aviNum,num){
    if(!aviNum>num){
	$("#buyNums").attr("value",aviNum);
	$("#buyNums").val(aviNum);
    }else{
	$("#buyNums").attr("value",num);
	$("#buyNums").val(num);
    }
    if($("#inventory").attr("expire")!="Y" && $("#inventory").attr("activityStart")!="N"){
	if(aviNum>0){
	    $("#inventory").attr("avilable", "Y");
	    $("#purchaseNow").attr("class", "icon-iocn_27");
	    $("#addCartItem").attr("class", "icon-iocn_29");
	}else{
	    $("#inventory").html("抢光了");
	    $("#inventory").attr("aviNum", 0);
	    $("#purchaseNow").attr("class", "iocn_142");
	    $("#addCartItem").attr("class", "iocn_143");
	}
    }else{
	if(aviNum>0){
	    $("#inventory").html(aviNum + " ");
	    $("#inventory").attr("aviNum", aviNum);
	    $("#purchaseNow").attr("class", "iocn_142");
	    $("#addCartItem").attr("class", "iocn_143");
	}else{
	    $("#inventory").html("抢光了");
	    $("#inventory").attr("aviNum", 0);
	    $("#purchaseNow").attr("class", "iocn_142");
	    $("#addCartItem").attr("class", "iocn_143");
	}
    }

}
/**手动输入购买数量*/
function buyNumChange(o) {
    // the min reorder num
    var reco = $("#" + o.id).attr("quantity");
    //the max reorder num
    var maxReorder = parseInt($("#buyNums").attr("maxReorder"));
    //the product's inventory num
    var aviNum = parseInt($("#inventory").attr("aviNum"));
    // the input's num
    var buyNum = parseInt($("#buyNums").val());
    var reg = /^[1-9]\d*$|^0$/;
    if (reg.test($("#buyNums").val()) == true) {
	if(maxReorder==0 && aviNum>0){
	    if(buyNum<reco){
		$("#feature").find("em[class='red']").html("您所购买的商品不能小于最低限购量！");
		$("#feature").find("em[class='red']").attr("style", "display:block;");
		inventoryCompare(aviNum,reco);
		dishiqi();
	    }else if(buyNum>aviNum){
		$("#buyNums").attr("value",aviNum);
		$("#buyNums").val(aviNum);
		$("#feature").find("em[class='red']").html("您所填写的商品数量超过库存量！");
		$("#feature").find("em[class='red']").attr("style", "display:block;");
		inventoryCompare(aviNum,aviNum);
		dishiqi();
	    }
	}else if(maxReorder!=0 && aviNum>0){
	    if(maxReorder>aviNum){//抢光了
		if(buyNum<reco){
			$("#feature").find("em[class='red']").html("您所购买的商品不能小于最低限购量！");
			$("#feature").find("em[class='red']").attr("style", "display:block;");
			inventoryCompare(aviNum,reco);
			dishiqi();
		    }else if(buyNum>aviNum){
			$("#feature").find("em[class='red']").html("您所填写的商品数量超过库存量！");
			$("#feature").find("em[class='red']").attr("style", "display:block;");
			inventoryCompare(aviNum,aviNum);
			dishiqi();
		    }
	    }else{//低于最大购买
		if(buyNum<reco){
			$("#feature").find("em[class='red']").html("您所购买的商品不能小于最低限购量！");
			$("#feature").find("em[class='red']").attr("style", "display:block;");
			inventoryCompare(aviNum,reco);
			dishiqi();
		    }else if(buyNum>maxReorder){
			$("#feature").find("em[class='red']").html("您所购买的商品不能大于最高限购量！");
			$("#feature").find("em[class='red']").attr("style", "display:block;");
			inventoryCompare(aviNum,maxReorder);
			dishiqi();
		    }
	    }

	}
    } else {
	$("#buyNums").val(reco);
	buyNumChange($("#buyNums")[0]);
    }
    $("#buyNums").attr("value", $("#buyNums").val());
}

function changeAtt(t) {
	t.lastChild.checked='checked';
	for (var i = 0; i<t.parentNode.childNodes.length;i++) {

	        if (t.parentNode.childNodes[i].className == 'cattsel') {
	           t.parentNode.childNodes[i].className = '';
	        }
	    }

	t.className = "cattsel";
	}

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
           var  fromPartyIdVal =$("#fromPartyId").val();
           if(fromPartyIdVal) {
                addItemproduct();
           }else{
           	   document.addform.action="<@ofbizUrl>login</@ofbizUrl>";
               document.addform.submit();
           }
    }
    function addItemproduct(){
     if (document.addform.add_product_id.value == 'NULL') {
           showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllRequiredOptions}");
           return;
       } else {
           if (isVirtual(document.addform.add_product_id.value)) {
               document.location = '<@ofbizUrl>product?category_id=${categoryId?if_exists}&amp;product_id=</@ofbizUrl>' + document.addform.add_product_id.value;
               return;
           } else {
               document.addform.action="<@ofbizUrl>additem</@ofbizUrl>";
               document.addform.submit();
           }
       }
    }
    function addItemBuy() {
       if (document.addform.add_product_id.value == 'NULL') {
           showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllRequiredOptions}");
           return;
       } else {
           if (isVirtual(document.addform.add_product_id.value)) {
               document.location = '<@ofbizUrl>product?category_id=${categoryId?if_exists}&amp;product_id=</@ofbizUrl>' + document.addform.add_product_id.value;
               return;
           } else {
           	   document.addform.action="<@ofbizUrl>additemBuy</@ofbizUrl>";
               document.addform.submit();
           }
       }
    }


    <!-- cart-controller.xml 里面有addFavorite-->
    function addFavorite() {
           var  fromPartyIdVal =$("#fromPartyId").val();
           if(fromPartyIdVal) {
                addFavoriteToOK();
           }else{
           	   document.addform.action="<@ofbizUrl>login</@ofbizUrl>";
               document.addform.submit();
           }
    }

    function addFavoriteToOK() {
       if (document.addform.add_product_id.value == 'NULL') {
           showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllRequiredOptions}");
           return;
       } else {
           if (isVirtual(document.addform.add_product_id.value)) {
               document.location = '<@ofbizUrl>product?category_id=${categoryId?if_exists}&amp;product_id=</@ofbizUrl>' + document.addform.add_product_id.value;
               return;
           } else {
           	   document.addform.action="<@ofbizUrl>addFavorite?productId=${(product.productId)!}</@ofbizUrl>";
               document.addform.submit();
           }
       }
    }

    <!-- cart-controller.xml 里面有addFavoriteStore-->
    function addFavoriteStore() {
           var  fromPartyIdVal =$("#fromPartyId").val();
           if(fromPartyIdVal) {
                addFavoriteStoreToOK();
           }else{
           	   document.addform.action="<@ofbizUrl>login</@ofbizUrl>";
               document.addform.submit();
           }
    }

    function addFavoriteStoreToOK() {
       if (document.addform.add_product_id.value == 'NULL') {
           showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllRequiredOptions}");
           return;
       } else {
           if (isVirtual(document.addform.add_product_id.value)) {
               document.location = '<@ofbizUrl>product?category_id=${categoryId?if_exists}&amp;product_id=</@ofbizUrl>' + document.addform.add_product_id.value;
               return;
           } else {
           	   document.addform.action="<@ofbizUrl>addFavoriteStore?productStoreId=${(productStore1.productStoreId)!}</@ofbizUrl>";
               document.addform.submit();
           }
       }
    }

    <!-- cart-controller.xml 里面有addProductAdvisory-->
    function addProductAdvisory() {
           var  fromPartyIdVal =$("#fromPartyId").val();
           if(fromPartyIdVal) {
                addProductAdvisoryToOK();
           }else{
           	   document.addform.action="<@ofbizUrl>login</@ofbizUrl>";
               document.addform.submit();
           }
    }

    function addProductAdvisoryToOK() {
       if (document.addform.add_product_id.value == 'NULL') {
           showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.CommonPleaseSelectAllRequiredOptions}");
           return;
       } else {
           if (isVirtual(document.addform.add_product_id.value)) {
               document.location = '<@ofbizUrl>product?category_id=${categoryId?if_exists}&amp;product_id=</@ofbizUrl>' + document.addform.add_product_id.value;
               return;
           } else {
					showDIV();
           }
       }
    }

    var $ = function(){
	      return document.getElementById(arguments[0]);
	};


     function  showDIV(){
			easyDialog.open({
					container : {
						header : '${uiLabelMap.WelcomeStoreCf}',
						content : $("#imgBox").html()
					}
			});
	};

/*
	function  showDIV(){
			easyDialog.open({
					container : "imgBox"
			});
	};
*/	
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

<style>
    tr3 .btn a {
        color: #737373;
        display: inline-block;
        font-size: 14px;
        font-weight: bold;
        text-align: center;
        width: 13px;
    }

    a {
        color: #666;
    }

    a {
        color: #777;
        text-decoration: none;
        outline: medium none;
    }

    #feature span, #COLOR span {
        cursor: pointer;
        margin-top: 8px;
    }

    .tr3 p span {
        color: #000;
    }

/*    .btn {
        cursor: pointer;
    }*/

    .tr3 .btn span input {
        width: 57px;
        text-align: center;
        height: 24px;
        margin: 0px 7px;
        line-height: 24px;
    }

    .border-i {
        border: 1px solid #D6D5D5;
    }

    article, audio, blockquote, body, button, canvas, caption, code, datalist, dd, details, div, dl, dt, embed, fieldset, figcaption, figure, form, h1, h2, h3, h4, h5, h6, hr, html, input, legend, li, menu, ol, p, pre, section, table, td, textarea, th, tr, ul, video, img {
        margin: 0px;
        padding: 0px;
    }

    .top .top-right .tr3 .tr3_taste em {
        display: block;
        float: left;
        height: 18px;
        margin-top: 7px;
        overflow: hidden;
        width: 40px;
    }

    .top em {
        font-style: normal;
    }

    em {
        font-style: normal;
    }

    .top .top-right .tr3 .tr3_taste {
        overflow: hidden;
    }

    .top .top-right .tr3 .tr3_taste p {
        float: left;
        margin-bottom: 5px;
        width: 747px;
    }

    .tr3 p {
        margin-bottom: 5px;
    }

    #feature span, #COLOR span {
        border-radius: 2px;
        cursor: pointer;
    }

    .tr3 .scolor {
        border: 2px solid #E85E5E;
    }

    .tr3 p span {
        padding: 4px 8px;
        /*border: 2px solid #D6D6D6;*/
        margin: 2px 10px 2px 0px;
        color: #000;
        display: inline-block;
        /*background-color: #FFF;*/
    }

    .tb-main-pic a {
        width: 350px;
        height: 350px;
        overflow: hidden;
    }

    .tb-pic a {
        display: table-cell;
        vertical-align: middle;
        text-align: center;
    }

    .tb-pic a img {
        vertical-align: middle;
    }
</style>
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
          <!--
          ${productContentWrapper.get("PRODUCT_NAME")?if_exists}
          -->
          <#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
														${productName!}
          </h1>
           <input value="${(userLogin.partyId)!}"  id="fromPartyId" name="fromPartyId" type="hidden">
         <!-- <div class="product-star-order">
		  <span id="product-star" class="product-star">
		  <span class="ui-rating"> <span class="ui-rating-star">
		  <span style="width:99.0%;">额定 <span>4.9 </span>/ 5的基础上 <span>
		  59 </span>顾客评论 </span> </span> </span> <b>100.0% </b>
		  的买家喜欢这个产品! (59票) </span>
		  <span class="orders-count"> <b>216 </b>订单 </span>
		  </div>-->

          <div class="product-info-wrap">
           <div class="product-info">

            <!-- <form action="" class="buy-now-form" id="buy-now-form" name="buyNowForm"> -->

            <form  method="post" action="<@ofbizUrl>additem</@ofbizUrl>" name="addform"  style="margin: 0;">
				<input  type='hidden' name='order_item_attr_dxStoreId' value='${parameters.dxStoreId!}'>
				<input  type='hidden' name='dxStoreId' value='${parameters.dxStoreId!}'>
				<#if dxStore?has_content>
					<#assign dxProduct=delegator.findOne("DxProduct",{"dxStoreId",dxStore.productStoreId,"supplierStoreId",productStore1.productStoreId,"productId",product.productId},false)?if_exists>
					<#if dxProduct?has_content>
					<input  type='hidden' name='price' value='${dxProduct.dxPrice!}'>
					</#if>
				</#if>
                 <!--  123456789 -->
                 <#assign inStock  = true />
		            <#assign commentEnable = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("order.properties", "order.item.comment.enable")>
		            <!--  <#if commentEnable.equals("Y")>
		                <#assign orderItemAttr = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("order.properties", "order.item.attr.prefix")>
		                ${uiLabelMap.CommonComment}&nbsp;<input type="text" name="${orderItemAttr}comment"/>
		            </#if> -->

               <!--  123456789 -->





                <!-- esi -->
                <div id="product-info-price-pnl">
                  <dl class="product-info-current">
                    <dt>
                    ${uiLabelMap.PortalPriceCf}: </dt>
                    <dd>
                      <div class="current-price">
		          <#if price.competitivePrice?exists && price.price?exists && price.price &lt; price.competitivePrice>
		           <div style="text-decoration:line-through;">${uiLabelMap.ProductCompareAtPrice}:
		           		<span class="basePrice"><@ofbizCurrency amount=price.competitivePrice isoCode=price.currencyUsed /></span></div>
		         </#if>
		          <#if price.listPrice?exists && price.price?exists && price.price &lt; price.listPrice>
		          <div style="text-decoration:line-through;">${uiLabelMap.ProductListPrice}:
		          		<span class="basePrice"><@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed /></span>
		          		<span class="basePrice"><@ofbizCurrency amount=price.listPrice isoCode=price.currencyUsed /></span>
		          		</div>
		          </#if>
		          <#if price.listPrice?exists && price.defaultPrice?exists && price.price?exists && price.price &lt; price.defaultPrice && price.defaultPrice &lt; price.listPrice>
		         <div style="text-decoration:line-through;">${uiLabelMap.ProductRegularPrice}:
		         <span class="basePrice"><@ofbizCurrency amount=price.defaultPrice isoCode=price.currencyUsed /></span></div>
		        </#if>
		          <#if price.specialPromoPrice?exists>
		            <div style="text-decoration:line-through;">${uiLabelMap.ProductSpecialPromoPrice}: <span class="basePrice">
		            	<@ofbizCurrency amount=price.specialPromoPrice isoCode=price.currencyUsed /></span></div>
		           </#if>


					<div id="product-price" class="ui-cost notranslate">
		             <strong>
		              <#if price.isSale?exists && price.isSale>
		              <span  class="salePrice">${uiLabelMap.OrderOnSale}!</span>
		                <#assign priceStyle = "salePrice" />
		              <#else>
		                <#assign priceStyle = "regularPrice" />
		              </#if>

						<span class="${priceStyle}" id="priceSpan">
						<#if dxStore??>
							
							<@ofbizCurrency amount=dxProduct.dxPrice isoCode=priceMap.currencyUsed />
						<#else>
							<@ofbizCurrency amount=priceMap.price isoCode=priceMap.currencyUsed />
						</#if>
						</span>
                          </strong>
                      <div class="price-sub-info"> </div>
                    </dd>
                  </dl>
                </div>
                <div class="product-info-operation">
                  <#if daysToShip?exists>
                  <dl class="product-info-shipping">
                    <dt>送货: </dt>
                    <dd>
                      <div id="product-info-shipping" class="product-info-shipping-pnl util-clearfix notranslate" data-widget-cid="widget-13">
                      <span id="shipping-cost"><span class="shipping-cost">
                      免费送货 </span>
                      <span class="shipping-to">至 </span></span>
                       <a id="shipping-link" class="shipping-link" rel="nofollow" href="javascript:void(0);" tabindex="-1">
                       <span id="shipping-country">俄罗斯 </span>
                       <span class="shipping-via">通过 </span>
                        <span id="shipping-company">中国邮政挂号小包</span></a> </div>

                      <div id="product-info-shipping-sub" class="sub-info" style="display: block;">
                      预计送货时间: 
                      <span id="shipping-delivery-day">${daysToShip} </span>
                      ${uiLabelMap.CommonDays}! 天(卖家3天内发货) </div>
                    </dd>
                  </dl>
                  </#if>
                  <div id="product-info-sku" data-widget-cid="widget-11">


                    <dl class="product-info-size">
                      <#-- Variant Selection    变形产品-->
		            <#if product.isVirtual?if_exists?upper_case == "Y">
		              <#if product.virtualVariantMethodEnum?if_exists == "VV_FEATURETREE" && featureLists?has_content>
		                <#list featureLists as featureList>
		                    <dt class="pp-dt-ln sku-title"></dt>
		                    <dd>
                        	  <ul id="sku-sku3" class="sku-attr sku-checkbox">
		                    <#list featureList as feature>
		                    	<li><input type="radio" name="FT${feature.productFeatureTypeId}" value="${feature.productFeatureId}">${feature.description}</li>
		                    </#list>
							</ul>
						   </dd>
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
		               
		                <span id="product_uom"></span>
		                <input type="hidden" name="product_id" value="${product.productId}"/>
		                <#-- <input type="hidden" name="add_product_id" value="${product.productId}"/> -->
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
                    </dl>

                  </div>


                  <div style="clear:both;"></div>
		                    <#if product.isVirtual?if_exists?upper_case == "Y">
		                    <dl id="product-info-quantity" class="tr3_tast" data-widget-cid="widget-12">
			                    <dt>
			                      <span>${uiLabelMap.ProductFeature}: 
			                    <dd>
								<div class="tr3" id="feature">
									<#assign firstInvetoryNum=0>
					              	<#if featureCategoryList?has_content>
						                <#list featureCategoryList as featureCategory>
						                    <div class="tr3_taste">
						                       <em>${featureCategory.description!}:</em>
												<p id="${featureCategory.productFeatureCategoryId}">
													<#assign featureList = delegator.findByAnd("ProductFeatureAndAppl",{"productFeatureCategoryId":featureCategory.productFeatureCategoryId,"productId":product.productId})?if_exists  />
												    <#list featureList as feature>
												    	<#if featureCategory_index==0&&feature_index==0>
												    	<#assign firstInvetoryNum=childList[0].inventoryNum>
												    	<input type="hidden" name="add_product_id" value="${childList[0].productId}" >
												    	</#if>
						                    			<span name="feature${feature.productFeatureId}" id="${feature.productFeatureId}"   choice="<#if feature_index==0>choiced<#else>unChoiced</#if>"	class="<#if feature_index==0>scolor</#if>">
												         <#assign language=locale.language>
												         		${feature.description!}
											    		</span>
						                   		 	</#list>
						                   		</p>
											</div>
										</#list>
					           		 </#if>
					           </div>
					          

							</dd>
			                 </dl>
							 <dl id="product-info-quantity" class="tr3_tast" data-widget-cid="widget-12">
			                    <dt>
			                      <span>${uiLabelMap.PortalQuantityCf}: 
			                    <dd>
								<div class="tr3">
									<p class="btn" id="productNum">
					                    <span>
											<a href="javascript:void(0)" id="reduce" onclick="updateNum(this,'${product.productId}','265.00','0.50','N','')">-</a>
											<input class="border-i" id="buyNums" name="quantity" value="1" onkeyup="buyNumChange(this);" onafterpaste="buyNumChange(this);" quantity="1" maxreorder="0" type="text">
											<a href="javascript:void(0)" id="add" onclick="updateNum(this,'${product.productId}','265.00','0.50','N','')">+</a>
										</span>

							${uiLabelMap.PartsInventoryStatusCf}：
							<strong id="inventory" avilable="Y" avinum="11" expire="N" activitystart="Y">
							${firstInvetoryNum!} ${uiLabelMap.ItemCf})</strong>
							</p>
				   <#else>
				                	<input type="hidden" name="add_product_id" value="NULL"/>
				                	</dd>
					                 </dl>
									 <dl id="product-info-quantity" class="tr3_tast" data-widget-cid="widget-12">
					                    <dt>
					                      <span>${uiLabelMap.PortalQuantityCf}: 
					                    <dd>
										<div class="tr3">
											<p class="btn" id="productNum">
							                    <span>
													<a href="javascript:void(0)" id="reduce" onclick="updateNum(this,'${product.productId}','265.00','0.50','N','')">-</a>
													<input class="border-i" id="buyNums" name="quantity" value="1" onkeyup="buyNumChange(this);" onafterpaste="buyNumChange(this);" quantity="1" maxreorder="0" type="text">
													<a href="javascript:void(0)" id="add" onclick="updateNum(this,'${product.productId}','265.00','0.50','N','')">+</a>
												</span>

											${uiLabelMap.PartsInventoryStatusCf}：
											<strong id="inventory" avilable="Y" avinum="11" expire="N" activitystart="Y">
											${mainInventoryNum!}) </strong>
									</p>
				</#if>
						</div>
					<#--
                      <input id="product-info-txt-quantity" name="quantity" id="quantity"  value="1" min="1" max="9999" maxlength="5" onkeyup="checkRate(this);" onBlur="checkRatenull(this);">
                      <span id="product-info-unit" class="lbl-unit sub-info">${uiLabelMap.PortalMonthsCf} </span>
                      <input type="hidden" id="oddUnitName_id" value="piece">
                      <input type="hidden" id="multiUnitName_id" value="pieces">
                      -->
                    </dd>
                  </dl>

                   <!--111 -->
                 <#--  <dl class="product-info-total-price">
                    <dt>${uiLabelMap.PortalGoods666Cf}: </dt>
                    <dd> <span class="sku-totle-price-tip" style="display: inline;">
					
					       <#if productTax?has_content>
				            <@ofbizCurrency amount=productTax isoCode=priceMap.currencyUsed />
				           </#if> </span>
                      <input type="hidden" id="hid-freight" value="0.00">
                      <div id="product-info-total-price" style="display: none;" data-widget-cid="widget-16" class="notranslate">
                       <span class="total-price"></span>
                       <span id="multi-currency-total-price" class="sub-info">
                       (<span class="value"></span>
                       ) </span> </div>
                        <p class="ui-feedback ui-feedback-addon ui-feedback-alert ui-feedback-body" id="cannot-deliver" style="display: none;">
                         </p>
                    </dd>
                  </dl> -->

                 <!--222 -->
                  <#-- <dl class="product-info-total-price">
                    <dt>${uiLabelMap.PortalGoods777Cf}: </dt>
                    <dd> <span class="sku-totle-price-tip" style="display: inline;">
					
					       <#if productTax?has_content>
				            <@ofbizCurrency amount=shippingCharge isoCode=priceMap.currencyUsed />
				           </#if> </span>
                      <input type="hidden" id="hid-freight" value="0.00">
                      <div id="product-info-total-price" style="display: none;" data-widget-cid="widget-16" class="notranslate">
                       <span class="total-price"></span>
                       <span id="multi-currency-total-price" class="sub-info">
                       (<span class="value"></span>
                       ) </span> </div>
                        <p class="ui-feedback ui-feedback-addon ui-feedback-alert ui-feedback-body" id="cannot-deliver" style="display: none;">
                        </p>
                    </dd>
                  </dl> -->



                  <div class="product-info-action">


                   <div class="buy-now">
                         <a id="buy-now" class="buy-now-btn" href="javascript:addItemBuy()" tabindex="-1" data-widget-cid="widget-17">
                          ${uiLabelMap.PortalBuyNowCf}</a>
                        <a href="javascript:addItem()" id="addToCart" name="addToCart" class="add-to-cart-btn">
                          ${uiLabelMap.PortalAddtoCartCf}</a>

                         <div class="add-to-wishlist">
                           <a href="javascript:addFavorite()" rel="nofollow" tabindex="-1">
                          ${uiLabelMap.PortalFavoriteCf}</a><span class="sub-info">
                           <a href="javascript:addProductAdvisory()" class="ovovov" id="Product_Advisory" >
                          ${uiLabelMap.ProductAdvisoryCf}</a><span class="sub-info">
                          <#-- ( <span id="wl-product-num">
                          431已 </span>
                          收藏) </span>--> </div>
                    </span>



            <!--  123456789 -->
            <!--  添加 到购物车   end  -->

                    </div>


                  </div>
                </div>



              </form>

              <#-- Prefill first select box (virtual products only)
          <#if variantTree?exists && 0 &lt; variantTree.size()>
            <script type="text/javascript">eval("list" + "${featureOrderFirst}" + "()");</script>
          </#if>
          -->
              <dl class="store-promotion" style="display:none">
                <dt>商店促销: </dt>
                <dd><span id="seller-coupon" data-widget-cid="widget-32"><a class="store-promotion-item"></a>
                  <div id="seller-coupon-result">
                    <div id="sc-result-body"></div>
                    <a href="javascript:;" class="ui-close">关闭 </a></div>
                  </span></dd>
              </dl>
              <!-- store promotion coupon and fixeddisscount -->
              <div id="seller-promise-list" data-widget-cid="widget-21" style="display: block;">
                <dl class="return-policy util-clearfix">
                  <dt>${uiLabelMap.PortalReturnProuductCf}</dt>
                  <dd>
                    <div class="s-serve sp-1">${uiLabelMap.PortalOrdersYourPaymentCf}</div>
                  </dd>
                </dl>
                <dl class="s-seller-guarantees util-clearfix" id="serve-guarantees-detail">
                  <dt>${uiLabelMap.PortalTheSellerPromisesCf}</dt>
                  <dd class="util-clearfix">
                    <div class="s-serve sp-5"> <em>${uiLabelMap.PortalDeliveryontimeCf}</em><span class="sp-brief">
                    <span class="promise-time-cont"></span></span>
                      <!-- <div class="ui-balloon ui-balloon-tl"> 如果产品不接受全额退款 <i><span class="promise-time-cont">15</span>天 </i> <span class="ui-balloon-arrow"></span> </div> -->
                       </div>
                    <!-- <div class="s-serve-line"></div> -->
                    <div class="s-serve sp-2">
                    <a rel="" hidefocus="true" target="_blank">
                    <em></em>
                    <span class="sp-brief"></span>
                      <!-- <div class="ui-balloon ui-balloon-tl"> 返回 <i> 任何产品 </i>,即使在完美的条件,买方支付返回航运 <span class="ui-balloon-arrow"></span> </div> -->
                      </a> </div>
                  </dd>
                </dl>
              </div>

            </div>

          </div>

<!--评分开始-->
<style>
.brand-logo {
    padding: 10px 0px;
    overflow: hidden;
    border-top: 1px solid #EEE;
    border-bottom: 1px solid #EEE;
}
.seller-pop-box {
    margin-bottom: 10px;
    border-bottom: 1px solid #EEE;
}
.pop-score-part1 {
    overflow: hidden;
    clear: both;
    padding: 0px 9px;
}
.pop-score-part1 dt {
	float: left;
}
.pop-score-part1 dd {
    float: left;
    width: 107px;
}
.pop-score-part1 .heart-white {
    position: relative;
    float: left;
    overflow: hidden;
    width: 72px;
    background-position: 0px -18px;
}

.pop-score-part1 .heart-red, .pop-score-part1 .heart-white {
    height: 18px;
    display: inline-block;
    background: url("http://misc.360buyimg.com/product/item/1.0.12/css/i/grade.png") no-repeat scroll 0px 0px transparent;
}
.pop-score-part1 .h9 {
    left: -10px;
}
.pop-score-part1 .heart-red {
    position: absolute;
    left: -40px;
    width: 78px;
    background-position: 0px 0px;
}
.pop-score-part1 .heart-red, .pop-score-part1 .heart-white {
    height: 18px;
    display: inline-block;
    background: url("http://misc.360buyimg.com/product/item/1.0.12/css/i/grade.png") no-repeat scroll 0px 0px transparent;
}
em {
    font-style: normal;
}
.pop-score-part2 {
    overflow: hidden;
    padding: 10px 0px 19px 9px;
}
.pop-score-part2 dt {
    float: left;
    line-height: 1.1em;
}
.pop-score-part2 dd {
    overflow: hidden;
    line-height: 1.1em;
}
.pop-score-detail {
    display: none;
}
.pop-score-detail .score-title {
    width: 178px;
    height: 32px;
    overflow: hidden;
    padding: 0px 11px;
    line-height: 32px;
    border-top: 1px dotted #DDD;
    font-size: 0px;
}
.pop-score-detail .score-title .col1 {
    width: 31%;
}
.pop-score-detail .score-title .col1, .pop-score-detail .score-title .col2, .pop-score-detail .score-title .col3 {
    display: inline-block;
    font-size: 12px;
}
.pop-score-detail .score-title .col2 {
    width: 35%;
    text-align: center;
}
.pop-score-detail .score-title .col1, .pop-score-detail .score-title .col2, .pop-score-detail .score-title .col3 {
    display: inline-block;
    font-size: 12px;
}
.pop-score-detail .score-title .col3 {
    width: 34%;
    text-align: right;
}
.pop-score-detail .score-title .col1, .pop-score-detail .score-title .col2, .pop-score-detail .score-title .col3 {
    display: inline-block;
    font-size: 12px;
}
.pop-score-detail .score-infor {
    width: 130px;
    padding: 10px 0px 10px 70px;
    overflow: hidden;
    border-top: 1px dotted #DDD;
}
.pop-score-detail .score-sum {
    float: left;
    display: inline;
    margin-left: -65px;
    margin-top: 8px;
    color: #999;
}
.pop-score-detail .score-sum .number {
    padding-left: 3px;
    font-size: 30px;
    line-height: 45px;
    color: #E4393C;
}
.pop-score-detail .score-part {
    width: 127px;
    line-height: 20px;
}
.pop-score-detail .score-desc {
    display: inline-block;
    width: 65px;
    color: #999;
}
.pop-score-detail .score-desc .number {
    margin-left: 5px;
    color: #333;
}
.pop-score-detail .score-change {
    display: inline-block;
}
.pop-score-detail .score-change .down {
    background-position: -150px -84px;
}
.pop-score-detail .score-change i {
    display: inline-block;
    width: 11px;
    height: 11px;
    margin-right: 3px;
    vertical-align: middle;
    background: url("http://misc.360buyimg.com/product/item/1.0.12/css/i/newicon20140910.png") no-repeat scroll 0% 0% transparent;
}
.pop-score-detail .score-change .percent {
    display: inline-block;
    vertical-align: middle;
}
.pop-shop-detail {
    /* display: none; */
    width: 100%;
    padding: 10px 0px;
    border-top: 1px dotted #DDD;
}
.pop-shop-detail .item {
    padding: 0px 3px 0px 69px;
    margin-bottom: 5px;
    line-height: 20px;
    text-indent: -60px;
    font-family: 宋体;
}
.pop-shop-detail .item .label {
    color: #999;
}
.customer-service {
    padding-left: 9px;
    padding-bottom: 10px;
    margin-bottom: 10px;
    line-height: 24px;
}
.clearfix {
    display: block;
}
.clearfix {
    display: inline-table;
}
.customer-service .label {
    width: 60px;
    height: 24px;
    line-height: 24px;
    float: left;
    display: none;
}
.customer-service .service {
    float: left;
    width: 187px;
}
.pop-shop-enter {
    height: 24px;
    padding-left: 9px;
    padding-bottom: 20px;
}
.pop-shop-enter .btn-gray {
    padding: 0px 12px;
}
.btn-gray {
    display: inline-block;
    border: 1px solid #DDD;
    border-radius: 2px;
    text-align: center;
    text-decoration: none;
    color: #333;
    background: -moz-linear-gradient(center top , #F7F7F7, #F2F2F2) repeat scroll 0% 0% transparent;
}
.btn-gray, .btn-gray:hover, .btn-gray:visited {
    text-decoration: none;
}
.btn-gray {
    padding: 0px 15px;
    height: 22px;
    line-height: 22px;
    overflow: hidden;
}
.pop-shop-enter .btn-shop-follower {
    margin-left: 5px;
}
.pop-shop-enter .btn-gray {
    padding: 0px 12px;
}
.btn-gray {
    display: inline-block;
    border: 1px solid #DDD;
    border-radius: 2px;
    text-align: center;
    text-decoration: none;
    color: #333;
    background: -moz-linear-gradient(center top , #F7F7F7, #F2F2F2) repeat scroll 0% 0% transparent;
}
.btn-gray, .btn-gray:hover, .btn-gray:visited {
    text-decoration: none;
}
.btn-gray {
    padding: 0px 15px;
    height: 22px;
    line-height: 22px;
    overflow: hidden;
}
.pop-score-part2 .eva-down s {
    background-position: -150px -84px;
}
.pop-score-part2 s {
    width: 11px;
    height: 11px;
    display: inline-block;
    margin: 0px 3px 0px 1px;
    background: url("http://misc.360buyimg.com/product/item/1.0.12/css/i/newicon20140910.png") no-repeat scroll 0% 0% transparent;
}
.jd-im {
    display: inline-block;
    width: 59px;
    height: 24px;
    line-height: 24px;
    padding-left: 27px;
    background: url("http://misc.360buyimg.com/product/item/1.0.12/css/i/im20131028.gif") no-repeat scroll 0% 0% transparent;
}
.jd-im b {
    font-weight: 400;
    color: #FFF;
}
</style>
           <!--卖家信息   付款方式   注意 的页面   -->
			<!-- seller-info-wrap  开始 -->
			<div class="seller-info-wrap">
			    <div class="seller-info">
				<div class="seller">
					<!-- <div class="title">${uiLabelMap.PortalSellerCf}</div> -->
					<#assign PcompanyId="">
					<#assign storeName="">
					<#assign productStoreLogo="">
					<#if dxStore??>
						<#assign PcompanyId=dxStore.productStoreId!>
						<#assign storeName=dxStore.storeName!>
						<#assign productStoreLogo=dxStore.productStoreLogo!>
					 <#else>
					 	<#assign PcompanyId=productStore1.productStoreId!>
						<#assign storeName=productStore1.storeName!>
						<#assign productStoreLogo=productStore1.productStoreLogo!>
					 </#if>
					 <div class="brand-logo" style="text-align:center;">
					      <a href="http://veromoda.jd.com" target="_blank">
					          <img src="${productStoreLogo!""}" height="60px" title="${storeName!}">
					      </a>
					 </div>	
					 <div class="company-name notranslate">
					 <#-- http://localhost:8080/portal/control/sellerhome?productStoreId=10001 -->
					 <script type="text/javascript">
						 function oncheckP(){
			                  var  PcompanyIdVal =$("#PcompanyId").val();
			                  window.location.href="<@ofbizUrl>sellerhome?productStoreId="+PcompanyIdVal</@ofbizUrl>;
		                 }
	                </script>
					   		 <a  onclick="oncheckP();"> ${storeName!}</a>
					   		 <input value="${productStoreId!}"  id="PcompanyId" name="PcompanyId" style="display: none;">
					  </div>
			    	<input type="hidden" id="hid-feedback-url" value="#">
				</div>
				<div class="seller-pop-box">
					<div class="J-pop-score z-pop-desc-show">       
						<div class="pop-score">    
						    <dl class="pop-score-detail" style="display:block">     
								<dt class="score-title">                
						          	<span class="col1">综合评分</span>                
						          	<span class="col2">评分细则</span>        
		                			<span class="col3">相比行业</span>            
		                		  </dt>            
		                		  <dd class="score-infor">            
		                    			<div class="score-sum"><em class="number">9.6</em>分</div>                
		                    			<div class="score-part">             
		                           			<span class="score-desc">商品<em title="9.75" class="number">9.75</em></span>                
		                               		<span class="score-change">
		                               			<i class="down"></i><em class="percent">1.32%</em>
		                               		</span>                
		                               	</div>               
		                               	<div class="score-part">                    
		                               		<span class="score-desc">服务<em title="9.51" class="number">9.51</em></span>                    
		                               		<span class="score-change"><i class="down"></i><em class="percent">1.01%</em></span>                
		                               	</div>                
		                               	<div class="score-part">                    
		                               		<span class="score-desc">时效<em title="9.82" class="number">9.82</em></span>                    
		                               		<span class="score-change"><i class="down"></i><em class="percent">2.04%</em></span>                
		                               	</div>            
		                           </dd>        
	                          </dl>        
	                          	<div class="pop-shop-detail">            
	                          		<!--
	                          		<div class="item">                
	                          			<span class="label">公司名称：</span><span class="text J-shop-name">
	                          			绫致时装销售（天津）有限公司</span>            
	                          		</div>  
	                          		-->          
	                          		<div class="item">               
	                          	 		<span class="label">所&nbsp;在&nbsp;地&nbsp;：</span><span class="text J-shop-address">天津&nbsp;武清区</span>            
	                          		 </div>            
	                          		 <div class="item hide">                
	                          	 		<span class="label">联系电话：</span><span class="text J-shop-phone">1024</span>            
	                          	 	</div>        
	                         	</div>
	                      </div>     	
		          	</div>  
				</div> 
				<dl class="customer-service clearfix">
					<dt class="label">在线客服：</dt>
					<dd class="service"><span id="J-im-btn" clstag="shangpin|keycount|product|{* pType *}|dongdong">
					<span data-domain="chat.jd.com" data-code="1" data-seller="VERO MODA官方旗舰店" title="联系客服" class="item">
					<a id="j-im" class="jd-im" href="#none"><b>联系客服</b></a></span></span>
						<span id="J-jimi-btn" clstag="shangpin|keycount|product|{* pType *}|jimi"></span>
					</dd>
				</dl>
				<div class="pop-shop-enter">
			      <a href="javascript:oncheckP();" target="_blank" class="btn-gray btn-shop-access J-enter-shop">进入店铺</a>
			      <a href="#none"  onclick="addFavoriteStore();" class="btn-gray btn-shop-follower J-follow-shop" data-vid="57028">收藏店铺</a>
			    </div>
				
            </div>
            <!-- seller-info-wrap  结束 -->
		 </div>

        </div>
      </div>
      <div class="col-sub">
        <div>

        			<link href="/portal/images/css/base.css" rel="stylesheet" type="text/css" />
        			<link href="/portal/images/css/imagezoom.css" rel="stylesheet" type="text/css" />
					<script type="text/javascript" src="/portal/images/js/jquery-1.4.2.min.js"></script>
					<script type="text/javascript" src="/portal/images/js/jquery.imagezoom.min.js"></script>

           <!--跑马灯的大图片  放大镜的效果  开始 -->

         	<#assign imgMap = Static["org.ofbiz.ebiz.product.ProductHelper"].getProdImgPaths(productId,"EB_PRODIMG_INFO",delegator)/>
		    <#assign flag=imgMap.flag />
		     <#assign imgList = imgMap.imgPathList/>
            	<div  id="preview" class="tb-booth tb-pic tb-s350">
					 <a href="javascript:void(0);">
                    <#if imgList?has_content>
                       <img id='imgurl' rel="${baseUrl+(imgList?first)}"  src="${baseUrl+(imgList?first)}"  class="jqzoom">
                     <#else>
		        	     <img id='imgurl' jqimg="../portal/images/defaultImage2.jpg" src="../portal/images/defaultImage.jpg" style="width: 350px; height:350px;">
		        	</#if>
		        	</a>
             	</div>
             <div  class="ui-image-viewer-loading" style="width: 350px; height: 350px; overflow: hidden; display: none;">
              <div  class="ui-image-viewer-loading-mask"></div>
              <div  class="ui-image-viewer-loading-whirl"></div>
            </div>
            <!--   跑马灯的大图片  放大镜的效果  End -->


  			 <!--缩图开始-->
    <div class="spec-scroll">
      <div class="items">
       <ul id="thumblist">
            <#if imgList?has_content>
        	<#list imgList as image>
        		 <li><a href="javascript:void(0);"><img  bimg="${baseUrl+image}" src="${baseUrl+image}"></a></li>
        	</#list>
        	<#else>
        	     <li><a href="javascript:void(0);"><img  bimg="../portal/images/defaultImage2.jpg" src="../portal/images/defaultImage.jpg" onmousemove="preview(this);"></a></li>
        	</#if>
        </ul>
      </div>
    </div>
    <!--缩图结束-->



      </div>


        </div>

      </div>


   <!--用户咨询--->
<link rel="stylesheet" href="/portal/seller/images/product/easydialog.css" type="text/css"/>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.min.js"></script>

  <div id="imgBox" style="display:none;">
           <div class="activity-list" style="padding:10px;">
          <div class="activity-detail">
           <dl>
            <dt>
             	${uiLabelMap.StoreNameCf}:
            </dt>
            <dd></dd>

            <dt></dt>
            <dd>
            	<span class="countdown"><strong class="setcountdown">
            		         <#if productStore1?has_content >
	                          ${(productStore1.storeName)!}
	                         </#if>
            	</strong></span>
            </dd>

           </dl>

          </div>
         </div>
         <div>
       <form id="actyform" name="actyform" action="<@ofbizUrl>subProductAdvisoryToSeller</@ofbizUrl>" method="post">
         
         	 <textarea id="story" name="story" rows="10" style="width:680px; margin-left:10px;"></textarea>
         	   
	         <div class="autpost-con02 clearfix" style="margin-bottom:50px; margin-left:0px; padding-top:20px;">    
	              <!--RF_PRODINFO  区分 作用 -->
	              <input value="RF_PRODINFO"  id="custRequestTypeId" name="custRequestTypeId" type="hidden" >
	               
	              <!--卖家的ID 或者说是店铺的ID--> 
	              <input value="${(productStore1.productStoreId)!}"  id="productStoreId" name="productStoreId" type="hidden" >
	              <!--买家的ID--> 
	              <input value="${(userLogin.partyId)!}"  id="fromPartyId" name="fromPartyId" type="hidden">
	               <!--商品的ID--> 
	              <input value="${(product.productId)!}"  id="productId" name="productId" type="hidden">
	          <span>
	        	   <a href="javascript:easyDialog.close();" class="btn_normal" style="width:100px;margin-right:250px; height:30px; text-align:center; line-height:30px;">${uiLabelMap.CommonGoBack}</a>
	               <input type="button" onclick="javascript:submitRequest()"  value="${uiLabelMap.CommonSave}" class="btn_highlight" style="width:100px;margin-right:10px; height:30px; text-align:center; line-height:30px;"/>
	             </span>
               </div> 
	               
         
       </form>
       		
	             
       </div>

  </div>

  <script>
<!--
function submitRequest(){
	var actyformObj =event.srcElement.parentNode.parentNode.parentNode;
	var actyformData ="custRequestTypeId="+$("#custRequestTypeId").val();
	actyformData +="&productStoreId="+$("#productStoreId").val();
	actyformData +="&fromPartyId="+$("#fromPartyId").val();
	actyformData +="&productId="+$("#productId").val();
	actyformData +="&story="+actyformObj.story.value;
	//alert(actyformData);
	jQuery.ajax({
            type: "post",//使用get方法访问后台
            url: "<@ofbizUrl>subProductAdvisoryToSeller</@ofbizUrl>",//要访问的后台地址
            data:actyformData, //$("#actyform").serialize(),//要发送的数据
            dataType: "json",//返回json格式的数据
            success: function (msg) {//msg为返回的数据，在这里做数据绑定
                //alert(msg.custRequestId);
                alert("${StringUtil.wrapString(uiLabelMap.SuccessInquiryCf)}");
                easyDialog.close();
            },
            error :function(msg){
            	//alert(msg.custRequestId);;
            }
 	});
 }
 
 //-->
</script>

 <script>

			/**
			  * 特征选择
			  * @param o
			  */
			   function featureChoice(o){
			     var json = eval("("+o+")");
			     var varaints = json.variant;
			     $obj = $("#feature");
			     var $span = $obj.find("span"); 
			     $span.click( function() {
					 if("bg"!=$(this).attr("class")){
					     $(this).parent().find("span").attr("choice","unChoiced").attr("class", "");
					     $(this).attr("choice", "choiced").attr("class", "scolor");
						var featureType = $(this).parent();
						var featureTypeId = $(featureType).attr("id");
						var featureId = this.id;
						var products = new Array();
						for (var j = 0; j < varaints.length; j++) {// variant
						    var variant = varaints[j];
						    var variantFeatureId = variant.productFeature[featureTypeId].productFeatureId;
						    if (variantFeatureId == featureId) {
							products.push(variant);
						    }
						}
						var otherType = $("#feature").find("p[id!='productNum'][id!='"+featureTypeId+"']");
						var otherTypeLength = 0;
						 if("undefined"!=typeof(otherType)){
						     otherTypeLength = otherType.length;
						 }
						 if(otherTypeLength>0){
							 var otherTypeId = $(otherType).attr("id");
							 var features = $(otherType).find("span");
							 for (var m = 0; m < features.length; m++) {
								var hasFeature = "N";
								var nextFeature = features[m];
								var nextFeatureId= $(nextFeature).attr("id");
								for (var n = 0; n < products.length; n++) {
								    var product = products[n];
								    var productFeatureId = product.productFeature[otherTypeId].productFeatureId;
								    if(nextFeatureId==productFeatureId){
									hasFeature="Y";
									 if("undefined"==typeof($(otherType).find("span[choice='choiced']")) ||!($(otherType).find("span[choice='choiced']").length>0) ){
										 $("#"+nextFeatureId).attr("choice","choiced");
										 $("#"+nextFeatureId).attr("class", "scolor");
										 variantHtml(product);
									     }else{
										 if($(otherType).find("span[choice='choiced']").attr("id")!=nextFeatureId){
										     $("#"+nextFeatureId).attr("choice","unChoiced");
										     $("#"+nextFeatureId).attr("class", "");
										 }else{
										     variantHtml(product);
										 }
									     }
								    }
								}
								if("N"==hasFeature){
								    $(nextFeature).attr("choice","unChoiced");
								    $(nextFeature).attr("class", "bg");
								}
							    }
						 }else{
						     /**only one feature*/
						    variantHtml(products[0]);
						 }
					 buyNumChange($("#buyNums")[0]);
					 }
			     });
			 }
			 /**
			  * control variant product
			  */
			 function variantHtml(o){
			     var product = o;
			     document.addform.add_product_id.value=product.productId;
			     $("#product").attr("value",product.productId);
			     $("#product").find("h3").html(product.productName);
			     if(product.imgUrl){
			     	$("#imgurl").attr("src",product.imgUrl);//子商品图片-还需要添加放大图的处理
			     }
				 //set the product's price
				 $("#priceSpan").html(product.productPrice.defaultPrice);
				 $("#inventory").html(product.inventoryNum + "件)");
				 //set the product's inventory
				 /*
				 var url = "/product";
				 var productId = $("#product").attr("value");
				 $.post(url, {
				     	status : "inventory",
					productId : product.productId
					},
				     function(data){
				     var json = eval("("+data+")");
				     var aviNum = json.productInventory;
				     if($("#inventory").attr("expire")!="Y" && $("#inventory").attr("activityStart")!="N"){
					 if(aviNum>0){
					     $("#inventory").html(aviNum + "件");
					     $("#inventory").attr("avilable", "Y");
					     $("#inventory").attr("aviNum", aviNum);
					     $("#purchaseNow").attr("class", "icon-iocn_27");
					     $("#addCartItem").attr("class", "icon-iocn_29");
					}else{
					    $("#inventory").html("抢光了");
					    $("#inventory").attr("avilable", "N");
					    $("#inventory").attr("aviNum", 0);
					    $("#purchaseNow").attr("class", "iocn_142");
					    $("#addCartItem").attr("class", "iocn_143");
					}
				     }else{
					 if(aviNum>0){
					     $("#inventory").html(aviNum + "件");
					     $("#inventory").attr("avilable", "N");
					     $("#inventory").attr("aviNum", aviNum);
					     $("#purchaseNow").attr("class", "iocn_142");
					     $("#addCartItem").attr("class", "iocn_143");
					 }else{
					     $("#inventory").html("抢光了");
					     $("#inventory").attr("avilable", "N");
					     $("#inventory").attr("aviNum", 0);
					     $("#purchaseNow").attr("class", "iocn_142");
					     $("#addCartItem").attr("class", "iocn_143");
					 }
				     }
				 });
				 */
			 }
			 /**
			  * 虚拟产品初始化
			  * @param o
			  */
			 function variantInit(o){
			     var product = o;
			     $("#product").attr("value",product.productId);
			     $("#product").find("h3").html(product.productName);
			     //set the product's price
			     $("#priceSpan").html(product.productPrice.defaultPrice);
			     var aviNum = parseInt(product.inventoryNum);
			     if($("#inventory").attr("expire")!="Y" && $("#inventory").attr("activityStart")!="N"){
				 if(aviNum>0){
				     $("#inventory").html(aviNum + "件");
				     $("#inventory").attr("avilable", "Y");
				     $("#inventory").attr("aviNum", aviNum);
				     $("#purchaseNow").attr("class", "icon-iocn_27");
				     $("#addCartItem").attr("class", "icon-iocn_29");
				}else{
				    $("#inventory").html("抢光了");
				    $("#inventory").attr("avilable", "N");
				    $("#inventory").attr("aviNum", 0);
				    $("#purchaseNow").attr("class", "iocn_142");
				    $("#addCartItem").attr("class", "iocn_143");
				}
			     }else{
				 if(aviNum>0){
				     $("#inventory").html(aviNum + "件");
				     $("#inventory").attr("avilable", "N");
				     $("#inventory").attr("aviNum", aviNum);
				     $("#purchaseNow").attr("class", "iocn_142");
				     $("#addCartItem").attr("class", "iocn_143");
				 }else{
				     $("#inventory").html("抢光了");
				     $("#inventory").attr("avilable", "N");
				     $("#inventory").attr("aviNum", 0);
				     $("#purchaseNow").attr("class", "iocn_142");
				     $("#addCartItem").attr("class", "iocn_143");
				 }
			     }
			 }
			 /**
			 * 保持两位小数点
			 */
			function CurrencyFormatted(amount) {
			    var i = parseFloat(amount);
			    if (isNaN(i)) {
				i = 0.00;
			    }
			    var minus = '';
			    if (i < 0) {
				minus = '-';
			    }
			    i = Math.abs(i);
			    i = parseInt((i + .005) * 100);
			    i = i / 100;
			    s = new String(i);
			    if (s.indexOf('.') < 0) {
				s += '.00';
			    }
			    if (s.indexOf('.') == (s.length - 2)) {
				s += '0';
			    }
			    s = minus + s;
			    return s;
			}
			/**
			 * 未选商品直接购买
			 * @param o
			 * @returns {String}
			 */
			 function returnProduct(o){
			    var proDetail = o;
			    var productId = "";
			    if ("Y" == $("#inventory").attr("avilable")) {
				// 添加购物车
				    var features = $("#feature").find("p[id!='productNum']");
				    var aryFeature = new Array();
				    var aryType = new Array();
				    for (var int = 0; int < features.length; int++) {
					var feature = features[int];
					var featureType = $(feature).attr("id");
					var featureValue = $(feature).find("span[choice='choiced']")
						.attr("value");
					aryFeature.push(featureValue);
					aryType.push(featureType);
				    }
				    var jsonPro = eval("(" + proDetail + ")");
				    // 虚拟产品
				    var variant = jsonPro.productDetail.variant;
				    if ((typeof (variant) != "undefined") && variant.length > 0) {
					for (var i = 0; i < aryType.length; i++) {
					    var productV = new Array();
					    for (var j = 0; j < aryFeature.length; j++) {
						for (var int2 = 0; int2 < variant.length; int2++) {
						    var variantProduct = variant[int2];
						    var aryfea = aryFeature[j];
						    var cc = variantProduct.feature[aryType[i]];
						    var dd = cc[0].productFeatureId;
						    if (dd == aryfea) {
							productV.push(variantProduct);
						    }
						}
					    }
					    variant = productV;
					}
					productId = variant[0].product.productId;
				    } else {
					productId = $("#product").attr("value");
				    }
			    }
			    return productId;
			}
		/**手动输入购买数量*/
		function buyNumChange(o) {
		    // the min reorder num
		    var reco = $("#" + o.id).attr("quantity");
		    //the max reorder num
		    var maxReorder = parseInt($("#buyNums").attr("maxReorder"));
		    //the product's inventory num
		    var aviNum = parseInt($("#inventory").attr("aviNum"));
		    // the input's num
		    var buyNum = parseInt($("#buyNums").val());
		    var reg = /^[1-9]\d*$|^0$/;
		    if (reg.test($("#buyNums").val()) == true) {
			if(maxReorder==0 && aviNum>0){
			    if(buyNum<reco){
				$("#feature").find("em[class='red']").html("您所购买的商品不能小于最低限购量！");
				$("#feature").find("em[class='red']").attr("style", "display:block;");
				inventoryCompare(aviNum,reco);
				dishiqi();
			    }else if(buyNum>aviNum){
				$("#buyNums").attr("value",aviNum);
				$("#buyNums").val(aviNum);
				$("#feature").find("em[class='red']").html("您所填写的商品数量超过库存量！");
				$("#feature").find("em[class='red']").attr("style", "display:block;");
				inventoryCompare(aviNum,aviNum);
				dishiqi();
			    }
			}else if(maxReorder!=0 && aviNum>0){
			    if(maxReorder>aviNum){//抢光了
				if(buyNum<reco){
					$("#feature").find("em[class='red']").html("您所购买的商品不能小于最低限购量！");
					$("#feature").find("em[class='red']").attr("style", "display:block;");
					inventoryCompare(aviNum,reco);
					dishiqi();
				    }else if(buyNum>aviNum){
					$("#feature").find("em[class='red']").html("您所填写的商品数量超过库存量！");
					$("#feature").find("em[class='red']").attr("style", "display:block;");
					inventoryCompare(aviNum,aviNum);
					dishiqi();
				    }
			    }else{//低于最大购买
				if(buyNum<reco){
					$("#feature").find("em[class='red']").html("您所购买的商品不能小于最低限购量！");
					$("#feature").find("em[class='red']").attr("style", "display:block;");
					inventoryCompare(aviNum,reco);
					dishiqi();
				    }else if(buyNum>maxReorder){
					$("#feature").find("em[class='red']").html("您所购买的商品不能大于最高限购量！");
					$("#feature").find("em[class='red']").attr("style", "display:block;");
					inventoryCompare(aviNum,maxReorder);
					dishiqi();
				    }
			    }

			}
		    } else {
			$("#buyNums").val(reco);
			buyNumChange($("#buyNums")[0]);
		    }
		    $("#buyNums").attr("value", $("#buyNums").val());
		}
		featureChoice('<#if productJsonStr?has_content>${StringUtil.wrapString(productJsonStr)}</#if>');
//featureChoice('({"variant":[{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"10739","productFeatureTypeId":"COLOR","description":"黑色"}],"SIZE":[{"productFeatureId":"10771","productFeatureTypeId":"SIZE","description":"XL"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-15","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"16374","productFeatureTypeId":"COLOR","description":"米白"}],"SIZE":[{"productFeatureId":"10950","productFeatureTypeId":"SIZE","description":"XXL"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-12","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"16374","productFeatureTypeId":"COLOR","description":"米白"}],"SIZE":[{"productFeatureId":"10770","productFeatureTypeId":"SIZE","description":"L"}]},"state":0,"isVirtual":"N","inventoryNum":"10","brandName":"曼菲格","productId":"14864-09","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"16868","productFeatureTypeId":"COLOR","description":"水粉"}],"SIZE":[{"productFeatureId":"10769","productFeatureTypeId":"SIZE","description":"M"}]},"state":0,"isVirtual":"N","inventoryNum":"10","brandName":"曼菲格","productId":"14864-02","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"10739","productFeatureTypeId":"COLOR","description":"黑色"}],"SIZE":[{"productFeatureId":"10950","productFeatureTypeId":"SIZE","description":"XXL"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-16","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"16868","productFeatureTypeId":"COLOR","description":"水粉"}],"SIZE":[{"productFeatureId":"10771","productFeatureTypeId":"SIZE","description":"XL"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-03","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"16374","productFeatureTypeId":"COLOR","description":"米白"}],"SIZE":[{"productFeatureId":"10769","productFeatureTypeId":"SIZE","description":"M"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-10","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"16868","productFeatureTypeId":"COLOR","description":"水粉"}],"SIZE":[{"productFeatureId":"10950","productFeatureTypeId":"SIZE","description":"XXL"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-04","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"10739","productFeatureTypeId":"COLOR","description":"黑色"}],"SIZE":[{"productFeatureId":"10770","productFeatureTypeId":"SIZE","description":"L"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-13","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"16868","productFeatureTypeId":"COLOR","description":"水粉"}],"SIZE":[{"productFeatureId":"10770","productFeatureTypeId":"SIZE","description":"L"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-01","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"11833","productFeatureTypeId":"COLOR","description":"灰色"}],"SIZE":[{"productFeatureId":"10771","productFeatureTypeId":"SIZE","description":"XL"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-07","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"11833","productFeatureTypeId":"COLOR","description":"灰色"}],"SIZE":[{"productFeatureId":"10769","productFeatureTypeId":"SIZE","description":"M"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-06","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"11833","productFeatureTypeId":"COLOR","description":"灰色"}],"SIZE":[{"productFeatureId":"10950","productFeatureTypeId":"SIZE","description":"XXL"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-08","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"10739","productFeatureTypeId":"COLOR","description":"黑色"}],"SIZE":[{"productFeatureId":"10769","productFeatureTypeId":"SIZE","description":"M"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-14","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"16374","productFeatureTypeId":"COLOR","description":"米白"}],"SIZE":[{"productFeatureId":"10771","productFeatureTypeId":"SIZE","description":"XL"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-11","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"},{"lastUpdatedStamp":"Tue Dec 02 14:54:40 CST 2014","showReview":"N","productFeature":{"COLOR":[{"productFeatureId":"11833","productFeatureTypeId":"COLOR","description":"灰色"}],"SIZE":[{"productFeatureId":"10770","productFeatureTypeId":"SIZE","description":"L"}]},"state":0,"isVirtual":"N","inventoryNum":"11","brandName":"曼菲格","productId":"14864-05","reviewed":"N","reviewAvgRating":0,"lastUpdatedTxStamp":"Tue Dec 02 14:54:40 CST 2014","productName":"韩版时尚兔毛拼接羽绒服","productPrice":{"listPrice":"528.00","defaultPrice":"265.00"},"reviewTotalNums":0,"isVariant":"Y"}]})');
</script>
  
  
    