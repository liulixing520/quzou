//跳转至下一页
	function setViewSize(size,searchFormId){
		$("#viewIndex").val(0);
		$("#viewSize").val(size);
		searchFormFun(searchFormId);
	}
	function toNextPageFunSimple(currentPage,searchFormId){
		$("#viewIndex").val(parseInt(currentPage)+1);
		searchFormFun(searchFormId);
	}
	function toPrevPageSimple(prePage,searchFormId){
		$("#viewIndex").val(prePage);
		searchFormFun(searchFormId);
	}
	function toFirstPageSimple(searchFormId){
		$("#viewIndex").val(0);
		searchFormFun(searchFormId);
	}
	function toLastSimple(lastPage,searchFormId){
		$("#viewIndex").val(lastPage);
		searchFormFun(searchFormId);
	}
	function sortSimpleFun(orderBy,searchFormId){
		$("#orderBy").val(orderBy);
		searchFormFun(searchFormId);
	}
