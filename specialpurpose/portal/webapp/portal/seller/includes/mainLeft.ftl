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

<input type="hidden" id="currentPath" value="10000" />
<div class="catalog">
  <div class="h-title">
    <h3>快捷入口</h3>
    <a id="M_btn_setQuick" class="setup" href="javascript:void(0)">设置</a> </div>
  <div class="catalog-list clearfix" id="M_div_quickList"  > <a href="http://seller.dhgate.com/marketing/signup/spread"><b>GoogleShopping推广</b></a>
    <ul id="M_quickList_ul">
    </ul>
  </div>
  <div  class="perdue-hide"  id="M_quickList_perdue"><a href="javascript:void(0)"><b></b></a></div>
  <div class="catalog-pop" id="M_div_pop_setQuick">
    <div class="catalog-pop-main">
      <div class="option-info">
        <h3>设置快捷入口</h3>
        <div class="clearfix option-remind">
          <p id="M_quickMenu_selAll">您最多可以设置<b>7</b>个快捷入口</p>
          <p class="caution" id="M_quickMenu_selMax" style="display:none">您已经选择了<b id="M_hasSel_count" >7</b>个快捷入口</p>
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
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0201"  value="0201"  />
                  <label for="m_quick_cbox_0201" id="m_hid_name_0201">添加新产品</label>
                  <input type="hidden" name="m_hid_url_0201" id="m_hid_url_0201" value="http://seller.dhgate.com/syi/category.do"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0202"  value="0202"  />
                  <label for="m_quick_cbox_0202" id="m_hid_name_0202">管理产品</label>
                  <input type="hidden" name="m_hid_url_0202" id="m_hid_url_0202" value="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0209"  value="0209"  />
                  <label id="m_hid_name_0209" for="m_quick_cbox_0209">管理产品组</label>
                  <input type="hidden" name="m_hid_url_0209" id="m_hid_url_0209" value="http://seller.dhgate.com/prodmanage/group/prodGroup.do?dhpath=10001,21001,0209"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0220"  value="0220"  />
                  <label id="m_hid_name_0220" for="m_quick_cbox_0220">关联产品模板</label>
                  <input type="hidden" name="m_hid_url_0220" id="m_hid_url_0220" value="http://seller.dhgate.com/prodmanage/relModel/relModel.do?dhpath=10001,21001,0220"/>
                </li>
              </ul>
            </dd>
            <dt>产品诊断 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_7001"  value="7001"  />
                  <label for="m_quick_cbox_7001" id="m_hid_name_7001">属性缺失产品</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_7001" id="m_hid_url_7001" value="/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_7002"  value="7002"  />
                  <label id="m_hid_name_7002" for="m_quick_cbox_7002">违规待处理产品</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_7002" id="m_hid_url_7002" value="/prodrepeat/prodrepeatgroup/grouplist.do?dhpath=10001,70,7002"/>
                </li>
              </ul>
            </dd>
            <dt>一键达 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0221"  value="0221"  />
                  <label id="m_hid_name_0221" for="m_quick_cbox_0221">一键达搬家</label>
                  <input type="hidden" name="m_hid_url_0221" id="m_hid_url_0221" value="/mydhgate/product/crawlstore.do?act=pageload&dhpath=10001,22001,0221"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0222"  value="0222"  />
                  <label id="m_hid_name_0222" for="m_quick_cbox_0222">搬家记录</label>
                  <input type="hidden" name="m_hid_url_0222" id="m_hid_url_0222" value="/mydhgate/product/crawlertask.do?act=findcrawlsource&dhpath=10001,22001,0222"/>
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0205" value="0205" />
              <label id="m_hid_name_0205" for="m_quick_cbox_0205">运费模板管理 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0205" id="m_hid_url_0205" value="http://seller.dhgate.com/frttemplate/pageload.do?act=pageload&dhpath=10001,0205"/>
            <dt>商铺 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0801"  value="0801"  />
                  <label for="m_quick_cbox_0801" id="m_hid_name_0801">商铺信息</label>
                  <input type="hidden" name="m_hid_url_0801" id="m_hid_url_0801" value="/store/pageload.do?dhpath=10001,08,0801"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0802"  value="0802"  />
                  <label for="m_quick_cbox_0802" id="m_hid_name_0802">商铺装修</label>
                  <input type="hidden" name="m_hid_url_0802" id="m_hid_url_0802" value="/store/style.do?dhpath=10001,08,0802"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0803"  value="0803"  />
                  <label for="m_quick_cbox_0803" id="m_hid_name_0803">橱窗管理</label>
                  <input type="hidden" name="m_hid_url_0803" id="m_hid_url_0803" value="/store/storeWindowManage.do?dhpath=10001,08,0803"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0804"  value="0804"  />
                  <label for="m_quick_cbox_0804" id="m_hid_name_0804">商铺类目</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_0804" id="m_hid_url_0804" value="/store/getStoreDisplayRule.do?dhpath=10001,08,0804"/>
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0212" value="0212" />
              <label for="m_quick_cbox_0212" id="m_hid_name_0212">备货管理 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0212" id="m_hid_url_0212" value="http://seller.dhgate.com/prodmanage/inventory/doQueryInventory.do?dhpath=10001,0212"/>
            <dt>产品服务设定 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2402"  value="2402"  />
                  <label id="m_hid_name_2402" for="m_quick_cbox_2402">海外退货服务设定</label>
                  <input type="hidden" name="m_hid_url_2402" id="m_hid_url_2402" value="http://seller.dhgate.com/prodmanage/serviceset/prodLocalReturn.do?dhpath=10001,21002,2402"/>
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0211" value="0211" />
              <label id="m_hid_name_0211" for="m_quick_cbox_0211">产品相册 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0211" id="m_hid_url_0211" value="http://seller.dhgate.com/album/albumsmanagerlist.do?act=pageload&dhpath=10001,0211"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0210" value="0210" />
              <label for="m_quick_cbox_0210" id="m_hid_name_0210">申诉管理 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0210" id="m_hid_url_0210" value="http://seller.dhgate.com/prodmanage/appeal/prodAppeal.do?dhpath=10001,0210"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0217" value="0217" />
              <label for="m_quick_cbox_0217" id="m_hid_name_0217">经营品牌 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0217" id="m_hid_url_0217" value="/mydhgate/product/brands.do?act=sellerbrandlist&dhpath=10001,0217"/>
          </dl>
          <h4>消息</h4>
          <dl>
            <dt>站内信 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_51001"  value="51001"  />
                  <label id="m_hid_name_51001" for="m_quick_cbox_51001">买家消息</label>
                  <input type="hidden" name="m_hid_url_51001" id="m_hid_url_51001" value="/messageweb/newmessagecenter.do?msgtype=001,002,003&dhpath=10005,0301,51001"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_51002"  value="51002"  />
                  <label id="m_hid_name_51002" for="m_quick_cbox_51002">系统消息</label>
                  <input type="hidden" name="m_hid_url_51002" id="m_hid_url_51002" value="/messageweb/newmessagecenter.do?msgtype=004,005,006,007,008,009&dhpath=10005,0301,51002"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_51003"  value="51003"  />
                  <label id="m_hid_name_51003" for="m_quick_cbox_51003">平台公告</label>
                  <input type="hidden" name="m_hid_url_51003" id="m_hid_url_51003" value="/messageweb/newmessagecenter.do?msgtype=010,011,012,013&dhpath=10005,0301,51003"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_51004"  value="51004"  />
                  <label id="m_hid_name_51004" for="m_quick_cbox_51004">垃圾箱</label>
                  <input type="hidden" name="m_hid_url_51004" id="m_hid_url_51004" value="/messageweb/newmessagecenter.do?state=1&dhpath=10005,0301,51004"/>
                </li>
              </ul>
            </dd>
            <dt>客服留言 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2701"  value="2701"  />
                  <label id="m_hid_name_2701" for="m_quick_cbox_2701">在线留言</label>
                  <input type="hidden" name="m_hid_url_2701" id="m_hid_url_2701" value="/mydhgate/csmsg/leavemsg.do?dhpath=10005,52000,2701"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2702"  value="2702"  />
                  <label id="m_hid_name_2702" for="m_quick_cbox_2702">历史留言</label>
                  <input type="hidden" name="m_hid_url_2702" id="m_hid_url_2702" value="/mydhgate/csmsg/leavemsg.do?act=showListMsg&dhpath=10005,52000,2702"/>
                </li>
              </ul>
            </dd>
          </dl>
          <h4>资金账户</h4>
          <dl>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0901" value="0901" />
              <label for="m_quick_cbox_0901" id="m_hid_name_0901">交易记录 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0901" id="m_hid_url_0901" value="/fundaccounting/accountDetail/detailList.do?dhpath=10006,0901"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0907" value="0907" />
              <label for="m_quick_cbox_0907" id="m_hid_name_0907">提前放款 <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif"></label>
            </dt>
            <input type="hidden" name="m_hid_url_0907" id="m_hid_url_0907" value="/pria/service/priaOrderList.do?dhpath=10006,0907"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0904" value="0904" />
              <label for="m_quick_cbox_0904" id="m_hid_name_0904">保障金管理 <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif"></label>
            </dt>
            <input type="hidden" name="m_hid_url_0904" id="m_hid_url_0904" value="/mydhgate/guaranteefund/securityaccount.do?act=pageload&dhpath=10006,0904"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0902" value="0902" />
              <label for="m_quick_cbox_0902" id="m_hid_name_0902">敦煌币管理 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0902" id="m_hid_url_0902" value="/mydhgate/dhb/dhblist.do?dhpath=10006,0902"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0903" value="0903" />
              <label for="m_quick_cbox_0903" id="m_hid_name_0903">优惠券管理 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0903" id="m_hid_url_0903" value="/mydhgate/dhaccount/productcoupon.do?act=pageload&dhpath=10006,0903"/>
            <dt>建行敦煌“e保通” </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_9003"  value="9003"  />
                  <label id="m_hid_name_9003" for="m_quick_cbox_9003">功能介绍</label>
                  <input type="hidden" name="m_hid_url_9003" id="m_hid_url_9003" value="/mydhgate/ccb/ccbuseraction.do?act=allservice&dhpath=10006,90,9003"/>
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0905" value="0905" />
              <label id="m_hid_name_0905" for="m_quick_cbox_0905">在线贷款 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></label>
            </dt>
            <input type="hidden" name="m_hid_url_0905" id="m_hid_url_0905" value="/bankcorp/cmb/onlineloan.do?dhpath=10006,0905"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0906" value="0906" />
              <label for="m_quick_cbox_0906" id="m_hid_name_0906">账户设置 </label>
            </dt>
            <input type="hidden" name="m_hid_url_0906" id="m_hid_url_0906" value="/fundaccounting/ba/cnyAccInfo.do?dhpath=10006,0906"/>
          </dl>
        </div>
        <div class="option-col">
          <h4>交易</h4>
          <dl>
            <dt>我的订单 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0601"  value="0601"  />
                  <label for="m_quick_cbox_0601" id="m_hid_name_0601">全部订单</label>
                  <input type="hidden" name="m_hid_url_0601" id="m_hid_url_0601" value="http://seller.dhgate.com/sellerordmng/orderList/list.do?params.linkType=102&dhpath=10002,06,0601"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0602"  value="0602"  />
                  <label id="m_hid_name_0602" for="m_quick_cbox_0602">纠纷订单</label>
                  <input type="hidden" name="m_hid_url_0602" id="m_hid_url_0602" value="/sellerordmng/orderList/disputeOrderList.do?params.linkType=200&dhpath=10002,06,0602"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0603"  value="0603"  />
                  <label id="m_hid_name_0603" for="m_quick_cbox_0603">批量导出订单</label>
                  <input type="hidden" name="m_hid_url_0603" id="m_hid_url_0603" value="/mydhgate/order/batchexportorder.do?act=pageload&dhpath=10002,06,0603"/>
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_22" value="22" />
              <label id="m_hid_name_22" for="m_quick_cbox_22">佣金返还 </label>
            </dt>
            <input type="hidden" name="m_hid_url_22" id="m_hid_url_22" value="http://seller.dhgate.com/mydhgate/order/commissionreturn.do?act=pageload&dhpath=10002,22"/>
            <dt>在线物流 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0501"  value="0501"  />
                  <label id="m_hid_name_0501" for="m_quick_cbox_0501">国际E邮宝</label>
                  <input type="hidden" name="m_hid_url_0501" id="m_hid_url_0501" value="/logistics/onlinedeliveryinfo/findOnlineDeliveryList.do?onlineDelivery.status=0&dhpath=10002,05,0501"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0502"  value="0502"  />
                  <label id="m_hid_name_0502" for="m_quick_cbox_0502">仓库发货</label>
                  <input type="hidden" name="m_hid_url_0502" id="m_hid_url_0502" value="/logistics/setofgoods/findDeliveryListByStatus.do?onlineDelivery.wareHouseStatus=12&dhpath=10002,05,0502"/>
                </li>
              </ul>
            </dd>
            <dt>评价和评论管理 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0701"  value="0701"  />
                  <label id="m_hid_name_0701" for="m_quick_cbox_0701">交易评价管理</label>
                  <input type="hidden" name="m_hid_url_0701" id="m_hid_url_0701" value="/mydhgate/feedback/feedbacklist.do?act=pageload&dhpath=10002,07,0701"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0702"  value="0702"  />
                  <label id="m_hid_name_0702" for="m_quick_cbox_0702">产品评论管理</label>
                  <input type="hidden" name="m_hid_url_0702" id="m_hid_url_0702" value="/mydhgate/review/reviewlist.do?dhpath=10002,07,0702"/>
                </li>
              </ul>
            </dd>
            <dt>我的买家 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0401"  value="0401"  />
                  <label id="m_hid_name_0401" for="m_quick_cbox_0401">买家名单</label>
                  <input type="hidden" name="m_hid_url_0401" id="m_hid_url_0401" value="/mydhgate/mybuyer/mybuyer.do?dhpath=10002,04,0401"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_0402"  value="0402"  />
                  <label for="m_quick_cbox_0402" id="m_hid_name_0402">买家黑名单</label>
                  <input type="hidden" name="m_hid_url_0402" id="m_hid_url_0402" value="/mydhgate/mybuyer/mybuyer.do?isBlackBuyer=1&dhpath=10002,04,0402"/>
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
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_6001"  value="6001"  />
                  <label id="m_hid_name_6001" for="m_quick_cbox_6001">商铺概况</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_6001" id="m_hid_url_6001" value="/wisdom/shopanalysis/toprofile.do?dhpath=10007,60,6001"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_6002"  value="6002"  />
                  <label for="m_quick_cbox_6002" id="m_hid_name_6002">我的买家</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_6002" id="m_hid_url_6002" value="/wisdom/shopanalysis/toanalysis.do?dhpath=10007,60,6002"/>
                </li>
              </ul>
            </dd>
            <dt>行业动态 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_6101"  value="6101"  />
                  <label id="m_hid_name_6101" for="m_quick_cbox_6101">行业概况</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_6101" id="m_hid_url_6101" value="/wisdom/industryanalysis/toprofile.do?dhpath=10007,61,6101"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_6102"  value="6102"  />
                  <label id="m_hid_name_6102" for="m_quick_cbox_6102">买家情报</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_6102" id="m_hid_url_6102" value="/wisdom/industryanalysis/toanalysis.do?dhpath=10007,61,6102"/>
                </li>
              </ul>
            </dd>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_62" value="62" />
              <label id="m_hid_name_62" for="m_quick_cbox_62">搜索词追踪 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></label>
            </dt>
            <input type="hidden" name="m_hid_url_62" id="m_hid_url_62" value="/wisdom/keyword/analysis.do?dhpath=1007,62"/>
          </dl>
        </div>
        <div class="option-col">
          <h4>增值服务</h4>
          <dl>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_1001" value="1001" />
              <label for="m_quick_cbox_1001" id="m_hid_name_1001">服务简介 </label>
            </dt>
            <input type="hidden" name="m_hid_url_1001" id="m_hid_url_1001" value="/mydhgate/service/serviceaction.do?act=allservice&dhpath=10003,1001"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_1002" value="1002" />
              <label for="m_quick_cbox_1002" id="m_hid_name_1002">我的增值礼包 </label>
            </dt>
            <input type="hidden" name="m_hid_url_1002" id="m_hid_url_1002" value="/mydhgate/service/serviceaction.do?act=myservice&dhpath=10003,1002"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_1005" value="1005" />
              <label for="m_quick_cbox_1005" id="m_hid_name_1005">我的功能包 </label>
            </dt>
            <input type="hidden" name="m_hid_url_1005" id="m_hid_url_1005" value="/mydhgate/premium/premiumInfo.do?act=getMyPremiumInfo&dhpath=10003,1005"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_1201" value="1201" />
              <label for="m_quick_cbox_1201" id="m_hid_name_1201">EDM推荐 </label>
            </dt>
            <input type="hidden" name="m_hid_url_1201" id="m_hid_url_1201" value="/mydhgate/edm/edmentrance.do?&dhpath=10003,1201"/>
            <dt>国外求购信息 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_1801"  value="1801"  />
                  <label id="m_hid_name_1801" for="m_quick_cbox_1801">查看国外求购信息</label>
                  <input type="hidden" name="m_hid_url_1801" id="m_hid_url_1801" value="/wantitnow/wantitnowseller/wantindex.do?dhpath=10003,18,1801"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_1802"  value="1802"  />
                  <label id="m_hid_name_1802" for="m_quick_cbox_1802">已回复的求购信息</label>
                  <input type="hidden" name="m_hid_url_1802" id="m_hid_url_1802" value="/wantitnow/wantitnowseller/doload.do?dhpath=10003,18,1802"/>
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
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3001"  value="3001"  />
                  <label id="m_hid_name_3001" for="m_quick_cbox_3001">平台活动</label>
                  <input type="hidden" name="m_hid_url_3001" id="m_hid_url_3001" value="/promoweb/platformacty/actylist.do?ptype=1&dhpath=10004,30,3001"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3002"  value="3002"  />
                  <label for="m_quick_cbox_3002" id="m_hid_name_3002">店铺活动</label>
                  <input type="hidden" name="m_hid_url_3002" id="m_hid_url_3002" value="/promoweb/storeacty/actylist.do?ptype=1&dhpath=10004,30,3002"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3003"  value="3003"  />
                  <label id="m_hid_name_3003" for="m_quick_cbox_3003">促销日历</label>
                  <input type="hidden" name="m_hid_url_3003" id="m_hid_url_3003" value="/promoweb/storeacty/actycalendar.do?ptype=1&dhpath=10004,30,3003"/>
                </li>
              </ul>
            </dd>
            <dt>敦煌产品营销系统 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2612"  value="2612"  />
                  <label id="m_hid_name_2612" for="m_quick_cbox_2612">首页</label>
                  <input type="hidden" name="m_hid_url_2612" id="m_hid_url_2612" value="http://adcenter.dhgate.com"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2613"  value="2613"  />
                  <label id="m_hid_name_2613" for="m_quick_cbox_2613">我的广告</label>
                  <input type="hidden" name="m_hid_url_2613" id="m_hid_url_2613" value="http://adcenter.dhgate.com/adindex/index?menuRoute=02"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2614"  value="2614"  />
                  <label id="m_hid_name_2614" for="m_quick_cbox_2614">竟价广告投放</label>
                  <input type="hidden" name="m_hid_url_2614" id="m_hid_url_2614" value="http://adcenter.dhgate.com/bidding/products"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2615"  value="2615"  />
                  <label id="m_hid_name_2615" for="m_quick_cbox_2615">展示计划投放</label>
                  <input type="hidden" name="m_hid_url_2615" id="m_hid_url_2615" value="http://adcenter.dhgate.com/showplan/productChoose"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2616"  value="2616"  />
                  <label for="m_quick_cbox_2616" id="m_hid_name_2616">数据报表</label>
                  <input type="hidden" name="m_hid_url_2616" id="m_hid_url_2616" value="http://adcenter.dhgate.com/datareport/pageload?menuRoute=05"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_2617"  value="2617"  />
                  <label for="m_quick_cbox_2617" id="m_hid_name_2617">账务管理</label>
                  <input type="hidden" name="m_hid_url_2617" id="m_hid_url_2617" value="http://adcenter.dhgate.com/paymentmanage/paymentList?menuRoute=06"/>
                </li>
              </ul>
            </dd>
            <dt>流量快车 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3301"  value="3301"  />
                  <label id="m_hid_name_3301" for="m_quick_cbox_3301">我的流量快车</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_3301" id="m_hid_url_3301" value="http://seller.dhgate.com/marketweb/trafficbus/pageload.do?dhpath=10004,33,3301"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3302"  value="3302"  />
                  <label for="m_quick_cbox_3302" id="m_hid_name_3302">数据报表</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_3302" id="m_hid_url_3302" value="http://seller.dhgate.com/marketweb/trafficbus/datareport.do?dhpath=10004,33,3302"/>
                </li>
              </ul>
            </dd>
            <dt>GoogleShopping推广 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3501"  value="3501"  />
                  <label id="m_hid_name_3501" for="m_quick_cbox_3501">新增推广产品</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_3501" id="m_hid_url_3501" value="http://seller.dhgate.com/marketing/signup/apply"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3502"  value="3502"  />
                  <label id="m_hid_name_3502" for="m_quick_cbox_3502">我的推广产品 </label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_3502" id="m_hid_url_3502" value="http://seller.dhgate.com/marketing/signup/myapply"/>
                </li>
              </ul>
            </dd>
            <dt>视觉精灵 <img class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif" width="11" height="12"></dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3401"  value="3401"  />
                  <label for="m_quick_cbox_3401" id="m_hid_name_3401">我的视觉精灵</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_3401" id="m_hid_url_3401" value="/marketweb/vaslisting/pageload.do?dhpath=10004,34,3401"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3402"  value="3402"  />
                  <label for="m_quick_cbox_3402" id="m_hid_name_3402">数据报表</label>
                  <img width="11" height="12" class="valmiddle" src="http://www.dhresource.com/dhs/mos/image/public/new001.gif">
                  <input type="hidden" name="m_hid_url_3402" id="m_hid_url_3402" value="/marketweb/vaslisting/buydetail.do?sign=1&dhpath=10004,34,3402"/>
                </li>
              </ul>
            </dd>
            <dt>敦煌联盟 </dt>
            <dd>
              <ul>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3702"  value="3702"  />
                  <label id="m_hid_name_3702" for="m_quick_cbox_3702">主推产品</label>
                  <input type="hidden" name="m_hid_url_3702" id="m_hid_url_3702" value="/union/supplier/getprods.do?dhpath=10004,37,3702"/>
                </li>
                <li>
                  <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_3703"  value="3703"  />
                  <label id="m_hid_name_3703" for="m_quick_cbox_3703">联盟产品交易订单</label>
                  <input type="hidden" name="m_hid_url_3703" id="m_hid_url_3703" value="/union/supplier/getorders.do?dhpath=10004,37,3703"/>
                </li>
              </ul>
            </dd>
          </dl>
          <h4>商户管理</h4>
          <dl>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_32" value="32" />
              <label for="m_quick_cbox_32" id="m_hid_name_32">处罚管理 </label>
            </dt>
            <input type="hidden" name="m_hid_url_32" id="m_hid_url_32" value="/punish/punishManage/getPunishInfo.do?dhpath=10009,32"/>
            <dt class="select-have">
              <input type="checkbox"  name="m_quickMenu_cbox" id="m_quick_cbox_29" value="29" />
              <label for="m_quick_cbox_29" id="m_hid_name_29">商户评级 </label>
            </dt>
            <input type="hidden" name="m_hid_url_29" id="m_hid_url_29" value="/dmrs/dmrsaction.do"/>
          </dl>
        </div>
      </div>
      <div class="set-option"> <a id="M_btn_setQuick_confirm" class="yellowbutton2" href="javascript:void(0)"><span>确 定</span></a> <a href="javascript:void(0)" class="greybutton2" id="M_btn_setQuick_Cancel2" ><span>取 消</span></a> </div>
    </div>
    <div class="catalog-pop-shadow"></div>
    <div class="catalog-pop-sharp"></div>
    <iframe scrolling="no" frameborder="0" style="position:absolute;top:0px; left:0px; z-index:-1; height:513px; width:615px; background-color:transparent;"></iframe>
  </div>
</div>
<div class="help-contact"><a onclick="_gaq.push(['_trackEvent', 'Seller-mydh1', 'Lef –在线客服'])" href="http://seller.dhgate.com/mydhgate/others/live800Sign.do?act=do400"></a></div>
<div class="advance-loan"> <a href="http://seller.dhgate.com/pria/service/priaOrderList.do?dhpath=10006,0907" title="提前放款"></a> </div>