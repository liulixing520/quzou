<#assign shoppingCart = Static["org.ofbiz.order.shoppingcart.ShoppingCartEvents"].getCartObject(request)>
<form method="post" action="modifycart" name="cartform">
	<input type="hidden" name="removeSelected" value="false"/>

	<span class="gwc_target target table">
		<div class="title"><i>购物车</i><a href="showcart" class="num bgcor-red cartNum">${(shoppingCart.size()?default(0))!}</a></div>
		<div class="temporary_bar gwcModule">
			<div class="t_b_tip">购物车</div>
			<div>
				<dl>
					<dt>
						<span style="width: 5%;text-align:center;">
						<#--<input type="checkbox" class="checkAll mt12" name="selectAll" data-name="18" onclick="toggleAll(this);"/>-->
						</span>
						<span style="width: 27%;">商品名称</span>
						<span style="width: 18%;">价格</span>
						<span style="width: 14%;">数量</span>
						<span style="width: 14%;">折扣</span>
						<span style="width: 17%;">折后价格</span>
					</dt>
				</dl>
			</div>
			<div id="barListContentInfor2" style="/*overflow:overlay;*/height:260px;overflow-y:auto;" class="">
				<#if shoppingCart?has_content>
					<#assign cartItems = shoppingCart.items()/>
					<#list cartItems as item>
						<#assign cartIndex=shoppingCart.getItemIndex(item)/>

						<#assign defaultPrice = delegator.findByAnd("ProductPrice", {"productId" :"${(item.getProductId())!}","productPriceTypeId":"DEFAULT_PRICE"}) >
						<#assign product = delegator.findByPrimaryKey("Product", {"productId" :"${(item.getProductId())!}"}) >
						<dl id="cart_${(cartIndex)!}">
							<dd>
								<span style="width: 5%;text-align:center;">
									<input type="checkbox" name="selectedItem" title="${(item.getProductId())!}" value="${(cartIndex)!}" class="checkItem mt12" data-name="18" />
								</span>
								<span style="width: 27%;" class="productNameSet" title="${(item.getName())!}">${(item.getName())!}
								<input name="price_${(cartIndex)!}" type="hidden" value="${(item.getBasePrice())!}"/>
								</span>
								<span class="rightbar productBasePrice" style="width: 18%;">
								${(defaultPrice[0].price)?default(item.getBasePrice())!}
								</span>

								<span class="rightbar productNumber" style="width: 14%;">
									<input class="barInputUpdate inp-text" style="width:30px" name="update_${(cartIndex)!}" type="text" value="${(item.getQuantity())!}"
									 onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,1);}).call(this)"
									  onblur="this.v();"/>
								</span>
								<span class="rightbar productDiscount" style="width: 14%;">
								<#if defaultPrice?has_content>
									<#if defaultPrice[0].price!=0>
										${(item.getBasePrice()/(defaultPrice[0].price))?string("0.00")!}
										<#else>
										1
									</#if>
								<#else>
								1
								</#if>
								</span>
								<span class="rightbar productDisPrice" style="width: 17%;">
									<#if product.primaryProductCategoryId =='BEAUTY_PRODUCT' || product.primaryProductCategoryId =='BEAUTY_ITEM'>
										<input class="barInputUpdate inp-text" name="defaultPriceAll_${(cartIndex)!}" type="text" value="${(item.getBasePrice()*item.getQuantity())!}" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9]+/,1);}).call(this)" onblur="this.v();"/>
									</#if>
								</span>
							   <!-- <span class="t_b_del out out_right" onclick="removeCartItem('${(cartIndex)!}');"><b class="iconfont"></b></span>-->
							</dd>
						</dl>
					</#list>
				</#if>
			</div>
			<div class="table_control mt5" style="height:30px;">
				<div class="t_c_inp">
					<input type="checkbox" data-name="18"name="selectAll" id="checkAll" class="checkAll mt5 ml3">
				</div>
				<div class="t_c_btn"><#--removeCartItemAll();-->
					<span style="cursor:pointer;" onclick="removeShowCart()" class="btn mm btn-default">删除</span>
				</div>
			</div>
			<div class="temporary_remind"><a href="findProduct" class="col_f83976" >赶快去购物吧！</a></div>
			<div class="t_b_control">
				<#if security.hasPermission("PCPOS_checkout", session)>
					<a href="javascript:" id="cartJs" onclick="jinrujiesuan()" class="btn btn-accounts">进入结算</a>
				</#if>
			</div>
		</div>
	</span>
</form>
