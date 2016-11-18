<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!--
	<link href="../seller/css/common20111215.css" rel="stylesheet" type="text/css" media="all">
	<link href="../seller/css/common20140922.css" rel="stylesheet" type="text/css" media="all">
	<link href="../seller/css/seller.css" rel="stylesheet" type="text/css" media="all">
	-->
	<link href="../seller/css/inbox20131128.css" rel="stylesheet" type="text/css" media="all">
	<body>
	<div class="content">
					<div class="crumb">
        		<a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">消息</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">站内信</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=004,005,006,007,008,009&amp;dhpath=10005,0301,51002">系统消息</a><span>&gt;</span>			
            全部  </div>
			            <script language="javascript">
			jQuery(function(){
				var lastCrumbtext = jQuery('div.rtab-warp li.current').text();
				if(lastCrumbtext.length>0 ){
				  lastCrumbtext = lastCrumbtext.replace('（','').replace('）','').replace(/[0-9]+/,'');
				  jQuery('div.content div.crumb').append( lastCrumbtext );
				}
				if(document.title && (document.title=='无权限访问'||document.title=='提示页面') ){
				  jQuery('div.content div.crumb').append( document.title );
				}
			});
			</script>
				
        <div class="layout clearfix">
            <div class="col-main">
                <div class="col-main-warp">
						<div id="right"><!-- 修改 start -->
						  <form name="searchMsgForm" id="searchMsgForm" action="/messageweb/newmessagecenter.do?msgtype=004,005,006,007,008,009&amp;dhpath=10005,0301,51002" method="post" autocomplete="off" 360chrome_form_autofill="2">
						  <input name="dhpath" id="dhpath" type="hidden" value="10005,0301,51002">
						  <input name="searchContent" id="searchContent" type="hidden" value="">
						  <input name="page" id="page" type="hidden" value="1">
						  <input name="orderfield" id="orderfield" type="hidden" value="lastreplytime">
						  <input name="ordertype" id="ordertype" type="hidden" value="desc">
							
						  <div class="page-topic clearfix"><h2>系统消息</h2></div>
						   <div class="page-operate-tip inb-packup">
								<span class="leftcol-tip">温馨提示：</span>
								<div class="rightcol-tip" id="pageTipCon" style="height: 24px; overflow: hidden;">
                                    <p>1、接收和回复买家发起的询盘消息、订单消息以及其它类型的消息；</p>
                                    <p>2、查看系统发出的有关订单、产品、付款等类型的提醒消息和平台通知公告类消息；</p>
                                    <p>3、您的站内信消息将会被保存<var class="inb-hasnum" style="font-weight: bold;">12个月</var>。</p>
								</div>
								<a class="deploy" id="pageTipButton" href="javascript:void(0)">展开</a>
							</div>
							<div class="rtab-warp">
								<ul class="clearfix">
									<li class="current"><a onclick="handleTab('004,005,006,007,008,009');" href="javascript:handleTab('004,005,006,007,008,009');"><span>全部  </span></a></li>
									<li><a onclick="handleTab('004');" href="javascript:handleTab('004');"><span>订单  </span></a></li>
									<li><a onclick="handleTab('005');" href="javascript:handleTab('005');"><span>产品  </span></a></li>
									<li><a onclick="handleTab('006');" href="javascript:handleTab('006');"><span>付款/退款  </span></a></li>
									<li><a onclick="handleTab('007');" href="javascript:handleTab('007');"><span>促销  </span></a></li>
									<li><a onclick="handleTab('008');" href="javascript:handleTab('008');"><span>账户  </span></a></li>
									<li><a onclick="handleTab('009');" href="javascript:handleTab('009');"><span>其它  </span></a></li>
								</ul>
							</div>
							<div class="inb-searchwarp clearfix">
								<div class="inb-searchbox">
									<span>关键词：</span>
																		<input id="inbInput" style="-ms-ime-mode: disabled;" type="text" maxlength="200" value="输入订单编号" dataval="输入订单编号">
																	</div>
								<div class="inb-searread">
									<span>是否阅读：</span>
									<select name="readed">
										<option value="-1" selected="">全部</option>
										<option value="1">已读</option>
										<option value="0">未读</option>
									</select>
								</div>
								<div class="inb-searmark">
									<span>标记：</span>
									<select name="marked">
										<option value="-1" selected="">全部</option>
										<option value="1">已标记</option>
										<option value="0">未标记</option>
									</select>
								</div>
								<span class="yellowBtn">
									<input id="formSearchBtn" onclick="searchMsg();" type="button" value="搜 索">
								</span>
							</div>
							<div class="search-list">
								<div class="search-top clearfix">
																		<div class="search-toplf" id="volumeset">
										<a class="greybutton1 inb-setup" href="javascript:void(0)"><span>设 置<var class="inb-narr"></var></span></a>
										<div class="inb-setuplist" style="display: none;">
											<div class="inb-setreadcon">
												<a class="inb-setread" href="javascript:void(0)" setattr="Read"><span></span>设置为已读</a>
												<a class="inb-setunread" href="javascript:void(0)" setattr="Unread"><span></span>设置为未读</a>
												<a class="inb-setmarked" href="javascript:void(0)" setattr="Mark"><span></span>设置标记</a>
												<a class="inb-setdel" href="javascript:void(0)" setattr="Unmark"><span></span>取消标记</a>
											</div>
										</div>
										<span class="tourBtn "><input class="inb-del" type="button" value="删 除"></span>
									</div>
																		<div class="search-topri">
										<span>发送时间：</span>
										<select name="beforeDate" onchange="searchMsgByDate();">
											<option value="30">最近1个月</option>
											<option value="60">最近2个月</option>
											<option value="90" selected="">最近3个月</option>
											<option value="180">最近6个月</option>
											<option value="270">最近9个月</option>
											<option value="366">最近12个月</option>
										</select>
									</div>
								</div>
								<div class="search-mid" id="searchMid">
																		<table>
										<thead>
											<tr>
												<td class="inb-smcheck"><input id="ckeckAll" type="checkbox" value=""></td>
												<td class="inb-smstatus">状态</td>
												<td class="inb-smmark">标记</td>
												<td class="inb-smsubject" style="width: 410px;">主 题</td>
												<td class="inb-smtype">类 型</td>
																								<td class="inb-smtime" style="cursor: pointer;">发送时间<var class="inb-narr"></var></td>
																							</tr>
										</thead>
										<tbody>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="287279961"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="287279961"><span></span></td>
																																																<td class="inb-smmark" topicid="287279961"><span></span></td>
																								    																							<td class="inb-smsubject" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=287279961&amp;dhpath=10005,0301,51002" target="_blank">您本月被评为敦煌网“标准商户”！</a></td>
    																																			<td class="inb-smtype">其它</td>
																								<td class="inb-smtime">2014-10-01 12:52</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="284048620"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="284048620"><span></span></td>
																																																<td class="inb-smmark" topicid="284048620"><span></span></td>
																								    																							<td class="inb-smsubject" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=284048620&amp;dhpath=10005,0301,51002" target="_blank">[DHgate] 账户信息通知！</a></td>
    																																			<td class="inb-smtype">账户</td>
																								<td class="inb-smtime">2014-09-11 11:37</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="283947111"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="283947111"><span></span></td>
																																																<td class="inb-smmark" topicid="283947111"><span></span></td>
																								    																							<td class="inb-smsubject" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=283947111&amp;dhpath=10005,0301,51002" target="_blank">身份认证申请已通过审核</a></td>
    																																			<td class="inb-smtype">账户</td>
																								<td class="inb-smtime">2014-09-10 17:02</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="283917911"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="283917911"><span></span></td>
																																																<td class="inb-smmark" topicid="283917911"><span></span></td>
																								    																							<td class="inb-smsubject" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=283917911&amp;dhpath=10005,0301,51002" target="_blank">[DHgate] 账户信息通知！</a></td>
    																																			<td class="inb-smtype">账户</td>
																								<td class="inb-smtime">2014-09-10 15:30</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="283905822"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="283905822"><span></span></td>
																																																<td class="inb-smmark" topicid="283905822"><span></span></td>
																								    																							<td class="inb-smsubject" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=283905822&amp;dhpath=10005,0301,51002" target="_blank">[DHgate] 账户信息通知！</a></td>
    																																			<td class="inb-smtype">账户</td>
																								<td class="inb-smtime">2014-09-10 13:59</td>
											</tr>												
																					</tbody>
									</table>
																	</div>
								<!-- 分页按钮 -->
																   <script language="javascript">
	    function gotopage (pagenum, frm) {
	    	if(frm==null || frm==''){
				frm=document.forms['searchMsgForm'];
			}else{
				frm=document.forms[frm];
			}
			if(pagenum!=null&&pagenum!=''){
			frm.page.value=pagenum;
			}
			frm.submit();
		}
	</script>

	        	                		        				        <div class="commonpage">
                    <span class="pageleft"><span>共有5条记录，每页显示20条</span></span>
                    <span class="pageright">
                    	?上一页
                                	        		<font color="red">1</font>
        		    	    		        	下一页 ?
                <span class="gotopage">到 <input class="inputtext" type="text" value=""> 页<span class="buttonpage"><input onclick="javascript:gotopage($('.inputtext').val(),'searchMsgForm')" type="button" value="确 定"></span></span>
       </span>
    </div>
        
															</div>
						  </form>
						  <!-- 修改 end -->
						
<script type="text/javascript">
//--切换TAB页面时，执行搜索
function handleTab(msgtype){
	//1.设定消息类型
	var acturl = $('#searchMsgForm').attr('action');
	acturl = acturl.replace(/msgtype=[^&]*/g,'msgtype='+msgtype);
	$('#searchMsgForm').attr('action',acturl);
	$('#searchContent').val('');//2.清空表单域
	document.getElementById('searchMsgForm')['readed'].options[0].selected = true;//3.设定阅读为全部
	document.getElementById('searchMsgForm')['marked'].options[0].selected = true;//4.设定标记为全部
	document.getElementById('searchMsgForm')['beforeDate'].options[2].selected = true;//5.设定发送时间为3个月
	$('#page').val('1');//6.设定分页起始页
	//7.清除排序
	$('#orderfield').val('lastreplytime');
	$('#ordertype').val('desc');
	//提交表单
	document.getElementById('searchMsgForm').submit();
}

//--点击搜索按钮时，执行搜索
function searchMsg(){
	//1.设定关键词
	$('#searchContent').val('');//先清空
	var searchText = $.trim($('#inbInput').val());
	if( searchText!='' && searchText!=$('#inbInput').attr('dataVal') ){
		$('#searchContent').val(searchText);
	}
	//2.设定分页起始页
	$('#page').val('1');
	//3.设定发送时间为3个月
	//document.getElementById('searchMsgForm')['beforeDate'].options[2].selected = true;
	//4.清除排序
	$('#orderfield').val('lastreplytime');
	$('#ordertype').val('desc');
	//提交表单
	document.getElementById('searchMsgForm').submit();
}

//--选择发送时间下拉框时，执行搜索
function searchMsgByDate(){
	//1.设定分页起始页
	$('#page').val('1');
	//2.清除排序
	$('#orderfield').val('lastreplytime');
	$('#ordertype').val('desc');
	//提交表单
	document.getElementById('searchMsgForm').submit();
}


</script></div>
				</div>
            </div>
	<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#messageLeft")}
        </div>
    </div>
</body>
</head>
</html>