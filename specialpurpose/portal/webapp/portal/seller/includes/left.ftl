<#assign url = request.getPathInfo()>
<#assign url = url.substring(url.indexOf("/")+1)>
<div class="wrap clearfix">
        <div class="nav">
    <!--<h2 class="title"><a href="http://chunbo.com/member/index.html">我的春播</a></h2>-->
    <dl>
        <dt>交易管理</dt>
        <dd class="<#if url=="FindOrderEn">on</#if>"><a href="<@ofbizUrl>FindOrderEn</@ofbizUrl>"> 销售订单 </a></dd>
        <dd class="<#if url=="FindOrderDx">on</#if>"><a href="<@ofbizUrl>FindOrderDx</@ofbizUrl>"> 分销订单 </a></dd>
        <dd class="<#if url=="findreturn">on</#if>"><a href="<@ofbizUrl>findreturn</@ofbizUrl>"> 退货订单 </a></dd>
        <dd class="<#if url=="review">on</#if>"><a href="<@ofbizUrl>review</@ofbizUrl>"> 客户咨询 </a></dd>
    </dl>
    <dl>
        <dt>商品管理</dt>
        <dd class="<#if url=="EditProductEn">on</#if>"><a href="<@ofbizUrl>EditProductEn</@ofbizUrl>"> 添加商品 </a></dd>
        <dd class="<#if url=="FindProductEn">on</#if>"><a href="<@ofbizUrl>FindProductEn</@ofbizUrl>"> 商品列表 </a></dd>
        <dd class="<#if url=="FindProductDx">on</#if>"><a href="<@ofbizUrl>FindProductDx</@ofbizUrl>"> 分销商品列表 </a></dd>
    </dl>
    <dl>
        <dt>店铺管理</dt>
        <dd class="<#if url=="store">on</#if>"><a href="<@ofbizUrl>store</@ofbizUrl>"> 店铺基本信息 </a></dd>
        <!--<dd class="<#if url=="FindSupplierQualSm">on</#if>"><a href="<@ofbizUrl>FindSupplierQualSm</@ofbizUrl>">资质信息</a></dd>-->
        <dd class="<#if url=="FindSupplierQualSm">on</#if>"><a href="<@ofbizUrl>merchantInfo</@ofbizUrl>">资质信息</a></dd>
        <dd class="<#if url=="FindCuserTomerCatalog">on</#if>"><a href="<@ofbizUrl>FindCuserTomerCatalog</@ofbizUrl>">自定义商品分类</a></dd>
        <!--<dd class="<#if url=="merchantInfo">on</#if>"><a href="<@ofbizUrl>merchantInfo</@ofbizUrl>"> 店主信息管理 </a></dd>-->
        <dd class="<#if url=="seller_listFacilityAddress">on</#if>"><a href="<@ofbizUrl>seller_listFacilityAddress</@ofbizUrl>"> 发货地址管理 </a></dd>
        <dd class="<#if url=="EditProductStoreShipSetup">on</#if>"><a href="<@ofbizUrl>EditProductStoreShipSetup</@ofbizUrl>"> 物流管理 </a></dd>
        <dd class="<#if url=="mySupplier">on</#if>"><a href="<@ofbizUrl>mySupplier</@ofbizUrl>"> 我的供应商 </a></dd>
        <dd class="<#if url=="myDxStore">on</#if>"><a href="<@ofbizUrl>myDxStore</@ofbizUrl>"> 我的分销商 </a></dd>
        <dd class="<#if url=="myDxStore">on</#if>"><a href="<@ofbizUrl>myDxStore</@ofbizUrl>"> 我的导购员 </a></dd>
        <dd class="<#if url=="FindCashBm">on</#if>"><a href="<@ofbizUrl>FindCashBm</@ofbizUrl>"> 提现</a></dd>
        
    </dl>
  
</div>