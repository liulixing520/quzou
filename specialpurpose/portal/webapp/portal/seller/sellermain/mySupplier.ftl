
<form id="pagerForm" method="post" action="FindProduct">
	<input type="hidden" name="status" >
	<input type="hidden" name="keywords"  />
	<input type="hidden" name="VIEW_INDEX_1" />
	<input type="hidden" name="VIEW_SIZE_1"  />
	<input type="hidden" name="sortField"  />
	<input type="hidden" name="sorterDirection"  />
	
</form>
<div class="content my_order">	
		<div class="search_area"><h3>已签约供应商</h3></div>
		<div class="search_area">
		<#if supperStoreList??>
			<#list supperStoreList as supper>
				
			</#list>
		</#if>	
		
		<table class="table-bordered" cellspacing="0" width="100%">
		<thead>
			<tr class='header-row'>
				<td style="text-align:center;">logo</td>
				<td style="text-align:center;">供应商名称</td>
				<td>操作</td>
			</tr>
		</thead>
		<tbody> 
		 <#if supperStoreList?has_content>
			<#list supperStoreList as supper>
		 	<tr>
				<td style="text-align:center;"><img src="<#if supper.productStoreLogo??>${supper.productStoreLogo!}</#if>" width="100px" height="100px"/></td>
				<td style="text-align:center;"><a  target='_blank'  href="<@ofbizUrl>tmall?productStoreId=${supper.supplierStoreId?if_exists}&dxStoreId=${supper.dxStoreId}</@ofbizUrl>">${supper.storeName!}</a></td>
				<td style="text-align:center;"><a  target='_blank'  href="<@ofbizUrl>tmall?productStoreId=${supper.supplierStoreId?if_exists}&dxStoreId=${supper.dxStoreId}</@ofbizUrl>">分销商品</a>
				<a href='<@ofbizUrl>mySupplierProtocol?supplierStoreId=${supper.supplierStoreId?if_exists}&dxStoreId=${supper.dxStoreId}</@ofbizUrl>'>查看协议</a></td>
			</tr>
		</#list>
		<#else>
			<tr><td colspan='2'>暂无签约信息</td></tr>
		</#if>	
		
			
		</tbody>
	</table>
		</div>
		<br>
		<div class="search_area"><h3>未签约供应商</h3></div>
	<div class="search_area">
		 <table>
				<tr>
					<td>
						<form   action="mySupplier" id="FindProductEn" method="post">
							<table class="searchContent">
								<tr>
									<td>
									           供应商名称：<input type="text" name="storeName" value='${queryStringMap.storeName!}'/>
										<input type="hidden" value="Y" name="storeName_ic">
										<input type="hidden" value="contains" name="storeName_op">
									</td>
									<td>&nbsp;&nbsp;&nbsp;&nbsp;
										<input class="btn btn-info" type="submit" value="查询">
									</td>
								</tr>
							</table>
						</form>
					
				</tr>
			</table>
		<div>
		</div>
	</div>
	<div>
   	<table class="table-bordered" cellspacing="0" >
		<thead>
			<tr class='header-row-2'>
				<td style="text-align:center;">logo</td>
				<td style="text-align:center;">分销商名称</td>
				<td>操作</td>
			</tr>
		</thead>
		<tbody> 
		 <#list productStoreList as ps>
		 	<tr>
				<td style="text-align:center;"><img src="<#if ps.productStoreLogo??>${ps.productStoreLogo!}</#if>" width="100px" height="100px"/></td>
				<td style="text-align:center;"><a class="blue"  target='_blank'  href="<@ofbizUrl>tmall?productStoreId=${ps.productStoreId?if_exists}&dxStoreId=${productStoreId}</@ofbizUrl>"><#if ps.storeName??>${ps.storeName?if_exists}</#if></a></td>
				<td style="text-align:center;"><a class="btn-mini"  href="<@ofbizUrl>mySupplierProtocol?supplierStoreId=${ps.productStoreId?if_exists}&dxStoreId=${productStoreId}</@ofbizUrl>">签约</a></td>
			</tr>
		 </#list>
			
		</tbody>
	</table>
	
	<#include "component://portal/webapp/portal/includes/sellerpagination.ftl"/>       
	<@paginationSimple  listSize viewSize viewIndex  'FindProductEn' 'FindProductEn' parameters.sortField!/>	
	</div>
</div>	
