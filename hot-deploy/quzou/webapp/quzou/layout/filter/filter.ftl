<div class="wrap">
	<div class="filter">
    	<!--面包屑-->
    	<div class="crumb">
        	<ul>
            	<li>
                	<a href="#">首页</a>
                    <b class="iconfont ico">&#xe604;</b>
                </li>
                
                <li>
                	<a href="basicsInfo.html">产品</a>
                    <b class="iconfont ico">&#xe604;</b>
                </li>
                
                <li class="seh">
                	<input type="text" class="inp-text" data-value="" />
                    <span class="seh_btn"><b class="iconfont ico">&#xe601;</b></span>
                </li>
            </ul>
            
            <div class="count">共 999999 件相关商品</div>
        </div>
        <div class="crumb">
        	<ul>
            	<li>
                	<span>搜索条件：</span>
                </li>
                
                <li class="set">
                	<a href="javascript:">兰蔻 <b class="iconfont del">&#xe607;</b></a>
                </li>
                <li class="set">
                	<a href="javascript:">兰蔻 <b class="iconfont del">&#xe607;</b></a>
                </li>
                <li class="set">
                	<a href="javascript:">兰蔻 <b class="iconfont del">&#xe607;</b></a>
                </li>
        </div>
        <!--面包屑end-->
        
        <!--筛选信息-->
    	<div class="filter_attr">
            
        	<dl class="clear-fix item">
            	<dt>
                	<span>品牌</span>
                </dt>
                
                <dd>
                	<div class="filter_search filterSearch"><input type="text" class="inp-text" data-value="搜索品牌名称" /><span class="searchBtn">查询</span></div>
                    
                	<ul class="clear-fix attrList" data-info='{"id": 1}'>
                    	<li>
                        	<a href="#">扒拉扒拉</a>
                            <b class="iconfont del">&#xe607;</b>
                        </li>
                        
                        <li>
                        	<a href="#">Macfion/迈克·菲恩</a>
                            <b class="iconfont del">&#xe607;</b>
                        </li>
                    </ul>
                    
                    <div class="control clear-fix">
                    	<a href="javascript:" class="promise disabled">确定</a>
                        <a href="javascript:" class="cancel">取消</a>
                    </div>
                    
                	<div class="options">
                    	<span class="select"><a href="javascript:"><b class="iconfont">&#xe609;</b>多选</a></span>
                        <span class="more"><a href="javascript:">更多<b class="iconfont">&#xe602;</b></a></span>
                    </div>
                </dd>
            </dl>
            
            <dl class="clear-fix item">
            	<dt>
                	<span>系列</span>
                </dt>
                
                <dd>
                	<div class="filter_search filterSearch"><b class="iconfont">&#xe60a;</b><input type="text" class="inp-text" data-value="搜索品牌名称" /></div>
                    
                	<ul class="clear-fix attrList" data-info='{"id": 2}'>
                    	<li>
                        	<a href="#">扒拉扒拉</a>
                            <b class="iconfont del">&#xe607;</b>
                        </li>
                        
                        <li>
                        	<a href="#">Macfion/迈克·菲恩</a>
                            <b class="iconfont del">&#xe607;</b>
                        </li>
                    </ul>
                    
                	<div class="options">
                        <span class="more"><a href="javascript:">更多<b class="iconfont">&#xe602;</b></a></span>
                    </div>
                </dd>
            </dl>
        </div>
        <!--筛选信息end-->
    </div>
</div>

<script type="text/javascript">
	$(function(){
		//让滚动插件加载进来,设置ID
		$(".attrList").each(function(i) {
            $(this).attr("id", "attrList"+i);
        });
		
		var data = {
			"1": {"default": ["扒拉扒拉", "宽松"], "more": ["扒拉扒拉", "宽松", "卫生间", "西裤", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "户外鞋服/装备", "扒拉扒拉", "扒拉扒拉", "卫生间", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "休闲", "户外鞋服/装备", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "户外鞋服/装备", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉"]},
			"2": {"default": ["迈克", "宽松"], "more": ["户外鞋服/装备", "宽松", "卫生间", "西裤", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "户外鞋服/装备", "扒拉扒拉", "扒拉扒拉", "卫生间", "扒拉扒拉", "扒拉扒拉", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉", "扒拉扒拉", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "Macfion/迈克·菲恩", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉", "Macfion/迈克·菲恩", "扒拉扒拉"]}
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
				$("#"+$listBox.attr("id")).mCustomScrollbar();
				
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
				$("#"+$listBox.attr("id")).mCustomScrollbar();
				
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
			
			// ...
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
</script>