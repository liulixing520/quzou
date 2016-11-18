<#assign url = request.getPathInfo()>
<#assign url = url.substring(url.indexOf("/")+1)>
<div class="wrap clearfix">
        <div class="nav">
    <!--<h2 class="title"><a href="http://chunbo.com/member/index.html">我的春播</a></h2>-->
    <dl>
        <dt>交易管理</dt>
        <dd class="<#if url=="user_myorder">on</#if>"><a href="<@ofbizUrl>user_myorder</@ofbizUrl>">我的订单</a></dd>
        <dd class="<#if url=="user_review">on</#if>"><a href="<@ofbizUrl>user_review</@ofbizUrl>">我的咨询</a></dd>
        <dd class="<#if url=="user_review">on</#if>"><a href="<@ofbizUrl>store</@ofbizUrl>">申请开店</a></dd>
        <dd class="<#if url=="user_review">on</#if>"><a href="<@ofbizUrl>store</@ofbizUrl>">我要导购</a></dd>
        <!-- <dd><a href="user_review">取消订单记录</a></dd> -->
    </dl>
    <dl>
        <dt>账户中心</dt>
        <dd class="<#if url=="userInfo">on</#if>"><a href="userInfo">个人信息</a></dd>
        <!-- <dd><a href="http://chunbo.com/member/security.html">账户安全</a></dd> -->
        <dd class="<#if url=="user_listAddress">on</#if>"><a href="<@ofbizUrl>user_listAddress</@ofbizUrl>">收货地址</a></dd>
        <!-- <dd><a href="user_EditUserLogin">我的积分</a></dd>-->
        <dd class="<#if url=="user_EditUserLogin">on</#if>"><a href="<@ofbizUrl>user_EditUserLogin</@ofbizUrl>">修改密码</a></dd>
        <dd class="<#if url=="user_Passwordprotection">on</#if>"><a href="<@ofbizUrl>user_Passwordprotection</@ofbizUrl>">密码保护</a></dd>
    </dl>
    <dl>
        <dt>我的收藏</dt>
        <dd class="<#if url=="showmyShopFavorites">on</#if>"><a href="<@ofbizUrl>showmyShopFavorites</@ofbizUrl>">收藏的店铺</a></dd>
        <dd class="<#if url=="showmyFavorite">on</#if>"><a href="<@ofbizUrl>showmyFavorite</@ofbizUrl>">收藏的商品</a></dd>
    </dl>
</div>