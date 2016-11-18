/*
*Js 时间操作 移动天，上几天，下几天/*

*参数说明
*【OperationDay】
*当前时间移动多少天，例如 正整数 就是 下几天 ，负整数就是 前几天
*【OperationDate】
*操作日期 可为空，如为空，就是当前时间。
*/
function DateOperationDay(OperationDay,OperationDate){
	var today="";
	if(OperationDate==""){
		today=new Date(); 
	} else {
		OperationDateArray=OperationDate.split("-");
		today=new Date(OperationDateArray[0],parseInt(OperationDateArray[1]-1),OperationDateArray[2]);
	}
	var TempDate_Milliseconds=today.getTime() + OperationDay*1000*60*60*24;
	var ResultDate = new Date();
	ResultDate.setTime(TempDate_Milliseconds);
	var ResultYear = ResultDate.getFullYear();
	var ResultMonth = ResultDate.getMonth() + 1;
	var ResultDay = ResultDate.getDate();
	if(ResultMonth<10){
		ResultMonth = "0" + ResultMonth;
	}
	if(ResultDay<10){
		ResultDay = "0" + ResultDay;
	}
	var ResultDateString = ResultYear + "-" + ResultMonth + "-" + ResultDay;
	return ResultDateString;
}
 
