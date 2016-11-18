<ul class="nav nav-list">
 <li class="highlight">
        <a href="" class="dropdown-toggle">
            <span class="menu-text"> 交易管理 </span>

            <b class="arrow fa fa-angle-down"></b>
        </a>

        <b class="arrow"></b>

        <ul class="submenu">
            <li class="" id="FindOrder">
                <a href="<@ofbizUrl>FindOrderEn</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    订单列表
                </a>
                <b class="arrow"></b>
            </li>
           	<li class="" id="findreturn">
                <a href="<@ofbizUrl>findreturn</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    	退货订单列表
                </a>
                <b class="arrow"></b>
            </li>
            
            <li class="" id="review">
                <a href="<@ofbizUrl>review</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    	客户咨询 
                </a>
                <b class="arrow"></b>
            </li>
            

            <#--
            <li class="">
                <a href="<@ofbizUrl></@ofbizUrl>">
                    <i class="menu-icon fa fa-caret-right"></i>
                    评价管理
                </a>

                <b class="arrow"></b>
            </li>
-->

        </ul>
    </li>


 <#--
    <li class="highlight">
        <a href=""<@ofbizUrl>EditProduct</@ofbizUrl>" class="dropdown-toggle">
            <span class="menu-text"> 我的订单</span>

            <b class="arrow fa fa-angle-down"></b>
        </a>

        <b class="arrow"></b>

        <ul class="submenu">
            <li class="">
                <a href="<@ofbizUrl>myorder</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
                    订单列表
                </a>
                <b class="arrow"></b>
            </li>


           <li class="">
                <a href="buttons.html">
                    <i class="menu-icon fa fa-caret-right"></i>
                    关联产品模板
                </a>

                <b class="arrow"></b>
            </li>

        </ul>
    </li>
-->
 <#--
    <li class="">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 佣金返还</span>

            <b class="arrow fa fa-angle-down"></b>
        </a>

        <b class="arrow"></b>

        <ul class="submenu">

          <li class="">
                <a href="jqgrid.html">
                    <i class="menu-icon fa fa-caret-right"></i>
                    商铺装修
                </a>

                <b class="arrow"></b>
            </li>
        </ul>
    </li>
        <li class="">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 在线物流</span>

            <b class="arrow fa fa-angle-down"></b>
        </a>

        <b class="arrow"></b>

        <ul class="submenu">

            <li class="">
                <a href="jqgrid.html">
                    <i class="menu-icon fa fa-caret-right"></i>
                    商铺装修
                </a>

                <b class="arrow"></b>
            </li>
        </ul>
    </li>
        <li class="">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 评价和评论管理</span>

            <b class="arrow fa fa-angle-down"></b>
        </a>

        <b class="arrow"></b>

        <ul class="submenu">

           <li class="">
                <a href="jqgrid.html">
                    <i class="menu-icon fa fa-caret-right"></i>
                    商铺装修
                </a>

                <b class="arrow"></b>
            </li>
        </ul>
    </li>
    
 <li class="">
        <a href="#" class="dropdown-toggle">
            <span class="menu-text"> 我的买家</span>

            <b class="arrow fa fa-angle-down"></b>
        </a>

        <b class="arrow"></b>

        <ul class="submenu">
			<li class="">
                <a href="<@ofbizUrl>mySellerbuyer</@ofbizUrl>" class="">
                    <i class="menu-icon fa fa-caret-right"></i>
               	买家名单
                </a>
                <b class="arrow"></b>
            </li>
           <li class="">
                <a href="jqgrid.html">
                    <i class="menu-icon fa fa-caret-right"></i>
                    商铺装修
                </a>

                <b class="arrow"></b>
            </li>
        </ul>
    </li>
    -->
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