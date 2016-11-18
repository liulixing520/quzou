//<script type="text/javascript">

//为string增加Trim方法
String.prototype.Trim=function(){return this.replace(/(^\s+|\s+$)/g,"")};

String.prototype.format = function()
{
    var args = arguments;
    return this.replace(/\{(\d+)\}/g,              
        function(m,i){
            return args[i];
    });
} 

//将全角中文字符转为英文半角字符
function replaceZhToEn(str){
	//空值及字符串不处理	
	if(null ==str || "" == str.Trim())return str;
	
	str = str.replace(/！/g,"!");
	str = str.replace(/◎/g,"@");
	str = str.replace(/＃/g,"#");
	str = str.replace(/￥/g,"$");
	str = str.replace(/％/g,"%");
	str = str.replace(/……/g,"^");
	str = str.replace(/—/g,"&");
	str = str.replace(/×/g,"*");
	str = str.replace(/（/g,"(");
	str = str.replace(/）/g,")");
	str = str.replace(/－/g,"-");
	str = str.replace(/＋/g,"+");
	str = str.replace(/÷/g,"/");
	str = str.replace(/§/g,"|");
	str = str.replace(/。/g,".");
	str = str.replace(/，/g,",");
	str = str.replace(/《/g,"<");
	str = str.replace(/》/g,">");
	str = str.replace(/？/g,"?");
	str = str.replace(/～/g,"~");
	str = str.replace(/“/g,"\"");
	str = str.replace(/；/g,";");
	str = str.replace(/：/g,":");
	str = str.replace(/‘/g,"'");
	str = str.replace(/【/g,"[");
	str = str.replace(/】/g,"]");
	str = str.replace(/『/g,"{");
	str = str.replace(/』/g,"}");
	str = str.replace(/·/g,"`");

	str = str.replace(/！/g,"!");
	str = str.replace(/＠/g,"@");
	str = str.replace(/＃/g,"#");
	str = str.replace(/￥/g,"$");
	str = str.replace(/％/g,"%");
	str = str.replace(/＾/g,"^");
	str = str.replace(/＆/g,"&");
	//str = str.replace(/*/g,"");
	str = str.replace(/（/g,"(");
	str = str.replace(/）/g,")");
	str = str.replace(/＿/g,"_");
	str = str.replace(/－/g,"-");
	str = str.replace(/＋/g,"+");
	str = str.replace(/＝/g,"=");
	str = str.replace(/＼/g,"\\");
	str = str.replace(/｜/g,"|");
	str = str.replace(/ａ/g,"a");
	str = str.replace(/ｂ/g,"b");
	str = str.replace(/ｃ/g,"c");
	str = str.replace(/ｄ/g,"d");
	str = str.replace(/ｅ/g,"e");
	str = str.replace(/ｆ/g,"f");
	str = str.replace(/ｇ/g,"g");
	str = str.replace(/ｈ/g,"h");
	str = str.replace(/ｉ/g,"i");
	str = str.replace(/ｊ/g,"j");
	str = str.replace(/ｋ/g,"k");
	str = str.replace(/ｌ/g,"l");
	str = str.replace(/ｍ/g,"m");
	str = str.replace(/ｎ/g,"n");
	str = str.replace(/ｏ/g,"o");
	str = str.replace(/ｐ/g,"p");
	str = str.replace(/ｑ/g,"q");
	str = str.replace(/ｒ/g,"r");
	str = str.replace(/ｓ/g,"s");
	str = str.replace(/ｔ/g,"t");
	str = str.replace(/ｕ/g,"u");
	str = str.replace(/ｖ/g,"v");
	str = str.replace(/ｗ/g,"w");
	str = str.replace(/ｘ/g,"x");
	str = str.replace(/ｙ/g,"y");
	str = str.replace(/ｚ/g,"z");
	str = str.replace(/Ａ/g,"A");
	str = str.replace(/Ｂ/g,"B");
	str = str.replace(/Ｃ/g,"C");
	str = str.replace(/Ｄ/g,"D");
	str = str.replace(/Ｅ/g,"E");
	str = str.replace(/Ｆ/g,"F");
	str = str.replace(/Ｇ/g,"G");
	str = str.replace(/Ｈ/g,"H");
	str = str.replace(/Ｉ/g,"I");
	str = str.replace(/Ｊ/g,"J");
	str = str.replace(/Ｋ/g,"K");
	str = str.replace(/Ｌ/g,"L");
	str = str.replace(/Ｍ/g,"M");
	str = str.replace(/Ｎ/g,"N");
	str = str.replace(/Ｏ/g,"O");
	str = str.replace(/Ｐ/g,"P");
	str = str.replace(/Ｑ/g,"Q");
	str = str.replace(/Ｒ/g,"R");
	str = str.replace(/Ｓ/g,"S");
	str = str.replace(/Ｔ/g,"T");
	str = str.replace(/Ｕ/g,"U");
	str = str.replace(/Ｖ/g,"V");
	str = str.replace(/Ｗ/g,"W");
	str = str.replace(/Ｘ/g,"X");
	str = str.replace(/Ｙ/g,"Y");
	str = str.replace(/Ｚ/g,"Z");
	str = str.replace(/［/g,"[");
	str = str.replace(/］/g,"]");
	str = str.replace(/｛/g,"{");
	str = str.replace(/｝/g,"}");
	str = str.replace(/：/g,":");
	str = str.replace(/；/g,";");
	str = str.replace(/＂/g,"\"");
	str = str.replace(/＇/g,"'");
	str = str.replace(/？/g,"?");
	str = str.replace(/／/g,"/");
	str = str.replace(/．/g,".");
	str = str.replace(/，/g,",");
	str = str.replace(/＞/g,">");
	str = str.replace(/＜/g,"<");
	str = str.replace(/｀/g,"`");
	str = str.replace(/～/g,"~");
	str = str.replace(/１/g,"1");
	str = str.replace(/２/g,"2");
	str = str.replace(/３/g,"3");
	str = str.replace(/４/g,"4");
	str = str.replace(/５/g,"5");
	str = str.replace(/６/g,"6");
	str = str.replace(/７/g,"7");
	str = str.replace(/８/g,"8");
	str = str.replace(/９/g,"9");
	str = str.replace(/０/g,"0");
	str = str.replace(/　/g," ");

	return str;
}
//做大陆身份证验证，15-18位，年份段限制为1939-2000年期间
function validateIdcard(strVal) {
	if(strVal==null)return false;
	
	strVal = strVal.toUpperCase();
    // 身份证验证长度验证
    if(strVal.length != 18 && strVal.length != 15 && strVal.length != 11 && strVal.length != 10) {     
        return false;
    }   
    if (strVal.length == 15 || strVal.length == 18){
    	//中国大陆身份证验证    	  
    	//身份证地区编号
    	var areaCityList = { 11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",
    				21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",
    				33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",
    				41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",
    				46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",
    				54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",
    				65:" 新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"}; 	
    	//如湖北武汉市江岸区1975-12-31生辰男：15位- 420102 751231 215 ；18位 - 420102 19751231 2115 或 420102 19751231 211x 
    				
	    var strBirthday = "1900/01/01";
    	if(strVal.length == 15){    		
	    	var isIDCard15=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
		   	if(!isIDCard15.test(strVal)) {
		   		 return false;
		   	}
		   	strBirthday = "19" + strVal.substr(6,2)+"/" + strVal.substr(8,2)+"/"+strVal.substr(10,2);
	   	}else{	   		
	    	var isIDCard18=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])(\d{4}|\d{3}X)$/;
		   	if(!isIDCard18.test(strVal)) {
		   		 return false;
		   	}		   
		    strBirthday = strVal.substr(6,4)+ "/"+ strVal.substr(10,2)+"/"+ strVal.substr(12,2);
	   	}  
	   	//生日校验
	   	var dBirthday = new Date(strBirthday);
	   	var bmonth = dBirthday.getMonth()+1 ;
	   	if(bmonth < 10) bmonth= ""+"0"+ bmonth;	   	
	   	
	   	var bday = dBirthday.getDate();
	   	if(bday<10)bday = "" +"0"+bday;
	   	
		if( strBirthday != (dBirthday.getFullYear()+"/"+ bmonth + "/" + bday ) ){
			return false; 
		}
		//出生日期在1939年到2000年之间。	   
	    if ( dBirthday < new Date("1939/01/01") || dBirthday > new Date("1999/12/31")) {
	    	return false;
	    }	
	    //地区校验   	
    }else if (strVal.length == 10 || strVal.length == 11) {
    	//香港的身份证 
		//身份证号码的结构，可以用XYabcdef(z)表示。「X」可能是「空格」或是一个英文字母，「Y」则必定是英文字母。
		//「abcdef」代表一个六位数字，而「z」是作为检码之用，它的可能选择是0,1,2,...,9,A(代表10)。
    	var patn = new RegExp("^[A-Za-z]{1,2}[0-9]{6}[(][0-9aA][)]+$");
	   	if(patn.test(strVal)) { 
	   		return true;
	   	}
	   	//1.	台湾身份证总共有10位数字。第一位是字母。后面九位是数字。 台湾省份证的第一位的字母代表地区分别以A——Z表示
	   	//2.	第二位数字代表性别 男性是1，女性是2
	   	//3.	第三位到第九位为任意的一串数字
	   	//4.	第十位为验证码。 第十位数字

	   	var patn1 = new RegExp("^[A-Za-z]{1}[1-2]{1}[0-9]{8}$");
	   	if(patn1.test(strVal)) { 
	   		return true;
	   	}
	   	return false;
    }
	
	return true;
}

function checkImg(oInp){
	if(oInp == null) return false;
	var sValue = oInp.value;
	if(sValue == null || sValue=="")return false;
	//获取文件扩展名
	var bRightName = true;
	var iPos = sValue.lastIndexOf("."); 
	if(iPos < 0){
		bRightName = false;
	}else{
		var imgType = sValue.substr(iPos+1).toUpperCase();
		if(imgType == "" || (imgType != "JPG" && imgType != "GIF" && imgType != "JPEG") ){				
			bRightName = false;
		}
	}
	if(!bRightName){
		alert("你选择的文件格式错误,只允许选择jpg,jpeg,gif文件!");		
		return false;
	}
	/*
	//文件大小、尺寸检测, 由于安全的原因此段code无效
	var img = new Image();
	if (document.layers
		&& location.protocol.toLowerCase() != 'file:'
		&& navigator.javaEnabled()){		
		netscape.security.PrivilegeManager.enablePrivilege('UniversalFileRead');
	}
	img.src = "file:///" + sValue;
	if( !isNaN(parseInt(img.fileSize))){
		if(parseInt(img.fileSize) > 143360){ //fileSize > 200k
			alert("你选择的文件大小超过200K, 请检查!");
			
			return false;
		}
	}
	if( img.width <250 || img.height< 250 || img.width > 500 || img.height> 500 ){
		alert("图片大小不能大于500*500, 请检查!");
		return false;
	}
	*/	 
	return true;     
}

//显示input剩余字符长度
function showResLen(oInput, iMaxLen){
	var bRet = false;
	if(oInput == null){
		alert("要查询剩余输入字符的对象为空，请检查！");
		return bRet;
	} 
	var iMax = parseInt(iMaxLen);
	if( isNaN(iMax) || iMax <= 0){
		alert("最大输入字节数不正确，请检查！");
		return bRet;
	}
	isInputEle(oInput);
	var sValue = "";
	var sTagName = oInput.tagName.toUpperCase();
	if( sTagName == "INPUT" || sTagName == "TEXTAREA"){
		sValue = oInput.value;
	}else {
		alert("要查询剩余输入字符的对象不是可编辑对象，请检查！");
		return bRet;
	}
		
	var iRLen = iMaxLen - sValue.length;
	var oTipPanel = document.getElementById(oInput.id + "Tip");
	if(iRLen < 0 ){
		iRLen = 0;		
		sValue = sValue.substring(0, iMaxLen);
		oInput.value = sValue;		
		if(oTipPanel != null){
			oTipPanel.style.display = "";
			oTipPanel.innerHTML = "输入的字符数已经超过最大输入长度"+iMaxLen;
		}else{
			alert("输入的字符数已经超过最大输入长度"+iMaxLen);
		}			
	}else{	
		//显示剩余可输入的字符数
		//var oMsgPanel = document.getElementById(oInput.id + "Msg");
		if (oTipPanel != null) {
			var sMsg = "还可以输入" + iRLen + "个字符" ;
			oTipPanel.innerHTML = sMsg;
		}
		bRet = true;
	}	
	return bRet;	
}

//判断元素是否是Input对象
function isInputEle(oInput){
	var bRet = false;
	if(oInput != null && typeof(oInput)=="object"){
		if(oInput.tagName != null && oInput.tagName.toUpperCase() == "INPUT" || oInput.tagName.toUpperCase() == "TEXTAREA" ){
			bRet = true;
		}
	}
	return bRet;	
}

//判断是否是英文，不是英文则返回false
function checkEnglish(str)
{
	if(str == null || str.Trim().length==0)return true;
	
	str = replaceZhToEn(str.Trim());
	var len= str.length;
    var i;
    for (i=0;i<len;i++){
		if (str.charCodeAt(i)>255){
			return false;
		}
    }
    return true;
}

//-->
//</script>