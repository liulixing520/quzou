<ul class="nav nav-list">

    <li>
        <a href="#" class="dropdown-toggle">
            <span class="menu-text">店铺管理</span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu">
            <li id="businessinformation">
                <a href="<@ofbizUrl>businessinformation</@ofbizUrl>" class="">
                    店铺信息管理
                </a>
                <b class="arrow"></b>
            </li>
            <li id="merchantInfo">
                <a href="<@ofbizUrl>merchantInfo</@ofbizUrl>" class="">
                    店主信息管理
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
