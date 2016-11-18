<link rel="stylesheet" type="text/css" href="../seller/css/newsyi-category.css?v=20141013">
<!-- 代码 开始 -->
<!-- 头文件调用开始 -->
<div id="header">
  <div id="toplist"></div>
</div>
<!-- 头文件调用结束 -->
<div class="leavecategory">
  <div class="leave-cat-lv leave01"> 
  	<span class="first">1. 选择类目</span> 
  	<span class="middle current">2.填写信息</span> 
  	<span class="last">3. 提交审核</span> 
  </div>
  <h1>上传产品</h1>
</div>
<div class="catgoray-box">
  <div id="search-box">
    <div class="titlebox">
      <h3>选择类目</h3>
    </div>
  <!-- 级联菜单-->
  <div id="greay-cat-box" class="greay-cat-box">
    <div class="b-f-line">
      <div class="categoryselectlistbox clearfix">
        <div id="div_catagory0" class="categoryselectlist addscroll">
          <ul id="catagory0">
            <#list categoryList as category>
            <li onclick="javascript:selectCategory('${category.productCategoryId}', '${category.categoryName}', '${category.primaryParentCategoryId}', 'catagory1', 1);" title="${category.categoryName}" data-param="catePubId=${category.productCategoryId}" data-message=""
				data-remark="" data-leaf="0" data-valid="1" data-en="${category.categoryName}"
				data-cn="${category.categoryName}" >${category.categoryName}</li>
            </#list>
          </ul>
        </div>
        
        <div id="div_catagory1" class="categoryselectlist">
          <ul id="catagory1">
          </ul>
        </div>
        
        <div id="div_catagory2" class="categoryselectlist">
          <ul id="catagory2">
          </ul>
        </div>
        
        <div id="div_catagory3" class="categoryselectlist">
          <ul id="catagory3">
          </ul>
        </div>
      </div>
      
      <div class="selected-category">
        <!--   -----------------------------当前已选择的产品类目 DIV----------------------------   -->
        <div class="chouseed-catrgory clearfix">
          <div class="clearfix"> <span class="cate-title">当前已选择的类目：</span> <span
								id="show_category_path" class="cate-value show_category_path"></span> </div>
        </div>
        <!--   -----------------------------没有操作权限提醒 DIV----------------------------               -->
        <div style="display: none;" id="div_show_admittance"
						class="chousetips"></div>
        <!--   -----------------------------类目介绍提醒DIV ----------------------------               -->
        <div style="display: none;" id="div_show_remark"
						class="selected-category-tip clearfix"> <span class="cate-title">类目介绍：</span> <span id="show_remark"
							class="cate-value show_remark"></span> </div>
      </div>
      
    </div>
    
    <div class="buttonbox"> 
    	<form method="post" action="<@ofbizUrl>addNewGoodsNext</@ofbizUrl>" id="addNewGoodsForm">
    		<input id="productCategoryId0" name="productCategoryId0" type="hidden">
    		<input id="productCategoryId1" name="productCategoryId1" type="hidden">
    		<input id="productCategoryId2" name="productCategoryId2" type="hidden">
    		<input id="productCategoryId3" name="productCategoryId3" type="hidden">
        	<button id="submit_button" class="submit_button" type="submit"> 
        		<span id="button_category" class="submit-syi initialstate"> <span>立即去发布新产品</span> </span> 
        	</button>
        </form> 
    </div>
    
  </div>
</div>
<script type="text/javascript">
        
	function selectCategory(id, name, parentCategoryStr, divId, index) {
		$('#'+divId).html('');
		var ajaxUrl = '<@ofbizUrl>productCategoryList</@ofbizUrl>';
	    //jQuerry Ajax Request
	    $.ajax({
	        url: ajaxUrl,
	        type: 'POST',
	        data: {"category_id" : id, "parentCategoryStr" : parentCategoryStr, "index" : index},
	        error: function(msg) {
	            alert("An error occured loading content! : " + msg);
	        },
	        success: function(msg) {
	            $('#div_'+divId).addClass('addscroll');
	            $('#'+divId).html(msg);
	        }
	    });
	    $('#productCategoryId'+(index-1)).val(id);
		$('#productCategoryName'+(index-1)).val(name);
	}

</script>
<!-- 代码 结束 -->