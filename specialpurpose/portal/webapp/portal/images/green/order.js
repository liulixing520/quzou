var sub_pay_price = -1;
var sub_points = 0;
var sub_balance = 0;
var sub_chunbo_cards = 0;
var sub_coupons_amount = 0;
var sub_coupons_number = 0;
var member_id = $("#sub_member_id").val();
var orther_price = 0;
//商品列表
var product_list_show = 1;
//使用积分余额 春播券
function formatMoney(x) {    
    var f = parseFloat(x);    
    if (isNaN(f)) {
        return false;
    }    
    var f = Math.round(x*100)/100;    
    var s = f.toString();    
    var rs = s.indexOf('.');    
    if (rs < 0) {    
        rs = s.length;    
        s += '.';    
    }    
    while (s.length <= rs + 2) {    
        s += '0';    
    }    
    return s;    
}
function changePrice(){
    var sub_total_price = $("#sub_total_price").val();
    sub_pay_price = formatMoney(sub_total_price)-formatMoney(sub_coupons_amount)-formatMoney(sub_points)-formatMoney(sub_balance)-formatMoney(sub_chunbo_cards);
    if(sub_pay_price < 0){
        sub_pay_price = 0;
    }
    orther_price = formatMoney(sub_total_price) - formatMoney(sub_coupons_amount) - formatMoney(sub_points) - formatMoney(sub_chunbo_cards);
    if(orther_price <= 0){
        $("#invoice_box_disabled").hide();
        $("#invoice_box_disabled2").show();
    }else{
        $("#invoice_box_disabled2").hide();
        $("#invoice_box_disabled").show();
    }
    //console.log(formatMoney(sub_total_price)+"--"+formatMoney(sub_coupons_amount)+"--"+formatMoney(sub_points)+"---"+formatMoney(sub_chunbo_cards)+"--"+orther_price);
    $("#pay_money").html(formatMoney(sub_pay_price));    
}
function usePrice(type,useType){
    if(useType == "use"){
        if(sub_pay_price <=0 && sub_pay_price!=-1){
            alert("支付金额已经0");
            return;
        }
    }
    var is_disabled_btn = $("#is_disabled_edit");
    if(is_disabled_btn.hasClass("disabled_li")){
        return false;
    }
    switch (type){
        case "chunbo_card":
            var old_chunbo_card = $("#old_chunbo_card").html();
            var old_chunbo_card2 = parseFloat(old_chunbo_card);
            if(useType == "use"){
                var input_val = $("#chunbo_card").val();
                if(input_val == "" || isNaN(input_val)){
                    alert("余额不能为空");
                    return false;
                }
                if(old_chunbo_card2 > 0 && old_chunbo_card2 >= parseFloat(input_val)){
                    sub_chunbo_cards = parseFloat(input_val);
                    if(sub_pay_price <= sub_chunbo_cards){
                        sub_chunbo_cards = sub_pay_price;
                    }
                    changePrice();
                    var old_chunbo_card3 = (old_chunbo_card2-sub_chunbo_cards).toFixed(2);
                    $("#old_chunbo_card").html(formatMoney(old_chunbo_card3));
                    $("#sub_chunbo_card").val(formatMoney(sub_chunbo_cards));
                    $("#show_chunbo_card_price").show();
                    $("#show_chunbo_card_price2").html(formatMoney(sub_chunbo_cards));
                    $("#div_chunbo_card").html("<p class='user_p'><span><span class='icon'></span>已经使用"+formatMoney(sub_chunbo_cards)+"元</span>"+"&nbsp;<a href='javascript:;' onclick='usePrice(\"chunbo_card\",\"cancel\")'>取消使用</a></p>");
                    //支付密码
                    $("#show_pay_password").show();
                    $("#pay_count").val(parseInt($("#pay_count").val()) + 1);
                    $("#pay_password").val("");
                }else{
                    alert("春播卡余额不足");
                    return;
                }
            }else{
                var sub_chunbo_card = parseFloat($("#sub_chunbo_card").val());
                var new_chunbo_card_price = (old_chunbo_card2 + sub_chunbo_card).toFixed(2);
                sub_chunbo_cards = 0;
                $("#sub_chunbo_card").val('');
                $("#show_chunbo_card_price").hide();
                $("#show_chunbo_card_price2").html("");
                $("#old_chunbo_card").html(formatMoney(new_chunbo_card_price));
                $("#div_chunbo_card").html('<input type="text" class="text" value="" id="chunbo_card" placeholder="请输入要抵用的金额" ><a href="javascript:;" class="btn btn_green" onclick="usePrice(\'chunbo_card\',\'use\')">使用</a>');
                changePrice();
                var pay_count = parseInt($("#pay_count").val()) - 1;
                if(pay_count <= 0){
                    $("#show_pay_password").hide();
                }
                $("#pay_count").val(pay_count);
            }
            break;
        case "points":
            var old_points_1 = $("#old_points").html();
            var old_points = parseInt(old_points_1);
            if(useType == "use"){
                var input_val1 = $("#use_points").val();
                var input_val = parseInt(input_val1);
                if(input_val == "" || isNaN(input_val)){
                    alert("积分不能为空");
                    return false;
                }
                if(old_points > 0 && old_points >= input_val){
                    sub_points = parseInt(input_val)/100;
                    if(sub_pay_price <= sub_points){
                        sub_points = sub_pay_price;
                    }
                    changePrice();
                    var old_points_cancel = old_points-parseInt(formatMoney(sub_points*100));
                    $("#old_points").html(old_points_cancel);
                    $("#old_price_points").html(formatMoney(old_points_cancel/100));
                    $("#sub_points").val(sub_points);
                    $("#show_points_price").show();
                    $("#show_points_price2").html(formatMoney(sub_points));
                    $("#div_points").html("<p class='user_p'><span><span class='icon'></span>已经使用"+parseInt(formatMoney(sub_points*100))+"积分</span>"+"&nbsp;<a href='javascript:;' onclick='usePrice(\"points\",\"cancel\")'>取消使用</a></p>");
                }else{
                    alert("积分不足");
                    return;
                }
            }else{
                var old_points_cancel = old_points+sub_points*100;
                $("#old_points").html(old_points_cancel);
                $("#old_price_points").html(old_points_cancel/100);
                $("#show_points_price").hide();
                $("#show_points_price2").html("");
                sub_points = 0;
                $("#div_points").html('<input type="text" class="text" value="" id="use_points" placeholder="请输入要抵用的积分数" ><a href="javascript:;" class="btn btn_green" onclick="usePrice(\'points\',\'use\')">使用</a>');
                changePrice();
            }
            break;
        case "balance":
            var old_balance_str = $("#old_balance").html();
            var old_balance = parseFloat(old_balance_str);
            if(useType == "use"){
                var input_val = $("#use_balance").val();
                if(input_val == "" || isNaN(input_val)){
                    alert("余额不能为空");
                    return false;
                }
                if(old_balance > 0 && old_balance >= parseFloat(input_val)){
                    sub_balance = parseFloat(input_val);
                    if(sub_pay_price <= sub_balance){
                        sub_balance = sub_pay_price;
                    }
                    changePrice();
                    var old_balance_cancel = (old_balance-sub_balance).toFixed(2);
                    $("#old_balance").html(formatMoney(old_balance_cancel));
                    $("#sub_balance").val(sub_balance);
                    $("#show_balance_price").show();
                    $("#pay_password").val("");
                    $("#show_balance_price2").html(formatMoney(sub_balance));
                    $("#div_balance").html("<p class='user_p'><span><span class='icon'></span>已经使用"+formatMoney(sub_balance)+"元</span>"+"&nbsp;<a href='javascript:;' onclick='usePrice(\"balance\",\"cancel\")'>取消使用</a></p>");
                    //支付密码处理
                    $("#pay_count").val(parseInt($("#pay_count").val()) + 1);
                    $("#show_pay_password").show();
                }else{
                    alert("余额不足");
                    return;
                }
            }else{
                var pay_balance = $("#sub_balance").val();
                var old_balance_html = (old_balance+ parseFloat(sub_balance)).toFixed(2);
                $("#old_balance").html(old_balance_html);
                $("#sub_balance").val('');
                $("#show_balance_price").hide();
                $("#show_balance_price2").html("");
                sub_balance = 0;
                changePrice();
                var pay_count = parseInt($("#pay_count").val()) - 1;
                if(pay_count <= 0){
                    $("#show_pay_password").hide();
                }
                $("#pay_count").val(pay_count);
                $("#div_balance").html('<input type="text" class="text" value="" id="use_balance" placeholder="请输入要抵用的金额" ><a href="javascript:;" class="btn btn_green" onclick="usePrice(\'balance\',\'use\')">使用</a>');
            }
            break;
        case "coupons":
            var coupons_number = $("#coupons_number_temp").val();
            var coupons_type = $("#coupons_type_temp").val();
            var coupons_id = $("#coupons_id_temp").val();
            var sku = $("#coupons_sku_temp").val();
            var amount = $("#coupons_amount_temp").val();
            var type_name = coupons_type ==1 ? "a 券" : "b 券";
            if(coupons_number != ""){
                var coupons_count = $("#old_coupons").html();
                var coupons_count1 = parseInt(coupons_count);
                if(useType == "use"){
                    if(coupons_type == 1){
                        //A券
                        sub_coupons_amount = parseFloat(amount);
                        if(sub_pay_price <= sub_coupons_amount){
                            sub_coupons_amount = sub_pay_price;
                        }
                        sub_coupons_number = coupons_number;
                        changePrice();
                        $("#coupons_"+coupons_id).hide();
                        $("#old_coupons").html(coupons_count1-1);
                        $("#sub_coupons_amount").val(sub_coupons_amount);
                        $("#show_coupons_price").show();
                        $("#show_coupons_price2").html(sub_coupons_amount);
                        $("#use_coupons1_1").hide();
                        $("#use_coupons2").show();
                    }else{
                    //B券
                    }
                }else{
                    var sub_coupons_amounts = $("#sub_coupons_amount").val();
                    sub_coupons_amount = 0;
                    sub_coupons_number = "";
                    if(coupons_count1 <0){
                        last_coupons_count = coupons_count1;
                    }else{
                        last_coupons_count = coupons_count1+1;
                    }
                    $("#old_coupons").html(last_coupons_count);
                    $("#show_coupons_price").hide();
                    $("#show_coupons_price2").html('');
                    $("#sub_coupons_amount").val("");
                    $("#sub_coupons_number").val("");
                    $("#conpons_val").html("请选择春播券");
                    sub_balance = 0;
                    $("#coupons_"+coupons_id).show();
                    changePrice();
                    $("#use_coupons1_1").show();
                    $("#use_coupons2").hide();
                }                     
            }else{
                alert("请选择春播券");
            }
            break;
    }
}
function postData(url,args){
        var form = $("#sub_form"),
        input;
        form.attr({"action":url});
        $.each(args,function(key,value){
            input = $("<input type='hidden'>");
            input.attr({"name":key});
            input.val(value);
            form.append(input);
        });
        form.submit();
}
//处理拆包
    function productUnpacking(thisa,type){
        if($(thisa).hasClass("cur")){return false;}
        $(thisa).addClass("cur");
        if(type == "all"){
            product_list_show = 1;
            $("#product_div_all").show();
            $("#product_div_unpack").hide();
            $("#product_h4_unpack").removeClass("cur");
        }else{
            product_list_show = 0;
            $("#product_div_unpack").show();
            $("#product_div_all").hide();
            $("#product_h4_all").removeClass("cur");
        }
    }
//获取商品列表公共部分
function getProductList(delivery_id){
    var product_list_param = new Object();
    product_list_param.product_list = $("#product_list_param").val();
    if(delivery_id !="" && typeof(delivery_id) != "undefined"){
        product_list_param.delivery_id = delivery_id;
    }
    var is_presale = $("#sub_is_presale").val();
    if(is_presale == 1){
        product_list_param.is_presale = 1;
    }
    $.ajax({
        type: 'post',
        dataType: 'html',
        url: "/Order/getProductList",
        data:product_list_param,
        success: function (returnData) {
            if(returnData.flag == 0){
                $.each(returnData.data, function (i, item) {
                        _html += item+"库存不足\n";
                });
                alert(_html);
                var redirect_url = $("#sub_redirect_url").val();
                window.location.href = redirect_url;return;         
            }
            if(returnData.length > 100){
                $("#product_list_html").html(returnData);
                changePrice();
            }else{
                var redirect_url = $("#sub_redirect_url").val();
                //window.location.href = redirect_url;return;                  
            }
            sub_pay_price = parseFloat($("#product_total_price_all").val());
        }
    });
}
//getProductList();
//处理代金券
function select_coupons(thisa,divClass){
    var is_disabled_btn = $("#is_disabled_coupons");
    if(is_disabled_btn.hasClass("disabled_li")){
        return false;
    }
    var thisflag = $(thisa).attr("flag");
    if( thisflag== 1){
        $(thisa).attr("flag",0);
        $("."+divClass).show();
    }else{
        $("."+divClass).hide();
        $(thisa).attr("flag",1);
    }
    //隐藏已经选中的券
    var sub_coupons_number = $("#sub_coupons_number").val();
    var coupons_id = $("#coupons_id_temp").val();
    if(sub_coupons_number !="" && coupons_id != ""){
        $("#coupons_"+coupons_id).hide();
    }
}
//选择券
function selectConpons(thisa,conpons_id){
    var coupons_number = $("#coupons_number_"+conpons_id).val();
    var coupons_type = $("#coupons_type_"+conpons_id).val();
    var sku = $("#coupons_sku_"+conpons_id).val();
    var amount = $("#coupons_amount_"+conpons_id).val();
    var coupons_html = $(thisa).html();
    $("#conpons_val").html(coupons_html);
    $("#coupons_number_temp").val(coupons_number);
    $("#coupons_id_temp").val(conpons_id);
    $("#coupons_type_temp").val(coupons_type);
    $("#coupons_sku_temp").val(sku);
    $("#coupons_amount_temp").val(amount);
    $(".privilege_slide").hide();
}
//验证手机号
function check_mobile(mobile){
    var regu = /^\d{11}$/;
    var re = new RegExp(regu);
    if(!re.test(mobile)){
        return  false;
    }
    return true;
}
    
//展示第四级区域
function loadCountys(obj,delivery_id_type){
    var delivery_parent_id = $(obj).val();
    var region_url = "/Order/getDelivery";
    if(delivery_parent_id){
        $.ajax({
            type: 'get',
            dataType: 'html',
            url: region_url,
            data: {
                "region_id": delivery_parent_id
            },
            success: function(returnData) {
                if (returnData != null) {
                    $("#" + delivery_id_type).html(returnData);
                }
            }
        });
    }
    return false;
}
//编辑
function editloadCountys(obj){
    var delivery_parent_id = $(obj).val();
    var region_url = "/Order/getDelivery";
    $.ajax({
        type: 'get',
        dataType: 'html',
        url: region_url,
        data: {
            "region_id": delivery_parent_id
        },
        success: function(returnData) {
            if (returnData != null) {
                $("#edit_delivery_id").html(returnData);
            }
        }
    });
}
//展示第四级区域
function getCountys(region_ids,delivery_id){
    var region_url = "/Order/getDelivery";
    $.ajax({
        type: 'get',
        dataType: 'html',
        url: region_url,
        data: {
            "region_id":region_ids,
            "delivery_id":delivery_id
        },
        success: function (returnData) {
            if(returnData != null){
                $("#delivery_id_edit").html(returnData);
            }
        }
    });
}
//获取三级地区
function getDistrict(city_id,district_id){
    $.ajax({
        type: 'post',
        dataType: 'json',
        url: "/Order/getDistrict",
        data: {
            "city_id":city_id
        },
        success: function (returnData) {
            if(returnData.flag == 1){
                $(".add_new_address").addClass("hide");
                var _html = "<option value=''>请选择区/县</option>";
                $.each(returnData.list, function (i, item) {
                    var sel = "";
                    if(district_id == item.region_id){
                        sel = " selected='selected'";
                    }
                    _html += "<option value='" + item.region_id +"' "+sel+">" + item.region_name + "</option>";
                });
                $("#district_id_edit").html(_html);
            }
        }
    });
}
//添加收货地址
function add_new_address(idVal){
    $(".error_tips").hide();
    $("#pop_box_address").find("li").removeClass("success");
    $("#pop_box_address").find("li").removeClass("error");
    if($("#"+idVal).hasClass("hide")){
        $("#attnName_add").val("");
        $("#district_id_add").val("");
        $("#delivery_id_add").val("");
        $("#address_add").val("");
        $("#phone_add").val("");
        $("#mobile_add").val("");
        $("#"+idVal).show();
        $(".shade_box").show();
    }else{
        $("#"+idVal).hide();
        $(".shade_box").hide();
    }
}
//展示所有的收货地址
function show_all_addre(obj){
    if($(obj).attr("flag") == 1){
        $(obj).html("-收起配送地址");
        $(obj).attr("flag",0);
        $(".change_show_hide").removeClass("hide");
    }else{
        $(obj).attr("flag",1);
        $(obj).html("+展开更多配送地址");
        $(".change_show_hide").addClass("hide");
    }
}
//编辑收货地址
function edit_address(address_id){
	$(".error_tips").hide();
	$("#pop_box_address_edit").find("li").removeClass("success");
	$("#pop_box_address_edit").find("li").removeClass("error");
	if(address_id){
		var address_list = $("#edit_address_"+address_id).val();
		address_list = address_list.split("_"); 
		var address_id = address_list[0];
		var district_id = address_list[2];
		var delivery_id = address_list[3];
		$("#attnName_edit").val(address_list[1]);
		$("#address_edit").val(address_list[5]);
		$("#phone_edit").val(address_list[6]);
		$("#mobile_edit").val(address_list[8]);
		$("#address_id_edit").val(address_list[0]);
		$("#stateProvinceGeoId").val(address_list[2]);
		$("#cityGeoId").val(address_list[3]);
		$("#countyGeoId").val(address_list[4]);
		
		getArea('stateProvinceGeoId', '', 'cityGeoId', 'countyGeoId',address_list[3]);
		getArea('cityGeoId', '', 'countyGeoId', 'null',address_list[4]);
		
		$("#addressBtn").attr("name","edit");
		$(".shade_box").show();
		$("#pop_box_address_edit").show();
	}else{
		$("#attnName_edit").val('');
		$("#address_edit").val('');
		$("#phone_edit").val('');
		$("#mobile_edit").val('');
		$("#address_id_edit").val('');
		$("#stateProvinceGeoId").val('');
		$("#cityGeoId").val('');
		$("#countyGeoId").val('');
		$("#addressBtn").attr("name","add");
        $(".shade_box").show();
		$("#pop_box_address_edit").show();
	}
}

//设置省县市,传入出发的对象this,请求地址,表单ID,替换内容的name
function getArea(thisObjId, url, replaceDivId, childAreaDiv,defaltValue) {
	var area = document.getElementById(replaceDivId + "");
	var childArea = document.getElementById(childAreaDiv + "");
	var thisObjValue = $("#"+thisObjId).val();
	$.ajax({
		url:'ajaxArea',
		type:'POST',
		async: false,
		data:{parentId:thisObjValue},
		success:function(r){
			if ( r.areaList ) {
				var areaList = r.areaList;
				var optStr = '<option></option>';
				for ( var i = 0, end = areaList.length; i < end; i++) {
					if(defaltValue == areaList[i].geoId){
						optStr += '<option value="'+areaList[i].geoId+'" selected >'+areaList[i].geoName+'</option>';
					}else{
						optStr += '<option value="'+areaList[i].geoId+'" >'+areaList[i].geoName+'</option>';
					}
				}
				$("#"+replaceDivId).html(optStr);
				if(childAreaDiv=='null'){}else{
					$("#"+childAreaDiv).html('');
				}
			}
		}
	});
}

//删除收货地址
function delete_address(address_id){
    if(confirm("确认删除收货地址")){
        var member_id = $("#sub_member_id").val();
       $.ajax({
            type: 'post',
            dataType: 'json',
            url: "/Order/deleteAddress",
            data: {"address_id":address_id,"member_id":member_id},
            success: function (returnData) {
                if(returnData.flag ==  1){
                    getAddressList();
                    //alert("删除成功");
                }else{
                    alert("删除失败");
                }
            }
        });
    }
    
}
//弹框
function tankuang(msg){
    $("#mesg_content").html(msg);
     var add_dept=dialog({
        //title: '新增促销活动',
        content: $('#tankuang_div').html(),
        width:400,
        ok:function(){}
       });
       add_dept.show();
}
//春播卡input 验证
function check_chunbo_card(obj,input_id){
    if($(obj).val().length >= 4){
        $("#"+input_id).focus();
    }
}
//绑定春播卡
function bindChunBoCard(type){
    if(type =="add"){
        var card_code1 = $("#bind_chunbo_card_number1").val();
        var card_code2 = $("#bind_chunbo_card_number2").val();
        var card_code3 = $("#bind_chunbo_card_number3").val();
        var card_code4 = $("#bind_chunbo_card_number4").val();
        var card_pwd = $("#bind_chunbo_card_password").val();
        //var yzm_input = $("#bind_chunbo_card_yzm").val();
        //var chunbo_card_yzm = $("#bind_chunbo_card_yzm").val();
        var card_code = card_code1 +"-"+card_code2+"-"+card_code3+"-"+card_code4;
        if(card_code == ""){
            alert("卡号不能为空");
            return;
        }
        if(card_pwd == ""){
            alert("密码不能为空");
            return;
        }
        $.ajax({
            type: 'post',
            dataType: 'json',
            url: "/Order/bindChunBoCard",
            data: {
                "card_code":card_code,
                "card_pwd":card_pwd,
                "member_id":member_id
            },
            success: function (returnData) {
                if(returnData.flag ==  1){
                    getChunboCard(member_id);
                    alert("绑定春播卡成功");
                    $(".shade_box").hide();
                    $("#bind_chunbo_card").hide();
                }else{
                    console.log(returnData);
                    alert("绑定春播卡失败");
                }
            }
        });
    }else{
        $("#bind_chunbo_card_number1").focus();
        $("#bind_chunbo_card_password").val("");
        $("#bind_chunbo_card_yzm").val("");
        $("#bind_chunbo_card_yzm").val("");
        $("#bind_chunbo_card_number1").val("");
        $("#bind_chunbo_card_number2").val("");
        $("#bind_chunbo_card_number3").val("");
        $("#bind_chunbo_card_number4").val("");
        $(".shade_box").show();
        $("#bind_chunbo_card").show();
    }
}
//获取春播卡余额
function getChunboCard(member_id){
    $.ajax({
            type: 'post',
            dataType: 'json',
            url: "/Order/getChunboCard",
            data: {"member_id":member_id},
            success: function (returnData) {
                if(returnData.flag == 1){
                   $("#is_disabled_chunbo_card").removeClass("disabled_li");
                   $("#chunbo_card").removeAttr("disabled");
                   $("#old_chunbo_card").html(formatMoney(returnData.balance));
                }
            }
        });
}
//绑定春播券
function bindChunBoQuan(type){
    if(type =="add"){
        var coupons_number = $("#bind_coupons_number").val();
        if(coupons_number == ""){
            alert("代金券编码不能为空");
            return;
        }
        $.ajax({
            type: 'post',
            dataType: 'json',
            url: "/Order/bindCoupons",
            data: {
                "coupons_number":coupons_number,
                "member_id":member_id
            },
            success: function (returnData) {
                if(returnData.flag ==  1){
                    $("#is_disabled_coupons").removeClass("disabled_li");
                    getChunBoQuanList(member_id);
                    alert("绑定春播券成功");
                    $(".shade_box").hide();
                    $("#bind_chunbo_quan").hide();
                }else{
                    alert("绑定春播券失败");
                }
            }
        });
    }else{
        $("#bind_coupons_number").val("");
        $(".shade_box").show();
        $("#bind_chunbo_quan").show();
    }
}
function getChunBoQuanList(member_id){
    $.ajax({
            type: 'post',
            dataType: 'json',
            url: "/Order/getChunBoQuanList",
            data: {"member_id":member_id},
            success: function (returnData) {
                if(returnData.flag == 1){
                   var _html = "<ul>";
                   $.each(returnData.list, function (i, item) {
                        _html += '<li id="coupons_'+item.coupons_log_id+'" ><a href="javascript:;" onclick="selectConpons(this,'+item.coupons_log_id+')" >'+item.coupons_name+'</a></li>';
                        _html += '<input type="hidden" value="'+item.coupons_number+'" id="coupons_number_'+item.coupons_log_id+'" />';
                        _html += '<input type="hidden" value="'+item.type+'" id="coupons_type_'+item.coupons_log_id+'" />';
                        _html += '<input type="hidden" value="'+item.sku+'" id="coupons_sku_'+item.coupons_log_id+'" />';
                        _html += '<input type="hidden" value="'+item.amount+'" id="coupons_amount_'+item.coupons_log_id+'" />';
                    });
                    _html += "</ul>";
                    $(".privilege_slide_coupons").html(_html);
                    $("#old_coupons").html(returnData.count);
                }
            }
        });
}
//获取地址列表
function getAddressList(){
    $.ajax({
        type: 'post',
        dataType: 'html',
        url: "/Order/getAddressList",
        success: function (returnData) {
            $("#address_list_div").html(returnData);
            selected_default_address();
        }
    });
}

//切换选中的配送地址
function selected_addr(now_addr_id){
    $(".selected_addr").each(function(i){
       $(this).removeClass("error_box");
    });
    //$("#address_"+now_addr_id).removeClass("error_box");
    $(".selected_addr").removeClass("cur");
    var select_address_li = $("#select_old_li").val();
    var old_cur_li_html = '<a href="javascript:;" class="btn" onclick="selected_addr('+select_address_li+')"  >选择该地址</a>';
    $("#address_btn_"+select_address_li).children("b").replaceWith(old_cur_li_html);
    $("#address_"+now_addr_id).addClass("cur");
    var _html = '<b style="color:#2BBC69;font-weight:400;" class="success"><span></span>配送至此地址</b>';
    $("#address_btn_"+now_addr_id).children(".btn").replaceWith(_html);
    $("#select_old_li").val(now_addr_id);
    var delivery_id = $("#selected_addr_delivery_id_"+now_addr_id).val();
    getProductList(delivery_id);
    alert("更换地址后，您需要重新确认配送时间");
}
function selected_addr_box(now_addr_id){
    $.ajax({
        type: 'post',
        dataType: 'json',
        url: "/Order/editAddress",
        data: {"address_id":now_addr_id},
        success: function (returnData) {
            $(".shade_box").hide();
            $("#orther_address_list").hide();
            getAddressList();
        }
    });
}
//默认地址选中
function selected_default_address(){
    var first_addr = $("#show_address_list li").eq(0);
    var addr_id = first_addr.attr("name");
    first_addr.addClass("cur");
    var _html = '<b style="color:#2BBC69;font-weight:400;" class="success"><span></span>配送至此地址</b>';
    $("#address_btn_"+addr_id).children(".btn").replaceWith(_html);
    var delivery_id = $("#selected_addr_delivery_id_"+addr_id).val();
    getProductList(delivery_id);
    alert("更换地址后，您需要重新确认配送时间");
}
//展示所有的配送地址
//function show_all_addr(){
//    $(".selected_addr").each(function(i){
//        if($(this).hasClass("cur")){
//            $(this).removeClass("cur");
//        }           
//    }); 
//    $(obj).addClass("cur");
//}
//验证input 值是否为空
function checkVal(obj){
    var thisName = $(obj).attr("name");
    $(".error_tips").hide();
    if($(obj).val() == ""){
        switch(thisName){
            case "attnName":
                $(obj).parent().parent().removeClass("success");
                $(obj).parent().parent().addClass("error");
                $(obj).nextAll(".error_tips").html("姓名不能为空"); 
                $(obj).nextAll(".error_tips").eq(0).show();
                break;
            case "address":
                $(obj).parent().parent().removeClass("success");
                $(obj).parent().parent().addClass("error");
                $(obj).nextAll(".error_tips").html("详细地址不能为空"); 
                $(obj).nextAll(".error_tips").eq(0).show();
                break;
            case "phone":
                $(obj).parent().parent().removeClass("success");
                $(obj).parent().parent().addClass("error");
                $(obj).nextAll(".error_tips").html("手机号输入错误！"); 
                $(obj).nextAll(".error_tips").eq(0).show();
                break;
            case "mobile":
                $(obj).parent().parent().removeClass("success");
                break;
        }
    }else{
        switch(thisName){
            case "attnName":
                $(obj).parent().parent().removeClass("error");
                $(obj).parent().parent().addClass("success");
                $(obj).nextAll(".error_tips").eq(0).hide();
                break;
            case "address":
                $(obj).parent().parent().removeClass("error");
                $(obj).parent().parent().addClass("success");
                $(obj).nextAll(".error_tips").eq(0).hide();
                break;
            case "remarks":
                $(obj).parent().parent().removeClass("error");
                $(obj).parent().parent().addClass("success");
                $(obj).nextAll(".error_tips").eq(0).hide();
                break;
            case "phone":
                var phone_reg = /^1[3,5,7,8]{1}[0-9]{9}$/;
                if(phone_reg.test($(obj).val())){
                    $(obj).parent().parent().addClass("success");
                    $(obj).parent().parent().removeClass("error");
                    $(obj).nextAll(".error_tips").eq(0).hide();
                } else {
                    $(obj).parent().parent().removeClass("success");
                    $(obj).parent().parent().addClass("error");
                    $(obj).nextAll(".error_tips").html("手机号输入错误！");
                    $(obj).nextAll(".error_tips").eq(0).show();
                }
                break;
            case "mobile":
                $(obj).parent().parent().addClass("success");
                $(obj).parent().parent().removeClass("error");
                $(obj).nextAll(".error_tips").eq(0).hide();
                break;
        }
    }
}
//四级地址
function is_show_err(thisa){
    if($(thisa).val()){
        $(thisa).next().hide();
    }
}
//添加收货地址
function addAddress(obj){
    var type = $(obj).attr("name"); 
    var address_id = $("#address_id_edit").val() ? $("#address_id_edit").val() : ""; 
    var member_id = $("#sub_member_id").val();
    var attnName = $("#attnName_edit").val();
    var address = $("#address_edit").val();
    var phone = $("#phone_edit").val();
    var mobile = $("#mobile_edit").val();
    var stateProvinceGeoId = $("#stateProvinceGeoId").val();
    var cityGeoId = $("#cityGeoId").val();
    var countyGeoId = $("#countyGeoId").val();
    var contactMechPurposeTypeId = $("#contactMechPurposeTypeId").val();
          
    if(attnName == ""){
        $("#attnName_edit").parents("li").addClass("error");
        $("#attnName_edit").nextAll(".error_tips").eq(0).html("姓名不能为空");
        $("#attnName_edit").nextAll(".error_tips").eq(0).show();
        return false;
    //$("#attnName_span_edit").html("请您填写收货人姓名");return;
    }
    if(stateProvinceGeoId == ""){
         $(".dis_del_edit").html("请选择省");
         $(".dis_del_edit").show();
        return;
    }
    if(cityGeoId == ""){
         $(".dis_del_edit").html("请选择市");
         $(".dis_del_edit").show();
        return;
    }
    if(countyGeoId == ""){
    	$(".dis_del_edit").html("请选择县");
    	$(".dis_del_edit").show();
    	return;
    }
    if(address == ""){
        $("#address_edit").parents("li").addClass("error");
        $("#address_edit").nextAll(".error_tips").eq(0).html("详细地址不能为空");
        $("#address_edit").nextAll(".error_tips").eq(0).show();
        return false;
    }
    if(phone == ""){
        $("#phone_edit").parents("li").addClass("error");
        $("#phone_edit").nextAll(".error_tips").eq(0).html("手机号不能为空");
        $("#phone_edit").nextAll(".error_tips").eq(0).show();
        return false;
    }else{
        var phone_reg = /^1[3,5,7,8]{1}[0-9]{9}$/;
        if (!phone_reg.test(phone)) {
            $("#phone_edit").parents("li").addClass("error");
            $("#phone_edit").nextAll(".error_tips").eq(0).html("手机号码输入错误！");
            $("#phone_edit").nextAll(".error_tips").eq(0).show();
            
            return false;
        }
        if (phone.length > 30) {
            $("#phone_edit").parents("li").addClass("error");
            $("#phone_edit").nextAll(".error_tips").eq(0).html("手机号不能超过30个字符");
            $("#phone_edit").nextAll(".error_tips").eq(0).show();
            return false;
        }
    }
    if (mobile.length > 30) {
        $("#mobile_edit").parents("li").addClass("error");
        $("#mobile_edit").nextAll(".error_tips").eq(0).html("手机号不能超过30个字符");
        $("#mobile_edit").nextAll(".error_tips").eq(0).show();
        return false;
    }
    var url ="";
    if(type == "add"){
    	url = "user_createPostalAddress";
    }else{
    	url = "user_updatePostalAddress";
    }
    alert(address_id);
    $.ajax({
        type: 'post',
        dataType: 'json',
        url: url,
        data: {
            "attnName":attnName,
            "stateProvinceGeoId":stateProvinceGeoId,
            "cityGeoId":cityGeoId,
            "countyGeoId":countyGeoId,
            "address1":address,
            "phoneExd":phone,
            "mobileExd":mobile,
            "contactMechPurposeTypeId":contactMechPurposeTypeId,
            "contactMechId":address_id
        },
        success: function (returnData) {
        	window.location.reload();
            $(".shade_box").hide();
            $("#pop_box_address_edit").hide();
        }
    });
}
$(function(){
    //判断积分 余额 春播卡 券 在右边是否展示
    $("#use_points").val("");
    $("#use_balance").val("");
    $("#chunbo_card").val("");
    $("#sub_points").val("");
    $("#sub_balance").val("");
    $("#sub_chunbo_card").val("");
    $("#sub_coupons_amount").val("");
    $("#sub_coupons_number").val("");
    //获取地址列表
    //getAddressList();
    //关闭弹框
    $('.close').click(function(){
        $(this).parent().fadeOut(500);
        $(".shade_box").hide();
    });
    //添加 编辑配送地址
    $(".add_edit_address").unbind("click").bind("click", function () {
        var obj = $(this);
        addAddress(obj);
    });
    //
    var v_top = $('.checkout_box .checkout_box_right').offset().top;
	var checkout_list = $('.checkout_box .checkout_box_right .checkout_list');
	$(window).scroll(function(){
		if($(window).scrollTop()+96 > v_top + 80){
			checkout_list.addClass('fixed_checkout');
		}else{
			checkout_list.removeClass('fixed_checkout');
		}
	});
     //是否打印价格
     $("#checkbox_in_click").unbind("click").bind("click", function () {
         $(this).parent().toggleClass('cur');
     });
     var product_nums_all = $(".product_nums_all").val();
    $("#total_product_num").html(product_nums_all);
    var product_total_price_all = $("#product_total_price_all").val();
    sub_pay_price = product_total_price_all;
    $("#total_price").html(product_total_price_all);
    $("#pay_money").html(product_total_price_all);
    $("#sub_total_price").val(product_total_price_all);
});
//页面刷新判断发票信息是否展示
function is_show_invoice(){
    var needInvoice = $("#sub_needInvoice").val();
    if(needInvoice == 1){
        var invoice_title = $("#sub_invoice_title").val();
        var invoice_content = $("#sub_invoice_content").val();
        $("#invoice_detail_div").show();
        $("#invoice_title_html").html(invoice_title);
        $("#invoice_content_html").html(invoice_content);
    }
    
}
is_show_invoice();
//发票取消
function delInvoice(){
    $(".invoice_content").removeClass("cur");
    $(".invoice_content").eq(0).addClass("cur");
    $(".invoice_title").removeClass("cur");
    $(".invoice_title").eq(0).addClass("cur");
    $("#companyNameText").val("");
    $("#companyNameText_ishow").hide();
    $("#sub_needInvoice").val("");
    $("#sub_invoice_title").val("个人");
    $("#sub_invoice_content").val("食品");
    $("#invoice_detail_div").hide();
    $("#invoice_title_html").html("");
    $("#invoice_content_html").html("");
}
//发票按钮切换
function invoice_fun(thisa,type,type2){
    if(type == "title"){
        $(".invoice_title").removeClass("cur");
        $(thisa).addClass("cur");
        $("#companyNameText").val("");
        if(type2 == "com"){
            $("#companyNameText_ishow").show();
        }else{
            $("#companyNameText_ishow").hide();
        }
    }else if(type == "content"){
        $(".invoice_content").removeClass("cur");
        $(thisa).addClass("cur");
        $("#sub_invoice_content").val(type2);
    }
}
//添加发票信息
function addInvoice(type){
    if(type == "save"){
        var sub_invoice_title;
        var sub_invoice_content;
        if($("#companyNameText_ishow").is(":hidden")){
            var title = "个人";
            $("#sub_invoice_title").val("个人");
        }else{
            var invoice_content = $("#companyNameText").val();
            if(invoice_content.replace(/(^\s*)|(\s*$)/g, "") == ""){
                alert("发票抬头必须填写");
                return;
            }
            var title = invoice_content;
            $("#sub_invoice_title").val(invoice_content);
        }
        $("#sub_needInvoice").val(1);
        var content = $("#sub_invoice_content").val();
        $("#invoice_detail_div").show();
        $("#invoice_title_html").html(title);
        $("#invoice_content_html").html(content);
        $(".shade_box").hide();
        $("#add_Invoice").hide();
    }else{
        //$("#sub_invoice_content").val("明细");
        //$("#companyNameText_ishow").val("");
        if(orther_price <= 0 && sub_pay_price <= 0){
            //$("#invoice_box_disabled").addClass("invoice_box_disabled");
            return false;
        }
        $(".shade_box").show();
        $("#add_Invoice").show();
    }
}
function changeProductTag(){
    var address_id;
    $(".selected_addr").each(function(i){
        if($(this).hasClass("cur")){
            var address_id_str = $(this).attr("name");
            if(parseInt(address_id_str) > 0){
                address_id = parseInt(address_id_str);
            }
        }           
    });
    if(address_id == 0 || typeof(address_id) == "undefined"){
         var first_addr = $("#show_address_list li").eq(0);
         var addr_id = first_addr.attr("name");
         $(".selected_addr").each(function(i){
            $(this).addClass("error_box");
         });
         $(".checkout_list_p").show();return false;
    }else{
         //$(".checkout_list_p").hide();
    }
    var flag = 0;
    if(sub_balance>0 || sub_chunbo_cards>0){
        var pay_password = $("#pay_password").val();
        if(pay_password == ""){
            $("#pay_password").focus();
            alert("请输入支付密码");
            return;
        }else{
            $.ajax({
                type: 'post',
                dataType: 'json',
                async:false,
                url: "/Order/payPassword",
                data:{
                    "member_id":member_id,
                    "password":pay_password
                },
                success: function (returnData) {
                    if(returnData.flag == 2){
                        $("#pay_password").focus();
                        alert("支付密码有误");
                        flag = -1;
                        return false;
                    }
                }
            });
        }
    }
    if(flag < 0){return false;}
    var address_id;
    $(".selected_addr").each(function(i){
        if($(this).hasClass("cur")){
            var address_id_str = $(this).attr("name");
            if(parseInt(address_id_str) > 0){
                address_id = parseInt(address_id_str);
            }
        }           
    });
    if(address_id == 0 || typeof(address_id) == "undefined"){
         var first_addr = $("#show_address_list li").eq(0);
         var addr_id = first_addr.attr("name");
         $(".selected_addr").each(function(i){
            $(this).addClass("error_box");
         });
         $(".checkout_list_p").show();return false;
    }else{
         //$(".checkout_list_p").hide();
    }
    var product_info=[];
    $('.select_date').each(function(index){
           tag_send_date = $(this).html();
           if(tag_send_date == "" || tag_send_date == "请选择送货时间"){
               alert("第"+index+"包裹配送时间不正确");return false;
           }
           product_list = $(this).parent().siblings("input[name='product_info']").val();
           product_info[index]= [tag_send_date,product_list];
    });
    $.ajax({
        type: 'post',
        dataType: 'text',
        url: "/Order/changeProductGroup",
        data: {"product_info":product_info},
        success: function (returnData) {
            if(returnData !="<ul>null</ul>"){
                $("#chang_product_group").html("");
                $("#chang_product_group").html(returnData);
                var group_order_type = $("#group_order_type").val();
                if(group_order_type == 1){
                    $(".shade_box").show();
                    $("#chang_product_group").show();
                }else{   
                        submitOrder();
                }
            }else{
                alert("网络异常,请稍后重试!");return;
            }
        }
    });
}
function submitOrder(){
    var product_param = new Object();
    product_param.product_list = $("#product_list_param").val();
    product_param.sub_points = sub_points;//积分
    product_param.sub_balance = sub_balance;//余额
    product_param.sub_chunbo_card = sub_chunbo_cards;//春播卡       
    product_param.sub_coupons_number = sub_coupons_number;
    product_param.member_id = member_id;
    if($("#invoice_box_disabled").is(":visible")){
        var needInvoice = $("#sub_needInvoice").val();
        if(needInvoice){
            product_param.invoiceTitle = $("#sub_invoice_title").val();
            product_param.invoiceContent = $("#sub_invoice_content").val();
        }
    }
    var error_obj = new Object();
    product_param.address_id = 0;
    $(".selected_addr").each(function(i){
        if($(this).hasClass("cur")){
            var address_id_str = $(this).attr("name");
            if(parseInt(address_id_str) > 0){
                product_param.address_id = parseInt(address_id_str);
            }
        }           
    }); 
    if(product_param.address_id == 0){
        $(".checkout_list_p").show();return false;
    }else{
        //$(".checkout_list_p").hide();
    }
    //商品清单是否打印价格
    if($(".checkbox_in").hasClass("cur")){
        product_param.is_show_price = 0;
    }else{
        product_param.is_show_price = 1;
    }
    var pay_url = $("#sub_pay_url").val();
    var sub_url = "/Order/submitOrder";
    $.ajax({
        type: 'post',
        dataType: 'json',
        url: sub_url,
        data:product_param,
        success: function (returnData) {
            if(returnData.result != 1){
                var error_code = returnData.erron;
                switch (error_code){
                    case 5001:
                        alert("没有用户相关信息，请重试");
                        return;
                        break;
                    case 5005:
                        alert("没有收货地址相关信息，请重试");
                        return;
                        break;
                    case 5112:
                        alert("未获取您的订单列表信息，请重试");
                        return;
                        break;
                    case 5017:
                        alert("发票信息有部分缺失，请验证");
                        return;
                        break;
                    case 5021:
                        alert("未获取您的收货地址，请重试");
                        return;
                        break;
                    case 5018:
                        alert("四级收货地址为空");
                        return;
                        break;
                    case 5022:
                        alert("四级地址不存在");
                        return;
                        break;
                    case 5205:
                        alert("获取促销信息失败，请重试");
                        return;
                        break;
                    case 5016:
                        alert("请填写您的预约发货时间");
                        return;
                        break;
                    case 5113:
                        alert("同一件商品出现多次");
                        return;
                        break;
                    case 5013:
                        alert("商品购买数量小于0");
                        return;
                        break;
                    case 5114:
                        alert("商品不存在");
                        return;
                        break;
                    case 5019:
                        alert("指定预约配送时间不在可配送时间范围内");
                        return;
                        break;
                    case 5202:
                        alert("库存查询失败");
                        return;
                        break;
                    case 5205:
                        alert("商品信息获取失败，请重试");
                        return;
                        break;
                    case 5208:
                        alert("赠品信息缺失，请重试");
                        return;
                        break;
                    case 5023:
                        alert("春播券验证失败，请重试");
                        return;
                        break;
                    case 5024:
                        alert("积分验证失败，请重试");
                        return;
                        break;
                    case 5025:
                        alert("春播卡验证失败，请重试");
                        return;
                        break;
                    case 5026:
                        alert("余额验证失败，请重试");
                        return;
                        break;
                    case 5115:
                        alert("扣取春播券失败，请重试");
                        return;
                        break;
                    case 5116:
                        alert("积分扣取失败，请重试");
                        return;
                        break;
                    case 5117:
                        alert("春播卡扣取失败，请重试");
                        return;
                        break;
                    case 5118:
                        alert("余额扣取失败，请重试");
                        return;
                        break;
                    case 5206:
                        alert("商品库存占用失败");
                        return;
                        break;
                    case 5207:
                        alert("商品库存释放失败");
                        return;
                        break;
                    case 5203:
                        var _html="";
                         $.each(returnData.lack_product_list, function (i, item) {
                             _html += $("#product_"+item.sku_code).html()+"库存不足\n";
                        });
                        alert(_html);
                        var redirect_url = $("#sub_redirect_url").val();
                        window.location.href = redirect_url;return;
                        break;
                     default:
                         alert("网络异常,请稍后重试！");
                }
            }else{
                $("#chang_product_group").fadeOut(500);
                $(".shade_box").hide();
                $("#sub_points").val('');//积分
                $("#sub_balance").val('');//余额
                $("#sub_chunbo_card").val('');//春播卡
                $("#sub_coupons_number").val('');//券编码
                $("#sub_coupons_amount").val('');//券
                
                if(parseFloat(returnData.total_pay_price) <= 0){
                    location.href="/Order/paySuccess";
                }else{
                    var subData = new Object();
                    subData.ORDER_IDS = returnData.orderIds;
                    
                    subData.CHANNEL_NAME = "default";
                    subData.BUYER_ID = product_param.member_id;
                    postData(pay_url,subData);
                }
            }
        }
    });
}