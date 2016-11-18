var isIndex;
$(function(){
	checkInviteReg();
    showForgetPwd();

	var total = $('#headerProductNum').val();
	//if(total==0){
	//	$('div.header_cart .cart_a span.num').hide();
	//}
	// 购物车
	$('.header_myhome').hover(function(){
		$(this).find('.myhome_slide').fadeIn(300);
	},function(){
		$(this).find('.myhome_slide').fadeOut(300);
	});

var sto = null;
$('.header_cart .cart_a').hover(function(){
	clearTimeout(sto);
	var total = $('#headerProductNum').val();
	if(total!=0){
		$(this).parent().find('.cart_slide').fadeIn(300);
	}
},function(){
	var that = $(this);
	sto = setTimeout(function(){
		that.parent().find('.cart_slide').fadeOut(300);
	},300);
});

$('.header_cart .cart_slide').hover(function(){
	clearTimeout(sto);
},function(){
	$(this).fadeOut(300);
});

// 导航
var sto2 = null;
if(!!isIndex){
	$('.nav_all_slide').show();
}else{
	$('.nav_all').hover(function(){
		$(this).find('.nav_all_slide').show();
	},function(){
		$(this).find('.nav_all_slide').hide();
	})
}

$('.nav_all .nav_all_slide li').hover(function(){
	$('.nav_all .nav_all_slide li').removeClass('hover');
	$('.nav_all .nav_all_slide li .nav_all_lislide').hide();
	$(this).addClass('hover');
	$(this).find('.nav_all_lislide').show();
},function(){
	$('.nav_all .nav_all_slide li').removeClass('hover');
	$(this).find('.nav_all_lislide').hide();
})
})


//删除购物车里的产品
function delCartProduct(cartLineIndex,productStoreId,quantity,displayPrice){
	var url = "ajaxDeleteFromCart?DELETE_"+cartLineIndex+"=Y&productStoreId="+productStoreId;
	$.ajax({
		url:url,
		type:'post',
		dataType:'json',
		success:function(data){
			
			$('#'+productStoreId+"_"+cartLineIndex).remove();
			var num = $('#nav-cart-num').text()-quantity;
			$('#nav-cart-num').text(num);
			$('#headerProductNum').val(num);
			var playPrice = ($('#cartTotalPrice').text()-displayPrice*quantity);
			$('#cartTotalPrice').text(playPrice);
		}
	})
}  
		 
//登录浮层
function showLogin(dom){
	var LoginStatus = getLoginStatus();
	if(LoginStatus == true){
		return false;
	}
	
	var param = getUrlParam('invite_id');
	var param1 = getUrlParam('invite_member_id');
	var url = $(dom).attr('href');

	if(param){
		url=url+'?invite_id='+param;
	}else if(param1){
		url=url+'?invite_member_id='+param1;
	}

	var d = dialog({
		url:url,
	    id:'LoginDiv',
	    width:'644px',
	    cancel: false
	});
	d.showModal();
	return false;
}

function showPayPass(dom){
//	var LoginStatus = getLoginStatus();
//	if(LoginStatus == false){
//		return false;
//	}
	var url = $(dom).attr('data');

	var d = dialog({
		url:url,
	    id:'PayPassDiv',
	    width:'644px',
            height:'372px',
	    cancel: false
	});
	d.showModal();
	return false;
}

//判断是否为注册
function checkInviteReg(){
	var param = getUrlParam('invite_id');
	var param1 = getUrlParam('invite_member_id');
	if(param || param1){
		$('#red').trigger('click');
	}
}
//找回密码窗口展示
function showForgetPwd(){
	var param = getUrlParam('verify');
	if(param){
		var url = $('#ChangePwd_url').val();
		$('#red').attr('href',url);
		$('#red').trigger('click');
	}
}

//获取url参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
    if (r != null) return unescape(r[2]); return null; //返回参数值
}

//关闭邀请提示窗
function CloseInviteRemind(dom){
	var url= $('#delInviteSession_url').val();
	var href = $(dom).attr('href');
	$.ajax({
		url:url,
		type:'post',
		dataType:'json',
		success:function(i){
			if(i.status==1){
				$('.myhome_tip').remove();
				window.location.href = href;
			}
		}
	})
	return false;
}
//检测用户登录状态
function getLoginStatus(){
	var result = false;
	$.ajax({
		url:'/Login/getStatus',
		type:'post',
		dataType:'text',
		async:false,
		success:function(i){
			if(i == 1){
				window.location.reload();
				result = true;
			}
		}
	})
	return result;
}
