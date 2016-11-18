
<#macro showPage requestUrl1 requestUrl2 listSize viewSize viewIndex  isAuth noConditionFind="Y">
<#assign x=Static["java.lang.Math"].ceil(listSize/viewSize)>
<#if listSize gt (x*viewSize)><#assign x=x></#if>
<script type="text/javascript" src="../images/kkpager/kkpager.min.js"></script>
<link rel="stylesheet" type="text/css" href="../images/kkpager/kkpager.css" />
<div id="kkpager"></div>

<script type="text/javascript">
function getParameter(name) { 
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); 
	var r = window.location.search.substr(1).match(reg); 
	if (r!=null) return unescape(r[2]); return null;
}

$(function(){
	var totalPage = ${(x)!};
	var totalRecords = ${(listSize)!};
	pageNo = ${(viewIndex)!};
	//生成分页
	//有些参数是可选的，比如lang，若不传有默认值
	kkpager.generPageHtml({
		pno : pageNo,
		//总页码
		total : totalPage,
		//总数据条数
		totalRecords : totalRecords,
		//链接前部
		hrefFormer : '${(requestUrl1)!}',
		//链接尾部
		hrefLatter : '${(requestUrl2)!}',
		getLink : function(n){
			<#if isAuth==true>
			 return this.hrefFormer + this.hrefLatter + "&VIEW_INDEX=" + n;	//view ?xxx=xxx &VIEW_INDEX_1= 1
			<#else>
			 return this.hrefFormer + '-' + n + this.hrefLatter; // view-xx -1.html
			</#if>
		}
		,lang : {
			firstPageText : '首页',
			lastPageText : '尾页',
			prePageText : '上一页',
			nextPageText : '下一页',
			totalPageBeforeText : '共',
			totalPageAfterText : '页',
			totalRecordsAfterText : '条数据',
			gopageBeforeText : '转到',
			gopageButtonOkText : '确定',
			gopageAfterText : '&nbsp;&nbsp;页',
			buttonTipBeforeText : '第',
			buttonTipAfterText : '页'
		}
	});
});
</script>
</#macro>


<#macro showPageAjax requestUrl1 requestUrl2 listSize viewSize viewIndex  isAuth replaceDiv noConditionFind="Y">
<#assign x=Static["java.lang.Math"].ceil(listSize/viewSize)>
<#if listSize gt (x*viewSize)><#assign x=x></#if>
<script type="text/javascript" src="../images/kkpager/kkpager.min.js"></script>
<script type="text/javascript" src="/images/js/selectall.js"></script>
<link rel="stylesheet" type="text/css" href="../images/kkpager/kkpager.css" />
<div id="kkpager"></div>

<script type="text/javascript">
function getParameter(name) { 
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); 
	var r = window.location.search.substr(1).match(reg); 
	if (r!=null) return unescape(r[2]); return null;
}

$(function(){
	var totalPage = ${(x)!};
	var totalRecords = ${(listSize)!};
	pageNo = ${(viewIndex)!};
	//生成分页
	//有些参数是可选的，比如lang，若不传有默认值
	kkpager.generPageHtml({
		pno : pageNo,
		//总页码
		total : totalPage,
		mode : 'click', //设置为click模式
		//总数据条数
		totalRecords : totalRecords,
		//链接前部
		hrefFormer : '${(requestUrl1)!}',
		//链接尾部
		hrefLatter : '${(requestUrl2)!}',
		click:function(n){
			<#if isAuth==true>
			 ajaxUpdateArea('${replaceDiv}',this.hrefFormer + this.hrefLatter + "&VIEW_INDEX=" + n);	//view ?xxx=xxx &VIEW_INDEX_1= 1
			<#else>
			 ajaxUpdateArea('${replaceDiv}',this.hrefFormer + '-' + n + this.hrefLatter); // view-xx -1.html
			</#if>
		}
		,lang : {
			firstPageText : '首页',
			lastPageText : '尾页',
			prePageText : '上一页',
			nextPageText : '下一页',
			totalPageBeforeText : '共',
			totalPageAfterText : '页',
			totalRecordsAfterText : '条数据',
			gopageBeforeText : '转到',
			gopageButtonOkText : '确定',
			gopageAfterText : '&nbsp;&nbsp;页',
			buttonTipBeforeText : '第',
			buttonTipAfterText : '页'
		}
	});
});
</script>
</#macro>
