	
<script type="text/javascript">
function submitFormDisableSubmits(form) {
    for (var i=0;i<form.length;i++) {
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
 $(function(){ 
		$(".breadcrumb").append("<li class='active'>网站管理</li><li class='active'>畅销商品设置</li><li class='active'>畅销设置列表</li>")
	}); 
</script>
<style type="text/css">

#navcontainer ul
{
padding-left: 0;
margin-left: 0;
background-color: #036;
color: White;
float: left;
font-family: arial, helvetica, sans-serif;
}
#navcontainer ul li { display: inline; }
#navcontainer ul li a
{
padding: 0.2em 1em;
background-color: #036;
color: White;
text-decoration: none;
float: left;
border-right: 1px solid #fff;
}
#navcontainer ul li a:hover
{
background-color: #369;
color: #fff;
}

</style>
<body background="../../images/allbg.gif" topMargin="8" leftMargin="8">
<div class="page-content">
    <div class="page-content-area">
    		<div id="navcontainer">
			<ul id="navlist">
			<li id="active_1" onclick="getTagId(this.id);"><a href="<@ofbizUrl>mng_Home_BestSellingProducts</@ofbizUrl>" _fcksavedurl="#" >添加畅销商品</a></li>
			<li id="active_2" onclick="getTagId(this.id);"><a href="<@ofbizUrl>mng_BestSellingList</@ofbizUrl>" _fcksavedurl="#" >查看首页畅销</a></li>
			</ul>
			</div><br/>
        <div class="page-header" style="height:60px;clear:both;">
            <h1 style="float:left; padding-top:8px;">
                首页设置畅销商品列表
            </h1>
        </div>

        <div class="row">
      <!--      <div class="col-xs-12">
                <form class="form-horizontal" role="form" method="post" action="<@ofbizUrl>mng_FindProductStoreByOne</@ofbizUrl>">
                    <div class="form-group" style="float:left;">
                        <label class="col-sm-2 control-label no-padding-right" style="width:80px; padding-top:10px;">店铺名称</label>

                        <div class="col-sm-9" style="width:400px;">
                            <input class="col-xs-10 col-sm-5" type="text" id="storeName" style="width:250px; margin-top:5px;" name="storeName" placeholder="输入店铺名称进行查询……" value="${(storeName)!}">
                             &nbsp; &nbsp; &nbsp;<input class="btn" type="submit" value=" 查询">
                        </div>
                    </div>

                </form>
                <div>  -->
                    <div id="sample-table-2_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <table id="sample-table-2"
                               class="table table-striped table-bordered table-hover dataTable no-footer"
                               role="grid" aria-describedby="sample-table-2_info" align="center">
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    畅销商品分类ID
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    商品ID
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    商品名称
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    商品中文名称
                                </th>

                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="" style="text-align:center;">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            
                            <tbody>
						 		<#if RecomBestSellingCategoryList?has_content>
						        <#list RecomBestSellingCategoryList as rsclist>
                                    <td align="center" style="text-align:center;vertical-align:inherit;">
                                    ${rsclist.productCategoryId?if_exists}
                                    </td>
                                     <td align="center" style="text-align:center;vertical-align:inherit;">
                                    ${rsclist.productId?if_exists}
                                    </td>
                                     <td align="center" style="text-align:center;vertical-align:inherit;">
                                    <#if rsclist.productId?has_content>
						            <#assign product = delegator.findOne("Product", {"productId" : rsclist.productId}, true)>
						            </#if>
                                    ${product.internalName?if_exists}
                                    </td>
                                     <td align="center" style="text-align:center;vertical-align:inherit;">
                                    ${product.productNameZh?if_exists}
                                    </td>
                                     <td style="text-align:center;vertical-align:inherit;">
                                     <div class="hidden-sm hidden-xs action-buttons" style="text-align:center;vertical-align:inherit;">
                                     <a class="red" href="javascript:document.ListProductCategoryBranddeleteLink_${(rsclist.productId)!}.submit()" title="移除"> <i class="ace-icon fa fa-trash-o bigger-130"></i> </a> 
                                     
                   <form onsubmit="javascript:submitFormDisableSubmits(this)" method="post" name="ListProductCategoryBranddeleteLink_${(rsclist.productId)!}" action="<@ofbizUrl>removeBestSellCategory</@ofbizUrl>">
					<input name="productId" value="${(rsclist.productId)!}" type="hidden">
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
</body>