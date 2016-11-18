
<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">
<style type="text/css">
body,ul,li{margin: 0;padding: 0;font: 12px normal "宋体", Arial, Helvetica, sans-serif;list-style: none;}
a{text-decoration: none;font-size: 14px;}

#tabbox{ width: 950px;overflow: hidden;margin: 0 auto;margin-left: 0px;}
.tab_conbox{border: 1px solid #999;border-top: none;}
.tab_con{ display:none;}

.tabs{height: 32px;border-bottom:1px solid #999;border-left: 1px solid #999;width: 100%;}
.tabs li{height:31px;line-height:31px;float:left;border:1px solid #999;border-left:none;margin-bottom: -1px;background: #e0e0e0;overflow: hidden;position: relative;}
.tabs li a {display: block;padding: 0 20px;border: 1px solid #fff;outline: none;}
.tabs li a:hover {background: #ccc;}    
.tabs .thistab,.tabs .thistab a:hover{background: #fff;border-bottom: 1px solid #fff;}

.tab_con {padding:12px;font-size: 14px; line-height:175%;}

.expanded{height:30px;line-height:30px;font-weight:bold;}
td{line-height:30px; height:30px;}
.label{color: #000000; background-color: #ffffff !important; line-height:20px;}

.table {font-size:11px;}

</style>
 <script type="text/javascript"> 
	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>管理产品</li><li class='active'>添加新产品</li>")
	});   

$(document).ready(function() {
    jQuery.jqtab = function(tabtit,tabcon) {
        $(tabcon).hide();
        $(tabtit+" li:first").addClass("thistab").show();
        $(tabcon+":first").show();
    
        $(tabtit+" li").click(function() {
            $(tabtit+" li").removeClass("thistab");
            $(this).addClass("thistab");
            $(tabcon).hide();
            var activeTab = $(this).find("a").attr("tab");
            $("#"+activeTab).fadeIn();
            return false;
        });
        
    };
    /*调用方法如下：*/
    $.jqtab("#tabs",".tab_con");
    
});
</script>


<!-- 代码 开始 -->
<div class="col-main">
  <div id="tabbox">
    <ul class="tabs" id="tabs">
      <li><a href="#" tab="tab1">产品</a></li>
      <li><a href="#" tab="tab2">价格</a></li>
      <li><a href="#" tab="tab3">内容</a></li>
      <li><a href="#" tab="tab4">分类</a></li>
    </ul>
    <ul class="tab_conbox">
      <li id="tab1" class="tab_con"> ${screens.render("component://portal/widget/SellerScreens.xml#EditProductGoods")} </li>
      <li id="tab2" class="tab_con"> ${screens.render("component://portal/widget/SellerScreens.xml#EditProductPrices")} </li>
      <li id="tab3" class="tab_con" style="height:auto"> ${screens.render("component://portal/widget/SellerScreens.xml#EditProductContent")} </li>
      <li id="tab4" class="tab_con"> ${screens.render("component://portal/widget/SellerScreens.xml#EditProductCategories")} </li>
    </ul>
  </div>
</div>