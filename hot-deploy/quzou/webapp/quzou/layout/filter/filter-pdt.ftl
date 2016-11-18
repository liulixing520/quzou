<div class="wrap2">
  <div class="filter">
      <!--面包屑-->
      <#-- V1.0不上此功能  modify by Ansen
      <div class="crumb">
          <ul>
              <li>
                  <a href="#">首页</a>
                    <b class="iconfont ico">&#xe604;</b>
                </li>
                <li>
                  <a href="#">产品</a>
                    <b class="iconfont ico">&#xe604;</b>
                </li>
                <li class="seh">
                  <input type="text" class="inp-text" name="SEARCH_STRING_STR" id="SEARCH_STRING_STR" value="${(parameters.SEARCH_STRING)!}" data-value="" />
                    <span class="seh_btn" onclick="showForm()" ><b class="iconfont ico">&#xe601;</b></span>
                </li>
            </ul>

            <div class="count">共 ${(listSize)!} 件相关商品</div>
        </div>-->
        <!--面包屑end-->

    <#if productFeatureTypeIdsOrdered?has_content>
      <div class="crumb">
        <ul>
          <li>
            <span>搜索条件：</span>
          </li>

          <#list productFeatureTypeIdsOrdered as productFeatureTypeId>
            <#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productFeatureTypeId", productFeatureTypeId)>
            <#assign productFeatures = productFeaturesByTypeMap[productFeatureTypeId]>
            <#list productFeatures as productFeature>
              <#if "${(parameters['pft_${(productFeatureTypeId)!}'])!}"=="${productFeature.productFeatureId}">
                <#assign hid = 0 />
                <#if "${(parameters.SEARCH_CATEGORY_ID)!}"=="BEAUTY_PRODUCT">
                  <#if productFeatureTypeId=="TYPE"><#assign hid = 1 /></#if>
                </#if>
                <#if hid==0>
                  <li class="set">
                    <a href="javascript:" onclick="showUrl('${(productFeatureTypeId)!}','');">
                      ${productFeature.description?default(productFeature.productFeatureId)}
                      <b class="iconfont ico del">&#xe607;</b>
                    </a>
                  </li>
                </#if>
              </#if>
            </#list>
          </#list>
        </ul>
      </div>
    </#if>
        <!--筛选信息-->
    <div class="filter_attr">
      <#list productFeatureTypeIdsOrdered as productFeatureTypeId>
        <#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productFeatureTypeId", productFeatureTypeId)>
        <#assign productFeatureType = delegator.findOne("ProductFeatureType", findPftMap, true)>
        <#assign productFeatures = productFeaturesByTypeMap[productFeatureTypeId]>
        <#assign hid = 0 />
        <#if "${(parameters.SEARCH_CATEGORY_ID)!}"=="BEAUTY_PRODUCT">
          <#if productFeatureTypeId=="TYPE"><#assign hid = 1 /></#if>
        </#if>
        <#if hid==0>
          <dl class="clear-fix item">
            <dt>
              <span>${(productFeatureType.get("description",locale))?if_exists}</span>
            </dt>

            <dd>
              <div class="filter_search filterSearch"><input type="text" class="inp-text" data-value="搜索${(productFeatureType.get("description",locale))?if_exists}名称" /><span class="searchBtn">查询</span></div>
              <#assign defaultFeature = ""/>
              <ul class="clear-fix attrList" data-info='{"id": ${(productFeatureTypeId_index+1)!}}'>
                <#list productFeatures as productFeature>
                  <li>
                    <a href="javascript:void(0);" onclick="showUrl('${(productFeatureTypeId)!}','${productFeature.productFeatureId}');">${productFeature.description?default(productFeature.productFeatureId)}</a>
                    <b class="iconfont del">&#xe607;</b>
                  </li>
                  <#assign defaultFeature = defaultFeature+"'${StringUtil.wrapString(productFeature.description?default(productFeature.productFeatureId))}-${(productFeatureTypeId)!}-${productFeature.productFeatureId}',"/>
                  <#if productFeature_index==11><#break></#if>
                </#list>

              </ul>

              <div class="control clear-fix">
                <a href="javascript:" class="promise disabled">确定</a>
                <a href="javascript:" class="cancel">取消</a>
              </div>

              <div class="options">
                  <#--
                  <span class="select"><a href="javascript:"><b class="iconfont">&#xe609;</b>多选</a></span>
                  -->
                <span class="more"><a href="javascript:">更多<b class="iconfont">&#xe602;</b></a></span>
              </div>
            </dd>
          </dl>
        </#if>
      </#list>
    </div>
        <!--筛选信息end-->
  </div>
</div>


<script type="text/javascript">
  function showForm(){
    var SEARCH_STRING_STR = $("#SEARCH_STRING_STR").val();
    if(SEARCH_STRING_STR==""){
    SEARCH_STRING_STR="";
    }
    $("#SEARCH_STRING").val(SEARCH_STRING_STR);
    showUrl('','');
  }
  function showOrderBy(byValue){
    var sortOrder = $("#sortOrder").val(byValue);
    var sortAscending = $("#sortAscending").val();
    if(sortAscending==="N"){
      $("#sortAscending").val("Y");
    }else{
      $("#sortAscending").val("N");
    }
    showUrl('','');
  }
  $(function(){
    //让滚动插件加载进来,设置ID
    $(".attrList").each(function(i) {
      $(this).attr("id", "attrList"+i);
    });

    var data = {
                            <#--[0..defaultFeature?length-1]-->

      <#list productFeatureTypeIdsOrdered as productFeatureTypeId>
        <#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productFeatureTypeId", productFeatureTypeId)>
        <#assign productFeatures = productFeaturesByTypeMap[productFeatureTypeId]>
        <#assign defaultFeature = ""/>
        <#assign listFeature = ""/>
        <#list productFeatures as productFeature>
          <#assign defaultFeature = defaultFeature+"'${StringUtil.wrapString(productFeature.description?default(productFeature.productFeatureId))}-${(productFeatureTypeId)!}-${productFeature.productFeatureId}',"/>
          <#if productFeature_index==7><#break></#if>
        </#list>
        <#list productFeatures as productFeature>
          <#assign listFeature = listFeature+"'${StringUtil.wrapString(productFeature.description?default(productFeature.productFeatureId))}-${(productFeatureTypeId)!}-${productFeature.productFeatureId}',"/>
        </#list>
        "${(productFeatureTypeId_index+1)!}": {"default": [${StringUtil.wrapString(defaultFeature)!}], "more": [${(StringUtil.wrapString(listFeature))!}]}<#if productFeatureTypeId_index+1!=productFeatureTypeIdsOrdered?size>,</#if>
      </#list>
    };

    function getDataMore(d, id, type){
      var d = d[id][type];
      return d;
    }

    function createAttrListHTML(p){
      var html = "";

      for(var i=0, l=p.length; i<l; i++) {
        var arrayObj = p[i].split("-");
        html += "<li>"+
                  "<a href='javascript:void(0)' onclick=showUrl('"+arrayObj[1]+"','"+arrayObj[2]+"');>"+arrayObj[0]+"</a>"+
                  "<b class='iconfont del'>&#xe607;</b>"+
                "</li>";
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
