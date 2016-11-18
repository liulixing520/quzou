<#-- 分页调用 参数说明 -->
<#macro paginationSimple   listSize  viewSize viewIndex searchAction searchForm sortField>
<#assign totalPage=Static["java.lang.Math"].floor(listSize/viewSize)>
<#if listSize gt (viewIndex*viewSize)><#assign totalPage=totalPage+1></#if>
<div class="datagrid-pager pagination" style="border-top: 1px solid #dddddd">
						<table cellspacing="0" cellpadding="0" border="0">
							<tbody>
								<tr>
									<td><select onchange="setViewSize(this.value,'${searchForm!}');return false;" name='pageSize' class="pagination-page-list">
									<#assign availPageSizes = [ 15, 20, 30, 50, 100, 200, 1000]>
									<#list availPageSizes as ps>
									  <option<#if viewSize == ps> selected="selected" </#if> value="${ps}">${ps}</option>
									</#list>
									</select></td>
									<td><div class="pagination-btn-separator"></div></td>
									<td><a href="javascript:void(0)" <#if !(viewIndex lt 1)>onclick="javascript:toFirstPageSimple('${searchForm!}');return false;"</#if>
										class="l-btn l-btn-plain l-btn<#if viewIndex lt 1>-disabled</#if>" id=""><span
											class="l-btn-left"><span class="l-btn-text"><span
													class="l-btn-empty pagination-first">&nbsp;</span></span></span></a></td>
									<td><a href="javascript:void(0)" <#if !(viewIndex lt 1)>onclick="javascript:toPrevPageSimple('${viewIndex-1}','${searchForm!}');return false;"</#if>
										class="l-btn l-btn-plain l-btn<#if viewIndex lt 1>-disabled</#if>" id=""><span
											class="l-btn-left"><span class="l-btn-text"><span
													class="l-btn-empty pagination-prev">&nbsp;</span></span></span></a></td>
									<td><div class="pagination-btn-separator"></div></td>
									<td><span style="padding-left: 6px;">第</span></td>
									<td><input type="text" size="2" value="${(viewIndex?int+1)}"
										class="pagination-num"></td>
									<td><span style="padding-right: 6px;">共${totalPage}页</span></td>
									<td><div class="pagination-btn-separator"></div></td>
									<td><a href="javascript:void(0)" <#if !(viewSize*(viewIndex+1)>listSize)>onclick="javascript:toNextPageFunSimple('${viewIndex}','${searchForm!}');return false;"</#if>
										class="l-btn l-btn-plain l-btn<#if  (viewSize*(viewIndex+1)>listSize)>-disabled</#if>" id=""><span
											class="l-btn-left"><span class="l-btn-text"><span
													class="l-btn-empty pagination-next">&nbsp;</span></span></span></a></td>
									<td><a href="javascript:void(0)" <#if ((totalPage-1!=viewIndex) && (viewIndex*viewSize) lt listSize)>onclick="javascript:toLastSimple('${totalPage-1}','${searchForm!}');return false;"</#if>
										class="<#if (totalPage-1!=viewIndex) && (viewIndex*viewSize) lt listSize>l-btn l-btn-plain l-btn<#else>l-btn l-btn-plain l-btn-disabled</#if>" id=""><span
											class="l-btn-left"><span class="l-btn-text"><span
													class="l-btn-empty pagination-last">&nbsp;</span></span></span></a></td>
									
								</tr>
							</tbody>
						</table>
						<div class="pagination-info">显示${viewSize*viewIndex+1}到
						<#if (viewSize*(viewIndex+1)>listSize)>${listSize!}<#else>${viewSize*(viewIndex+1)}</#if> 共${listSize!}记录</div>
						<div style="clear: both;"></div>
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
</script>
</#macro>