	<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId productCategoryId=categoryId/></#assign>
	<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
                  		<tr>
		                    <td class="center">
		                    <label class="position-relative">
              				<input type="checkbox" class="ace">
              				<span class="lbl"></span> </label>
              				<!--
		                    <input id="ckbox208268522" class="j-check-group-id" name="prodShelfForm.itemcodeChecked" value="208268522" type="checkbox"><span class="lbl"></span></input>
		                    -->
		                    </td>
		                    <td class="padimg"><span class="prolayout"> <a href="#" target="_blank"> <img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>"> </a> </span> <span class="serveicon"> </span> </td>
		                    <td class="padpro"><span class="padright40 clearfix"> <a href="#" target="_blank"> ${product.internalName?if_exists} </a> </span> <span class="gearycolor"> 产品编号：${product.productId?if_exists}<br>
		                      </span> </td>
		                      <td class="hidden-480">未分组</td>
		                      <!--
		                    <td class="productgroup"><span class="groupreline"> 未分组 </span></td>
		                    -->
		                    <td class="hidden-480" ProdItemecode="208268522" data-itemcode="208268522"><span class="tipstion tipstion03"> <span class="priceiconbox newcolor defaultstyle">
		                      <div> <span>实收：</span> <span class="pricebox"> <@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></span> </div>
		                      <div> <span>买价：</span> <span class="pricebox"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></span> </div>
		                      <div> <span>买价：</span> <span class="pricebox"><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></span> </div>
		                      </span> </span> </td>
		                    <td class="right">${orderQuantity}</td>
		                    <td>${product.salesDiscontinuationDate?if_exists}</td>
		                    <td class="marketingstatus"><span style="display: none;" id="trafficbus_208268522" title="流量快车" name="marketStatus_trafficbus" data-itemcode="208268522">快车</span> <span style="display: none;" class="s-show" title="展示">展示</span> <span style="display: none;" class="s-bidding" title="竞价">竞价</span> <span style="display: none;" class="s-price" title="定价">定价</span> </td>
		                    <td class="operation"><a href="<@ofbizUrl>EditProduct?productId=${product.productId?if_exists}</@ofbizUrl>">修改产品信息</a><br>
		                      <a href="<@ofbizUrl>createProduct</@ofbizUrl>">添加类似产品 </a><br>
		                      <a href="<@ofbizUrl>EditProduct?productId=${product.productId?if_exists}</@ofbizUrl>">更改价格</a><br>
		                    </td>
		            	</tr>