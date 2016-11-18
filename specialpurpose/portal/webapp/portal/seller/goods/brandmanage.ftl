<script type="text/javascript">
    function submitFormDisableSubmits(form) {
        for (var i = 0; i < form.length; i++) {
            var formel = form.elements[i];
            if (formel.type == "submit") {
                submitFormDisableButton(formel);
                var formName = form.name;
                var formelName = formel.name;
                var timeoutString = "submitFormEnableButtonByName('" + formName + "', '" + formelName + "')";
                var t = setTimeout(timeoutString, 1500);
            }
        }
    }
</script>
<div class="page-content">
    <div class="page-content-area">
    <#--        <div class="page-header">
                <h1>
                    经营品牌
                </h1>
            </div>-->
        <div class="row">
            <div class="col-xs-12">

                <form class="form-horizontal" role="form" method="post" action="<@ofbizUrl>brandmanage</@ofbizUrl>">
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">品牌名称</label>

                        <div class="col-sm-9">
                            <input class="col-xs-10 col-sm-5" type="text" id="brandName" name="brandName"
                                   placeholder="输入产品组名称进行查询……" value="${(brandName)!}">
                            &nbsp; &nbsp; &nbsp;<input class="btn" type="submit" value=" 查询">
                        </div>
                    </div>

                </form>
                <div class="col-md-offset-3 col-md-9">
                    <a style="float:right;" href="<@ofbizUrl>createBrandmanage</@ofbizUrl>"
                    <button class="btn btn-info" type="button">
                        新增
                    </button>
                    </a>
                </div>

                <h3 class="header smaller lighter blue">
                    品牌列表
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
                                    品牌名称
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    品牌别名
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    描述
                                </th>
                            <#--              <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                                 colspan="1" aria-label="">
                       LOGO
                                             </th>
                                             -->
                                <th style="width:70px;" rowspan="1" colspan="1" aria-label="">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>

                            <#if productStoreBrandList?has_content>
                                <#list productStoreBrandList as brand>
                                <tr class="odd">
                                    <td>${(brand.productStoreBrandId)!}</td>
                                    <td>${(brand.brandName)!}</td>
                                    <td>${(brand.brandAlias)!}</td>
                                    <td>${(brand.brandIntroduction)!}</td>
                                <#--   <td>${(brand.brandLogoImage)!}</td> -->
                                    <td>
                                        <div class="hidden-sm hidden-xs action-buttons">
                                            <!--   <a class="blue" href="#"> <i class="ace-icon fa fa-search-plus bigger-130"></i> </a> -->
                                            <a class="green"
                                               href="<@ofbizUrl>createBrandmanage</@ofbizUrl>?productStoreBrandId=${(brand.productStoreBrandId)!}">
                                                <i class="ace-icon fa fa-pencil bigger-130"></i> </a>
                                            <a class="red"
                                               href="javascript:document.ListProductStoreBranddeleteLink_${(brand.productStoreBrandId)!}.submit()">
                                                <i class="ace-icon fa fa-trash-o bigger-130"></i> </a>

                                            <form onsubmit="javascript:submitFormDisableSubmits(this)" method="post"
                                                  name="ListProductStoreBranddeleteLink_${(brand.productStoreBrandId)!}"
                                                  action="<@ofbizUrl>storeRemoveBrand</@ofbizUrl>">
                                                <input name="productStoreId" value="${(brand.productStoreId)!}"
                                                       type="hidden">
                                                <input name="productStoreBrandId"
                                                       value="${(brand.productStoreBrandId)!}" type="hidden">
                                                <input name="VIEW_INDEX_1" value="0" type="hidden">
                                                <input name="VIEW_SIZE_1" value="20" type="hidden">
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                                </#list>
                            </#if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>