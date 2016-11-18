     function changeset(value){
    	 $("#tipInfo_1").show();
    	 $("#erroriInfo_1").hide();
		 $("#identitytype").val(value);
		 
		// if(value == '300'){
		//	$("#identitytype").val('300600');
		// }
		 
	 }
		function login_sub_button(){
		var identitytype = $("#identitytype").val();
		if(identitytype != '400' && identitytype != '600' && identitytype != '700'&& identitytype != '300'&& identitytype != '500'&& identitytype != '100'&& identitytype != '200'){
			identitytype = "0";
		}
		if(identitytype=="" || identitytype == null || identitytype == "0"){
			$("#tipInfo_1").hide();
			$("#erroriInfo_1").show();
			$("#identitytype").val("0");
			$("#inputvalue_1").focus();
			return false;
		}
		
		var fullname = $("#inputvalue_2").val();
		var idcard = $("#inputvalue_3").val();
		if( fullname == "" || fullname == null){
			$("#tipInfo_2").hide();
			$("#erroriInfo_2").css("display", "inline-block");
			$("#inputvalue_2").focus();
			return false;
		}
		if(idcard == "" || idcard == null){
			$("#erroriInfo_3").css("display", "inline-block");
			$("#inputvalue_3").focus();
			return false;
		}
		
		
	   if(!checkChinese(fullname)){
		    $("#tipInfo_2").hide();
			$("#erroriInfo_2").text("请输入正确的身份证姓名");
			$("#erroriInfo_2").css("display", "inline-block");
			$("#inputvalue_2").focus();
			return false;
	    } 
	   var flag = validateIdcard(idcard);
	   if(flag != 1){
			$("#erroriInfo_3").text(flag==2?"您好,注册人年龄须在18周岁到70周岁之间！":"请输入正确的身份证号");
			$("#erroriInfo_3").css("display", "inline-block");
			$("#inputvalue_3").focus();
			return false;
	   }
		return true;
	}
		function setFocus(value){
			$("#tipInfo_"+value).show();
			$("#erroriInfo_"+value).hide();
		}
		function setInput(value){
			$("#tipInfo_"+value).hide();
			$("#erroriInfo_"+value).hide();
		}
		//做大陆身份证验证，15-18位，年份段限制为1939-2000年期间
		function validateIdcard(val) {
			if(val==null)return 0;
			
			val = val.toUpperCase();
			
		    // 身份证验证长度验证
		    if(val.length != 18 && val.length != 15 && val.length != 11 && val.length != 10) {     
		        return 0;
		    }   
		    if (val.length == 15 || val.length == 18){
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
		    	if(val.length == 15){    		
			    	var isIDCard15=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
				   	if(!isIDCard15.test(val)) {
				   		 return 0;
				   	}
				   	strBirthday = "19" + val.substr(6,2)+"/" + val.substr(8,2)+"/"+val.substr(10,2);
			   	}else{	   		
			    	var isIDCard18=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])(\d{4}|\d{3}X)$/;
				   	if(!isIDCard18.test(val)) {
				   		 return 0;
				   	}		   
				    strBirthday = val.substr(6,4)+ "/"+ val.substr(10,2)+"/"+ val.substr(12,2);
			   	}  
			   	//生日校验
			   	var dBirthday = new Date(strBirthday);
			   	var bmonth = dBirthday.getMonth()+1 ;
			   	if(bmonth < 10) bmonth= ""+"0"+ bmonth;	   	
			   	
			   	var bday = dBirthday.getDate();
			   	if(bday<10)bday = "" +"0"+bday;
			   	
				if( strBirthday != (dBirthday.getFullYear()+"/"+ bmonth + "/" + bday ) ){
					return 0; 
				}	
				//出生日期在1944年到1996年之间。	   
			    if ( dBirthday < new Date("1944/01/01") || dBirthday > new Date("1996/12/31")) {
			    	return 2;
			    }	
			    //地区校验   	
		    }else if (val.length == 10 || val.length == 11) {
		    	//香港的身份证 
				//身份证号码的结构，可以用XYabcdef(z)表示。「X」可能是「空格」或是一个英文字母，「Y」则必定是英文字母。
				//「abcdef」代表一个六位数字，而「z」是作为检码之用，它的可能选择是0,1,2,...,9,A(代表10)。
		    	var patn = new RegExp("^[A-Za-z]{1,2}[0-9]{6}[(][0-9aA][)]+$");
			   	if(patn.test(val)) { 
			   		return 1;
			   	}
			   	//1.	台湾身份证总共有10位数字。第一位是字母。后面九位是数字。 台湾省份证的第一位的字母代表地区分别以A——Z表示
			   	//2.	第二位数字代表性别 男性是1，女性是2
			   	//3.	第三位到第九位为任意的一串数字
			   	//4.	第十位为验证码。 第十位数字

			   	var patn1 = new RegExp("^[A-Za-z]{1}[1-2]{1}[0-9]{8}$");
			   	if(patn1.test(val)) { 
			   		return 1;
			   	}
			   	return 0;
		    }
			
			return 1;
		}
		function checkChinese(val, elem) {
			var len;
		    var i;
		    len = 0;
		    var reg = /^[\u4e00-\u9fa5]+$/i; 
		  	if (!reg.test(val)) {
		      return false;
		    }
		    return true;
		}