
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>目录管理 - EcManage</title>
<meta name="author" content="EcManage" />
<meta name="copyright" content="EcManage" />
<link href="/ofcupload/admin/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/ofcupload/admin/js/common.js"></script>
<script type="text/javascript" src="/ofcupload/admin/js/list.js"></script>
<script type="text/javascript">
$(document).ready(function() {

});
</script>
</head>
<body>
    <div class="path">
        <a href="main">首页</a> &raquo; 目录数据列表 <span>(共<span id="pageTotal">${listSize?default(0)}</span>条记录)</span>
    </div>
        <div class="bar">
            <a href="EditProdCatalog" class="iconButton disabled"><span class="addIcon">&nbsp;</span>添加</a>
        </div>
        <table id="listTable" class="list">
            <tr>
                <th class="check"><input type="checkbox" id="selectAll"/></th>
                <th><a href="javascript:;" class="sort" name="prodCatalogId">编码</a></th>
                <th><a href="javascript:;" class="sort" name="catalogName">名称</a></th>
                <th><a href="javascript:;" class="sort" name="useQuickAdd">是否快速添加</a></th>
                <th><span>操作</span></th>
            </tr>
            <#if listIt?has_content>
            <#list listIt as item>
            <tr>
                <td><input type="checkbox" name="CatalogId" value="${(item.prodCatalogId)!}" /></td>
                <td>${(item.prodCatalogId)!}</td>
                <td>${(item.catalogName)!}</td>
                <td>${(item.useQuickAdd)!}</td>
                <td>
                	<a class="button" href="EditProdCatalog?prodCatalogId=${item.prodCatalogId!}" ><span>[查看]</span></a>
                	<a class="button" href="FindProductCategory?prodCatalogId=${item.prodCatalogId!}" ><span>[分类管理]</span></a>
				</td>
            </tr>
            </#list>
            </#if>
        </table>
         <#import "component://gbsm/webapp/gbsm/includes/button.ftl" as p> 
		 <@p.pagination paginationUrl="FindProdCatalog" listSize=listSize/>
       
</body>
</html>