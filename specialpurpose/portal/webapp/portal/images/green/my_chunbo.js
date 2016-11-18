$(function(){

	// tab切换
	(function(){
		tab($('.order_show'));
		tab($('.recent_browse'));
		tab($('.my_collect'));
		tab($('.points_show'));
		tab($('.my_wishlist_tab'));
		tab($('.comments_share'));
		function tab(obj){

			var aTabLi = obj.find('.tab_wrap .tab li');
			var aTabCon= obj.find('.tab_content');
			aTabCon.hide().eq(0).show();

			aTabLi.each(function(i){

				$(this).click(function(){

					aTabLi.removeClass('on');
					$(this).addClass('on');
					aTabCon.hide().eq(i).show();

				})
			})


		}
	})();
	

	
	// 弹窗

	(function(){

		$('.pop_up .cross').click(function(){
			$(this).parent().hide();

			$('.shade_box').hide();
		})

		$('.pop_up_return .cross').click(function(){
			$(this).parent().hide();
		})
	})();
	

	// 轮播图
	(function(){

			var aLbtn = $('.left_btn');
			var aRbtn = $('.right_btn');
			var aWrap=$('.luobo_wrap .lunbo');
			var aUl=$('.luobo_wrap .lunbo ul');
			aLbtn.addClass('left_btn_disable')
			aRbtn.off();
			aLbtn.off();
			aRbtn.each(function(i){
				
				$(this).on('click',function(){

					var aLi= aUl.eq(i).find('li');
					var iWrapWidth=parseInt(aWrap.eq(i).outerWidth())-1;
					var iAllWidth=parseInt(aLi.eq(0).outerWidth())*aLi.length;
					var iLeft=parseInt(aUl.eq(i).css('left'));
					$(this).removeClass('right_btn_disable');
					$(this).siblings('.left_btn').removeClass('left_btn_disable');
						
						document.title=iAllWidth-Math.abs(iLeft)+":"+iWrapWidth

						if(iAllWidth-Math.abs(iLeft)>=2*iWrapWidth){
							
							$(this).removeClass('.right_btn_disable');
							aUl.eq(i).stop(true,false).animate({
								"left":iLeft-iWrapWidth+'px'

							},900)
						}else if(iAllWidth-Math.abs(iLeft)<2*iWrapWidth){
						
							aUl.eq(i).stop(true,false).animate({
								"left":-iAllWidth+iWrapWidth+'px'
							},900)

							$(this).addClass('right_btn_disable');
							
						}

					
					
				})
			});

			aLbtn.each(function(i){

				$(this).on('click',function(){
					var aLi= aUl.eq(i).find('li');
					var iWrapWidth=parseInt(aWrap.eq(i).outerWidth())-1;
					var iAllWidth=parseInt(aLi.eq(0).outerWidth())*aLi.length;
					var iLeft=parseInt(aUl.eq(i).css('left'));

					$(this).removeClass('left_btn_disable');
					$(this).siblings('.right_btn').removeClass('right_btn_disable');

						if(iLeft+iWrapWidth<0){
							
							aUl.eq(i).stop(true,false).animate({
								"left":iLeft+iWrapWidth+'px'

							},900)
						}else if(iLeft+iWrapWidth>=0){
						
							
							aUl.eq(i).stop(true,false).animate({
								"left":0+'px'
							},900)

							$(this).addClass('left_btn_disable');
							
						}

				})
			});
	})();

})

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

