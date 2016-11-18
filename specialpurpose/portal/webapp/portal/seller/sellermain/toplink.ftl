<#assign shoppingCartMap = sessionAttributes.shoppingCartMap?if_exists>
<#if shoppingCartMap?has_content>
    <#assign shoppingCartSize = shoppingCartMap.size()>
<#else>
    <#assign shoppingCartSize = 0>
</#if>

 <#if shoppingCartMap?has_content>
 	<#assign totalQuantity = shoppingCartMap.getTotalQuantity()>
<#else>
    <#assign totalQuantity = 0>
</#if>
<div class="header">
    <div class="header_top">
        <div class="header_top_inner">
            <a href="<@ofbizUrl>main</@ofbizUrl>" class="header_logo"><img src="/portal/images/logo-1x.png" alt=""></a>
            <div class="search_box">
                <form id="form-searchbar" class="searchbar-form" method="post" action="<@ofbizUrl>keywordsearch</@ofbizUrl>">
                  	<input type="hidden" name="VIEW_SIZE" value="10"/>
	                <input type="hidden" name="PAGING" value="Y"/>
	                <input type="hidden" name="SEARCH_CATEGORY_ID" value="all"/>
	                <input class="text" placeholder="搜索" id="search_key" name="SEARCH_STRING" type="text"/>
                	<input class="btn" id="search_key_btn" style="cursor:pointer;" type="submit"/>
                </form>
            </div>
            <div class="header_top_right">
                <div class="header_cart">
                    <a href="<@ofbizUrl>showcart</@ofbizUrl>" target="_blank" class="cart_a">我的购物车
	                    <span id="nav-cart-num" class="num">${totalQuantity?default('0')}</span>
                        <!--<span class="num">5</span>-->
                        <span class="icon"></span></a>

                    <div class="cart_slide" style="display: none;">
		                    <h2 class="cart_slide_title">
						        最新加入的商品
						    </h2>
				    	<ul class="cart_shop_list">
				    		<#if shoppingCartMap?has_content && shoppingCartMap.getShoppingCartList()?has_content && (shoppingCartMap.size()>0)>
					    		<#list shoppingCartMap.getShoppingCartList() as innerCart>
						    		<#assign productStoreId= innerCart.getProductStoreId()/>
					            	<#if (innerCart.size()>0)>
					            		<#list innerCart.items() as cartLine>
					            			<#if cartLine.getParentProductId()?exists>
						                        <#assign parentProductId = cartLine.getParentProductId() />
						                    <#else>
						                        <#assign parentProductId = cartLine.getProductId() />
						                    </#if>
								    		<#assign cartLineIndex = innerCart.getItemIndex(cartLine) />
						                    <#assign smallImageUrl = Static["org.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(cartLine.getProduct(), "SMALL_IMAGE_URL", locale, dispatcher)?if_exists />
						                    <#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg" /></#if>
									    	<li class="clearfix smallCartProduct" id="${productStoreId}_${cartLineIndex}">
									            <a class="pic" href="<@ofbizCatalogAltUrl productId=parentProductId/>" target="_blank"><img src="${smallImageUrl!}"></a>
									            <p class="name"><a href="<@ofbizCatalogAltUrl productId=parentProductId/>" target="_blank"> 
								                       <#-- 判断商品语种-->
								 					<#assign product=cartLine.getProduct() />
														<#assign productName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product, request)/>
																						${productName!} </a>
									            <p class="num"> <b><@ofbizCurrency amount=cartLine.getDisplayPrice() isoCode=innerCart.getCurrency()/></b><span> x${cartLine.getQuantity()?string.number}</span></p>
									            <input name="smallCartQuantity" value="1" class="smallCartQuantity" type="hidden">
									            <a href="javascript:void(0);" class="delete" onclick="delCartProduct('${cartLineIndex}','${productStoreId}',${cartLine.getQuantity()?string.number},${cartLine.getDisplayPrice()})"> </a>
									        </li>
									        </#list>
							        </#if>
				    			</#list>
				    		</#if>
				        </ul>
					    <div class="cart_bottom">
					        <a href="<@ofbizUrl>checkout</@ofbizUrl>" target="_blank" class="goto_cart">去结算</a>
					        <span class="price">共计<span>￥</span><span id="cartTotalPrice">${shoppingCartMap.getDisplaySubTotal()!}</span>
					        </span>
		    			</div>
				   		<input name="headerProductNum" id="headerProductNum" value="${totalQuantity?default('0')}" type="hidden">
			    	</div>
            </div>
                <div class="header_message clearfix">
                    <div class="header_login">
                        <!--<a href="http://chunbo.com/member/index.html" class="green_a" id="login_user_name">-->
                    		<#if sessionAttributes.autoName?has_content>
                                <a href="<@ofbizUrl>userMain</@ofbizUrl>">${sessionAttributes.autoName?html}</a>
                            <#else>
                                <a href="<@ofbizUrl>login</@ofbizUrl>">${uiLabelMap.PortalLogin}</a>
                            </#if>
                            &nbsp;&nbsp;
                            <!--</a>-->
                    </div>
                    <div class="header_myhome">
	                	<a href="#" class="myhome_a">我的物美<span></span></a>
	                  	<div class="myhome_slide" style="display: none;">
	                        <ul>
	                            <li><a href="<@ofbizUrl>EditProductEn</@ofbizUrl>">发布商品</a></li>
	                            <li><a href="<@ofbizUrl>FindOrderEn</@ofbizUrl>">销售订单</a></li>
	                            <li><a href="<@ofbizUrl>logout</@ofbizUrl>" class="green_a" id="logout">退出</a></li>                            
	                         </ul>
	                  </div>
                 </div>
                </div>
            </div>
        </div>
    </div>