<ul class="nav nav-list">
    <li class="open hsub">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 商品 </span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu submenu nav-show" style="display: block;">
            <li class="" id="mng_FindCategory">
                <a href="<@ofbizUrl>mng_FindCategory</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                     商品分类管理 
                </a>
            </li>
            <li class="" id="CategoryTreeEnCF">
                <a href="<@ofbizUrl>CategoryTreeEnCF</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
             商品分类设置 
                </a>
            </li>
            <li class="" id="FindTypeAttributeCF">
                <a href="<@ofbizUrl>FindTypeAttributeCF</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                   商品属性 
                </a>
            </li>
            <li class="" id="FindProductFeatureCategoryCF">
                <a href="<@ofbizUrl>FindProductFeatureCategoryCF</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                  商品规格 
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