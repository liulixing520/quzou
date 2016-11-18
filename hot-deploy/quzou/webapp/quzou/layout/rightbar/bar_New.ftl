<div class="wrap-bar">

    <#include "/pcpos/webapp/pcpos/includes/bar/bar_right_top.ftl" encoding="utf-8">  <#--用户信息、时间提醒、管理菜单-->

    <#assign shoppingCart = Static["org.ofbiz.order.shoppingcart.ShoppingCartEvents"].getCartObject(request)>
    <div class="bus_management tc buycart">
      <#if security.hasPermission("PCPOS_addTreatment", session)>
        <div id="baseTreCart">
            <#include "/pcpos/webapp/pcpos/includes/bar/base_tre_cart_templ.ftl" encoding="utf-8">  <#--新建疗程模板-->
        </div>
      </#if>

      <#if security.hasPermission("PCPOS_addFangAn", session)>
        <div id="baseFACart">
            <#include "/pcpos/webapp/pcpos/includes/bar/base_fa_cart_templ.ftl" encoding="utf-8">  <#--新建方案模板-->
        </div>
      </#if>
    </div>

    <#include "/pcpos/webapp/pcpos/includes/bar/bar_download_app.ftl" encoding="utf-8">  <#--下载手机app-->

</div>

<script type="text/javascript">

/*
	function zsAll(obj,name){
		var check = $(obj).attr("checked");
		var url="";
		if(name=="treatId"){
			url="addBaseJsonTreatment";
		}
		if(name=="fanganId"){
			url="addBaseJsonFangan";
		}
		if(check=="checked"){
			$('input[name="'+name+'"]').each(function(){
		   		$(this).parents("dl").addClass("rowSelected");
		   		var treatId = $(this).val();
		   		$(this).attr("title","Y");
		   		//执行ajax 把值传递到后台
		   		$.ajax({
					url: url,
					data: {productId: treatId, quantity: 0, isType: "add",iszengsong:"Y"},
					type: "POST",
					success: function (data) {}
				});
		  	});
		}else{
			$('input[name="'+name+'"]').each(function(){
		   		$(this).parents("dl").removeClass("rowSelected");
		   		$(this).attr("title","N");
		   		var treatId = $(this).val();
		   		//执行ajax  把值传递到后台
		   		$.ajax({
					url: url,
					data: {productId: treatId, quantity: 0, isType: "add",iszengsong:"N"},
					type: "POST",
					success: function (data) {}
				});
		  	});
		}
	}

	function zs(obj,name){
		var check = $(obj).attr("checked");
		var treatId = $(obj).val();
		var url="";
		if(name=="treatId"){
			url="addBaseJsonTreatment";
		}
		if(name=="fanganId"){
			url="addBaseJsonFangan";
		}
		if(check=="checked"){
		   		$(obj).parents("dl").addClass("rowSelected");
		   		$(obj).attr("title","Y");
		   		//执行ajax 把值传递到后台
		   		$.ajax({
					url: url,
					data: {productId: treatId, quantity: 0, isType: "add",iszengsong:"Y"},
					type: "POST",
					success: function (data) {}
				});
		}else{
		   		$(obj).parents("dl").removeClass("rowSelected");
		   		//执行ajax  把值传递到后台
		   		$(obj).attr("title","N");
		   		$.ajax({
					url: url,
					data: {productId: treatId, quantity: 0, isType: "add",iszengsong:"N"},
					type: "POST",
					success: function (data) {}
				});
		}
	}
*/
		/*
		 * 赠送部分代码
		*/
		$(function(){
			//------发送赠送状态
			function ajaxPost(name, productId, state){
				if(name=="treatId"){
					url="addBaseJsonTreatment";
				}
				if(name=="fanganId"){
					url="addBaseJsonFangan";
				}
				$.post(url, {productId: productId, quantity: 0, isType: "add",iszengsong:state});
			}

			//------赠送
			function give(checkbox){
				var row 	  = checkbox.closest("dl");
				var productId = checkbox.val();
				var name = checkbox.attr("name");

				if(row.hasClass("rowSelected")){
					return;
				}
				checkbox.attr("title","Y");
				row.addClass("rowSelected");

				ajaxPost(name, productId,"Y");
			}

			//------取消赠送
			function cancel_give(checkbox){
				var row 	  = checkbox.closest("dl");
				var productId = checkbox.val();
				var name = checkbox.attr("name");

				if(!row.hasClass("rowSelected")){
					return;
				}
				if(checkbox.is(":checked")){
					checkbox.attr({
						checked:"false"
					});
				}
				checkbox.attr({
					title:"N"
				});
				row.removeClass("rowSelected");
				ajaxPost(name, productId,"N");
			}

			//赠送按钮
			$("body").on("click","[trigger='give_all']",function(){
				var barList = $(this).parent().parent().siblings(".scrollbar");
				//console.log(barList);
				$("dd > .productId > input", barList).each(function(){
					var checkbox   = $(this);
					var checkState = checkbox.is(":checked");

					if(checkState === true){
						give(checkbox);
					}
				});
			});

			//------取消勾选按钮点击
			$("body").on("click","#checkAll",function(){
				var checkbox = $(this);
				if(checkbox.is(":checked") == false){
					var barList = $(this).parent().parent().siblings(".scrollbar");
					$("dd > .productId > input", barList).each(function(){
						var checkbox   = $(this);
						//var checkState = checkbox.is(":checked");
						cancel_give(checkbox);
					});
				}
			});

			//------单个勾选按钮点击
			$("body").on("click","dd > .productId > input",function(){
				var checkbox   = $(this);
				var checkState = checkbox.is(":checked");

				if(checkState === false){
					cancel_give(checkbox);
				}
			});
		});



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
	}

	$(function(){
		initbar();
	});

</script>
<script>

	/*
	 * 右侧栏表单修改计算
	*/
	$(function(){
		var body = $("body");

		//------数量输入框
		body.on("keyup",".productNumber input",function(){
			var dd 		 = $(this).closest("dd");
			var price	 = $(".productBasePrice",dd);
			var discount = $(".productDiscount",dd);

			price = price.text().replace(",",function(){
				return ""
			});

			$(".productDisPrice input",dd).val(
				(parseFloat($(this).val()) * parseFloat(discount.text()) * parseFloat(price)).toFixed(2)
			);
		});

		//------折扣后输入框
		body.on("keyup",".productDisPrice input",function(){
			var dd 		 = $(this).closest("dd");
			var price	 = $(".productBasePrice",dd);
			var number   = $(".productNumber input",dd);

			price = price.text().replace(",",function(){
				return ""
			});

			$(".productDiscount",dd).html(
				(parseFloat($(this).val()) /  (parseFloat(price) * parseFloat(number.val()))).toFixed(2)
			);
		});
	});


<#--
	function removeCart(productId, url) {
		$.ajax({
			url: url,
			data: {productId: productId},
			type: "POST",
			success: function (data) {
				location.href = location.href;
			}
		});
	}
-->

	function removeFanganItemAll() {
		var fanganNum = parseFloat($(".fanganNum").html());
		$('input[name="fanganId"]:checked').each(function () {
			var productId = $(this).val();
			$.ajax({
				url: 'removeCartFangan',
				data: {productId: productId},
				type: "POST",
				success: function (data) {
					$("#fangan_" + productId).remove();
					//重新计算购物车数字
					fanganNum = fanganNum - 1;
					$(".fanganNum").html(fanganNum);
					initbar();
				}
			});
		});

	}

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


	function addTreCart(productId, quantity, isType) {
		var baseTreCartHtml = "";
		$.ajax({
			url: 'addBaseJsonTreatment',
			data: {productId: productId, quantity: quantity, isType: isType},
			type: "POST",
			success: function (data) {
				$.ajax({
					url: 'baseTreCartHtml',
					data: {},
					type: "POST",
					success: function (data) {
						baseTreCartHtml = data;
						$("#baseTreCart").html(baseTreCartHtml);
						initbar();
					}
				});

			}
		});
	}

	function addFACart(productId, quantity, isType) {
		var baseFACartHtml = "";
		$.ajax({
			url: 'addBaseJsonFangan',
			data: {productId: productId, quantity: quantity, isType: isType},
			type: "POST",
			success: function (data) {
				$.ajax({
					url: 'baseFACartHtml',
					data: {},
					type: "POST",
					success: function (data) {
						baseFACartHtml = data;
						$("#baseFACart").html(baseFACartHtml);
						initbar();
					}
				});

			}
		});
	}

	//*更新自定义疗程折扣信息，再添加购物车！
	function updateCartTreatment() {
		if($("#newTreatment").val()=="新建疗程"||$("#newTreatment").val()=="" || $("#newTreatment").val()==undefined || $("#newTreatment").val()==null){
			alert("请输入疗程名称!");
			return;
		}
		var i = $("#barListContentInfor dd").length;
		var j = 0;
		$("#barListContentInfor dd").each(function () {
			j = j + 1;
			var sl = 1;
			var proid = '';
			var zhekou = 1;
			var iszengsong = "N";
			zhekou = $(this).children("span").siblings(".productDiscount").text();
			iszengsong = $(this).children("span").siblings(".productId").find("input").attr("title");
			zhekoujia = $(this).children("span").siblings(".productDisPrice").children("input").val();
			proid = $(this).children("span").siblings(".productDiscount").attr("productid");
			sl = $(this).children("span").siblings(".productNumber").children("input").val();
			//alert(iszengsong);
			$.ajax({
				url: 'addBaseJsonTreatment',
				data: {productId: proid, quantity: sl, zhekou: zhekou, zhekoujia: zhekoujia, iszengsong: iszengsong},
				type: "POST",
				success: function (data) {
				}
			});
		});
		if (i == j) {
			$('#addTreatment').submit();
		}

	}

	//更新新建方案折扣信息，再添加购物车！
	function updateFangAn() {
	
		if($("#newScheme").val()=="新建方案"||$("#newScheme").val()=="" || $("#newScheme").val()==undefined || $("#newScheme").val()==null){
			alert("请输入方案名称!");
			return;
		}
		var i = $("#barListContentInfor2 dd").length;
		var j = 0;
		$("#barListContentInfor2 dd").each(function () {
			j = j + 1;
			var sl = 1;
			var proid = '';
			var zhekou = 1;
			var iszengsong = "N";
			iszengsong = $(this).children("span").siblings(".productId").find("input").attr("title");
			zhekou = $(this).children("span").siblings(".productDiscount").text();
			zhekoujia = $(this).children("span").siblings(".productDisPrice").children("input").val();
			proid = $(this).children("span").siblings(".productDiscount").attr("productid");
			sl = $(this).children("span").siblings(".productNumber").children("input").val();
			$.ajax({
				url: 'addBaseJsonFangan',
				data: {productId: proid, quantity: sl, zhekou: zhekou, zhekoujia: zhekoujia, iszengsong: iszengsong},
				type: "POST",
				success: function (data) {

				}
			});
		});
		if (i == j) {
			$('#addFangan').submit();
		}

	}
</script>
