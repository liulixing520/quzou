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
        		<a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">消息</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">站内信</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=010,011,012,013&amp;dhpath=10005,0301,51003">平台公告</a><span>&gt;</span>			
            全部    </div>
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
						  <form name="searchMsgForm" id="searchMsgForm" action="/messageweb/newmessagecenter.do?msgtype=010,011,012,013&amp;dhpath=10005,0301,51003" method="post" autocomplete="off" 360chrome_form_autofill="2">
						  <input name="dhpath" id="dhpath" type="hidden" value="10005,0301,51003">
						  <input name="searchContent" id="searchContent" type="hidden" value="">
						  <input name="page" id="page" type="hidden" value="1">
						  <input name="orderfield" id="orderfield" type="hidden" value="lastreplytime">
						  <input name="ordertype" id="ordertype" type="hidden" value="desc">
							
						  <div class="page-topic clearfix"><h2>平台公告</h2></div>
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
									<li class="current"><a onclick="handleTab('010,011,012,013');" href="javascript:handleTab('010,011,012,013');"><span>全部  （<var class="inb-hasnum">22</var>）  </span></a></li>
									<li><a onclick="handleTab('010');" href="javascript:handleTab('010');"><span>活动宣传  （<var class="inb-hasnum">9</var>）  </span></a></li>
									<li><a onclick="handleTab('011');" href="javascript:handleTab('011');"><span>政策通知  </span></a></li>
									<li><a onclick="handleTab('012');" href="javascript:handleTab('012');"><span>商品营销  （<var class="inb-hasnum">13</var>）  </span></a></li>
									<li><a onclick="handleTab('013');" href="javascript:handleTab('013');"><span>其它  </span></a></li>
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
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="291297193"></td>
																																				<td title="未读" class="inb-smstatus" topicid="291297193"><span></span></td>
																																																<td class="inb-smmark" topicid="291297193"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=291297193&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之助推神器~</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-24 11:25</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="291110166"></td>
																																				<td title="未读" class="inb-smstatus" topicid="291110166"><span></span></td>
																																																<td class="inb-smmark" topicid="291110166"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=291110166&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之请款、放款和提款</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-23 11:15</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="290931893"></td>
																																				<td title="未读" class="inb-smstatus" topicid="290931893"><span></span></td>
																																																<td class="inb-smmark" topicid="290931893"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=290931893&amp;dhpath=10005,0301,51003" target="_blank">2014年10月23日下午15:00卖家风控技巧线上培训</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-22 16:08</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="290849561"></td>
																																				<td title="未读" class="inb-smstatus" topicid="290849561"><span></span></td>
																																																<td class="inb-smmark" topicid="290849561"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=290849561&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之处理未付款订单</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-22 10:18</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="290821310"></td>
																																				<td title="未读" class="inb-smstatus" topicid="290821310"><span></span></td>
																																																<td class="inb-smmark" topicid="290821310"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=290821310&amp;dhpath=10005,0301,51003" target="_blank">传说中的广告投放技巧，一般人我不告诉他!</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-22 09:27</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="290648076"></td>
																																				<td title="未读" class="inb-smstatus" topicid="290648076"><span></span></td>
																																																<td class="inb-smmark" topicid="290648076"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=290648076&amp;dhpath=10005,0301,51003" target="_blank">免费视频培训：账户处罚及申诉介绍 2014年10月23日(周四)上午11:00</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-21 15:13</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="290516015"></td>
																																				<td title="未读" class="inb-smstatus" topicid="290516015"><span></span></td>
																																																<td class="inb-smmark" topicid="290516015"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=290516015&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之优化产品提升曝光</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-21 10:57</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="290346448"></td>
																																				<td title="未读" class="inb-smstatus" topicid="290346448"><span></span></td>
																																																<td class="inb-smmark" topicid="290346448"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=290346448&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之如何寻找货源！</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-20 11:28</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="289793464"></td>
																																				<td title="未读" class="inb-smstatus" topicid="289793464"><span></span></td>
																																																<td class="inb-smmark" topicid="289793464"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=289793464&amp;dhpath=10005,0301,51003" target="_blank">《数据智囊运用》培训链接</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-16 18:12</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="289603138"></td>
																																				<td title="未读" class="inb-smstatus" topicid="289603138"><span></span></td>
																																																<td class="inb-smmark" topicid="289603138"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=289603138&amp;dhpath=10005,0301,51003" target="_blank">你造吗？1元钱也能投广告！</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-16 10:31</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="289223579"></td>
																																				<td title="未读" class="inb-smstatus" topicid="289223579"><span></span></td>
																																																<td class="inb-smmark" topicid="289223579"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=289223579&amp;dhpath=10005,0301,51003" target="_blank">利用数据分析打造明星店铺!</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-15 15:06</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288950349"></td>
																																				<td title="未读" class="inb-smstatus" topicid="288950349"><span></span></td>
																																																<td class="inb-smmark" topicid="288950349"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288950349&amp;dhpath=10005,0301,51003" target="_blank">2014年10月16日敦煌网3c行业卖家大会</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-14 00:34</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288864356"></td>
																																				<td title="未读" class="inb-smstatus" topicid="288864356"><span></span></td>
																																																<td class="inb-smmark" topicid="288864356"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288864356&amp;dhpath=10005,0301,51003" target="_blank">2014年10月16日敦煌网3c行业卖家大会</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-13 14:20</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288826867"></td>
																																				<td title="未读" class="inb-smstatus" topicid="288826867"><span></span></td>
																																																<td class="inb-smmark" topicid="288826867"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288826867&amp;dhpath=10005,0301,51003" target="_blank">敦煌网提醒您跟进未付款订单</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-13 11:15</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288742550"></td>
																																				<td title="未读" class="inb-smstatus" topicid="288742550"><span></span></td>
																																																<td class="inb-smmark" topicid="288742550"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288742550&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之助推神器！</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-12 14:36</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288553979"></td>
																																				<td title="未读" class="inb-smstatus" topicid="288553979"><span></span></td>
																																																<td class="inb-smmark" topicid="288553979"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288553979&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之请款、放款和提款</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-11 15:00</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288537366"></td>
																																				<td title="未读" class="inb-smstatus" topicid="288537366"><span></span></td>
																																																<td class="inb-smmark" topicid="288537366"><span></span></td>
																								    																							<td class="inb-smsubject addbold" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288537366&amp;dhpath=10005,0301,51003" target="_blank">2014年10月16日敦煌网3c行业卖家大会</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																								<td class="inb-smtime">2014-10-11 14:28</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288520295"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="288520295"><span></span></td>
																																																<td class="inb-smmark" topicid="288520295"><span></span></td>
																								    																							<td class="inb-smsubject" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288520295&amp;dhpath=10005,0301,51003" target="_blank">敦煌网提醒您跟进未付款订单</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-11 11:30</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288409440"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="288409440"><span></span></td>
																																																<td class="inb-smmark" topicid="288409440"><span></span></td>
																								    																							<td class="inb-smsubject" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288409440&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之处理未付款订单</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-10 14:55</td>
											</tr>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="288292252"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="288292252"><span></span></td>
																																																<td class="inb-smmark" topicid="288292252"><span></span></td>
																								    																							<td class="inb-smsubject" style="width: 410px;"><a style="width: 410px;" href="/messageweb/loadmessagedetail.do?messageid=288292252&amp;dhpath=10005,0301,51003" target="_blank">出单秘籍之优化产品提升曝光</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																								<td class="inb-smtime">2014-10-09 14:35</td>
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
                    <span class="pageleft"><span>共有28条记录，每页显示20条</span></span>
                    <span class="pageright">
                    	?上一页
                                	        		<font color="red">1</font>
        		            	        		<a onclick="javascript:gotopage(2,'searchMsgForm')" href="#">2</a> 
	        	    	    		        	<a onclick="javascript:gotopage(2,'searchMsgForm')" href="#">下一页 ?</a> 
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

//--初始化TAB页中的站内信数量


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