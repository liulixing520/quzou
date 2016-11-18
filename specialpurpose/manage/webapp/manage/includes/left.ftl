<ul class="nav nav-list">
    <li class="open hsub">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 交易 </span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu submenu nav-show" style="display: block;">
            <li class="" id="mng_ShowOrder">
                <a href="<@ofbizUrl>mng_ShowOrder</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    交易列表
                </a>
            </li>
            <li class="" id="mng_ShowOrder2">
                <a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_COMPLETED</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    已完成订单 
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
