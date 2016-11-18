//检验是否空
function isEmpty(s)
{   if (s == null) return true;
	s = trim(s);
 	if (s == "")
 		return true;
 	else
 		return false;
}

//去掉字符串头尾的空格
function trim(s)
{
	var i;

    if (s == null) return s;
    //去掉左边空格
    for (i = 0; i < s.length; i++)
        if (s.charAt(i)!=" ") break;
    if (i!=0) s = s.substr(i);
    //去掉右边空格
    for (i = s.length-1; i>=0; i--)
        if (s.charAt(i)!=" ") break;
    if (i!=s.length-1) s = s.substr(0,i+1);
    return s;
}

//检验字符是否是数字
function isDigit (c)
{
	return ((c >= "0") && (c <= "9"))
}

//检验是否整型
function isInteger (s)
{
	var i;

    if (isEmpty(s)) return false;
	s = trim(s);

    for (i = 0; i < s.length; i++)
    {
        var c = s.charAt(i);
        if (!isDigit(c)) return false;	//不是数字
    }
    return true;
}

function selectbank(bank_id,direct_pmode_id,direct_card_id) {
	document.bankform.bank_id.value=bank_id;
	document.bankform.direct_pmode_id.value=direct_pmode_id;
	document.bankform.direct_card_id.value=direct_card_id;		
	document.bankform.submit();
}

function selectpmode(cardid,pmodeid) {
	document.payform.card_id.value=cardid;
	document.payform.pmode_id.value=pmodeid;
	document.payform.submit();
}

function MM_swapImgRestore() {
	var i,x,a=document.MM_sr;
	for(i=0 ; a&&i < a.length&&(x=a[i])&&x.oSrc;i++)
		x.src=x.oSrc;
}

function MM_findObj(n, d) {
	var p,i,x;
	if(!d)	d=document;
	if((p=n.indexOf("?"))>0&&parent.frames.length) {
		d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
	}
	if(!(x=d[n])&&d.all)
		x=d.all[n];
	for (i=0;!x&&i<d.forms.length;i++)
		x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++)
		x=MM_findObj(n,d.layers[i].document);
	return x;
}

function MM_swapImage() {
	var i,j=0,x,a=MM_swapImage.arguments;
	document.MM_sr=new Array;
	for(i=0;i<(a.length-2);i+=3)
		if ((x=MM_findObj(a[i]))!=null) {
			document.MM_sr[j++]=x;
			if(!x.oSrc) x.oSrc=x.src;
			x.src=a[i+2];
		}
}

function isPosInteger(inputVal)
{
    inputStr = inputVal.toString();
	for (var i=0; i< inputStr.length; i++)
    {
		var oneChar = inputStr.charAt(i)
		if (oneChar < "0" || oneChar > "9")
			return (true);
	}
    return (false)
}

function isTrueNum(inputPmode, inputVal)
{
	if (inputPmode == "1" && ((inputVal.substr(0,1) != "8" && inputVal.substr(0,6) != "518476" && inputVal.substr(0,6) != "518378" && inputVal.substr(0,6) != "518475" && inputVal.substr(0,6) != "518379" && inputVal.substr(0,6) != "547766" && inputVal.substr(0,6) != "558868" && inputVal.substr(0,6) != "518474" ) || inputVal.length != 16))
			return(true);
	if (inputPmode == "11" && (inputVal.substr(0,5) != "84390" || inputVal.length != 16))
			return(true);
	if (inputPmode == "12" && (inputVal.length !=11 && inputVal.length !=12))
			return(true);
	if (inputPmode == "17" && (inputVal.substr(0,1) != "4" || inputVal.length != 16))
			return(true);
  if (inputPmode == "18" || inputPmode == "45"){
  		/****************************************
  		Master
  		长度：16 
  		第一碼為 5，且前二碼介於 51 和 55 中間。 
  		****************************************/
			if(
				(inputVal.substr(0,2) != "51" && 
				inputVal.substr(0,2) != "52" && 
				inputVal.substr(0,2) != "53" && 
				inputVal.substr(0,2) != "54" && 
				inputVal.substr(0,2) != "55" )||
				inputVal.substr(0,6) == "518476" || 
				inputVal.substr(0,6) == "518378" || 
				inputVal.substr(0,6) == "518475" || 
				inputVal.substr(0,6) == "518379" || 
				inputVal.substr(0,6) == "547766" || 
				inputVal.substr(0,6) == "558868" || 
				inputVal.substr(0,6) == "518474" || 
				inputVal.length != 16)
		  return(true);
	}
	
  if (inputPmode == "19"){
  	 /*******************************************
  	 American Express 
  	 长度：15
  	 		第一碼為 3，且前三碼介於 340 和 379 之間 
  	 ********************************************/
  	 if(inputVal.substr(0,3) < 340 || inputVal.substr(0,3) > 379 || inputVal.length != 15)
				return(true);
	}
	
	if (inputPmode == "20"){
			/**************************************
			JCB
			长度：15
				第一碼為 1，且前四碼為 1800。
				第一碼為 2，且前四碼為 2131。
			长度：16 
				第一碼為 3，且前三碼介於 300和399之間 
			**************************************/
		
		 if(inputVal.length != 16 && inputVal.length != 15)
		 return(true);
		 
		 if((inputVal.length == 15) && (inputVal.substr(0,4) != "1800" && inputVal.substr(0,4) != "2131"))
		 return(true);
		 
		 if((inputVal.length == 16) && (inputVal.substr(0,3) > 399 || inputVal.substr(0,3) < 300))
		 return(true);
	}		 
		 
		 
		 
	if (inputPmode == "24" && (inputVal.substr(0,5) != "98430" || inputVal.length != 16))
			return(true);	
	
	if (inputPmode == "42") {
           if(inputVal.length != 16 && inputVal.length != 15 )
	        return(true);		
	   
	   if(inputVal.substr(0,1)=="5") {
  		if ((inputVal.substr(0,2) != "51" && 
		inputVal.substr(0,2) != "52" && 
		inputVal.substr(0,2) != "53" && 
		inputVal.substr(0,2) != "54" && 
   	    inputVal.substr(0,2) != "55" )||
		inputVal.substr(0,6) == "518476" || 
		inputVal.substr(0,6) == "518378" || 
		inputVal.substr(0,6) == "518475" || 
		inputVal.substr(0,6) == "518379" || 
		inputVal.substr(0,6) == "547766" || 
		inputVal.substr(0,6) == "558868" || 
		inputVal.substr(0,6) == "518474" || 
		inputVal.length != 16)
		  return(true);	   	
	   }else if (inputVal.substr(0,1)=="1" || inputVal.substr(0,1)=="2" || inputVal.substr(0,1)=="3") {
		 if(inputVal.length != 16 && inputVal.length != 15)
		 return(true);
		 
		 if((inputVal.length == 15) && (inputVal.substr(0,4) != "1800" && inputVal.substr(0,4) != "2131"))
		 return(true);
		 
		 if((inputVal.length == 16) && (inputVal.substr(0,3) > 399 || inputVal.substr(0,3) < 300))
		 return(true);	   	
	   }else if (inputVal.substr(0,1)=="4") {
		 return false;
	   }else	   
		 return(true);	   		   	
        }	 
	
	return(false); 
}


function Check_Cardform_Validator(theForm)
{
	if (theForm.card_holder.value == "" || theForm.card_holder.value.length < 2){
		alert("请正确输入持卡人姓名!");
		theForm.card_holder.focus();
		return(false);
    }
	if (checkCreditCard(theForm.card_id.value,theForm.card_no.value)==false){
		alert("无效信用卡号！");
		theForm.card_no.focus();
		return false;
	}
/*
	if (isPosInteger(theForm.card_no.value) || isTrueNum(theForm.pmode_id.value, theForm.card_no.value) ){
		alert("无效信用卡号！");
		theForm.card_no.focus();
		return(false);
	}
*/
	if (theForm.expire_m.value == ""){
		alert("请填写信用卡有效期中的月份字段!");
		theForm.expire_m.focus();
		return(false);
	}
	if (theForm.expire_y.value == ""){
		alert("请填写信用卡有效期中的年份字段!");
		theForm.expire_y.focus();
		return(false);
	}
	if (!(theForm.expire_m.value >=1 && theForm.expire_m.value <=12)){
		alert("无效信用卡有效期！");
		theForm.expire_m.focus();
		return(false);
	}
	if (!(theForm.expire_y.value >=0 && theForm.expire_y.value <=99)){
		alert("无效信用卡有效期！");
    	theForm.expire_y.focus();
		return(false);
	}
	if (theForm.idcard.value.length > 18 || theForm.idcard.value.length < 6 ){
		alert("无效证件号码");
		theForm.idcard.focus();
		return (false);
	}

    theForm.action = "pay_submit.jsp";
	return (true);
}

function Check_Cardform_Validator1(theForm)
{
	if (theForm.card_holder.value == "" || theForm.card_holder.value.length < 2){
		alert("请正确输入持卡人姓名!");
		theForm.card_holder.focus();
		return(false);
        }

	if (checkCreditCard(theForm.card_id.value,theForm.card_no.value)==false){
		alert("无效信用卡号！");
		theForm.card_no.focus();
		return false;
	}
/*
	if (isPosInteger(theForm.card_no.value) || isTrueNum(theForm.pmode_id.value, theForm.card_no.value) ){
		alert("无效信用卡号！");
		theForm.card_no.focus();
		return(false);
	}
*/
	
	if (theForm.expire_m.value == ""){
		alert("请填写信用卡有效期中的月份字段!");
		theForm.expire_m.focus();
		return(false);
	}
	if (theForm.expire_y.value == ""){
		alert("请填写信用卡有效期中的年份字段!");
		theForm.expire_y.focus();
		return(false);
	}
	if (!isInteger(theForm.expire_m.value)) {
		alert("无效信用卡有效月份！");
		theForm.expire_m.focus();
		return(false);
	}
	if (!(theForm.expire_m.value >=1 && theForm.expire_m.value <=12)){
		alert("无效信用卡有效月份！");
		theForm.expire_m.focus();
		return(false);
	}
	if (!isInteger(theForm.expire_y.value)) {
		alert("无效信用卡有效年份！");
		theForm.expire_y.focus();
		return(false);
	}
	if (theForm.expire_y.value.length != 4){
		alert("无效信用卡有效年份！");
    	        theForm.expire_y.focus();
		return(false);
	}
	if (theForm.expire_y.value < 2003){
		alert("信用卡已过期！");
		theForm.expire_y.focus();
		return(false);
	}
	if (theForm.idcard.value.length > 18 || theForm.idcard.value.length < 6 ){
		alert("无效证件号码");
		theForm.idcard.focus();
		return (false);
	}
        theForm.action = "pay_abc_submit.jsp";
	return (true);
}

function Check_Cardform_Validator2(theForm)
{
	if (theForm.card_holder.value == "" || theForm.card_holder.value.length < 2){
		alert("请正确输入持卡人姓名!");
		theForm.card_holder.focus();
		return(false);
        }


	if (checkCreditCard(theForm.card_id.value,theForm.card_no.value)==false){
		alert("无效信用卡号！");
		theForm.card_no.focus();
		return false;
	}
/*
	if (isPosInteger(theForm.card_no.value) || isTrueNum(theForm.pmode_id.value, theForm.card_no.value) ){
		alert("无效信用卡号！");
		theForm.card_no.focus();
		return(false);
	}
*/
	if (theForm.expire_m.value == ""){
		alert("请填写信用卡有效期中的月份字段!");
		theForm.expire_m.focus();
		return(false);
	}
	if (theForm.expire_y.value == ""){
		alert("请填写信用卡有效期中的年份字段!");
		theForm.expire_y.focus();
		return(false);
	}
	if (!(theForm.expire_m.value >=1 && theForm.expire_m.value <=12)){
		alert("无效信用卡有效期！");
		theForm.expire_m.focus();
		return(false);
	}
	if (!(theForm.expire_y.value >=0 && theForm.expire_y.value <=99)){
		alert("无效信用卡有效期！");
    	        theForm.expire_y.focus();
		return(false);
	}
	if (theForm.idcard.value.length > 18 || theForm.idcard.value.length < 6 ){
		alert("无效证件号码");
		theForm.idcard.focus();
		return (false);
	}

        theForm.action = "pay_oversea_submit.jsp";
	return (true);
}

function Check_Mobile_Validator(theForm)
{
	if (isPosInteger(theForm.mobile_no.value) || theForm.mobile_no.value.length!=11){
		alert("手机号码格式错误！");
		theForm.mobile_no.focus();
		return(false);
	}
	theForm.action = "/customer/gb/mpss_submit.jsp";
	return (true); 
}







	/********************************************
		  20060331修改 by sd
	********************************************/



    /****************************************
        判断是否为有效卡
        18 VISA
        19 MASTER
        20 AE
        21 JCB
        113 VISA
        122 MASTER
    ****************************************/
    function checkCreditCard(cardid, cardno){
        if(cardid==18 || cardid==113){
            return is_visa(cardno);
        }
        if(cardid==19 || cardid==122){
            return is_master(cardno);
        }
        if(cardid==20){
            return is_ae(cardno);
        }
        if(cardid==21){
            return is_jcb(cardno);
        }
    }



    /*******************************************
    Visa
    长度：16
        首位为为 4
    ********************************************/
    function is_visa(cardno){
        var pattern = /^4\d{15}$/;
        return pattern.test(cardno);
    }

    /*******************************************
    American Express 
    长度：15
        第一碼為 3，且前三碼介於 340 和 379 之間 
    ********************************************/
    function is_ae(cardno){
        var pattern = /^3[4-7]\d{13}$/;
        return pattern.test(cardno);
    }

    /**************************************
    JCB
    长度：15
        第一碼為 1，且前四碼為 1800。
        第一碼為 2，且前四碼為 2131。
    长度：16 
        第一碼為 3，且前三碼介於 300和399之間 
    **************************************/    
    function is_jcb(cardno){
        var pattern1 = /^(1800|2131)\d{11}$/;
        var pattern2 = /^3\d{15}$/;

        if(pattern1.test(cardno)){
            return true;
        }else if(pattern2.test(cardno)){
            return true;
        }else{
            return false;
        }
    }

    /****************************************
    Master
    长度：16 
    第一碼為 5，且前二碼介於 51 和 55 中間。 

    并且前6位不包括下面卡段
        518476, 518378, 518475, 518379, 547766, 558868, 518474
    function is_master(cardno){
        var pattern1 = /^(518476|518378|518475|518379|547766|558868|518474)\d{10}$/;
        var pattern2 = /^5[1-5]\d{14}$/;
        if(pattern1.test(cardno)){
            return false;
        }else{
            return pattern2.test(cardno);
        }
    }
    ****************************************/
    function is_master(cardno){
        var pattern2 = /^5[1-5]\d{14}$/;
        return pattern2.test(cardno);
    }

   
    /****************************************
    长城信用卡
    长度：16 
    第一碼為 8，或者前6位为下面卡段
        518476, 518378, 518474, 518475, 518379, 547766, 558868 
    ****************************************/
    function is_bocCreditCard(cardno){
        var pattern1 = /^8\d{15}$/;
        var pattern2 = /^(518476|518378|518474|518475|518379|547766|558868)\d{10}$/;
        if (pattern1.test(cardno)){
            return true;
        }else if(pattern2.test(cardno)){
            return true;
        }else{
            return false;
        }
    }