<ul class="nav nav-list">

    <li>
        <a href="#" class="dropdown-toggle">
            <span class="menu-text">报表管理</span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu">
            <li id="buyCartGoods">
                <a href="<@ofbizUrl>buyCartGoods</@ofbizUrl>" class="">
                    购物车商品 
                </a>
                <b class="arrow"></b>
            </li>
            <li id="buyCartOutGoods">
                <a href="<@ofbizUrl>buyCartOutGoods</@ofbizUrl>" class="">
                    购物车弃购商品 
                </a>
                <b class="arrow"></b>
            </li>
            <#-- 
            <li>
                <a href="<@ofbizUrl>bestSellingGoods</@ofbizUrl>" class="">
                    畅销商品
                </a>
                <b class="arrow"></b>
            </li>
            -->
             <li id="salesAmountGoods">
                <a href="<@ofbizUrl>salesAmountGoods</@ofbizUrl>" class="">
                   商品销售额列表
                </a>
                <b class="arrow"></b>
            </li>
            <li id="salesVolumeGoods">
                <a href="<@ofbizUrl>salesVolumeGoods</@ofbizUrl>" class="">
                    商品销售量列表 
                </a>
                <b class="arrow"></b>
            </li>
            <li id="mySellerbuyer">
                <a href="<@ofbizUrl>mySellerbuyer</@ofbizUrl>" class="">
                    我的买家列表
                </a>
                <b class="arrow"></b>
            </li>           
        </ul>
    </li>
</ul>

<script type="text/javascript">
    $(function () {
    <#if NavigationLi?has_content>
        $(${(NavigationLi)!}).parent("ul").parent("li").attr("class", "hsub open");
        $(${(NavigationLi)!}).parent("ul").css("display", "block");
        $(${(NavigationLi)!}).attr("class", "active");
    </#if>
    });
</script>