<div class="wrap-bar">

    <#include "/quzou/webapp/quzou/includes/bar/bar_right_top.ftl" encoding="utf-8">  <#--用户信息、时间提醒、管理菜单-->

    <#include "/quzou/webapp/quzou/includes/bar/bar_download_app.ftl" encoding="utf-8">  <#--下载手机app-->

</div>

<script>
	/*
	 * ajax submit
	 */
	$.fn.ajaxSubmit = function(callback){
		var form = $(this);
		var data = {};

		$("[name]",form).each(function(){
			var that  = $(this);
			var name  = that.attr("name");
			var value = that.val();

			data[name] = value;
		});

		$.post(form.attr("action"),data,function(){
			if($.isFunction(callback)){
				callback();
			}
		});

		return form;
	};

	function jinrujiesuan(){
		$(document.cartform).ajaxSubmit(function(){
			window.location = "showcart";
		});
	}
</script>


<script type="text/javascript">
	function disabledSubmitButton(){
		$(document.createElement("div")).css({
			top:0,
			left:0,
			width:$(document).width(),
			height:$(document).height(),
			position:"absolute",
			opacity:0.3,
			background:"white",
			zIndex:9999,
			cursor:"not-allowed"
		}).appendTo("body");
	}
	function updateCartTreatment() {
		if($("#liaocmc").val()=="自定义疗程"||$("#liaocmc").val()=="" || $("#liaocmc").val()==undefined || $("#liaocmc").val()==null){
			alert("请输入疗程名称!");
			return;
		}

		var i = $("#barListContentInfor dd").length;
		var j = 0;
		$("#barListContentInfor dd").each(function () {
			//j = j + 1;
			var sl = 1;
			var proid = '';
			var zhekou = 1;
			var iszengsongs = "N";
			zhekou = $(this).children("span").siblings(".productDiscount").text();
			iszengsongs = $(this).children("span").siblings(".productId").find("input").attr("title");
			var zhekoujias = $(this).children("span").siblings(".productDisPrice").children("input").val();
			proid = $(this).children("span").siblings(".productDiscount").attr("productid");
			sl = $(this).children("span").siblings(".productNumber").children("input").val();
			$.ajax({
				url: 'addJsonCartTreatment',
				data: {productId: proid, quantity: sl, zhekou: zhekou, zhekoujia: zhekoujias, iszengsong: iszengsongs},
				type: "POST",
				async : false,
				success: function (data) {
							j = j + 1;
				}
			});
		});
		if (i == j) {
			disabledSubmitButton();
			$('#addTreatment').submit();
		}
	}
	/*
	 * 初始化右侧自定义疗程
	*/
	function initbar(){
		$(document).setValue();
		$(".scrollbar1").mCustomScrollbar();
		$(".scrollbar2").mCustomScrollbar();

		//全选、赠送、删除 、创建这些按钮在列表中没数据的时候不显示
		var _this1 =  $("#barListContentInfor");
		var table_control = _this1.siblings(".table_control");
		var temporary_remind = _this1.siblings(".temporary_remind");
		var t_b_control = _this1.siblings(".t_b_control");

		if($("dl",_this1).length > 0){
			table_control.show();
			temporary_remind.hide();
			t_b_control.show();
		}else{
			table_control.hide();
			temporary_remind.show();
			t_b_control.hide();
		}

		var _this2 =  $("#barListContentInfor2");
		table_control = _this2.siblings(".table_control");
		temporary_remind = _this2.siblings(".temporary_remind");
		t_b_control = _this2.siblings(".t_b_control");

		if($("dl",_this2).length > 0){
			table_control.show();
			temporary_remind.hide();
			t_b_control.show();
		}else{
			table_control.hide();
			temporary_remind.show();
			t_b_control.hide();
		}
		barlczj();
	}

	/*
	 * 右侧栏表单修改计算
	*/
	$(function(){
		var body = $("body");

		//------数量输入框
		body.on("keyup",".productNumber input",function(){

			<#-- 还是不去校验了吧。。到时候套上统一的校验代码
			if(/^([^0-9])+$/.test($(this).val()) ) {
				$(this).val($(this).val().replace(/([^0-9])+/,"1"));
			}
			if(/^([0-9]+)[^0-9]$/.test($(this).val())){
				$(this).val($(this).val().replace(/([0-9]+)[^0-9]/,"$1"));
			}
			-->
			var dd 		 = $(this).closest("dd");
			var price	 = $(".productBasePrice",dd);	//原价
			var discount = $(".productDiscount",dd); //折扣
			if(isNaN($(this).val()) || $(this).val()=="" ||$(this).val()==null || $(this).val()==undefined){
				$(this).val(1);
				$(this).keyup();
				return;
			}
			var pro_num = parseInt($(this).val()); //数量
			price = price.text().replace(",",function(){
				return ""
			});

			var pro_price = parseFloat(price);
			var pro_dis = parseFloat(discount.text());
			var disPrice = Math.round(pro_num * pro_price * pro_dis);
			$(".productNameSet input", dd).val(disPrice/pro_num); // 传给购物车对象的价格应该是单个数量的折后价

			$(".productDisPrice input",dd).val(disPrice.toFixed(2));
			barlczj();
		});

		//------折后金额输入框
		body.on("keyup",".productDisPrice input",function(){
			var dd 		 = $(this).closest("dd");
			var price	 = $(".productBasePrice",dd);
			var number   = $(".productNumber input",dd);
			price = price.text().replace(",",function(){
				return ""
			});
			if(isNaN($(this).val()) || $(this).val()=="" ||$(this).val()==null || $(this).val()==undefined){
				$(this).val(1);
			}
			if($(this).val()<=0){
				$(this).val(1)
			}
			var pro_price = parseFloat(price);
			var pro_disprice = parseFloat($(this).val()); //折后金额
			var pro_num = parseInt(number.val()); //数量
			var _dis = Math.round(((pro_disprice || 0)/(pro_price*pro_num))*100)/100;
			$(".productNameSet input",dd).val(pro_disprice/pro_num); // 传给购物车对象的价格应该是单个数量的折后价
			$(".productDiscount",dd).html(_dis.toFixed(2));
			barlczj();
		});
	});

	<#--疗程总计计算-->
	function barlczj(){
		var d=0;
		var e=0;
		$("#barListContentInfor dd").each(function () {
			var p = $(this).children("span").siblings(".productDisPrice").children("input").val();
			p = p.replace(",",function(){
				return "";
			});
			if($(this).parent().hasClass("rowSelected")){
				e = e+ parseFloat(p);
			}else{
				d = d+ parseFloat(p);
			}
		});

		if($("#lchj")){
			$("#lchj").html("总计:￥"+d+"元");
		}
		if($("#zslchj")){
			$("#zslchj").html("赠送总计:￥"+e+"元");
		}
	}

	$(function(){

		initbar();
	});
</script>
<script>

	//自定义疗程列表中删除按钮
	function removeTreatItemAll() {
		var treatNum = parseFloat($(".treatNum").html());
		$('input[name="treatId"]:checked').each(function () {
			var productId = $(this).val();
			$.ajax({
				url: 'removeCartTreatment',
				data: {productId: productId},
				type: "POST",
				success: function (data) {
					$("#treat_" + productId).remove();
					//重新计算购物车数字
					treatNum = treatNum - 1;
					$(".treatNum").html(treatNum);
					initbar();
				}
			});
		});

	}

	// 产品页面添加到购物车
	function addShowCart(price, productId, clearSearch, mainSubmitted, quantity) {
		var showCartHtml = "";

		if($(".top_info.ri").text().indexOf("当前") == -1 && confirm("当前还没有选择会员,是否需要选择?")){
			window.location = "/quzou/control/customerList";
			return;
		}
		$.ajax({
			url: 'addJsonitem',
			data: {
				price: price,
				add_product_id: productId,
				clearSearch: clearSearch,
				mainSubmitted: mainSubmitted,
				quantity: quantity
			},
			type: "POST",
			success: function (data) {
				$.ajax({
					url: 'showCartHtml',
					data: {},
					type: "POST",
					success: function (data) {
						showCartHtml = data;
						$("#showCart").html(showCartHtml);
						initbar();
					}
				});

			}
		});

	}

	<#--加入疗程-->
	function addTreCart(productId, quantity, isType) {
		var showTreCartHtml = "";

		if($(".top_info.ri").text().indexOf("当前") == -1 && confirm("当前还没有选择会员,是否需要选择?")){
			window.location = "/quzou/control/customerList";
			return;
		}

		$.ajax({
			url: 'addJsonCartTreatment',
			data: {productId: productId, quantity: quantity, isType: isType},
			type: "POST",
			success: function (data) {
				$.ajax({
					url: 'showTreCartHtml',
					data: {},
					type: "POST",
					success: function (data) {
						showTreCartHtml = data;
						$("#treCart").html(showTreCartHtml);
						initbar();
					}
				});

			}
		});

	}

	//购物车删除选中
	function removeShowCart() {
		var showCartHtml = "";
		var selectedItem = document.getElementsByName("selectedItem");
		var itemStr = "";
		for (var i = 0; i < selectedItem.length; i++) {
			if (selectedItem[i].checked) {
				itemStr = itemStr + selectedItem[i].value + ",";
			}
		}
		itemStr = itemStr.substring(0, itemStr.length - 1);
		$.ajax({
			url: 'modifycart',
			data: {removeSelected: true, itemStr: itemStr},
			type: "POST",
			success: function (data) {
				$.ajax({
					url: 'showCartHtml',
					data: {},
					type: "POST",
					success: function (data) {
						showCartHtml = data;
						$("#showCart").html(showCartHtml);
						initbar();
					}
				});
			}
		});
	}


</script>
