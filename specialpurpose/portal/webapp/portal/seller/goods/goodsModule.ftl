<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20111215.css">
<link rel="stylesheet" href="../seller/css/jquery-calendar.css">
<link rel="stylesheet" type="text/css" href="../seller/css/my-products.css">
<link rel="stylesheet" type="text/css" href="../seller/css/syi_pop.css">
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css">
<link rel="stylesheet" type="text/css" href="../seller/css/product.css">
<!-- 代码 开始 -->
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a
				href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span><a
				href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品管理</a><span>&gt;</span>关联产品模板 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <div class="j-template-list">
            <div class="col-boxpd col-linebom">
              <h2>关联产品模板</h2>
            </div>
            <div class="col-sailtips clearfix"> <span class="leftcol-tip">温馨提示：</span>
              <div class="rightcol-tip">
                <p id="hideTipsBox" class="addheight j-fold-content"> 关联产品模板是一种新的管理产品信息的方式，您可以将特定的产品（例如新品、参加促销活动的产品）创建成一个模板，并在编辑产品信息时引用。如果您修改了关联产品模板，所有引用这个模板的产品的信息全部会自动更新，实现一步操作，全网同步的目的。同时方便卖家进行其他产品宣传，提高交易效率，提升订单转化率！<br>
                  您可以<a class="under-line"
											href="http://seller.dhgate.com/help/seller-help/c0303/a85801.html"
											target="_blank">点击这里</a>了解关联产品模板的使用技巧。 </p>
                <span id="viewTips" class="viewticps viewshow j-folder">展开</span> </div>
            </div>
            <div class="public-lr-box clearfix">
              <form id="relModelFrom" method="post"
									action="/prodmanage/relModel/relModel.do?dhpath=10001,21001,0220">
                <input id="orderType" name="orderType" value="" type="hidden">
                <input id="modelName" name="modelName" value="" type="hidden">
                <input id="relModelId" name="relModelId" value="" type="hidden">
                <div class="public-r-box"> <span>
                  <input id="modelNameInput"
											class="public-txt-input color999 marginright10 j-title"
											value="" type="text">
                  </span> <span class="tourBtn">
                  <input onclick="queryRelModel();" value="搜 索" type="button">
                  </span> </div>
              </form>
              <div class="public-l-box"> <span class="bigyellow-button marginright10">
                <input
										class="j-add-template" value="添 加" type="button">
                </span> <span class="bigunclick-button marginright10">
                <input
										disabled="disabled" value="删 除" type="button">
                </span> <span>您已经添加 <b class="colorf50 j-cur-no">0</b> 个模板
                还可以添加 <b class="colorf50 j-left-no">99</b> 个</span> </div>
            </div>
            <!-- 列表 开始 -->
            <div class="bg-list">
              <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                <tbody>
                  <tr>
                    <th
												style="margin: 0px; padding: 0px; border: currentColor; width: 788px; height: 29px; position: relative; z-index: 100;"
												colSpan="6"><div>
                        <table style="border: currentColor;">
                          <tbody>
                            <tr class="j-sticky">
                              <th class="padleft20"><input class="j-check-all"
																	type="checkbox">
                              </th>
                              <th class="align-left padleft10" width="28%">模板名称</th>
                              <th width="16%">模板ID</th>
                              <th width="17%">使用此模板的产品</th>
                              <th class="cursor cursorasc" width="16%"><span
																	onclick="queryByDate();">最后更新时间</span> </th>
                              <th class="last" width="20%">操作</th>
                            </tr>
                          </tbody>
                        </table>
                      </div></th>
                  </tr>
                  <tr>
                    <td class="tipmktd" colSpan="6"><div class="tipmkbox"> <span class="icon-bighighlight-warning marginright10"></span>您目前还没有关联产品模板，快<a
														class="lkundeline"
														href="/prodmanage/relModel/createRelModel.do?dhpath=10001,21001,0220">添加</a>一个吧。 </div></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <!-- 列表 结束 -->
          </div>
          <!-- 添加产品 开始 -->
          <div style="width: 780px; display: none;" class="j-dialog-product">
            <div class="poppad01">
              <div class="dsbbtitle2 clearfix j-search-container"> <span>产品名称：</span>
                <input
										class="ssif-text-input width100 marginright10  j-prod-name"
										value="" type="text">
                <span>产品组：</span>
                <select
										class="width100 marginright10 j-select-root">
                  <option value="">所有</option>
                </select>
                <select style="display: none;"
										class="width100 marginright10 j-select-sub">
                  <option>所有</option>
                </select>
                <input class="j-select-hidden" type="hidden">
                <span>到期时间：</span>
                <select
										class="width100 marginright10 j-end-time">
                  <option value="">所有</option>
                  <option value="3">3天内过期</option>
                  <option value="5">5天内过期</option>
                  <option value="7">7天内过期</option>
                </select>
                <span class="yellowBtn valmiddle">
                <input
										class="j-search-confirm" value="搜 索" type="button">
                </span> <span class="tourBtn valmiddle">
                <input
										class="j-search-reset" value="重置" type="button">
                </span> </div>
              <!-- 列表 开始 -->
              <div class="bg-list rew-bg moreoptioin">
                <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                  <tbody>
                    <tr>
                      <th width="50%">产品信息</th>
                      <th width="20%">产品组</th>
                      <th width="15%">价格</th>
                      <th width="15%">有效期</th>
                    </tr>
                    <tr class="btngroup">
                      <td colSpan="4"><input class="marginright10 j-chk-all"
													name="checkAllProducts" value="" type="checkbox">
                        <span
													class="marginright10">全选</span> <span class="tourBtn">
                        <input
														class="j-del-temp" value="在模板中删除此产品信息" type="button">
                        </span></td>
                    </tr>
                  </tbody>
                </table>
              </div>
              <div class="bg-list rew-hg">
                <table class="j-prod-list" border="0" cellSpacing="0"
										cellPadding="0" width="100%">
                </table>
              </div>
              <!-- 列表 结束 -->
              <!--分页 开始-->
              <div class="commonpage j-prod-pager"></div>
              <!--分页 结束-->
            </div>
            <div class="box1">
              <div class="align-center clearfix"> <span class="biggrey-button">
                <input class="j-btn-close"
										value="关 闭" type="button">
                </span> </div>
            </div>
          </div>
          <!-- 添加产品 结束 -->
          <!-- 关联产品引导 开始 -->
          <div style="display: none;" id="newGuideStep1"
							class="new-guide-step1 png_bg j-dialog-relatedproduct-guide">
            <div class="txtcontent"> 关联产品模板功能上线了！<br>
              您可以为产品信息中的公共信息单独创建一个<br>
              模板，并在产品中引用！<a
									href="http://seller.dhgate.com/help/seller-help/c0303/a85801.html"
									target="_blank">点这里</a>了解详细。 </div>
            <div class="txtconval"> <span class="guide-i-know j-know" conduct="iknow">我知道了~</span> </div>
            <div class="guide-arrow1 png_bg"></div>
            <a class="guide-close-button png_bg j-closer" href="javascript:;"
								conduct="iknow"></a>
            <div class="guide-pos1"></div>
          </div>
          <!-- 关联产品引导 结束 -->
          <script>
							//搜索
							function queryRelModel() {
								var modelName = $('#modelNameInput').val();
								if (modelName != "模板名称") {
									$('#modelName').val(modelName);
								} else {
									$('#modelName').val('');
								}
								$('#relModelFrom').submit();
							}
							//按照日期排序
							function queryByDate() {
								var orderType = $('#orderType').val();
								if (orderType == "0") {
									$('#orderType').val("1");
								} else {
									$('#orderType').val("0");
								}
								$('#relModelFrom').submit();
							}
							//修改
							function edit(relModelId) {
								$('#relModelId').val(relModelId);
								$('#relModelFrom')
										.attr('action',
												'/prodmanage/relModel/createRelModel.do?dhpath=10001,21001,0220');
								$('#relModelFrom').submit();
							}
						</script>
          <script
							src="http://js.dhresource.com/seller/relatedproduct/list.js?version=2014-04-28"></script>
        </div>
      </div>
    </div>
   

   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 
  </div>
</div>
<!-- 代码 结束 -->
