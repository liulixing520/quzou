//PlaceHolder
var PlaceHolder = {
	init:function(){
	    $("input").each(function(){
		   PlaceHolder.create($(this));
		})
	},
	class_input:function(classname){
	     $("."+classname).each(function(){
		   PlaceHolder.create($(this));
		})
	},
	create:function(input){
	   var temp_placeholder=$(input).attr("placeholder");
	   if($(input).val()!=temp_placeholder){
	      $(input).addClass("sms-color1");
	      $(input).val(temp_placeholder);
	   }else{
	      $(input).addClass("sms-color1"); 
	   }
	   $(input).focus(function(){
			if($(this).val()==temp_placeholder){
	           $(this).val("");
			   $(this).removeClass("sms-color1");
			}
	   }),
	   $(input).blur(function(){
			if($(this).val()==""){
	           $(this).val(temp_placeholder);
			   $(this).addClass("sms-color1");
			}
	   })
    }
};

//获取验证码
function getCheckCode(){
	var getCodeBtn = $('#getCodeBtn'),
		CodeSendTip =$('#CodeSendTip');
		var timer=null;
	
	
	getCodeBtn.click(function(){
					  
		if($(this).children().attr('disabled')==true){
			return;
		}
		$(this).addClass('sms-sixty-second');
		$(this).children().attr('disabled','disabled');
		$(this).children().val('60秒之内输入');
		CodeSendTip.css('display','inline-block');
		
		var n=59;
		clearInterval(timer);
		timer = setInterval(function(){
			var getCodeBtn = $('#getCodeBtn'),
				CodeSendTip =$('#CodeSendTip');	
				
			getCodeBtn.children().val( n + '秒之内输入');
			n--;
			if( n < 0 ){
				clearInterval(timer);
				getCodeBtn.children().val('重新发送验证码');
				getCodeBtn.children().removeAttr('disabled');
				getCodeBtn.removeClass('sms-sixty-second');
				CodeSendTip.css('display','none');
			}
		},1000);

	});
	
}


//我要订阅
function wantSubscription(){
	var wantSubscriptionBtn = $('#wantSubscriptionBtn'),
		smsSubscriptWrap = $('#smsSubscriptWrap'),
		smsResultWrap = $('#smsResultWrap'),
		setRadios = $('#smsSubscriptWrap :radio'),
		confirmResultBtn = $('.confirmResultBtn'),
		cancelResultBtn = $('.cancelResultBtn'),
		checkedTimeBtn = $('.checkedTimeBtn'),
		modifySubscriptBtn = $('.modifySubscriptBtn'),
		resultLine1 = $('.resultLine1'),
		resultLine2 = $('.resultLine2'),
		resultLine3 = $('.resultLine3'),
		setTime1 = $('.setTime1'),
		setTime2 = $('.setTime2'),
		setTime3 = $('.setTime3'),
		setTime4 = $('.setTime4'),
		resultTime1 = $('.resultTime1'),
		resultTime2 = $('.resultTime2'),
		resultTime3 = $('.resultTime3'),
		resultTime4 = $('.resultTime4');
		
	wantSubscriptionBtn.click(function(){
		$(this).css({display: 'none'});	
		smsSubscriptWrap.css({display: 'block'});
	});
	
	confirmResultBtn.click(function(){
		smsSubscriptWrap.css({display: 'none'});
		smsResultWrap.css({display: 'block'});
		if( $(setRadios[0]).attr('checked') == true ){
			resultLine1.css({display: 'block'});
			resultTime1.text(setTime1.val());
			resultLine3.css({display: 'none'});
			resultLine2.css({display: 'none'});
		}else{
			if( checkedTimeBtn.attr('checked') == true){
				resultLine3.css({display: 'block'});
				resultTime2.text(setTime2.val());
				resultTime3.text(setTime3.val());
				resultTime4.text(setTime4.val());
				resultLine2.css({display: 'none'});
			}else{
				resultLine2.css({display: 'block'});
				resultLine3.css({display: 'none'});
			}
			resultLine1.css({display: 'none'});
		}
		smsSubscriptWrap.parent().prev().html('<span class="sms-tick-icon"></span>');
	});
	
	cancelResultBtn.click(function(){
		var judge = resultLine1.css('display') == 'block' || resultLine2.css('display') == 'block' || resultLine3.css('display') == 'block';
		
		smsSubscriptWrap.css({display: 'none'});
		if( judge ){
			smsResultWrap.css({display: 'block'});
			smsSubscriptWrap.parent().prev().html('<span class="sms-tick-icon"></span>');
		}else{
			wantSubscriptionBtn.css({display: 'block'});
			smsSubscriptWrap.parent().prev().html('未订阅');
		}
	});
	
	modifySubscriptBtn.click(function(){
		smsSubscriptWrap.css({display: 'block'});
		smsResultWrap.css({display: 'none'});									  
	});
	
}

//我要退订
var wantUnsubscribe = function( options ){
	this.SetOptions(options);
	
	this.unsubscribePop = $('#' + this.options.unsubscribePop);

	this.timer = null;
	
	this.Init();
};

wantUnsubscribe.prototype = {
	SetOptions: function( options ) {
		this.options = {
			unsubscribePop: 'unsubscribePop'
		};
		$.extend( this.options, options || {} );
	},
	Init: function() {
		this.Load();	
	},
	Load: function(){
		var _this = this;
		
		$(document).click(function(event){
			var evtTarget = event.target,
				evtTargetJQ	= $(evtTarget);
				
			if( evtTargetJQ.attr('conduct') == 'subscription' ){
				_this.parentTd = evtTargetJQ.parent('td');
				_this.prevTd = evtTargetJQ.parent('td').prev();
				_this.parentTd.html('即时短信服务<a class="sms-m-l20" href="javascript:;" conduct="unsubscribe">我要退订</a>');
				_this.prevTd.html('<span class="sms-tick-icon"></span>');
				
			}
				
			if ( evtTargetJQ.attr('conduct') == 'unsubscribe' ) {
				_this.btnTop = evtTargetJQ.offset().top + evtTargetJQ.height() + 8;
				_this.btnLeft = evtTargetJQ.offset().left - _this.unsubscribePop.width()/2 + 20;
				_this.tdSelf = evtTargetJQ.parents('td');
				_this.unsubscribePop.css({display:'block'});
				_this.SetPosition();
			}
			
			if ( evtTargetJQ.attr('conduct') == 'closepop' ) {
				_this.unsubscribePop.css({display:'none'});
			}
			
			if ( evtTargetJQ.attr('conduct') == 'success' ) {
				
				if(_this.tdSelf.hasClass('waitOrder')){
					$('#wantSubscriptionBtn').css({display:'block'});
					$('#smsResultWrap').css({display: 'none'});
					$('.resultLine1').css({display: 'none'});
					$('.resultLine2').css({display: 'none'});
					$('.resultLine3').css({display: 'none'});
				}else{
					_this.tdSelf.html('<a href="javascript:;" conduct="subscription">我要订阅</a>');
				}
				
				_this.tdSelf.prev().html('未订阅');
				_this.unsubscribePop.css({display:'none'});
			}
		});
	},
	SetPosition: function(){
		var _this = this;
		
		_this.unsubscribePop.css({top: _this.btnTop, left: _this.btnLeft});
		
	}
}