<script language="javascript"> 
//查询商品列表
var can = true;
var hrefstr = '<@ofbizUrl>/EditProduct</@ofbizUrl>';
function show_child_products(pid, t) {
	$("tr[id^=commodities][id!=commodities" + pid + "]").hide();
	var commoditiesTr = $("#commodities" + pid);
	if (commoditiesTr[0]) {
		commoditiesTr.toggle();
	} else {
		if(can){
			can = false;
			$.getJSON("<@ofbizUrl>/getChildProducts</@ofbizUrl>", {"productId": pid}, function (data) {
				var html = "<tr id=commodities" + pid + "><td colspan='13' ><table width='100%' border='0' cellspacing='0' cellpadding='0' class='table'>" + "<tr class='border_tr02'>" + "<th class='width12'>&nbsp;</th>" + "<th class='width5'>编号</th>" + "<th class='width25'>子商品名称</th>" + "<th class='width15'>子商品货号</th>" + "<th class='width10'>现价</th>" + "<th class='width10'>市场价</th>"+ "<th class='width10'>成本价</th>" + "<th class='width13'>规格</th>" + "<th class='width10'>库存</th>" + "</tr>";
				if (data.length == 0) {
					html += "<tr><td colspan=14 style='text-align:center'>没有符合条件的记录</td></tr>";
				} else {
					for (var i = 0, ci; ci = data.data[i]; i++) {
						html += "<tr class='border_tr02' id='background_tr'><td>&nbsp;</td>";
						html += "<td><div><a rel='EditProduct' title='编辑商品' class='button' href='"+ hrefstr + "?productId=" + ci.product.productId + "' target='navTab'><span>" + ci.product.productId + "</span></a></div></td>";
						/*html += "<td><div><a class='button' href=\"javascript:a("+ ci.product.productId +");\"><span>" + ci.product.productId + "</span></a></div></td>";*/
						/*编号*/
						html += "<td>" + ((ci.product.productName == "" || ci.product.productName == null || ci.product.productName == undefined) ? "&nbsp" : ci.product.productName) + "</td>";
						/*子商品名称*/
						html += "<td>" + ((ci.product.goodsNo == "" || ci.product.goodsNo == null || ci.product.goodsNo == undefined) ? "&nbsp" : ci.product.goodsNo) + "</td>";
						/*子商品货号*/
						html += "<td>" + ((ci.priceGv == "" || ci.priceGv == null || ci.priceGv == undefined) ? "&nbsp" : ci.priceGv.price) + "</td>";
						/*现价*/
						html += "<td>" + ((ci.marketPrice == "" || ci.marketPrice == null || ci.marketPrice == undefined) ? "&nbsp" : ci.marketPrice.price) + "</td>";
						/*市场价*/
						html += "<td>" + ((ci.avergeCostPrice == "" || ci.avergeCostPrice == null || ci.avergeCostPrice == undefined) ? "&nbsp" : ci.avergeCostPrice.price) + "</td>";
						/*成本价*/
						html += "<td>" + ((ci.features == "" || ci.features == null || ci.features == undefined) ? "&nbsp" : ci.features)  + "</td>";
						/*规格*/
						html += "<td>" + "1000" + "</td>";
						/*库存*/
						html += "</tr>";
					}
				}
				html += "</table>";
				$(t).parents("tr").after(html);
				can = true;
				/*jQuery("#commodities"+pid).initUI();  */
				var $p = $(document);
				$("a[target=navTab]", $p).each(
					function() {
						$(this).click(
								function(event) {
									var $this = $(this);
									var title = $this.attr("title") || $this.text();
									var tabid = $this.attr("rel") || "_blank";
									var fresh = eval($this.attr("fresh") || "true");
									var external = eval($this.attr("external")
											|| "false");
									var url = unescape($this.attr("href"))
											.replaceTmById(
													$(event.target).parents(
															".unitBox:first"));
									DWZ.debug(url);
									if (!url.isFinishedTm()) {
										alertMsg.error($this.attr("warn")
												|| DWZ.msg("alertSelectMsg"));
										return false;
									}
									navTab.openTab(tabid, url, {
										title : title,
										fresh : fresh,
										external : external
									});
									event.preventDefault();
								});
					});
			});
		}	

	}
}
$('#searchCondition').bind('change',function(){
	var selectOne = this.value;
	$("#search_c").attr('name',selectOne);
	$("#search_op").attr('name',selectOne+'_op');
	$("#search_ic").attr('name',selectOne+'_ic');
});
//批量还原
$("#recycle_batch").bind("click", function (event) {

	//页面中选中的checkbox
	var checkboxs = $("input:checked[type=checkbox][name=orderIndexs]");

	if (checkboxs.length == 0) {
		alert("请选择要删除的商品");
		return;
	}
	var propertys = "";
	for (var i = 0, ci; ci = checkboxs[i]; i++) {
		if (i > 0) {
			propertys += ",";
		}
		propertys += ci.value;
	}
	//删除操作
	jQuery.ajax({
	    url: "recoverProductStatus",
	    type: 'POST',
	    data: {productIds : propertys},
	    error: function(msg) {
	        showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
	    },
	    success: function(msg) {
			navTab.reload();
	    }
    });
		
});
</script>
<form id="pagerForm" method="post" action="FindProductRecycle">

	<input type="hidden" name="pageNum" value="1" />
	<input type="hidden" name="numPerPage" />
	<input type="hidden" name="orderField"  />
</form>

<script language='javascript'></script>


<div class="pageContent" >
	<div class="panelBar">
		<ul class="toolBar">
		<form action='FindProductRecycle' name='FindProductRecycle' id='FindProductRecycle' method="post" rel="pageForm">
			<li><a class="add" href="#" id="recycle_batch"><span>还原</span></a></li>
			<li>
				<select id="searchCondition">
					<option value="productName">产品名称</option>
					<option value="goodsNo">货号</option>
				</select>
			</li>
			<li>
				<input type='hidden' id="search_op" name='productName_op' value="contains">
				<input type='hidden' id="search_ic" name='productName_ic' value="Y">
				<input type='text' id="search_c" name='productName'></li>
			<li><a class="icon" href="#"  onclick="javascript:submitForm('FindProductRecycle');" ><span>搜索</span></a></li>
			<#--<li><a class="icon" href="<@ofbizUrl>FindProductAdvanced</@ofbizUrl>" target="dialog" mask="true" title="查询框"><span>高级检索</span></a></li>-->
		</form>	
			</ul>
	</div>
	<table class="table" width="100%" layoutH="78">
		<thead>
			<tr>
				<td width="55">操作</td>
				<td width="60"><input type="checkBox" class="checkboxCtrl" group="orderIndexs">全选</td>
				<td width="120">商品名称</td>
				<td width="120">品牌</td>
				<td width="120">货号</td>
				<td width="100">上架</td>
				<td width="150">类型</td>
				<td width="80">库存</td>
				
			</tr>
		</thead>
		<tbody>
		 <#list productList as product>
		 	<tr>
				<td ><a rel='EditProduct' title='编辑商品' class="button" href="<@ofbizUrl>EditProduct</@ofbizUrl>?productId=${product.productId?if_exists}" ><span>编辑</span></a></td>
				<td><input type="checkbox" value="${product.productId?if_exists}" name="orderIndexs" ></td>
				<td <#if product?? && product.productId??>onclick="show_child_products('${product.productId}', this)"</#if>>${product.productName?if_exists}</td>
				<td <#if product?? && product.productId??>onclick="show_child_products('${product.productId}', this)"</#if>>${product.brandName?if_exists}</td>
				<td <#if product?? && product.productId??>onclick="show_child_products('${product.productId}', this)"</#if>>${product.goodsNo?if_exists}</td>
				<td <#if product?? && product.productId??>onclick="show_child_products('${product.productId}', this)"</#if>>
					<#if product.salesDiscontinuationDate?has_content> 
						<#if Static["org.ofbiz.base.util.UtilDateTime"].nowTimestamp().before(product.salesDiscontinuationDate)>
							<img src="/images/itea/face.gif" width="16" height="16"/>
						<#else>
							<img src="/images/itea/delete.gif" width="16" height="16"/>
						</#if>
					<#else>
						<img src="/images/itea/face.gif" width="16" height="16"/>
					</#if>
				</td <#if product?? && product.productId??>onclick="show_child_products('${product.productId}', this)"</#if>>
				<td <#if product?? && product.productId??>onclick="show_child_products('${product.productId}', this)"</#if>>${product.categoryName?if_exists}</td>
				
				<td <#if product?? && product.productId??>onclick="show_child_products('${product.productId}', this)"</#if>>100</td>
			</tr>
		 </#list>
			
		</tbody>
	</table>
<!--
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="VIEW_SIZE_1" onchange="navTabPageBreak({VIEW_SIZE_1:this.value})">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select>
			<span>${paginateViewSizeLabel!}&nbsp;&nbsp;共${listSize!0}条</span>
			</div>
		</div>
		
		<div class="pagination" targetType="navTab" totalCount="${listSize!}" VIEW_SIZE_1="${viewSize!}" pageNumShown="3" currentPage="${(viewIndex+1)!}"></div>
-->
</div>
