var spiner=createSpinner();var background=document.getElementById("background");var spinerShow=function(){background.style.display="block";spiner.spin(background)};var spinerHide=function(){background.style.display="none";spiner.stop()};function sliderLoad(){if(location.hash.length!=0){location.hash=""}}function backScroll(){background.style.top=document.body.scrollTop+"px"}window.onscroll=backScroll;var calcYunfee=function(c,a){var b="";if(c==1){b="&updateFlag=1&IsUseJdBean="+a}else{b="&updateFlag=0&useBalance="+a}jQuery.get("/norder/calcYunfeeVm.action?sid="+$("#sid").val()+b,function(d){if(d!=null){if(d.indexOf("Copyright")==-1){$("#yunfei").html(d)}if($("#showPayPassword").val()=="true"){addPayPasswordLink()}else{$("#payPwdSpan").html("");$("#payPwdDiv").hide();checkSecurityPayPassword()}}})};var jdBeanHandler=function(){if($("#useJdbeanIcon").attr("class")=="icon"){$("#useJdbeanIcon").addClass("on")}else{$("#useJdbeanIcon").removeClass("on")}calcJdBeanAndBalance(1)};var balanceHandler=function(){if($("#useBalanceIcon").attr("class")=="icon"){$("#useBalanceIcon").addClass("on")}else{$("#useBalanceIcon").removeClass("on")}calcJdBeanAndBalance(0)};var calcJdBeanAndBalance=function(a){var b=false;var c=false;if(a==1){if($("#useJdbeanIcon").attr("class")=="icon on"){b=true;calcYunfee(1,b)}else{calcYunfee(1,b)}}else{if($("#useBalanceIcon").attr("class")=="icon on"){c=true;calcYunfee(0,c)}else{calcYunfee(0,c)}}};function addPayPasswordLink(){$("#payPwdDiv").show();if($("#showPayPassword").val()=="true"){$("#openPayPassword").hide();$("#findPayPassword").show();$("#payPassword").removeAttr("disabled")}else{$("#openPayPassword").show();$("#findPayPassword").hide();$("#payPassword").attr("disabled","disabled")}checkSecurityPayPassword()}var checkSecurityPayPassword=function(){var a=$("#payPassword").val();if($("#showPayPassword").val()=="true"&&$("#userPayPassword").val()=="true"&&(a==undefined||a.trim()=="")){$("#submiOrder").addClass("new-abtn-default");return false}else{$("#submiOrder").removeClass("new-abtn-default");return true}};var orderDate=new Array();$("#orderForm").submit(function(){var a=$("#isIdTown").val();if("true"==a){if(confirm("\u4e3a\u4e86\u8ba9\u60a8\u4eab\u53d7\u66f4\u4e3a\u7cbe\u51c6\u7684\u914d\u9001\u670d\u52a1\uff0c\u6211\u4eec\u63d0\u4f9b\u4e86\u56db\u7ea7\u5730\u5740\u9009\u9879\uff0c\u8bf7\u60a8\u7acb\u523b\u5b8c\u5584\u5730\u5740\u4fe1\u606f\u4ee5\u514d\u5f71\u54cd\u6b63\u5e38\u4e0b\u5355")){$("#addressLink").click()}return false}orderDate.push(new Date());if(orderDate.length>1&&(orderDate[orderDate.length-1].getTime()-orderDate[orderDate.length-2].getTime()<5000)){return false}if(!checkSecurityPayPassword()){alert("\u652f\u4ed8\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a");return false}return true});var submitOrder=function(){$("#orderForm").submit()};var showTownTip=function(){var g=createSpinner();$("#spinner2").show();g.spin($("#spinner2")[0]);if($("#_mask")){$("#_mask").remove()}var a=((document.body||document.documentElement).clientHeight+20)+"px";var c="100%";var b=document.createElement("div");b.setAttribute("id","_mask");b.setAttribute("style","position:absolute;left:0px;top:0px;background-color:rgb(20, 20, 20);filter:alpha(opacity=60);opacity: 0.6;width:"+c+";height:"+a+";z-index:9998;");(document.body||document.documentElement).appendChild(b);g.stop();$("#spinner2").hide();var e=100;var d=window.pageYOffset||document.documentElement.scrollTop||document.body.scrollTop;var f=document.documentElement.clientHeight||document.body.clientHeight;document.getElementById("showIdTown").style.bottom=((f-e)/2-d)+"px";$("#showIdTown").show();return false};