<#-- 分页调用 参数说明 -->
<#macro paginationSimple   listSize  viewSize viewIndex searchAction searchForm sortField>
<#assign totalPage=Static["java.lang.Math"].floor(listSize/viewSize)>
<#if listSize gt (viewIndex*viewSize)><#assign totalPage=totalPage+1></#if>

<style type="text/css">
.m-page {height: 37px;margin-top: 20px;padding: 10px 0;position: relative;}
.m-page .wraper{float:left;margin-left:2%}
.m-page .inner{float:left;margin-left:2%}
.m-page .wraper,.m-page .inner{min-width:850px;_float:none;_width:760px;_margin-left:auto;_margin-right:auto}
.m-page .items{float:left}
.m-page .item{position:relative; margin-right:10px;float:left;margin-left:-1px;width:35px;border:solid 1px #ededed;height:35px;color:#3e3e3e;text-align:center;line-height:35px;cursor:pointer;-webkit-transition:all .1s linear;-moz-transition:all .1s linear;-o-transition:all .1s linear;transition:all .1s linear}
.m-page .item .num{position:relative;z-index:1;display:inline-block;width:100%;text-decoration:none;font-size:14px; padding:0;}
.m-page .item:hover{z-index:1;border-color:#f40}
.m-page .dot{border:none;line-height:37px;width:24px;cursor:default}
.m-page .dot:hover{color:#3e3e3e; border:none;}
.m-page .prev,.m-page .next{width:70px;font-weight:400}
.m-page .prev{margin-right:6px;margin-left:0}
.m-page .next{margin-left:5px}
.m-page .dot+.next{margin-left:-1px}
.m-page .prev-disabled,.m-page .next-disabled{color:#ccc}
.m-page .prev-disabled:hover,.m-page .next-disabled:hover{border-color:#ededed}
.m-page .active,.m-page .active:hover{position:relative;z-index:1;background:#f40;color:#fff;border-color:#f40;cursor:default;text-decoration:none}
.m-page .icon-btn-star,.m-page .icon-btn-star-selected{display:block;margin:5px auto 0}
.m-page .page0:hover .star-gif{display:none}
.m-page .page0 .star-gif{position:absolute;top:11px;left:10px}
.m-page .form{float:left}
.m-page .total,.m-page .text{_display:inline;float:left;line-height:37px}
.m-page .text,.m-page .input,.m-page .btn{margin-left:5px}
.m-page .total{margin-left:10px}
.m-page .text,.m-page .input,.m-page .total{color:#999}
.m-page .input,.m-page .btn{margin-top:7px;float:left;_display:inline}
.m-page .input{width:35px;border:solid 1px #ededed;height:21px;text-align:center}
.ks-ie8 .m-page .input{line-height:21px}
.m-page .btn{height:21px;width:43px;-webkit-border-radius:2px;-webkit-background-clip:padding-box;-moz-border-radius:2px;-moz-background-clip:padding;border-radius:2px;background-clip:padding-box;border:solid 1px #ededed;text-align:center;line-height:21px;cursor:pointer}
.m-page .btn:hover{color:#f40;border-color:#f40}.m-feedback .tb-side{position:fixed;_position:absolute;right:3px;bottom:50px;z-index:100000}

</style>

	<div class="paginating">
			<div id="mainsrp-pager">
<div class="m-page g-clearfix">
    <div class="wraper">
        <div class="inner clearfix">
            <ul class="items">
              <li class="item prev">
              <a  trace="srp_bottom_pageup" href="javascript:void(0)" <#if !(viewIndex &lt; 2)>onclick="javascript:toPrevPageSimple('${viewIndex-1}','${searchForm!}');return false;"</#if> class="J_Ajax num" id="">
                  <span class="icon icon-btn-prev-2"></span>
                  <span>${uiLabelMap.selleronepage}</span>
                </a>
              </li>
              <li class="item <#if viewIndex==1>active</#if>">
              		<a  trace="srp_bottom_pageup" href="javascript:void(0)" onclick="javascript:toPrevPageSimple('1','${searchForm!}');return false;" class="J_Ajax num" id="">
                  <span class="num">1</span>
                  	</a>
              </li>
             <#if viewIndex &gt;5>
	             	<li class="item <#if viewIndex==2>active</#if>">
	              		<a  trace="srp_bottom_pageup" href="javascript:void(0)" onclick="javascript:toPrevPageSimple('2','${searchForm!}');return false;" class="J_Ajax num" id="">
	                  	<span class="num">2</span>
	                  </a>
	              	</li>
	          		<li class="item dot">...</li>
	              	<#list (viewIndex-2)..(viewIndex+2) as i >
	              	 <#if i-1&lt;totalPage >
		              	<li class="item <#if viewIndex==i>active</#if>">
		              		<a  trace="srp_bottom_pageup" href="javascript:void(0)" onclick="javascript:toPrevPageSimple('${i}','${searchForm!}');return false;" class="J_Ajax num" id="">
		                  	<span class="num">${i}</span>
		                  </a>
		              	</li>
		              </#if>
	              	</#list>
	              	
	              	<#if viewIndex+2 &lt;totalPage>
	              		<li class="item dot">...</li>
	              	</#if>
             <#else>
             
             <#if totalPage&gt;5>
             		<#list 2..6 as i >
             			<li class="item <#if viewIndex==i>active</#if>">
			              		<a  trace="srp_bottom_pageup" href="javascript:void(0)" onclick="javascript:toPrevPageSimple('${i}','${searchForm!}');return false;" class="J_Ajax num" id="">
			                  	<span class="num">${i}</span>
			                  </a>
			              </li>
             		</#list>
	              	<li class="item dot">...</li>
             	<#else>
	             	<#if totalPage&gt;1>
		             	<#list 2..totalPage as i >
		              	 <#if i-1&lt;totalPage >
			              	<li class="item <#if viewIndex==i>active</#if>">
			              		<a  trace="srp_bottom_pageup" href="javascript:void(0)" onclick="javascript:toPrevPageSimple('${i}','${searchForm!}');return false;" class="J_Ajax num" id="">
			                  	<span class="num">${i}</span>
			                  </a>
			              	</li>
			              </#if>
		              	</#list>
		              </#if>
              </#if>
             </#if>
               <li class="item next">
               <a href="javascript:void(0)" trace="srp_bottom_pagedown" <#if viewIndex&lt;totalPage >onclick="javascript:toPrevPageSimple('${viewIndex+1}','${searchForm!}');return false;"</#if> 	class="J_Ajax num icon-tag" id="">
                  <span>${uiLabelMap.sellernextpage}</span>
                  <span class="icon icon-btn-next-2"></span>
                </a>
              </li>
            </ul>
        <div class="total">
       		 ${uiLabelMap.sellertotal} ${totalPage} ${uiLabelMap.sellerPage}，${uiLabelMap.sellertotal}${listSize!}${uiLabelMap.sellerRecord}
        </div>
	       <div class="form">
	       <#-- <span class="text">${uiLabelMap.sellerTothe}</span>
	        <input type="number"  id="inde" max="100" min="1" value="${viewIndex}" class="input J_Input">
	        <span class="text">${uiLabelMap.sellerPage}</span>
			<a href="javascript:jump('${searchForm!}','${totalPage}');">
	         <span tabindex="0" role="button" class="btn J_Submit">${uiLabelMap.sellerDetermine}</span>
	         </a>
	       -->  
	        </div>
        </div>
    </div>
</div>
</div>
</div>
		</div>
<form class='pageForm' id='pageForm'>
	<input type='hidden' name='VIEW_INDEX_1' id='viewIndex' value='${viewIndex!}'>
	<input type='hidden' name='VIEW_SIZE_1' id='viewSize' value='${viewSize!}'>
	<input type='hidden' name='sortField' id='sortField' value='${sortField!}'>
</form>

<script language='javascript'>
jQuery(function() {
	$(".header-row-2").children().each(function() {
		if($(this).attr("sortField")){
			var orderClass="sort-order";
			var thisorderBy=$("#sortField").val();
			if(thisorderBy.replace("-","")==$(this).attr("sortField").replace("-","")){
				if(thisorderBy.indexOf("-")==-1){
					$(this).attr("sortField","-"+$(this).attr("sortField"));
					orderClass="sort-order-desc";
				}else{
					orderClass="sort-order-asc";
				}
			}
			$(this).html("<a href='javascript:void(0);' class='"+orderClass+"' onclick=\"sortSimpleFun('"+$(this).attr("sortField")+"','${searchForm!}');return false;\">"+$(this).text()+"</a>");
		}
	});
});

//跳转至下一页
	function setViewSize(size,searchFormId){
		$("#viewIndex").val(0);
		$("#viewSize").val(size);
		searchFormFun(searchFormId);
	}
	function toNextPageFunSimple(currentPage,searchFormId){
		$("#viewIndex").val(parseInt(currentPage)+1);
		searchFormFun(searchFormId);
	}
	function toPrevPageSimple(prePage,searchFormId){
		$("#viewIndex").val(prePage);
		searchFormFun(searchFormId);
	}
	function toFirstPageSimple(searchFormId){
		$("#viewIndex").val(0);
		searchFormFun(searchFormId);
	}
	function toLastSimple(lastPage,searchFormId){
		$("#viewIndex").val(lastPage);
		searchFormFun(searchFormId);
	}
	function sortSimpleFun(sortField,searchFormId){
		$("#sortField").val(sortField);
		searchFormFun(searchFormId);
	}
	// 查询列表
function searchFormFun(formId) {
	jQuery("#pageForm").find(":input").each(
			function() {
				jQuery("#" + formId).append(
						"<input type='hidden' value='" + this.value
								+ "' name='" + this.name + "'>");
			});
	$("#" + formId).submit();
}
</script>
</#macro>