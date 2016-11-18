<script src="/portal/images/js/jquery.pagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="/portal/images/css/pagination.css" type="text/css"/>
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
		$(".breadcrumb").append("<li class='active'>网站管理</li><li class='active'>推荐品类设置</li><li class='active'>分类列表</li>")
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
<style type="text/css">
    .nav-tabs li {
        list-style: none;
    }

    .nav-tabs li.current a {
        background: #b3d9ff;
        color: #000;
        font-weight: bold;
    }
</style>
<script type="text/javascript">
    $(function () {
        startId = $("#orderStatus").val();
        $("li").remove(".current");
        if (startId == "") {
            $("#li1").attr("class", "current");
        } else {
            $("#" + startId).attr("class", "current");
        }
        function pageselectCallback(page_id, jq) {
            //alert(page_id); 回调函数，进一步使用请参阅说明文档
            //TranUrl(page_id);
        }

        $("#Pagination").pagination("${listSize}", {
            callback: pageselectCallback,//PageCallback() 为翻页调用次函数。
            prev_text: " 上一页",
            next_text: "下一页 ",
            items_per_page: 10, //每页的数据个数
            num_display_entries: 4, //两侧首尾分页条目数
            current_page: "${viewIndex}",   //当前页码
            num_edge_entries: 2, //连续分页主体部分分页条目数
            link_to: "?page=__id__"
        });
        function TranUrl(page_id) {
            var url = location.href;
            //var startOrderDate=$("#start_order_time").val();
            //var endOrderDate=$("#end_order_time").val();
            var statusId = $("#orderStatus").val();
            if (statusId.length > 0) {
                url = url + "statusId=" + statusId
            }
            location.href = url + "&page=" + page_id;
        }
    })

</script>
<body background="../../images/allbg.gif" topMargin="8" leftMargin="8">
<div class="page-content">
    <div class="page-content-area">
        	<div id="navcontainer">
			<ul id="navlist">
			<li id="active_1" onclick="getTagId(this.id);"><a href="<@ofbizUrl>mng_Home_recommendCategory</@ofbizUrl>" _fcksavedurl="#" >商品品类</a></li>
			<li id="active_2" onclick="getTagId(this.id);"><a href="<@ofbizUrl>mng_RecommendCategoryList</@ofbizUrl>" _fcksavedurl="#" >推荐品类</a></li>
			</ul>
			</div><br/>

        <div class="row">
            <div class="col-xs-12">
                <form class="form-horizontal" role="form" method="post" action="<@ofbizUrl>mng_FindCategoryByOne</@ofbizUrl>">
                    <div class="form-group" style="float:left;">
                        <label class="col-sm-2 control-label no-padding-right" style="width:80px; padding-top:10px;">品类ID</label>

                        <div class="col-sm-9" style="width:400px;">
                            <input class="col-xs-10 col-sm-5" type="text" id="productCategoryId" style="width:250px; margin-top:5px;" name="productCategoryId" placeholder="输入品类ID进行查询……" value="${(productCategoryId)!}">
                            &nbsp; &nbsp; &nbsp;<input class="btn" type="submit" value=" 查询">  
                        </div>
                    <#--    <label class="col-sm-2 control-label no-padding-right" style="width:80px; padding-top:10px;">品类名称</label>

                        <div class="col-sm-9" style="width:400px;">
                            <input class="col-xs-10 col-sm-5" type="text" id="catedgoryName" style="width:250px; margin-top:5px;" name="catedgoryName" placeholder="输入品类名称进行查询……" value="${(catedgoryName)!}">
                             &nbsp; &nbsp; &nbsp;<input class="btn" type="submit" value=" 查询">
                        </div>-->
                    </div>

                </form>
                <div>
                    <div id="sample-table-2_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <table id="sample-table-2"
                               class="table table-striped table-bordered table-hover dataTable no-footer"
                               role="grid" aria-describedby="sample-table-2_info" align="center">
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                  分类ID
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                  分类名称
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="" style="text-align:center;">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            
                            <tbody>
						 		<#if orderHeaderList?has_content>
						        <#list orderHeaderList as productCategory>
                                    <td align="center" style="text-align:center;vertical-align:inherit;">
                                     <#if (productCategory.productCategoryId)!?length gt 30>${(productCategory.productCategoryId[0..30])?if_exists}..<#else>${productCategory.productCategoryId?if_exists}</#if>
                                    </td>
                                    <td align="center" style="text-align:center;vertical-align:inherit;">
                                    <#assign productcategory = delegator.findOne("ProductCategory", {"productCategoryId" : productCategory.productCategoryId}, true)>
                                    ${productcategory.categoryName!}
                                    </td>
                                     <td style="text-align:center;vertical-align:inherit;">
                                     <div class="hidden-sm hidden-xs action-buttons" style="text-align:center;vertical-align:inherit;">
                                     <a class="green" href="<@ofbizUrl>mng_addCategoryToHomePage</@ofbizUrl>?productCategoryId=${(productCategory.productCategoryId)!}" title="添加"> <i class="ace-icon fa fa-pencil bigger-130"></i> </a>
                                     </div>
                                    </td>
                                </tr>
                                </#list>
        </#if>	
                            </tbody>
                        </table>
                        <div id="Pagination" class="flickr"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>
</body>