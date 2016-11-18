<ul class="nav nav-list">
    <li class="open hsub">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 安全设置 </span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu submenu nav-show" style="display: block;">
            <li class="" id="seller_EditUserLogin">
                <a href="<@ofbizUrl>seller_EditUserLogin</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    修改密码 
                </a>
            </li>
    <!--        <li class="open hsub">
                <a href="<@ofbizUrl>mng_Home_pagesetting</@ofbizUrl>" class="dropdown-toggle">
                    <i class="menu-icon fa fa-caret-right"></i>
                    帮助信息管理
                </a>
            </li>-->
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
