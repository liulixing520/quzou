  
  <div class="bgwhite clearfix">
  	
    <div class="wrap main_top ">
      <div class="logo fl">
          <a href="main"><img src="../images/images/common/logo.png" /></a>
         <#-- <div class="cattleImg">
            <a href="findProduct"><img src="../images/images/common/cattle.gif" /></a>
          </div>-->
      </div>
      <div class="search fl">
          <form method="get" name="findProForm" id="findProForm" action="${(titleProperty)?default("findProduct")!}">
            <input type="hidden" name="sortOrder" id="sortOrder" value="${(parameters.sortOrder)!}"/>
            <input type="hidden" name="sortAscending" id="sortAscending" value='${(parameters.sortAscending)!("N")}'><#--从高到低-->
            <input type="hidden" name="SEARCH_SUB_CATEGORIES" id="searchCategories" value="Y"/>
            <input type="hidden" name="SEARCH_OPERATOR" id="operator" value="OR" />
            <input type="hidden" name="SEARCH_CATEGORY_ID" id="SEARCH_CATEGORY_ID" value="${(parameters.SEARCH_CATEGORY_ID)!}" />
            <input type="text" name="SEARCH_STRING" id="SEARCH_STRING" class="search_input" value="${requestParameters.SEARCH_STRING?if_exists}" />
            <input type="button" class="search_btn" value="搜索" onclick=""/>
          </form>
      </div>
      
    </div>
  </div>

<script type="text/javascript">
$(function(){
  $("#SEARCH_STRING").focus(function(){
    $(this).parent().siblings(".accountSelectList").show();
  }).click(function(){
    return false;
  });
  $(".accountSelectList").click(function(){
    $(this).hide();
    return false;
  });
  $(document).click(function(){
    $(".accountSelectList").hide();
  });
  $(".closeIcon").click(function(){
  	$(this).parent().remove();
  });
});
</script>

<script>
  function showUrl(typeId,value){
    var url = "";
    var searchCategories = jQuery("#searchCategories").val();
    var operator = jQuery("#operator").val();
    var sortOrder = $("#sortOrder").val();
    var sortAscending = $("#sortAscending").val();
    url = "${(titleProperty)?default("findProduct")!}?SEARCH_CATEGORY_ID=${(parameters.SEARCH_CATEGORY_ID)!}&SEARCH_SUB_CATEGORIES="+searchCategories+"&SEARCH_OPERATOR="+operator+"&sortOrder="+sortOrder+"&sortAscending="+sortAscending;
    <#if productFeatureTypeIdsOrdered?has_content>
    <#list productFeatureTypeIdsOrdered as productFeatureTypeId>
      if(typeId!="${(productFeatureTypeId)!}"){
        <#if parameters['pft_${(productFeatureTypeId)!}']?has_content>
          url+="&pft_${(productFeatureTypeId)!}=${(parameters['pft_${(productFeatureTypeId)!}'])!}";
        </#if>
      }
    </#list>
    </#if>
    var SEARCH_STRING=jQuery("#SEARCH_STRING").val();
    if(SEARCH_STRING!=""&&SEARCH_STRING!=null&&SEARCH_STRING!=undefined){
      url+="&SEARCH_STRING="+SEARCH_STRING;
    }
    if(value!=""&&value!=null&&value!=undefined){
      url+="&pft_"+typeId+"="+value;
    }
    location.href=url;
  }

  window.onload = function () {
    jQuery('#searchIcon').bind('click', function () {
      jQuery('#findProForm button').trigger('click');
    });
  };
</script>
