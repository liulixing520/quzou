var _index;
	 var timershow, timerhide;
	 var _com_search_body=$('.com_search_box .com_search_body');
	 var _com_search_li=$('.com_search_libox .com_search_li');
	$(function(){
		_com_search_li.hover(function(){
			if (timerhide) {
				 window.clearInterval(timerhide);
			 }
			$(this).addClass('cur').siblings().removeClass('cur');
			_index=$(this).index();
			_com_search_body.stop().hide().eq(_index).show();
		},function(){
			settimerhide()
		})
	});
	_com_search_body.hover(function(){
			if (timerhide) {
				 window.clearInterval(timerhide);
			 }
			
	},function(){
			settimerhide()
		});
	
	function settimerhide() {
      timerhide = window.setTimeout(titItemHide, 200)
  	}
  
  function titItemHide(){
	_com_search_li.removeClass('cur');
		_com_search_body.hide();	  
	}
	
	
//全局模块函数
$(function(){
	//selectList下拉框
	((function(){
		var selectList = $('.selectList');
		var title = selectList.find('span');
		var optionList = selectList.find('.optionList');
		title.on('mouseenter',function () {
			$(this).parents('.selectList')
			.css('z-index','9')
			.find('.optionList').show()
			.find('li').click(function () {
				$(this).parents('.optionList').hide();
			});
			$(this).siblings("i").addClass('on');
			//ie6,7下回复区域的下拉菜单层级显示问题
			if($.browser.msie){
				$(this).parents('.selectlist-li').css("z-index","10");
				$(this).parents('.selectlist-li').parent('ul').parent().css("z-index","10");
				//$(this).parents('.workEvaluate').parent('.section').css("z-index","1");
			}
		});

		selectList.on('mouseleave',function () {
			$(this).css('z-index','0').find('.optionList').hide();
			$(this).find("i").removeClass('on');
			// ie6,7下回复区域的下拉菜单层级显示问题
			if($.browser.msie){
				$(this).parent('.selectlist-li').css("z-index","0");
				$(this).parent('.selectlist-li').parent('ul').parent().css("z-index","0");
		 		//$(this).parents('.workEvaluate').parent('.section').css("z-index","0");
		 	}
		});

		optionList.each(function () {
			var opItem = $(this).find('li').length;
			if(opItem > 8){
				$(this).find('ul').addClass('ulLimit');
			}
		});
      
    })());

})

function chooseLi(val,id){
    $('#'+id).val(val);
    $('#'+id+'Span').text(val);
    $('#'+id+'Ul li a').removeClass();
    $('.optionList').hide();
    return false;
}
$(function(){
	$(".kingkong_return_count").each(function(index, element) {
       var jian = $(this).find(".jian"),plus = $(this).find(".plus"),input = $(this).find(".kingkong-count");
	   jian.click(function(){
		   var count = parseInt(input.val());
		   if(count==0) return;
		   input.val(count-1);
		})
		plus.click(function(){
		   var count = parseInt(input.val());
		   if(count < parseInt(input.attr("maxnum"))){
			   input.val(count+1);
			};
		})
		input.blur(function(){
			var val = $(this).val();
			if(!/^\d+$/g.test(val)){
				$(this).val(0);
			}
			if(parseInt(val)>parseInt($(this).attr("maxnum"))){
				$(this).val($(this).attr("maxnum"));
			}
		})
    });
})
function setScrollTop(){
	h = $(window).height()/2;
	t = $(document).scrollTop();
	if(t > h){
		$('#gotop').fadeIn();
	}else{
		$('#gotop').fadeOut();
	}
}

$(window).scroll(function(e){
	setScrollTop();		
});
$(function(){
	$(".liaocheng_list th input[type=checkbox]").click(function(){
		var checked = $(this).attr("checked"),sibs = $(this).parents("tr").siblings().find("input[type=checkbox]");
		if(checked){
			sibs.attr("checked","checked");
		}
		else{
			sibs.removeAttr("checked");
		}
	});
	$(".liaocheng_list th .del").click(function(){
		var obj = $(this).parents("tr").siblings("tr");
			obj.each(function(index, element) {
                if($(this).find("input[type=checkbox]").attr("checked")){
					$(this).remove();
				}
            });
	});
	$(".liaocheng_list td .del").click(function(){
		$(this).parents("tr").remove();
	});
});

/*
* new
*/
$(function(){
	
	// 设置input.inp-text的value,默认定义值在 data-value中
	function setValue(elem, type){
		var self = elem,
			defVal = self.val(),
			dataVal = self.data("value"),
			val = ""; 
		
		if(type == "focus") {
			val = !!dataVal ? $.trim(defVal) == dataVal ? "" : defVal : defVal;
			self.removeClass("inpBlur").addClass("inpFocus");
			
		} else {
			val = !!dataVal ? $.trim(defVal) == "" ? dataVal : defVal : defVal;
			self.removeClass("inpFocus").addClass("inpBlur");
		}
		
		return val;
	}
	
	$(document).on("focus", "input.inp-text", function(){
		var self = $(this),
			val = setValue(self, "focus");
		
		self.val(val);
	});
	
	$(document).on("blur", "input.inp-text", function(){
		var self = $(this),
			val = setValue(self, "blur");
		
		self.val(val);
	});
	
	$.fn.setValue = function(){
		var $list = $(this).find("input.inp-text");
		
		$list.each(function() {
			var self = $(this),
				val = setValue(self, "blur");
			
			self.val(val);
        });
	};
	/*END*/
	
	/*置顶*/
	$.fn.tiptop = function(){
		var self = $(this),
			top = self.parent().offset().top;
		
		function keepTop(){
			if($(window).scrollTop() >= top) {
				self.attr("style", "position:fixed;");
			} else {
				self.removeAttr("style");
			}
		}
		
		$(window).scroll(function(){
			keepTop();
		});
	}
	
	/*全选*/
	setTimeout(function(){ /*套上程序后删除setTimeout*/
		$(document).on("change", "input.checkAll", function(){
			var _self = $(this),
				name = _self.data("name"),
				checked = _self.prop("checked"),
				$items = _self.closest(".popup_table_list").find(".items");
			
			$("input.checkItem").each(function() {
				var self = $(this);
				if(self.data("name") == name) {
					checked == true ? self.prop("checked", true) :self.prop("checked", false);
					
					if(checked) {
						self.prop("checked", true);
					} else {
						self.prop("checked", false);
					}
				}
			});
				
			$("input.checkAll[data-name = "+name+"]").prop("checked", checked);
			
			return false;
		});
	
		$(document).on("change", "input.checkItem", function(){
			var _self = $(this),
				name = _self.data("name"),
				checked = _self.prop("checked"),
				$items = _self.closest(".items");
				
			if(!checked) {
				$("input.checkAll[data-name = "+name+"]").prop("checked", checked);
				
			} else {
				var flag = true;
				$("input.checkItem").each(function() {
					var self = $(this),
						name = self.data("name");
						
					if(_self.data("name") == name && !self.prop("checked")) {
						flag = false;
					}
				});
				
				if(flag) {
					$("input.checkAll[data-name = "+name+"]").prop("checked", true);
				} else {
					$("input.checkAll[data-name = "+name+"]").prop("checked", false);
				}
			};
		});
	}, 500);
	
	/*价格区间*/
	$(document).on("focus", ".filterPrice input.inp-text", function(){
		clearTimeout(window.filterPriceTimer);
		window.filterPriceTimer = null;
		
		var _self = $(this),
			$box = _self.closest(".fp_box");
		
		$box.addClass("control");
	});
	
	window.filterPriceTimer = null;
	
	$(document).on("blur", ".filterPrice input.inp-text", function(){
		var _self = $(this),
			$box = _self.closest(".fp_box");
		
		window.filterPriceTimer = setTimeout(function(){
			$box.removeClass("control");
		}, 150);
	});
	
	$(document).on("click", ".fp_expand .btn", function(){
		clearTimeout(window.filterPriceTimer);
		window.filterPriceTimer = null;
		
		var _self = $(this),
			$box = _self.closest(".fp_box"),
			type = _self.hasClass("btn-default") ? "clear" : "true";
			
		if(type == "clear") {
			$box.find("input.inp-text").val("").blur();
		} else {
			
			//...
			
		}
		
		$box.removeClass("control");
	});
		
	$(document).on("keyup", ".filterPrice input.inp-text", function(){
		var _self = $(this),
			val = _self.val(),
			reg = /(^0{1})$|(^0{1}(\.)?)$|(^0{1}(\.)?\d{1,2})|(^\d+)$|(^\d+(\.)?)$|(^\d+(\.)?\d{1,2})/g;
		
		_self.val(val.match(reg));
	});
	
	/*删除列表*/
	$(document).on("click", ".items-del", function(){
		var _self = $(this),
			$cor = _self.closest(".items");
		
		$cor.addClass("pending").fadeOut(400, function(){
			$(this).remove();
		});
	});
	
	/*setNumber*/
	function setControlCountInfo(elem, type){
		var _self = elem,
			$box = _self.closest(".controlCount"),
			$inp = $box.find("input.inp-text"),
			val = $inp.val(),
			maxNum = $box.data("info").maxNum,
			minNum = $box.data("info").minNum;
			
		var cur = type == "subtract" ? val <= minNum ? minNum : +val-1 : val >= maxNum ? maxNum : +val+1;
			
		$inp.val(cur);
	}
	
	$(document).on("click", ".controlCount .subtract", function(){
		setControlCountInfo($(this), "subtract");
	});
	
	$(document).on("click", ".controlCount .add", function(){
		setControlCountInfo($(this), "add");
	});
	
	$(document).on("keyup", "input.enterNumber", function(){
		var _self = $(this),
			val = _self.val(),
			reg = /\d+/g,
			n = 0;
			
		n = val.match(reg) ? +(val.match(reg).join("")) : 0;
		
		if(_self.hasClass("controlCountInp")) {
			var $box = _self.closest(".controlCount"),
				maxNum = $box.data("info").maxNum,
				minNum = $box.data("info").minNum;
			
			n = n >= maxNum ? maxNum : n <= minNum ? minNum : n;
		}
		
		_self.val(n);
	});
	
	;(function($) {
        $.extend($.fn, {
            popup: function( options ){
                
                this.settings = $.extend(true, {}, $.popup.settings, options, {currentElement: this});
            
                var thisObj = $.popup.prototype.init(this.settings);
                
                return thisObj;
            }
        });
        
        $.popup = function( options ){
            
            this.settings = $.extend(true, {}, $.popup.settings, options, {currentElement: $([])});
            
            var thisObj = $.popup.prototype.init(this.settings);
                
            return thisObj;
        }
        
        function remindFollowFn(self, text, type, callback){
            self.popup({
                "content": '<div class="remind-text-box"><div class="remind-'+type+'-text">' + text + '</div></div>',
                "isAutoRemove": true,
                "width" : 600,
                "delay": 2000,
                "dispose" : "follow",
                "closeCallback":function(){
                    if(callback && typeof callback == 'function'){
                        callback();
                    }
                }
            });
        }
        
        $.fn.success = function(text,callback){
            remindFollowFn($(this), text, "success", callback);
        }
        
        $.fn.error = function(text,callback){
             remindFollowFn($(this), text, "error", callback);
        }

        $.success = function(text,callback){
            $.popup({
                "content": '<div class="remind-text-box"><div class="remind-success-text">' + text + '</div></div>',
                "isAutoRemove": true,
                "width" : 600,
                "delay": 1000,
                "dispose" : "center",
                "closeCallback":function(){
                    if(callback && typeof callback == 'function'){
                        callback();
                    }
                }
            });
        }

        $.error = function(text, callback){
            $.popup({
                "content": '<div class="remind-text-box"><div class="remind-error-text">' + text + '</div></div>',
                "isAutoRemove": true,
                "width" : 600,
                "delay": 1000,
                "dispose" : "center",
                "closeCallback":function(){
                    if(callback && typeof callback == 'function'){
                        callback();
                    }
                }
            });
        }
        
        
        $.extend($.popup, {
            
            /**
             * 参数配置
             */
            settings: {
                wrapElement : $("body"),
                containerClass : "popupContainer",
                closeClass : "popupClose",
                
                containerElement : $([]),
                currentElement : $([]),
                
                content : "what happen !",
                dispose : "center",
                width : 150,
                delay : 3000,
                
                data : null,
                openCallback : null,
                closeCallback : null,
                winClose : false, /*点击窗口是否自动关闭，不包括当前弹出提示层*/
                timer : 1000, /*如果timer==null, isAutoRemove不起作用*/
                isAutoRemove : false,
                isMask : false
            },
            
            prototype: {
                
                /**
                 * 创建遮罩层HTML
                 * @param   {settings}
                 * @return  {html}
                 */
                createMask: function( settings, flag ){
                    
					var h, sign = '', opacity = '';
					
					if(!flag) {
                    	h = this.winDocSize().docH;
						sign = 'id="mask"';
						opacity = 'filter:alpha(opacity=70); -moz-opacity:0.70; opacity:0.70;';
					} else {
						h = settings;
						sign = 'class="mask"';
						opacity = 'filter:alpha(opacity=35); -moz-opacity:0.35; opacity:0.35;';
					}
                    
                    var html = '<div '+sign+' style="width:100%; height:'+h+'px; background:#000; position:absolute; left:0; top:0; z-index:999; '+opacity+'"></div>';
                    
                    return html;
                },
                
                /**
                 * 创建容器HTML
                 * @param   {settings}
                 * @return  {html}
                 */
                createContainer: function( settings ){
                    
                    var html = "";
                    
                    if(settings.data) {
                        
                        var string = this.getDataString(settings.data);
                        
                        html = '<div class="'+settings.containerClass+'" style="width:'+settings.width+'px;" data-info="'+string+'"></div>';
                        
                    } else {
                        html = '<div class="'+settings.containerClass+'" style="width:'+settings.width+'px;"></div>';
                    }
                    
                    return html;
                },
                
                /**
                 * 获取窗口尺寸
                 * @param   {settings}
                 * @return  {winW, winH, docW, docH}
                 */
                winDocSize: function(){
                    var win = $(window),
                        doc = $(document);
                        
                    return {
                        winW : win.width(),
                        winH : win.height(),
                        docW : doc.width(),
                        docH : doc.height()
                    }
                },
                
                /**
                 * 居中对齐
                 * @param   {settings}
                 * @return  {left, top, type}
                 */
                centerOffset: function( settings ){
                    
                    var win = this.winDocSize(),
                        w   = settings.containerElement.outerWidth();
                        h   = settings.containerElement.outerHeight();
                    
                    var left = win.winW > w ? win.winW/2 - w/2 : 0,
                        top = win.winH > h ? win.winH/2 - h/2 : 0,
                        type = top > 0 ? "fixed" : "absolute";
                    
                    return {
                        left: left,
                        top: top,
                        type: type
                    };
                },
                
                /**
                 * 跟随
                 * @param   {settings}
                 * @return  {left, top}
                 */
                followOffset: function( settings ){
                    var win = this.winDocSize(),
                        offset = settings.currentElement.offset(),
                        left = offset.left,
                        top = offset.top,
                        w = settings.currentElement.outerWidth(),
                        h = settings.currentElement.outerHeight(),
                        W = settings.containerElement.outerWidth(),
                        H = settings.containerElement.outerHeight();
                        
                    var Top = 0;
                        
                    if(top + h + H > win.winH) {
                        
                        if(H > top) {
                            Top = 0;
                        } else {
                            Top = top - H - 5;
                        }
                    } else {
                        Top = top + h + 5;
                    }
                    
                    return {
                        left : left + W > win.winW ? left + w - W  : left,
                        top : top + h + H > win.winH ? H > top ? 0 : top - H : top + h + 5
                    }
                },
                
                /**
                 * 弹出方式选择 三种方式 center, top, follow
                 * @param   {settings}
                 */
                setDispose: function( settings ){
                    var offset = this.centerOffset(settings);
                    
                    switch(settings.dispose) {
                        case "center":
                            settings.containerElement.attr("style", "width:"+settings.width+"px; left:"+offset.left+"px; top:"+offset.top+"px; position:"+offset.type+"; z-index:1000;");
                        break;
                        
                        case "top":
                            settings.containerElement.attr("style", "width:"+settings.width+"px; left:"+offset.left+"px; top:0px; position:fixed; z-index:1000;");
                        break;
                        
                        case "follow":
                            if(!!settings.currentElement.length) {
                                
                                var offset = this.followOffset( settings )
                                
                                settings.containerElement.attr("style", "width:"+settings.width+"px; left:"+offset.left+"px; top:"+offset.top+"px; position:absolute; z-index:1000;");
                                
                            } else {
                                settings.containerElement.attr("style", "width:"+settings.width+"px; left:"+offset.left+"px; top:"+offset.top+"px; position:"+offset.type+"; z-index:1000;");
                            }
                        break;
                        
                        default:
                            settings.containerElement.attr("style", "width:"+settings.width+"px; left:"+offset.left+"px; top:0px; position:fixed; z-index:1000;");
                    }
                    
                    $("#mask").css("height", this.winDocSize().docH + "px");
                },
                
                /**
                 * 弹出方式调整位置
                 * @param   {settings}
                 */
                getDispose: function( settings ){
                    
                    var self = this,
                        timer = null;
                    
                    self.setDispose( settings );
                    
                    $(window).resize(function() {
                        self.setDispose( settings );
                    });
                    
                    if(settings.dispose == "follow") {
                        $("div").scroll(function() {
                            self.setDispose( settings );
                        });
                    }
                },
                
                /**
                 * 获取传入的data属性
                 * @param   {settings.data}
                 * @return  {string}
                 */
                getDataString: function( data ){
                    
                    function json2str( o ) {
                        var arr = [];
                        var fmt = function(s) {
                            if (typeof s == 'object' && s != null) return json2str(s);
                            return /^(string)$/.test(typeof s) ? "'" + s + "'" : s;
                        }
                        for (var i in o) arr.push(i + ":" + fmt(o[i]));
                        return '{' + arr.join(',') + '}';
                    };
                    
                    return json2str( data );
                },
                
                /**
                 * 移除窗口
                 * @param   {settings}
                 */
                remove: function( settings, containerElement ){
                    var self = this;
                    
                    settings = settings ? settings : $.popup.settings;
                    containerElement = containerElement ? containerElement : settings.containerElement;
					
					if(settings.isMask) {
						$("#mask").delay(100).fadeOut(200, function(){
							$(this).remove();
						});
                    }
					
					$("#mark-"+containerElement.attr("data-mark")).removeAttr("data-mark").removeAttr("id");
					
                    containerElement.fadeOut(200, function(){
                        
                        $(this).remove();
                        settings.containerElement = $([]);
                        settings.currentElement = $([]);
                        
                        if(typeof settings.closeCallback == "function") {
                            settings.closeCallback(settings.containerElement);
                        }
                    });
                    
                    return false;
                    
                },
                
                /**
                 * 定时移除
                 * @param   {settings}
                 */
                delayRemove: function( settings ){
                    
                    var self = this;
                    
                    settings.timer = setTimeout(function(){
                        self.remove(settings);
                        settings.timer = null;
                    }, settings.delay);
                    
                    return settings;
                },
                
                /**
                 * 打开窗口
                 * @param   {settings}
                 */
                openup: function( settings ){
                    
                    var self = this;
                    var mark = new Date().getTime(); /*给窗口设定标记*/
                    
                    if(settings.isMask) {
						if(!!!$("."+settings.containerClass).length) {
							settings.wrapElement.append(self.createMask(settings));
							$("#mask").attr("data-mark", mark); /*被触发的窗口*/
							
						} else {
							var box = settings.currentElement.closest("."+settings.containerClass),
								h = box.innerHeight();
							
							box.append(self.createMask(h, true));
						}
                    };
                    
                    settings.wrapElement.append(self.createContainer(settings));
                    settings.containerElement = $("."+settings.containerClass+":last");
                    
                    settings.containerElement.attr("data-mark", mark); /*被触发的窗口*/
                    
                    if(!!settings.currentElement.length){
                        settings.currentElement.attr("data-mark", mark).attr("id","mark-"+mark); /*触发元素*/
                    }
                    
                    //if(settings.isLoad) {
                    
                        settings.containerElement.append(settings.content);
                        
                        this.getDispose(settings);
                        
                        if(settings.isAutoRemove && settings.timer) {
                            self.delayRemove(settings);
                        }
                        
                        if(typeof settings.openCallback == "function") {
                            settings.openCallback(settings.containerElement);
                        }
                    //}
                    
                },
                
                init: function( options ){
                    
                    var self = this;
                    
                    var settings = $.extend(true, {}, $.popup.settings, options);
                    
                    $.eventBind(settings, self);
                    
                    return {
                        obj : this,
                        settings : settings
                    };
                }
            }
        });
        
        $.fn.removePopup = function(flag){
			
			$.popup.prototype.remove(null, $(this).closest(".popupContainer"));
            
            return false;
        };
        
        $.extend({
            eventBind : function(settings, self){
                
                $(document).on("click", function(event){
					
                    if(settings.winClose && $(event.target).closest("."+settings.containerClass).length <= 0) {
                        self.remove(settings);
                    }
                });
                
                if(!!!settings.currentElement.attr("data-mark")) {
                    self.openup(settings);
                } else {
                    //self.remove(settings, $("."+settings.containerClass+"[data-mark="+settings.currentElement.attr("data-mark")+"]"));
                };
                
                $("."+settings.closeClass).bind("click", function(){
                    $.popup.prototype.remove(settings, settings.containerElement);
                });
            }
        });
        
    }(jQuery));
    
    $(document).on("click", ".closePopup", function(){
		var _self = $(this);
		if(_self.hasClass("maskClose")) {
			var $cor = $(".popupContainer");
			if($cor.length > 1) {
				
				$cor.prev().find(".mask").remove();
				
			} else {
				$("#mask").fadeOut(200, function(){
					$(this).remove();
				});
			}
		}
		
		setTimeout(function(){
			_self.removePopup();
		}, 100);
		
		$.save = [];
    });
});

/*
* 分页
*/
function Page(){};

Page.prototype.getPageHtml = function(p){
	this.current = p.current; //当前分页
	this.pageCount = p.count; //总页数
	this.pageNumber = 3; //显示值
	
	if(this.pageCount <= 1) {
		return false;
	}
	
	var first = '<a href="javascript:">1</a><a href="javascript:>2</a>',
		prev = '<a href="javascript:" class="prevPage" data-val='+this.current+'>上一页</a>',
		next = '<a href="javascript:" class="nextPage" data-val='+this.current+'>下一页</a>',
		last = '<a href="javascript:">'+ (this.pageCount - 1) +'</a><a>'+ this.pageCount +'</a>',
		pageMore = '<a href="javascript:" class="pagemore">...</span>',
		pageStr = '',
		pagetext = "<small>共 <b>"+this.pageCount+"</b> 页</small>";
	
	var pageStartIndex, pageEndIndex, pageContent, pageSize = parseInt(this.pageNumber/2 ,10);
	
	if(this.current >= this.pageCount) { this.current = this.pageCount; }; //判断当前页数是否超出总页数
	if(this.current <= 1) { this.current = 1; }; //判断当前页数是否低于基数
	
	if(this.pageNumber >= this.pageCount) { this.pageNumber = this.pageCount; }; //判断展现分割页幅是否大于总页幅
	
	// 判断开始、结束位置
	if(this.pageCount <= this.pageNumber * 2) {
		
		pageStartIndex = 1;
		pageEndIndex = this.pageCount;
		
	} else {
		if(this.current <= this.pageNumber + 1) {
			
			pageStartIndex = 1;
			pageEndIndex = this.pageNumber + 1;
			
		} else if(this.current + this.pageNumber + 1 > this.pageCount) {
			
			pageStartIndex = this.pageCount - this.pageNumber;
			pageEndIndex = this.pageCount;
			
		} else {
			
			pageStartIndex = this.current - pageSize;
			pageEndIndex = this.current + pageSize;
		};
	}
	
	//循环展示行输出
	for(var i = pageStartIndex; i <= pageEndIndex; i++)
	{
		if(i == this.current)
		{
			pageStr += '<a href="javascript:" class="onthis">'+ i +'</a>';
		} else {
			pageStr += '<a href="javascript:">'+ i +'</a>';
		};
	};
	
	// 获取分页列表HTML
	if(this.pageCount <= this.pageNumber * 2) {
		if(this.current == 1) {
			
			pageContent = pageStr + next;
			
		} else if(this.current == this.pageCount) {
			
			pageContent = prev + pageStr;
			
		} else {
			pageContent = prev + pageStr + next;
		};
		
	} else {
		
		if(this.current == 1) {
			pageContent = pageStr + pageMore + next + pagetext;
			
		} else if(this.current == this.pageCount){
			
			pageContent = prev + first + pageMore + pageStr + pagetext;
		} else {
			
			if( this.current > this.pageNumber + 1 )
			{
				if( pageEndIndex < this.pageCount )
				{
					pageContent = prev + first + pageMore + pageStr + pageMore + last + next + pagetext;
					
				} else {
					pageContent = prev + first + pageMore + pageStr + next + pagetext;
				};
				
			} else {
					
				pageContent = prev + pageStr + pageMore + next + pagetext;
			};
		};
	};
	
	// 返回分页列表HTML
	return pageContent;
};

Page.prototype.pageCanvas = function(ele, p){
	ele.html(this.getPageHtml(p));
}
/*分页END*/

/**************************************************************************/
$(function(){
	/*公用filterSelect， 需要用到滚轮插件*/
	$.extend($.fn, {
		filterSelect : function(data, info){
			var _data = data[info.id] || [],
				_info = info,
				_this = this,
				_flag = !!_this.find(".fsItemsBox").length;
			
			var html = function (data, flag, info){
				
				var h1 = !flag ? '<ul class="fs_'+info.type+' fsItemsBox" id="filterSelect-'+info.id+'">' : '', h2 = '', html = '';
				
				for(var i=0, l=data.length; i<l; i++){
					h2 += '<li class="items">'+data[i]+'</li>';
				}
				
				html = flag ? h2 : h1 + h2 + '</ul>';
				
				return html;
			}
			
			_flag ? _this.find(".fsItemsBox").html(html(_data, _flag, _info)) : _this.append(html(_data, _flag, _info));
			
			var $select = _this.find(".fsItemsBox"),
				ajaxRequest = {};
				ajaxRequest.type = "post";
				ajaxRequest.datatype = "json";
				
			$("#filterSelect-"+_info.id).mCustomScrollbar();
			
			_this.unbind("click");
			_this.bind("click", function(e){
				var $el = $(e.target);
				
				$(".filterSelect").removeClass("pending");
				_this.addClass("pending");
				
				if(!!$el.closest(".fsBtn").length) {
					_this.toggleClass("CK").find(".fsItemsBox").fadeToggle(200);
				}
				
				if(!!$el.closest(".fsInp").length) {
					_this.addClass("CK").find(".fsItemsBox").fadeIn(200);
					$el.bind("keyup", function(){
						var self = $(this),
							$list = _this.find(".fsItemsBox li");
							
						//从后台数据库读取筛选后的结果
						/*ajaxRequest.url = "test.php";
						ajaxRequest.data = {"value": self.val()};
						ajaxRequest.success = function(data){ //data有两个参数，data.code|data.info, code>0的时候才会修改html内容。
							data.code > 0 && ($list.parent().html(html(data.info, true)));
							$("#filterSelect-"+_this.data("info").id).mCustomScrollbar("update");
						}
						$.ajax(ajaxRequest);*/
							
						//本地筛选，数据全部读取后
						$list.filter(function(index) {
							if($(this).text().indexOf(self.val()) < 0) {
								$(this).hide();
							} else {
								$(this).show();
							}
						});
						$("#filterSelect-"+_this.data("info").id).mCustomScrollbar("update");
					});
				}
				
				if(!!$el.closest("li.items").length) {
					var text = $el.text();
					
					_this.removeClass("CK").find(".fsInp").val(text).closest(".filterSelect").find(".fsItemsBox").fadeOut(200);
				}
				$("#filterSelect-"+_this.data("info").id).mCustomScrollbar("update");
			});
		}
	});
	
	/*公用filterSelect， 绑定document*/
	$(document).bind("click", function(e){
		
		var $el = $(e.target);
		
		if(!!!$el.closest(".filterSelect").length) {
			$(".filterSelect").removeClass("CK pending").find(".fsItemsBox").fadeOut(200);
		}
		
		$(".filterSelect").each(function(){
			var _self = $(this);
			
			if(!_self.hasClass("pending")) {
				_self.removeClass("CK pending").find(".fsItemsBox").fadeOut(200);
			}
		});
	});/*END*/
});
/****************************************************************************/

/*输入框聚焦清零*/
$(function(){
	$(".blurClearZero").focus(function(){
		var put_val = $(this).val();
		if(put_val == 0){
			$(this).val("");
		}
	}).blur(function(){
		var put_val = $(this).val();
		if(put_val == ""){
			$(this).val("0");
		}
	});
});






























