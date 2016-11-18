<div class="wrap-bar">

    <#include "/pcpos/webapp/pcpos/includes/bar/bar_right_top.ftl" encoding="utf-8">  <#--用户信息、时间提醒、管理菜单-->

    <#assign shoppingCart = Static["org.ofbiz.order.shoppingcart.ShoppingCartEvents"].getCartObject(request)>

    <#include "/pcpos/webapp/pcpos/includes/bar/bar_download_app.ftl" encoding="utf-8">  <#--下载手机app-->
</div>

<script type="text/javascript">
    $(function(){
        $(document).setValue();
        $(".scrollbar1").mCustomScrollbar();
        $(".scrollbar2").mCustomScrollbar();
    });
</script>
