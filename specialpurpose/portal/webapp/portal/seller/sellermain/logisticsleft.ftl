<ul class="nav nav-list">

    <li class="highlight">
        <a href=""<@ofbizUrl>merchantInfo</@ofbizUrl>" class="dropdown-toggle">
            <span class="menu-text"> 物流管理</span>

            <b class="arrow fa fa-angle-down"></b>
        </a>

        <b class="arrow"></b>

        <ul class="submenu">
          <!--  <li class="">
                <a href="<@ofbizUrl>merchantInfo</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                   商户信息
                </a>
                <b class="arrow"></b>
            </li>-->

<li class="" id="seller_listAddress">
                <a href="<@ofbizUrl>seller_listAddress</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    退货地址管理
                </a>
                <b class="arrow"></b>
            </li>
            <li class="" id="seller_listFacilityAddress">
                <a href="<@ofbizUrl>seller_listFacilityAddress</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    发货地址管理
                </a>
                <b class="arrow"></b>
            </li>
            <li class="" id="EditProductStoreShipSetup">
                <a href="<@ofbizUrl>EditProductStoreShipSetup</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    物流管理
                </a>
                <b class="arrow"></b>
            </li>
        <#--    <li class="">
                <a href="<@ofbizUrl></@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    银行账户
                </a>
                <b class="arrow"></b>
            </li>
-->
<#--            <li class="">
                <a href="buttons.html">
                    <i class="menu-icon fa fa-caret-right"></i>
                    关联产品模板
                </a>

                <b class="arrow"></b>
            </li>-->

        </ul>
    </li>

    
</ul><!-- /.nav-list -->

<script type="text/javascript">
    $(function () {
    <#if NavigationLi?has_content>
        $(${(NavigationLi)!}).parent("ul").parent("li").attr("class", "hsub open");
        $(${(NavigationLi)!}).parent("ul").css("display", "block");
        $(${(NavigationLi)!}).attr("class", "active");
    </#if>
    });
</script>