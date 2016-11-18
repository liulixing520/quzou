<!DOCTYPE html>
<!--精选商品页面-->
<html style="height: 100%; " class="translated-ltr"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      
    <meta charset="utf-8">
    <title>超级优惠 - 精选优惠</title>
        <meta name="robots" content="nofollow,noindex">
        <meta name="data-spm" content="5261">
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style>
            #footer { clear: both;padding: 10px 0;text-align: center;border-top: 1px solid #CCC;margin-top: 15px;font: .85em/14px verdana; }
        </style>
    
<link rel="stylesheet" href="../images/css/layout-990-34-30-30?v=20140109">
<link rel="stylesheet" type="text/css" href="../seller/css/specialOffer.css">

<link charset="utf-8" rel="stylesheet" href="../images/css/window-base.css">
<link type="text/css" rel="stylesheet" charset="UTF-8" href="../images/css/translateelement.css">
<link rel="stylesheet" type="text/css" href="/portal/images/css/footer.css">

<script type="text/javascript" charset="UTF-8" src="../images/js/main_zh-CN.js"></script>
<script type="text/javascript" charset="UTF-8" src="../images/js/element_main.js"></script>
<body data-spm="7390502" data-pageid="1182541" data-widget-cid="widget-73" class="day-5" style="position: relative; min-height: 100%; "> 
</head>
<div id="page">
<div id="content">
<div class="J_Layout layout grid-m">
	<div class="col-main">
		<div class="J_Module skin-default" data-name="mm-ae-superdeal-category-product" data-skin="default" data-guid="14072775889890" id="guid-14072775889890" data-version="186" data-type="3"><div class="module" data-spm="1998074813"><style>
.mm-ae-superdeal-category-product.cat-loaded #sd-catagory-waterfall .sd-filter { display:block; }</style>
<div class="tb-module mm-ae-superdeal-category-product cat-loaded" data-ttid="812328" data-btn-text="" data-hassort="yes">
	<div id="sd-catagory-waterfall" class="container">
		<h3>
			<span class="text"><font><font>${uiLabelMap.PortalSuperDeals}</font></font></span>
					</h3>
		<#-- 类别  -->			
		<#--  <div id="sd-catagory-tab"><div class="sd-catagory">
				<div class="waterfall-tab">
					<a href="javascript:void(0);" tabid="1021557" icon="all" class="cat-item item selected"><font><font>所有</font></font></a>
					<a href="javascript:void(0);" tabid="1021561" icon="women" class="cat-item item"><font><font>女装</font></font></a>
					<a href="javascript:void(0);" tabid="1021563" icon="men" class="cat-item item"><font><font>男装</font></font></a>
					<a href="javascript:void(0);" tabid="1021565" icon="kids" class="cat-item item"><font><font>童装</font></font></a>
					<a href="javascript:void(0);" tabid="1022091" icon="shoes" class="cat-item item"><font><font>鞋</font></font></a>
					<a href="javascript:void(0);" tabid="1024524" icon="bags" class="cat-item item"><font><font>包</font></font></a>
					<a href="javascript:void(0);" tabid="1024526" icon="accessories" class="cat-item item"><font><font>配饰</font></font></a>
					<a href="javascript:void(0);" tabid="1051696" icon="jewelry" class="cat-item item"><font><font>珠宝</font></font></a>
				</div>
			</div>
			<div class="fixed-wrap">
				<div class="fixed-wrap-inner">
					<div class="sd-filter">
						<div class="sd-recent-view"><font><font>
							最近浏览
						</font></font></div>
						<div class="sd-filter-inner">
							<a href="javascript:void(0);" class="sort-item item selected" order-type="default"><font><font>最佳匹配</font></font></a>
							<a href="javascript:void(0);" class="sort-item item" order-factor-id="1004" order-type="desc" order="desc" current=""><font><font>折扣</font></font></a>
							<a href="javascript:void(0);" class="sort-item item" order-factor-id="1003" order-type="ad" order="ad" current=""><font><font>价格</font></font></a>
							<a href="javascript:void(0);" class="sort-item item" order-factor-id="1001" order-type="desc" order="desc" current=""><font><font>的订单</font></font></a>
							<a href="javascript:void(0);" class="sort-item item" order-factor-id="1002" order-type="desc" order="desc" current=""><font><font>卖家评级</font></font></a>
						</div>
						<div class="sd-recent-view-wrap"></div>
					</div>
				</div>
			</div></div> -->
		<div class="sd-products-wrap">
			<ul class="sd-products-wrap-inner">
			<#if weeklyCategoryMembers?has_content>
        	<#assign appCount = 0>
			<#list weeklyCategoryMembers as productCategoryMember>
				<li class="sd-product-outer" style="height:270px;">
				  ${setRequestAttribute("optProductId", productCategoryMember.productId)}
				  ${screens.render("component://portal/widget/CatalogScreens.xml#productsummaryForSuper")}
				</li>
			</#list>
			<#else>
			</#if>
			</ul>
		</div>
		
<form  action="<@ofbizUrl>commoditySpecialOffer</@ofbizUrl>" id="FindProductEn" method="GET">
<form>
<#include "component://portal/webapp/portal/includes/sellerpagination.ftl"/>      
<@paginationSimple  listSize viewSize viewIndex  'FindProductEn' 'FindProductEn' parameters.sortField!/>

	</div>
	<script type="text/mustache-template" class="J-tab-template">
			<div class="sd-catagory">
				<div class="waterfall-tab">
					{{#nodeTree}}
					<a href="javascript:void(0);" tabid="{{nodeId}}" icon="{{icon}}" class="cat-item item">{{nodeName}}</a>
					{{/nodeTree}}
				</div>
			</div>
			<div class="fixed-wrap">
				<div class="fixed-wrap-inner">
					<div class="sd-filter">
						<div class="sd-recent-view">
							Recently Viewed
						</div>
						<div class="sd-filter-inner">
							<a href="javascript:void(0);" class="sort-item item selected"  order-type="default">Best Match</a>
							{{#orderFactor}}
							<a href="javascript:void(0);" class="sort-item item" order-factor-id="{{orderFactorId}}" order-type="{{orderType}}" order="{{orderType}}" current="">{{orderFactorName}}</a>
							{{/orderFactor}}
						</div>
						<div class="sd-recent-view-wrap"></div>
					</div>
				</div>
			</div>
	</script>
	<script type="text/mustache-template" class="J-gagatab-template">
			<div class="sd-catagory">
				<div class="waterfall-tab">
					{{#nodeTree}}
					<a href="javascript:void(0);" tabid="{{nodeId}}" icon="{{icon}}" class="cat-item item gaga-cat">{{nodeName}}</a>
					{{/nodeTree}}
				</div>
			</div>
	</script>
	<script type="text/mustache-template" class="J-productList-template">
		{{#productList}}
			<li class="sd-product-outer">
				<div class="sd-product-inner">
					<div class="sd-product" data-name="{{productName}}" data-img="{{productImgUrl}}" data-link="{{productStoreDetailUrl}}">
						<div class="sd-label">
							<span class="number">{{productDiscount}}</span><span class="percent">%</span>
							<span class="off">OFF</span>
						</div>
						<a target="_blank" href="{{productStoreDetailUrl}}" productId="{{productId}}" class="img-wrap">
							<img src="{{productImgUrl}}" class="img-responsive" alt="{{productName}}"></a>
						</a>
						<a target="_blank" href="{{productStoreDetailUrl}}" productId="{{productId}}" class="title-wrap" title="{{productName}}">
							{{productName}}	
						</a>
						<div class="price-wrap">
							<span class="amount">US {{productDiscountMinPrice}}</span>
							<span class="unit">/ {{productUnitTypeSingle}}</span>
						</div>
						<div class="footer-wrap clearfix">
							<div class="price-extra-wrap">
								<div class="origin-wrap">
									<span class="value-title">Value: </span>
									<span class="amount">US {{productMinPrice}}</span>
									<span class="unit">/ {{productUnitTypeSingle}}</span>
								</div>
								<div class="save-wrap">
									<span class="save-title">You Save: </span>
									<span class="save-amount">US {{productSave}}</span>
								</div>
							</div>
							<div class="action-wrap">
								{{^isSoldOut}}
								<a target="_blank" href="{{productStoreDetailUrl}}" productId="{{productId}}" class="sd-button">{{btnText}}</a>
								<a target="_blank" href="{{productStoreDetailUrl}}" data-prodId="{{productId}}" productId="{{productId}}" class="sd-button add2wishlist to-be-add-to-wish-list"><span class="icon"></span><span class="text">Add to Wish List</span></a>
								{{/isSoldOut}}
								{{#isSoldOut}}
								<span productId="{{productId}}" class="sd-button sd-sold-out">Sold Out</span>
								{{/isSoldOut}}
							</div>
						</div>
					</div>
					<div class="sold-wrap">
						&nbsp; 
					</div>
				</div>
			</li>
		{{/productList}}
	</script>
</div>
</div></div>
</div>
</div></div>
</div>
</div>
<div class="ui-fixed-panel" style="position: fixed; visibility: visible; left: 1261px; top: 456px; " data-widget-cid="widget-11">
	
<div class="ui-fixed-panel-operation" data-role="operationArea">
<div class="ui-fixed-panel-unit ui-fixed-panel-go-top" data-role="hide" data-widget-cid="widget-12" style="visibility: hidden; opacity: 1; ">
<a href="" data-role="trigger"></a>
</div>
</div>
</div>

<div class="started-activity-container">
<hr style="color: #CCC; background-color: #CCC; height: 1px; border: none;">
<div class="activity-root"></div></div></div>
<div class="status-message" style="display: none; "></div></div>

<div data-widget-cid="widget-3"></div>
<iframe frameborder="0" class="goog-te-menu-frame skiptranslate" style="visibility: visible; box-sizing: content-box; width: 721px; height: 274px; display: none; "></iframe>
<iframe frameborder="0" class="goog-te-menu-frame skiptranslate" style="visibility: visible; box-sizing: content-box; width: 716px; height: 274px; display: none; "></iframe>
<iframe frameborder="0" class="goog-te-menu-frame skiptranslate" style="visibility: visible; box-sizing: content-box; width: 135px; height: 108px; display: none; "></iframe>
</body>
</html>