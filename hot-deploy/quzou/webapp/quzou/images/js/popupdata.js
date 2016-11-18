$(function(){
	
	var pageto = new Page();
	
	/*弹出层数据*/
	
	$.popupContent = {};
	
	$.extend($.popupContent, {
		"title": function(title){
			return !!title ? '<h3 class="title">'+title+'</h3>' : "";
		},
		
		"topInfo": function(data){
			var bh = '', ih = '', ihl = '', sh = '', shl = '', ch = '<div class="control">', chl='';
			
			if(data.isSearch) {
				shl = '<div class="stock_search popup_search">'+
						'<input type="text" class="inp-text ss_inp" data-value="商品名称" />'+
						'<input type="submit" class="inp-submit" value="查询" />'+
					 '</div>';
			}
			
			if(!!data.info) {
				for(var a in data.info) {
					ihl +=  '<li>'+
								'<cite>'+a+'</cite>'+
								'<span>'+data.info[a]+'</span>'+
							'</li>';
				}
				
				ihl = '<ul>' + ihl + '</ul>';
			}
			
			if(!!data.control) {
				for(var a in data.control) {
					chl +=  '<a href="javascript:" class="btn mm btn-'+a+' '+a+'Btn">'+data.control[a]+'</a>';
				}
				
				chl = '<div class="control">' + chl + '</div>';
			}
			
			ih = ihl;
			ch = chl;
			sh = shl;
			
			bh = ih == "" && ch == "" && sh == "" ? "" : '<div class="popup_top_info">'+sh+ih+ch+'</div>';
			
			return bh;
		},
		
		"content": function(data){
			
			var bh = '', th = '<tr>', thl = '', td = '', tdl = '', thc = "", thd = "", tdc = "", tdd = "", w = 100, lw = 0;
			
			if(!!data.isChecked) {
				thc = '<th width="5%" class="td_checked"><input type="checkbox" class="checkAll" data-name="'+data.vid+'" /></th>';
				tdc = '<td class="td_checked"><input type="checkbox" name="1" class="checkItem" data-name="'+data.vid+'" /></td>';
				w -= 5;
			};
			
			if(!!data.isDelete) {
				thd = '<th width="5%">操作</th>';
				tdd = '<td><a href="javascript:" class="items-del del"><b class="iconfont">&#xe603;</b></a></td>';
				w -= 5;
			};
			
			if(!!data.isAdd) {
				thd = '<th width="5%">操作</th>';
				tdd = '<td><a href="javascript:" class="items-add add"><b class="iconfont">&#xe603;</b></a></td>';
				w -= 5;
			};
			
			if(!!data.name) {
				var l = data.name.length;
				
				lw = w/l;
			
				for(var i=0; i<l; i++) {
					thl += '<th width="'+lw+'%">'+data.name[i]+'</th>';
				}
			}
			
			if(!!data.info){
				for(var i=0, l=data.info.length; i<l; i++) {
					
					tdl += '<tr class="items">' + tdc;
					
					for(var a in data.info[i]) {
						
						if(a == "bad_number") {
							
							tdl += '<td data-type='+a+'>'+
										'<div class="set_number">'+
											'<span class="controlCount" data-info=\'{"maxNum":'+data.info[i][a].maxNum+', "minNum":'+data.info[i][a].minNum+'}\'>'+
												'<a href="javascript:" class="subtract">-</a>'+
												'<input type="text" class="inp-text enterNumber controlCountInp" value="'+data.info[i][a].current+'" data-value="" />'+
												'<a href="javascript:" class="add">+</a>'+
											'</span>'+
										'</div>'+
									'</td>';
									
						} else if(a == "price") {
							
							tdl += '<td data-type="'+a+'"><em class="col_f83976">¥'+data.info[i][a]+'</em></td>';
							
						} else {
							
							tdl += '<td data-type="'+a+'">'+data.info[i][a]+'</td>';
						}
					}
					
					tdl += tdd + '</tr>';
				}
			}
			
			th += thc + thl + thd + "</tr>";
			td += tdl;
			
			if($.trim(thl) != "") {
				bh = '<div class="popup_table_list">'+
						'<table width="100%" border="0" cellspacing="0" cellpadding="0">'+th+td+'</table>'+
					 '</div>';
			} else {
				bh = tdl;
			}
					
			return bh;
		},
		
		"pageto": function(data){
			return '<div class="pageto" data-info=\'{"count":'+data.count+', "current":'+data.current+'}\'></div>';
		},
		
		"draw": function(p, flag){
			
			var html = '',
				cls = flag ? "maskClose" : "";
			
			for(var a in p){
				html += this[a](p[a]);
			}
			
			return '<div class="popupbox"><div class="table popup_table">' + html + '</div> <a href="javascript:" class="popup-close-btn closePopup '+cls+'"><b class="iconfont">&#xe607;</b></a></div>';
		}
	});
	
	var targetInfo = null,
		ajaxRequest = {};
		ajaxRequest.type = "post";
		ajaxRequest.datatype = "json";
		
	$.save = []; /*临时数据*/
	
	/*添加到临时数组*/
	function addItemsData(items){
		$.save = [];
		
		items.each(function(){
			var _self = $(this);
			
			if(_self.find(".checkItem").prop("checked")){
				var	code = _self.find("td[data-type=code]").text(),
					data = getSaveInfo(_self.find("td"));
				$.save.push(data);
			}
		});
	}
	
	/*获取到当前列的数据*/
	function getSaveInfo(list){
		
		var data = {}
		
		list.each(function(){
			var _self = $(this),
				type = $(this).data("type");
			
			if($.trim(type) != "") {
				
				switch (type) {
					case "price":
						data[type] = _self.text().match(/\d+/g);
					break;
					
					case "bad_number":
						var $bad_number = _self.find(".controlCount");
						data[type] = {};
						data[type].maxNum = $bad_number.data("info").maxNum;
						data[type].minNum = $bad_number.data("info").minNum;
						data[type].current = $bad_number.find("input.inp-text").val();
					break;
					
					default:
						data[type] = _self.text();
					break;
				}
			}
		});
		
		return data;
	}
	
	/*获取数据信息*/
	function getDataInfo(box){
		var $cor = box.find(".popup_table_list");
					
		$cor.find("input[type=checkbox]").bind("change", function(){
			var $items = $(this).closest(".popup_table_list").find("tr.items");
			
			setTimeout(function(){
				addItemsData($items);
			}, 50);
		});
	}
	
	$(document).on("click", ".navTarget", function(){
		$(this).popup({
			"content": $.popupContent.draw({
											"title": "新增进货单1",
											"topInfo": {
												"info": {"报损单号1：": "111111", "报损单号2：": "222222", "报损单号3：": "333333", "报损单号4：": "444444"},
												"control": {"submit": "提交报损单", "product": "添加产品名"}
											},
											"content":{
												"isChecked": true,
												"vid": 15,
												"isDelete": true,
												"name": ["品牌", "系列", "商品名称", "商品代码", "商品类别", "规格", "面价", "报损数量", "当前库存"],
												"info": [
													{"brand": "品牌1", "series": "系列", "name": "化妆品", "code": "1111111", "category": "化妆品", "rule": "TX1", "price": "111", "bad_number": {"maxNum": 15, "minNum": 0, "current": 8}, "stock": 99},
													{"brand": "品牌2", "series": "系列", "name": "化妆品", "code": "2222222", "category": "化妆品", "rule": "TX2", "price": "222", "bad_number": {"maxNum": 8, "minNum": 0, "current": 2}, "stock": 99},
													{"brand": "品牌3", "series": "系列", "name": "化妆品", "code": "3333333", "category": "化妆品", "rule": "TX3", "price": "333", "bad_number": {"maxNum": 7, "minNum": 0, "current": 0}, "stock": 99},
													{"brand": "品牌4", "series": "系列", "name": "化妆品", "code": "4444444", "category": "化妆品", "rule": "TX5", "price": "444", "bad_number": {"maxNum": 20, "minNum": 0, "current": 1}, "stock": 99}
												]
											}
										}, true),
			
			"width": 1000,
			"isMask" : true,
			"openCallback": function(box){
				getDataInfo(box);
			}
		});
		
		return false;
	});
	
	$(document).on("click", ".productBtn", function(){
		$(this).closest(".popupContainer").find("input[type=checkbox]").prop("checked", false);
		
		targetInfo = $(this).popup({
			"content": $.popupContent.draw({
											"title": "添加商品",
											"topInfo": {
												"isSearch": true,
												"control": {"confirm": "确认添加"}
											},
											"content":{
												"isChecked": true,
												"vid": 10,
												"name": ["品牌", "系列", "商品名称", "商品代码", "商品类别", "规格", "面价", "报损数量", "当前库存"],
												"info": [
													{"brand": "品牌1", "series": "系列", "name": "化妆品", "code": "1234567", "category": "化妆品", "rule": "TX1", "price": "111", "bad_number": {"maxNum": 15, "minNum": 0, "current": 8}, "stock": 99},
													{"brand": "品牌2", "series": "系列", "name": "化妆品", "code": "1234567", "category": "化妆品", "rule": "TX2", "price": "222", "bad_number": {"maxNum": 8, "minNum": 0, "current": 2}, "stock": 99},
													{"brand": "品牌3", "series": "系列", "name": "化妆品", "code": "1234567", "category": "化妆品", "rule": "TX3", "price": "333", "bad_number": {"maxNum": 7, "minNum": 0, "current": 0}, "stock": 99},
													{"brand": "品牌4", "series": "系列", "name": "化妆品", "code": "1234567", "category": "化妆品", "rule": "TX5", "price": "444", "bad_number": {"maxNum": 20, "minNum": 0, "current": 1}, "stock": 99}
												]
											},
											"pageto":{
												"count": 10,
												"current": 2
											}
										}, true),
			
			"width": 1000,
			"dispose" : "center",
			"isMask" : true,
			"openCallback": function(box){
				var page = box.find(".pageto"),
					pageInfo = page.data("info"),
					$searchBox = box.find(".popup_search"),
					$searchInp = $searchBox.find(".inp-text"),
					$searchBtn = $searchBox.find(".inp-submit"),
					$tblist = box.find(".popup_table_list"),
					$pageto = box.find(".pageto");
					
				pageto.pageCanvas(page, {"count": pageInfo.count, "current": pageInfo.current});
				
				var dataA = {
						"isChecked": true,
						"vid": 10,
						"info": [
							{"brand": "金兰煤炉", "series": "金品", "name": "高三脚", "code": "7758", "category": "煤炉类", "rule": "A001", "price": "20", "bad_number": {"maxNum": 15, "minNum": 0, "current": 8}, "stock": 999},
							{"brand": "金兰煤炉", "series": "金品", "name": "三芯", "code": "258", "category": "煤炉类", "rule": "A002", "price": "43", "bad_number": {"maxNum": 8, "minNum": 0, "current": 2}, "stock": 1999},
							{"brand": "金兰煤炉", "series": "金品", "name": "七芯", "code": "258", "category": "煤炉类", "rule": "A003", "price": "120", "bad_number": {"maxNum": 7, "minNum": 0, "current": 0}, "stock": 2999},
							{"brand": "金兰煤炉", "series": "金品", "name": "4芯", "code": "22258", "category": "煤炉类", "rule": "A004", "price": "60", "bad_number": {"maxNum": 20, "minNum": 0, "current": 1}, "stock": 3999}
						]
					};
				
				$searchBtn.bind("click", function(){
					ajaxRequestList("test.php", {"value": $searchInp.val()}, $tblist, $pageto, dataA);
					return false;
				});
				
				getDataInfo(box);
			}
		});
		
		return false;
	});
	
	$.fn.loading = function(type){
		var _self = this;
		
		if(type == "add") {
			_self.append('<div class="popup-loading"></div>');
			
			_self.find(".popup-loading").height(_self.innerHeight());
		} else {
			_self.find(".popup-loading").remove();
		}
	}
	
	function ajaxRequestList(url, sData, tblist, pageto, dataA){ /*最后一个dataA套上程序后可以不要*/
		tblist.loading("add");
		pageto.addClass("pending");
		
		ajaxRequest.url = url;
		ajaxRequest.data = sData;
		ajaxRequest.success = function(data){
			pageto.removeClass("pending");
			tblist.loading("remove");
			tblist.find("tr.items").remove();
			tblist.find("tr:first").after($.popupContent.content(dataA));
		}
		
		$.ajax(ajaxRequest);
	}
	
	$(document).on("click", ".popupbox .pageto a", function(){
		var _self = $(this),
			$box = _self.closest(".pageto"),
			pageInfo = $box.data("info"),
			count = pageInfo.count, page = 0, type,
			$tblist = $box.closest(".popupContainer").find(".popup_table_list");
		
		if(_self.hasClass("pagemore") || $box.hasClass("pending") || _self.hasClass("onthis")){
			 return false
		} else {
			type = _self.hasClass("prevPage") ? "prev" : _self.hasClass("nextPage") ? "next" : "cur";
		};
		
		var val = !!_self.data("val") ? +(_self.data("val")) : +(_self.text());
		
		function getVal(){
			return val >= count ? count : val <= 1 ? 1 : val;
		}
		
		switch (type){
			case "prev":
				val--;
				page = getVal();
			break;
			
			case "next":
				val++;
				page = getVal();
			break;
			
			case "cur":
				page = val;
		}
		
		_self.data("val", page);
		pageto.pageCanvas($box, {"count": count, "current": page});
		
		var dataA = {
						"isChecked": true,
						"vid": 10,
						"info": [
							{"brand": "品牌11", "series": "系2列", "name": "1化妆品", "code": "asdf2324", "category": "12w", "rule": "1TX1", "price": "334", "bad_number": {"maxNum": 15, "minNum": 0, "current": 8}, "stock": 199},
							{"brand": "品牌12", "series": "系3列", "name": "2化妆品", "code": "qwezsds", "category": "sdsd", "rule": "2TX2", "price": "4211", "bad_number": {"maxNum": 8, "minNum": 0, "current": 2}, "stock": 199},
							{"brand": "品牌13", "series": "系4列", "name": "3化妆品", "code": "gfhgf322", "category": "qwe", "rule": "3TX3", "price": "782", "bad_number": {"maxNum": 7, "minNum": 0, "current": 0}, "stock": 199},
							{"brand": "品牌14", "series": "系5列", "name": "4化妆品", "code": "25332weded", "category": "1233", "rule": "4TX5", "price": "158", "bad_number": {"maxNum": 20, "minNum": 0, "current": 1}, "stock": 199}
						]
					};
					
		ajaxRequestList("test.php", {}, $tblist, $box, dataA);
		
		return false;
	});
	/*$.save 数据从里面可以直接读取*/
});