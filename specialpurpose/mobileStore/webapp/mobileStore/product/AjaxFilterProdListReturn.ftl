<#if showProdInfoList?? && showProdInfoList?size &gt; 0>
	<#list showProdInfoList as showProdInfo>
		<li class="new-mu_l2">
		<#--
		prodInfo.productName = prod.productName
		prodInfo.productId = prod.productId
		stock
		price
		attrInfo[attrName : attrValue]
		saleQuantity
		
		-->
			<a href="productDetail?product_id=${showProdInfo.productId!}" class="new-mu_l2a">
				<span class="new-mu_tmb"><img src="${showProdInfo.imgPath!}" width="100" height="100"></span>
				<span class="new-mu_l2cw">
				<strong class="new-mu_l2h">${showProdInfo.productName!}</strong>
				<span class="new-mu_l2h"><span class="new-txt-rd2 new-elps"></span></span>
				<span class="new-mu_l2c"><strong class="new-txt-rd2">￥${showProdInfo.price!'0.00'}</strong></span>
				<span class="new-mu_l2c new-p-re"><span class="new-txt">已售出${showProdInfo.saleQuantity!'0'}件</span><span class="new-sale-icon"></span></span>
				</span>
			</a>
		</li>
	</#list>
<#else>
	<div class="new-cp-prom2">
        <span class="new-logo2"></span>
        <strong class="new-span-block">抱歉暂时没有相关结果，换个词试试吧</strong>
    </div>
</#if>