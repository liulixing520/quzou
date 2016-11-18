<SCRIPT type=text/javascript src="http://image.dhgate.com/seller/js/common.js"></SCRIPT>
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<LINK rel=stylesheet type=text/css href="../seller/css/seller.css">
<LINK rel=stylesheet type=text/css href="../seller/css/common20140922.css">
<LINK rel=stylesheet type=text/css href="../seller/css/general_popup_box.css">
<SCRIPT type=text/javascript src="http://stats.g.doubleclick.net/dc.js" async="true"></SCRIPT>
<SCRIPT type=text/javascript src="http://image.dhgate.com/dhs/mos/js/public/menu-common_20111226.js?ver=2013"></SCRIPT>
<SCRIPT type=text/javascript src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery.simplemodal2.js?ver=2012-09-27"></SCRIPT>
<!--<script type="text/javascript" src="http://seller.dhgate.com/js/publish/menu-common_20111226.js"></script>-->
<SCRIPT type=text/javascript src="/js/jquery.liu.select.js"></SCRIPT>
<LINK rel=stylesheet type=text/css href="../seller/css/seller_button.css">
<LINK rel=stylesheet type=text/css href="../seller/css/our_buyer.css">
</LINK>
<LINK rel=stylesheet type=text/css href="../seller/css/general_popup_box.css">
<SCRIPT type=text/javascript src="http://image.dhgate.com/2008/web20/seller/js/jquery-time.js"></SCRIPT>
<SCRIPT type=text/javascript>
 	$(document).ready(function() { $('.calendarFocus').calendar(); } );
</SCRIPT>
<LINK rel=stylesheet href="../seller/css/jquery-calendar.css">
<!--thickbox start -->
<SCRIPT type=text/javascript src="http://image.dhgate.com/2008/web20/seller/js/syi/jquery.simplemodal2.js"></SCRIPT>
<!-- Basic Dialog -->
<LINK rel=stylesheet type=text/css href="http://image.dhgate.com/2008/web20/seller/css/thickbox.css" media=screen>
<SCRIPT type=text/javascript src="http://image.dhgate.com/2008/web20/seller/js/thickbox.js"></SCRIPT>
<!-- Basic Dialog -->
<SCRIPT type=text/javascript>
   $(document).ready(function () {
	   $('td.basicModal').click(function (e) {
	   		$("#comments").val("");
	        $("#act").val($(this).attr("act"));
	        $("#buyerid").val($(this).attr("buyerid"));
	        $("#comments").val($(this).attr("comments"));
	        $("#basicModalContent").modal();
	   });
	   
	   $('a.basicModalNickname').click(function (e) {
	   		$("#mybuyernicknameid").val("");
	        $("#act").val($(this).attr("act"));
	        $("#buyerid").val($(this).attr("buyerid"));
	        $("#nickname").html($(this).attr("nickname"));
	        $("#mybuyernicknameid").val($(this).attr("mybuyernickname"));
	        $("#basicModalNickname").modal();
	   });
	   $('a.removeBlackList').click(function (e) {
	   		$("#removeBuyerId").html($(this).attr("nickname"));
			$("#buyerid").val($(this).attr("buyerid"));
	        $("#removeBlackList").modal();
	   });
	   $('a.addToBlackList').click(function (e) {
	   		$("#addBuyerId").html($(this).attr("nickname"));
			$("#buyerid").val($(this).attr("buyerid"));
	        $("#addToBlackList").modal();
	   });
   });  
</SCRIPT>
<LINK rel=stylesheet type=text/css href="../seller/css/ui.tabs.css">
<LINK rel=stylesheet type=text/css href="../seller/css/basic.css" media=screen>
</LINK>
<STYLE type=text/css>
#modalContainer {
	WIDTH: auto; HEIGHT: auto; TOP: 40%; LEFT: 1%
}
</STYLE>
<!-- thickbox end -->
<SCRIPT>
	function caculate_length(){
		var text_length = document.getElementById("comments").value.length;
		var text_max_length = 200;
		var target_div = document.getElementById("body_length");
		var text_remain = text_max_length - text_length;
		target_div.innerHTML = "&nbsp;&nbsp;<font color=#ff0000>已输入字符数 : "+text_length+", 还可以输入字符数 : "+text_remain+"</font>";
      } 
      
      
     function saveComments(){
       var text_length = document.getElementById("comments").value.length;
   	   if(text_length > 200){
   	      alert('输入字符过长,请重新输入.');
   	   }else{
	     	$('#act').val("saveComments");
	     	$('#lastpage').val("1");
	     	$('#inpcomments').val($("#comments").val());
	     	$('#mybuyerformid').submit();
   	   }
     }
     
     function saveNickname(){
   	   var mybuyernicknameid = document.getElementById("mybuyernicknameid").value;
	   if(mybuyernicknameid.length == 0){
	   		alert("请输入昵称");
	   }
   	   if(mybuyernicknameid.length > 20){
   	      alert('输入字符过长,请重新输入.');
   	   }else{
	         jQuery.ajax({
		   		type: "POST",
		   		url: "/mydhgate/mybuyer/mybuyer.do?act=ajaxchecknick&inpmybuyernickname="+encodeURI(mybuyernicknameid)+"&isblank=true",
		   		dataType: "json",
			    success: function(data,status){
			     		var retmes = data.msg;
			     		if(retmes == "1"){
			     			alert("昵称重复,请重新填写");
			     		}else{
			     			$('#act').val("saveComments");
					     	$('#lastpage').val("1");
					     	document.getElementById("inpmybuyernickname").value = mybuyernicknameid;
	     					$('#mybuyerformid').submit();
			     		}
			    },
			    error: function (data, status, e)
		       {
		           alert(e);
		       }
			}); 
			
   	   }
     }
     
     function search(){
         	$('#act').val("pageload");
	     	$('#mybuyerformid').submit();
     }
     
     
     function messageTo(to , k,bid){
		document.getElementById('fromurl').value=window.location.href;
		document.getElementById('to').value=to;
		//改成新发站内信，故PARM将随机生成，保证每一次都是单发
		document.getElementById('parm').value='SingleSend'+Math.floor(Math.random()*10000000000);
		//document.getElementById('parm').value=bid;
		document.getElementById('k').value=k;
		document.getElementById('answer1').submit();
	}
	
	function orderbyrfxcount(){
		$("#orderbyGMV").attr("value",0);
		$('#act').val('pageload');
		$('#mybuyerformid').submit();
	}
	
	function orderbygmv(){
		$("#orderbycount").attr("value",0);
		$('#act').val('pageload');
		$('#mybuyerformid').submit();
	}
	function removeBuyer(){
		$('#act').val("removeBlackBuyer");
     	$('#isBlackBuyer').val('0');
		$('#lastpage').val("1");
     	$('#mybuyerformid').submit();
	}
	function addBuyer(){
	
		var blackReason = $("#blackReason").val();
		if(blackReason =='' || blackReason == "请输入您要填写的内容"){
			alert('原因不能为空，请输入!');
			$("#blackReason").val('');
			return ;
		}
		if(blackReason.length > 200 ){
			alert('原因太长，请在200字以内!');
			return ;
		}
		$('#act').val("removeBlackBuyer");
		$("#inpBlackReason").val(blackReason);
     	$('#isBlackBuyer').val('1');
		$('#lastpage').val("1");
     	$('#mybuyerformid').submit();
	}
	
	//-----------------------------------------------------------群发站内信begin
	$(function(){
		//初始化每一行中的复选框,包括第一行的全选复选框
		var buyersysids_in_cookie = $('#selectedBuyerIds').val();
		var buyersysids = buyersysids_in_cookie.split(',');
		buyersysids = jQuery.grep(buyersysids,function(value,index){
			if(value==''){return false;}else{return true;}
		});
		jQuery.each(buyersysids,function(index,value){
    		$('table tr input[buyersysid='+value+']').attr('checked',true);//每一行
		});
		if( $('table tr input[name=buyerInfo]').size()==$('table tr input[name=buyerInfo]:checked').size() ){
			$('table tr.bbg input[type=checkbox]').attr('checked',true);//第一行
		}
		
		//第一行中的全选按钮
    	$('table tr.bbg input[type=checkbox]').bind('click',function(){
    		var buyersysids_in_cookie = $('#selectedBuyerIds').val();
    		var buyersysids = buyersysids_in_cookie.split(',');
    		buyersysids = jQuery.grep(buyersysids,function(value,index){
    			if(value==''){return false;}else{return true;}
    		});
			var checked = $(this).is(':checked');
			if(checked){//全选
				var counttoadd = $('table tr input[name=buyerInfo]').size()-$('table tr input[name=buyerInfo]:checked').size();
				if( buyersysids.length + counttoadd > 20 ){
		    		$(this).attr('checked',false);
					alert('您目前已选择了'+ buyersysids.length +'个买家，全部选取后买家数量将超过20个，请单独选择买家！');
					return;
				}
				//全选时数据处理
	    		$('table tr input[name=buyerInfo]').attr('checked',true);
				$('table tr input[name=buyerInfo]').each(function(){
					if( jQuery.inArray($(this).attr('buyersysid'),buyersysids)==-1 ){
						buyersysids.push( $(this).attr('buyersysid') );
					}
				});
				$('#selectedBuyerIds').val( buyersysids.join(',') );
			}else{//全不选
				//全不选时数据处理,从buyersysids_in_cookie中全部剃除(字符串处理)
	    		$('table tr input[name=buyerInfo]').attr('checked',false);
				$('table tr input[name=buyerInfo]').each(function(){
    				buyersysids_in_cookie = buyersysids_in_cookie.replace(','+$(this).attr('buyersysid') ,'');
    				buyersysids_in_cookie = buyersysids_in_cookie.replace($(this).attr('buyersysid')+',' ,'');
    				buyersysids_in_cookie = buyersysids_in_cookie.replace($(this).attr('buyersysid') ,'');
				});
				$('#selectedBuyerIds').val( buyersysids_in_cookie );
			}
    	});
		
		//每一行中的复选按钮
    	$('table tr input[name=buyerInfo]').bind('click',function(){
    		var buyersysids_in_cookie = $('#selectedBuyerIds').val();
    		var buyersysids = buyersysids_in_cookie.split(',');
    		buyersysids = jQuery.grep(buyersysids,function(value,index){
    			if(value==''){return false;}else{return true;}
    		});
    		var checked = $(this).is(':checked');
			if(checked){//选中时
				if( buyersysids.length + 1 > 20 ){
		    		$(this).attr('checked',false);
					alert('您目前已选择了20个买家，无法再进行选取！');
					return;
				}
				//选中时数据处理
				if( $('table tr input[name=buyerInfo]').size()==$('table tr input[name=buyerInfo]:checked').size() ){
					$('table tr.bbg input[type=checkbox]').attr('checked',true);
				}
				buyersysids.push( $(this).attr('buyersysid') );
				$('#selectedBuyerIds').val( buyersysids.join(',') );
			}else{//不选时
				//不选时数据处理,从buyersysids_in_cookie中全部剃除(字符串处理)
				$('table tr.bbg input[type=checkbox]').attr('checked',false);
				buyersysids_in_cookie = buyersysids_in_cookie.replace(','+$(this).attr('buyersysid') ,'');
				buyersysids_in_cookie = buyersysids_in_cookie.replace($(this).attr('buyersysid')+',' ,'');
				buyersysids_in_cookie = buyersysids_in_cookie.replace($(this).attr('buyersysid') ,'');
				$('#selectedBuyerIds').val( buyersysids_in_cookie );
			}
    	});
		
		//群发站内信按钮
    	$('#batchsendBtn').bind('click',function(){
    		var buyersysids_in_cookie = $('#selectedBuyerIds').val();
    		var buyersysids = buyersysids_in_cookie.split(',');
    		buyersysids = jQuery.grep(buyersysids,function(value,index){
    			if(value==''){return false;}else{return true;}
    		});
			if(buyersysids.length==0){
				alert('请选择要发送的买家！');
				return;
			}
			$('#tosysids').val( buyersysids.join(',') );
			document.getElementById('answer2').submit();
    	});
	});
	//--------------------------------------------------------------群发站内信end
</SCRIPT>
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">交易</a><span>&gt;</span><a href="/mydhgate/mybuyer/mybuyer.do?dhpath=10002,04,0401">我的买家</a><span>&gt;</span>买家名单 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <div class="common_tab">
            <ul>
              <li class="common_tab_current"><a href="/mydhgate/mybuyer/mybuyer.do"><span> 我的买家 </span></a></li>
            </ul>
          </div>
          <div style='background: url("http://image.dhgate.com/2008/web20/seller/img/bg_buyer.gif") no-repeat; height: 36px; line-height: 38px; padding-left: 102px;'>您可以通过我的买家，整体了解并管理买家的交易状况，帮助您开展营销推广，即时发送相关信息。<a href="http://cs.dhgate.com/announce/610.html" target="_blank">查看详情</a></div>
          <form id="mybuyerformid" method="post" name="MybuyerForm" action="/mydhgate/mybuyer/mybuyer.do">
            <input id="selectedBuyerIds" name="selectedBuyerIds" value="" type="hidden">
            <div class="our_button"> 买家：
              <input id="textfield" name="buyernickname" maxLength="20" value="" size="10" type="text">
              昵称：
              <input id="textfield2" name="mybuyernickname" maxLength="20" value="" size="10" type="text">
              买家所在国家：
              <select id="select" class="oSelect1" size="1" name="buyercountryid">
                <option value="">选择国家</option>
              </select>
              下单日期：
              <input id="textfield3" class="calendarFocus" name="startdate" readOnly="" value="" size="8" type="text">
              <span class="calendar_append"></span> 到
              <input id="textfield4" class="calendarFocus" name="enddate" readOnly="" value="" size="8" type="text">
              <span class="calendar_append"></span> &nbsp;
              <button onclick="search()" type="button"><span class="button1_lt"><span class="button1_ri">搜索</span></span></button>
            </div>
            <!-- 添加群发按钮 start -->
            <div class="our_button clearfix">
              <div style="float: right;"> 排序查看：
                <select id="orderbycount" onchange="orderbyrfxcount()" class="oSelect1" size="1" name="orderbycount">
                  <option value="0">选择交易次数</option>
                  <option value="1">低到高</option>
                  <option value="2">高到低</option>
                </select>
                <select id="orderbyGMV" onchange="orderbygmv()" class="oSelect2" size="1" name="orderbyGMV">
                  <option value="0">选择交易总额数</option>
                  <option value="1">低到高</option>
                  <option value="2">高到低</option>
                </select>
              </div>
            </div>
            <!-- 添加群发按钮 end -->
            <table border="1" cellSpacing="0" borderColor="#c8d9e9" cellPadding="0" width="100%">
              <tbody>
                <tr class="bbg">
                  <td width="40"><input value="" type="checkbox"></td>
                  <td width="70">买家</td>
                  <td>昵称</td>
                  <td>买家级别</td>
                  <td>信用度</td>
                  <td>12个月内好评率</td>
                  <td>交易次数</td>
                  <td>交易总金额</td>
                  <td>最后一次交易时间</td>
                  <td>操作</td>
                  <td>备注</td>
                </tr>
              </tbody>
            </table>
            <div id="page"> </div>
            <div style="display: none;" id="basicModalContent">
              <table class="listtext" border="0" cellSpacing="1" cellPadding="0">
                <tbody>
                  <tr>
                    <td class="top" colSpan="2">备注</td>
                  </tr>
                  <tr>
                    <td colSpan="2"><textarea id="comments" onkeyup="caculate_length()" cols="40" rows="5" name="comments"></textarea>
                    </td>
                  </tr>
                  <tr>
                    <td class="buttle"><div id="body_length"><span class="red">最多输入字符数为500</span></div></td>
                    <td class="buttri" align="right"><input onclick="saveComments()" name="Submit" value="提交" type="button">
                      <input class="modalClose" name="Submit2" value="取消 " type="button">
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div style="display: none;" id="basicModalNickname">
              <div style="padding-top: 8px;" class="tc_main">
                <div class="tc_content">
                  <table border="0" cellSpacing="0" cellPadding="0" width="400">
                    <tbody>
                      <tr>
                        <td height="6" colSpan="2"></td>
                      </tr>
                      <tr>
                        <td width="45%" align="right">买家名称：</td>
                        <td id="nickname"></td>
                      </tr>
                      <tr>
                        <td align="right">昵称：</td>
                        <td><input id="mybuyernicknameid" name="mybuyernickname" size="9" type="text"></td>
                      </tr>
                      <tr>
                        <td height="36" colSpan="2" align="center"><button onclick="saveNickname()" type="button"><span class="button1_lt"><span class="button1_ri">提 交</span></span></button>
                             
                          <button class="modalClose" typpe="buttong"><span class="button2_lt "><span class="button2_ri">取 消</span></span></button></td>
                      </tr>
                      <tr>
                        <td height="6" colSpan="2"></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <div style="width: 500px; display: none;" id="addToBlackList" class="tc_warp">
              <div class="tc_title">
                <dl>
                  <dt>加入黑名单</dt>
                </dl>
              </div>
              <div class="tc_main">
                <div class="tc_content">
                  <div class="box2">
                    <p style="text-align: left;" class="clear">将用户加入黑名单后，该用户不能给您下订单，只能询盘。请写明将买家加入黑名单的原因！该原因将会作为以后的提示，当您收到该买家发来的站内信时会看到该原因。</p>
                    <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                      <tbody>
                        <tr class="tr1">
                          <td style="color: rgb(255, 0, 0);" vAlign="top" width="26"><strong>*</strong></td>
                          <td width="444"><textarea style="width: 355px; height: 60px;" id="blackReason" class="color5" cols="20" rows="2" name="blackReason">请输入您要填写的内容</textarea></td>
                        </tr>
                        <tr>
                          <td height="36" colSpan="2">最多输入200个字</td>
                        <tr class="tr1">
                          <td vAlign="top" colSpan="2" align="center"><button onclick="addBuyer();" type="button"><span style="color: rgb(255, 255, 255);" class="button1_lt"><span class="button1_ri">提交</span></span></button>
                              
                            <button class="modalClose" type="button"><span style="color: rgb(108, 108, 108);" class="button2_lt"><span class="button2_ri">取消</span></span></button></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
            <input id="act" name="act" value="pageload" type="hidden">
            <input id="buyerid" name="buyerid" value="" type="hidden">
            <input id="inpcomments" name="inpcomments" value="" type="hidden">
            <input id="inpmybuyernickname" name="inpmybuyernickname" value="" type="hidden">
            <input id="lastpage" name="lastpage" value="" type="hidden">
            <input id="isBlackBuyer" name="isBlackBuyer" value="0" type="hidden">
            <input id="inpBlackReason" name="inpBlackReason" value="" type="hidden">
          </form>
          <form id="answer1" method="POST" action="/messageweb/loadmessagetobuller.do">
            <input name="dhpath" value="10005,0301" type="hidden">
            <input name="_M" value="5" type="hidden">
            <input id="fromurl" name="fromurl" type="hidden">
            <input name="msgtype" value="4" type="hidden">
            <input id="to" name="to" type="hidden">
            <input id="parm" name="parm" type="hidden">
            <input id="k" name="K" type="hidden">
          </form>
          <form id="answer2" method="POST" action="/messageweb/batchsendpage.do">
            <input name="dhpath" value="10005,0301" type="hidden">
            <input name="msgtype" value="4" type="hidden">
            <input id="tosysids" name="tosysids" type="hidden">
          </form>
          <script type="text/javascript" src="http://image.dhgate.com/dhs/mos/js/vip.js"></script>
          <link rel="stylesheet" type="text/css" href="http://image.dhgate.com/dhs/mos/css/vip.css">
          <div style="display: none; visibility: hidden;" id="vipContent">
            <div class="vippop">
              <div class="helppane_right"></div>
              <p><strong class="fl">VIP买家<span class="color3">新增如下特权</span></strong><a class="closepop closeme" href="javascript:void(0);"></a></p>
              <p>金银牌买家给卖家的Feedback打分翻倍计算</p>
              <p><a class="fl" href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0701&amp;artid=792EC2EE9187CC68E0400A0A2B0A2BD8" target="_blank">查看详情&gt;&gt;</a><a class="closeme" href="javascript:void(0);">我知道啦！</a></p>
            </div>
          </div>
          <script type="text/javascript">
	$(document).ready(function() {
		var viphover = new VipicoHover();
		$("#vipContent").css({visibility: "hidden"});
		$(".tc_warp").hide();
	});
</script>
        </div>
      </div>
    </div>
   	<#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#orderLeftbar")}
   

  </div>
</div>
