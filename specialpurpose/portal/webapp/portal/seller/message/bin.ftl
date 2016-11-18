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
        		<a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">消息</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">站内信</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?state=1&amp;dhpath=10005,0301,51004">垃圾箱</a><span>&gt;</span>			
            </div>
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
						  <form name="searchMsgForm" id="searchMsgForm" action="/messageweb/newmessagecenter.do?state=1&amp;dhpath=10005,0301,51004" method="post" autocomplete="off" 360chrome_form_autofill="2">
						  <input name="dhpath" id="dhpath" type="hidden" value="10005,0301,51004">
						  <input name="page" id="page" type="hidden" value="1">
						  <input name="orderfield" id="orderfield" type="hidden" value="lastreplytime">
						  <input name="ordertype" id="ordertype" type="hidden" value="desc">
							
						  <div class="page-topic clearfix"><h2>垃圾箱</h2></div>
						   <div class="page-operate-tip inb-packup">
								<span class="leftcol-tip">温馨提示：</span>
								<div class="rightcol-tip" id="pageTipCon" style="height: 24px; overflow: hidden;">
                                    <p>1、接收和回复买家发起的询盘消息、订单消息以及其它类型的消息；</p>
                                    <p>2、查看系统发出的有关订单、产品、付款等类型的提醒消息和平台通知公告类消息；</p>
                                    <p>3、您的站内信消息将会被保存<var class="inb-hasnum" style="font-weight: bold;">12个月</var>。</p>
								</div>
								<a class="deploy" id="pageTipButton" href="javascript:void(0)">展开</a>
							</div>
							
							<div class="search-list">
								<div class="search-top clearfix">
																		<div class="search-toplf">
										<span class="yellowBtn"><input type="button" value="永久删除" opcode="2"></span>
										<span class="tourBtn"><input type="button" value="撤销删除" opcode="0"></span>
									</div>
																		<div class="search-topri">
										<span class="inb-sourcecon" id="inbSearch">
											<span class="inb-sourcetit">消息来源：</span>
											<select id="ingStyle">
												<option value="virLinkCls1">全部</option>
												<option value="virLinkCls2">买家消息</option>
												<option value="virLinkCls3">系统消息</option>
												<option value="virLinkCls4">平台公告</option>
											</select>
											<select name="msgtype" id="inbStylecon">
											
											
											
											
											
											
											
											
											
											
											
											
											
											
											
											
											
											<option class="virLinkCls1" value="">全部</option></select>
										</span>
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
												<td class="inb-smlink">联系人</td>
												<td class="inb-smsubject">主 题</td>
												<td class="inb-smtype">类 型</td>
																								<td class="inb-smreplay" style="cursor: pointer;">回复数<var class="inb-narr"></var></td>
																																				<td class="inb-smtime" style="cursor: pointer;">发送&nbsp;/&nbsp;回复时间<var class="inb-narr"></var></td>
																							</tr>
										</thead>
										<tbody>
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="287101197"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="287101197"><span></span></td>
																																																<td class="inb-smmark" topicid="287101197"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=287101197&amp;dhpath=10005,0301,51004" target="_blank">出单秘籍之处理未付款订单</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-30 10:04</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="286935274"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="286935274"><span></span></td>
																																																<td class="inb-smmark" topicid="286935274"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=286935274&amp;dhpath=10005,0301,51004" target="_blank">敦煌网论坛八卦站内容推送第6期（0928）</a></td>
    																																			<td class="inb-smtype">其它</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-29 12:04</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="286909509"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="286909509"><span></span></td>
																																																<td class="inb-smmark" topicid="286909509"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=286909509&amp;dhpath=10005,0301,51004" target="_blank">出单秘籍之优化产品提升曝光</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-29 09:31</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="286679457"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="286679457"><span></span></td>
																																																<td class="inb-smmark" topicid="286679457"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=286679457&amp;dhpath=10005,0301,51004" target="_blank">出单秘籍之如何寻找货源！</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-28 11:36</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="286298242"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="286298242"><span></span></td>
																																																<td class="inb-smmark" topicid="286298242"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=286298242&amp;dhpath=10005,0301,51004" target="_blank">敦煌通2.0新功能上线啦!</a></td>
    																																			<td class="inb-smtype">其它</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-26 15:42</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="286256324"></td>
																																				<td title="未读" class="inb-smstatus" topicid="286256324"><span></span></td>
																																																<td class="inb-smmark" topicid="286256324"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=286256324&amp;dhpath=10005,0301,51004" target="_blank">出单秘籍之助推神器！</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-26 11:02</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="286021058"></td>
																																				<td title="未读" class="inb-smstatus" topicid="286021058"><span></span></td>
																																																<td class="inb-smmark" topicid="286021058"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=286021058&amp;dhpath=10005,0301,51004" target="_blank">出单秘籍之请款、放款和提款</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-25 11:23</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="285813518"></td>
																																				<td title="未读" class="inb-smstatus" topicid="285813518"><span></span></td>
																																																<td class="inb-smmark" topicid="285813518"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=285813518&amp;dhpath=10005,0301,51004" target="_blank">出单秘籍之处理未付款订单</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-24 11:57</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="285637259"></td>
																																				<td title="未读" class="inb-smstatus" topicid="285637259"><span></span></td>
																																																<td class="inb-smmark" topicid="285637259"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=285637259&amp;dhpath=10005,0301,51004" target="_blank">出单秘籍之优化产品提升曝光</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-23 11:32</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="285596980"></td>
																																				<td title="未读" class="inb-smstatus" topicid="285596980"><span></span></td>
																																																<td class="inb-smmark" topicid="285596980"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=285596980&amp;dhpath=10005,0301,51004" target="_blank">好消息！运费模板升级啦！</a></td>
    																																			<td class="inb-smtype">其它</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-23 10:45</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="285522476"></td>
																																				<td title="未读" class="inb-smstatus" topicid="285522476"><span></span></td>
																																																<td class="inb-smmark" topicid="285522476"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=285522476&amp;dhpath=10005,0301,51004" target="_blank">如何高效的使用产品流量快车</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-22 15:51</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="285494830"></td>
																																				<td title="未读" class="inb-smstatus" topicid="285494830"><span></span></td>
																																																<td class="inb-smmark" topicid="285494830"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=285494830&amp;dhpath=10005,0301,51004" target="_blank">出单秘籍之如何寻找货源！</a></td>
    																																			<td class="inb-smtype">商品营销</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-22 11:23</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="285047326"></td>
																																				<td title="未读" class="inb-smstatus" topicid="285047326"><span></span></td>
																																																<td class="inb-smmark" topicid="285047326"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=285047326&amp;dhpath=10005,0301,51004" target="_blank">利用数据分析打造明星店铺视频培训延期</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-18 16:20</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="284918425"></td>
																																				<td title="未读" class="inb-smstatus" topicid="284918425"><span></span></td>
																																																<td class="inb-smmark" topicid="284918425"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=284918425&amp;dhpath=10005,0301,51004" target="_blank">新卖家流量不用愁，助力出单！产品流量快车，专注您的需求！</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-17 14:07</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="284723869"></td>
																																				<td title="未读" class="inb-smstatus" topicid="284723869"><span></span></td>
																																																<td class="inb-smmark" topicid="284723869"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject addbold"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=284723869&amp;dhpath=10005,0301,51004" target="_blank">"秋季新品发布会"活动征集！</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-16 14:49</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="284644970"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="284644970"><span></span></td>
																																																<td class="inb-smmark" topicid="284644970"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=284644970&amp;dhpath=10005,0301,51004" target="_blank">利用数据分析打造明星店铺</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-16 10:45</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="284548693"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="284548693"><span></span></td>
																																																<td class="inb-smmark" topicid="284548693"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=284548693&amp;dhpath=10005,0301,51004" target="_blank">“秋季新品发布会”活动征集</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-15 17:46</td>
											</tr>												
											    											    											    																																			
											<tr>
												<td class="inb-smcheck"><input name="topicid" type="checkbox" value="284102959"></td>
																																				<td title="已读" class="inb-smstatus hasread" topicid="284102959"><span></span></td>
																																																<td class="inb-smmark" topicid="284102959"><span></span></td>
																																																	<td class="inb-smlink">SYSTEM</td>
																								    																							<td class="inb-smsubject"><a style="cursor: pointer;" href="/messageweb/loadmessagedetail.do?messageid=284102959&amp;dhpath=10005,0301,51004" target="_blank">敦煌网操作指导及经营技巧</a></td>
    																																			<td class="inb-smtype">活动宣传</td>
																																				<td class="inb-smreplay"><em>0</em></td>
																																				<td class="inb-smtime">2014-09-11 16:56</td>
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
                    <span class="pageleft"><span>共有18条记录，每页显示20条</span></span>
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