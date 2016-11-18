//摘要页公用弹层脚本
var myDhgatePopUp = function(options){
	this.SetOptions(options);
	if ( !document.getElementById(this.options.PopUpWrap) ) {
		return;
	}
	this.PopUpWrap = $('#' + this.options.PopUpWrap)
	this.popMask = $('#' + this.options.popMask);
	this.popMaskIframe = $('#' + this.options.popMaskIframe);
	this.isIE6 = ( $.browser.msie && $.browser.version == '6.0' );
	
	this.Init();
};
myDhgatePopUp.prototype = {
	SetOptions: function(options){
		this.options = {
			PopUpWrap: '',
			popMask: 'popMask',
			popMaskIframe:'popMaskIframe'
		};
		$.extend(this.options, options || {});
	},
	Init:function(){
		$('body').append(this.PopUpWrap);
		$('body').append(this.popMask);
	},
	PopShow:function(){
		var _this = this;
		_this.PopUpWrap.css({display:'block'});
		_this.popMask.css({display:'block'});
		_this.SetPosition();
		$(window).bind('scroll resize',function(){
			_this.SetPosition();
		});
		$(document).click(function(event){
			var evtTarget = event.target,
				evtTargetJQ	= $(evtTarget);
			if(evtTargetJQ.attr('attr-close')){
				_this.PopUpWrap.css({display:'none'});
				_this.popMask.css({display:'none'});
			}
		});
	},
	SetPosition: function() {
		if ( this.PopUpWrap.css('display') == 'none') {
			return;
		}
		var hDocument, wDocument, iHeight, iWidth, hWindow, wWindow, _x, _y, tScroll, hScroll, _this = this;
		hDocument = $(document).height();
		wDocument = Math.min($(document).width(), $("body").outerWidth(true));
		iHeight = this.PopUpWrap.outerHeight(true);
		iWidth = this.PopUpWrap.outerWidth(true);
		hWindow = $(window).height();
		wWindow = $(window).width();
		tScroll = $(window).scrollTop();
		lScroll = $(window).scrollLeft();
		if ( !this.isIE6 ) {
			_x = parseInt((wWindow - iWidth) / 2);
			_y = parseInt((hWindow - iHeight) / 2);
		} else {
			_x = parseInt((wWindow - iWidth) / 2 + lScroll);
			_y = parseInt((hWindow - iHeight) / 2 + tScroll);
		}
		this.PopUpWrap.css({top: _y, left: _x });
		this.popMask.css({width: wDocument, height: hDocument});
		this.popMaskIframe.css({width: wDocument, height: hDocument});
	}
};


//调用
//$(document).ready(function(){
	//var loanPop = new myDhgatePopUp({PopUpWrap: 'loanPopWrap'}); //先初始化一下
	//loanPop.PopShow(); //调用这个现实弹层
//});