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

<input id="currentPath" value="10001,21001,0202" type="hidden">
<div id="secondMenu" class="second-menu clearfix">
  <div id="Menu_21001" class="h-title2 t-current" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品管理']);">
    <h2>产品管理</h2>
    <b class="menu-show"></b></div>
  <dl style="display: block;">
    <dt id="Menu_0201"><a  href="<@ofbizUrl>EditProduct</@ofbizUrl>">添加新产品</a></dt>
    <dt id="Menu_0202"><a class="current" href="<@ofbizUrl>goodsMgnt</@ofbizUrl>">管理产品 </a></dt>
    <dt id="Menu_0209"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品管理','管理产品组']);" href="<@ofbizUrl>goodsGroupMgnt</@ofbizUrl>">管理产品组 </a></dt>
    <dt id="Menu_0220"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品管理','关联产品模板']);" href="<@ofbizUrl>goodsModule</@ofbizUrl>">关联产品模板 </a></dt>
  </dl>
  <div id="Menu_70" class="h-title2" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品诊断']);">
    <h2>产品诊断</h2>
    <b class="menu-show"></b></div>
  <dl style="display: block;">
    <dt id="Menu_7001"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品诊断','属性缺失产品']);" href="<@ofbizUrl>lackductattribute</@ofbizUrl>">属性缺失产品 <img class="marginlr5 valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></a></dt>
    <dt id="Menu_7002"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品诊断','违规待处理产品']);" href="<@ofbizUrl>lllegalductprocessed</@ofbizUrl>">违规待处理产品 <img class="marginlr5 valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></a></dt>
  </dl>
  <div id="Menu_22001" class="h-title2 t-mouseover" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-一键达']);">
    <h2>一键达</h2>
    <b class="menu-show"></b></div>
  <dl style="display: block;">
    <dt id="Menu_0221"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-一键达','一键达搬家']);" href="<@ofbizUrl>keyupmove</@ofbizUrl>">一键达搬家 </a></dt>
    <dt id="Menu_0222"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-一键达','搬家记录']);" href="<@ofbizUrl>movingrecords</@ofbizUrl>">搬家记录 </a></dt>
  </dl>
  <div class="h-title2">
    <h2 onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-运费模板管理']);"><a id="Menu_0205" href="<@ofbizUrl>freightemplatemanage</@ofbizUrl>">运费模板管理</a></h2>
  </div>
  <div id="Menu_08" class="h-title2" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-商铺']);">
    <h2>商铺</h2>
    <b class="menu-show"></b></div>
  <dl style="display: block;">
    <dt id="Menu_0801"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-商铺','商铺信息']);" href="<@ofbizUrl>store</@ofbizUrl>">商铺信息 </a></dt>
    <dt id="Menu_0802"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-商铺','商铺装修']);" href="<@ofbizUrl>shopdecoration</@ofbizUrl>">商铺装修 </a></dt>
    <dt id="Menu_0803"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-商铺','橱窗管理']);" href="<@ofbizUrl>windowmanage</@ofbizUrl>">橱窗管理 </a></dt>
    <dt id="Menu_0804"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-商铺','商铺类目']);" href="<@ofbizUrl>shopscategory</@ofbizUrl>">商铺类目 <img class="marginlr5 valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></a></dt>
  </dl>
  <div class="h-title2">
    <h2 onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-备货管理']);"><a id="Menu_0212" href="<@ofbizUrl>stockmanage</@ofbizUrl>">备货管理</a></h2>
  </div>
  <div id="Menu_21002" class="h-title2" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品服务设定']);">
    <h2>产品服务设定</h2>
    <b class="menu-show"></b></div>
  <dl style="display: block;">
    <dt id="Menu_2402"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品服务设定','海外退货服务设定']);" href="<@ofbizUrl>overseaservice</@ofbizUrl>">海外退货服务设定 </a></dt>
  </dl>
  <div class="h-title2">
    <h2 onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-产品相册']);"><a id="Menu_0211" href="<@ofbizUrl>ductphotoalbum</@ofbizUrl>">产品相册</a></h2>
  </div>
  <div class="h-title2">
    <h2 onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-申诉管理']);"><a id="Menu_0210" href="<@ofbizUrl>complaintmanage</@ofbizUrl>">申诉管理</a></h2>
  </div>
  <div class="h-title2">
    <h2 onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Left-经营品牌']);"><a id="Menu_0217" href="<@ofbizUrl>brandmanage</@ofbizUrl>">经营品牌</a></h2>
  </div>
</div>
<div class="catalog">
  <div class="h-title">
    <h3>快捷入口</h3>
    <a id="M_btn_setQuick" class="setup" href="javascript:void(0)">设置</a> </div>
  <div style="display: none;" id="M_div_quickList" class="catalog-list clearfix"> <a href="http://seller.dhgate.com/marketing/signup/spread"><b>GoogleShopping推广</b></a>
    <ul id="M_quickList_ul">
      <li id="M_quick_li_0601"><a id="M_quick_0601" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', ' Left-快捷入口','全部订单']);" href="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601">全部订单</a></li>
      <li id="M_quick_li_0201"><a id="M_quick_0201" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', ' Left-快捷入口','添加新产品']);" href="http://seller.dhgate.com/syi/category.do">添加新产品</a></li>
      <li id="M_quick_li_0202"><a id="M_quick_0202" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', ' Left-快捷入口','管理产品']);" href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">管理产品</a></li>
      <li id="M_quick_li_0801"><a id="M_quick_0801" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', ' Left-快捷入口','商铺信息']);" href="/store/pageload.do?dhpath=10001,08,0801">商铺信息</a></li>
      <li id="M_quick_li_0803"><a id="M_quick_0803" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', ' Left-快捷入口','橱窗管理']);" href="/store/storeWindowManage.do?dhpath=10001,08,0803">橱窗管理</a></li>
      <li id="M_quick_li_7001"><a id="M_quick_7001" onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', ' Left-快捷入口','属性缺失产品']);" href="/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001">属性缺失产品</a></li>
    </ul>
  </div>
  <div id="M_quickList_perdue" class="perdue-show"><a href="javascript:void(0)"><b></b></a></div>
  <div id="M_div_pop_setQuick" class="catalog-pop">
    <div class="catalog-pop-main">
      <div class="option-info">
        <h3>设置快捷入口</h3>
        <div class="clearfix option-remind">
          <p id="M_quickMenu_selAll">您最多可以设置<b>7</b>个快捷入口</p>
          <p style="display: none;" id="M_quickMenu_selMax" class="caution">您已经选择了<b id="M_hasSel_count">6</b>个快捷入口</p>
          <div class="clear-option"> <a id="M_quickMenuClear_btn" class="greybutton1" href="javascript:void(0)"><span>清空选项</span></a> <a id="M_quickMenuRestore_btn" class="greybutton1" href="javascript:void(0)"><span>还原选项</span></a> </div>
        </div>
        <a id="M_btn_setQuick_Cancel" class="catalog-pop-close" href="javascript:void(0)"></a> </div>
      <div class="all-option clearfix">
        <div class="option-col">
          <h4>产品</h4>
          <dl>
            <dt>产品管理 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_0201" name="m_quickMenu_cbox" value="0201" type="checkbox">
                  <label id="m_hid_name_0201" for="m_quick_cbox_0201">添加新产品</label>
                  <input id="m_hid_url_0201" name="m_hid_url_0201" value="http://seller.dhgate.com/syi/category.do" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0202" name="m_quickMenu_cbox" value="0202" type="checkbox">
                  <label id="m_hid_name_0202" for="m_quick_cbox_0202">管理产品</label>
                  <input id="m_hid_url_0202" name="m_hid_url_0202" value="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0209" name="m_quickMenu_cbox" value="0209" type="checkbox">
                  <label id="m_hid_name_0209" for="m_quick_cbox_0209">管理产品组</label>
                  <input id="m_hid_url_0209" name="m_hid_url_0209" value="http://seller.dhgate.com/prodmanage/group/prodGroup.do?dhpath=10001,21001,0209" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0220" name="m_quickMenu_cbox" value="0220" type="checkbox">
                  <label id="m_hid_name_0220" for="m_quick_cbox_0220">关联产品模板</label>
                  <input id="m_hid_url_0220" name="m_hid_url_0220" value="http://seller.dhgate.com/prodmanage/relModel/relModel.do?dhpath=10001,21001,0220" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>产品诊断 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_7001" name="m_quickMenu_cbox" value="7001" type="checkbox">
                  <label id="m_hid_name_7001" for="m_quick_cbox_7001">属性缺失产品</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_7001" name="m_hid_url_7001" value="/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_7002" name="m_quickMenu_cbox" value="7002" type="checkbox">
                  <label id="m_hid_name_7002" for="m_quick_cbox_7002">违规待处理产品</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_7002" name="m_hid_url_7002" value="/prodrepeat/prodrepeatgroup/grouplist.do?dhpath=10001,70,7002" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>一键达 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_0221" name="m_quickMenu_cbox" value="0221" type="checkbox">
                  <label id="m_hid_name_0221" for="m_quick_cbox_0221">一键达搬家</label>
                  <input id="m_hid_url_0221" name="m_hid_url_0221" value="/mydhgate/product/crawlstore.do?act=pageload&amp;dhpath=10001,22001,0221" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0222" name="m_quickMenu_cbox" value="0222" type="checkbox">
                  <label id="m_hid_name_0222" for="m_quick_cbox_0222">搬家记录</label>
                  <input id="m_hid_url_0222" name="m_hid_url_0222" value="/mydhgate/product/crawlertask.do?act=findcrawlsource&amp;dhpath=10001,22001,0222" type="hidden">
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input id="m_quick_cbox_0205" name="m_quickMenu_cbox" value="0205" type="checkbox">
              <label id="m_hid_name_0205" for="m_quick_cbox_0205">运费模板管理 </label>
            </dt>
            <input id="m_hid_url_0205" name="m_hid_url_0205" value="http://seller.dhgate.com/frttemplate/pageload.do?act=pageload&amp;dhpath=10001,0205" type="hidden">
            <dt>商铺 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_0801" name="m_quickMenu_cbox" value="0801" type="checkbox">
                  <label id="m_hid_name_0801" for="m_quick_cbox_0801">商铺信息</label>
                  <input id="m_hid_url_0801" name="m_hid_url_0801" value="/store/pageload.do?dhpath=10001,08,0801" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0802" name="m_quickMenu_cbox" value="0802" type="checkbox">
                  <label id="m_hid_name_0802" for="m_quick_cbox_0802">商铺装修</label>
                  <input id="m_hid_url_0802" name="m_hid_url_0802" value="/store/style.do?dhpath=10001,08,0802" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0803" name="m_quickMenu_cbox" value="0803" type="checkbox">
                  <label id="m_hid_name_0803" for="m_quick_cbox_0803">橱窗管理</label>
                  <input id="m_hid_url_0803" name="m_hid_url_0803" value="/store/storeWindowManage.do?dhpath=10001,08,0803" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0804" name="m_quickMenu_cbox" value="0804" type="checkbox">
                  <label id="m_hid_name_0804" for="m_quick_cbox_0804">商铺类目</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_0804" name="m_hid_url_0804" value="/store/getStoreDisplayRule.do?dhpath=10001,08,0804" type="hidden">
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input id="m_quick_cbox_0212" name="m_quickMenu_cbox" value="0212" type="checkbox">
              <label id="m_hid_name_0212" for="m_quick_cbox_0212">备货管理 </label>
            </dt>
            <input id="m_hid_url_0212" name="m_hid_url_0212" value="http://seller.dhgate.com/prodmanage/inventory/doQueryInventory.do?dhpath=10001,0212" type="hidden">
            <dt>产品服务设定 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_2402" name="m_quickMenu_cbox" value="2402" type="checkbox">
                  <label id="m_hid_name_2402" for="m_quick_cbox_2402">海外退货服务设定</label>
                  <input id="m_hid_url_2402" name="m_hid_url_2402" value="http://seller.dhgate.com/prodmanage/serviceset/prodLocalReturn.do?dhpath=10001,21002,2402" type="hidden">
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input id="m_quick_cbox_0211" name="m_quickMenu_cbox" value="0211" type="checkbox">
              <label id="m_hid_name_0211" for="m_quick_cbox_0211">产品相册 </label>
            </dt>
            <input id="m_hid_url_0211" name="m_hid_url_0211" value="http://seller.dhgate.com/album/albumsmanagerlist.do?act=pageload&amp;dhpath=10001,0211" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_0210" name="m_quickMenu_cbox" value="0210" type="checkbox">
              <label id="m_hid_name_0210" for="m_quick_cbox_0210">申诉管理 </label>
            </dt>
            <input id="m_hid_url_0210" name="m_hid_url_0210" value="http://seller.dhgate.com/prodmanage/appeal/prodAppeal.do?dhpath=10001,0210" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_0217" name="m_quickMenu_cbox" value="0217" type="checkbox">
              <label id="m_hid_name_0217" for="m_quick_cbox_0217">经营品牌 </label>
            </dt>
            <input id="m_hid_url_0217" name="m_hid_url_0217" value="/mydhgate/product/brands.do?act=sellerbrandlist&amp;dhpath=10001,0217" type="hidden">
          </dl>
          <h4>消息</h4>
          <dl>
            <dt>站内信 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_51001" name="m_quickMenu_cbox" value="51001" type="checkbox">
                  <label id="m_hid_name_51001" for="m_quick_cbox_51001">买家消息</label>
                  <input id="m_hid_url_51001" name="m_hid_url_51001" value="/messageweb/newmessagecenter.do?msgtype=001,002,003&amp;dhpath=10005,0301,51001" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_51002" name="m_quickMenu_cbox" value="51002" type="checkbox">
                  <label id="m_hid_name_51002" for="m_quick_cbox_51002">系统消息</label>
                  <input id="m_hid_url_51002" name="m_hid_url_51002" value="/messageweb/newmessagecenter.do?msgtype=004,005,006,007,008,009&amp;dhpath=10005,0301,51002" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_51003" name="m_quickMenu_cbox" value="51003" type="checkbox">
                  <label id="m_hid_name_51003" for="m_quick_cbox_51003">平台公告</label>
                  <input id="m_hid_url_51003" name="m_hid_url_51003" value="/messageweb/newmessagecenter.do?msgtype=010,011,012,013&amp;dhpath=10005,0301,51003" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_51004" name="m_quickMenu_cbox" value="51004" type="checkbox">
                  <label id="m_hid_name_51004" for="m_quick_cbox_51004">垃圾箱</label>
                  <input id="m_hid_url_51004" name="m_hid_url_51004" value="/messageweb/newmessagecenter.do?state=1&amp;dhpath=10005,0301,51004" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>客服留言 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_2701" name="m_quickMenu_cbox" value="2701" type="checkbox">
                  <label id="m_hid_name_2701" for="m_quick_cbox_2701">在线留言</label>
                  <input id="m_hid_url_2701" name="m_hid_url_2701" value="/mydhgate/csmsg/leavemsg.do?dhpath=10005,52000,2701" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_2702" name="m_quickMenu_cbox" value="2702" type="checkbox">
                  <label id="m_hid_name_2702" for="m_quick_cbox_2702">历史留言</label>
                  <input id="m_hid_url_2702" name="m_hid_url_2702" value="/mydhgate/csmsg/leavemsg.do?act=showListMsg&amp;dhpath=10005,52000,2702" type="hidden">
                </li>
              </ul>
            </dd>
          </dl>
          <h4>资金账户</h4>
          <dl>
            <dt class="select-have">
              <input id="m_quick_cbox_0901" name="m_quickMenu_cbox" value="0901" type="checkbox">
              <label id="m_hid_name_0901" for="m_quick_cbox_0901">交易记录 </label>
            </dt>
            <input id="m_hid_url_0901" name="m_hid_url_0901" value="/fundaccounting/accountDetail/detailList.do?dhpath=10006,0901" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_0907" name="m_quickMenu_cbox" value="0907" type="checkbox">
              <label id="m_hid_name_0907" for="m_quick_cbox_0907">提前放款 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></label>
            </dt>
            <input id="m_hid_url_0907" name="m_hid_url_0907" value="/pria/service/priaOrderList.do?dhpath=10006,0907" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_0904" name="m_quickMenu_cbox" value="0904" type="checkbox">
              <label id="m_hid_name_0904" for="m_quick_cbox_0904">保障金管理 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></label>
            </dt>
            <input id="m_hid_url_0904" name="m_hid_url_0904" value="/mydhgate/guaranteefund/securityaccount.do?act=pageload&amp;dhpath=10006,0904" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_0902" name="m_quickMenu_cbox" value="0902" type="checkbox">
              <label id="m_hid_name_0902" for="m_quick_cbox_0902">敦煌币管理 </label>
            </dt>
            <input id="m_hid_url_0902" name="m_hid_url_0902" value="/mydhgate/dhb/dhblist.do?dhpath=10006,0902" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_0903" name="m_quickMenu_cbox" value="0903" type="checkbox">
              <label id="m_hid_name_0903" for="m_quick_cbox_0903">优惠券管理 </label>
            </dt>
            <input id="m_hid_url_0903" name="m_hid_url_0903" value="/mydhgate/dhaccount/productcoupon.do?act=pageload&amp;dhpath=10006,0903" type="hidden">
            <dt>建行敦煌“e保通” </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_9003" name="m_quickMenu_cbox" value="9003" type="checkbox">
                  <label id="m_hid_name_9003" for="m_quick_cbox_9003">功能介绍</label>
                  <input id="m_hid_url_9003" name="m_hid_url_9003" value="/mydhgate/ccb/ccbuseraction.do?act=allservice&amp;dhpath=10006,90,9003" type="hidden">
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input id="m_quick_cbox_0905" name="m_quickMenu_cbox" value="0905" type="checkbox">
              <label id="m_hid_name_0905" for="m_quick_cbox_0905">在线贷款 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></label>
            </dt>
            <input id="m_hid_url_0905" name="m_hid_url_0905" value="/bankcorp/cmb/onlineloan.do?dhpath=10006,0905" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_0906" name="m_quickMenu_cbox" value="0906" type="checkbox">
              <label id="m_hid_name_0906" for="m_quick_cbox_0906">账户设置 </label>
            </dt>
            <input id="m_hid_url_0906" name="m_hid_url_0906" value="/fundaccounting/ba/cnyAccInfo.do?dhpath=10006,0906" type="hidden">
          </dl>
        </div>
        <div class="option-col">
          <h4>交易</h4>
          <dl>
            <dt>我的订单 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_0601" name="m_quickMenu_cbox" value="0601" type="checkbox">
                  <label id="m_hid_name_0601" for="m_quick_cbox_0601">全部订单</label>
                  <input id="m_hid_url_0601" name="m_hid_url_0601" value="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&amp;dhpath=10002,06,0601" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0602" name="m_quickMenu_cbox" value="0602" type="checkbox">
                  <label id="m_hid_name_0602" for="m_quick_cbox_0602">纠纷订单</label>
                  <input id="m_hid_url_0602" name="m_hid_url_0602" value="/sellerordmng/orderList/disputeOrderList.do?params.linkType=200&amp;dhpath=10002,06,0602" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0603" name="m_quickMenu_cbox" value="0603" type="checkbox">
                  <label id="m_hid_name_0603" for="m_quick_cbox_0603">批量导出订单</label>
                  <input id="m_hid_url_0603" name="m_hid_url_0603" value="/mydhgate/order/batchexportorder.do?act=pageload&amp;dhpath=10002,06,0603" type="hidden">
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input id="m_quick_cbox_22" name="m_quickMenu_cbox" value="22" type="checkbox">
              <label id="m_hid_name_22" for="m_quick_cbox_22">佣金返还 </label>
            </dt>
            <input id="m_hid_url_22" name="m_hid_url_22" value="http://seller.dhgate.com/mydhgate/order/commissionreturn.do?act=pageload&amp;dhpath=10002,22" type="hidden">
            <dt>在线物流 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_0501" name="m_quickMenu_cbox" value="0501" type="checkbox">
                  <label id="m_hid_name_0501" for="m_quick_cbox_0501">国际E邮宝</label>
                  <input id="m_hid_url_0501" name="m_hid_url_0501" value="/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=0&amp;dhpath=10002,05,0501" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0502" name="m_quickMenu_cbox" value="0502" type="checkbox">
                  <label id="m_hid_name_0502" for="m_quick_cbox_0502">仓库发货</label>
                  <input id="m_hid_url_0502" name="m_hid_url_0502" value="/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=12&amp;dhpath=10002,05,0502" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>评价和评论管理 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_0701" name="m_quickMenu_cbox" value="0701" type="checkbox">
                  <label id="m_hid_name_0701" for="m_quick_cbox_0701">交易评价管理</label>
                  <input id="m_hid_url_0701" name="m_hid_url_0701" value="/mydhgate/feedback/feedbacklist.do?act=pageload&amp;dhpath=10002,07,0701" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0702" name="m_quickMenu_cbox" value="0702" type="checkbox">
                  <label id="m_hid_name_0702" for="m_quick_cbox_0702">产品评论管理</label>
                  <input id="m_hid_url_0702" name="m_hid_url_0702" value="/mydhgate/review/reviewlist.do?dhpath=10002,07,0702" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>我的买家 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_0401" name="m_quickMenu_cbox" value="0401" type="checkbox">
                  <label id="m_hid_name_0401" for="m_quick_cbox_0401">买家名单</label>
                  <input id="m_hid_url_0401" name="m_hid_url_0401" value="/mydhgate/mybuyer/mybuyer.do?dhpath=10002,04,0401" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_0402" name="m_quickMenu_cbox" value="0402" type="checkbox">
                  <label id="m_hid_name_0402" for="m_quick_cbox_0402">买家黑名单</label>
                  <input id="m_hid_url_0402" name="m_hid_url_0402" value="/mydhgate/mybuyer/mybuyer.do?isBlackBuyer=1&amp;dhpath=10002,04,0402" type="hidden">
                </li>
              </ul>
            </dd>
          </dl>
          <h4>数据智囊</h4>
          <dl>
            <dt>商铺解析 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_6001" name="m_quickMenu_cbox" value="6001" type="checkbox">
                  <label id="m_hid_name_6001" for="m_quick_cbox_6001">商铺概况</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_6001" name="m_hid_url_6001" value="/wisdom/shopanalysis/toprofile.do?dhpath=10007,60,6001" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_6002" name="m_quickMenu_cbox" value="6002" type="checkbox">
                  <label id="m_hid_name_6002" for="m_quick_cbox_6002">我的买家</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_6002" name="m_hid_url_6002" value="/wisdom/shopanalysis/toanalysis.do?dhpath=10007,60,6002" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>行业动态 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_6101" name="m_quickMenu_cbox" value="6101" type="checkbox">
                  <label id="m_hid_name_6101" for="m_quick_cbox_6101">行业概况</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_6101" name="m_hid_url_6101" value="/wisdom/industryanalysis/toprofile.do?dhpath=10007,61,6101" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_6102" name="m_quickMenu_cbox" value="6102" type="checkbox">
                  <label id="m_hid_name_6102" for="m_quick_cbox_6102">买家情报</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_6102" name="m_hid_url_6102" value="/wisdom/industryanalysis/toanalysis.do?dhpath=10007,61,6102" type="hidden">
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input id="m_quick_cbox_62" name="m_quickMenu_cbox" value="62" type="checkbox">
              <label id="m_hid_name_62" for="m_quick_cbox_62">搜索词追踪 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></label>
            </dt>
            <input id="m_hid_url_62" name="m_hid_url_62" value="/wisdom/keyword/analysis.do?dhpath=1007,62" type="hidden">
          </dl>
        </div>
        <div class="option-col">
          <h4>增值服务</h4>
          <dl>
            <dt class="select-have">
              <input id="m_quick_cbox_1001" name="m_quickMenu_cbox" value="1001" type="checkbox">
              <label id="m_hid_name_1001" for="m_quick_cbox_1001">服务简介 </label>
            </dt>
            <input id="m_hid_url_1001" name="m_hid_url_1001" value="/mydhgate/service/serviceaction.do?act=allservice&amp;dhpath=10003,1001" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_1002" name="m_quickMenu_cbox" value="1002" type="checkbox">
              <label id="m_hid_name_1002" for="m_quick_cbox_1002">我的增值礼包 </label>
            </dt>
            <input id="m_hid_url_1002" name="m_hid_url_1002" value="/mydhgate/service/serviceaction.do?act=myservice&amp;dhpath=10003,1002" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_1005" name="m_quickMenu_cbox" value="1005" type="checkbox">
              <label id="m_hid_name_1005" for="m_quick_cbox_1005">我的功能包 </label>
            </dt>
            <input id="m_hid_url_1005" name="m_hid_url_1005" value="/mydhgate/premium/premiumInfo.do?act=getMyPremiumInfo&amp;dhpath=10003,1005" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_1201" name="m_quickMenu_cbox" value="1201" type="checkbox">
              <label id="m_hid_name_1201" for="m_quick_cbox_1201">EDM推荐 </label>
            </dt>
            <input id="m_hid_url_1201" name="m_hid_url_1201" value="/mydhgate/edm/edmentrance.do?&amp;dhpath=10003,1201" type="hidden">
            <dt>国外求购信息 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_1801" name="m_quickMenu_cbox" value="1801" type="checkbox">
                  <label id="m_hid_name_1801" for="m_quick_cbox_1801">查看国外求购信息</label>
                  <input id="m_hid_url_1801" name="m_hid_url_1801" value="/wantitnow/wantitnowseller/wantindex.do?dhpath=10003,18,1801" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_1802" name="m_quickMenu_cbox" value="1802" type="checkbox">
                  <label id="m_hid_name_1802" for="m_quick_cbox_1802">已回复的求购信息</label>
                  <input id="m_hid_url_1802" name="m_hid_url_1802" value="/wantitnow/wantitnowseller/doload.do?dhpath=10003,18,1802" type="hidden">
                </li>
              </ul>
            </dd>
          </dl>
          <h4>推广营销</h4>
          <dl>
            <dt>促销活动 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_3001" name="m_quickMenu_cbox" value="3001" type="checkbox">
                  <label id="m_hid_name_3001" for="m_quick_cbox_3001">平台活动</label>
                  <input id="m_hid_url_3001" name="m_hid_url_3001" value="/promoweb/platformacty/actylist.do?ptype=1&amp;dhpath=10004,30,3001" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_3002" name="m_quickMenu_cbox" value="3002" type="checkbox">
                  <label id="m_hid_name_3002" for="m_quick_cbox_3002">店铺活动</label>
                  <input id="m_hid_url_3002" name="m_hid_url_3002" value="/promoweb/storeacty/actylist.do?ptype=1&amp;dhpath=10004,30,3002" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_3003" name="m_quickMenu_cbox" value="3003" type="checkbox">
                  <label id="m_hid_name_3003" for="m_quick_cbox_3003">促销日历</label>
                  <input id="m_hid_url_3003" name="m_hid_url_3003" value="/promoweb/storeacty/actycalendar.do?ptype=1&amp;dhpath=10004,30,3003" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>敦煌产品营销系统 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_2612" name="m_quickMenu_cbox" value="2612" type="checkbox">
                  <label id="m_hid_name_2612" for="m_quick_cbox_2612">首页</label>
                  <input id="m_hid_url_2612" name="m_hid_url_2612" value="http://adcenter.dhgate.com" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_2613" name="m_quickMenu_cbox" value="2613" type="checkbox">
                  <label id="m_hid_name_2613" for="m_quick_cbox_2613">我的广告</label>
                  <input id="m_hid_url_2613" name="m_hid_url_2613" value="http://adcenter.dhgate.com/adindex/index?menuRoute=02" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_2614" name="m_quickMenu_cbox" value="2614" type="checkbox">
                  <label id="m_hid_name_2614" for="m_quick_cbox_2614">竟价广告投放</label>
                  <input id="m_hid_url_2614" name="m_hid_url_2614" value="http://adcenter.dhgate.com/bidding/products" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_2615" name="m_quickMenu_cbox" value="2615" type="checkbox">
                  <label id="m_hid_name_2615" for="m_quick_cbox_2615">展示计划投放</label>
                  <input id="m_hid_url_2615" name="m_hid_url_2615" value="http://adcenter.dhgate.com/showplan/productChoose" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_2616" name="m_quickMenu_cbox" value="2616" type="checkbox">
                  <label id="m_hid_name_2616" for="m_quick_cbox_2616">数据报表</label>
                  <input id="m_hid_url_2616" name="m_hid_url_2616" value="http://adcenter.dhgate.com/datareport/pageload?menuRoute=05" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_2617" name="m_quickMenu_cbox" value="2617" type="checkbox">
                  <label id="m_hid_name_2617" for="m_quick_cbox_2617">账务管理</label>
                  <input id="m_hid_url_2617" name="m_hid_url_2617" value="http://adcenter.dhgate.com/paymentmanage/paymentList?menuRoute=06" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>流量快车 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_3301" name="m_quickMenu_cbox" value="3301" type="checkbox">
                  <label id="m_hid_name_3301" for="m_quick_cbox_3301">我的流量快车</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_3301" name="m_hid_url_3301" value="http://seller.dhgate.com/marketweb/trafficbus/pageload.do?dhpath=10004,33,3301" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_3302" name="m_quickMenu_cbox" value="3302" type="checkbox">
                  <label id="m_hid_name_3302" for="m_quick_cbox_3302">数据报表</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_3302" name="m_hid_url_3302" value="http://seller.dhgate.com/marketweb/trafficbus/datareport.do?dhpath=10004,33,3302" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>GoogleShopping推广 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_3501" name="m_quickMenu_cbox" value="3501" type="checkbox">
                  <label id="m_hid_name_3501" for="m_quick_cbox_3501">新增推广产品</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_3501" name="m_hid_url_3501" value="http://seller.dhgate.com/marketing/signup/apply" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_3502" name="m_quickMenu_cbox" value="3502" type="checkbox">
                  <label id="m_hid_name_3502" for="m_quick_cbox_3502">我的推广产品 </label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_3502" name="m_hid_url_3502" value="http://seller.dhgate.com/marketing/signup/myapply" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>视觉精灵 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_3401" name="m_quickMenu_cbox" value="3401" type="checkbox">
                  <label id="m_hid_name_3401" for="m_quick_cbox_3401">我的视觉精灵</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_3401" name="m_hid_url_3401" value="/marketweb/vaslisting/pageload.do?dhpath=10004,34,3401" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_3402" name="m_quickMenu_cbox" value="3402" type="checkbox">
                  <label id="m_hid_name_3402" for="m_quick_cbox_3402">数据报表</label>
                  <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12">
                  <input id="m_hid_url_3402" name="m_hid_url_3402" value="/marketweb/vaslisting/buydetail.do?sign=1&amp;dhpath=10004,34,3402" type="hidden">
                </li>
              </ul>
            </dd>
            <dt>敦煌联盟 </dt>
            <dd>
              <ul>
                <li>
                  <input id="m_quick_cbox_3702" name="m_quickMenu_cbox" value="3702" type="checkbox">
                  <label id="m_hid_name_3702" for="m_quick_cbox_3702">主推产品</label>
                  <input id="m_hid_url_3702" name="m_hid_url_3702" value="/union/supplier/getprods.do?dhpath=10004,37,3702" type="hidden">
                </li>
                <li>
                  <input id="m_quick_cbox_3703" name="m_quickMenu_cbox" value="3703" type="checkbox">
                  <label id="m_hid_name_3703" for="m_quick_cbox_3703">联盟产品交易订单</label>
                  <input id="m_hid_url_3703" name="m_hid_url_3703" value="/union/supplier/getorders.do?dhpath=10004,37,3703" type="hidden">
                </li>
              </ul>
            </dd>
          </dl>
          <h4>商户管理</h4>
          <dl>
            <dt class="select-have">
              <input id="m_quick_cbox_32" name="m_quickMenu_cbox" value="32" type="checkbox">
              <label id="m_hid_name_32" for="m_quick_cbox_32">处罚管理 </label>
            </dt>
            <input id="m_hid_url_32" name="m_hid_url_32" value="/punish/punishManage/getPunishInfo.do?dhpath=10009,32" type="hidden">
            <dt class="select-have">
              <input id="m_quick_cbox_29" name="m_quickMenu_cbox" value="29" type="checkbox">
              <label id="m_hid_name_29" for="m_quick_cbox_29">商户评级 </label>
            </dt>
            <input id="m_hid_url_29" name="m_hid_url_29" value="/dmrs/dmrsaction.do" type="hidden">
          </dl>
        </div>
      </div>
      <div class="set-option"> <a id="M_btn_setQuick_confirm" class="yellowbutton2" href="javascript:void(0)"><span>确 定</span></a> <a id="M_btn_setQuick_Cancel2" class="greybutton2" href="javascript:void(0)"><span>取 消</span></a> </div>
    </div>
    <div class="catalog-pop-shadow"></div>
    <div class="catalog-pop-sharp"></div>
    <iframe style="left: 0px; top: 0px; width: 615px; height: 513px; position: absolute; z-index: -1; background-color: transparent;" frameBorder="0" scrolling="no"></iframe>
  </div>
</div>
<div class="help-contact"><a onClick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Lef –在线客服'])" href="http://seller.dhgate.com/mydhgate/others/live800Sign.do?act=do400"></a></div>
<div class="advance-loan"> <a title="提前放款" href="http://seller.dhgate.com/pria/service/priaOrderList.do?dhpath=10006,0907"></a> </div>