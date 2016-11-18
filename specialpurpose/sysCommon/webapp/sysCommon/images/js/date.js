/**日期工具**/
//对Date的扩展，将 Date 转化为指定格式的String 
//月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
//年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
//例子： 
//(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
//(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function(fmt){ 
	var o = { 
	 "M+" : this.getMonth()+1,                 //月份 
	 "d+" : this.getDate(),                    //日 
	 "h+" : this.getHours(),                   //小时 
	 "m+" : this.getMinutes(),                 //分 
	 "s+" : this.getSeconds(),                 //秒 
	 "q+" : Math.floor((this.getMonth()+3)/3), //季度 
	 "S"  : this.getMilliseconds()             //毫秒 
	}; 
	if(/(y+)/.test(fmt)) 
	 fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	for(var k in o) 
	 if(new RegExp("("+ k +")").test(fmt)) 
	fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
	return fmt; 
}
/**
 * 将当前日期设置为指定的文本框ID
 * **/
function setNowDateToId(id){
	$("#"+id).attr("value",(new Date()).Format("yyyy-MM-dd"));
}
/**
 * 在某时间上增加days天并赋给指定的文本框ID
 * days:天数
 */
function addDaysToId(oldDate,id,days){
	var year = oldDate.split("-")[0];
	var month = oldDate.split("-")[1]-1;
	//parseInt(oldDate.split("-")[1])-1;
	var day = oldDate.split("-")[2];
	var newDate = new Date(year,month,day);
	newDate = newDate.valueOf();
	newDate = newDate+days*24*60*60*1000;
	$("#"+id).attr("value",(new Date(newDate)).Format("yyyy-MM-dd"));
}
/**
 * 在某时间上增加monthNum月并赋给指定的文本框ID
 * monthNum:月数
 */
function addModthToId(oldDate,id,monthNum){
	var year = oldDate.split("-")[0];
	var month =oldDate.split("-")[1]-1;
	//parseInt(oldDate.split("-")[1]);
	var day = oldDate.split("-")[2];
	var newDate = new Date(year,month,day);
	newDate.setMonth(parseInt(newDate.getMonth())+parseInt(monthNum)); 
	newDate.setDate(parseInt(newDate.getDate())-1); 
	$("#"+id).attr("value",(new Date(newDate)).Format("yyyy-MM-dd"));
}
