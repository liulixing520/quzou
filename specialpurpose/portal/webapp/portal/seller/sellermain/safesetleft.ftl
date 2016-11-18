<ul class="nav nav-list">

    <li>
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 安全设置</span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu">
            <li id="seller_EditUserLogin">
                <a href="<@ofbizUrl>seller_EditUserLogin</@ofbizUrl>" class="">
                    修改密码
                </a>
                <b class="arrow"></b>
            </li>
            <li id="seller_userEmail">
                <a href="<@ofbizUrl>seller_userEmail</@ofbizUrl>" class="">
                    修改邮箱
                </a>
                <b class="arrow"></b>
            </li>
            <li id="stor_certification">
                <a href="<@ofbizUrl>stor_certification</@ofbizUrl>" class="">
                    身份验证
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