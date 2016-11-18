<#assign actionUrlStr="createStoreCatagory">
<#if productStore?has_content>
    <#assign actionUrlStr="updateStoreCatagory">
</#if>

<div class="page-content">
    <div class="page-content-area">
        <div class="page-header"><h1>维护产品组</h1></div>
        <div class="row">
            <div class="col-xs-12">
                <form class="form-horizontal" role="form" id="EditStoreCatagory" name="EditStoreCatagory"
                      method="get"
                      action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>"
                      onsubmit="javascript:submitFormDisableSubmits(this)" novalidate="novalidate">
                    <input type="hidden" name="productStoreId" id="productStoreId" value="${productStoreId}"/>
                    <input type="hidden" name="productCategoryTypeId" id="productCategoryTypeId" value="STORECAT_CATEGORY" />
                    <input type="hidden" name="prodCatalogCategoryTypeId" id="prodCatalogCategoryTypeId" value="PCCT_BROWSE_ROOT" />
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">产品组名称</label>

                        <div class="col-sm-4">
                            <input class="form-control" type="text" id="categoryName" name="categoryName" placeholder="">
                        </div>
                    </div>
                    <div class="space-4"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">上级分类</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="primaryParentCategoryId" name="primaryParentCategoryId">
                                <option value=""></option>
                                <#if topStoreCategoryList?has_content>
                                    <#list topStoreCategoryList as category>
                                        <@categoryList parentCategoryId="" category=category wrapInBox="N"/>
                                   
                                <#macro categoryList parentCategoryId category wrapInBox>
                                    <#assign gvCategory =category.getRelatedOne("CurrentProductCategory", true)>
                                    <option value="${category.productCategoryId}">${(gvCategory.categoryName)!}</option>
                                </#macro>
                                 </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                    <div class="space-4"></div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">描述</label>
                        <div class="col-sm-9">
                            <textarea class="form-control limited" id="description" name="description" maxlength="50" style="margin: 0px -0.015625px 0px 0px; height: 52px; width: 450px;"></textarea>
                        </div>
                    </div>
                    <div class="col-md-offset-3 col-md-9">
                        <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                        &nbsp; &nbsp; &nbsp;
                        <a href="<@ofbizUrl>listSellerCatagory</@ofbizUrl>"
                        <button class="btn" type="button">取消</button>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>