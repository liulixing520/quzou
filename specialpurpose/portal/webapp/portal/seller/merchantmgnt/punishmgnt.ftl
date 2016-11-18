<link rel="stylesheet" type="text/css" href="../images/css/general_popup_box.css">
<link rel="stylesheet" type="text/css" href="../images/css/common20111215.css">
<link rel="stylesheet" type="text/css" href="../images/css/merchantassessment.css">
<link rel="stylesheet" type="text/css" href="../images/css/punish-manage.css">
<link rel="stylesheet" type="text/css" href="../images/css/seller.css">

<link rel="stylesheet" type="text/css" href="../images/css/common.js">
<link rel="stylesheet" type="text/css" href="../images/css/dc.js">
<link rel="stylesheet" type="text/css" href="../images/css/dhta2.js">
<link rel="stylesheet" type="text/css" href="../images/css/jquery.simplemodal2.js">
<link rel="stylesheet" type="text/css" href="../images/css/jquery-time.js">
<link rel="stylesheet" type="text/css" href="../images/css/menu-common_20111226.js">
<link rel="stylesheet" type="text/css" href="../images/css/merchantassessment.js">
<link rel="stylesheet" type="text/css" href="../images/css/poplayer.js">
<link rel="stylesheet" type="text/css" href="../images/css/punish-manage.js">



            <div class="content">
					<div class="crumb">
        		<a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/dmrs/dmrsaction.do">商户管理</a><span>&gt;</span><a href="./处罚管理详情_files/处罚管理详情.htm">处罚管理</a><span>&gt;</span>	处罚管理详情	
            </div>
				<div class="layout clearfix">
            <div class="col-main">
               		<div id="right">
				<!--右侧内容 开始-->
                    <div class="page-topic clearfix">
                        <h2>处罚管理</h2>
                    </div>
                    <div class="punish-sailtips">
                    	<span class="tips-title">温馨提示：</span>
                        <div class="tips-con">
                        	<p>1.如果您对敦煌网作出的处罚行为有异议，请在10个自然日内进行处罚申诉，敦煌网将根据卖家所提供的证据进行再次审核。</p>
                            <p>2.对于申诉成功的卖家，敦煌网将解除相关处罚记录。</p>
                        </div>
                    </div>
                    <div id="punishTabWrap">
                    	<ul class="punish-tab">
                        	<li class="current"><span onclick="changePage(&#39;0&#39;);">所有处罚</span></li>
                            <li><span onclick="changePage(&#39;1&#39;);">可申诉处罚</span></li>
                            <li><span onclick="changePage(&#39;2&#39;);">申诉结果查询</span></li>
                        </ul>
                    	<!--搜索条件 开始-->
						<form id="punishForm" method="post" action="http://seller.dhgate.com/punish/punishManage/getPunishInfo.do">
							<input type="hidden" id="type" name="type" value="0">
							<input type="hidden" id="isShow" name="queryParmDTO.isShow" value="0">
                        <div class="p-search-wrap">
                            <div class="p-search-inner">
                                <p><span class="p-search-name">处罚日期：</span>
									<input id="punishStartTime" name="queryParmDTO.punishStartTime" value="" class="punish-input calendarFocus" type="text" size="10" readonly="readonly"><span class="calendar_append"></span>
									<b class="join-time">到</b>
									<input id="punishEndTime" name="queryParmDTO.punishEndTime" value="" class="punish-input calendarFocus punish-m1" type="text" size="10" readonly="readonly"><span class="calendar_append"></span>
									<span class="p-search-name">处罚类型：</span>
									<select id="punishType" name="queryParmDTO.punishType" class="punish-select punish-m1">
										<option value="">请选择</option>
										        									        																			        									        									<option value="1010">警告</option>
        																			        									        									<option value="2014">终止账户</option>
        																			        									        									<option value="2013">关闭账户</option>
        																			        									        									<option value="2012">限制提款（无/固定期限）</option>
        																			        									        									<option value="2011">期限冻结</option>
        																			        									        									<option value="201011">限制类目经营</option>
        																			        									        									<option value="201010">限制更新和上传产品</option>
        																			        									        									<option value="1011">黄牌</option>
        																												</select>
									<span id="pSearchBtn1" class="yellowBtn valmiddle"><input id="pSearchBtn1Input" type="button" onclick="querySubmit();" value="搜 索" class="e-text-fam"></span>
								</p>
                                <div id="hideSearch" style="display:none;"> 
                                    <p>
										<span class="p-search-name">处罚编号：</span><input id="punishId" name="queryParmDTO.punishId" value="" class="punish-input punish-m1" type="text" size="10">
										<span class="p-search-name">申诉状态：</span>
										<select id="appealStatus" name="queryParmDTO.appealStatus" class="punish-select punish-m1">
											<option value="">请选择</option>
											<option value="0">可申诉</option>
											<option value="1">申诉中</option>
											<option value="2">申诉成功</option>
											<option value="3">申诉失败</option>
										</select>
										<span class="p-search-name">处罚状态：</span>
										<select id="punishStatus" name="queryParmDTO.punishStatus" class="punish-select">
											<option value="">请选择</option>
											<option value="1">执行中</option>
											<option value="3">已申请解除</option>
											<option value="2">已解除</option>
										</select>
									</p>
                                    <p>
										<span class="p-search-name">订单号：</span><input id="orderid" name="queryParmDTO.orderId" value="" class="punish-input punish-m1" type="text" size="10">
										<span class="p-search-name">产品编号：</span><input id="productid" name="queryParmDTO.productId" value="" class="punish-input punish-m1" type="text" size="10">
										<span class="p-search-name" style="width:90px">可否申请解除：</span>
										<select id="isApplyUnfreeze" name="queryParmDTO.isApplyUnfreeze" class="punish-select">
											<option value="">请选择</option>
											<option value="0">是</option>
											<option value="1">否</option>
										</select>
									</p>
									<p class="search-btn">
										<span class="yellowBtn valmiddle"><input type="button" value="搜 索" onclick="querySubmit();" class="e-text-fam"></span>
									</p>
                                </div>
                                <span id="searchShowButton" onclick="isShowOrNot();" class="p-show-button">展开</span>
                            </div>
                        </div>
						
                        <!--搜索条件 结束-->
                        <div class="punish-main" style="display:block;">
                            <div class="p-search-number">您当前执行中的处罚有<strong class="punish-c1">0</strong>个，有<strong class="punish-c1">0</strong>个可以申请解除</div>
                            <div class="punish-list">
                            	<table width="100%" cellpadding="0" cellspacing="0">
                                	<thead>
                                    	<tr>
                                        	<th width="15%">处罚编号</th>
                                            <th width="15%">处罚日期</th>
                                            <th width="20%">处罚类型</th>
                                            <th width="15%">处罚原因</th>
                                            <th width="10%">处罚期限</th>
                                            <th width="15%">处罚状态</th>
                                            <th width="10%">操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										                                    </tbody>
                                </table>
                            </div>
                           							                            </div>
						</form>
            	    </div>
        	    </div>
            <script type="text/javascript">
                            $(document).ready(function(){
                                var nowDate = new Date();
                                var nowTime = nowDate.getTime();
                                var endTime = new Date(2014,0,1,0,0,0);
                                if(endTime-nowTime>0){
                                    var value = getCookie("dh_survey");
                                    if(value!=null&&value=="hide"){
                                        document.getElementById("survey").style.display="none";
                                    }else{
                                        document.getElementById("survey").style.display="";
                                    }
                                }else{
                                    document.getElementById("survey").style.display="";
                                }
                            })
                            //取COOKIE
                            function getCookie(Name){ 
                                var end = '';
                                var search = Name + "=" ;
                                if(document.cookie.length > 0) { 
                                    var offset = document.cookie.indexOf(search);
                                    if(offset != -1) { 
                                        offset += search.length; 
                                        end = document.cookie.indexOf(";", offset); 
                                        if(end == -1){
                                            end = document.cookie.length ;
                                        }	
                                        return document.cookie.substring(offset, end); 
                                    }else{
                                        return "";
                                    }	
                                } 
                            }
                            //设置COOKIE 下次不再显示
                            function hideNextTime(){
                                    var now = new Date();
                                    var month = now.getMonth();
                                    var expiredate = new Date();
                                    if(month < 3){
                                        expiredate.setMonth(2);
                                        expiredate.setDate(31);
                                    }else if(month < 6){
                                        expiredate.setMonth(5);
                                        expiredate.setDate(30);
                                    }else if(month < 9){
                                        expiredate.setMonth(8);
                                        expiredate.setDate(30);
                                    }else{
                                        expiredate.setMonth(11);
                                        expiredate.setDate(31);
                                    }
                                    expiredate.setHours(23);
                                    expiredate.setMinutes(59);
                                    expiredate.setSeconds(59);
                                    setCookieUseEncodeURI("dh_survey", "hide", expiredate, "/", ".dhgate.com", false);
                            }
                            function setCookieUseEncodeURI(name, value, expires, path, domain, secure) {
                                  var curCookie = name + "=" + encodeURI(value) +
                                      ((expires) ? "; expires=" + expires.toGMTString() : "") +
                                      ((path) ? "; path=" + path : "") +
                                      ((domain) ? "; domain=" + domain : "") +
                                      ((secure) ? "; secure" : "");
                                  document.cookie = curCookie;
                            }
                        </script>
<!--查看详情弹层 开始-->

<!--查看详情弹层 结束-->
<!--申请解除弹层 开始-->
<div id="applyRelievePop" style="display:none;">
    <table class="noshade-pop-table" style="width:400px;">
        <tbody><tr>
            <td class="t-lt"></td>
            <td class="t-mid"></td>
            <td class="t-ri"></td>
        </tr>
        <tr>
            <td class="m-lt"></td>
            <td class="m-mid">
                <div class="mid-warp">
                    <div class="noshade-pop-content">
                        <div class="noshade-pop-title">
                            <span><strong>申请解除操作提示：</strong></span>
                        </div>
                        <div class="noshade-pop-inner">
                            <div class="box1">
                                <p id="appUnFreeTips" class="align-center">您的申请解除提交成功，申请记录将在敦煌网审核通过后解除。</p>
                                <div class="align-center pop-button">
                                    <a href="javascript:void(0)" class="yellowbutton1 s-margin3" closepop="close"><span closepop="close">关闭</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="noshade-pop-bot"></div>
                    </div>
                    <a class="noshade-pop-close" href="javascript:void(0)" closepop="close"></a>
                </div>
            </td>
            <td class="m-ri"></td>
        </tr>
        <tr>
            <td class="b-lt"></td>
            <td class="b-mid"></td>
            <td class="b-ri"></td>
        </tr>
    </tbody></table>
</div>
<!--申请解除弹层 结束-->


<script>
	//展开收起
	function isShowOrNot(){
		var isShow = $('#isShow').val();
		if(isShow=="1"){
			$('#isShow').val("0");
		}else{
			$('#isShow').val("1");
		}
	}
	//申请解除
	function applyUnfreeze(punishId){
		jQuery.ajax({
            url:"/punish/punishManage/applyUnfreeze.do",
            data:{punishId:punishId},
            success:function (result) {
				if(result==true){
					$('#appUnFreeTips').text('您的申请解除提交成功，申请记录将在敦煌网审核通过后解除。');
				}else{
					$('#appUnFreeTips').text('申请失败，请重试');
				}
				var punishRelievePop = new applyRelievePop();
            },
			error:function(e){
				$('#appUnFreeTips').text('申请失败，请重试');
				var punishRelievePop = new applyRelievePop();
			}
        });
	}
	//提交
    function querySubmit(){
    	$('#punishForm').submit();
    }
	//切换TAB页面
	function changePage(type){
		//切换tab时重置所有查询参数
		$('#isShow').val("0");
		$('#punishStartTime').val('');
		$('#punishEndTime').val('');
		$('#punishType').val('');
		$('#punishId').val('');
		$('#appealStatus').val('');
		$('#punishStatus').val('');
		$('#isApplyUnfreeze').val('');
		$('#orderid').val('');
		$('#productid').val('');
		$('#type').val(type);
		$('#punishForm').submit();
	}
</script>
			</div>
			<div class="col-left">
				                    <script type="text/javascript">
					    $(document).ready(function(){
						})
						//取COOKIE
						function getCookie(Name){ 
                        	var end = '';
                            var search = Name + "=" ;
                            if(document.cookie.length > 0) { 
                                var offset = document.cookie.indexOf(search);
                                if(offset != -1) { 
                                    offset += search.length; 
                                    end = document.cookie.indexOf(";", offset); 
                                    if(end == -1){
                        				end = document.cookie.length ;
                        			}	
                                    return document.cookie.substring(offset, end); 
                            	}else{
                        			return "";
                        		}	
                       	   	} 
                        }
						//设置COOKIE 下次不再显示
    					function hideNextTime(){
                    		var expiredate = new Date();
                    		var day30 = new Array(1, 3, 5, 8, 10);
                    		
                    		var month = expiredate.getMonth();
                    		var day = 31;
                    		for(var i = 0; i< day30.length; i++){
                    			if(month == day30[i]){
                    				day = 30;
                    				break;
                    			}
                    		}
                    		expiredate.setDate(day);
                    		expiredate.setHours(23);
                    		expiredate.setMinutes(59);
                    		expiredate.setSeconds(59);
                    		setCookieUseEncodeURI("dh_survey", "hide", expiredate, "/", ".dhgate.com", false);
    					}
    					function setCookieUseEncodeURI(name, value, expires, path, domain, secure) {
                        	  var curCookie = name + "=" + encodeURI(value) +
                        	      ((expires) ? "; expires=" + expires.toGMTString() : "") +
                        	      ((path) ? "; path=" + path : "") +
                        	      ((domain) ? "; domain=" + domain : "") +
                        	      ((secure) ? "; secure" : "");
                        	  document.cookie = curCookie;
    					}
					</script>
					<input type="hidden" id="currentPath" value="10009,32">
					                             <div id="secondMenu" class="second-menu clearfix">
    							    								    									<div class=" h-title2 t-current"><h2 onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39;Left-处罚管理&#39;]);"><a href="./处罚管理详情_files/处罚管理详情.htm" id="Menu_32" class="current">处罚管理</a></h2></div>
    								    							    								    									<div class="h-title2"><h2 onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39;Left-商户评级&#39;]);"><a href="http://seller.dhgate.com/dmrs/dmrsaction.do" id="Menu_29">商户评级</a></h2></div>
    								    							                                 
                             </div>
										
					<div class="catalog">
                        <div class="h-title">
                            <h3>快捷入口</h3>
                            <a href="javascript:void(0)" class="setup" id="M_btn_setQuick">设置</a>
                        </div>
                        <div class="catalog-list clearfix" id="M_div_quickList" style="display:none">
								<a href="http://seller.dhgate.com/marketing/signup/spread"><b>GoogleShopping推广</b></a>
                            <ul id="M_quickList_ul">
							                              <li id="M_quick_li_0601"><a href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&dhpath=10002,06,0601" id="M_quick_0601" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39; Left-快捷入口&#39;,&#39;全部订单&#39;]);">全部订单</a></li><li id="M_quick_li_0201"><a href="http://seller.dhgate.com/syi/category.do" id="M_quick_0201" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39; Left-快捷入口&#39;,&#39;添加新产品&#39;]);">添加新产品</a></li><li id="M_quick_li_0202"><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202" id="M_quick_0202" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39; Left-快捷入口&#39;,&#39;管理产品&#39;]);">管理产品</a></li><li id="M_quick_li_0801"><a href="http://seller.dhgate.com/store/pageload.do?dhpath=10001,08,0801" id="M_quick_0801" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39; Left-快捷入口&#39;,&#39;商铺信息&#39;]);">商铺信息</a></li><li id="M_quick_li_0803"><a href="http://seller.dhgate.com/store/storeWindowManage.do?dhpath=10001,08,0803" id="M_quick_0803" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39; Left-快捷入口&#39;,&#39;橱窗管理&#39;]);">橱窗管理</a></li><li id="M_quick_li_7001"><a href="http://seller.dhgate.com/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001" id="M_quick_7001" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39; Left-快捷入口&#39;,&#39;属性缺失产品&#39;]);">属性缺失产品</a></li></ul>
                        </div>
                        <div class="perdue-show" id="M_quickList_perdue"><a href="javascript:void(0)"><b></b></a></div>
						<div class="catalog-pop" id="M_div_pop_setQuick">
                            <div class="catalog-pop-main">
                                <div class="option-info">
                                    <h3>设置快捷入口</h3>
                                    <div class="clearfix option-remind">
                                        <p id="M_quickMenu_selAll">您最多可以设置<b>7</b>个快捷入口</p>
                                        <p class="caution" id="M_quickMenu_selMax" style="display:none">您已经选择了<b id="M_hasSel_count">6</b>个快捷入口</p>
                                        <div class="clear-option">
                                            <a href="javascript:void(0)" class="greybutton1" id="M_quickMenuClear_btn"><span>清空选项</span></a> <a href="javascript:void(0)" class="greybutton1" id="M_quickMenuRestore_btn"><span>还原选项</span></a>
                                        </div>
                                    </div>
                                    <a id="M_btn_setQuick_Cancel" class="catalog-pop-close" href="javascript:void(0)"></a>
                                </div>
                                <div class="all-option clearfix">
    								
    								 <div class="option-col">
                                        <h4>产品</h4>
                                        <dl>
    										    											
    											    												<dt>产品管理 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0201" value="0201"><label for="m_quick_cbox_0201" id="m_hid_name_0201">添加新产品</label> 
    																    																<input type="hidden" name="m_hid_url_0201" id="m_hid_url_0201" value="http://seller.dhgate.com/syi/category.do">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0202" value="0202"><label for="m_quick_cbox_0202" id="m_hid_name_0202">管理产品</label> 
    																    																<input type="hidden" name="m_hid_url_0202" id="m_hid_url_0202" value="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0209" value="0209"><label for="m_quick_cbox_0209" id="m_hid_name_0209">管理产品组</label> 
    																    																<input type="hidden" name="m_hid_url_0209" id="m_hid_url_0209" value="http://seller.dhgate.com/prodmanage/group/prodGroup.do?dhpath=10001,21001,0209">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0220" value="0220"><label for="m_quick_cbox_0220" id="m_hid_name_0220">关联产品模板</label> 
    																    																<input type="hidden" name="m_hid_url_0220" id="m_hid_url_0220" value="http://seller.dhgate.com/prodmanage/relModel/relModel.do?dhpath=10001,21001,0220">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    												<dt>产品诊断 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_7001" value="7001"><label for="m_quick_cbox_7001" id="m_hid_name_7001">属性缺失产品</label> 
    																<img width="11" height="12" class="valmiddle" src="img/new001.gif">    																<input type="hidden" name="m_hid_url_7001" id="m_hid_url_7001" value="/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_7002" value="7002"><label for="m_quick_cbox_7002" id="m_hid_name_7002">违规待处理产品</label> 
    																<img width="11" height="12" class="valmiddle" src="img/new001.gif">    																<input type="hidden" name="m_hid_url_7002" id="m_hid_url_7002" value="/prodrepeat/prodrepeatgroup/grouplist.do?dhpath=10001,70,7002">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    												<dt>一键达 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0221" value="0221"><label for="m_quick_cbox_0221" id="m_hid_name_0221">一键达搬家</label> 
    																    																<input type="hidden" name="m_hid_url_0221" id="m_hid_url_0221" value="/mydhgate/product/crawlstore.do?act=pageload&amp;dhpath=10001,22001,0221">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0222" value="0222"><label for="m_quick_cbox_0222" id="m_hid_name_0222">搬家记录</label> 
    																    																<input type="hidden" name="m_hid_url_0222" id="m_hid_url_0222" value="/mydhgate/product/crawlertask.do?act=findcrawlsource&amp;dhpath=10001,22001,0222">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0205" value="0205"><label for="m_quick_cbox_0205" id="m_hid_name_0205">运费模板管理 </label></dt>
    												<input type="hidden" name="m_hid_url_0205" id="m_hid_url_0205" value="http://seller.dhgate.com/frttemplate/pageload.do?act=pageload&amp;dhpath=10001,0205">
    											                             
    										    											
    											    												<dt>商铺 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0801" value="0801"><label for="m_quick_cbox_0801" id="m_hid_name_0801">商铺信息</label> 
    																    																<input type="hidden" name="m_hid_url_0801" id="m_hid_url_0801" value="/store/pageload.do?dhpath=10001,08,0801">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0802" value="0802"><label for="m_quick_cbox_0802" id="m_hid_name_0802">商铺装修</label> 
    																    																<input type="hidden" name="m_hid_url_0802" id="m_hid_url_0802" value="/store/style.do?dhpath=10001,08,0802">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0803" value="0803"><label for="m_quick_cbox_0803" id="m_hid_name_0803">橱窗管理</label> 
    																    																<input type="hidden" name="m_hid_url_0803" id="m_hid_url_0803" value="/store/storeWindowManage.do?dhpath=10001,08,0803">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0804" value="0804"><label for="m_quick_cbox_0804" id="m_hid_name_0804">商铺类目</label> 
    																<img width="11" height="12" class="valmiddle" src="img/new001.gif">    																<input type="hidden" name="m_hid_url_0804" id="m_hid_url_0804" value="/store/getStoreDisplayRule.do?dhpath=10001,08,0804">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0212" value="0212"><label for="m_quick_cbox_0212" id="m_hid_name_0212">备货管理 </label></dt>
    												<input type="hidden" name="m_hid_url_0212" id="m_hid_url_0212" value="http://seller.dhgate.com/prodmanage/inventory/doQueryInventory.do?dhpath=10001,0212">
    											                             
    										    											
    											    												<dt>产品服务设定 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2402" value="2402"><label for="m_quick_cbox_2402" id="m_hid_name_2402">海外退货服务设定</label> 
    																    																<input type="hidden" name="m_hid_url_2402" id="m_hid_url_2402" value="http://seller.dhgate.com/prodmanage/serviceset/prodLocalReturn.do?dhpath=10001,21002,2402">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0211" value="0211"><label for="m_quick_cbox_0211" id="m_hid_name_0211">产品相册 </label></dt>
    												<input type="hidden" name="m_hid_url_0211" id="m_hid_url_0211" value="http://seller.dhgate.com/album/albumsmanagerlist.do?act=pageload&amp;dhpath=10001,0211">
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0210" value="0210"><label for="m_quick_cbox_0210" id="m_hid_name_0210">申诉管理 </label></dt>
    												<input type="hidden" name="m_hid_url_0210" id="m_hid_url_0210" value="http://seller.dhgate.com/prodmanage/appeal/prodAppeal.do?dhpath=10001,0210">
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0217" value="0217"><label for="m_quick_cbox_0217" id="m_hid_name_0217">经营品牌 </label></dt>
    												<input type="hidden" name="m_hid_url_0217" id="m_hid_url_0217" value="/mydhgate/product/brands.do?act=sellerbrandlist&amp;dhpath=10001,0217">
    											                             
    										    									</dl>
    									
    									<h4>消息</h4>
                                        <dl>
    										    											
    											    												<dt>站内信 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_51001" value="51001"><label for="m_quick_cbox_51001" id="m_hid_name_51001">买家消息</label> 
    																    																<input type="hidden" name="m_hid_url_51001" id="m_hid_url_51001" value="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_51002" value="51002"><label for="m_quick_cbox_51002" id="m_hid_name_51002">系统消息</label> 
    																    																<input type="hidden" name="m_hid_url_51002" id="m_hid_url_51002" value="/messageweb/newmessagecenter.do?msgtype=004,005,006,007,008,009&amp;dhpath=10005,0301,51002">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_51003" value="51003"><label for="m_quick_cbox_51003" id="m_hid_name_51003">平台公告</label> 
    																    																<input type="hidden" name="m_hid_url_51003" id="m_hid_url_51003" value="/messageweb/newmessagecenter.do?msgtype=010,011,012,013&amp;dhpath=10005,0301,51003">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_51004" value="51004"><label for="m_quick_cbox_51004" id="m_hid_name_51004">垃圾箱</label> 
    																    																<input type="hidden" name="m_hid_url_51004" id="m_hid_url_51004" value="/messageweb/newmessagecenter.do?state=1&amp;dhpath=10005,0301,51004">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    												<dt>客服留言 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2701" value="2701"><label for="m_quick_cbox_2701" id="m_hid_name_2701">在线留言</label> 
    																    																<input type="hidden" name="m_hid_url_2701" id="m_hid_url_2701" value="/mydhgate/csmsg/leavemsg.do?dhpath=10005,52000,2701">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2702" value="2702"><label for="m_quick_cbox_2702" id="m_hid_name_2702">历史留言</label> 
    																    																<input type="hidden" name="m_hid_url_2702" id="m_hid_url_2702" value="/mydhgate/csmsg/leavemsg.do?act=showListMsg&amp;dhpath=10005,52000,2702">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    									</dl>
    									
    									<h4>资金账户</h4>
                                        <dl>
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0901" value="0901"><label for="m_quick_cbox_0901" id="m_hid_name_0901">交易记录 </label></dt>
    												<input type="hidden" name="m_hid_url_0901" id="m_hid_url_0901" value="/fundaccounting/accountDetail/detailList.do?dhpath=10006,0901">
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0907" value="0907"><label for="m_quick_cbox_0907" id="m_hid_name_0907">提前放款 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></label></dt>
    												<input type="hidden" name="m_hid_url_0907" id="m_hid_url_0907" value="/pria/service/priaOrderList.do?dhpath=10006,0907">
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0904" value="0904"><label for="m_quick_cbox_0904" id="m_hid_name_0904">保障金管理 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></label></dt>
    												<input type="hidden" name="m_hid_url_0904" id="m_hid_url_0904" value="/mydhgate/guaranteefund/securityaccount.do?act=pageload&amp;dhpath=10006,0904">
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0902" value="0902"><label for="m_quick_cbox_0902" id="m_hid_name_0902">敦煌币管理 </label></dt>
    												<input type="hidden" name="m_hid_url_0902" id="m_hid_url_0902" value="/mydhgate/dhb/dhblist.do?dhpath=10006,0902">
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0903" value="0903"><label for="m_quick_cbox_0903" id="m_hid_name_0903">优惠券管理 </label></dt>
    												<input type="hidden" name="m_hid_url_0903" id="m_hid_url_0903" value="/mydhgate/dhaccount/productcoupon.do?act=pageload&amp;dhpath=10006,0903">
    											                             
    										    											
    											    												<dt>建行敦煌“e保通” </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_9003" value="9003"><label for="m_quick_cbox_9003" id="m_hid_name_9003">功能介绍</label> 
    																    																<input type="hidden" name="m_hid_url_9003" id="m_hid_url_9003" value="/mydhgate/ccb/ccbuseraction.do?act=allservice&amp;dhpath=10006,90,9003">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0905" value="0905"><label for="m_quick_cbox_0905" id="m_hid_name_0905">在线贷款 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></label></dt>
    												<input type="hidden" name="m_hid_url_0905" id="m_hid_url_0905" value="/bankcorp/cmb/onlineloan.do?dhpath=10006,0905">
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0906" value="0906"><label for="m_quick_cbox_0906" id="m_hid_name_0906">账户设置 </label></dt>
    												<input type="hidden" name="m_hid_url_0906" id="m_hid_url_0906" value="/fundaccounting/ba/cnyAccInfo.do?dhpath=10006,0906">
    											                             
    										    									</dl>
    									
    								 </div>	
    									
                                   
    								
                                    <div class="option-col">
    									
    									<h4>交易</h4>
                                        <dl>
    										    											
    											    												<dt>我的订单 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0601" value="0601"><label for="m_quick_cbox_0601" id="m_hid_name_0601">全部订单</label> 
    																    																<input type="hidden" name="m_hid_url_0601" id="m_hid_url_0601" value="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0602" value="0602"><label for="m_quick_cbox_0602" id="m_hid_name_0602">纠纷订单</label> 
    																    																<input type="hidden" name="m_hid_url_0602" id="m_hid_url_0602" value="/sellerordmng/orderList/disputeOrderList.do?params.linkType=200&amp;dhpath=10002,06,0602">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0603" value="0603"><label for="m_quick_cbox_0603" id="m_hid_name_0603">批量导出订单</label> 
    																    																<input type="hidden" name="m_hid_url_0603" id="m_hid_url_0603" value="/mydhgate/order/batchexportorder.do?act=pageload&amp;dhpath=10002,06,0603">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_22" value="22"><label for="m_quick_cbox_22" id="m_hid_name_22">佣金返还 </label></dt>
    												<input type="hidden" name="m_hid_url_22" id="m_hid_url_22" value="http://seller.dhgate.com/mydhgate/order/commissionreturn.do?act=pageload&amp;dhpath=10002,22">
    											                             
    										    											
    											    												<dt>在线物流 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0501" value="0501"><label for="m_quick_cbox_0501" id="m_hid_name_0501">国际E邮宝</label> 
    																    																<input type="hidden" name="m_hid_url_0501" id="m_hid_url_0501" value="/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=0&amp;dhpath=10002,05,0501">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0502" value="0502"><label for="m_quick_cbox_0502" id="m_hid_name_0502">仓库发货</label> 
    																    																<input type="hidden" name="m_hid_url_0502" id="m_hid_url_0502" value="/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=12&amp;dhpath=10002,05,0502">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    												<dt>评价和评论管理 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0701" value="0701"><label for="m_quick_cbox_0701" id="m_hid_name_0701">交易评价管理</label> 
    																    																<input type="hidden" name="m_hid_url_0701" id="m_hid_url_0701" value="/mydhgate/feedback/feedbacklist.do?act=pageload&amp;dhpath=10002,07,0701">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0702" value="0702"><label for="m_quick_cbox_0702" id="m_hid_name_0702">产品评论管理</label> 
    																    																<input type="hidden" name="m_hid_url_0702" id="m_hid_url_0702" value="/mydhgate/review/reviewlist.do?dhpath=10002,07,0702">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    												<dt>我的买家 </dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0401" value="0401"><label for="m_quick_cbox_0401" id="m_hid_name_0401">买家名单</label> 
    																    																<input type="hidden" name="m_hid_url_0401" id="m_hid_url_0401" value="/mydhgate/mybuyer/mybuyer.do?dhpath=10002,04,0401">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_0402" value="0402"><label for="m_quick_cbox_0402" id="m_hid_name_0402">买家黑名单</label> 
    																    																<input type="hidden" name="m_hid_url_0402" id="m_hid_url_0402" value="/mydhgate/mybuyer/mybuyer.do?isBlackBuyer=1&amp;dhpath=10002,04,0402">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    									</dl>
    									
    									<h4>数据智囊</h4>
                                        <dl>
    										    											
    											    												<dt>商铺解析 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_6001" value="6001"><label for="m_quick_cbox_6001" id="m_hid_name_6001">商铺概况</label> 
    																<img width="11" height="12" class="valmiddle" src="img/new001.gif">    																<input type="hidden" name="m_hid_url_6001" id="m_hid_url_6001" value="/wisdom/shopanalysis/toprofile.do?dhpath=10007,60,6001">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_6002" value="6002"><label for="m_quick_cbox_6002" id="m_hid_name_6002">我的买家</label> 
    																<img width="11" height="12" class="valmiddle" src="img/new001.gif">    																<input type="hidden" name="m_hid_url_6002" id="m_hid_url_6002" value="/wisdom/shopanalysis/toanalysis.do?dhpath=10007,60,6002">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    												<dt>行业动态 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></dt>
    												<dd>
                                                        <ul>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_6101" value="6101"><label for="m_quick_cbox_6101" id="m_hid_name_6101">行业概况</label> 
    																<img width="11" height="12" class="valmiddle" src="img/new001.gif">    																<input type="hidden" name="m_hid_url_6101" id="m_hid_url_6101" value="/wisdom/industryanalysis/toprofile.do?dhpath=10007,61,6101">
    															</li>
    														    															<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_6102" value="6102"><label for="m_quick_cbox_6102" id="m_hid_name_6102">买家情报</label> 
    																<img width="11" height="12" class="valmiddle" src="img/new001.gif">    																<input type="hidden" name="m_hid_url_6102" id="m_hid_url_6102" value="/wisdom/industryanalysis/toanalysis.do?dhpath=10007,61,6102">
    															</li>
    														                                                        </ul>
                                                    </dd>
    											    											
    											                             
    										    											
    											    											
    											    												<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_62" value="62"><label for="m_quick_cbox_62" id="m_hid_name_62">搜索词追踪 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></label></dt>
    												<input type="hidden" name="m_hid_url_62" id="m_hid_url_62" value="/wisdom/keyword/analysis.do?dhpath=1007,62">
    											                             
    										    									</dl>
    									
                                    </div>
    								
    								<div class="option-col">
    									
        								<h4>增值服务</h4>
                                        <dl>
        									        										
        										        										
        										        											<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_1001" value="1001"><label for="m_quick_cbox_1001" id="m_hid_name_1001">服务简介 </label></dt>
        											<input type="hidden" name="m_hid_url_1001" id="m_hid_url_1001" value="/mydhgate/service/serviceaction.do?act=allservice&amp;dhpath=10003,1001">
        										                             
        									        										
        										        										
        										        											<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_1002" value="1002"><label for="m_quick_cbox_1002" id="m_hid_name_1002">我的增值礼包 </label></dt>
        											<input type="hidden" name="m_hid_url_1002" id="m_hid_url_1002" value="/mydhgate/service/serviceaction.do?act=myservice&amp;dhpath=10003,1002">
        										                             
        									        										
        										        										
        										        											<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_1005" value="1005"><label for="m_quick_cbox_1005" id="m_hid_name_1005">我的功能包 </label></dt>
        											<input type="hidden" name="m_hid_url_1005" id="m_hid_url_1005" value="/mydhgate/premium/premiumInfo.do?act=getMyPremiumInfo&amp;dhpath=10003,1005">
        										                             
        									        										
        										        										
        										        											<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_1201" value="1201"><label for="m_quick_cbox_1201" id="m_hid_name_1201">EDM推荐 </label></dt>
        											<input type="hidden" name="m_hid_url_1201" id="m_hid_url_1201" value="/mydhgate/edm/edmentrance.do?&amp;dhpath=10003,1201">
        										                             
        									        										
        										        											<dt>国外求购信息 </dt>
        											<dd>
                                                        <ul>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_1801" value="1801"><label for="m_quick_cbox_1801" id="m_hid_name_1801">查看国外求购信息</label> 
        															        															<input type="hidden" name="m_hid_url_1801" id="m_hid_url_1801" value="/wantitnow/wantitnowseller/wantindex.do?dhpath=10003,18,1801">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_1802" value="1802"><label for="m_quick_cbox_1802" id="m_hid_name_1802">已回复的求购信息</label> 
        															        															<input type="hidden" name="m_hid_url_1802" id="m_hid_url_1802" value="/wantitnow/wantitnowseller/doload.do?dhpath=10003,18,1802">
        														</li>
        													                                                        </ul>
                                                    </dd>
        										        										
        										                             
        									        								</dl>
    								
    									<h4>推广营销</h4>
                                        <dl>
        									        										
        										        											<dt>促销活动 </dt>
        											<dd>
                                                        <ul>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3001" value="3001"><label for="m_quick_cbox_3001" id="m_hid_name_3001">平台活动</label> 
        															        															<input type="hidden" name="m_hid_url_3001" id="m_hid_url_3001" value="/promoweb/platformacty/actylist.do?ptype=1&amp;dhpath=10004,30,3001">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3002" value="3002"><label for="m_quick_cbox_3002" id="m_hid_name_3002">店铺活动</label> 
        															        															<input type="hidden" name="m_hid_url_3002" id="m_hid_url_3002" value="/promoweb/storeacty/actylist.do?ptype=1&amp;dhpath=10004,30,3002">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3003" value="3003"><label for="m_quick_cbox_3003" id="m_hid_name_3003">促销日历</label> 
        															        															<input type="hidden" name="m_hid_url_3003" id="m_hid_url_3003" value="/promoweb/storeacty/actycalendar.do?ptype=1&amp;dhpath=10004,30,3003">
        														</li>
        													                                                        </ul>
                                                    </dd>
        										        										
        										                             
        									        										
        										        											<dt>敦煌产品营销系统 </dt>
        											<dd>
                                                        <ul>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2612" value="2612"><label for="m_quick_cbox_2612" id="m_hid_name_2612">首页</label> 
        															        															<input type="hidden" name="m_hid_url_2612" id="m_hid_url_2612" value="http://adcenter.dhgate.com">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2613" value="2613"><label for="m_quick_cbox_2613" id="m_hid_name_2613">我的广告</label> 
        															        															<input type="hidden" name="m_hid_url_2613" id="m_hid_url_2613" value="http://adcenter.dhgate.com/adindex/index?menuRoute=02">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2614" value="2614"><label for="m_quick_cbox_2614" id="m_hid_name_2614">竟价广告投放</label> 
        															        															<input type="hidden" name="m_hid_url_2614" id="m_hid_url_2614" value="http://adcenter.dhgate.com/bidding/products">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2615" value="2615"><label for="m_quick_cbox_2615" id="m_hid_name_2615">展示计划投放</label> 
        															        															<input type="hidden" name="m_hid_url_2615" id="m_hid_url_2615" value="http://adcenter.dhgate.com/showplan/productChoose">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2616" value="2616"><label for="m_quick_cbox_2616" id="m_hid_name_2616">数据报表</label> 
        															        															<input type="hidden" name="m_hid_url_2616" id="m_hid_url_2616" value="http://adcenter.dhgate.com/datareport/pageload?menuRoute=05">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_2617" value="2617"><label for="m_quick_cbox_2617" id="m_hid_name_2617">账务管理</label> 
        															        															<input type="hidden" name="m_hid_url_2617" id="m_hid_url_2617" value="http://adcenter.dhgate.com/paymentmanage/paymentList?menuRoute=06">
        														</li>
        													                                                        </ul>
                                                    </dd>
        										        										
        										                             
        									        										
        										        											<dt>流量快车 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></dt>
        											<dd>
                                                        <ul>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3301" value="3301"><label for="m_quick_cbox_3301" id="m_hid_name_3301">我的流量快车</label> 
        															<img width="11" height="12" class="valmiddle" src="img/new001.gif">        															<input type="hidden" name="m_hid_url_3301" id="m_hid_url_3301" value="http://seller.dhgate.com/marketweb/trafficbus/pageload.do?dhpath=10004,33,3301">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3302" value="3302"><label for="m_quick_cbox_3302" id="m_hid_name_3302">数据报表</label> 
        															<img width="11" height="12" class="valmiddle" src="img/new001.gif">        															<input type="hidden" name="m_hid_url_3302" id="m_hid_url_3302" value="http://seller.dhgate.com/marketweb/trafficbus/datareport.do?dhpath=10004,33,3302">
        														</li>
        													                                                        </ul>
                                                    </dd>
        										        										
        										                             
        									        										
        										        											<dt>GoogleShopping推广 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></dt>
        											<dd>
                                                        <ul>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3501" value="3501"><label for="m_quick_cbox_3501" id="m_hid_name_3501">新增推广产品</label> 
        															<img width="11" height="12" class="valmiddle" src="img/new001.gif">        															<input type="hidden" name="m_hid_url_3501" id="m_hid_url_3501" value="http://seller.dhgate.com/marketing/signup/apply">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3502" value="3502"><label for="m_quick_cbox_3502" id="m_hid_name_3502">我的推广产品 </label> 
        															<img width="11" height="12" class="valmiddle" src="img/new001.gif">        															<input type="hidden" name="m_hid_url_3502" id="m_hid_url_3502" value="http://seller.dhgate.com/marketing/signup/myapply">
        														</li>
        													                                                        </ul>
                                                    </dd>
        										        										
        										                             
        									        										
        										        											<dt>视觉精灵 <img width="11" height="12" class="valmiddle" src="img/new001.gif"></dt>
        											<dd>
                                                        <ul>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3401" value="3401"><label for="m_quick_cbox_3401" id="m_hid_name_3401">我的视觉精灵</label> 
        															<img width="11" height="12" class="valmiddle" src="img/new001.gif">        															<input type="hidden" name="m_hid_url_3401" id="m_hid_url_3401" value="/marketweb/vaslisting/pageload.do?dhpath=10004,34,3401">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3402" value="3402"><label for="m_quick_cbox_3402" id="m_hid_name_3402">数据报表</label> 
        															<img width="11" height="12" class="valmiddle" src="img/new001.gif">        															<input type="hidden" name="m_hid_url_3402" id="m_hid_url_3402" value="/marketweb/vaslisting/buydetail.do?sign=1&amp;dhpath=10004,34,3402">
        														</li>
        													                                                        </ul>
                                                    </dd>
        										        										
        										                             
        									        										
        										        											<dt>敦煌联盟 </dt>
        											<dd>
                                                        <ul>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3702" value="3702"><label for="m_quick_cbox_3702" id="m_hid_name_3702">主推产品</label> 
        															        															<input type="hidden" name="m_hid_url_3702" id="m_hid_url_3702" value="/union/supplier/getprods.do?dhpath=10004,37,3702">
        														</li>
        													        														<li><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_3703" value="3703"><label for="m_quick_cbox_3703" id="m_hid_name_3703">联盟产品交易订单</label> 
        															        															<input type="hidden" name="m_hid_url_3703" id="m_hid_url_3703" value="/union/supplier/getorders.do?dhpath=10004,37,3703">
        														</li>
        													                                                        </ul>
                                                    </dd>
        										        										
        										                             
        									        								</dl>
    									
    									<h4>商户管理</h4>
                                        <dl>
        									        										
        										        										
        										        											<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_32" value="32"><label for="m_quick_cbox_32" id="m_hid_name_32">处罚管理 </label></dt>
        											<input type="hidden" name="m_hid_url_32" id="m_hid_url_32" value="/punish/punishManage/getPunishInfo.do?dhpath=10009,32">
        										                             
        									        										
        										        										
        										        											<dt class="select-have"><input type="checkbox" name="m_quickMenu_cbox" id="m_quick_cbox_29" value="29"><label for="m_quick_cbox_29" id="m_hid_name_29">商户评级 </label></dt>
        											<input type="hidden" name="m_hid_url_29" id="m_hid_url_29" value="/dmrs/dmrsaction.do">
        										                             
        									        								</dl>
    									
                                    </div>
                                </div>
                                <div class="set-option">
                                    <a href="javascript:void(0)" class="yellowbutton2" id="M_btn_setQuick_confirm"><span>确 定</span></a> <a href="javascript:void(0)" class="greybutton2" id="M_btn_setQuick_Cancel2"><span>取 消</span></a>
                                </div>
                            </div>
                            <div class="catalog-pop-shadow"></div>
                            <div class="catalog-pop-sharp"></div>
                            <iframe scrolling="no" frameborder="0" style="position:absolute;top:0px; left:0px; z-index:-1; height:513px; width:615px; background-color:transparent;"></iframe>
						</div>
								
								
                    </div>
					                    <div class="help-contact"><a href="http://seller.dhgate.com/mydhgate/others/live800Sign.do?act=do400" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39;Lef –在线客服&#39;])"></a></div>
										
					                    																									                    					
					<div class="advance-loan">
						<a href="http://seller.dhgate.com/pria/service/priaOrderList.do?dhpath=10006,0907" title="提前放款"></a>
					</div>
					
                    <div class="download-box">
                        <div class="h-title1">
                            <h3>在线下载</h3>
                        </div>
                        <div class="download">
                            <ul>  
								<li><span>手机版</span><a href="http://seller.dhgate.com/seller/pro/377lp.html" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39;导航&#39;,&#39;Mobile App-Left&#39;]);">下载</a><img width="25" height="17" src="img/new.gif"></li>
                                <li><span>敦煌通2.0</span><a href="http://download.dhgate.com/dhtalk/dhtalk2.0.rar" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39;Download&#39;, &#39;敦煌通&#39;]);">下载</a></li>
                                <li><span>敦煌助理2.0</span><a href="http://dhgatehelper001.dhgate.com/DHAssistant20Setup.zip" onclick="_gaq.push([&#39;_trackEvent&#39;, &#39;Seller-mydh1&#39;, &#39;Download&#39;, &#39;敦煌助理&#39;]);">下载</a></li>
                            </ul>
                        </div>
                    </div>
													<div class="dhgatewx">
						<p>敦煌网官方活动微信，<br>扫描二维码，<br>接收最新活动资讯</p>
						<div class="dhgatewx-icon"><img src="img/DHgate-wx.jpg" width="112" height="112"></div>
					</div>

					
           

            </div>
        </div>


</div>
   	


<div id="calendar_div"></div><div id="checkDetailPop" style="display:none;">
	<table class="noshade-pop-table" style="width:500px;">
        <tbody><tr>
            <td class="t-lt"></td>
            <td class="t-mid"></td>
            <td class="t-ri"></td>
        </tr>
        <tr>
            <td class="m-lt"></td>
            <td class="m-mid">
                <div class="mid-warp">
                    <div class="noshade-pop-content">
                        <div class="noshade-pop-title">
                            <span><strong>处罚详情：</strong></span>
                        </div>
                        <div class="noshade-pop-inner">
                            <div class="box1">
                                <div id="checkDetailMain"></div>
                                <div class="align-center pop-button">
                                    <a href="javascript:;" class="yellowbutton1 s-margin3" conduct="close"><span conduct="close">关闭</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="noshade-pop-bot"></div>
                    </div>
                    <a class="noshade-pop-close" href="javascript:;" conduct="close"></a>
                </div>
            </td>
            <td class="m-ri"></td>
        </tr>
        <tr>
            <td class="b-lt"></td>
            <td class="b-mid"></td>
            <td class="b-ri"></td>
        </tr>
    </tbody></table>
</div><div id="detailPopupMask" style="display:none;"><iframe id="detailPopupMaskIframe"></iframe></div></body></html>