
<form id="pagerForm" method="post" action="FindProduct">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	<input type="hidden" id="productStoreId"  value='${parameters.defalutProductStoreId!}'/>
	
</form>
	<div class="search_area">
		 <table>
				<tr>
					<td>
						<form   action="FindProductEn" id="FindProductEn" method="post">
							<table class="searchContent">
								<tr>
									<td>
									           产品名称：<input type="text" name="productName" value='${queryStringMap.productName!}'/>
										<input type="hidden" value="Y" name="productName_ic">
										<input type="hidden" value="contains" name="productName_op">
									</td>
									<td> &nbsp;&nbsp;&nbsp;&nbsp;
									          分类：<input type="text" name="categoryName" value='${queryStringMap.categoryName!}'/>
										<input type="hidden" value="Y" name="categoryName_ic">
										<input type="hidden" value="contains" name="categoryName_op">
									</td>
									<td>&nbsp;&nbsp;&nbsp;&nbsp;
										<input class="btn btn-info" type="submit" value="查询">
									</td>
									<td>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<button="" class="btn btn-info" onClick="location='/portal/control/EditProductEn'" type="button">新增 </button>
									</td>
								</tr>
							</table>
						</form>
					
				</tr>
			</table>
		<div>
		</div>
	</div>
	<div class="listheight" style="height:75%; width:100%; overflow-y: auto;">
   	<table class="table table-striped table-bordered table-hover dataTable no-footer" cellspacing="0" width="100%">
		<thead>
			<tr class='header-row-2'>
				<td width="50px"><input type="checkBox" class="checkboxCtrl" group="orderIndexs"></td>
				<!-- <td style="text-align:center;">货号</td>-->
				<td style="text-align:center;width:350px">商品名称</td>
				<td style="text-align:center;">品牌</td>
				<td style="text-align:center;">分类</td>
				<td style="text-align:center;">售出数量</td>
				<td style="text-align:center;">剩余库存</td>
				<td style="text-align:center;">上架</td>
				<td>操作</td>
				<td>查看子商品</td>
			</tr>
		</thead>
		<tbody>
		 <#list productList as product>
		 	<tr>
				<td><input type="checkbox" value="${product.productId?if_exists}" name="orderIndexs" ></td>
				<!-- <td style="text-align:center;">${product.goodsNo?if_exists}</td>-->
				<td style="text-align:center;"><a   href="/portal/products/p_${product.productId?if_exists}">${product.internalName?if_exists}</a></td>
				<td style="text-align:center;">${product.brandName?if_exists}</td>
				<#if product.primaryProductCategoryId?has_content>
					<#assign productCategory = delegator.findOne("ProductCategory", {"productCategoryId" : product.primaryProductCategoryId}, true)?if_exists>
				</#if>
				<td style="text-align:center;"><#if productCategory?has_content>${productCategory.categoryName?if_exists}</#if></td>
				<#assign productCalculatedInfo = delegator.findOne("ProductCalculatedInfo", {"productId" : product.productId}, true)?if_exists>
				<td style="text-align:center;"><#if productCalculatedInfo?has_content>${productCalculatedInfo.totalQuantityOrdered?if_exists}<#else>0</#if></td>
				
				<#assign result = dispatcher.runSync("getProductInventoryAvailable", Static["org.ofbiz.base.util.UtilMisc"].toMap("productId", product.productId))/>
				<td style="text-align:center;
				
				">${result.availableToPromiseTotal!}</td>
				<td style="text-align:center;">
					<#if product.salesDiscontinuationDate?has_content> 
						<#if Static["org.ofbiz.base.util.UtilDateTime"].nowTimestamp().before(product.salesDiscontinuationDate)>
							<img src="/portal/seller/images/face.gif" width="16" height="16"/>
						<#else>
							<img src="/portal/seller/images/delete.gif" width="16" height="16"/>
						</#if>
					<#else>
						<img src="/portal/seller/images/face.gif" width="16" height="16"/>
					</#if>
				</td>
				<td >
					<a  title='编辑商品' class="btnEdit" href="<@ofbizUrl>EditProductEn</@ofbizUrl>?productId=${product.productId?if_exists}"><span>编辑</span></a>
				</td>
				<td>
					<#if product.isVirtual == 'Y'><a rel='EditProductEn' title='查看子商品' class="btnEdit" href="#" onclick="show_child_products('${product.productId}', this);return false;"><span>查看子商品</span></a></#if>
				</td>
			</tr>
		 </#list>
			
		</tbody>
	</table>
	
</div>

<#include "component://portal/webapp/portal/includes/productpagination.ftl"/>      
<@paginationSimple  listSize viewSize viewIndex  'FindProductEn' 'FindProductEn' parameters.sortField!/>	

<script language="javascript"> 
//查询商品列表
var can = true;
var hrefstr = '<@ofbizUrl>/EditProductEn</@ofbizUrl>';
function show_child_products(pid, t) {
	$("tr[id^=commodities][id!=commodities" + pid + "]").hide();
	var commoditiesTr = $("#commodities" + pid);
	if (commoditiesTr[0]) {
		commoditiesTr.toggle();
	} else {
		if(can){
			can = false;
			$.getJSON("<@ofbizUrl>/getChildProducts</@ofbizUrl>", {"productId": pid}, function (data) {
				var html = "<tr id=commodities" + pid + "><td colspan='10' ><table width='100%' class='table'>" + "<tr>"+ "<td width='40px' style='font-weight:bold'></td>" + 
				//"<td width='120px' style='text-align:center;font-weight:bold'>子商品货号</td>" + 
				"<td width='350px' style='text-align:center;font-weight:bold'>子商品名称</td>" + "<td width='60px' style='text-align:center;font-weight:bold'>现价</td>" + "<td width='60px' style='text-align:center;font-weight:bold'>市场价</td>"+ "<td width='60px' style='text-align:center;font-weight:bold'>成本价</td>" + "<td width='200px' style='text-align:center;font-weight:bold'>规格</td>" + "<td width='60px' style='font-weight:bold'>售出数量</td>" + "<td width='60px' style='text-align:center;font-weight:bold'>剩余库存</td>" + "<td style='font-weight:bold'>编辑</td>" + "</tr>";
				if (data.length == 0) {
					html += "<tr><td colspan=10 style='text-align:center'>没有符合条件的记录</td></tr>";
				} else {
					for (var i = 0, ci; ci = data.data[i]; i++) {
						html += "<tr>";
						/*编号*/
						html += "<td><input type='checkbox' value=" + ci.product.productId + " name='orderIndexs' ></td>";
						/*子商品货号*/
						//html += "<td style='text-align:center;'>" + ((ci.product.goodsNo == "" || ci.product.goodsNo == null || ci.product.goodsNo == undefined) ? "&nbsp;" : ci.product.goodsNo) + "</td>";
						/*子商品名称*/
						html += "<td style='text-align:center;'>" + ((ci.product.internalName == "" || ci.product.internalName == null || ci.product.internalName == undefined) ? "&nbsp;" : ci.product.internalName) + "</td>";
						/*现价*/
						html += "<td style='text-align:center;'>" + ((ci.priceGv == "" || ci.priceGv == null || ci.priceGv == undefined) ? "&nbsp;" : ci.priceGv.price) + "</td>";
						/*市场价*/
						html += "<td style='text-align:center;'>" + ((ci.marketPrice == "" || ci.marketPrice == null || ci.marketPrice == undefined) ? "&nbsp;" : ci.marketPrice.price) + "</td>";
						/*成本价*/
						html += "<td style='text-align:center;'>" + ((ci.avergeCostPrice == "" || ci.avergeCostPrice == null || ci.avergeCostPrice == undefined) ? "&nbsp;" : ci.avergeCostPrice.price) + "</td>";
						/*规格*/
						html += "<td style='text-align:center;'>" + ((ci.features == "" || ci.features == null || ci.features == undefined) ? "&nbsp;" : ci.features) + "</td>";
						/*库存*/
						html += "<td style='text-align:center;'>" + ci.totalQuantityOrdered + "</td>";
						/*库存*/
						html += "<td style='text-align:center;'>" + ci.productInventory + "</td>";
						html += "<td><div><a  title='编辑子商品' class='btnEdit' href='"+ hrefstr + "?productId=" + ci.product.productId + "'>编辑</a></div></td>";
						html += "</tr>";
					}
				}
				html += "</table>";
				html += "</td></tr>";
				$(t).parents("tr").after(html);
				can = true;
				
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
									/* DWZ.debug(url);
									if (!url.isFinishedTm()) {
										alertMsg.error($this.attr("warn")
												|| DWZ.msg("alertSelectMsg"));
										return false;
									}
									navTab.openTab(tabid, url, {
										title : title,
										fresh : fresh,
										external : external
									}); */
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
//批量操作
$("#operate_batch").bind("click", function (event) {

	//页面中选中的checkbox
	var checkboxs = $("input:checked[type=checkbox][name=orderIndexs]");

	//所有搜索结果
	var operate = $("#operate")[0].value;
	if (checkboxs.length == 0) {
		alert("请选择要操作的商品");
		return;
	}
	if (operate == "") {
		alert("请选择操作项");
		return;
	}
	var propertys = "";
	for (var i = 0, ci; ci = checkboxs[i]; i++) {
		if (i > 0) {
			propertys += ",";
		}
		propertys += ci.value;
	}
	//上下架操作
	if (operate.indexOf("saleable") != -1) {
		jQuery.ajax({
        url: "updateProductSaleable",
        type: 'POST',
        data: {productIds : propertys,saleable : operate.split("_")[1]},
        error: function(msg) {
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
        },
        success: function(msg) {
			navTab.reload();
        }
    });
	}else if(operate.indexOf("inventory") != -1){
		//批量调整库存-toProductInventory 弹出库存调整dialog
		$.pdialog.open("toProductInventory?productIds="+propertys+"&productStoreId="+$("#productStoreId").val(), "toProductInventory", "库存调整", {mask:true,width:720,height:460});
	}
});
function inventory(){
	var checkboxs = $("input:checked[type=checkbox][name=orderIndexs]");
	var propertys;
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
	operEditDialog("toProductInventory?productIds="+propertys+"&productStoreId="+$("#productStoreId").val());
}
//批量删除
$("#delete_batch").bind("click", function (event) {

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
	    url: "deleteProductStatus",
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
//批量上架
function saleable(isYN){
	//页面中选中的checkbox
	var checkboxs = $("input:checked[type=checkbox][name=orderIndexs]");
	if (checkboxs.length == 0) {
		alert("请选择要操作的商品");
		return;
	}
	var propertys = "";
	for (var i = 0, ci; ci = checkboxs[i]; i++) {
		if (i > 0) {
			propertys += ",";
		}
		propertys += ci.value;
	}
	jQuery.ajax({
        url: "updateProductSaleable",
        type: 'POST',
        data: {productIds : propertys,saleable :isYN},
        error: function(msg) {
            showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
        },
        success: function(msg) {
			window.location.reload();
        }
        });
}

</script>