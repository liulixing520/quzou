function checkanswer(){
         	var answer = document.getElementById("answer");
         	var question = document.getElementById("question");
			if(answer.value.length==0)
    		{
    			alert("请输入答案");
    			answer.focus();
    			return false;
    		}
			
			jQuery.ajax({
	   		type: "POST",
	   		url: "/merchant/checkanswer.do?answer="+encodeURIComponent(encodeURIComponent(answer.value))+"&question="+encodeURIComponent(encodeURIComponent(question.value)),
	   		dataType: "json",
		    success: function(data, status) {
		    	var flag = data.flag;
		    	var msg = data.msg;
		    	//alert(flag+"  "+msg);
				if(flag){
					$('#close_popvalVid01').trigger("click");
					$('#showpassword').hide();
					$('#modifypassword').show();
				}else{
				 $("#aaerror").show();
					 $("#aaerror").text(msg);
				}
		    },
		    error: function (data, status, e) {
	           alert("操作失败!");
	       	}
		}); 
    		
}
function checkform(){
			var oldpassword = document.getElementById("oldpassword");
    		var password1 = document.getElementById("password1");
    		var password2 = document.getElementById("password2");
			var lspass=validatePassword(oldpassword);
    		if(oldpassword.value == ""){
    		   alert("请输入原密码");
    		   oldpassword.focus();
    			return false;
    		}
    		
    		var lspass1=validatePassword(password1);
    		if(lspass1==1){
    		   alert("密码长度为6-20位");
    			password1.focus();
    			return false;
    		}
    		
    		var lspass2=validatePassword(password2);
    		if(lspass2==1){
    		   alert("密码长度为6-20位");
    			password2.focus();
    			return false;
    		}
			if(password1.value!=password2.value)
    		{
    			alert("2次输入的密码不一致");
    			password1.value="";
    			password2.value="";
    			password1.focus();
    			return false;
    		}
			$("#prodoctImgWarp").show();
jQuery.ajax({
	   		type: "POST",
	   		url: "/merchant/changepassword.do",
	   		dataType: "json",
			data:"oldpassword="+oldpassword.value+"&password1="+password1.value+"&password2="+password2.value+"&domainname="+$("#domainname").val(),
		    success: function(data, status) {
		    	var flag = data.flag;
		    	var msg = data.msg;
		    	//alert(flag+"  "+msg);
				if(flag){
			     	$("#prodoctImgWarp").hide();
					 $("#success").show();
					 $('#modifypassword').hide();
				}else{
					 $("#error").show();
					 $("#error").text(msg);
				}
		    },
		    error: function (data, status, e) {
	           alert("操作失败!");
	       	}
		}); 
}

  function validatePassword(obj){
  		var str = obj.value;
    	if(!checkByteLength(str,6,20)) return 1;															
    	var patn1 =   /^[a-zA-Z0-9_]+$/;
    	if(!patn1.test(str) ) return 1;
    	return 0; 
	}
	
	function checkByteLength(str,minlen,maxlen) {
		if (str == null) return false;
		var l = str.length;
		var blen = 0;
		for(i=0; i<l; i++) {
			if ((str.charCodeAt(i) & 0xff00) != 0) {
				blen ++;
			}
			blen ++;
		}
		if (blen > maxlen || blen < minlen) {
			return false;
		}
		return true;
	}

function passwordChange(){
	var passwordnew1=$("#password1").val();
	jQuery.ajax({
	   		type: "POST",
	   		url: "/merchant/register/checkPassword.do?isblank=true&password="+passwordnew1,
	   		dataType: "json",
		    success: function(data, status) {
		    	var level = data.level;
		    	var msg = data.msg;
		    	 //alert(level+"  "+msg);
	     		 if(level == 'A'){
	     			 $("#show_1").hide();
	     			 $("#show_2").hide();
	     			 $("#show_3").show();
	     			 return true;
	     		 }else if(level == 'B'){
	     			 $("#show_1").hide();
	     			 $("#show_2").show();
	     			 $("#show_3").hide();
	     			 return true;
	     		 }else if(level == 'C'){
	     			 $("#show_1").show();
	     			 $("#show_2").hide();
	     			 $("#show_3").hide();
	     			 return true;
	     		 }
		    },
		    error: function (data, status, e) {
	           alert("操作失败!");
	       	}
		}); 
}