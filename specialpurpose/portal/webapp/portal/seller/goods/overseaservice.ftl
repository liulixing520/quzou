<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20111215.css?version=2014-10-13">
<script type="text/javascript" src="http://www.dhresource.com/seller/js/common.js?version=2014-10-13"></script>
<script type="text/javascript" src="http://stats.g.doubleclick.net/dc.js"></script>
<script type="text/javascript" src="http://www.dhresource.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js?version=2014-10-13"></script>
<script type="text/javascript" src="http://www.dhresource.com/dhs/mos/js/public/menu-common_20111226.js?ver=2013&amp;version=2014-10-13"></script>
<!--<script type="text/javascript" src="http://seller.dhgate.com/js/publish/menu-common_20111226.js"></script>-->
<link rel="stylesheet" href="../seller/css/jquery-calendar.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/localreturn.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css?version=2014-10-13">
<script type="text/javascript" src="http://www.dhresource.com/2008/web20/seller/js/syi/matrix/jquery.simplemodal2.js?ver=2013-07-03&amp;version=2014-10-13"></script>
<script type="text/javascript" src="http://www.dhresource.com/2008/web20/seller/js/syi/matrix/2013-07-16/tools/DHGatePlugin.js?version=2014-10-13"></script>
<script type="text/javascript" src="/prodmanage/js/serviceset/localreturn.js?version=2014-10-13"></script>
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span><a href="/mydhgate/product/productlocalreturn.do?act=pageload&amp;dhpath=10001,21002,2402">产品服务设定</a><span>&gt;</span>海外退货服务设定 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <div class="col-boxpd col-linebom">
            <h2>海外退货服务设定</h2>
            <span class="col-rigtit"><a href="http://seller.dhgate.com/seller/pro/399lp.html" target="_blank">海外退货服务详情</a></span></div>
          <div class="col-sailtips clearfix"> <span class="leftcol-tip">温馨提示：</span>
            <div class="rightcol-tip">
              <p id="hideTipsBox">请选择加入海外退货服务的产品，加入服务的产品在发生退货纠纷时，买家只需将产品完整的退到本地仓库即代表退货已完成，敦煌网会帮助卖家将产品发回中国。退货运费与您上传商品时填写的包装重量有关，请确保重量设置正确。<br>
                注意：只有销售到美国的订单才支持此服务。 </p>
              <span id="viewTips" class="viewticps">收起</span> </div>
          </div>
          <form id="prodLocalReturnForm" method="post" name="prodLocalReturnForm" action="/prodmanage/serviceset/prodLocalReturn.do">
            <input id="dispatcheOperation" name="serviceSetForm.dispatcheOperation" value="prodLocalReturn" type="hidden">
            <input id="hasOperationTip" name="serviceSetForm.hasOperationTip" value="" type="hidden">
            <input id="operationTip" name="serviceSetForm.operationTip" value="" type="hidden">
            <div class="mksearchbox">
              <div> 产品范围：
                <select id="lrTag" class="mksearchselect marg-r10" name="serviceSetForm.lrTag">
                  <option value="">全部产品</option>
                  <option value="1">海外退货产品</option>
                  <option value="0">非海外退货产品</option>
                </select>
                产品编号：
                <input id="searchItemcode" class="mksearchinput marg-r10" name="serviceSetForm.itemcode" value="" type="text">
                产品名称：
                <input id="productName" class="mksearchinput marg-r10" name="serviceSetForm.productName" value="" type="text">
              </div>
              <div class="marg-t10"> 产品类目：
                <select id="cate1PubId" class="mksearchselect marg-r10" name="serviceSetForm.cate1PubId">
                  <option value="">- 1级类目 -</option>
                  <option value="014">服装</option>
                  <option value="143">汽车、摩托车</option>
                  <option value="142">母婴用品</option>
                  <option value="137">箱包及箱包辅料</option>
                  <option value="011">商业及工业</option>
                  <option value="136">数码相机、摄影器材</option>
                  <option value="135">手机和手机附件</option>
                  <option value="009">计算机和网络</option>
                  <option value="153">电子元器件</option>
                  <option value="008">消费类电子</option>
                  <option value="099">其他产品</option>
                  <option value="140">时尚配件</option>
                  <option value="139">电玩游戏</option>
                  <option value="169">发制品</option>
                  <option value="018">健康与美容</option>
                  <option value="019">家居与花园</option>
                  <option value="004">珠宝</option>
                  <option value="152">照明灯饰</option>
                  <option value="041">仪器仪表</option>
                  <option value="144">乐器</option>
                  <option value="007">安全与监控</option>
                  <option value="141">鞋类及鞋类辅料</option>
                  <option value="024">运动与户外产品</option>
                  <option value="006">玩具与礼物</option>
                  <option value="005">表</option>
                  <option value="002">婚纱礼服</option>
                </select>
                <select id="cate2PubId" onchange="catePubOnChange(this,'cate3PubId', ['cate3PubId', 'cate4PubId'])" class="mksearchselect marg-r10" name="serviceSetForm.cate2PubId">
                  <option value="">- 2级类目 -</option>
                </select>
                <select id="cate3PubId" onchange="catePubOnChange(this,'cate4PubId', ['cate4PubId']);" class="mksearchselect marg-r10" name="serviceSetForm.cate3PubId">
                  <option value="">- 3级类目 -</option>
                </select>
                <select id="catePubId" class="mksearchselect marg-r10" name="serviceSetForm.catePubId">
                  <option value="">- 4级类目 -</option>
                </select>
                <span class="yellowBtn valmiddle">
                <input id="btn_search" value="搜 索" type="button">
                </span> </div>
            </div>
            <!-- 列表 开始 -->
            <div class="bg-list">
              <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                <tbody>
                  <tr class="btngroup">
                    <td class="padleft20"><input name="btn_checkAll" type="checkbox"></td>
                    <td colSpan="3"><span class="col-mgright10">全选</span> <span class="tourBtn">
                      <input name="btn_setLocalReturn" value="设定海外退货服务" type="button">
                      </span> <span class="tourBtn">
                      <input name="btn_cancelLocalReturn" value="取消海外退货服务" type="button">
                      </span> </td>
                    <td class="right"><select id="lrTagSearchFilter" onchange="filterChange();" class="mksearchselect marg-r10" name="lrTagSearchFilter">
                        <option value="">全部产品</option>
                        <option value="1">海外退货产品</option>
                        <option value="0">非海外退货产品</option>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th width="5%"></th>
                    <th class="align-left" width="10%">产品图片</th>
                    <th width="25%">产品编号</th>
                    <th width="37%">产品名称</th>
                    <th class="last padlr10 align-left" width="23%">产品服务</th>
                  </tr>
                  <tr>
                    <td class="padleft2010"><input id="productItemcodeArr" name="serviceSetForm.itemcodeArray" value="208268522" type="checkbox">
                    </td>
                    <td><span class="prolayout"><span><img src="http://www.dhresource.com/albu_901723560_00/1.thumb.jpg"></span></span></td>
                    <td class="center">208268522</td>
                    <td class="padlr10"><span class="padright40"><a href="http://seller.dhgate.com/prodmanage/preview/prodPreview.do?dhpath=10001,21002,2402&amp;itemcode=208268522">Cell Phone Cases </a></span></td>
                    <td id="lr_status_208268522" class="padlr10" localReturn="0"><span style="display: none;" id="lr_span_208268522" class="pro-a-ser-03"></span> </td>
                  </tr>
                  <tr>
                    <td class="padleft2010"><input id="productItemcodeArr" name="serviceSetForm.itemcodeArray" value="208107975" type="checkbox">
                    </td>
                    <td><span class="prolayout"><span><img src="http://www.dhresource.com/albu_899902750_00/1.thumb.jpg"></span></span></td>
                    <td class="center">208107975</td>
                    <td class="padlr10"><span class="padright40"><a href="http://seller.dhgate.com/prodmanage/preview/prodPreview.do?dhpath=10001,21002,2402&amp;itemcode=208107975">refueling card system </a></span></td>
                    <td id="lr_status_208107975" class="padlr10" localReturn="0"><span style="display: none;" id="lr_span_208107975" class="pro-a-ser-03"></span> </td>
                  </tr>
                  <tr>
                    <td class="padleft2010"><input id="productItemcodeArr" name="serviceSetForm.itemcodeArray" value="208102925" type="checkbox">
                    </td>
                    <td><span class="prolayout"><span><img src="http://www.dhresource.com/albu_899849231_00/1.thumb.jpg"></span></span></td>
                    <td class="center">208102925</td>
                    <td class="padlr10"><span class="padright40"><a href="http://seller.dhgate.com/prodmanage/preview/prodPreview.do?dhpath=10001,21002,2402&amp;itemcode=208102925">Transportation Card System </a></span></td>
                    <td id="lr_status_208102925" class="padlr10" localReturn="0"><span style="display: none;" id="lr_span_208102925" class="pro-a-ser-03"></span> </td>
                  </tr>
                  <tr>
                    <td class="padleft2010"><input id="productItemcodeArr" name="serviceSetForm.itemcodeArray" value="208112962" type="checkbox">
                    </td>
                    <td><span class="prolayout"><span><img src="http://www.dhresource.com/albu_899977691_00/1.thumb.jpg"></span></span></td>
                    <td class="center">208112962</td>
                    <td class="padlr10"><span class="padright40"><a href="http://seller.dhgate.com/prodmanage/preview/prodPreview.do?dhpath=10001,21002,2402&amp;itemcode=208112962">Agate bracelet </a></span></td>
                    <td id="lr_status_208112962" class="padlr10" localReturn="0"><span style="display: none;" id="lr_span_208112962" class="pro-a-ser-03"></span> </td>
                  </tr>
                  <tr class="btngroup">
                    <td class="padleft20"><input name="btn_checkAll" type="checkbox"></td>
                    <td colSpan="7"><span class="col-mgright10">全选</span><span class="tourBtn">
                      <input name="btn_setLocalReturn" value="设定海外退货服务" type="button">
                      </span><span class="tourBtn">
                      <input name="btn_cancelLocalReturn" value="取消海外退货服务" type="button">
                      </span></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <!-- 列表 结束 -->
            <script language="javascript">
	    function turnpage (pagenum,frm){
			if(frm==null || frm==''){
				frm=document.getElementById('prodLocalReturnForm');
			}else{
				frm=document.getElementById(frm);
			}
			frm.page.value=pagenum;
			frm.submit ();
		}
		//按钮提交
		function subpage (pages,frm){
			if(frm==null || frm==''){
				frm=document.getElementById('prodLocalReturnForm');
			}else{
				frm=document.getElementById(frm);
			}
			var pagenum = document.getElementById("pageid").value;
			//超过最大页 ， 取最大页
			if(eval(pagenum) > eval(pages)){
				pagenum = pages;
			}
			frm.page.value=pagenum;
			frm.submit ();
		}
		//判断输入框中的只能是数字，不是数字则置空
		function getPageNum(obj){
			var str = obj.value;
			if(!validateNum(str)){
				obj.value="";
			}
		}
		//判断数字//wuzhonghua
		//由数字组成 true  否则false
		function validateNum(str){
	    	var patn = /^[0-9-\/]+$/;  //正则表达式，不是数字
	    	if(patn.test(str)) return true;
	
			return false;
		}
	</script>
            <div id="page">
              <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                <tbody>
                  <tr>
                    <td class="le">共有记录4条，每页显示
                      <select id="selectpagesize" class="marginlr5" name="selectpagesize">
                        <option selected="" value="20">20</option>
                        <option value="40">40</option>
                        <option value="60">60</option>
                      </select>
                      条</td>
                    <td class="ri"><span><a href="javascript:turnpage(1,'prodLocalReturnForm')"> <img alt="首页" src="http://image.dhgate.com/2008/web20/seller/img/img_10.gif"></a> </span> <span class="tt2"><a href="javascript:turnpage(1,'prodLocalReturnForm')">上一页</a></span> <span><b>1</b></span> <span class="tt3"><a href="javascript:turnpage('1','prodLocalReturnForm')">下一页</a></span> <span><a href="javascript:turnpage('1','prodLocalReturnForm')"> <img alt="尾页" src="http://image.dhgate.com/2008/web20/seller/img/img_13.gif"></a> </span> <span>到
                      <input id="pageid" onkeyup="getPageNum(this)" name="page" value="" size="2" type="text">
                      页
                      <input id="button" onclick="javascript:subpage('1','prodLocalReturnForm')" name="button3" value="GO" type="button">
                      </span> </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </form>
          <!--当前证件弹层 开始-->
          <div style="display: none;" id="prodoctImgWarp" class="popup-pro-img">
            <iframe></iframe>
            <div id="proImg" class="proImg"> <b class="img-arrow-up"></b>
              <div class="product-list-img"> <a class="lazyload" href="#" target="_blank" lazyload-src="http://www.dhresource.com/dhs/mos/image/adsystem/proimg.jpg?version=2014-10-13"></a> </div>
            </div>
          </div>
          <!--当前证件弹层 结束-->
        </div>
      </div>
    </div>
    

   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 
  </div>
</div>
