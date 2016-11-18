$(function(){
	setTimeout(function(){
		$('#brand-waterfall').waterfall();

		var $lcModule = $(".lcModule"),
			$gwcModule = $(".gwcModule");

		if(!!!$lcModule.find("dd").length) {
			$lcModule.find(".t_b_control").hide();
			$lcModule.find(".temporary_remind").show();
		} else {
			$lcModule.find(".t_b_control").show();
			$lcModule.find(".temporary_remind").hide();
		}

		if(!!!$gwcModule.find("dd").length) {
			$gwcModule.find(".t_b_control").hide();
			$gwcModule.find(".temporary_remind").show();
		} else {
			$gwcModule.find(".t_b_control").show();
			$gwcModule.find(".temporary_remind").hide();
		}

	}, 500); //套上程序后删除 setTimeout

	(function ($) {
		$.fn.waterfall = function(options) {
			var df = {
				item: '.item',
				margin: 12,
				addfooter: false
			};
			options = $.extend(df, options);
			return this.each(function() {
				var $box = $(this), pos = [],
				_box_width = $box.width(),
				$items = $box.find(options.item),
				_owidth = $items.eq(0).outerWidth() + options.margin,
				_oheight = $items.eq(0).outerHeight() + options.margin,
				_num = Math.floor(_box_width/_owidth);
				(function() {
					var i = 0;
					for (; i < _num; i++) {
						pos.push([i*_owidth,0]);
					}
				})();
				$items.each(function() {
					var _this = $(this),
					_temp = 0,
					_height = _this.outerHeight() + options.margin;


					for (var j = 0; j < _num; j++) {
						if(pos[j][1] < pos[_temp][1]){
							//暂存top值最小那列的index
							_temp = j;
						}
					}
					this.style.cssText = 'left:'+pos[_temp][0]+'px; top:'+pos[_temp][1]+'px;';
					//插入后，更新下该列的top值
					pos[_temp][1] = pos[_temp][1] + _height;
				});

				// 计算top值最大的赋给外围div
				(function() {
					var i = 0, tops = [];
					for (; i < _num; i++) {
						tops.push(pos[i][1]);
					}
					tops.sort(function(a,b) {
						return a-b;
					});
					$box.height(tops[_num-1]);
					//增加尾部填充div
					if(options.addfooter){
						addfooter(tops[_num-1]);
					}
				})();
				function addfooter(max) {
					var addfooter = document.createElement('div');
					addfooter.className = 'item additem';
					for (var i = 0; i < _num; i++) {
						if(max != pos[i][1]){
							var clone = addfooter.cloneNode(),
							_height = max - pos[i][1] - options.margin;
							clone.style.cssText = 'left:'+pos[i][0]+'px; top:'+pos[i][1]+'px; height:'+_height+'px;';
							$box[0].appendChild(clone);
						}
					}
				}
			});
		}

		var slideFlag = true;
		$('#brand-waterfall .item').hover(function(e){
			$(this).addClass("hover");
			$(this).css("z-index","48");
			$(this).find(".pro_info").stop(false).slideDown(200);

		},function(){
			$(this).removeClass('hover');
			if(slideFlag) {
				$(this).find(".pro_info").stop(false).slideUp(200, function(){
					$(this).removeAttr("style");
				});
				$(this).css("z-index","1");
			}
		});

		$('.item').on('click', ".pro_info_tip",  function(){
			var $proinfo=$(this).parent('.pro_info');
			var $pro_info_more = $proinfo.find('.pro_info_more');
			$pro_info_more.slideToggle();
		});

		function getItemPoi(elem, flag){
			var r = {};

			r.left = elem.offset().left;
			r.top = flag ? elem.offset().top + elem.innerHeight()/2 : elem.offset().top;

			return r;
		}

		$.screenTicktock = function(duration, move, callback){

			var tween = function (t, b, c, d) {
							return c*((t=t/d-1)*t*t + 1) + b;
						};

			var	s = (new Date()).getTime(),
				c = move,
				d = duration,
				t = b = i = 0;

			function run(){

				if(typeof callback.startCallback == "function") callback.startCallback();

				t = (new Date()).getTime() - s;

				if(t >= d){
					t = d;
					i = Math.ceil(tween(t, b, c, d));

					if(typeof callback.init == "function"){
						callback.init(i);
					} else {
						callback.stopCallback(i);
					};

					return false;

				} else {
					i = Math.ceil(tween(t, b, c, d));

					if(typeof callback.init == "function"){
						callback.init(i);
					} else {
						callback.moveCallback(i);
					};
					setTimeout(run, 25);
				};
			};

			run();
		};

		function paracurveMove(i, targetPoi, moveElem){

			var curvature = 0.0006,
				c = 0,
				x = i,
				b = (targetPoi.y - curvature*targetPoi.x*targetPoi.x) / targetPoi.x,
				y = curvature*x*x + b*x;

			moveElem.attr("style", "left:"+x+"px; top:"+y+"px; position:absolute; width:60px; border-radius:50%;");
		}


		function movingTarget(_self, $box, $source){
			var data = $source.data("info"),
				$img = $source.find(".pro_img img"),
				scrTop = $(window).scrollTop(),
				targetOffset = $box.offset(),
				startOffset = _self.offset(),
				top = targetOffset.top - startOffset.top + $box.height()/2,
				targetPoi = {"x": targetOffset.left - startOffset.left, "y": top},
				img = $source.find(".pro_img img").clone().addClass("cloneImg");

			_self.append(img);
			var moveElem = _self.find(".cloneImg");


			$.screenTicktock(1000, targetPoi.x, {
				"moveCallback": function(i){
					paracurveMove(i, targetPoi, moveElem);
					$source.css("zIndex", 999);
				},
				"stopCallback": function(i){
					$source.css("zIndex", 1);
					moveElem.fadeOut(100, function(){
						$(this).remove();
						var targetElem = _self.hasClass("pro_btn_lc") ? $(".lcModule dl") : $(".gwcModule dl");

						appendCart(targetElem, data, $source);
						showPdtNumber($box, "add");
						setTargetRemind($box, true);
					});
				}
			});
		}

		$(document).on("mousedown", function(){
			slideFlag = false;
		});

		$(document).on("mouseup", function(){
			slideFlag = true;
		});

		function setTargetRemind(box, flag){
			if(flag) {
				box.find(".temporary_remind").hide();
				box.find(".t_b_control").show();
			} else {
				box.find(".temporary_remind").show();
				box.find(".t_b_control").hide();
			}
		}

		$('.item').on("mousedown", ".pro_btn_lc", function(e){
			var _self = $(this),
				$box = $(".lc_target"),
				$source = _self.closest(".item");

			movingTarget(_self, $box, $source);
		});

		$('.item').on("mousedown", ".pro_btn_gwc", function(){
			var _self = $(this),
				$box = $(".gwc_target"),
				$source = $(this).closest(".item");

			movingTarget(_self, $box, $source);
		});

		/*
		* 添加右侧购物车
		*/
		var regNum = /\d/g;

		/*添加显示数量*/
		function showPdtNumber(box){
			var l = box.find(".temporary_bar dd").length;
			box.find(".num").text(l);

			l >= 0 ? box.find(".t_b_control").show() : box.find(".t_b_control").hide();
		}

		/*创建html*/
		function createCartHTML(p){
			var html = "";
			html += '<dd class="items cartPriceSet" data-id="'+p.id+'" data-price="'+p.defPrice+'">'+
						'<span class="name">'+p.name+'</span>'+
						'<span class="price edit" data-type="price">\uffe5'+p.price+'</span>'+
						'<span class="count edit" data-type="count">'+p.count+'</span>'+
						'<span class="discount edit" data-type="discount">'+p.discount+'</span>'+
						'<span class="dis_price edit" data-type="disPrice">\uffe5'+p.dis_price+'</span>'+
						'<span class="t_b_del out out_right"><b class="iconfont">&#xe603;</b></span>'+
					'</dd>';
			return html;
		}

		/*创建自定义疗程HTML*/
		function createCartListHTML(p, name, id){
			var tH = "", lH = "", html = "", countData = {};

			countData.name = name;
			countData.id = id;

			for(var i=0, l=p.length; i<l; i++){
				lH += '<li>'+
						'<span class="name">'+p[i].name+'</span>'+
						'<span class="price">\uffe5'+p[i].price+'</span>'+
						'<span class="count">'+p[i].count+'</span>'+
						'<span class="discount">'+p[i].discount+'</span>'+
						'<span class="dis_price">\uffe5'+p[i].dis_price+'</span>'+
					'</li>';

				for(var a in p[i]) {
					if(a != "id" && a != "name") {
						countData[a] = !!countData[a] ? +countData[a] + (+p[i][a]) : p[i][a];
					}
				}
			}

			countData.discount = countData.discount/p.length;

			tH += '<dd class="items cartPriceSet" data-id="'+countData.id+'" data-price="'+p.defPrice+'">'+
						'<span class="t_b_cut out out_left"><b class="iconfont">&#xe602;</b></span>'+
						'<span class="name">'+countData.name+'</span>'+
						'<span class="price edit" data-type="price">\uffe5'+countData.price+'</span>'+
						'<span class="count edit" data-type="count">'+countData.count+'</span>'+
						'<span class="discount edit" data-type="discount">'+countData.discount+'</span>'+
						'<span class="dis_price edit" data-type="disPrice">\uffe5'+countData.dis_price+'</span>'+
						'<span class="t_b_del out out_right"><b class="iconfont">&#xe603;</b></span>';

			html += tH + '<ul>' + lH + '</ul></dl>';

			return html;
		}

		/*获取目标列表dom*/
		function getTargetDom(list, id){
			var $dom, $list = list, flag = true;

			$list.each(function(){
				if($(this).data("id") == id) {
					$dom = $(this);
					flag = false;

					return false;
				}
			});

			if(flag) return null;

			return $dom;
		}

		/*添加到页面*/
		function appendCart(box, p, source){
			var $box = box,
				$list = $box.find(".items");
			return;
			p.defPrice = source.data("info").price;

			if(!!!$list.length) { $box.append(createCartHTML(p)); return false;}

			var $e = getTargetDom($list, p.id);

			if($e) {
				var n = +$e.find(".count").text() + 1;
				$e.find(".count").text(n++);

				resetCartInfo($e, "count");
			} else {
				$box.append(createCartHTML(p));

			}
		}

		/*添加删除*/
		$(document).on("click", ".t_b_del", function(){
			var $box = $(this).closest("dd"),
				$dBox = $box.closest(".target");

			$box.fadeOut(400, function(){
				$(this).remove();
				showPdtNumber($dBox, "del");

				if(!!!$dBox.find("dd").length) setTargetRemind($dBox, false);
				$(".scrollbar1").mCustomScrollbar("update");
				$(".scrollbar2").mCustomScrollbar("update");
			});
		});

		/*从自定义疗程添加到购物车*/
		$(document).on("click", ".btn-addcart", function(){
			var $box = $(this).closest(".temporary_bar"),
				$remind = $box.find(".temporary_remind"),
				$inp = $box.find(".inp-text");

			if($.trim($inp.val()) == "" || $inp.val() == $inp.data("value")) {
				$inp.focus();
				return false;
			}

			if(!!!$box.find("dd").length){
				return false;
			}

			var $list =$box.find("dd"), data = [], b = {}, name = $inp.val(), id="listCart"+(Date.parse(new Date()));

			$list.each(function() {
				var self = $(this);

				b = {};
				b.name = self.find(".name").text();
				b.price = self.find(".price").text().match(regNum).join("");
				b.count = self.find(".count").text();
				b.discount = self.find(".discount").text();
				b.dis_price = self.find(".dis_price").text().match(regNum).join("");

				data.push(b);
			});

			$remind.fadeOut(400, function(){
				$(".gwcModule dl").append(createCartListHTML(data, name, id));
				$box.find("dd").remove();
				$(this).text($remind.data("text")).fadeIn();
				$box.find(".inp-text").val("");
				showPdtNumber($box.closest(".target"), "del");
				showPdtNumber($(".gwc_target"), "add");
				setTargetRemind($(".gwc_target"), true);
				$box.find(".t_b_control").hide();
				$(".scrollbar1").mCustomScrollbar("update");
				$(".scrollbar2").mCustomScrollbar("update");
			});
		});

		/*重置当前信息*/
		function resetCartInfo(e, type){

			var p = getCartElement(e);

			var r = getCartInfo({"type": type, "disPrice": p.disPrice, "discount": p.discount, "count": p.count, "price": p.price, "originalPrice": p.$cor.data("price")});

			p.$price.text("\uffe5"+r.price);
			p.$count.text(r.count);
			p.$discount.text(r.discount);
			p.$disPrice.text("\uffe5"+r.disPrice);

			e.find("input.edit").hide();
		}

		$(document).on("click", ".t_b_cut", function(){
			var _self = $(this),
				$box = _self.closest(".items");

			$box.find("ul").stop(true, false).slideToggle(400, function(){
				$(".scrollbar1").mCustomScrollbar("update");
				$(".scrollbar2").mCustomScrollbar("update");

				if(_self.hasClass("CK")) {
					_self.removeClass("CK").html('<b class="iconfont">&#xe602;</b>');
				} else {
					_self.addClass("CK").html('<b class="iconfont">&#xe600;</b>');
				}
			});
		});

		$.isFixed2 = function(str){

			var reg = /(^0{1})$|(^[1-9]+[0-9]+)$|(^[1-9]+)$|(^0{1}\.\d{1,2})$|(^[1-9]+\.\d{1,2})$/g;

			return reg.test(str || "");
		}

		$.getFixed2 = function(str) {

			var str = str.toString(),
				reg = /(\d{1,6}\.0[1-9]{1})|(\d{1,6}\.[1-9]{1,2})|(0\.[1-9]{1,2})|(0\.0[1-9]{1})|([1-9]{1,6}\.[1-9]{1,2})|([1-9]{1,6}\.0[1-9]{1})|(\d{1,6})/g;

			return str.match(reg)[0];
		}


		$(document).on("click", ".cartPriceSet span.edit", function(){
			var _self = $(this), $inpEdit,
				defVal = $.getFixed2(_self.text());

			if(!!!$(this).find("input.edit").length) {
				_self.append('<input type="text" class="inp-text edit" />');
			}

			window.cache = defVal;

			$inpEdit = _self.find("input.edit").show();
			$inpEdit.focus().val(defVal);
		});

		function getCartInfo(data){
			var r = {"price": "", "count": "", "discount": "", "disPrice": ""};

			switch(data.type) {
				case "count":
						r.count = data.count;
						r.price = r.count * data.originalPrice;
						r.discount = data.discount;
						r.disPrice = $.getFixed2(r.price * r.discount);
					break;

				case "discount":
						r.discount = data.discount;
						r.count = data.count;
						r.price = data.price;
						r.disPrice = $.getFixed2((r.price * r.discount * r.count));
					break;

				case "disPrice":
						r.disPrice = data.disPrice;
						r.price = data.price;
						r.count = data.count;
						r.discount = $.getFixed2(r.disPrice/r.price);
					break;

				case "price":
						r.price = data.price;
						r.count = data.count;
						r.discount = data.discount;
						r.disPrice = $.getFixed2(r.price*r.discount);
					break;

				default:
					return false;
			}

			return r;
		}

		function getCartElement(elem){
			var r = {} , e = elem;
			r.$cor = e.closest(".cartPriceSet"),
			r.$price = r.$cor.find(".edit[data-type=price]"),
			r.$count = r.$cor.find(".edit[data-type=count]"),
			r.$discount = r.$cor.find(".edit[data-type=discount]"),
			r.$disPrice = r.$cor.find(".edit[data-type=disPrice]"),
			r.price = r.$price.find("input.edit").val() || $.getFixed2(r.$price.text()),
			r.count = r.$count.find("input.edit").val() || $.getFixed2(r.$count.text()),
			r.discount = r.$discount.find("input.edit").val() || $.getFixed2(r.$discount.text()),
			r.disPrice = r.$disPrice.find("input.edit").val() || $.getFixed2(r.$disPrice.text());

			return r;
		}

		$(document).on("focus", ".cartPriceSet input.edit", function(){
			var p = getCartElement($(this)),
				price = p.price / p.count;

			p.$cor.data("price", price);
		});

		$(document).on("blur", ".cartPriceSet input.edit", function(){

			var _self = $(this);

			if(!$.isFixed2(_self.val())){ _self.hide(); return false;}

			var p = getCartElement(_self),
				$box = _self.closest("span.edit"),
				type = $box.data("type");

			if(type == "price") {
				var price = p.price / p.count;
				p.$cor.data("price", price);
			}

			resetCartInfo($box, type);
		});
	})(jQuery);
});














