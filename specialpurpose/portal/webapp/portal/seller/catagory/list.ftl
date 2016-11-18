<div class="page-content">
    <div class="page-content-area">
        <div class="page-header">
            <h1>
                管理产品组
            </h1>
        </div>
        <div class="row">
            <div class="col-xs-12">

                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">产品组名称</label>

                        <div class="col-sm-9">
                            <input class="col-xs-10 col-sm-5" type="text" id="categoryName" name="categoryName" value="${(categoryName)!}" placeholder="输入产品组名称进行查询……">
                        </div>
                    </div>

                    <div class="col-md-offset-3 col-md-9">
                        <a href="<@ofbizUrl>editStoreCatagory</@ofbizUrl>"
                        <button class="btn btn-info" type="button">
                            新增
                        </button>
                        </a>
                        &nbsp; &nbsp; &nbsp;
                        <input  class="btn" type="submit" value="查询">
                            
                    </div>
                </form>

                <h3 class="header smaller lighter blue">
                    产品组列表
                </h3>

                <!-- <div class="table-responsive"> -->
                <!-- <div class="dataTables_borderWrap"> -->
                <div>
                    <div id="sample-table-2_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <table id="sample-table-2"
                               class="table-bordered"
                               role="grid" aria-describedby="sample-table-2_info">
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="">
                                    序号
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="">
                                    产品组
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    产品数量
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    创建时间
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    是否可见
                                </th>
                                <th class="" rowspan="1" colspan="1" aria-label="">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>

                            <#if topStoreCategoryList?has_content>
                                <#list topStoreCategoryList as category>
                                    <@categoryList parentCategoryId="" category=category wrapInBox="N"/>
                                </#list>
                            </#if>
                            <#macro categoryList parentCategoryId category wrapInBox>
                                <#assign gvCategory =category.getRelatedOne("CurrentProductCategory", true)>
                                <tr class="odd">
                                    <td>${(category.productCategoryId)!}</td>
                                    <td>${(gvCategory.categoryName)!}</td>
                                    <td></td>
                                    <td>${(gvCategory.createdStamp)!}</td>
                                    <td>是</td>
                                    <td>
                                        <div class="hidden-sm hidden-xs action-buttons">
                                            <a class="red" href="javascript:document.ListProductCategoryDeleteLink_${(category.productCategoryId)!}.submit()">
                                                <i class="ace-icon fa fa-trash-o bigger-130">
                                                </i>
                                            </a>
                    <form onsubmit="javascript:submitFormDisableSubmits(this)" method="post" name="ListProductCategoryDeleteLink_${(category.productCategoryId)!}" action="<@ofbizUrl>delStoreCatagory</@ofbizUrl>">
							<input name="productStoreId" value="${(category.productStoreId)!}" type="hidden">
							<input name="productCategoryId" value="${(category.productCategoryId)!}" type="hidden">
							<input name="prodCatalogCategoryTypeId" value="${(category.prodCatalogCategoryTypeId)!}" type="hidden">
							<input name="parentProductCategoryId" value="${(category.parentProductCategoryId)!}" type="hidden">
							<input name="fromDate" value="${(category.fromDate)!}" type="hidden">
							
								<input name="VIEW_INDEX_1" value="0" type="hidden">
								<input name="VIEW_SIZE_1" value="20" type="hidden">
					</form>          
                                        
                                        </div>
                                    </td>
                                </tr>
                                <#local secondCatList = Static["org.ofbiz.product.category.CategoryExtWorker"].getRelatedCategoriesRet(request, "secondCatList",productStoreId, category.getString("productCategoryId"), true)>
                                <#if secondCatList?has_content>
                                    <#list secondCatList as secondCat>
                                        <#assign findPftMap = Static["org.ofbiz.base.util.UtilMisc"].toMap("productCategoryId", secondCat.productCategoryId)>
                                        <#assign gvSecondCat =delegator.findOne("ProductCategory", findPftMap, true)>
                                        <tr class="odd">
                                            <td>${(secondCat.productCategoryId)!}</td>
                                            <td>${(gvSecondCat.categoryName)!}</td>
                                            <td></td>
                                            <td>${(gvSecondCat.createdStamp)!}</td>
                                            <td>是</td>
                                            <td>
                                                <div class="hidden-sm hidden-xs action-buttons">
                                                    <a class="red" href="javascript:document.ListProductCategoryDeleteLink_${(secondCat.productCategoryId)!}.submit()">
                                                        <i class="ace-icon fa fa-trash-o bigger-130">
                                                        </i>
                                                    </a>
                                                    
                                                    
                                                        <form onsubmit="javascript:submitFormDisableSubmits(this)" method="post" name="ListProductCategoryDeleteLink_${(secondCat.productCategoryId)!}" action="<@ofbizUrl>delStoreCatagory</@ofbizUrl>">
					<input name="productCategoryId" value="${(secondCat.productCategoryId)!}" type="hidden">
					<input name="productStoreId" value="${(productStoreId)!}" type="hidden">
						<input name="VIEW_INDEX_1" value="0" type="hidden">
						<input name="VIEW_SIZE_1" value="20" type="hidden">
				</form>
                                                </div>
                                            </td>
                                        </tr>
                                    </#list>
                                </#if>
                            </#macro>
                            <#--<tr role="row" class="even"></tr>-->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>