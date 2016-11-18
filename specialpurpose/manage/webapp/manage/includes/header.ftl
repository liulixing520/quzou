<div class="navbar-header pull-left">
    <a href="main" class="navbar-brand">商城后台管理</a>
</div>
<nav class="navbar-menu pull-left">
    <ul class="nav navbar-nav">
        <li><a href="<@ofbizUrl>main</@ofbizUrl>"> 首页&nbsp; </a></li>
        <li><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 交易 &nbsp; <i
                class="ace-icon fa fa-angle-down bigger-110"></i> </a>
            <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                <li><a href="<@ofbizUrl>mng_ShowOrder</@ofbizUrl>"> 订单列表 </a></li>
            <#--<li><a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_SENT</@ofbizUrl>"> 在途订单 </a></li>-->
                <li><a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_COMPLETED</@ofbizUrl>"> 已完成订单 </a></li>
            <#--<li><a href="#"> 退单 </a></li>
            <li><a href="#"> 争议订单 </a></li>-->
            </ul>
        </li>
        <li><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 商品 <i
                class="ace-icon fa fa-angle-down bigger-110"></i> </a>
            <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                <li><a href="<@ofbizUrl>mng_FindCategory</@ofbizUrl>"> 商品分类管理 </a></li>
                <li class="divider"></li>
                <!--prod-controller.xml 配置CategoryTreeEn -->
                <li><a href="<@ofbizUrl>CategoryTreeEn</@ofbizUrl>">商品分类设置 </a></li>
                <!--prod-controller.xml 配置FindTypeAttribute -->
                <li><a href="<@ofbizUrl>FindTypeAttribute</@ofbizUrl>">商品属性 </a></li>
                <!--prod-controller.xml 配置FindProductFeatureCategory -->
                <li><a href="<@ofbizUrl>FindProductFeatureCategory</@ofbizUrl>">商品规格 </a></li>
                <!-- <li><a href="#"> 产品特征 </a></li> -->
            </ul>
        </li>
        <li><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 物流 <i
                class="ace-icon fa fa-angle-down bigger-110"></i> </a>
            <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                <li><a href="#"> 物流设置 </a></li>
            </ul>
        </li>
        <li><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 卖家 <i
                class="ace-icon fa fa-angle-down bigger-110"></i> </a>
            <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                <li><a href="<@ofbizUrl>mng_sellerInfo</@ofbizUrl>"> 卖家信息 </a></li>
                <li><a href="#"> 黑名单 </a></li>
                <li class="divider"></li>
                <li><a href="<@ofbizUrl>mng_sellerExamine</@ofbizUrl>"> 卖家申请审核 </a></li>
            </ul>
        </li>
        <li><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 网站管理 &nbsp; <i
                class="ace-icon fa fa-angle-down bigger-110"></i> </a>
            <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                <li><a href="<@ofbizUrl>mng_PageSetting</@ofbizUrl>"> 广告位管理 </a></li>
                <li><a href="<@ofbizUrl>mng_announcementSetting</@ofbizUrl>"> 公告管理 </a></li>
                <li><a href="<@ofbizUrl>mng_Home_BestSellingProducts</@ofbizUrl>"> 畅销商品管理 </a></li>
                <li><a href="<@ofbizUrl>mng_Home_SuperDealsProducts</@ofbizUrl>"> 超级特卖管理 </a></li>
                <li><a href="<@ofbizUrl>mng_Home_recommendSeller</@ofbizUrl>"> 推荐卖家管理 </a></li>
                <li><a href="<@ofbizUrl>mng_Home_recommendCategory</@ofbizUrl>"> 帮助品类管理 </a></li>
                <#--<li><a href="<@ofbizUrl>mng_Home_pagesetting</@ofbizUrl>"> 帮助信息管理 </a></li>-->
            </ul>
        </li>
        <li><a href="#" class="dropdown-toggle" data-toggle="dropdown"> 安全设置 &nbsp; <i
                class="ace-icon fa fa-angle-down bigger-110"></i> </a>
            <ul class="dropdown-menu dropdown-light-blue dropdown-caret">
                <li><a href="<@ofbizUrl>seller_EditUserLogin</@ofbizUrl>"> 修改密码 </a></li>
                <#--<li><a href="#"> 修改密码 </a></li>-->
                <#--<li><a href="#"> 密保问题设置 </a></li>-->
            </ul>
        </li>
    </ul>
</nav>
<div class="navbar-buttons navbar-header pull-right" role="navigation">
    <ul class="nav ace-nav">
        <li class="light-blue">
            <a data-toggle="dropdown" href="<@ofbizUrl>sellerIndex</@ofbizUrl>" class="dropdown-toggle">
            <#if sessionAttributes.autoName?has_content>
                <img class="nav-user-photo" src="../images/seller/avatars/avatar.png"
                     alt="${sessionAttributes.autoName?html}"/>
                <span class="user-info">${sessionAttributes.autoName?html}</span>
            </#if>
                <i class="ace-icon fa fa-caret-down"></i>
            </a>
            <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                <li>
                    <a href="#"> <i class="ace-icon fa fa-cog"></i> 设置 </a>
                </li>
                <li class="divider"></li>
                <li>
                    <a href="<@ofbizUrl>logout</@ofbizUrl>"> <i class="ace-icon fa fa-power-off"></i> 注销 </a>
                </li>
            </ul>
        </li>
    </ul>
</div>