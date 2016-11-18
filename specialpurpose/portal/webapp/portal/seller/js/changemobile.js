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
					$('#showmobile').hide();
					$('#modifymobile').show();
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
function submitMobile() {
	
	if (OnMobileSubmit()) {
		var ctrl = document.getElementById('mobilephone');
		checkMobile(ctrl.value);
	}
}	
function OnMobileSubmit(){
	//手机验证
	var ret = true;
	var ctrl = document.getElementById('mobilephone');
    var mobolevalue = ctrl.value;

    if (!validateNumber(mobolevalue)) {
	       	ret = false;
	}
    
    if (!ret) {
    	alert("手机格式错误，请重新输入")
     	window.setTimeout(function() {
    		ctrl.focus();
    		ctrl.select();
    	}, 50);
    	
    }
    return ret; 
}

function checkMobile(mobolevalue) {

	jQuery.ajax({
   		type: "POST",
   		url: "/merchant/jquerysendverifycode.do?mobilephone=" + mobolevalue,
   		dataType: "json",
	    success: function(data, status) {
	    	var retval = data.msg;
	    	var des = data.des;
     		if (retval >= 0) {
			  //  $("#err_mobile").show();
			//	$("#err_mobile").html("<span class=\"tips-error\">"+des+"</span>");
				//$("#showCodeDate").show();			//多秒秒后重新发送验证码
				$("#showCodeDate").css({"display":"inline-block"});
				$("#sendverfiycode").hide();
				$("#sendcodespan").hide();
    			$(".code-num01").text(60);
				setTimeout(startRunTimer, 1000);
     		} else {
			    $("#err_mobile").show();
				$("#err_mobile").html("<span class=\"tips-error\">"+des+"</span>");
				
     		}
	    },
	    error: function (data, status, e) {
           alert("操作失败!");
       	}
	}); 
	
}
function startRunTimer(){
        var needCodeNum=$(".code-num01").text();
        $(".code-num01").text(needCodeNum - 1);
        if(needCodeNum==1){
				$("#showCodeDate").hide();			////多秒秒后重新发送验证码
				$("#sendverfiycode").show();
				$("#sendcodespan").show();	//发送验证码
											//alert(" needCodeNum ="+needCodeNum);
        }else{
            setTimeout(startRunTimer,1000);
       }
}		
function validateNumber(val){
	if(!val)
		return false;
   	var patn = /^[0-9]+$/;
   	if(patn.test(val)) 
   		return true;
   	return false; 	
}
	
function checkMobile2() {
			var mobilephone=document.getElementById('mobilephone').value;
			var  ret = validateMobile(mobilephone);
			if(ret){
						return true;
			}else{
					$("#err_mobile").show();
					$("#err_mobile").html("<span class=\"tips-error\">请输入正确手机号码</span>");
	        }
	      }
function validateMobile(val) {
	       var patn = new RegExp("^(13|15|18)[0-9]{9}$");
	       	if(patn.test(val)) { 
	               return true;
	        }
	        //香港手机
	        var patn1 = new RegExp("^[0-9]{8}$");
	          if(patn1.test(val)) { 
	               return true;
	          }	   	
	             return false;
	      }
										
//修改手机同时验证手机验证码
function updatemobilephone(){
		var mobilephone  =  document.getElementById('mobilephone').value;
		var mobilephoneCode = document.getElementById('mobilephoneCode').value;
		if(mobilephone=="" || mobilephoneCode==""){
			$("#err_mobile").html("<span class=\"tips-error\">请获取验证码，输入正确的验证码！</span>");
			$("#err_mobile").show();
		    return ;
        }
      var bool = isVerifyCode(mobilephone,mobilephoneCode);
			//alert("bool  =  "+bool);
		if(bool){
			var url="/merchant/updateVerifyCode.do?mobilephone=" + mobilephone+'&mobilephoneCode='+mobilephoneCode;
	    	window.location.href=url;
	   }
}
										
function isVerifyCode(mobilephone,mobilephoneCode_val) {
				var bool=false;
				if(mobilephoneCode_val.length==6){
	                   jQuery.ajax({
	                                type: "POST",
	                                url: "/merchant/register/isVerifyCode.do?isblank=true&mobilephone=" + mobilephone+"&mobilephoneCode="+mobilephoneCode_val,
	                                dataType: "json",
									async: false,
	                                success: function(data, status) {
	                                var msg_val = data.msg;
	                               //alert(msg_val);
	                                if (msg_val == 'yes') {
	                                			bool=true;
	                               } else if(msg_val == 'outlimit') { //关联超限
	                                	$("#mobilephoneCode").val("");
	                                	$("#err_mobile").html("<span class=\"tips-error\">该手机号码关联账号数超限，请重新选择号码！</span>");
	                                	$("#err_mobile").show();
	                                	bool=false;
	                                		                            	   
	                               } else {
	                                	$("#mobilephoneCode").val("");
	                                	$("#err_mobile").html("<span class=\"tips-error\">请输入正确的手机验证码！</span>");
	                                	$("#err_mobile").show();
	                                	bool=false;
	                               }	
	                              },
	                              error: function (data, status, e) {
	                                		           alert("操作失败!");
													   bool=false;
	                                		       	}
	                                			});
	                                		}
											return bool;
	                                    }
function rengong(){
	$('#close_popvalVid03').trigger("click");
	var mobilephone = $("#mobilephone").val();
	
	if(checkMobile2()){
	alert(mobilephone);
    	jQuery.ajax({
       		type: "POST",
       		url: "/merchant/rengong.do?mobilephone=" + mobilephone,
       		dataType: "json",
    	    success: function(data, status) {
    	    	    var flag = data.flag;
    		    	var msg = data.msg;
    				if(flag){
						$('#modifymobile').hide();
    					$('#waitvaliddiv').show();
						$('#rgmobile').text(mobilephone);
    				}else{
					
							$("#err_mobile").show();
							$("#err_mobile").html("<span class=\"tips-error\">"+msg+"</span>");
    				}
    	    },
    	    error: function (data, status, e) {
               alert("操作失败!");
           	}
    	}); 
	}
    
}

function oncityresult(data,status) {
	var result = getCitysStr(data);
	resetCitySelect('citystate', result); 
 }
function changeProvince(provinceid, onresult) {
	if(provinceid == "64C1EDCCA373BC5BE040007F01004020"){
		$('#retips').val("00852");
		$('#mobilephone').attr('maxlength','8');
		if($('#mobilephone').val().length>8){
			$('#mobilephone').val("");
			$("#sendVerifyCode").hide();
			$("#mobilephoneTip").html("<span class=\"onError\"><span class=\"rgicon-wrong\"></span><span class=\"marginlf5\">请输入正确手机号码!</span></span>");
		}
	}else{
		$('#retips').val("+86");
		$('#mobilephone').attr('maxlength','11');
	}
   jQuery.ajax({
   		type: "POST",
   		url: "/merchant/register/getCitys.do?isblank=true&provinceid=" + provinceid,
   		data: '',
	    success: onresult,
	    error: function (data, status, e) {
           alert(e);
        }
	}); 
}
function resetCitySelect(cityselectid, retmes) {
	var cityIp=document.getElementById("cityIp").value;
	var select=false;
	var selObj = document.getElementById(cityselectid);
	if(retmes != "" ){
		selObj.options.length=0;
		//默认----
		//selObj.options.add(new Option("----",""));
		var retmeslist = retmes.split("-");
		//alert(retmeslist.length)
		for(var i=0;i<retmeslist.length;i++){
			var cityinfo = retmeslist[i].split(":");
	 		var tid = cityinfo[0];
	 		var tname = cityinfo[1];
			if(cityinfo.length > 2&&!select){
				selObj.options.add(new Option(tname,tid));
				if (cityinfo[2] == "1") {
				    //selObj.options[i+1].selected = true;  //由于有默认----
					selObj.options[i].selected = true;
				}
			}else{
				selObj.options.add(new Option(tname,tid));
				if(cityinfo[0]==cityIp&&!select){
					selObj.options[i].selected = true;
					select=true;
				}
			}
		}
  	}else{
  		selObj.options.length=0;
  		selObj.options.add(new Option("县、市地区等","null"));
  	}
}
function getCitysStr(content) {
	var retmeslist = content.split("|");
	return retmeslist[1];
}