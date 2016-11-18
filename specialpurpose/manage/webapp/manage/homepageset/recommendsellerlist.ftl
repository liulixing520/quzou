	
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
		$(".breadcrumb").append("<li class='active'>网站管理</li><li class='active'>推荐卖家设置</li><li class='active'>推荐卖家列表</li>")
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
			<li id="active_1" onclick="getTagId(this.id);"><a href="<@ofbizUrl>mng_Home_recommendSeller</@ofbizUrl>" _fcksavedurl="#" >卖家店铺</a></li>
			<li id="active_2" onclick="getTagId(this.id);"><a href="<@ofbizUrl>mng_RecommendSellerList</@ofbizUrl>" _fcksavedurl="#" >推荐卖家</a></li>
			</ul>
			</div><br/>

        <div class="row">
            <div class="col-xs-12">
            	<#--
                <form class="form-horizontal" role="form" method="post" action="<@ofbizUrl>mng_FindProductStoreByOne</@ofbizUrl>">
                    <div class="form-group" style="float:left;">
                        <label class="col-sm-2 control-label no-padding-right" style="width:80px; padding-top:10px;">店铺名称</label>

                        <div class="col-sm-9" style="width:400px;">
                            <input class="col-xs-10 col-sm-5" type="text" id="storeName" style="width:250px; margin-top:5px;" name="storeName" placeholder="输入店铺名称进行查询……" value="${(storeName)!}">
                             &nbsp; &nbsp; &nbsp;<input class="btn" type="submit" value=" 查询">
                        </div>
                    </div>

                </form>
                -->
                <div>  
                    <div id="sample-table-2_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <table id="sample-table-2"
                               class="table table-striped table-bordered table-hover dataTable no-footer"
                               role="grid" aria-describedby="sample-table-2_info" align="center">
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    卖家店铺ID
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    卖家店铺名称
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="" style="text-align:center;">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            
                            <tbody>
						 		<#if RecommendSellersList?has_content>
						        <#list RecommendSellersList as recommendseller>
                                    <td align="center" style="text-align:center;vertical-align:inherit;">
                                     <#if (recommendseller.productStoreId)!?length gt 30>${(recommendseller.productStoreId[0..30])?if_exists}..<#else>${recommendseller.productStoreId?if_exists}</#if>
                                    </td>
                                    <td align="center" style="text-align:center;vertical-align:inherit;">
                                     <#assign productcategory = delegator.findOne("ProductStore", {"productStoreId" : recommendseller.productStoreId}, true)>
                                     <#if (productcategory.storeName)!?length gt 30>${(productcategory.storeName[0..30])?if_exists}..<#else>${productcategory.storeName?if_exists}</#if>
                                    </td>
                                     <td style="text-align:center;vertical-align:inherit;">
                                     <div class="hidden-sm hidden-xs action-buttons" style="text-align:center;vertical-align:inherit;">
                                     <a class="red" href="javascript:document.ListProductStoreBranddeleteLink_${(recommendseller.recommendedSellerId)!}.submit()" title="移除"> <i class="ace-icon fa fa-trash-o bigger-130"></i> </a> 
                                     
                   <form onsubmit="javascript:submitFormDisableSubmits(this)" method="post" name="ListProductStoreBranddeleteLink_${(recommendseller.recommendedSellerId)!}" action="<@ofbizUrl>removeRecommendSeller</@ofbizUrl>">
					<input name="recommendedSellerId" value="${(recommendseller.recommendedSellerId)!}" type="hidden">
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