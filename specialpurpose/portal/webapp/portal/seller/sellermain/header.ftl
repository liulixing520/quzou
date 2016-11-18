<!--
<div id="navbar" class="navbar navbar-default">
    <div class="navbar-container container" id="navbar-container">

        <nav role="navigation" class="navbar-menu pull-left navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="<@ofbizUrl>sellerIndex</@ofbizUrl>"> 首页 </a>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 商品管理 </a>
                    <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                        <li><a href="<@ofbizUrl>EditProductEn</@ofbizUrl>"> 添加商品 </a></li>
                        <li><a href="<@ofbizUrl>FindProductEn</@ofbizUrl>"> 商品列表 </a></li>
                        <#--<li><a href="<@ofbizUrl>brandmanage</@ofbizUrl>"> 品牌管理 </a></li>-->
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 交易 </a>
                    <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                        <li><a href="<@ofbizUrl>FindOrderEn</@ofbizUrl>"> 订单列表 </a></li>
                        <li><a href="<@ofbizUrl>findreturn</@ofbizUrl>"> 退货订单 </a></li>
                        <#-- 
                        <li><a href="<@ofbizUrl>appraisal</@ofbizUrl>"> 评价管理 </a></li>
                        -->
                        <li><a href="<@ofbizUrl>review</@ofbizUrl>"> 客户咨询 </a></li>
                    <#--<li><a href="<@ofbizUrl>appraisal</@ofbizUrl>"> 评价管理 </a></li>-->
                    <#--<li><a href="#">返还佣金</li>-->
                    <#--<li><a href="#"> 在线物流 </a></li>
                    <li><a href="#"> 评价和评论管理 </a></li>-->
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 店铺管理 </a>
                    <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                        <li><a href="<@ofbizUrl>store</@ofbizUrl>"> 店铺信息管理 </a></li>
                        <li><a href="<@ofbizUrl>merchantInfo</@ofbizUrl>"> 店主信息管理 </a></li>
                        <li><a href="<@ofbizUrl>mySupplier</@ofbizUrl>"> 我的供应商 </a></li>
                        <li><a href="<@ofbizUrl>myDxStore</@ofbizUrl>"> 我的代理商 </a></li>
                        <li><a href="<@ofbizUrl>FindCashBm</@ofbizUrl>"> 提现</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 物流 </a>
                    <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                        <li><a href="<@ofbizUrl>seller_listAddress</@ofbizUrl>"> 退货地址管理 </a></li>
                        <li><a href="<@ofbizUrl>seller_listFacilityAddress</@ofbizUrl>"> 发货地址管理 </a></li>
                        <li><a href="<@ofbizUrl>EditProductStoreShipSetup</@ofbizUrl>"> 物流管理 </a></li>
                    <#-- <li><a href="#"> 银行账户 </a></li>-->
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 报表 </a>
                    <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                        <li><a href="<@ofbizUrl>buyCartGoods</@ofbizUrl>"> 购物车商品 </a></li>
                        <li><a href="<@ofbizUrl>buyCartOutGoods</@ofbizUrl>"> 购物车弃购商品 </a></li>
                        <#-- 
                        <li><a href="<@ofbizUrl>bestSellingGoods</@ofbizUrl>"> 畅销商品 </a></li>
                        -->
                        <li><a href="<@ofbizUrl>salesAmountGoods</@ofbizUrl>"> 商品销售额列表 </a></li>
                        <li><a href="<@ofbizUrl>salesVolumeGoods</@ofbizUrl>"> 商品销售量列表 </a></li>
                        <li><a href="<@ofbizUrl>mySellerbuyer</@ofbizUrl>"> 我的买家列表 </a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 账号中心 </a>
                    <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                        <li><a href="<@ofbizUrl>seller_EditUserLogin</@ofbizUrl>"> 修改密码 </a></li>
                        <li><a href="<@ofbizUrl>seller_userEmail</@ofbizUrl>"> 修改邮箱 </a></li>
                    <#-- <li><a href="#"> 设置密保问题 </a></li>-->
                        <li><a href="<@ofbizUrl>stor_certification</@ofbizUrl>"> 身份验证 </a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> 分销</a>
                    <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                        <li><a href="<@ofbizUrl>agentProductStore</@ofbizUrl>">分销商家 </a></li>
                        <li><a href="<@ofbizUrl>agentProduct</@ofbizUrl>"> 分销商品</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</div>
-->
<script type="text/javascript">
    $(document).ready(function () {
        /*// 关闭鼠标点击展开菜单
        $(document).off('click.bs.dropdown.data-api');*/

        // 调用鼠标滑过展开菜单
        dropdownOpen();
    });
    /**
     * 鼠标划过就展开子菜单
     */
    function dropdownOpen() {
        var $dropdownLi = $('li.dropdown');
        $dropdownLi.mouseover(function () {
            $(this).addClass('open');
        }).mouseout(function () {
            $(this).removeClass('open');
        });
    }
</script>
