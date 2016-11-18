function checkanswer(){
			var answer = document.getElementById("question");
         	var answer = document.getElementById("answer");
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
					$('#showemail').hide();
					$('#modifyemail').show();
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
//重新发送邮件
	function sendEmail(mail) {
	var email = $('#'+mail).val();
	if(validateMail('email')){
	jQuery.ajax({
   		type: "POST",
   		url: "/merchant/sendemail.do?isblank=true&email=" + email,
   		dataType: "json",
	    success: function(data, status) {
				var retval = data.msg;
		    	var des = data.des;
				if (retval > 0) {
					 $("#validmail").show();
					 $("#modifyemail").hide();
					 $("#premail").text(email);
					 $("#premail2").text(email);
					 $("#serverurl").val(data.serverurl);
				} else {
	     			 $("#err_mobile").show();
					$("#err_mobile").html("<span class=\"tips-error\">"+des+"</span>");
	     		}
	     },
		 error: function (data, status, e) {
	           alert("操作失败!");
			   //alert("不成功"+status);
	      }
		}); 
	
	
	}
		
	}		
	
	function validateEmail(obj){
    	var str = obj.value;
    	if(!checkByteLength(str,1,50)) return false;
      	var patn = /^[_a-zA-Z0-9\-]+(\.[_a-zA-Z0-9\-]*)*@[a-zA-Z0-9\-]+([\.][a-zA-Z0-9\-]+)+$/;
    	if(!patn.test(str)){
        	return false;
    	}
		return true;
		
	}
	function validateMail(ctrlid) {
		var ctrl = document.getElementById(ctrlid);
		var str = ctrl.value;
		if(str.split('@')[0].length <6){
			$("#err_mobile").show();
			$("#err_mobile").html("<span class=\"tips-error\">邮箱前缀不能少于6个字符</span>");
			 window.setTimeout(function() {
					ctrl.focus();
					ctrl.select();
				}, 50);
				return false;
		}
		if (!validateEmail(ctrl)) {
			 $("#err_mobile").show();
			 $("#err_mobile").html("<span class=\"tips-error\">输入错误，请重新输入</span>");
			window.setTimeout(function() {
				ctrl.focus();
				ctrl.select();
			}, 50);
			return false;
		} else {
			return true;
		}
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