<ul class="nav nav-list">
    <li>
        <a href="#" class="dropdown-toggle">
            <b class="arrow fa fa-angle-down"></b>
            <span class="menu-text"> 商品管理 </span>
        </a>
        <ul class="submenu">
            <li id="editProductLi">
                <a href="<@ofbizUrl>EditProductEn</@ofbizUrl>">
                    添加商品
                </a>
                <b class="arrow"></b>
            </li>
            <li id="findProductLi">
                <a href="<@ofbizUrl>FindProductEn</@ofbizUrl>">
                    商品列表
                </a>
                <b class="arrow"></b>
            </li>
   <#--         <li  id="categoryTreeLi">
                <a href="<@ofbizUrl>CategoryTreeEn</@ofbizUrl>">
                    商品品类
                </a>
                <b class="arrow"></b>
            </li>
            <li id="productAttributeLi">
                <a href="<@ofbizUrl>FindTypeAttribute</@ofbizUrl>">
                    商品属性
                </a>
                <b class="arrow"></b>
            </li>
            <li id="productFeatureLi">
                <a href="<@ofbizUrl>FindProductFeatureCategory</@ofbizUrl>">
                    商品规格
                </a>
                <b class="arrow"></b>
            </li> -->
<#--            <li>
                <a href="<@ofbizUrl>goodsMgnt</@ofbizUrl>">
                    管理产品
                </a>
                <b class="arrow"></b>
            </li>
            <li>
                <a href="<@ofbizUrl>listSellerCatagory</@ofbizUrl>">
                    管理产品组
                </a>
                <b class="arrow"></b>
            </li>
            <li  id="categoryTreeLi">
                <a href="<@ofbizUrl>CategoryTreeEn</@ofbizUrl>">
                    商品分类
                </a>
                <b class="arrow"></b>
            </li>
            <li id="productAttributeLi">
                <a href="<@ofbizUrl>FindTypeAttribute</@ofbizUrl>">
                    商品属性
                </a>
                <b class="arrow"></b>
            </li>
            <li id="productFeatureLi">
                <a href="<@ofbizUrl>FindProductFeatureCategory</@ofbizUrl>">
                    商品规格
                </a>
                <b class="arrow"></b>
            </li>&ndash;&gt;
            <li>
                <a href="buttons.html">
                    关联产品模板
                </a>
                <b class="arrow"></b>
            </li>-->
        </ul>
    </li>
<#--    <li>
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 商铺管理 </span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu">
            <li  id="businessInfoLi">
                <a href="<@ofbizUrl>store</@ofbizUrl>">
                    商铺信息
                </a>
                <b class="arrow"></b>
            </li>
            <li id="shipSetupLi">
                <a href="<@ofbizUrl>EditProductStoreShipSetup</@ofbizUrl>">
                    送货管理
                </a>
                <b class="arrow"></b>
            </li>
        </ul>
    </li>
    <li>
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 品牌管理 </span>
            <b class="arrow fa fa-angle-down"></b>
        </a>
        <ul class="submenu">
            <li id="brandManageLi">
                <a href="<@ofbizUrl>brandmanage</@ofbizUrl>">
                    <i class="menu-icon fa fa-caret-right"></i>
                    经营品牌
                </a>
                <b class="arrow"></b>
            </li>
        </ul>
    </li>-->
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