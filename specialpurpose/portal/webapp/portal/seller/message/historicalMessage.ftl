<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!--
	<link href="css/common20111215.css" rel="stylesheet" type="text/css" media="all">
	<link href="css/common20140922.css" rel="stylesheet" type="text/css" media="all">
	<link href="css/seller.css" rel="stylesheet" type="text/css" media="all">
	-->
	<link href="../seller/css/inbox20131128.css" rel="stylesheet" type="text/css" media="all">
	<link href="../seller/css/custom-service.css" rel="stylesheet" type="text/css" media="all">
	<body>
<div class="content">
						
												
					<div class="crumb">
									
																																	
															
				        		<a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">消息</a><span>&gt;</span><a href="/mydhgate/csmsg/leavemsg.do?dhpath=10005,52000,2701">客服留言</a><span>&gt;</span>历史留言
				
				            </div>
				
        <div class="layout clearfix">
            <div class="col-main">
                <div class="col-main-warp">
											<div id="right"><div class="right">
		<div class="page-topic clearfix">
    		<h2>
    			我的留言
    		</h2>
			<a class="send-message" href="/mydhgate/csmsg/leavemsg.do?act=pageload&amp;dhpath=10005,52000,2701">发起客服留言</a>
		</div>
    	<div class="page-operate-tip clearfix" id="pageOperateTip">
        	<span class="leftcol-tip">温馨提示：</span>
            <div class="rightcol-tip">
            	<p>客服中心将帮助您解答关于敦煌认证、平台功能、支付、财务、物流与运费等相关方面的咨询，您如果想了解更多关于 DHgate 的服务，请点击进入<a class="under-line" href="http://help.dhgate.com/dhgate/sellerhelpcn.php" target="_blank">帮助中心</a>。</p>
            </div>
         </div>

    <form name="msghistory" id="msghistory" action="/mydhgate/csmsg/leavemsg.do?act=showListMsg" method="post" 360chrome_form_autofill="2">
    	<div class="search-condition">
				<div class="module-title1">搜索条件：</div>
                   <div class="search-list">
    			<ul>
                  <li class="clearfix">
                    <span class="search-option">
						创建时间：
                    <select name="i_time" id="i_time" size="1">
                    	<option value="">--全部--</option>
						<option value="lw">一周内</option>
    					<option value="lm">一月内</option>
    					<option value="wsm">半年内</option>
    					<option value="way">一年内</option>
    					<option value="oya">一年前</option>
                    </select>
                    </span>
                    <span class="search-option">
						是否阅读：
                    <select name="isread" id="isread" size="1">
                    	<option value="">--全部--</option>
                    	<option value="0">未读</option>
						<option value="1">已读</option>
                    </select>
                    </span>
                    <span class="search-option">
						是否回复：
                    <select name="isreplied" id="isreplied" size="1">
                    	<option value="">--全部--</option>
						<option value="0">未回复</option>
						<option value="1">已回复</option>
                    </select>
            </span>
    			  </li>
                <li class="clearfix">
            	<span class="search-option">
    					问题分类：
                            <select name="type" class="question-sort" id="typevalue" size="1">
                            	<option value="">--全部--</option>
    							    								<option value="b391ef5032c4b9eae04010ac0b644f10">平台,信用卡纠纷的证据提交</option>
    							    								<option value="b3922090b1052faee04010ac0b6460a8">增值服务</option>
    							    								<option value="b392212beb1d89bfe04010ac0b6461e4">敦煌工具</option>
    							    								<option value="EAC9F58197A65435E04010AC0C644433">注册认证</option>
    							    								<option value="EACA8DBBAE8750B5E04010AC0C643712">资金账户</option>
    							    								<option value="EACAC9F4B42F2DB1E04010AC0C641525">其他</option>
    							    								<option value="EACA0FCC7825A38FE04010AC0C647008">后台功能</option>
    							    								<option value="EACA58940FD1D23EE04010AC0C6461E4">订单交易</option>
    							    								<option value="EACA70E236901C7FE04010AC0C6406E8">物流相关</option>
    							    								<option value="EACA9E39C90566D7E04010AC0C6453D7">处罚管理</option>
    							    								<option value="EACA80DEE26F694EE04010AC0C642345">交易纠纷</option>
    							    								<option value="EACA413FF1CFFFBBE04010AC0C643BFA">产品相关.</option>
    							    								<option value="EACAC4C10FF0EA10E04010AC0C640EA9">活动与公告</option>
    							    								<option value="EACAC733058C104FE04010AC0C641196">技术问题</option>
    							    								<option value="EACA509E406A04CDE04010AC0C645598">推广营销</option>
    							                            </select>
                            </span>
    						<span class="yellowBtn"><input name="i_button" id="i_button" onclick="filterButton();" type="button" value="搜 索"></span>
                        </li>
                    </ul>
                    </div>
            </div>
    		<div class="message-title-list">
            	<ul class="clearfix">
                	<li class="col1">状态</li>
                    <li class="col2">发起人</li>
                    <li class="col3">标题</li>
                    <li class="col4">创建时间</li>
                    <li class="col5">回复数</li>
                    <li class="col6">最后回复时间</li>
                    <li class="col7">最后回复人</li>
                </ul>
             </div>
		 
		 <div class="message-content-list">
	<div class="message-operation">
    	<span class="select-all"><input name="checkbox" onclick="checkAll(this,'messageAll')" type="checkbox" value=""> <label>全选</label></span>
        <span id="uplight" style="display: none;">
            <span class="tourBtn"><input name="ss" onclick="deleteButton(this,'messageAll')" type="submit" value="删除"></span>
			<span class="tourBtn"><input name="ss" onclick="readButton(this,'messageAll')" type="button" value="标记为已读"></span>
			<span class="tourBtn"><input name="ss" onclick="unreadButton(this,'messageAll')" type="button" value="标记为未读"></span>
        </span>
        <span id="updark">
            <span class="unclickbutton1"><span>删除</span></span>
			<span class="unclickbutton1"><span>标记为已读</span></span>
			<span class="unclickbutton1"><span>标记为未读</span></span>
        </span>
	</div>

		<table class="without-border-table" cellspacing="0" cellpadding="0">
							<tbody><tr>
    				<td height="150" colspan="8">
						<img width="14" height="15" class="seller-icon10" src="http://image.dhgate.com/2008/web20/seller/img/blank.gif"><strong>您暂时没有留言信息！</strong>
					</td>
            	</tr>
			      	</tbody></table>
		<div class="message-operation">
            	<span class="select-all"><input name="checkbox" onclick="checkAll(this,'messageAll')" type="checkbox" value=""> <label>全选</label></span>
                <span id="downlight" style="display: none;">
                    <span class="tourBtn"><input name="ss" onclick="deleteButton(this,'messageAll')" type="submit" value="删除"></span>
					<span class="tourBtn"><input name="ss" onclick="readButton(this,'messageAll')" type="button" value="标记为已读"></span>
					<span class="tourBtn"><input name="ss" onclick="unreadButton(this,'messageAll')" type="button" value="标记为未读"></span>
                </span>
                <span id="downdark">
                    <span class="unclickbutton1"><span>删除</span></span>
					<span class="unclickbutton1"><span>标记为已读</span></span>
					<span class="unclickbutton1"><span>标记为未读</span></span>
                </span>
			</div>
		</div>
		<input name="messagelist" id="messagelist" type="hidden" value="" property="messagelist">
		<input name="page" id="page" type="hidden" value="">
		<input name="act" id="act" type="hidden" value="showListMsg">
    </form>
	</div></div>
									</div>
            </div>
	<#-- left bar -->
  				${screens.render("component://portal/widget/SellerScreens.xml#messageLeft")}
            
		</div>
    </div>
</body>
</head>
</html>