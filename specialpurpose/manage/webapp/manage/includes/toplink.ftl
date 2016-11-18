<style type="text/css">
    #sys-links {
        text-align: right;
        height: 38px;
        position: absolute;
        right: 0;
        top: 10px;
    }
    #sys-links li {
        float: left;
        margin-right: 10px;
        list-style:none;
    }
    #sys-links li a:link, #sys-links li a:visited {
        color: #0095cd;
        display: inline-block;
        height: 10px;
        font-size: 12px;
        text-decoration: none;
    }
    #sys-infor {
        position: absolute;
        right: 10px;
        top: 40px;
        line-height: 22px;
    }
    #sys-infor a {
        margin-left: 5px;
        color: #48a7e7;
    }
    #logo {
        padding-top: 12px;
        padding-bottom: 12px;
        position: relative;
        z-index: 2;
        width: 330px;
        overflow: hidden;
    }
    #logo a {
        float: left;
        height: 40px;
        width: 299px;
        background: url(../images/logo-1x.png) no-repeat 0 0;
        text-indent: -9999px;
    }
</style>
<div class="container" style="position:relative;">
    <ul id="sys-links">
        <li><a target="_blank" href="/portal/control/main"><i class="i-home"></i><span>网站首页</span></a></li>
        <li><a target="_blank" href="#"><i class="i-help"></i><span>帮助中心</span></a></li>
        <li><a target="_blank" href="<@ofbizUrl>FindOrderEn</@ofbizUrl>"><i class="i-account"></i><span>我的订单</span></a></li>
        <li><a target="_blank" href="<@ofbizUrl>tmall</@ofbizUrl>?productStoreId=${productStoreId}"><i class="i-account"></i><span>我的店铺</span></a></li>
        <li><a target="_blank" href="<@ofbizUrl>seller_EditUserLogin</@ofbizUrl>"><i class="i-pwd"></i><span>修改密码</span></a></li>
    </ul>
    <div id="sys-infor">
        <span>欢迎您：<strong>${sessionAttributes.autoName?html}</strong></span> <a href="<@ofbizUrl>logout</@ofbizUrl>">[退出]</a>
    </div>
    <div id="logo">
        <a title="" href="<@ofbizUrl>main</@ofbizUrl>"></a>
    </div>

</div>