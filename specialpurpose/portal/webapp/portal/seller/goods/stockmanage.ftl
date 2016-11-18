<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20111215.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/jquery-calendar.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css?version=2014-10-13">
<link rel="stylesheet" type="text/css" href="../seller/css/product.css">
<link rel="stylesheet" type="text/css" href="../seller/css/relatedproduct.css">
<link rel="stylesheet" type="text/css" href="../seller/css/menu-common_20111226.js">
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span>备货管理 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <script type="text/javascript"> 
	
        <!--
        function hideTicpBox( targetId , boxId){
        	var hideTipsBox=$("#"+boxId);
        	$("#"+targetId).click(function(){
        		if(hideTipsBox.css('display') == 'block' ){
        			hideTipsBox.css("display","none");
        			$(this).addClass("viewshow")
        			$(this).text('展开');
        		}else{
        			hideTipsBox.css("display","block");
        			$(this).removeClass("viewshow")
        			$(this).text('收起');
        		}
        		return false;
        	 });	
        }
        $(document).ready(function(){
        	hideTicpBox("viewTips","hideTipsBox");
        });
-->
</script>
          <div class="col-boxpd col-linebom">
            <h2>备货管理</h2>
          </div>
          <!-- help部分 开始 -->
          <div class="col-sailtips clearfix"> <span class="leftcol-tip3">提示：</span>
            <div class="rightcol-tip">
              <p>1、能够进行备货管理的产品包括您的“上架的产品”和“下架的产品”。</p>
              <p id="hideTipsBox">2、您的产品被分为“有备货产品”和“待备货产品”两类，您可以通过“备货设置”和“批量备货设置”进行备货状态信息的设置，您还可以在“上架的产品”和“下架的产品”列表中通过修改产品信息，在修改产品信息页面进行备货状态信息设置。<br>
                3、您的“有备货产品”的产品数量快售完时，系统会将其列在“需要补充备货的产品”中，提醒您进行备货补充。 <a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0322" target="_blank">了解更多</a> </p>
            </div>
            <span id="viewTips" class="viewticps">收起</span> </div>
          <form id="searchForm" method="post" name="searchForm" action="/prodmanage/inventory/doQueryInventory.do?type=1">
            <input id="queryType" name="prodInventoryForm.queryType" value="1" type="hidden">
            <div class="mksearchbox">
              <div class="col-mgbottom10"> 产品编号：
                <input onblur="itemcodeCheck();" id="itemCode" onchange="itemcodeCheck();" class="mksearchinput2 marg-r10" onkeyup="itemcodeCheck();" onclick="itemcodeCheck();" name="prodInventoryForm.itemCode" value="" type="text">
                产品名称：
                <input id="productName" class="mksearchinput marg-r10" name="prodInventoryForm.productName" value="" type="text">
                <span class="tname">产品组：</span> <span id="newGuideTarget3">
                <select class="j-select-root mksearchselect addwid113">
                  <option title="请选择产品分组" value="">请选择产品分组</option>
                  <option title="未分组" value="nogroup">未分组</option>
                </select>
                <select style="display: none;" class="j-select-sub mksearchselect addwid113">
                </select>
                <input id="selectproductgroup" class="j-select-hidden" name="prodInventoryForm.selectedProdGroupId" value="" type="hidden">
                </span> </div>
              产品分类：
              <select id="cate1PubId" onchange="catePubOnChange(this,'cate2PubId', ['cate2PubId', 'cate3PubId','cate4PubId'])" class="mksearchselect marg-r10" name="prodInventoryForm.cate1PubId">
                <option value="">一级分类</option>
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
              <select id="cate2PubId" onchange="catePubOnChange(this,'cate3PubId', ['cate3PubId','cate4PubId'])" class="mksearchselect marg-r10" name="prodInventoryForm.cate2PubId">
                <option value="">二级分类</option>
              </select>
              <select id="cate3PubId" onchange="catePubOnChange(this,'cate4PubId', ['cate4PubId'])" class="mksearchselect marg-r10" name="prodInventoryForm.cate3PubId">
                <option value="">三级分类</option>
              </select>
              <select id="cate4PubId" class="mksearchselect marg-r10" name="prodInventoryForm.cate4PubId">
                <option value="">四级分类</option>
              </select>
              <input id="catePubId" name="prodInventoryForm.catePubId" value="" type="hidden">
              <span class="yellowBtn valmiddle">
              <input onclick="query();" value="搜 索" type="button">
              </span> </div>
          </form>
          <div class="rtab-warp">
            <ul>
              <li class="current"><a href="/prodmanage/inventory/doQueryInventory.do?type=1"><span>有备货产品</span></a></li>
              <li><a href="/prodmanage/inventory/doQueryInventory.do?type=0"><span>待备货产品</span></a></li>
            </ul>
            <div class="propbox tipstion"> <span class="yellowBtn">
              <input class="j-btn-akeystock" value="一键修改备货状态" type="button">
              </span> <span class="yellowBtn">
              <input class="j-onekey" value="一键修改" type="button" data-target=".j-tab-stockup">
              </span>
              <!-- 新增一键修改tip 

                <span class="tiparrow-posbox j-onekey-tip" style="display: none; left:-120px; top:-53px;">

                  <div class="tiparrow-box clearfix" style="width:180px">可以一键修改价格、延长有效期、修改备货期和调整产品组

					<a href="javascript:;" class="tiparrow-close j-closer"></a>

                    <a class="tiparrow-iknow j-know" href="javascript:;">我知道了</a>

                    <div class="tiparrow-b" style="left:150px;"></div>

                  </div>

                </span>

                -->
            </div>
          </div>
          <div class="movekeyd"> <a class="current" href="/prodmanage/inventory/doQueryInventory.do?type=1">全部有备货的产品<b class="color-ry">4</b></a> <a>需要补充备货的产品<b class="color-ry">0</b></a> </div>
          <!-- 列表 开始 -->
          <form id="managerInVentoryProduct" method="post" name="managerInVentoryProduct" action="/prodmanage/inventory/doQueryInventory.do?type=1">
            <input id="isStudentSupplier" name="isStudentSupplier" value="0" type="hidden">
            <div class="bg-list">
              <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                <tbody>
                  <tr>
                    <th width="40%" colSpan="3">产品信息</th>
                    <th width="30%">备货数量</th>
                    <th class="last" width="30%">操作</th>
                  </tr>
                  <tr class="btngroup">
                    <td class="padleft20" width="4%"><input class="j-chk-all" value="" type="checkbox">
                    </td>
                    <td colSpan="4"><span class="marginleft10 col-mgright10">全选</span> <span class="tourBtn j-btn-batch-ready">
                      <input value="批量修改为待备货" type="button">
                      </span> </td>
                  </tr>
                  <tr>
                    <td class="padleft20"><input class="j-chk-item" value="208268522" type="checkbox">
                    </td>
                    <td class="padlr10"><span class="prolayout"> <span><img src="http://www.dhresource.com/albu_901723560_00/1.thumb.jpg"></span> </span> </td>
                    <td class="padright40" width="30%"><span class="padright40"> <a href="http://seller.dhgate.com/prodmanage/preview/prodPreview.do?dhpath=10001,0212&amp;itemcode=208268522" target="_blank">Cell Phone Cases</a> </span> <span class="gearycolor">产品编号：208268522</span></td>
                    <td class="center"><b>194 </b> </td>
                    <td class="center"><a onclick="window.open ('http://seller.dhgate.com/syi/skuEdit.do?pid=208268522&amp;checkType=10','newwindow','height=600,width=900,top=100,left='+(screen.width/2-450)+',toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no')" href="javascript:void(0);">备货设置</a> <br>
                    </td>
                  </tr>
                  <tr>
                    <td class="padleft20"><input class="j-chk-item" value="208107975" type="checkbox">
                    </td>
                    <td class="padlr10"><span class="prolayout"> <span><img src="http://www.dhresource.com/albu_899902750_00/1.thumb.jpg"></span> </span> </td>
                    <td class="padright40" width="30%"><span class="padright40"> <a href="http://seller.dhgate.com/prodmanage/preview/prodPreview.do?dhpath=10001,0212&amp;itemcode=208107975" target="_blank">refueling card system</a> </span> <span class="gearycolor">产品编号：208107975</span></td>
                    <td class="center"><b>100 </b> </td>
                    <td class="center"><a onclick="window.open ('http://seller.dhgate.com/syi/skuEdit.do?pid=208107975&amp;checkType=10','newwindow','height=600,width=900,top=100,left='+(screen.width/2-450)+',toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no')" href="javascript:void(0);">备货设置</a> <br>
                    </td>
                  </tr>
                  <tr>
                    <td class="padleft20"><input class="j-chk-item" value="208102925" type="checkbox">
                    </td>
                    <td class="padlr10"><span class="prolayout"> <span><img src="http://www.dhresource.com/albu_899849231_00/1.thumb.jpg"></span> </span> </td>
                    <td class="padright40" width="30%"><span class="padright40"> <a href="http://seller.dhgate.com/prodmanage/preview/prodPreview.do?dhpath=10001,0212&amp;itemcode=208102925" target="_blank">Transportation Card System</a> </span> <span class="gearycolor">产品编号：208102925</span></td>
                    <td class="center"><b>1000 </b> </td>
                    <td class="center"><a onclick="window.open ('http://seller.dhgate.com/syi/skuEdit.do?pid=208102925&amp;checkType=10','newwindow','height=600,width=900,top=100,left='+(screen.width/2-450)+',toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no')" href="javascript:void(0);">备货设置</a> <br>
                    </td>
                  </tr>
                  <tr>
                    <td class="padleft20"><input class="j-chk-item" value="208112962" type="checkbox">
                    </td>
                    <td class="padlr10"><span class="prolayout"> <span><img src="http://www.dhresource.com/albu_899977691_00/1.thumb.jpg"></span> </span> </td>
                    <td class="padright40" width="30%"><span class="padright40"> <a href="http://seller.dhgate.com/prodmanage/preview/prodPreview.do?dhpath=10001,0212&amp;itemcode=208112962" target="_blank">Agate bracelet</a> </span> <span class="gearycolor">产品编号：208112962</span></td>
                    <td class="center"><b>100 </b> </td>
                    <td class="center"><a onclick="window.open ('http://seller.dhgate.com/syi/skuEdit.do?pid=208112962&amp;checkType=10','newwindow','height=600,width=900,top=100,left='+(screen.width/2-450)+',toolbar=no,menubar=no,scrollbars=yes, resizable=yes,location=no, status=no')" href="javascript:void(0);">备货设置</a> <br>
                    </td>
                  </tr>
                  <tr class="btngroup">
                    <td class="padleft20" width="4%"><input class="j-chk-all" value="" type="checkbox">
                    </td>
                    <td colSpan="4"><span class="marginleft10 col-mgright10">全选</span> <span class="tourBtn j-btn-batch-ready">
                      <input value="批量修改为待备货" type="button">
                      </span> </td>
                  </tr>
                </tbody>
              </table>
              <!-- 列表 结束 -->
              <script language="javascript">
	    function turnpage (pagenum,frm,formtype){
			if(frm==null || frm==''){
				frm=document.getElementById('managerInVentoryProduct');
			}else{
				frm=document.getElementById(frm);
			}
			frm.page.value=pagenum;
			if(formtype!='' && frm.type){
				frm.type.value=formtype;
			}
			frm.submit ();
		}
		//按钮提交
		function subpage (pages,frm,formtype){
			if(frm==null || frm==''){
				frm=document.getElementById('managerInVentoryProduct');
			}else{
				frm=document.getElementById(frm);
			}
			//var pagenum = document.getElementById(formtype+'page').value;
			var pagenum = frm.page.value;
			//超过最大页 ， 取最大页
			if(eval(pagenum) > eval(pages)){
				frm.page.value=pages;
			}
			if(formtype!='' && frm.type){
				frm.type.value=formtype;
			}					
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
              <div class="commonpage"> <span class="pageleft"><span>共有记录4条，每页显示10条</span></span> <span class="pageright"> <span> <span class="disablebtn"><span>?上一页</span></span> <b>1</b> <span class="disablebtn"><span>下一页?</span></span> </span>
                <input id="${type}page" name="page" value="" type="hidden">
                </span> </div>
            </div>
          </form>
          <table style="width: 480px; display: none;" id="doInventory" class="noshade-pop-table">
            <tbody>
              <tr>
                <td class="t-lt"></td>
                <td class="t-mid"></td>
                <td class="t-ri"></td>
              </tr>
              <tr>
                <td class="m-lt"></td>
                <td class="m-mid"><div class="mid-warp">
                    <div class="noshade-pop-content">
                      <div class="noshade-pop-title"> <span>批量备货设置</span> </div>
                      <div class="syi-pop-content-box clearfix">
                        <!-- 备货信息弹层 开始 -->
                        <div class="mainlayout ml-nowidth clearfix">
                          <div class="ml-title">备货状态： </div>
                          <label>
                          <input onclick="isShowCount()" name="RadioBtn" value="1" CHECKED="true" type="radio">
                          <span class="marginleft5 marginright10">有备货</span></label>
                          <label>
                          <input id="noStock" onclick="isShowCount()" name="RadioBtn" value="0" type="radio">
                          <span class="marginleft5">待备货</span></label>
                        </div>
                        <div id="locationSelect" class="mainlayout ml-nowidth clearfix">
                          <div class="ml-title">备货所在地： </div>
                          <select class="selected">
                            <option value="Afghanistan">阿富汗</option>
                            <option value="Albania">阿尔巴尼亚</option>
                            <option value="Algeria">阿尔及利亚</option>
                            <option value="American Samoa">美属萨摩亚</option>
                            <option value="Andorra">安道尔(安多拉)</option>
                            <option value="Angola">安哥拉</option>
                            <option value="Anguilla">安圭拉岛</option>
                            <option value="Antigua and Barbuda">安提瓜岛</option>
                            <option value="Argentina">阿根廷</option>
                            <option value="Armenia">亚美尼亚</option>
                            <option value="Aruba">阿鲁巴岛</option>
                            <option value="Australia">澳大利亚</option>
                            <option value="Austria">奥地利</option>
                            <option value="Azerbaijan">阿塞拜疆</option>
                            <option value="Bahamas">巴哈马群岛</option>
                            <option value="Bahrain">巴林群岛</option>
                            <option value="Bangladesh">孟加拉国</option>
                            <option value="Barbados">巴巴多斯岛</option>
                            <option value="Belarus">白俄罗斯</option>
                            <option value="Belgium">比利时</option>
                            <option value="Belize">伯利兹城</option>
                            <option value="Benin">贝宁湾</option>
                            <option value="Bermuda">百慕大群岛</option>
                            <option value="Bhutan">不丹</option>
                            <option value="Bolivia">玻利维亚</option>
                            <option value="Bosnia and Hercegovina">波斯尼亚</option>
                            <option value="Botswana">博茨瓦纳</option>
                            <option value="Brazil">巴西</option>
                            <option value="British Virgin Islands">英属维尔京群岛</option>
                            <option value="Brunei">文莱</option>
                            <option value="Bulgaria">保加利亚</option>
                            <option value="Burkina Faso">布基纳法索</option>
                            <option value="Burundi">布隆迪</option>
                            <option value="Cambodia">柬埔寨</option>
                            <option value="Cameroon">喀麦隆</option>
                            <option value="Canada">加拿大</option>
                            <option value="Cape Verde">佛得角共和国</option>
                            <option value="Cayman Islands">开曼群岛</option>
                            <option value="Central African Republic">中非共和国</option>
                            <option value="Chad">乍得</option>
                            <option value="Chile">智利</option>
                            <option value="China">中国</option>
                            <option value="Colombia">哥伦比亚</option>
                            <option value="Comoros">科摩罗</option>
                            <option value="Cook Islands">库克群岛</option>
                            <option value="Costa Rica">哥斯达黎加</option>
                            <option value="Croatia">克罗地亚</option>
                            <option value="Cuba">古巴</option>
                            <option value="Cyprus">塞浦路斯</option>
                            <option value="Czech Republic">捷克</option>
                            <option value="Democratic Republic of Congo">刚果 金</option>
                            <option value="Denmark">丹麦</option>
                            <option value="Djibouti">吉布提</option>
                            <option value="Dominica">多米尼加</option>
                            <option value="Dominican Republic">多米尼加共和国</option>
                            <option value="East Timor">东帝汶</option>
                            <option value="Ecuador">厄瓜多尔</option>
                            <option value="Egypt">埃及</option>
                            <option value="El Salvador">萨尔瓦多</option>
                            <option value="Equatorial Guinea">赤道几内亚</option>
                            <option value="Eritrea">厄立特里亚</option>
                            <option value="Estonia">爱沙尼亚</option>
                            <option value="Ethiopia">埃塞俄比亚</option>
                            <option value="Faeroe Islands">法罗群岛</option>
                            <option value="Falkland Islands">福克兰群岛</option>
                            <option value="Fiji">斐济</option>
                            <option value="Finland">芬兰</option>
                            <option value="France">法国</option>
                            <option value="French Guiana">法属圭亚那</option>
                            <option value="French Polynesia">法属波利尼西亚</option>
                            <option value="Gabon">加蓬</option>
                            <option value="Gambia">冈比亚</option>
                            <option value="Georgia">格鲁吉亚</option>
                            <option value="Germany">德国</option>
                            <option value="Ghana">加纳</option>
                            <option value="Gibraltar">直布罗陀</option>
                            <option value="Greece">希腊</option>
                            <option value="Greenland">格陵兰</option>
                            <option value="Grenada">格林纳达</option>
                            <option value="Guadeloupe">瓜德罗普岛</option>
                            <option value="Guam">关岛</option>
                            <option value="Guatemala">危地马拉</option>
                            <option value="Guinea">几内亚</option>
                            <option value="Guinea-Bissau">几内亚比绍共和国</option>
                            <option value="Guyana">圭亚那</option>
                            <option value="Haiti">海地</option>
                            <option value="Honduras">洪都拉斯</option>
                            <option value="Hong Kong">香港</option>
                            <option value="Hungary">匈牙利</option>
                            <option value="Iceland">冰岛</option>
                            <option value="India">印度</option>
                            <option value="Indonesia">印尼</option>
                            <option value="Iran">伊朗</option>
                            <option value="Iraq">伊拉克</option>
                            <option value="Ireland">爱尔兰</option>
                            <option value="Israel">以色列</option>
                            <option value="Italy">意大利</option>
                            <option value="Ivory Coast">科特迪瓦</option>
                            <option value="Jamaica">牙买加</option>
                            <option value="Japan">日本</option>
                            <option value="Jordan">约旦</option>
                            <option value="Kazakhstan">哈萨克</option>
                            <option value="Kenya">肯尼亚</option>
                            <option value="Kirghizia (formerly Kyrgyzstan)">吉尔吉斯斯坦</option>
                            <option value="Kiribati">基里巴斯</option>
                            <option value="Kuwait">科威特</option>
                            <option value="Laos">老挝国</option>
                            <option value="Latvia">拉脱维亚</option>
                            <option value="Lebanon">黎巴嫩</option>
                            <option value="Lesotho">莱索托</option>
                            <option value="Liberia">利比里亚</option>
                            <option value="Libya">利比亚</option>
                            <option value="Liechtenstein">列支敦士登</option>
                            <option value="Lithuania">立陶宛</option>
                            <option value="Luxembourg">卢森堡</option>
                            <option value="Macau">澳门</option>
                            <option value="Macedonia">马其顿</option>
                            <option value="Madagascar">马达加斯加岛</option>
                            <option value="Malawi">马拉维</option>
                            <option value="Malaysia">马来西亚</option>
                            <option value="Maldives">马尔代夫</option>
                            <option value="Mali">马里</option>
                            <option value="Malta">马耳他</option>
                            <option value="Marshall Islands">马绍尔群岛</option>
                            <option value="Martinique">马提尼克</option>
                            <option value="Mauritania">毛利塔尼亚</option>
                            <option value="Mauritius">毛里求斯</option>
                            <option value="Mexico">墨西哥</option>
                            <option value="Micronesia,Federated States of">密克罗尼西亚</option>
                            <option value="Moldova">摩尔多瓦</option>
                            <option value="Monaco">摩纳哥</option>
                            <option value="Mongolia">蒙古</option>
                            <option value="Montenegro">黑山</option>
                            <option value="Montserrat">蒙特塞拉特岛</option>
                            <option value="Morocco">摩洛哥</option>
                            <option value="Mozambique">莫桑比克</option>
                            <option value="Myanmar">缅甸</option>
                            <option value="Namibia">纳米比亚</option>
                            <option value="Nauru">瑙鲁</option>
                            <option value="Nepal">尼泊尔</option>
                            <option value="Netherlands Antilles">荷属安的列斯群岛</option>
                            <option value="Netherlands(Holland)">荷兰</option>
                            <option value="New Caledonia">新喀里多尼亚</option>
                            <option value="New Zealand">新西兰</option>
                            <option value="Nicaragua">尼加拉瓜</option>
                            <option value="Niger">尼日尔</option>
                            <option value="Nigeria">尼日利亚</option>
                            <option value="Niue">纽埃</option>
                            <option value="Norfolk Island">诺福克</option>
                            <option value="Northern Mariana islands">北马里亚纳群岛</option>
                            <option value="Norway">挪威</option>
                            <option value="Oman">阿曼</option>
                            <option value="Pakistan">巴基斯坦</option>
                            <option value="Palau">帕劳群岛</option>
                            <option value="Panama">巴拿马</option>
                            <option value="Papua New Guinea">巴布亚新几内亚</option>
                            <option value="Paraguay">巴拉圭</option>
                            <option value="Peru">秘鲁</option>
                            <option value="Philippines">菲律宾共和国</option>
                            <option value="Poland">波兰</option>
                            <option value="Portugal">葡萄牙</option>
                            <option value="Puerto Rico">波多黎各</option>
                            <option value="Qatar">卡塔尔</option>
                            <option value="Reunion Island">留尼汪岛</option>
                            <option value="Romania">罗马尼亚</option>
                            <option value="Russia">俄罗斯</option>
                            <option value="Rwanda">卢旺达</option>
                            <option value="Saint Kitts and Nevis">圣基茨和尼维斯</option>
                            <option value="Saint Lucia">圣卢西亚</option>
                            <option value="Saint Vincent and Grenadines">圣文森特和格林纳丁斯</option>
                            <option value="Samoa">萨摩亚</option>
                            <option value="San Marino">圣马力诺</option>
                            <option value="Sao Tome and Principe">圣多美和普林西比</option>
                            <option value="Saudi Arabia">沙特阿拉伯</option>
                            <option value="Senegal">塞内加尔</option>
                            <option value="Serbia">塞尔维亚共和国</option>
                            <option value="Seychelles">塞舌尔</option>
                            <option value="Sierra Leone">塞拉利昂</option>
                            <option value="Singapore">新加坡</option>
                            <option value="Slovakia">斯洛伐克</option>
                            <option value="Slovenia">斯洛文尼亚</option>
                            <option value="Solomon Islands">所罗门</option>
                            <option value="Somalia">索马里</option>
                            <option value="South Africa">南非</option>
                            <option value="South Korea">韩国</option>
                            <option value="Spain">西班牙</option>
                            <option value="Sri Lanka">斯里兰卡</option>
                            <option value="Sudan">苏丹</option>
                            <option value="Suriname">苏里南</option>
                            <option value="Swaziland">斯威士兰</option>
                            <option value="Sweden">瑞典</option>
                            <option value="Switzerland">瑞士</option>
                            <option value="Syria">叙利亚共和国</option>
                            <option value="Taiwan">台湾</option>
                            <option value="Tajikistan">塔吉克斯坦</option>
                            <option value="Tanzania">坦桑尼亚</option>
                            <option value="Thailand">泰国</option>
                            <option value="The Republic of Congo">刚果 布</option>
                            <option value="Togo">多哥</option>
                            <option value="Tonga">汤加</option>
                            <option value="Trinidad and Tobago">特立尼达和多巴哥</option>
                            <option value="Tunisia">突尼斯</option>
                            <option value="Turkey">土耳其</option>
                            <option value="Turkmenistan">土库曼斯坦</option>
                            <option value="Turks and Caicos Islands">特克斯和凯科斯群岛</option>
                            <option value="Tuvalu">图瓦卢</option>
                            <option value="US Virgin Islands">美属维尔京群岛</option>
                            <option value="Uganda">乌干达</option>
                            <option value="Ukraine">乌克兰</option>
                            <option value="United Arab Emirates">阿拉伯联合酋长国</option>
                            <option value="United Kingdom">英国</option>
                            <option value="United States">美国</option>
                            <option value="Uruguay">乌拉圭</option>
                            <option value="Uzbekistan">乌兹别克斯坦</option>
                            <option value="Vanuatu">瓦努阿图</option>
                            <option value="Vatican City">梵蒂冈</option>
                            <option value="Venezuela">委内瑞拉</option>
                            <option value="VietNam">越南</option>
                            <option value="Wallis and Futuna Islands">瓦利斯群岛</option>
                            <option value="Yemen,Repubic of">也门</option>
                            <option value="Zambia">赞比亚</option>
                            <option value="Zimbabwe">津巴布韦</option>
                          </select>
                        </div>
                        <!--备货信息 开始-->
                        <div id="StockCount" class="mainlayout ml-nowidth clearfix">
                          <div class="ml-title">设置备货数量： </div>
                          <p class="padbottom10 helptips">调整每个规格的备货数量，如无规格则调整总数量</p>
                          <p class="padbottom10">
                            <label>
                            <input name="RadioBtn2" value="1" CHECKED="true" type="radio">
                            <span class="marginleft5 marginright10">增加</span></label>
                            <label>
                            <input name="RadioBtn2" value="0" type="radio">
                            <span class="marginleft5">减少</span></label>
                          </p>
                          <p class="padbottom10">
                            <input id="count" class="attr-text-input addwid60" value="" type="text">
                            <span class="marginleft5">个</span></p>
                        </div>
                        <!-- 备货信息弹层 结束 -->
                        <div class="popupbox-button clearfix"> <span class="yellowBtn valmiddle">
                          <input onclick="doInventory();" value="确 定" type="button">
                          </span> <span class="tourBtn">
                          <input onclick="jQuery.modal.close();return false;" value="取 消" type="button">
                          </span> </div>
                      </div>
                      <div class="noshade-pop-bot"></div>
                      <a class="noshade-pop-close" onclick="jQuery.modal.close();return false;" href="javascript:void(0)"></a> </div>
                  </div></td>
                <td class="m-ri"></td>
              </tr>
              <tr>
                <td class="b-lt"></td>
                <td class="b-mid"></td>
                <td class="b-ri"></td>
              </tr>
            </tbody>
          </table>
          <table style="width: 300px; display: none;" id="faild" class="noshade-pop-table">
            <tbody>
              <tr>
                <td class="t-lt"></td>
                <td class="t-mid"></td>
                <td class="t-ri"></td>
              </tr>
              <tr>
                <td class="m-lt"></td>
                <td class="m-mid"><div class="mid-warp">
                    <div class="noshade-pop-content">
                      <div class="noshade-pop-inner">
                        <div class="noshade-pop-title"> <span>提示信息</span> </div>
                        <div class="box1 boxcenter"> <span class="ptp-error"><b id="faildcount">5</b>个产品更新备货信息失败</span> </div>
                        <div class="boxcenter clearfix"> <span class="yellowBtn">
                          <input onclick="reset()" value="确定" type="button">
                          </span> </div>
                      </div>
                      <div class="noshade-pop-bot"></div>
                      <a class="noshade-pop-close" onclick="reset()" href="javascript:void(0)"></a> </div>
                  </div></td>
                <td class="m-ri"></td>
              </tr>
              <tr>
                <td class="b-lt"></td>
                <td class="b-mid"></td>
                <td class="b-ri"></td>
              </tr>
            </tbody>
          </table>
          <table style="width: 330px; display: none;" id="success" class="noshade-pop-table">
            <tbody>
              <tr>
                <td class="t-lt"></td>
                <td class="t-mid"></td>
                <td class="t-ri"></td>
              </tr>
              <tr>
                <td class="m-lt"></td>
                <td class="m-mid"><div class="mid-warp">
                    <div class="noshade-pop-content">
                      <div class="noshade-pop-inner">
                        <div class="noshade-pop-title"> <span>提示信息</span> </div>
                        <div id="successcountspan" class="box2"> <span class="ptp-correct"><b id="successcount">5</b>个产品已经更新备货信息<br>
                          </span> </div>
                        <div class="boxcenter clearfix"> <span class="yellowBtn">
                          <input onclick="reset()" value="确定" type="button">
                          </span> </div>
                      </div>
                      <div class="noshade-pop-bot"></div>
                      <a class="noshade-pop-close" onclick="reset()" href="javascript:void(0)"></a> </div>
                  </div></td>
                <td class="m-ri"></td>
              </tr>
              <tr>
                <td class="b-lt"></td>
                <td class="b-mid"></td>
                <td class="b-ri"></td>
              </tr>
            </tbody>
          </table>
          <!-- 弹层操作 开始 -->
          <div style="width: 800px; display: none;" class="j-dialog-akey">
            <div class="amodifiedpop j-tab-container">
              <div class="poptab-warp clearfix">
                <ul>
                  <li class="j-tab-item current" data-target=".j-turn-ready"><span>有备货转化为待备货</span></li>
                  <li class="j-tab-item" data-target=".j-turn-stock"><span>待备货转化为有备货</span></li>
                </ul>
              </div>
              <div style="display: none;" class="j-tab-content j-turn-ready">
                <div class="amodifiedcontextlist amflayout2 clearfix">
                  <div class="j-load-container">
                    <div class="amtxt"> <span class="amloadding"></span>
                      <h2 class="h2title j-msg">备货信息正在修改中，请耐心等待。</h2>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button j-btn-close">
                      <input value="关闭" type="button">
                      </span> </div>
                  </div>
                  <div class="j-main-container">
                    <div class="tripmarkmessage"> 一次性将所选范围内产品的备货状态修改为 <b>待备货</b> 状态 </div>
                    <div class="mainlayout clearfix"> <span class="ml-title">产品范围：</span>
                      <div class="amcontext clearfix">
                        <p>
                          <input id="prodfw01" class="j-el-scope" name="scope" value="100" CHECKED="checked" type="radio">
                          <label class="radiobtnlabel" for="prodfw01">所有产品</label>
                        </p>
                        <p class="clearfix j-productgroup">
                          <input id="prodfw02" class="j-el-scope" name="scope" value="102" type="radio">
                          <label class="radiobtnlabel" for="prodfw02">指定产品组</label>
                          <select class="j-select-root">
                          </select>
                          <select style="display: none;" class="j-select-sub">
                          </select>
                          <input class="j-input-hidden" type="hidden">
                          <span style="display: none;" class="amerror j-error-productgroup"></span> </p>
                      </div>
                    </div>
                    <div class="mainlayout clearfix"> <span class="ml-title">备货期：</span>
                      <div class="amcontext clearfix">
                        <p>
                          <input class="am-text addwid60 marginright10 j-el-period" type="text">
                          <span class="marginright10">天</span> <span style="display: none;" class="amerror j-error-period"></span> </p>
                      </div>
                    </div>
                    <div class="mainlayout clearfix"> <span class="ml-title">一次最大购买数量：</span>
                      <div class="amcontext clearfix">
                        <p>
                          <input class="am-text addwid60 marginright10 j-el-buynum" value="" type="text">
                          <span style="display: none;" class="amerror j-error-buynum"></span> </p>
                      </div>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button j-btn-confirm">
                      <input value="提 交" type="button">
                      </span> </div>
                  </div>
                  <div style="display: none;" class="j-confirm-container">
                    <div class="amtxt"> <span class="ammarkmessage"></span>
                      <h2 class="h2title j-msg">您确认要将所有有备货状态产品转换为待备货状态吗？</h2>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button marginright20 j-btn-doconfirm">
                      <input value="确认提交" type="button">
                      </span> <span class="biggrey-button j-btn-goback">
                      <input value="上一步" type="button">
                      </span> </div>
                  </div>
                  <div style="display: none;" class="j-success-container">
                    <div class="amodifiedcontextlist">
                      <div class="amtxt"> <span class="ammiddleright"></span>
                        <h2 class="h2title j-msg">共计<span class="colorf50">XXXX</span>个产品的备货信息修改完</h2>
                      </div>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button j-btn-close">
                      <input value="关闭" type="button">
                      </span> </div>
                  </div>
                  <div style="display: none;" class="j-fail-container">
                    <div class="amodifiedcontextlist">
                      <div class="amtxt"> <span class="ammiddleerror"></span>
                        <h2 class="h2title j-msg">出错了。</h2>
                      </div>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button marginright20 j-btn-retry">
                      <input value="重新提交" type="button">
                      </span> <span class="biggrey-button j-btn-close">
                      <input value="关闭" type="button">
                      </span> </div>
                  </div>
                </div>
              </div>
              <div style="display: none;" class="j-tab-content j-turn-stock">
                <div class="amodifiedcontextlist amflayout2 clearfix">
                  <div class="j-load-container">
                    <div class="amtxt"> <span class="amloadding"></span>
                      <h2 class="h2title j-msg">备货信息正在修改中，请耐心等待。</h2>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button j-btn-close">
                      <input value="关闭" type="button">
                      </span> </div>
                  </div>
                  <div class="j-main-container">
                    <div class="tripmarkmessage"> 一次性将所选范围内产品的备货状态修改为 <b>有备货</b> 状态 </div>
                    <div class="mainlayout clearfix"> <span class="ml-title">产品范围：</span>
                      <div class="amcontext clearfix">
                        <p>
                          <input id="prodfw03" class="j-el-scope" name="stockScope" value="100" CHECKED="checked" type="radio">
                          <label class="radiobtnlabel" for="prodfw03">所有产品</label>
                        </p>
                        <p class="clearfix j-productgroup">
                          <input id="prodfw04" class="j-el-scope" name="stockScope" value="102" type="radio">
                          <label class="radiobtnlabel" for="prodfw04">指定产品组</label>
                          <select class="j-select-root">
                          </select>
                          <select style="display: none;" class="j-select-sub">
                          </select>
                          <input class="j-input-hidden" type="hidden">
                          <span style="display: none;" class="amerror j-error-productgroup"></span> </p>
                      </div>
                    </div>
                    <div class="mainlayout clearfix"> <span class="ml-title">备货所在地：</span>
                      <div class="amcontext clearfix">
                        <p>
                          <select class="addwid130 marginright10 j-el-area">
                            <option title="阿富汗" value="AF">阿富汗</option>
                            <option title="阿尔巴尼亚" value="AL">阿尔巴尼亚</option>
                            <option title="阿尔及利亚" value="DZ">阿尔及利亚</option>
                            <option title="美属萨摩亚" value="AS">美属萨摩亚</option>
                            <option title="安道尔(安多拉)" value="AD">安道尔(安多拉)</option>
                            <option title="安哥拉" value="AO">安哥拉</option>
                            <option title="安圭拉岛" value="AI">安圭拉岛</option>
                            <option title="安提瓜岛" value="AG">安提瓜岛</option>
                            <option title="阿根廷" value="AR">阿根廷</option>
                            <option title="亚美尼亚" value="AM">亚美尼亚</option>
                            <option title="阿鲁巴岛" value="AW">阿鲁巴岛</option>
                            <option title="澳大利亚" value="AU">澳大利亚</option>
                            <option title="奥地利" value="AT">奥地利</option>
                            <option title="阿塞拜疆" value="AZ">阿塞拜疆</option>
                            <option title="巴哈马群岛" value="BS">巴哈马群岛</option>
                            <option title="巴林群岛" value="BH">巴林群岛</option>
                            <option title="孟加拉国" value="BD">孟加拉国</option>
                            <option title="巴巴多斯岛" value="BB">巴巴多斯岛</option>
                            <option title="白俄罗斯" value="BY">白俄罗斯</option>
                            <option title="比利时" value="BE">比利时</option>
                            <option title="伯利兹城" value="BZ">伯利兹城</option>
                            <option title="贝宁湾" value="BJ">贝宁湾</option>
                            <option title="百慕大群岛" value="BM">百慕大群岛</option>
                            <option title="不丹" value="BT">不丹</option>
                            <option title="玻利维亚" value="BO">玻利维亚</option>
                            <option title="波斯尼亚" value="BA">波斯尼亚</option>
                            <option title="博茨瓦纳" value="BW">博茨瓦纳</option>
                            <option title="巴西" value="BR">巴西</option>
                            <option title="英属维尔京群岛" value="VG">英属维尔京群岛</option>
                            <option title="文莱" value="BN">文莱</option>
                            <option title="保加利亚" value="BG">保加利亚</option>
                            <option title="布基纳法索" value="BF">布基纳法索</option>
                            <option title="布隆迪" value="BI">布隆迪</option>
                            <option title="柬埔寨" value="KH">柬埔寨</option>
                            <option title="喀麦隆" value="CM">喀麦隆</option>
                            <option title="加拿大" value="CA">加拿大</option>
                            <option title="佛得角共和国" value="CV">佛得角共和国</option>
                            <option title="开曼群岛" value="KY">开曼群岛</option>
                            <option title="中非共和国" value="CF">中非共和国</option>
                            <option title="乍得" value="TD">乍得</option>
                            <option title="智利" value="CL">智利</option>
                            <option title="中国" value="CN">中国</option>
                            <option title="哥伦比亚" value="CO">哥伦比亚</option>
                            <option title="科摩罗" value="KM">科摩罗</option>
                            <option title="库克群岛" value="CK">库克群岛</option>
                            <option title="哥斯达黎加" value="CR">哥斯达黎加</option>
                            <option title="克罗地亚" value="HR">克罗地亚</option>
                            <option title="古巴" value="CU">古巴</option>
                            <option title="塞浦路斯" value="CY">塞浦路斯</option>
                            <option title="捷克" value="CZ">捷克</option>
                            <option title="刚果 金" value="CD">刚果 金</option>
                            <option title="丹麦" value="DK">丹麦</option>
                            <option title="吉布提" value="DJ">吉布提</option>
                            <option title="多米尼加" value="DM">多米尼加</option>
                            <option title="多米尼加共和国" value="DO">多米尼加共和国</option>
                            <option title="东帝汶" value="TL">东帝汶</option>
                            <option title="厄瓜多尔" value="EC">厄瓜多尔</option>
                            <option title="埃及" value="EG">埃及</option>
                            <option title="萨尔瓦多" value="SV">萨尔瓦多</option>
                            <option title="赤道几内亚" value="GQ">赤道几内亚</option>
                            <option title="厄立特里亚" value="ER">厄立特里亚</option>
                            <option title="爱沙尼亚" value="EE">爱沙尼亚</option>
                            <option title="埃塞俄比亚" value="ET">埃塞俄比亚</option>
                            <option title="法罗群岛" value="FO">法罗群岛</option>
                            <option title="福克兰群岛" value="FK">福克兰群岛</option>
                            <option title="斐济" value="FJ">斐济</option>
                            <option title="芬兰" value="FI">芬兰</option>
                            <option title="法国" value="FR">法国</option>
                            <option title="法属圭亚那" value="GF">法属圭亚那</option>
                            <option title="法属波利尼西亚" value="PF">法属波利尼西亚</option>
                            <option title="加蓬" value="GA">加蓬</option>
                            <option title="冈比亚" value="GM">冈比亚</option>
                            <option title="格鲁吉亚" value="GE">格鲁吉亚</option>
                            <option title="德国" value="DE">德国</option>
                            <option title="加纳" value="GH">加纳</option>
                            <option title="直布罗陀" value="GI">直布罗陀</option>
                            <option title="希腊" value="GR">希腊</option>
                            <option title="格陵兰" value="GL">格陵兰</option>
                            <option title="格林纳达" value="GD">格林纳达</option>
                            <option title="瓜德罗普岛" value="GP">瓜德罗普岛</option>
                            <option title="关岛" value="GU">关岛</option>
                            <option title="危地马拉" value="GT">危地马拉</option>
                            <option title="几内亚" value="GN">几内亚</option>
                            <option title="几内亚比绍共和国" value="GW">几内亚比绍共和国</option>
                            <option title="圭亚那" value="GY">圭亚那</option>
                            <option title="海地" value="HT">海地</option>
                            <option title="洪都拉斯" value="HN">洪都拉斯</option>
                            <option title="香港" value="HK">香港</option>
                            <option title="匈牙利" value="HU">匈牙利</option>
                            <option title="冰岛" value="IS">冰岛</option>
                            <option title="印度" value="IN">印度</option>
                            <option title="印尼" value="ID">印尼</option>
                            <option title="伊朗" value="IR">伊朗</option>
                            <option title="伊拉克" value="IQ">伊拉克</option>
                            <option title="爱尔兰" value="IE">爱尔兰</option>
                            <option title="以色列" value="IL">以色列</option>
                            <option title="意大利" value="IT">意大利</option>
                            <option title="科特迪瓦" value="CI">科特迪瓦</option>
                            <option title="牙买加" value="JM">牙买加</option>
                            <option title="日本" value="JP">日本</option>
                            <option title="约旦" value="JO">约旦</option>
                            <option title="哈萨克" value="KZ">哈萨克</option>
                            <option title="肯尼亚" value="KE">肯尼亚</option>
                            <option title="吉尔吉斯斯坦" value="KG">吉尔吉斯斯坦</option>
                            <option title="基里巴斯" value="KI">基里巴斯</option>
                            <option title="科威特" value="KW">科威特</option>
                            <option title="老挝国" value="LA">老挝国</option>
                            <option title="拉脱维亚" value="LV">拉脱维亚</option>
                            <option title="黎巴嫩" value="LB">黎巴嫩</option>
                            <option title="莱索托" value="LS">莱索托</option>
                            <option title="利比里亚" value="LR">利比里亚</option>
                            <option title="利比亚" value="LY">利比亚</option>
                            <option title="列支敦士登" value="LI">列支敦士登</option>
                            <option title="立陶宛" value="LT">立陶宛</option>
                            <option title="卢森堡" value="LU">卢森堡</option>
                            <option title="澳门" value="MO">澳门</option>
                            <option title="马其顿" value="MK">马其顿</option>
                            <option title="马达加斯加岛" value="MG">马达加斯加岛</option>
                            <option title="马拉维" value="MW">马拉维</option>
                            <option title="马来西亚" value="MY">马来西亚</option>
                            <option title="马尔代夫" value="MV">马尔代夫</option>
                            <option title="马里" value="ML">马里</option>
                            <option title="马耳他" value="MT">马耳他</option>
                            <option title="马绍尔群岛" value="MH">马绍尔群岛</option>
                            <option title="马提尼克" value="MQ">马提尼克</option>
                            <option title="毛利塔尼亚" value="MR">毛利塔尼亚</option>
                            <option title="毛里求斯" value="MU">毛里求斯</option>
                            <option title="墨西哥" value="MX">墨西哥</option>
                            <option title="密克罗尼西亚" value="FM">密克罗尼西亚</option>
                            <option title="摩尔多瓦" value="MD">摩尔多瓦</option>
                            <option title="摩纳哥" value="MC">摩纳哥</option>
                            <option title="蒙古" value="MN">蒙古</option>
                            <option title="黑山" value="ME">黑山</option>
                            <option title="蒙特塞拉特岛" value="MS">蒙特塞拉特岛</option>
                            <option title="摩洛哥" value="MA">摩洛哥</option>
                            <option title="莫桑比克" value="MZ">莫桑比克</option>
                            <option title="缅甸" value="MM">缅甸</option>
                            <option title="纳米比亚" value="NA">纳米比亚</option>
                            <option title="瑙鲁" value="NR">瑙鲁</option>
                            <option title="尼泊尔" value="NP">尼泊尔</option>
                            <option title="荷属安的列斯群岛" value="AN">荷属安的列斯群岛</option>
                            <option title="荷兰" value="NL">荷兰</option>
                            <option title="新喀里多尼亚" value="NC">新喀里多尼亚</option>
                            <option title="新西兰" value="NZ">新西兰</option>
                            <option title="尼加拉瓜" value="NI">尼加拉瓜</option>
                            <option title="尼日尔" value="NE">尼日尔</option>
                            <option title="尼日利亚" value="NG">尼日利亚</option>
                            <option title="纽埃" value="NU">纽埃</option>
                            <option title="诺福克" value="NF">诺福克</option>
                            <option title="北马里亚纳群岛" value="MP">北马里亚纳群岛</option>
                            <option title="挪威" value="NO">挪威</option>
                            <option title="阿曼" value="OM">阿曼</option>
                            <option title="巴基斯坦" value="PK">巴基斯坦</option>
                            <option title="帕劳群岛" value="PW">帕劳群岛</option>
                            <option title="巴拿马" value="PA">巴拿马</option>
                            <option title="巴布亚新几内亚" value="PG">巴布亚新几内亚</option>
                            <option title="巴拉圭" value="PY">巴拉圭</option>
                            <option title="秘鲁" value="PE">秘鲁</option>
                            <option title="菲律宾共和国" value="PH">菲律宾共和国</option>
                            <option title="波兰" value="PL">波兰</option>
                            <option title="葡萄牙" value="PT">葡萄牙</option>
                            <option title="波多黎各" value="PR">波多黎各</option>
                            <option title="卡塔尔" value="QA">卡塔尔</option>
                            <option title="留尼汪岛" value="RE">留尼汪岛</option>
                            <option title="罗马尼亚" value="RO">罗马尼亚</option>
                            <option title="俄罗斯" value="RU">俄罗斯</option>
                            <option title="卢旺达" value="RW">卢旺达</option>
                            <option title="圣基茨和尼维斯" value="KN">圣基茨和尼维斯</option>
                            <option title="圣卢西亚" value="LC">圣卢西亚</option>
                            <option title="圣文森特和格林纳丁斯" value="VC">圣文森特和格林纳丁斯</option>
                            <option title="萨摩亚" value="WS">萨摩亚</option>
                            <option title="圣马力诺" value="SM">圣马力诺</option>
                            <option title="圣多美和普林西比" value="ST">圣多美和普林西比</option>
                            <option title="沙特阿拉伯" value="SA">沙特阿拉伯</option>
                            <option title="塞内加尔" value="SN">塞内加尔</option>
                            <option title="塞尔维亚共和国" value="RS">塞尔维亚共和国</option>
                            <option title="塞舌尔" value="SC">塞舌尔</option>
                            <option title="塞拉利昂" value="SL">塞拉利昂</option>
                            <option title="新加坡" value="SG">新加坡</option>
                            <option title="斯洛伐克" value="SK">斯洛伐克</option>
                            <option title="斯洛文尼亚" value="SI">斯洛文尼亚</option>
                            <option title="所罗门" value="SB">所罗门</option>
                            <option title="索马里" value="SO">索马里</option>
                            <option title="南非" value="ZA">南非</option>
                            <option title="韩国" value="KR">韩国</option>
                            <option title="西班牙" value="ES">西班牙</option>
                            <option title="斯里兰卡" value="LK">斯里兰卡</option>
                            <option title="苏丹" value="SD">苏丹</option>
                            <option title="苏里南" value="SR">苏里南</option>
                            <option title="斯威士兰" value="SZ">斯威士兰</option>
                            <option title="瑞典" value="SE">瑞典</option>
                            <option title="瑞士" value="CH">瑞士</option>
                            <option title="叙利亚共和国" value="SY">叙利亚共和国</option>
                            <option title="台湾" value="TW">台湾</option>
                            <option title="塔吉克斯坦" value="TJ">塔吉克斯坦</option>
                            <option title="坦桑尼亚" value="TZ">坦桑尼亚</option>
                            <option title="泰国" value="TH">泰国</option>
                            <option title="刚果 布" value="CG">刚果 布</option>
                            <option title="多哥" value="TG">多哥</option>
                            <option title="汤加" value="TO">汤加</option>
                            <option title="特立尼达和多巴哥" value="TT">特立尼达和多巴哥</option>
                            <option title="突尼斯" value="TN">突尼斯</option>
                            <option title="土耳其" value="TR">土耳其</option>
                            <option title="土库曼斯坦" value="TM">土库曼斯坦</option>
                            <option title="特克斯和凯科斯群岛" value="TC">特克斯和凯科斯群岛</option>
                            <option title="图瓦卢" value="TV">图瓦卢</option>
                            <option title="美属维尔京群岛" value="VI">美属维尔京群岛</option>
                            <option title="乌干达" value="UG">乌干达</option>
                            <option title="乌克兰" value="UA">乌克兰</option>
                            <option title="阿拉伯联合酋长国" value="AE">阿拉伯联合酋长国</option>
                            <option title="英国" value="UK">英国</option>
                            <option title="美国" value="US">美国</option>
                            <option title="乌拉圭" value="UY">乌拉圭</option>
                            <option title="乌兹别克斯坦" value="UZ">乌兹别克斯坦</option>
                            <option title="瓦努阿图" value="VU">瓦努阿图</option>
                            <option title="梵蒂冈" value="VA">梵蒂冈</option>
                            <option title="委内瑞拉" value="VE">委内瑞拉</option>
                            <option title="越南" value="VN">越南</option>
                            <option title="瓦利斯群岛" value="WF">瓦利斯群岛</option>
                            <option title="也门" value="YE">也门</option>
                            <option title="赞比亚" value="ZM">赞比亚</option>
                            <option title="津巴布韦" value="ZW">津巴布韦</option>
                          </select>
                        </p>
                      </div>
                    </div>
                    <div class="mainlayout clearfix"> <span class="ml-title">备货数量：</span>
                      <div class="amcontext clearfix">
                        <p>
                          <input class="am-text addwid60 marginright10 j-el-stocknum" type="text">
                          <span style="display: none;" class="amerror j-error-stocknum"></span> </p>
                      </div>
                    </div>
                    <div class="mainlayout clearfix"> <span class="ml-title">备货期：</span>
                      <div class="amcontext clearfix">
                        <p>
                          <input class="am-text addwid60 marginright10 j-el-period" type="text">
                          <span class="marginright10">天</span><span style="display: none;" class="amerror j-error-period"></span> </p>
                      </div>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button j-btn-confirm">
                      <input value="提 交" type="button">
                      </span> </div>
                  </div>
                  <div style="display: none;" class="j-confirm-container">
                    <div class="amtxt"> <span class="ammarkmessage"></span>
                      <h2 class="h2title j-msg">您确认要将所有有备货状态产品转换为待备货状态吗？</h2>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button marginright20 j-btn-doconfirm">
                      <input value="确认提交" type="button">
                      </span> <span class="biggrey-button j-btn-goback">
                      <input value="上一步" type="button">
                      </span> </div>
                  </div>
                  <div style="display: none;" class="j-success-container">
                    <div class="amodifiedcontextlist">
                      <div class="amtxt"> <span class="ammiddleright"></span>
                        <h2 class="h2title j-msg">共计<span class="colorf50">XXXX</span>个产品的备货信息修改完</h2>
                      </div>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button j-btn-close">
                      <input value="关闭" type="button">
                      </span> </div>
                  </div>
                  <div style="display: none;" class="j-fail-container">
                    <div class="amodifiedcontextlist">
                      <div class="amtxt"> <span class="ammiddleerror"></span>
                        <h2 class="h2title j-msg">出错了。</h2>
                      </div>
                    </div>
                    <div class="ambtncenter clearfix"> <span class="bigyellow-button marginright20 j-btn-retry">
                      <input value="重新提交" type="button">
                      </span> <span class="biggrey-button j-btn-close">
                      <input value="关闭" type="button">
                      </span> </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div style="width: 450px; display: none;" class="j-dialog-batch-ready">
            <div class="amodifiedpop">
              <div class="amodifiedcontextlist amflayout2 clearfix">
                <p class="marginleft10 margintop10">您共选择了 <b class="prompt-letter j-product-num">11</b> 个产品，将备货状态修改为 <b>待备货</b> 状态</p>
                <div class="mainlayout clearfix"> <span class="ml-title">备货期：</span>
                  <div class="amcontext clearfix">
                    <p>
                      <input class="am-text addwid60 marginright10 j-period" type="text">
                      <span class="marginright10">天</span><span style="display: none;" class="amerror j-error-period"></span> </p>
                  </div>
                </div>
                <div class="mainlayout clearfix"> <span class="ml-title">一次最大购买数量：</span>
                  <div class="amcontext clearfix">
                    <p>
                      <input class="am-text addwid60 marginright10 j-buy-num" type="text">
                      <span style="display: none;" class="amerror j-error-buy-num"></span> </p>
                  </div>
                </div>
              </div>
              <div class="ambtncenter clearfix"> <span class="yellowBtn j-btn-confirm">
                <input value="确 定" type="button">
                </span> <span class="tourBtn j-btn-cancel">
                <input value="取 消" type="button">
                </span> </div>
            </div>
          </div>
          <div style="width: 450px; display: none;" class="j-dialog-batch-stock">
            <div class="amodifiedpop">
              <div class="amodifiedcontextlist amflayout2 clearfix">
                <p class="marginleft10 margintop10">您共选择了 <b class="prompt-letter j-product-num">11</b> 个产品，将备货状态修改为 <b>有备货</b> 状态</p>
                <div class="mainlayout clearfix"> <span class="ml-title">备货所在地：</span>
                  <div class="amcontext clearfix">
                    <p>
                      <select class="addwid130 marginright10 j-area">
                        <option title="阿富汗" value="AF">阿富汗</option>
                        <option title="阿尔巴尼亚" value="AL">阿尔巴尼亚</option>
                        <option title="阿尔及利亚" value="DZ">阿尔及利亚</option>
                        <option title="美属萨摩亚" value="AS">美属萨摩亚</option>
                        <option title="安道尔(安多拉)" value="AD">安道尔(安多拉)</option>
                        <option title="安哥拉" value="AO">安哥拉</option>
                        <option title="安圭拉岛" value="AI">安圭拉岛</option>
                        <option title="安提瓜岛" value="AG">安提瓜岛</option>
                        <option title="阿根廷" value="AR">阿根廷</option>
                        <option title="亚美尼亚" value="AM">亚美尼亚</option>
                        <option title="阿鲁巴岛" value="AW">阿鲁巴岛</option>
                        <option title="澳大利亚" value="AU">澳大利亚</option>
                        <option title="奥地利" value="AT">奥地利</option>
                        <option title="阿塞拜疆" value="AZ">阿塞拜疆</option>
                        <option title="巴哈马群岛" value="BS">巴哈马群岛</option>
                        <option title="巴林群岛" value="BH">巴林群岛</option>
                        <option title="孟加拉国" value="BD">孟加拉国</option>
                        <option title="巴巴多斯岛" value="BB">巴巴多斯岛</option>
                        <option title="白俄罗斯" value="BY">白俄罗斯</option>
                        <option title="比利时" value="BE">比利时</option>
                        <option title="伯利兹城" value="BZ">伯利兹城</option>
                        <option title="贝宁湾" value="BJ">贝宁湾</option>
                        <option title="百慕大群岛" value="BM">百慕大群岛</option>
                        <option title="不丹" value="BT">不丹</option>
                        <option title="玻利维亚" value="BO">玻利维亚</option>
                        <option title="波斯尼亚" value="BA">波斯尼亚</option>
                        <option title="博茨瓦纳" value="BW">博茨瓦纳</option>
                        <option title="巴西" value="BR">巴西</option>
                        <option title="英属维尔京群岛" value="VG">英属维尔京群岛</option>
                        <option title="文莱" value="BN">文莱</option>
                        <option title="保加利亚" value="BG">保加利亚</option>
                        <option title="布基纳法索" value="BF">布基纳法索</option>
                        <option title="布隆迪" value="BI">布隆迪</option>
                        <option title="柬埔寨" value="KH">柬埔寨</option>
                        <option title="喀麦隆" value="CM">喀麦隆</option>
                        <option title="加拿大" value="CA">加拿大</option>
                        <option title="佛得角共和国" value="CV">佛得角共和国</option>
                        <option title="开曼群岛" value="KY">开曼群岛</option>
                        <option title="中非共和国" value="CF">中非共和国</option>
                        <option title="乍得" value="TD">乍得</option>
                        <option title="智利" value="CL">智利</option>
                        <option title="中国" value="CN">中国</option>
                        <option title="哥伦比亚" value="CO">哥伦比亚</option>
                        <option title="科摩罗" value="KM">科摩罗</option>
                        <option title="库克群岛" value="CK">库克群岛</option>
                        <option title="哥斯达黎加" value="CR">哥斯达黎加</option>
                        <option title="克罗地亚" value="HR">克罗地亚</option>
                        <option title="古巴" value="CU">古巴</option>
                        <option title="塞浦路斯" value="CY">塞浦路斯</option>
                        <option title="捷克" value="CZ">捷克</option>
                        <option title="刚果 金" value="CD">刚果 金</option>
                        <option title="丹麦" value="DK">丹麦</option>
                        <option title="吉布提" value="DJ">吉布提</option>
                        <option title="多米尼加" value="DM">多米尼加</option>
                        <option title="多米尼加共和国" value="DO">多米尼加共和国</option>
                        <option title="东帝汶" value="TL">东帝汶</option>
                        <option title="厄瓜多尔" value="EC">厄瓜多尔</option>
                        <option title="埃及" value="EG">埃及</option>
                        <option title="萨尔瓦多" value="SV">萨尔瓦多</option>
                        <option title="赤道几内亚" value="GQ">赤道几内亚</option>
                        <option title="厄立特里亚" value="ER">厄立特里亚</option>
                        <option title="爱沙尼亚" value="EE">爱沙尼亚</option>
                        <option title="埃塞俄比亚" value="ET">埃塞俄比亚</option>
                        <option title="法罗群岛" value="FO">法罗群岛</option>
                        <option title="福克兰群岛" value="FK">福克兰群岛</option>
                        <option title="斐济" value="FJ">斐济</option>
                        <option title="芬兰" value="FI">芬兰</option>
                        <option title="法国" value="FR">法国</option>
                        <option title="法属圭亚那" value="GF">法属圭亚那</option>
                        <option title="法属波利尼西亚" value="PF">法属波利尼西亚</option>
                        <option title="加蓬" value="GA">加蓬</option>
                        <option title="冈比亚" value="GM">冈比亚</option>
                        <option title="格鲁吉亚" value="GE">格鲁吉亚</option>
                        <option title="德国" value="DE">德国</option>
                        <option title="加纳" value="GH">加纳</option>
                        <option title="直布罗陀" value="GI">直布罗陀</option>
                        <option title="希腊" value="GR">希腊</option>
                        <option title="格陵兰" value="GL">格陵兰</option>
                        <option title="格林纳达" value="GD">格林纳达</option>
                        <option title="瓜德罗普岛" value="GP">瓜德罗普岛</option>
                        <option title="关岛" value="GU">关岛</option>
                        <option title="危地马拉" value="GT">危地马拉</option>
                        <option title="几内亚" value="GN">几内亚</option>
                        <option title="几内亚比绍共和国" value="GW">几内亚比绍共和国</option>
                        <option title="圭亚那" value="GY">圭亚那</option>
                        <option title="海地" value="HT">海地</option>
                        <option title="洪都拉斯" value="HN">洪都拉斯</option>
                        <option title="香港" value="HK">香港</option>
                        <option title="匈牙利" value="HU">匈牙利</option>
                        <option title="冰岛" value="IS">冰岛</option>
                        <option title="印度" value="IN">印度</option>
                        <option title="印尼" value="ID">印尼</option>
                        <option title="伊朗" value="IR">伊朗</option>
                        <option title="伊拉克" value="IQ">伊拉克</option>
                        <option title="爱尔兰" value="IE">爱尔兰</option>
                        <option title="以色列" value="IL">以色列</option>
                        <option title="意大利" value="IT">意大利</option>
                        <option title="科特迪瓦" value="CI">科特迪瓦</option>
                        <option title="牙买加" value="JM">牙买加</option>
                        <option title="日本" value="JP">日本</option>
                        <option title="约旦" value="JO">约旦</option>
                        <option title="哈萨克" value="KZ">哈萨克</option>
                        <option title="肯尼亚" value="KE">肯尼亚</option>
                        <option title="吉尔吉斯斯坦" value="KG">吉尔吉斯斯坦</option>
                        <option title="基里巴斯" value="KI">基里巴斯</option>
                        <option title="科威特" value="KW">科威特</option>
                        <option title="老挝国" value="LA">老挝国</option>
                        <option title="拉脱维亚" value="LV">拉脱维亚</option>
                        <option title="黎巴嫩" value="LB">黎巴嫩</option>
                        <option title="莱索托" value="LS">莱索托</option>
                        <option title="利比里亚" value="LR">利比里亚</option>
                        <option title="利比亚" value="LY">利比亚</option>
                        <option title="列支敦士登" value="LI">列支敦士登</option>
                        <option title="立陶宛" value="LT">立陶宛</option>
                        <option title="卢森堡" value="LU">卢森堡</option>
                        <option title="澳门" value="MO">澳门</option>
                        <option title="马其顿" value="MK">马其顿</option>
                        <option title="马达加斯加岛" value="MG">马达加斯加岛</option>
                        <option title="马拉维" value="MW">马拉维</option>
                        <option title="马来西亚" value="MY">马来西亚</option>
                        <option title="马尔代夫" value="MV">马尔代夫</option>
                        <option title="马里" value="ML">马里</option>
                        <option title="马耳他" value="MT">马耳他</option>
                        <option title="马绍尔群岛" value="MH">马绍尔群岛</option>
                        <option title="马提尼克" value="MQ">马提尼克</option>
                        <option title="毛利塔尼亚" value="MR">毛利塔尼亚</option>
                        <option title="毛里求斯" value="MU">毛里求斯</option>
                        <option title="墨西哥" value="MX">墨西哥</option>
                        <option title="密克罗尼西亚" value="FM">密克罗尼西亚</option>
                        <option title="摩尔多瓦" value="MD">摩尔多瓦</option>
                        <option title="摩纳哥" value="MC">摩纳哥</option>
                        <option title="蒙古" value="MN">蒙古</option>
                        <option title="黑山" value="ME">黑山</option>
                        <option title="蒙特塞拉特岛" value="MS">蒙特塞拉特岛</option>
                        <option title="摩洛哥" value="MA">摩洛哥</option>
                        <option title="莫桑比克" value="MZ">莫桑比克</option>
                        <option title="缅甸" value="MM">缅甸</option>
                        <option title="纳米比亚" value="NA">纳米比亚</option>
                        <option title="瑙鲁" value="NR">瑙鲁</option>
                        <option title="尼泊尔" value="NP">尼泊尔</option>
                        <option title="荷属安的列斯群岛" value="AN">荷属安的列斯群岛</option>
                        <option title="荷兰" value="NL">荷兰</option>
                        <option title="新喀里多尼亚" value="NC">新喀里多尼亚</option>
                        <option title="新西兰" value="NZ">新西兰</option>
                        <option title="尼加拉瓜" value="NI">尼加拉瓜</option>
                        <option title="尼日尔" value="NE">尼日尔</option>
                        <option title="尼日利亚" value="NG">尼日利亚</option>
                        <option title="纽埃" value="NU">纽埃</option>
                        <option title="诺福克" value="NF">诺福克</option>
                        <option title="北马里亚纳群岛" value="MP">北马里亚纳群岛</option>
                        <option title="挪威" value="NO">挪威</option>
                        <option title="阿曼" value="OM">阿曼</option>
                        <option title="巴基斯坦" value="PK">巴基斯坦</option>
                        <option title="帕劳群岛" value="PW">帕劳群岛</option>
                        <option title="巴拿马" value="PA">巴拿马</option>
                        <option title="巴布亚新几内亚" value="PG">巴布亚新几内亚</option>
                        <option title="巴拉圭" value="PY">巴拉圭</option>
                        <option title="秘鲁" value="PE">秘鲁</option>
                        <option title="菲律宾共和国" value="PH">菲律宾共和国</option>
                        <option title="波兰" value="PL">波兰</option>
                        <option title="葡萄牙" value="PT">葡萄牙</option>
                        <option title="波多黎各" value="PR">波多黎各</option>
                        <option title="卡塔尔" value="QA">卡塔尔</option>
                        <option title="留尼汪岛" value="RE">留尼汪岛</option>
                        <option title="罗马尼亚" value="RO">罗马尼亚</option>
                        <option title="俄罗斯" value="RU">俄罗斯</option>
                        <option title="卢旺达" value="RW">卢旺达</option>
                        <option title="圣基茨和尼维斯" value="KN">圣基茨和尼维斯</option>
                        <option title="圣卢西亚" value="LC">圣卢西亚</option>
                        <option title="圣文森特和格林纳丁斯" value="VC">圣文森特和格林纳丁斯</option>
                        <option title="萨摩亚" value="WS">萨摩亚</option>
                        <option title="圣马力诺" value="SM">圣马力诺</option>
                        <option title="圣多美和普林西比" value="ST">圣多美和普林西比</option>
                        <option title="沙特阿拉伯" value="SA">沙特阿拉伯</option>
                        <option title="塞内加尔" value="SN">塞内加尔</option>
                        <option title="塞尔维亚共和国" value="RS">塞尔维亚共和国</option>
                        <option title="塞舌尔" value="SC">塞舌尔</option>
                        <option title="塞拉利昂" value="SL">塞拉利昂</option>
                        <option title="新加坡" value="SG">新加坡</option>
                        <option title="斯洛伐克" value="SK">斯洛伐克</option>
                        <option title="斯洛文尼亚" value="SI">斯洛文尼亚</option>
                        <option title="所罗门" value="SB">所罗门</option>
                        <option title="索马里" value="SO">索马里</option>
                        <option title="南非" value="ZA">南非</option>
                        <option title="韩国" value="KR">韩国</option>
                        <option title="西班牙" value="ES">西班牙</option>
                        <option title="斯里兰卡" value="LK">斯里兰卡</option>
                        <option title="苏丹" value="SD">苏丹</option>
                        <option title="苏里南" value="SR">苏里南</option>
                        <option title="斯威士兰" value="SZ">斯威士兰</option>
                        <option title="瑞典" value="SE">瑞典</option>
                        <option title="瑞士" value="CH">瑞士</option>
                        <option title="叙利亚共和国" value="SY">叙利亚共和国</option>
                        <option title="台湾" value="TW">台湾</option>
                        <option title="塔吉克斯坦" value="TJ">塔吉克斯坦</option>
                        <option title="坦桑尼亚" value="TZ">坦桑尼亚</option>
                        <option title="泰国" value="TH">泰国</option>
                        <option title="刚果 布" value="CG">刚果 布</option>
                        <option title="多哥" value="TG">多哥</option>
                        <option title="汤加" value="TO">汤加</option>
                        <option title="特立尼达和多巴哥" value="TT">特立尼达和多巴哥</option>
                        <option title="突尼斯" value="TN">突尼斯</option>
                        <option title="土耳其" value="TR">土耳其</option>
                        <option title="土库曼斯坦" value="TM">土库曼斯坦</option>
                        <option title="特克斯和凯科斯群岛" value="TC">特克斯和凯科斯群岛</option>
                        <option title="图瓦卢" value="TV">图瓦卢</option>
                        <option title="美属维尔京群岛" value="VI">美属维尔京群岛</option>
                        <option title="乌干达" value="UG">乌干达</option>
                        <option title="乌克兰" value="UA">乌克兰</option>
                        <option title="阿拉伯联合酋长国" value="AE">阿拉伯联合酋长国</option>
                        <option title="英国" value="UK">英国</option>
                        <option title="美国" value="US">美国</option>
                        <option title="乌拉圭" value="UY">乌拉圭</option>
                        <option title="乌兹别克斯坦" value="UZ">乌兹别克斯坦</option>
                        <option title="瓦努阿图" value="VU">瓦努阿图</option>
                        <option title="梵蒂冈" value="VA">梵蒂冈</option>
                        <option title="委内瑞拉" value="VE">委内瑞拉</option>
                        <option title="越南" value="VN">越南</option>
                        <option title="瓦利斯群岛" value="WF">瓦利斯群岛</option>
                        <option title="也门" value="YE">也门</option>
                        <option title="赞比亚" value="ZM">赞比亚</option>
                        <option title="津巴布韦" value="ZW">津巴布韦</option>
                      </select>
                    </p>
                  </div>
                </div>
                <div class="mainlayout clearfix"> <span class="ml-title">备货数量：</span>
                  <div class="amcontext clearfix">
                    <p>
                      <input class="am-text addwid60 marginright10 j-stock-num" type="text">
                      <span style="display: none;" class="amerror j-error-stock-num"></span> </p>
                  </div>
                </div>
                <div class="mainlayout clearfix"> <span class="ml-title">备货期：</span>
                  <div class="amcontext clearfix">
                    <p>
                      <input class="am-text addwid60 marginright10 j-period" type="text">
                      <span>天</span> <span style="display: none;" class="amerror j-error-period"></span> </p>
                  </div>
                </div>
              </div>
              <div class="ambtncenter clearfix"> <span class="yellowBtn j-btn-confirm">
                <input value="确 定" type="button">
                </span> <span class="tourBtn j-btn-cancel">
                <input value="取 消" type="button">
                </span> </div>
            </div>
          </div>
          <!-- 弹层操作 结束 -->
          <script src="http://www.dhresource.com/dhs/mos/js/productgroup/dialog.js?version=2014-10-13"></script>
          <script src="http://www.dhresource.com/dhs/mos/js/productgroup/prodmanage.js?version=2014-10-13"></script>
          <script type="text/javascript" src="http://www.dhresource.com/2008/web20/seller/js/syi/matrix/json2.min.js?version=2014-10-13"></script>
          <script type="text/javascript" src="http://js.dhresource.com/seller/stock/main.js?version=2014-10-13"></script>
          <script src="http://js.dhresource.com/seller/searchfilter/filter.js?version=2014-10-13"></script>
          <script type="text/javascript">
	$('#productName').searchFilter({
      	keyword: ['<', '>',' ', '&nbsp;']
	})
</script>
        </div>
      </div>
    </div>
    
   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 

  </div>
</div>
