<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<#assign productNameText><@htmlTemplate.productName product=product request=request/></#assign>
<li class="product-item">
					<a href="${productUrl?if_exists}" target="_blank">
						<img src="${smallImageUrl?if_exists}" style="visibility: visible; ">
					</a>
					
					<div class="rank-orders">
						<div class="rank"><font><font>${productNameText?if_exists}</font></font></div>
						
					</div>
					<a href="${productUrl?if_exists}" class="item-desc" target="_blank"><font><font>${product.description?if_exists}</font></font></a>
					<div class="item-price">
					
						<div class="price"><font><font> <@ofbizCurrency amount=price.price isoCode=price.currencyUsed/> </font></font></div>
						<div class="uint"><font><font>/件</font></font></div>
					</div>
					<div class="stars-feedback">
						<span class="star">
							<span class="rate-percent" style="width:56%"></span>
						</span>
						<span class="feedback"><font><font></font></font></span>
					</div>
				</li>
				
				
				
