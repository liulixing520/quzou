/*
 * 入参格式
    {
        'limit': 10,
        'data' : [
                    {
                        'limit': 8
                        'name':'项目名称',
                        'attrs':[
                            {"attrId":'pd-1001',"attrName":"卡瑞兹","linkUrl":"findProduct?sdf"},
                            {"attrId":'pd-1002',"attrName":"魔镜","onclickStr":"showUrl('a','b')" }
                        ]
                    },
                    {
                        'name':'品牌名称',
                        'attrs':[
                            {"attrId":'bd-1004',"attrName":"品牌1"},
                            {"attrId":'bd-1005',"attrName":"品牌2"}
                        ]
                    }
                ]
    }
 */
(function($){
    $.fn.cy_filter = function(options){
        var $filterDiv = $(this);
        var data = options.data || [];
        var limit = options.limit || 10; //全局超过limit条就隐藏在more里

        var makeDl =  function(data){
            var htmlTmpl = '';
            $.each(data,function(n,value) {
               htmlTmpl += makeOneDl(n,value);
            });
            return htmlTmpl;
        }

        var makeOneDl = function(n,oneDl){
            var listLimit = oneDl.limit || limit; //明细里没有配置limit则使用全局
            var tmp =
            '<dl class="clear-fix item"> \
                <dt> \
                    <span>'+oneDl.name+'</span> \
                </dt> \
                <dd> \
                    <div class="filter_search filterSearch"> \
                        <input type="text" class="inp-text" placeholder="搜索' + oneDl.name + '" /><span class="searchBtn">查询</span> \
                    </div> \
                    <ul id="attrList"'+n+'" class="clear-fix attrList" data-infoindex="'+n+'">'
                + makeLi(oneDl.attrs.slice(0,listLimit))+
                    '</ul> \
                    <div class="control clear-fix"> \
                        <a href="javascript:" class="promise disabled">确定</a> \
                        <a href="javascript:" class="cancel">取消</a> \
                    </div> \
                    <div class="options"> \
                        <span class="more"><a href="javascript:">更多<b class="iconfont">&#xe602;</b></a></span> \
                    </div> \
                </dd> \
            </dl>';
            return tmp;
        }

        var makeLi = function(attrs){
            var htmlTmpl = '';
            $.each(attrs,function(n,value) {
                htmlTmpl += makeOneLi(n,value);
            });
            return htmlTmpl;
        }

        var makeOneLi = function(n,oneLi){
            var tmp ='<li>';
            if(oneLi.linkUrl){
                tmp +='<a href="'+oneLi.linkUrl+'">'+oneLi.attrName+'</a>';
            }else if(oneLi.onclickStr){
                 tmp +='<a href="javascript:return void(0);" onclick="'+ oneLi.onclickStr +'">'+oneLi.attrName+'</a>';
            }else{
                tmp += '<a htref="#">'+oneLi.attrName+'</a>';
            }
            tmp += '<b class="iconfont del">&#xe607;</b></li>'
            return tmp;
        }

        $filterDiv.html('').append(makeDl(data));

        //
        $(".item input.inp-text").on("keyup", function(){
            var self = $(this),
                $list = self.closest("dl.item").find(".attrList li");

            $list.filter(function(index) {
                if($(this).text().indexOf(self.val()) < 0) {
                    $(this).hide();
                } else {
                    $(this).show();
                }
            });
        });

        function setAttrList(e, type) {
            var self = e,
                $box = self.closest("dl.item"),
                $listBox = $box.find(".attrList");
            var attrIndex = $listBox.data("infoindex");
            var listData = data[attrIndex];
            var listLimit = listData.limit || limit ;
            var attrs = listData["attrs"];

            $("#"+$listBox.attr("id")).mCustomScrollbar("update");

            if(type == "cancel") {
                //d = getDataMore(data, $listBox.data("info").id, "default");
                $listBox.removeClass("ck order").html(makeLi(attrs.slice(0,listLimit)));
                $box.find(".control").hide();
                $box.find(".options").show().find(".more").html('<a href="javascript:">更多<b class="iconfont">&#xe602;</b></a>');;
                $box.find(".filterSearch").hide();

                return false;
            }

            if(type == "select") {
                //d = getDataMore(data, $listBox.data("info").id, "more");
                $box.find(".control").show();
                $box.find(".options").hide();
                $box.find(".filterSearch").show();
                $listBox.addClass("ck order").html(makeLi(attrs));
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
                //d = getDataMore(data, $listBox.data("info").id, "default");
                $listBox.removeClass("ck more").html(makeLi(attrs.slice(0,listLimit)));
                $box.find(".filterSearch").hide();

                if(type == "more") self.html('<a href="javascript:">更多<b class="iconfont">&#xe602;</b></a>');

            } else {
                //d = getDataMore(data, $listBox.data("info").id, "more");
                $listBox.addClass("ck more").html(makeLi(attrs));
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

        //console.log("hahaha===" + $filterDiv.html());
    }
})(jQuery);




