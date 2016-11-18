//订单基础验证js


//是否为空验证,true 为空；false 不为空 
function checkNull(textId){ 
	var cValue = $("#"+textId).val();
	if(cValue == '') return true;
	else return false;
}

//判断是否是英文，不是英文则返回false
function checkEng(str)
{
	//alert(str)
	var len;
    var i;
    len = 0;
    for (i=0;i<str.length;i++){
		if (str.charCodeAt(i)>255){
			return false;
		}
    }
    return true;
} 

//判断是否是英文，不是英文则返回true
function checkNoEng(str)
{
	//alert(str)
	var len;
    var i;
    len = 0;
    for (i=0;i<str.length;i++){
        //alert(str.charCodeAt(i));
		if (str.charCodeAt(i)>64){
			return false;
		}
    }
    return true;
} 


//判断是否是整数
 function isInt_d(textId){
	var s = $("#"+textId).val();
	var patrn =/^([1-9]\d+|[1-9])(\.\d\d?)*$/;
	if (!patrn.exec(s))return false;
	else return true;
 }
	  
//验证字符串长度是否超过限制。超过 true；不超过 false
function checkStrLength(textId , limitLength){ 
	var cValue = $("#"+textId).val().length;
	if(cValue > limitLength) return ture;
	else return false; 
}

//英文验证 是英文 true； 不是英文 false
function checkEnglish(textId){ 
	var cValue = $("#"+textId).val();

	var reg = /[\u4e00-\u9fa5]/ig;
	if(reg.test(cValue))return false;
	else return ture;
};

//中文验证
function checkChinese(textId , notice){ }

//金额验证 ture 正确； false 错误
function checkMoney(textId){ 
	var val = $("#"+textId).val();
	var valv = parseFloat(val,10);
	valv = Math.round(val*100)/100;
	if (val != valv) return false;

	return true;

}

//邮箱验证
function checkEmail(textId , notice){ }

//手机验证
function checkMobil(textId , notice){ }

//邮编验证
function checkPostcode(textId , notice){ }

//数字验证
function checkNumber(textId , notice){ }

