/*
 * SimpleModal 1.1.1 - jQuery Plugin
 * http://www.ericmmartin.com/projects/simplemodal/
 * http://plugins.jquery.com/project/SimpleModal
 * http://code.google.com/p/simplemodal/
 *
 * Copyright (c) 2007 Eric Martin - http://ericmmartin.com
 *
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * Revision: $Id: jquery.simplemodal.js 93 2008-01-15 16:14:20Z emartin24 $
 *
 */
(function($){
	$.modal=function(data,options){
		return $.modal.impl.init(data,options);
	};
	$.modal.close=function(){
		$.modal.impl.close(true);
	};
	
	$.fn.modal=function(options){		
		return $.modal.impl.init(this,options);
	};
	$.modal.defaults={
		overlay:50,
		overlayId:'modalOverlay',		//遮盖层Id
		overlayCss:{},
		containerId:'modalContainer',	//内容Id
		containerCss:{},
		close:false,					//是否显示关闭按钮, 默认为不显示
		closeTitle:'Close',
		closeClass:'modalClose',
		persist:false,
		onOpen:null,
		onShow:null,
		onClose:null,
		onConfirm:null,					//确认按钮事件 ，返回true关闭弹出窗口，false
		onGiveUp:null,					//放弃、关闭按钮事件
		//dhgate param		
		isModal:true,					//是否是模态
		scrollType:'center',			//弹出窗口的显示模式：center：居中显示;scroll:随scroll浮动;relative:相对某一元素定位。
		nLeft:0,						//弹出框left相对位置
		nTop:0,							//弹出框top相对位置
		relativeEleId:'',				//scrollType为relative时，作为定位的HTML元素id。
		isCanDrag:true					//是否可以拖动(对于scroll浮动模式无效)
	};
	
	$.modal.impl={
		opts:null,
		dialog:{},
		init:function(data,options){			
			if(this.dialog.data){return false;};
			
			this.opts=$.extend({},$.modal.defaults,	options);
			if(typeof data=='object'){
				data=data instanceof jQuery?data:$(data);
				if(data.parent().parent().size()>0){
					this.dialog.parentNode=data.parent();
					if(!this.opts.persist){
						this.dialog.original=data.clone(true);
					}
				}
			}else if(typeof data=='string'||typeof data=='number'){
				data=$('<div>').html(data);
			}else{
				if(console){
					console.log('SimpleModal Error: Unsupported data type: '+typeof data);
				}
				return false;
			}
			
			this.dialog.data=data.addClass('modalData');
			data=null;
			this.create();
			this.open();
			if($.isFunction(this.opts.onShow)){
				this.opts.onShow.apply(this,[this.dialog]);
			}
			return this;
		},
		
		create:function(){
			this.dialog.overlay=$('<div>').attr('id',this.opts.overlayId).addClass('modalOverlay').css($.extend(this.opts.overlayCss,{opacity:this.opts.overlay/100,height:'100%',width:'100%',position:'fixed',left:0,top:0,zIndex:3000})).hide().appendTo('body');
			
			this.dialog.container=$('<div>').attr('id',this.opts.containerId).addClass('modalContainer').css($.extend(this.opts.containerCss,{position:'absolute',zIndex:3100})).append(this.opts.close?'<a class="modalCloseImg '+this.opts.closeClass +'" title="'+this.opts.closeTitle+'"></a>':'').hide().appendTo('body');
			if($.browser.msie&&($.browser.version<7) && this.opts.isModal){
				//如果加入此段code，IE6下有焦点问题
				this.fixIE();
			}
			
			this.dialog.container.append(this.dialog.data.hide());
		},
		
		bindEvents:function(){
			var modal=this;
			$('.'+this.opts.closeClass).click(function(e){e.preventDefault();modal.close();});
			if(this.opts.scrollType =='scroll' ){
				var modal=this;
				if($.browser.msie){//IE 浏览器可以响应onscroll事件					
					$(window).scroll(function(e){modal.redraw();});					
				}
			}			
			if(this.opts.isCanDrag){//如果弹出框允许拖动，绑定拖动事件
				var oPopBar = this.dialog.container.find("#DHPopBar");			
				if(oPopBar[0] != null ){
					var modal=this;					
					oPopBar.mousedown(
						function(e){
							oPopBar.css("cursor","move"); //鼠标光标变为十字箭头光标，用于标示对象可被移动。
							modal.regDrag(e);
						}
					);
					this.opts.isDraging = false;
				}
			}
			//关闭按钮事件绑定
			var arrCloseBtn = this.dialog.container.find("."+this.opts.closeClass);	//class="closebtn"	
			var oThis = this;
			var oDialog = this.dialog;
			if(arrCloseBtn.length>0){
				var funGiveUp = this.opts.onGiveUp;
				//for(var i=0; i<arrCloseBtn.length; i++){
					arrCloseBtn.click(
						function(e){
							var bClose = true;
							if($.isFunction(funGiveUp)){
								bClose = funGiveUp.apply(oThis,[oDialog]);	
							}
							if(bClose){	
								$.modal.close();
							}
							return false;
						}
					);
				//}
			}
			
			var arrCloseBtn2 = this.dialog.container.find(".closebtn");	//class="closebtn"	
			if(arrCloseBtn2.length>0){
				var funGiveUp = this.opts.onGiveUp;
				//for(var i=0; i<arrCloseBtn.length; i++){
					arrCloseBtn2.click(
						function(e){
							var bClose = true;
							if($.isFunction(funGiveUp)){
								bClose = funGiveUp.apply(oThis,[oDialog]);	
							}
							if(bClose){	
								$.modal.close();
							}
							return false;
						}
					);
				//}
			}
			
			var arrConfirmBtn = this.dialog.container.find(".confirmbtn");	//class="closebtn"	
			if(arrConfirmBtn.length>0){
				var funConfirm = this.opts.onConfirm;
				for(var i=0; i<arrConfirmBtn.length; i++){
					arrConfirmBtn.click(
						function(e){
							var bClose = true;
							if($.isFunction(funConfirm)){
								bClose = funConfirm.apply(oThis,[oDialog]);	
							}
							if(bClose){	
								$.modal.close();
							}
							return false;
						}
					);
				}
			}
								
		},
		
		unbindEvents:function(){
			$('.'+this.opts.closeClass).unbind('click');
			if(this.opts.scrollType =='scroll'){
				if($.browser.msie)$(window).unbind('scroll'); 
			}
			if(this.opts.isCanDrag){
				var oPopBar = this.dialog.container.children().children(0);
				if(oPopBar != null){					
					oPopBar.unbind('mousedown');
				}
			}	
			
			var arrCloseBtn = this.dialog.container.find(".closebtn");			
			if(arrCloseBtn.length>0){				
				for(var i=0; i<arrCloseBtn.length; i++){
					arrCloseBtn[i].unbind('click');
				}
			}
			
			var arrConfirmBtn = this.dialog.container.find(".confirmbtn");	//class="closebtn"	
			if(arrConfirmBtn.length>0){
				var funConfirm = this.opts.onConfirm;
				for(var i=0; i<arrConfirmBtn.length; i++){
					arrConfirmBtn[i].unbind('click');
				}	
			}				
		},
		
		fixIE:function(){
			var wHeight=$(document.body).height()+'px';
			var wWidth=$(document.body).width()+'px';
			this.dialog.overlay.css({position:'absolute',height:wHeight,width:wWidth});
			this.dialog.container.css({position:'absolute'});
			this.dialog.iframe=$('<iframe src="javascript:false;">').css($.extend(this.opts.iframeCss,{opacity:0,position:'absolute',height:wHeight,width:wWidth,zIndex:1000,width:'100%',top:0,left:0})).hide().appendTo('body');
		},
		
		open:function(){
			if(this.dialog.iframe){
				this.dialog.iframe.show();
			}
			if($.isFunction(this.opts.onOpen)){
				this.opts.onOpen.apply(this,[this.dialog]);
			}else{
				if(this.opts.isModal == true){ //如果是模态弹出框，
					this.dialog.overlay.show();
				}else{
					this.dialog.overlay.hide();
				}
				
				this.dialog.container.show();
				this.dialog.data.show();
			}				
			this.redraw();
			if(this.opts.scrollType =='scroll' && $.browser.mozilla ){
				this.dialog.container.css({position:'fixed'});							
			}
				
			this.bindEvents();
			
		},
		
		redraw:function(){
			if(!this.dialog.data){return false;}
			
			var oContainerEle = this.dialog.container[0];
			var nPanelWidth = oContainerEle.offsetWidth;
			var nPanelHeight = oContainerEle.offsetHeight;
			
			var nScreenWidth = 1204;
			var nScreenHeigth = 768;
			if(window.top == window){
				nScreenWidth = window.screen.availWidth;
				nScreenHeigth = window.screen.availHeight;
			}else{
				nScreenHeigth = getDocHeight(document) ;
			    nScreenWidth = document.documentElement.scrollWidth ;			
			    function getDocHeight(doc) {
			        var docHt = 0;
			        if (doc.height) {
			            docHt = doc.height;
			        }
			        else if (doc.body) {
			            if (doc.body.scrollHeight) docHt = doc.body.scrollHeight;
			        }
			        return docHt;
			    }		
			}
			
			
			//document.documentElement.offsetHeight || document.body.clientHeight;
			var nLeft = this.opts.nLeft;
			var nTop = this.opts.nTop;
			if(this.opts.relativeEleId !=''){
				var oRE = document.getElementById(this.opts.relativeEleId);
				if(oRE != null){
					var oPosInfo = this.getElementPositionInfo(this.opts.relativeEleId);
					nTop = oPosInfo["top"]+nTop;
					if((document.documentElement.scrollTop || document.body.scrollTop)>0){
						nTop -= (document.documentElement.scrollTop || document.body.scrollTop);
					}
					//nLeft = oPosInfo["left"] + oPosInfo["width"] + 5 + "px";
					nLeft = oPosInfo["left"] + nLeft;
					
					this.opts.nLeft = nLeft;
					this.opts.nTop = nTop;
				}
				this.opts.relativeEleId="";
			}
			if(nLeft == 0){
				nLeft = (nScreenWidth - nPanelWidth)/2;
				nLeft = (nLeft <0)?0:nLeft;
			}
			
			if(nTop == 0){
				var nTop = (nScreenHeigth- nPanelHeight)/4; 
				nTop = (nTop <0)?0:nTop;
			}
						
			oContainerEle.style.left = parseInt(nLeft) + "px";				
			oContainerEle.style.marginLeft = "0px";
			nTop += (document.documentElement.scrollTop || document.body.scrollTop) ;
			oContainerEle.style.top = nTop + "px";				
			oContainerEle.style.marginTop = "0px";
		},
		
		close:function(external){
			document.body.focus();
			if(!this.dialog.data){return false;}
			
			if($.isFunction(this.opts.onClose)&&!external){
				this.opts.onClose.apply(this,[this.dialog]);				
			}else{
				if(this.dialog.parentNode){
					if(this.opts.persist){
						this.dialog.data.hide().appendTo(this.dialog.parentNode);
					}else{
						this.dialog.data.remove();
						this.dialog.original.appendTo(this.dialog.parentNode);
					}
				}else{
					this.dialog.data.remove();
				}
				
				this.unbindEvents();	
				
				if(window.top.event != null){
					window.top.event.returnValue = false;
				}
				
				this.dialog.container.innerHTML="";
				this.dialog.container.remove();
				this.dialog.overlay.remove();
				if(this.dialog.iframe){
					this.dialog.iframe.remove();
				}
				this.dialog={};
			}
					
		},
		
		regDrag:function(e){
			if(!this.opts.isCanDrag || this.opts.isDraging)return; 	//当定义窗口为不可拖动或 已经处于拖拽状态返回。
			
			e = e || window.event;
			this.Drag(this.dialog.container[0],e,false);
		},

		Drag:function(obj, e, limit){
			if(this.opts.isDraging ||!this.opts.isCanDrag) return ; 	//当定义窗口为不可拖动或 已经处于拖拽状态返回。

    		e = e || window.event;
			//closeHistory(e);
    		var x=parseInt(obj.style.left);
    		var y=parseInt(obj.style.top);
    		var x_=e.clientX-x;
    		var y_=e.clientY-y;
 
	    	if(document.addEventListener){
		        document.addEventListener('mousemove', KSHY_move, true);
		        document.addEventListener('mouseup', KSHY_up, true);
		    } else if(document.attachEvent){
		        document.attachEvent('onmousemove', KSHY_move);
		        document.attachEvent('onmouseup', KSHY_up);
		    }
			
			this.opts.isDraging = true;
    
    		KSHY_stop(e);    
    		KSHY_abort(e);
    
		    function KSHY_move(e){
		        e = e || window.event;
		        if((e.clientX-x_) < 0) {
		            return false;
		        }
		        if((e.clientY-y_) < 0) {
		            return false;
		        }
				/*
		        if(limit){
		            if((e.clientX-x_+K.config.oObjWidth)>K.config.bodyArea["x"]) {
		                return false;
		            }
		            if((e.clientY-y_+K.config.oObjHeight)>K.config.bodyArea["y"]) {
		                return false;
		            }		            
		        }*/
		       
		        obj.style.left=e.clientX-x_+'px';
		        obj.style.top=e.clientY-y_+'px';
		        KSHY_stop(e);
		    }

		    function KSHY_up(e){
		        e = e || window.event;
		        if(document.removeEventListener){
		            document.removeEventListener('mousemove', KSHY_move, true);
		            document.removeEventListener('mouseup', KSHY_up, true);
		        } else if(document.detachEvent){
		            document.detachEvent('onmousemove', KSHY_move);
		            document.detachEvent('onmouseup', KSHY_up);
		        }
		        		        
				$.modal.impl.opts.isDraging = false;
				$.modal.impl.opts.nLeft = $.modal.impl.dialog.container[0].offsetLeft;
				$.modal.impl.opts.nTop = $.modal.impl.dialog.container[0].offsetTop - (document.documentElement.scrollTop || document.body.scrollTop);
				
		        KSHY_stop(e);
				//还原光标
		    	var oPopBar = $.modal.impl.dialog.container.children().children("#dargbar");				
				if(oPopBar[0] != null ){
					oPopBar.css("cursor","");			
				}
		    }

		    function KSHY_stop(e){
		    	
		        if(e.stopPropagation) {
		        	return e.stopPropagation();
		        }else{
		        	return e.cancelBubble=true;
		        }            
		    }

		    function KSHY_abort(e){
		        if(e.preventDefault) return e.preventDefault();
		        else return e.returnValue=false;
		    }		    
		},
		
		getElementPositionInfo:function (strEleId){
			if(typeof(strEleId)==	"string"){
				strEleId = "#" + strEleId;
			}

			var oEle$ = $(strEleId);
			
			
			var oEle = oEle$[0]; 
			if(!oEle)return null;
			
			var arrPos={"top":"", "left":"", "width":"","height":""};
			var lTop = pageY(oEle);
			var lLeft = pageX(oEle);
			var lWidth = oEle.offsetWidth;
			var lHeight = oEle.offsetHeight;
			arrPos["top"] = lTop;
			arrPos["left"] = lLeft;
			arrPos["width"] = lWidth;
			arrPos["height"] = lHeight;
			
			return arrPos;
			
			function pageX(oEle){	
				if((oEle.parentElement !=null && oEle.parentElement.id=='modalContainer') || (oEle.parentNode !=null && oEle.parentNode.id=='modalContainer'))return 0;
				
			    return oEle.offsetParent?(oEle.offsetLeft+pageX(oEle.offsetParent)):oEle.offsetLeft;
			}
			
			function pageY(oEle){
				if((oEle.parentElement !=null && oEle.parentElement.id=='modalContainer') || (oEle.parentNode !=null && oEle.parentNode.id=='modalContainer'))return 0;
				
			    return oEle.offsetParent?(oEle.offsetTop+pageY(oEle.offsetParent)):oEle.offsetTop;
			}
				
		}
	};
})(jQuery);