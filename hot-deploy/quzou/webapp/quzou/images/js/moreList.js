$(function(){
		//让滚动插件加载进来,设置ID
		$(".attrList").each(function(i) {
            $(this).attr("id", "attrList"+i);
        });
		
		var data = {
			"1": {"default": ["卡瑞兹", "魔镜"], "more": ["充值", "转账", "退货/退款", "现金付款", "消耗", "购买"]},
			"2": {"default": ["品牌1", "品牌2"], "more": ["现金账户", "银行账户", "抵用券", "卡扣", "卡扣", "卡扣"]},
			"3": {"default": ["文三路店", "闻涛路店"], "more": ["闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店"]},
			"4": {"default": ["文三路店", "闻涛路店"], "more": ["闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店"]},
			"5": {"default": ["文三路店", "闻涛路店"], "more": ["闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店", "闻涛路店"]}
		};
		
		function getDataMore(d, id, type){
			var d = d[id][type];
			return d;
		}
		
		function createAttrListHTML(p){
			var html = "";
			
			for(var i=0, l=p.length; i<l; i++) {
				html += '<li>'+
                        	'<a href="#">'+p[i]+'</a>'+
                            '<b class="iconfont del">&#xe607;</b>'+
                        '</li>';
			}
			
			return html;
		}
		
		$(".item input.inp-text").bind("keyup", function(){
			var self = $(this),
				$list = self.closest(".item").find(".attrList li");
			
			$list.filter(function(index) {
				if($(this).text().indexOf(self.val()) < 0) {
					$(this).hide();
				} else {
					$(this).show();
				}
            });
		});
		
		function setAttrList(e, type) {
			var self = e, d,
				$box = self.closest(".item"),
				$listBox = $box.find(".attrList");
				
			$("#"+$listBox.attr("id")).mCustomScrollbar("update");
				
			if(type == "cancel") {
				d = getDataMore(data, $listBox.data("info").id, "default");
				$listBox.removeClass("ck order").html(createAttrListHTML(d));
				$box.find(".control").hide();
				$box.find(".options").show().find(".more").html('<a href="javascript:">更多<b class="iconfont">&#xe602;</b></a>');;
				$box.find(".filterSearch").hide();
				
				return false;
			}
				
			if(type == "select") {
				d = getDataMore(data, $listBox.data("info").id, "more");
				$box.find(".control").show();
				$box.find(".options").hide();
				$box.find(".filterSearch").show();
				$listBox.addClass("ck order").html(createAttrListHTML(d));
				$("#"+$listBox.attr("id")).mCustomScrollbar({
					scrollButtons:{
						scrollType:"pixels",
						scrollSpeed:1000,
						scrollAmount:1000
					}
				});
				
				return false;
			}
			
			if($listBox.hasClass("ck") && type == "more") {
				d = getDataMore(data, $listBox.data("info").id, "default");
				$listBox.removeClass("ck more").html(createAttrListHTML(d));
				$box.find(".filterSearch").hide();
				
				if(type == "more") self.html('<a href="javascript:">更多<b class="iconfont">&#xe602;</b></a>');
				
			} else {
				d = getDataMore(data, $listBox.data("info").id, "more");
				$listBox.addClass("ck more").html(createAttrListHTML(d));
				$("#"+$listBox.attr("id")).mCustomScrollbar({
					scrollButtons:{
						scrollType:"pixels",
						scrollSpeed:1000,
						scrollAmount:1000
					}
				});
				
				$box.find(".filterSearch").show();
				
				if(type == "more") self.html('<a href="javascript:">收起<b class="iconfont">&#xe600;</b></a>');
			}
		}
		
		$(".filter_attr").on("click", ".options .more", function(){
			setAttrList($(this), "more");
		});
		
		$(".filter_attr").on("click", ".options .select", function(){
			setAttrList($(this), "select");
		});
		
		$(".filter_attr").on("click", ".control .promise", function(){
			
			if($(this).hasClass("disabled")) return false;
			
		});
		
		$(".filter_attr").on("click", ".attrList li", function(){
			var $box = $(this).closest(".item"),
				$listBox = $box.find(".attrList");
			
			if($listBox.hasClass("order")) {
				$(this).toggleClass("onthis");
			}
			
			if($listBox.find("li.onthis").length > 0) {
				$box.find(".promise").removeClass("disabled");
			} else {
				$box.find(".promise").addClass("disabled");
			}
		});
		
		$(".filter_attr").on("click", ".control .cancel", function(){
			setAttrList($(this), "cancel");
		});
	});