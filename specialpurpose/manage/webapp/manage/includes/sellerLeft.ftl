<ul class="nav nav-list">
    <li class="open hsub">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 卖家 </span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu submenu nav-show" style="display: block;">
            <li class="" id="mng_sellerInfo">
                <a href="<@ofbizUrl>mng_sellerInfo</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                     卖家信息 
                </a>
            </li>
            <li class="" id="">
                <a href="javascript:void(0)" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
              黑名单 
                </a>
            </li>
            <li class="" id="mng_sellerExamine">
                <a href="<@ofbizUrl>mng_sellerExamine</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                   卖家申请审核 
                </a>
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