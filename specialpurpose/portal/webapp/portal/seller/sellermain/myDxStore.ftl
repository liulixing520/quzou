
<form id="pagerForm" method="post" action="FindProduct">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	
</form>
<div class="content my_order">
	<h3 class="title" style='font-size:20px'>我的代理商</h3>
	<div class="search_area">
		 <table>
				<tr>
					<td>
						<form   action="FindProductEn" id="FindProductEn" method="post">
							<table class="searchContent">
								<tr>
									<td>
									           代理商名称：<input type="text" name="productName" value='${queryStringMap.productStoreName!}'/>
										<input type="hidden" value="Y" name="productName_ic">
										<input type="hidden" value="contains" name="productName_op">
									</td>
									<td>&nbsp;&nbsp;&nbsp;&nbsp;
										<input class="btn btn-info" type="submit" value="查询">
									</td>
								</tr>
							</table>
						</form>
					
				</tr>
			</table>
		
	</div>
	<div>
   	<table class="table-bordered" cellspacing="0" width="100%">
		<thead>
			<tr class='header-row-2'>
				<td style="text-align:center;">图片</td>
				<td style="text-align:center;">供应商名称</td>
				<td style="text-align:center;">是否签约</td>
				<td>操作</td>
			</tr>
		</thead>
		<tbody> 
		 <#list productStoreList as ps>
		 	<tr>
				<td style="text-align:center;"><img src="<#if ps.productStoreLogo??>${ps.productStoreLogo!}</#if>" width="100px" height="100px"/></td>
				<td style="text-align:center;"><a  target='_blank'  href="<@ofbizUrl>tmall?productStoreId=${ps.productStoreId?if_exists}&dxStoreId=${productStoreId}</@ofbizUrl>"><#if ps.storeName??>${ps.storeName?if_exists}</#if></a></td>
				<td style="text-align:center;">否</td>
				<td style="text-align:center;"><a  href="<@ofbizUrl>mySupplierProtocol?productStoreId=${ps.productStoreId?if_exists}&dxStoreId=${productStoreId}</@ofbizUrl>">签约</a></td>
			</tr>
		 </#list>
			
		</tbody>
	</table>
	
</div>
<#include "component://portal/webapp/portal/includes/sellerpagination.ftl"/>      
<@paginationSimple  listSize viewSize viewIndex  'FindProductEn' 'FindProductEn' parameters.sortField!/>	
</div>
