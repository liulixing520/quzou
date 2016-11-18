<ul class="nav nav-list">
    <li class="open hsub">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 网站管理 </span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu submenu nav-show" style="display: block;">
            <li class="" id="mng_PageSetting">
                <a href="<@ofbizUrl>mng_PageSetting</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                      广告位管理  
                </a>
            </li>
            <li class="" id="mng_announcementSetting">
                <a href="<@ofbizUrl>mng_announcementSetting</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
              公告管理 
                </a>
            </li>
            <li class="" id="mng_Home_BestSellingProducts">
                <a href="<@ofbizUrl>mng_Home_BestSellingProducts</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                   畅销商品管理 
                </a>
            </li>
            <li class="" id="mng_Home_SuperDealsProducts">
                <a href="<@ofbizUrl>mng_Home_SuperDealsProducts</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                   超级特卖管理 
                </a>
            </li>
            <li class="" id="mng_Home_recommendSeller">
                <a href="<@ofbizUrl>mng_Home_recommendSeller</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    推荐卖家管理 
                </a>
            </li>
            <li class="" id="mng_Home_recommendCategory">
                <a href="<@ofbizUrl>mng_Home_recommendCategory</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    帮助品类管理 
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