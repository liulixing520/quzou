<#assign productUrl><@ofbizCatalogAltUrl productId=product.productId /></#assign>
<#assign smallImageUrl = productContentWrapper.get("SMALL_IMAGE_URL")?if_exists>
<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
<#assign productIndex =requestAttributes.optProductIndex?if_exists/>
<#if product.internalName?has_content>
<#assign pagelanguage = Languages?if_exists>
<#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product,request)!!/>
		<a class="prod-item"  href="${productUrl}">
			  <div class="wrapper util-clearfix">
			      <div class="inner">
			          <div class="img loading">
			            <#if productIndex!=1>
			             <img src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>"  alt="${productName?if_exists}" width="100px"  height="100px">
			            <#else>
			             <img  src="<@ofbizContentUrl>${contentPathPrefix?if_exists}${smallImageUrl}</@ofbizContentUrl>"  alt="${productName?if_exists}" width="180px"  height="180px">
			            </#if>
			          </div>
			          <div class="description">
			               <div class="bottom">
			                   <span class="prod-title"><font title="${productName?if_exists}">
			                     
			                      </font>
			                    </span>
			                    <span class="price" style="display:block; padding-top:10px; color:#BD1A1D; font-weight:bold; font-size:18px; padding-bottom:5px;"><em><font><@ofbizCurrency amount=price.price isoCode=price.currencyUsed/></font></em></span>
			                </div>
			            </div>
			         </div>
			     </div>
		</a>
			      
</#if>               


			        



