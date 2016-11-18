<link rel="stylesheet" type="text/css" href="../seller/css/syi20130506.css?t=20141013">
<style type="text/css" media="screen">
</style>
<style type="text/css">
#div_imgcontainer div {
	cursor: pointer;
}
</style>
<link rel="stylesheet" type="text/css"
	href="../seller/css/ueditor.css">
<!-- 代码 开始 -->
<div id="header">
  <div style="display: none;" id="viewReturn"> <span id="seeNewUserWizard" class="seenewusergu"><span>查看新版向导</span> </span> <a id="changeSyiVsersion" class="returnoldsyi" href="javascript:;;"><span>返回旧版</span> </a> </div>
  <div id="toplist"></div>
</div>
<div class="postmargin"> <a id="syiTop" name="syiTop"></a>
  <!-- 步骤提示 开始 -->
  <div class="leavecategory">
    <div class="leave-cat-lv leave02"> 
    	<span class="first">1. 选择类目</span>
    	<span class="middle current">2. 填写信息</span>
    	<span class="last">3. 提交审核</span> 
    </div>
    <h1>上传产品 &nbsp;&nbsp;&nbsp;&nbsp;</h1>
  </div>
  <!-- 步骤提示 开始 -->
  <!-- 已选择类目 开始 -->
  <div class="categorydicbox">
    <div class="layer-b-bg"> <span class="layer-l"></span> <span class="layer-r"></span>
      <div class="cat-titleconbox"> <b>${uiLabelMap.CurrentSelCategory}</b>
	      <span class="navbox">${requestParameters.productCategoryId0}
	      	<#if requestParameters.productCategoryId1?has_content>
	      		<span class="nav">&gt;</span>${requestParameters.productCategoryId1}
	      	</#if>
	      	<#if requestParameters.productCategoryId2?has_content>
	      		<span class="nav">&gt;</span>${requestParameters.productCategoryId2}
	      	</#if>
	      	<#if requestParameters.productCategoryId3?has_content>
	      		<span class="nav">&gt;</span>${requestParameters.productCategoryId3}
	      	</#if>
	      </span> 
	      <a class="marginleft20" href="<@ofbizUrl>addNewGoods</@ofbizUrl>">«返回修改类目</a> 
      </div>
    </div>
  </div>
  <!-- 已选择类目 结束 -->
  <!-- 错误信息 开始 -->
  <div style="display: none;" id="errorMsgDiv"
				class="syi-all-error clearfix">
    <div class="syi-all-error-lt"></div>
    <div class="syi-all-error-ri">
      <p class="p1"> <b>您还有下述表单项填写不正确，请点击相应链接进行修改。</b> </p>
      <ul id="errorUL">
      </ul>
    </div>
  </div>
  <!-- 错误信息 结束 -->
  <#assign actionUrlStr="createProduct">
  <#if product?has_content>
  <#assign actionUrlStr="updateProduct">
  </#if>
  <form id="syi_form" encType="multipart/form-data" method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>"
				name="SYIForm" target="_blank">
    <input type="hidden" name="primaryProductStoreId" id="primaryProductStoreId"  value="${(product.primaryProductStoreId)!productStoreId!}">
    <input type="hidden" name="productTypeId" id="productTypeId"  value="${(product.productTypeId)!'FINISHED_GOOD'}">
    <!-- title产品基本信息 开始 -->
    <div class="titlebox">
      <h3>1、产品基本信息</h3>
    </div>
    <!-- title产品基本信息 结束 -->
    <!-- 产品标题 开始 -->
    <div id="productnameTip" class="mainlayout clearfix">
      <div class="ml-title"> <span class="required">*</span>产品标题： </div>
      <a id="a_productname"></a>
      <div>
        <input style="ime-mode: disabled;" id="internalName"
							class="attr-text-input addwid402" name="internalName"
							maxLength="140" value="${(product.internalName)!(requestParameters.internalName)!}" type="text">
        <span
							id="productnameTip" class="helptips marginleft10">您还可以输入<b
							id="productNameLengthSpan" class="color444">140</b><span
							class="color000">/<span>140</span> </span>个字符</span> <span
							class="helpicon" title="产品标题帮助" helptipval="productnameTip"></span> </div>
      <div style="display: none;" id="productnameErrTip"
						class="tip-error"></div>
    </div>
    <!-- 产品标题 结束 -->
    <!-- 产品关键词 开始 -->
    <div id="keywordTip" class="mainlayout clearfix">
      <div class="ml-title">产品关键词：</div>
      <a id="a_keyword1"></a><a id="a_keyword2"></a><a id="a_keyword3"></a>
      <div>
        <input style="ime-mode: disabled;" id="keyword1"
							class="attr-text-input marginright10" name="keyword1"
							maxLength="40" value="" type="text">
        <input
							style="display: none; ime-mode: disabled;" id="keyword2"
							class="attr-text-input marginright10" name="keyword2"
							maxLength="40" type="text">
        <input
							style="display: none; ime-mode: disabled;" id="keyword3"
							class="attr-text-input marginright10" name="keyword3"
							maxLength="40" type="text">
        <span id="keywordbutton"
							class="tourBtn">
        <input onclick="showOtherKeywords();"
							value="添加多个关键词" type="button">
        </span> <span class="helpicon"
							title="产品关键词帮助" helptipval="keywordTip"></span> </div>
      <div style="display: none;" id="keyword1ErrTip" class="tip-error"></div>
      <div style="display: none;" id="keyword2ErrTip" class="tip-error"></div>
      <div style="display: none;" id="keyword3ErrTip" class="tip-error"></div>
    </div>
    <!-- 产品关键词 结束 -->
    <!-- 产品基本属性 开始 -->
    <!-- 产品基本属性 开始 -->
    <div id="product_cattr_container"
					class="j-basic-attr-container clearfix">
      <div class="mainlayout clearfix">
        <div class="ml-title"> <span class="required">*</span>产品基本属性：<a id="a_productattr"></a> </div>
        <p class="helptips"> 设置完整的产品属性有助于买家更容易找到您的产品<span class="helpicon"
								helptipval="product_cattr_container"></span> </p>
        <div class="product-attributes">
          <table class="table-property j-attrs-list">
            <tbody>
              <tr class="j-attr-item" data-id="99" data-style="3"
										data-defined="0" data-isother="1">
                <td class="bktit" title="品牌">品牌：</td>
                <td class="bkcon j-attrList" data-aid="99"><div
												class="posionrel clearfix">
                    <div id="selectBrandsDiv" class="drop-down"
													onclick="onSelectBrandsClick();"> <span id="brandNameSpan"
														class="drop-down-value text-indent">- 无品牌 -</span> <span
														class="drop-down-default"></span>
                      <div style="display: none;" id="brandsDiv"
														class="chouse-down-box text-indent"> <span>- 无品牌 -</span><span class="lasted"><a
															onclick="onClickSelectBrandBtn();" href="#">选择其它品牌</a> </span> </div>
                      <iframe></iframe>
                    </div>
                  </div></td>
              </tr>
              <tr class="j-attr-item" data-id="700568" data-style="1"
										data-defined="0" data-isother="1">
                <td class="bktit" title="原型机"><span class="required">*</span>原型机：</td>
                <td class="bkcon j-attrList" data-aid="700568"><select
											class="attr-select j-attr-select" name="c_700568_vname">
                    <option
													value="" data-etext="" data-text="请选择">请选择</option>
                    <option value="987248" data-etext="Nokia Cell Phones"
													data-text="诺基亚手机">诺基亚手机</option>
                    <option value="987255" data-etext="Motorola Cell Phones"
													data-text="摩托罗拉手机">摩托罗拉手机</option>
                    <option value="987253" data-etext="Samsung Cell Phones"
													data-text="三星手机">三星手机</option>
                    <option value="987258"
													data-etext="Apple iPhones Cell Phones" data-text="苹果手机">苹果手机</option>
                    <option value="987259"
													data-etext="Sony-Ericsson Cell Phones" data-text="索尼-爱立信手机">索尼-爱立信手机</option>
                    <option value="987254" data-etext="Toshiba Cell Phones"
													data-text="东芝手机">东芝手机</option>
                    <option value="987239" data-etext="LG Cell Phones"
													data-text="LG手机">LG手机</option>
                    <option value="987242" data-etext="HTC Cell Phones"
													data-text="HTC手机">HTC手机</option>
                    <option value="987257" data-etext="Blackberry Cell Phones"
													data-text="黑莓">黑莓</option>
                    <option value="987245" data-etext="Palm Cell Phones"
													data-text="Palm">Palm</option>
                    <option value="987260"
													data-etext="Google Android Cell Phones"
													data-text="Google手机">Google手机</option>
                    <option value="987250" data-etext="Lenovo Cell Phones"
													data-text="联想手机">联想手机</option>
                    <option value="987252" data-etext="Philips Cell Phones"
													data-text="飞利浦手机">飞利浦手机</option>
                    <option value="987240" data-etext="NEC Cell Phone"
													data-text="NEC手机">NEC手机</option>
                    <option value="987256" data-etext="Panasonic Cell Phone"
													data-text="松下手机">松下手机</option>
                    <option value="987251" data-etext="Siemens Cell Phone"
													data-text="西门子手机">西门子手机</option>
                    <option value="987246" data-etext="Alctel Cell Phone"
													data-text="阿尔卡特手机">阿尔卡特手机</option>
                    <option value="987244" data-etext="Meizu Cell Phone"
													data-text="魅族手机">魅族手机</option>
                    <option value="987243" data-etext="Oppo Cell Phone"
													data-text="Oppo手机">Oppo手机</option>
                    <option value="987247" data-etext="Huawei Cell Phone"
													data-text="华为手机">华为手机</option>
                    <option value="987241" data-etext="ZTE Cell Phone"
													data-text="中兴手机">中兴手机</option>
                    <option value="987249" data-etext="Sharp Cell Phones"
													data-text="夏普手机">夏普手机</option>
                    <option value="0" data-etext="" data-text="自定义">自定义</option>
                  </select>
                  <table style="display: none;"
												class="edit-properties j-attr-define">
                    <tbody class="j-attr-define-list">
                      <tr>
                        <th>默认参数</th>
                        <th>自定义内容</th>
                      </tr>
                    </tbody>
                  </table>
                  <div style="display: none;" id="tip-error-attr-700568"
												class="tip-error j-tip-error"> <span></span> </div></td>
              </tr>
              <tr>
                <td class="bktit">自定义属性：</td>
                <td class="bkcon j-custom-attr-list"><div class="j-custom-attr-item">
                    <p class="marginbottom5 clearfix">
                      <input class="attr-text-input custom1 j-custom-attr-name"
														type="text">
                      <input
														class="attr-text-input custom1 j-custom-attr-value"
														type="text">
                      <a class="custom1 j-custom-attr-add"
														href="javascript:;">添加更多</a> </p>
                    <div style="display: none;"
													class="tip-error j-custom-attr-tip-error"> <span></span> </div>
                  </div></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <div style="display: none;" id="display_div_brand">
      <div style="display: none;" id="div_brand_id"
						class="syi-properties-ri syi-rposition">
        <div class="posionrel clearfix">
          <div id="selectBrandsDiv" class="drop-down"
								onclick="onSelectBrandsClick();"> <span id="brandNameSpan" class="drop-down-value text-indent">-
            无品牌 -</span> <span class="drop-down-default"></span>
            <div style="display: none;" id="brandsDiv"
									class="chouse-down-box text-indent"></div>
            <iframe></iframe>
          </div>
        </div>
      </div>
      <input id="brandid" name="brandid" value="99" type="hidden">
      <input id="brandName" name="brandName" value="" type="hidden">
    </div>
    <!-- 产品基本属性 结束 -->
    <!-- 产品规格 开始 -->
    <div class="mainlayout j-basic-standard-container clearfix">
      <div class="ml-title">产品规格：</div>
      <p class="helptips">产品的不同规格，可以设置不同的零售价，并在前台展示给买家</p>
      <!-- ----- 产品基本属性结束 -----  -->
      <div id="j-attribute-list" class="product-attributes2">
        <div>
          <table class="table-property j-buy-attrs-list">
          </table>
        </div>
        <div>
          <table class="table-property j-sale-attrs-list">
          </table>
        </div>
        <div id="div_self_defind_attr" class="j-list-item">
          <table class="table-property">
            <tbody>
              <tr>
                <td class="bktit addborderline">自定义规格</td>
                <td class="bkcon addborderline"></td>
              </tr>
              <tr>
                <td class="bktit"></td>
                <td class="bkcon addpadtop j-attrList" data-aid="9999"><table style="display: none;"
												class="edit-properties j-cattr-box">
                    <thead>
                      <tr>
                        <th>自定义规格名称</th>
                        <th>自定义图片（JPG格式，≤200K，可不添加）</th>
                        <th></th>
                      </tr>
                    </thead>
                    <tbody class="j-customAttr-box">
                    </tbody>
                  </table>
                  <p class="marginbottom5 clearfix"> <a class="addmoreprop j-addCustomAttr" href="#"><span></span>增加自定义规格</a> </p></td>
              </tr>
            </tbody>
          </table>
          <div style="display: none;" id="msgdiv_9999" class="tip-error"
								data-name="自定义规格" data-id="tips-saletype"
								data-anchor="div_self_defind_attr">您选取的图片中有大于200K的图片</div>
        </div>
      </div>
    </div>
    <!-- 产品规格 结束 -->
    <!-- 属性图片上传入口参数   -->
    <input id="functionname_avim" name="functionname_avim" value="avim"
					type="hidden">
    <!--功能名   	不可以为空-->
    <input id="imagebannername_avim" name="imagebannername_avim"
					value="" type="hidden">
    <!--水印名  现在是用户名-->
    <!-- 产品基本属性 结束 -->
    <!-- 产品购买属性 开始 -->
    <!-- 产品购买属性 结束 -->
    <!-- title产品销售信息开始 -->
    <!-- title产品包装信息 开始 -->
    <div id="a_productprice" class="titlebox">
      <h3>2、产品销售信息</h3>
    </div>
    ﻿
    <input name="noSpecWholeSaleIncome" value="" type="hidden">
    <input id="catePubDiscount" value="" type="hidden">
    <input
					id="cateMinPrice" name="cateMinPrice" value="0.01" type="hidden">
    <input id="noSpecPrice" name="noSpecPrice" type="hidden">
    <!-- title产品包装信息 结束 -->
    <a id="tips-sale-foot"></a>
    <div id="j-saleBox">
      <!-- 销售计量单位 开始 -->
      <div class="mainlayout clearfix j-list-item j-help"
						data-helpid="saleUnit">
        <div class="ml-title"> <span class="required">*</span>销售计量单位： </div>
        <a id="a_measureid"></a>
        <select class="attr-select j-select-unit"
							name="measureid">
          <option disabled="disabled" value="">-- 请选择销售单位 --</option>
          <option value="00000000000000000000000000000001" data-name="打">打(Dozen)</option>
          <option value="00000000000000000000000000000002" data-name="英尺">英尺(Feet)</option>
          <option selected="" value="00000000000000000000000000000003"
								data-name="件">件(Piece)</option>
          <option value="00000000000000000000000000000004" data-name="套">套(Set)</option>
          <option value="00000000000000000000000000000005" data-name="克">克(Gram)</option>
          <option value="00000000000000000000000000000008" data-name="英寸">英寸(Inch)</option>
          <option value="00000000000000000000000000000009" data-name="千克">千克(Kilogram)</option>
          <option value="00000000000000000000000000000010" data-name="千米">千米(Kilometre)</option>
          <option value="00000000000000000000000000000011" data-name="升">升(Liter)</option>
          <option value="00000000000000000000000000000012" data-name="吨">吨(Metric
          Tonne)</option>
          <option value="00000000000000000000000000000013" data-name="米">米(Meter)</option>
          <option value="00000000000000000000000000000015" data-name="毫升">毫升(Milliliter)</option>
          <option value="00000000000000000000000000000016" data-name="盎司">盎司(Ounce)</option>
          <option value="00000000000000000000000000000017" data-name="双">双(Pair)</option>
          <option value="00000000000000000000000000000018" data-name="磅">磅(Pound)</option>
          <option value="00000000000000000000000000000022" data-name="平方码">平方码(Square
          Yard)</option>
          <option value="00000000000000000000000000000023" data-name="平方米">平方米(Square
          Meter)</option>
          <option value="00000000000000000000000000000024" data-name="平方英尺">平方英尺(Square
          Feet)</option>
          <option value="00000000000000000000000000000028" data-name="码">码(Yard)</option>
          <option value="00000000000000000000000000000029" data-name="厘米">厘米(Centimeter)</option>
          <option value="00000000000000000000000000000033" data-name="箱">箱(Carton)</option>
        </select>
        示例：12美元/<span class="j-unit-no" name="sortbyunit">件</span> <span
							class="helpicon" title="销售计量单位帮助" data-helpid="saleUnit"></span>
        <input id="measurename" value="件" type="hidden">
        <div style="display: none;" class="tip-error" data-name="销售计量单位"
							data-id="tips-unit" data-anchor="j-saleBox"></div>
      </div>
      <!-- 销售计量单位 结束 -->
      <!-- 销售方式 开始 -->
      <div class="mainlayout clearfix j-list-item j-help"
						data-helpid="saleType">
        <div class="ml-title"> <span class="required">*</span>销售方式： </div>
        <div class="marginbottom10 clearfix">
          <label>
          <input id="sortbyradio1" name="sortby" value="1"
								CHECKED="" type="radio" data-name="件">
          <span
								class="marginleft5 marginright10">
          <label for="gg">按件卖</label>
          （单位：<span
									class="j-unit-no" name="sortbyunit">件</span>）</span>
          </label>
        </div>
        <div class="marginbottom10 clearfix">
          <label>
          <input id="sortbyradio2" name="sortby" value="2"
								type="radio" data-name="包">
          <span class="marginleft5">按包卖</span> </label>
          <span> <span style="display: none;" class="j-sale-bao"> （每包产品的数量：
          <input id="packquantity" class="input2"
									name="packquantity" maxLength="8" value="1" size="6"
									type="text">
          <span class="j-unit-no" name="sortbyunit">件</span>）</span> </span> <span class="helpicon" title="销售方式帮助" data-helpid="saleType"></span> </div>
        <div style="display: none;" class="tip-error" data-name="销售方式"
							data-id="tips-packquantity" data-anchor="j-saleBox">
          <p></p>
        </div>
      </div>
      <!-- 销售方式 结束 -->
      <!-- 库存状态 开始 -->
      <div class="mainlayout clearfix j-list-item">
        <div class="ml-title"> <span class="required">*</span>备货状态： </div>
        <div class="marginbottom10 clearfix">
          <label>
          <input name="inventoryStatus" value="1" CHECKED=""
								type="radio">
          <span class="marginleft5 marginright10">有备货，备货所在地</span> </label>
          <select id="inventoryLocation" class="syi-select5"
								name="inventoryLocation">
            <option title="中国" selected="" value="CN">中国</option>
            <option title="美国" value="US">美国</option>
            <option title="香港" value="HK">香港</option>
            <option title="英国" value="UK">英国</option>
            <option title="加拿大" value="CA">加拿大</option>
            <option title="西班牙" value="ES">西班牙</option>
            <option title="德国" value="DE">德国</option>
            <option title="澳大利亚" value="AU">澳大利亚</option>
            <option title="法国" value="FR">法国</option>
            <option title="巴西" value="BR">巴西</option>
            <option title="俄罗斯" value="RU">俄罗斯</option>
            <option title="越南" value="VN">越南</option>
            <option title="智利" value="CL">智利</option>
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
            <option title="英属维尔京群岛" value="VG">英属维尔京群岛</option>
            <option title="文莱" value="BN">文莱</option>
            <option title="保加利亚" value="BG">保加利亚</option>
            <option title="布基纳法索" value="BF">布基纳法索</option>
            <option title="布隆迪" value="BI">布隆迪</option>
            <option title="柬埔寨" value="KH">柬埔寨</option>
            <option title="喀麦隆" value="CM">喀麦隆</option>
            <option title="佛得角共和国" value="CV">佛得角共和国</option>
            <option title="开曼群岛" value="KY">开曼群岛</option>
            <option title="中非共和国" value="CF">中非共和国</option>
            <option title="乍得" value="TD">乍得</option>
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
            <option title="法属圭亚那" value="GF">法属圭亚那</option>
            <option title="法属波利尼西亚" value="PF">法属波利尼西亚</option>
            <option title="加蓬" value="GA">加蓬</option>
            <option title="冈比亚" value="GM">冈比亚</option>
            <option title="格鲁吉亚" value="GE">格鲁吉亚</option>
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
            <option title="乌拉圭" value="UY">乌拉圭</option>
            <option title="乌兹别克斯坦" value="UZ">乌兹别克斯坦</option>
            <option title="瓦努阿图" value="VU">瓦努阿图</option>
            <option title="梵蒂冈" value="VA">梵蒂冈</option>
            <option title="委内瑞拉" value="VE">委内瑞拉</option>
            <option title="瓦利斯群岛" value="WF">瓦利斯群岛</option>
            <option title="也门" value="YE">也门</option>
            <option title="赞比亚" value="ZM">赞比亚</option>
            <option title="津巴布韦" value="ZW">津巴布韦</option>
          </select>
          <span class="helptips">（有现货，可立即发货，备货期不大于两天）</span> </div>
        <div class="marginbottom10 clearfix">
          <label>
          <input name="inventoryStatus" value="0"
								type="radio">
          <span class="marginleft5">待备货，客户一次最大购买数量为</span> </label>
          <span class="j-nostock-label">
          <input
								class="attr-text-input addwid60 margindoublev5 j-help"
								disabled="" name="maxSaleQty" value="10000" type="text"
								data-helpid="maxSaleQty">
          <span class="j-unit"> 件 </span><span class="helptips">（暂无现货需采购）</span> </span> <span class="helpicon"
								title="产品备货帮助" data-helpid="stockHelp"></span> </div>
        <div style="display: none;" class="tip-error" data-name="库存状态"
							data-id="tips-maxSaleQty" data-anchor="j-saleBox">
          <p></p>
        </div>
      </div>
      <!-- 库存状态 结束 -->
      <!-- 备货数量 开始 -->
      <div class="mainlayout clearfix j-list-item j-stock-input">
        <div class="ml-title"> <span class="required">*</span>备货数量： </div>
        <div class="clearfix">
          <input class="attr-text-input addwid60 j-sale-inventory"
								name="inventory" value="" type="text">
          <span
								class="marginleft5 marginright20 j-unit"> 件 </span> </div>
        <div style="display: none;" class="tip-error" data-name="库存数量"
							data-id="j-saleBox" data-anchor="j-saleBox">
          <p></p>
        </div>
      </div>
      <!-- 备货数量 结束 -->
      <!-- 备货期 开始 -->
      <div class="mainlayout clearfix j-list-item">
        <div class="ml-title"> <span class="required">*</span>备货期： </div>
        <div class="clearfix">
          <div>
            <input class="attr-text-input addwid60 marginright5 j-help"
									name="proLeadingtime" value="2" type="text"
									data-helpid="proLeading">
            天 <span
									class="helptips marginleft20 j-leadingtime-tip">有备货的产品备货期小于等于2天</span> </div>
          <div style="display: none;" class="tip-error" data-name="备货期"
								data-id="tips-leadingtime" data-anchor="tips-sale-foot">
            <p></p>
          </div>
        </div>
      </div>
      <!-- 备货期 结束 -->
      <div style="display: none;"
						class="mainlayout clearfix j-stock-box j-list-item">
        <div class="ml-title">备货总量：</div>
        <div class="clearfix">
          <div> <b class="color009b02 j-stock-totalnum">0</b><span
									class="j-unit"> 件 </span> <span class="helptips marginleft20">产品备货数量的总和</span> </div>
          <div style="display: none;" class="tip-error" data-name="库存总量"
								data-id="tips-stockNum" data-anchor="tips-sale-foot">
            <p></p>
          </div>
        </div>
      </div>
      <!-- 产品价格 开始 -->
      <div style="position: relative;" id="tips-sale"
						class="mainlayout clearfix">
        <div class="ml-title"> <span class="required">*</span>产品价格区间： </div>
        <div>
          <div class="helptips"> <span class="j-price-tipstxt"> 您可以最多添加4个价格区间 <span
									class="colorF60"> <span class="tipstion"> <span
											class="commission"></span>
            <div style="top: -40px; display: none;"
												class="tiparrow-posbox">
              <div class="tiparrow-box"></div>
            </div>
            </span> 阶梯佣金计算公式 </span> </span> <span class="helpicon" title="阶梯佣金计算公式帮助"
									data-helpid="expressions"></span> </div>
        </div>
        <div style="display: none;"
							class="marginbottom10 clearfix j-price-typeList">
          <label>
          <input name="setdiscounttype" value="2"
								CHECKED="checked" type="radio">
          <span
								class="marginleft5 ver-align-middle marginright20">统一设置价格</span> </label>
          <label>
          <input name="setdiscounttype" value="1"
								type="radio">
          <span class="marginleft5 ver-align-middle">分别设置价格</span> </label>
        </div>
        <!-- 统一设置价格区域-->
        <div class="j-list-item">
          <div class="setwhoprice setshow marginbottom10 j-sectionA-box">
            <div class="ladderprice">
              <div class="j-section-list">
                <p>
                  <input
												class="attr-text-input addwid50 margindoublev5 j-section-stock"
												value="1" type="text" data-type="unify">
                  <span
												class="marginright20"><span class="j-unit">件</span>及以上</span>实际收入：US$
                  <input
												class="attr-text-input addwid50 margindoublev5 j-section-price "
												value="" type="text">
                  <span class="marginright20">/<span
												class="j-unit">件</span> </span>买家价格： US$ <span
												class="j-section-salePrice"></span><a style="display: none;"
												class="j-section-del" href="#">删除</a> </p>
              </div>
              <p> <a class="addmoreprop j-section-add" href="#"><span></span>增加区间</a> </p>
            </div>
          </div>
          <div style="display: none;" class="tip-error" data-name="统一设置价格"
								data-id="tips-stockNum" data-anchor="tips-sale-foot">
            <p></p>
          </div>
        </div>
        <!-- sku 绘制区域-->
        <div class="j-list-item">
          <div
								class="marginbottom10 stocking-inf-box clearfix j-saleBox-table">
            <table>
              <thead>
              </thead>
              <tbody class="j-sku-body">
              </tbody>
            </table>
          </div>
          <div style="display: none;" class="tip-error" data-name="产品价格"
								data-id="tips-sale" data-anchor="tips-sale">
            <p></p>
          </div>
        </div>
        <div class="j-list-item">
          <div style="display: none;"
								class="setwhoprice setshow marginbottom10 j-sectionB-box">
            <div class="ladderprice padbottom10"> <a class="fltrig j-price-previewBtn" href="#">价格预览</a> <span
										class="required">*</span>设置产品的价格区间 </div>
            <div class="ladderprice">
              <div class="j-section-list"></div>
              <p> <a class="addmoreprop j-section-add" href="#"><span></span>添加批发区间</a> </p>
            </div>
          </div>
          <div style="display: none;" class="tip-error" data-name="分别设置价格"
								data-id="tips-stockNum" data-anchor="tips-sale-foot">
            <p></p>
          </div>
        </div>
      </div>
      <!-- 产品价格 结束 -->
      <!-- 商品编码 开始 -->
      <div class="mainlayout clearfix j-goodcode-box j-list-item">
        <div class="ml-title">商品编码：</div>
        <div class="clearfix">
          <input class="attr-text-input addwid140 j-help" name="skuCode"
								value="" type="text" data-helpid="skuCode">
          <div style="display: none;" class="tip-error" data-name="商品编码"
								data-id="tips-skucode" data-anchor="tips-sale-foot">
            <p></p>
          </div>
        </div>
      </div>
      <!-- 商品编码 结束 -->
    </div>
    <!-- title产品销售信息 结束 -->
    <!-- title产品销售信息 结束 -->
    <!-- title产品内容描述 开始 -->
    <div class="titlebox">
      <h3>3、产品内容描述</h3>
    </div>
    <!-- 产品图片 开始 -->
    <!-- 产品图片 开始 -->
    <div class="mainlayout clearfix">
      <div class="ml-title"> <span class="required">*</span>产品图片： </div>
      <a id="a_div_imgcontainer"></a>
      <p class="helptips"> 图片格式<strong>JPEG</strong>，文件大小<strong>2M</strong>以内，切勿盗用他人图片，以免受网规处罚。<span
							class="helpicon" title="产品图片帮助" data-helpid="waterMark"></span> </p>
      <p class="helptips"> 上传优质产品图片会获得更多的站内外流量。<br>
        优质产品图片定义：产品原图，即无人为修改痕迹、无水印、无修饰边框和文字。 </p>
      <div class="margintop10"> <span class="yellowBtn11">
        <input
							style="display: none; visibility: hidden;" id="fileupload"
							name="fileupload" width="72" height="23" type="button">
        <object
								style="visibility: visible;" id="fileuploadUploader"
								classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="72"
								height="23">
          <PARAM NAME="_cx" VALUE="1905">
          <PARAM NAME="_cy" VALUE="608">
          <PARAM NAME="FlashVars"
									VALUE="uploadifyID=fileupload&amp;pagepath=/syi/&amp;script=http://upload.dhgate.com/uploadfile&amp;folder=uploaddify&amp;width=72&amp;height=23&amp;wmode=transparent&amp;method=GET&amp;queueSizeLimit=8&amp;simUploadLimit=8&amp;hideButton=true&amp;fileDesc=choose *.jpg/&amp;fileExt=*.jpg;*.JPG;*.jpeg;*.JPEG;&amp;multi=true&amp;sizeLimit=2097152&amp;fileDataName=Filedata&amp;queueID=productPicQueue">
          <PARAM NAME="Movie"
									VALUE="/syi/js/photo/upload2/uploadalbums.swf?v=1414202990934">
          <PARAM NAME="Src"
									VALUE="/syi/js/photo/upload2/uploadalbums.swf?v=1414202990934">
          <PARAM NAME="WMode" VALUE="Transparent">
          <PARAM NAME="Play" VALUE="0">
          <PARAM NAME="Loop" VALUE="-1">
          <PARAM NAME="Quality" VALUE="High">
          <PARAM NAME="SAlign" VALUE="LT">
          <PARAM NAME="Menu" VALUE="-1">
          <PARAM NAME="Base" VALUE="">
          <PARAM NAME="AllowScriptAccess" VALUE="always">
          <PARAM NAME="Scale" VALUE="NoScale">
          <PARAM NAME="DeviceFont" VALUE="0">
          <PARAM NAME="EmbedMovie" VALUE="0">
          <PARAM NAME="BGColor" VALUE="">
          <PARAM NAME="SWRemote" VALUE="">
          <PARAM NAME="MovieData" VALUE="">
          <PARAM NAME="SeamlessTabbing" VALUE="1">
          <PARAM NAME="Profile" VALUE="0">
          <PARAM NAME="ProfileAddress" VALUE="">
          <PARAM NAME="ProfilePort" VALUE="0">
          <PARAM NAME="AllowNetworking" VALUE="all">
          <PARAM NAME="AllowFullScreen" VALUE="false">
          <PARAM NAME="AllowFullScreenInteractive" VALUE="false">
          <PARAM NAME="IsDependent" VALUE="0">
          <param name="quality" value="high">
          <param name="wmode" value="transparent">
          <param name="allowScriptAccess" value="always">
          <param name="flashvars"
									value="uploadifyID=fileupload&amp;pagepath=/syi/&amp;script=http://upload.dhgate.com/uploadfile&amp;folder=uploaddify&amp;width=72&amp;height=23&amp;wmode=transparent&amp;method=GET&amp;queueSizeLimit=8&amp;simUploadLimit=8&amp;hideButton=true&amp;fileDesc=choose *.jpg/&amp;fileExt=*.jpg;*.JPG;*.jpeg;*.JPEG;&amp;multi=true&amp;sizeLimit=2097152&amp;fileDataName=Filedata&amp;queueID=productPicQueue">
          <param name="movie"
									value="/syi/js/photo/upload2/uploadalbums.swf?v=1414202990934">
        </object>
        </span><span class="yellowBtn marginleft10">
        <input
							id="albumImgListButton" value="相册上传" type="button">
        </span> <span
							class="helptips"> 您还可以上传<b id="photonum_b"
							class="color444">8</b> <span class="color000">/<span>8</span> </span> 张 </span>
        <input id="inp_img_index" value="" type="hidden">
      </div>
      <!--本地上传相关开始， 暂时先隐藏掉-->
      <div id="fileQueue"></div>
      <div style="display: none;" id="div_imgcontainerErrTip"
						class="tip-error"></div>
      <input id="functionname" name="functionname" value="albu"
						type="hidden">
      <!--功能名   	不可以为空-->
      <input id="imagebannername" name="imagebannername" value=""
						type="hidden">
      <!--水印名  现在是用户名-->
      <input id="supplierid" name="supplierid"
						value="ff808081482fd3fd01485e24266e5056" type="hidden">
      <input
						id="waterMark" name="waterMark" value="" type="hidden">
      <input
						id="imgtoken" name="imgtoken"
						value="-hwBEsUCl5XyIYsFzQ8sOb0lT30Yqz4pGvoKVf0taPBNi0fS9CxnD4MNhppTzCYZm15SvLgyphrdlcDEEKsw6lhfnPsOSZOSY_8yF9PgrTU"
						type="hidden">
      <!--本地上传相关结束-->
      <div id="div_imgcontaine_init"
						class="pro-img-box margintop10 clearfix">
        <div class="pro-img-picbox addpiccolor2">
          <div class="pic"> <img
									src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m.jpg"
									width="100" height="100"> </div>
          <!--div class="pro-tit-nm">IMG_...5.JPG</div>
                <div class="pro-tit-del"><a href="#">删除</a></div-->
        </div>
        <div class="pro-img-picbox">
          <div class="pic"> <img
									src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m2.jpg"
									width="80" height="80"> </div>
          <!--div class="pro-img-upload"><span class="pro-img-upload-bar"><span style="width:40%;"></span></span></div-->
        </div>
      </div>
      <div style="display: none;" id="div_imgcontainer"
						class="pro-img-box margintop10 clearfix" data-listIdx="0">
        <input id="inp_img_index" value="" type="hidden">
        <input
							id="inp_imgbox_index" value="" type="hidden">
        <input
							id="ori_tdalbumswindowid" value="" type="hidden">
      </div>
      <div style="display: none;" id="j-waterMark-box">
        <div class="pro-add-watermark margintop5">
          <p class="margintop10"> <span class="pos-checkbox">
            <input id="j-waterMarkSelect"
									CHECKED="true" type="checkbox">
            </span>为“本地上传”的图片添加水印<a
									id="j-waterMarkBtn" class="marginleft10" href="#">设置水印位置并预览</a> </p>
        </div>
        <div class="pro-bluewatermark-tip margintop5 clearfix"> <span>勾选：为本地上传的图片添加水印，默认位置为右下角；您还可以调整水印位置（点击【设置水印位置并预览】）。<br>
          不勾选：本地上传的图片不添加水印。 </span> </div>
      </div>
      <div class="pos-content">
        <!--P>为“本地上传”的图片添加水印<a href="#" class="marginleft10">真实产品图片水印效果预览</a></P-->
        <p class="margintop5"> 将“本地上传”的图片保存至
          <select id="s_albums_winid"
								onchange="javascript:onChangeAlbums_syn();"
								class="attr-select addwid140" name="s_albums_winid">
            <option selected="" value="2cecab61-8ac7-4e42-8a5f-101e09ef3f88">默认相册</option>
          </select>
        </p>
      </div>
    </div>
    <!-- 产品图片 结束 -->
    <!-- 从相册上传 开始-->
    <div style="width: 970px; display: none;" id="div_album_imglist"
					class="tc_warp" name="div_album_imglist">
      <iframe id="ifm_album_imglist" height="597" frameBorder="0"
						width="970" name="ifm_album_imglist" scrolling="no"></iframe>
    </div>
    <!--div id="div_desc_photoupload" name="div_desc_photoupload" class="tc_warp" style="width:610px;display:none;">                
    	<iframe id="ifm_desc_photoupload" name="ifm_desc_photoupload" width="610" height="560" frameborder="0" scrolling='no' ></iframe>     			                  
    </div-->
    <!--  从相册上传 结束-->
    <!--图片上传弹出窗口            开始-->
    <div style="width: 610px; display: none;" id="div_desc_photoupload"
					class="tc_warp">
      <table style="width: 610px;" class="noshade-pop-table">
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
                  <div class="noshade-pop-title"> <span>插入图片</span> </div>
                  <div class="syi-pop-title3">允许上传的图片格式为JPG，图片大小2M以内
                    。单次最多可上传8张，可分多次上传。</div>
                  <div class="padrigbox02">
                    <div class="marginbottom10 clearfix"> <span id="puw_spanobject_id" class="yellowBtn">
                      <!--input type="button" value="本地上传"-->
                      <input style="visibility: hidden;" id="puw_fileupload"
														name="puw_fileupload" type="button">
                      </span> <span
														class="uperrorbox">
                      <div style="display: none;" id="div_imgdescErrTip"
															class="tip-error"></div>
                      </span> </div>
                    <div class="rigmovebox nobod">
                      <div class="rigmove-b noscrol">
                        <ul id="div_imgcontainer_upload">
                          <li id="pu_li_1">
                            <div class="imgbod"> <img id="pu_imgshowurl_1"
																		src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m3.jpg"
																		width="98" height="98"> </div>
                            <div> <span id="descPicQueue_1"></span> </div>
                            <div> <span id="pu_imgshowname_1" class="marginleft5">&nbsp;</span> </div>
                            <div style="display: none;" id="pu_img_del_1"> <a
																		onclick="javascript:deleteImgUI_puw('1');return false;"
																		href="javascript:;">删除</a> </div>
                            <input id="pu_imgurl_1" name="pu_imgurl" value=""
																type="hidden">
                            <input id="pu_imgmd5_1"
																name="pu_imgmd5" value="" type="hidden">
                            <input
																id="pu_localfilename_1" name="pu_localfilename" value=""
																type="hidden">
                            <input id="pu_imgsize_1"
																name="pu_imgsize" value="" type="hidden">
                            <input
																id="pu_state_1" name="pu_state" value="" type="hidden">
                          </li>
                          <li id="pu_li_2">
                            <div class="imgbod"> <img id="pu_imgshowurl_2"
																		src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m3.jpg"
																		width="98" height="98"> </div>
                            <div> <span id="descPicQueue_2"></span> </div>
                            <div> <span id="pu_imgshowname_2" class="marginleft5">&nbsp;</span> </div>
                            <div style="display: none;" id="pu_img_del_2"> <a
																		onclick="javascript:deleteImgUI_puw('2');return false;"
																		href="javascript:;">删除</a> </div>
                            <input id="pu_imgurl_2" name="pu_imgurl" value=""
																type="hidden">
                            <input id="pu_imgmd5_2"
																name="pu_imgmd5" value="" type="hidden">
                            <input
																id="pu_localfilename_2" name="pu_localfilename" value=""
																type="hidden">
                            <input id="pu_imgsize_2"
																name="pu_imgsize" value="" type="hidden">
                            <input
																id="pu_state_2" name="pu_state" value="" type="hidden">
                          </li>
                          <li id="pu_li_3">
                            <div class="imgbod"> <img id="pu_imgshowurl_3"
																		src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m3.jpg"
																		width="98" height="98"> </div>
                            <div> <span id="descPicQueue_3"></span> </div>
                            <div> <span id="pu_imgshowname_3" class="marginleft5">&nbsp;</span> </div>
                            <div style="display: none;" id="pu_img_del_3"> <a
																		onclick="javascript:deleteImgUI_puw('3');return false;"
																		href="javascript:;">删除</a> </div>
                            <input id="pu_imgurl_3" name="pu_imgurl" value=""
																type="hidden">
                            <input id="pu_imgmd5_3"
																name="pu_imgmd5" value="" type="hidden">
                            <input
																id="pu_localfilename_3" name="pu_localfilename" value=""
																type="hidden">
                            <input id="pu_imgsize_3"
																name="pu_imgsize" value="" type="hidden">
                            <input
																id="pu_state_3" name="pu_state" value="" type="hidden">
                          </li>
                          <li id="pu_li_4">
                            <div class="imgbod"> <img id="pu_imgshowurl_4"
																		src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m3.jpg"
																		width="98" height="98"> </div>
                            <div> <span id="descPicQueue_4"></span> </div>
                            <div> <span id="pu_imgshowname_4" class="marginleft5">&nbsp;</span> </div>
                            <div style="display: none;" id="pu_img_del_4"> <a
																		onclick="javascript:deleteImgUI_puw('4');return false;"
																		href="javascript:;">删除</a> </div>
                            <input id="pu_imgurl_4" name="pu_imgurl" value=""
																type="hidden">
                            <input id="pu_imgmd5_4"
																name="pu_imgmd5" value="" type="hidden">
                            <input
																id="pu_localfilename_4" name="pu_localfilename" value=""
																type="hidden">
                            <input id="pu_imgsize_4"
																name="pu_imgsize" value="" type="hidden">
                            <input
																id="pu_state_4" name="pu_state" value="" type="hidden">
                          </li>
                          <li id="pu_li_5">
                            <div class="imgbod"> <img id="pu_imgshowurl_5"
																		src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m3.jpg"
																		width="98" height="98"> </div>
                            <div> <span id="descPicQueue_5"></span> </div>
                            <div> <span id="pu_imgshowname_5" class="marginleft5">&nbsp;</span> </div>
                            <div style="display: none;" id="pu_img_del_5"> <a
																		onclick="javascript:deleteImgUI_puw('5');return false;"
																		href="javascript:;">删除</a> </div>
                            <input id="pu_imgurl_5" name="pu_imgurl" value=""
																type="hidden">
                            <input id="pu_imgmd5_5"
																name="pu_imgmd5" value="" type="hidden">
                            <input
																id="pu_localfilename_5" name="pu_localfilename" value=""
																type="hidden">
                            <input id="pu_imgsize_5"
																name="pu_imgsize" value="" type="hidden">
                            <input
																id="pu_state_5" name="pu_state" value="" type="hidden">
                          </li>
                          <li id="pu_li_6">
                            <div class="imgbod"> <img id="pu_imgshowurl_6"
																		src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m3.jpg"
																		width="98" height="98"> </div>
                            <div> <span id="descPicQueue_6"></span> </div>
                            <div> <span id="pu_imgshowname_6" class="marginleft5">&nbsp;</span> </div>
                            <div style="display: none;" id="pu_img_del_6"> <a
																		onclick="javascript:deleteImgUI_puw('6');return false;"
																		href="javascript:;">删除</a> </div>
                            <input id="pu_imgurl_6" name="pu_imgurl" value=""
																type="hidden">
                            <input id="pu_imgmd5_6"
																name="pu_imgmd5" value="" type="hidden">
                            <input
																id="pu_localfilename_6" name="pu_localfilename" value=""
																type="hidden">
                            <input id="pu_imgsize_6"
																name="pu_imgsize" value="" type="hidden">
                            <input
																id="pu_state_6" name="pu_state" value="" type="hidden">
                          </li>
                          <li id="pu_li_7">
                            <div class="imgbod"> <img id="pu_imgshowurl_7"
																		src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m3.jpg"
																		width="98" height="98"> </div>
                            <div> <span id="descPicQueue_7"></span> </div>
                            <div> <span id="pu_imgshowname_7" class="marginleft5">&nbsp;</span> </div>
                            <div style="display: none;" id="pu_img_del_7"> <a
																		onclick="javascript:deleteImgUI_puw('7');return false;"
																		href="javascript:;">删除</a> </div>
                            <input id="pu_imgurl_7" name="pu_imgurl" value=""
																type="hidden">
                            <input id="pu_imgmd5_7"
																name="pu_imgmd5" value="" type="hidden">
                            <input
																id="pu_localfilename_7" name="pu_localfilename" value=""
																type="hidden">
                            <input id="pu_imgsize_7"
																name="pu_imgsize" value="" type="hidden">
                            <input
																id="pu_state_7" name="pu_state" value="" type="hidden">
                          </li>
                          <li id="pu_li_8">
                            <div class="imgbod"> <img id="pu_imgshowurl_8"
																		src="http://www.dhresource.com/dhs/mos/image/syi/new/no-photo-m3.jpg"
																		width="98" height="98"> </div>
                            <div> <span id="descPicQueue_8"></span> </div>
                            <div> <span id="pu_imgshowname_8" class="marginleft5">&nbsp;</span> </div>
                            <div style="display: none;" id="pu_img_del_8"> <a
																		onclick="javascript:deleteImgUI_puw('8');return false;"
																		href="javascript:;">删除</a> </div>
                            <input id="pu_imgurl_8" name="pu_imgurl" value=""
																type="hidden">
                            <input id="pu_imgmd5_8"
																name="pu_imgmd5" value="" type="hidden">
                            <input
																id="pu_localfilename_8" name="pu_localfilename" value=""
																type="hidden">
                            <input id="pu_imgsize_8"
																name="pu_imgsize" value="" type="hidden">
                            <input
																id="pu_state_8" name="pu_state" value="" type="hidden">
                          </li>
                        </ul>
                        <div class="numimg ps01">1</div>
                        <div class="numimg ps02">2</div>
                        <div class="numimg ps03">3</div>
                        <div class="numimg ps04">4</div>
                        <div class="numimg ps05">5</div>
                        <div class="numimg ps06">6</div>
                        <div class="numimg ps07">7</div>
                        <div class="numimg ps08">8</div>
                      </div>
                    </div>
                    <div class="pro-add-watermark margintop10  clearfix">
                      <div class="pos-content">
                        <p class="margintop5"> 将“本地上传”的图片保存至
                          <select id="puw_albums_winid"
																class="attr-select addwid140" name="puw_albums_winid">
                            <option selected=""
																	value="2cecab61-8ac7-4e42-8a5f-101e09ef3f88">默认相册</option>
                          </select>
                        </p>
                      </div>
                    </div>
                    <div class="popupbox-button clearfix"> <span class="yellowBtn valmiddle">
                      <input
														onclick="window.savaImageInfoToAlbum_puw();return false;"
														value="确 定" type="button">
                      </span> <span class="tourBtn">
                      <input
														onclick="window.closeSimpleModel();return false;"
														value="取 消" type="button">
                      </span> </div>
                  </div>
                  <div class="noshade-pop-bot"></div>
                  <a class="noshade-pop-close"
												onclick="window.parent.closeSimpleModel();return false;"
												href="javascript:;"></a> </div>
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
      <br>
      <br>
      <br>
      <br>
      <br>
    </div>
    <!--input type="hidden" name="tdalbumswindowid" id="tdalbumswindowid" value="" />
<input type="hidden" name="pagenum" id="pagenum" value="" />
<input type="hidden" name="searchtype" id="searchtype" value="" />
<input type="hidden" name="imgCount" id="imgCount" value="" /-->
    <input id="current_oper_index" name="current_oper_index" value="1"
					type="hidden">
    <input id="current_oper_imgurls"
					name="current_oper_imgurls" value="" type="hidden">
    <!--图片上传弹出窗口完-->
    <!-- 产品图片 结束 -->
    <!--google shopping页面-->
    <!-- 站内外推广图片 开始 -->
    <div class="mainlayout clearfix j-googleshopping-container"> <a id="a_googleshopping"></a>
      <div class="ml-title j-title">站内外推广图片：</div>
      <div class="j-enabled">
        <p class="helptips"> <span class="color444">请上传一张高质量的图片用于站内外推广(例如google
          shopping)，图片上无人为修改，无促销、产品属性、名称等信息，无PS修改涂痕 <a
								href="http://seller.dhgate.com/help/seller-help/c1510/a90202.html"
								target="_blank">了解更多</a> </span><span style="display: none;"
								class="helpicon" title="站内外推广图片帮助" data-helpid="googleshopping"></span> </p>
        <div class="margintop10"> <span class="yellowBtn j-btn-showpic">
          <input
								value="产品图片中选" type="button">
          </span> <span class="yellowBtn11">
          <input style="display: none;" id="fileupload_googleshopping"
								name="fileupload_googleshopping" width="72" height="23"
								type="button">
          <object style="visibility: visible;"
									id="fileupload_googleshoppingUploader"
									classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="72"
									height="23">
            <PARAM NAME="_cx" VALUE="1905">
            <PARAM NAME="_cy" VALUE="608">
            <PARAM NAME="FlashVars"
										VALUE="uploadifyID=fileupload_googleshopping&amp;pagepath=/syi/&amp;script=http://upload.dhgate.com/uploadfile&amp;folder=uploaddify&amp;width=72&amp;height=23&amp;wmode=transparent&amp;method=GET&amp;queueSizeLimit=8&amp;simUploadLimit=8&amp;hideButton=true&amp;fileDesc=choose *.jpg/&amp;fileExt=*.jpg;*.JPG;*.jpeg;*.JPEG;&amp;multi=true&amp;sizeLimit=2097152&amp;fileDataName=Filedata&amp;queueID=googleshoppingPicQueue">
            <PARAM NAME="Movie"
										VALUE="/syi/js/photo/upload2/uploadalbums.swf?v=1414202990667">
            <PARAM NAME="Src"
										VALUE="/syi/js/photo/upload2/uploadalbums.swf?v=1414202990667">
            <PARAM NAME="WMode" VALUE="Transparent">
            <PARAM NAME="Play" VALUE="0">
            <PARAM NAME="Loop" VALUE="-1">
            <PARAM NAME="Quality" VALUE="High">
            <PARAM NAME="SAlign" VALUE="LT">
            <PARAM NAME="Menu" VALUE="-1">
            <PARAM NAME="Base" VALUE="">
            <PARAM NAME="AllowScriptAccess" VALUE="always">
            <PARAM NAME="Scale" VALUE="NoScale">
            <PARAM NAME="DeviceFont" VALUE="0">
            <PARAM NAME="EmbedMovie" VALUE="0">
            <PARAM NAME="BGColor" VALUE="">
            <PARAM NAME="SWRemote" VALUE="">
            <PARAM NAME="MovieData" VALUE="">
            <PARAM NAME="SeamlessTabbing" VALUE="1">
            <PARAM NAME="Profile" VALUE="0">
            <PARAM NAME="ProfileAddress" VALUE="">
            <PARAM NAME="ProfilePort" VALUE="0">
            <PARAM NAME="AllowNetworking" VALUE="all">
            <PARAM NAME="AllowFullScreen" VALUE="false">
            <PARAM NAME="AllowFullScreenInteractive" VALUE="false">
            <PARAM NAME="IsDependent" VALUE="0">
            <param name="quality" value="high">
            <param name="wmode" value="transparent">
            <param name="allowScriptAccess" value="always">
            <param name="flashvars"
										value="uploadifyID=fileupload_googleshopping&amp;pagepath=/syi/&amp;script=http://upload.dhgate.com/uploadfile&amp;folder=uploaddify&amp;width=72&amp;height=23&amp;wmode=transparent&amp;method=GET&amp;queueSizeLimit=8&amp;simUploadLimit=8&amp;hideButton=true&amp;fileDesc=choose *.jpg/&amp;fileExt=*.jpg;*.JPG;*.jpeg;*.JPEG;&amp;multi=true&amp;sizeLimit=2097152&amp;fileDataName=Filedata&amp;queueID=googleshoppingPicQueue">
            <param name="movie"
										value="/syi/js/photo/upload2/uploadalbums.swf?v=1414202990667">
          </object>
          </span> <span class="yellowBtn marginleft10 j-btn-showalbum">
          <input
								value="相册上传" type="button">
          </span> </div>
        <div style="height: 120px;"
							class="pro-img-box margintop10 clearfix">
          <div style="cursor: pointer;" class="syi-upload-list addpiccolor"
								data-itemidx="0"> <span class="img promo j-current-pic"></span>
            <div id="googleshoppingPicQueue"></div>
          </div>
        </div>
        <div style="display: none;" class="tip-error j-error-tip"></div>
      </div>
      <div style="display: none;" class="j-disabled">
        <p class="helptips"> <span class="color444">已上传 <a
								href="http://seller.dhgate.com/help/seller-help/c1510/a90202.html"
								target="_blank">了解更多</a> </span><span style="display: none;"
								class="helpicon" title="站内外推广图片帮助" data-helpid="googleshopping"></span> </p>
      </div>
      <input class="j-input-googleshoppingimagelist"
						name="googleshoppingimagelist" value="" type="hidden"
						autocomplete="off">
    </div>
    <!-- 站内外推广图片 开始 -->
    <!-- googleshopping 弹层 开始 -->
    <div style="width: 390px; display: none;"
					class="j-dialog-googleshopping-pic">
      <div class="bs-pro-img-box">
        <div class="bimg">
          <div class="bimg-inner"> <span class="j-current"><img width="308"> </span> </div>
        </div>
        <div class="simg-warp">
          <div class="simg-list">
            <ul style="margin-left: 0px;" class="j-list">
            </ul>
          </div>
          <div class="simg-lg-arrow j-left"></div>
          <div id="simgRight" class="simg-rg-arrow j-right"></div>
        </div>
      </div>
      <div class="deitbtnbox clearfix j-dialog-btnbox"> <span class="j-btn-confirm yellowBtn">
        <input value="确定"
							type="button">
        </span><span class="j-btn-cancel tourBtn">
        <input
							value="取消" type="button">
        </span> </div>
    </div>
    <!-- googleshopping 弹层 结束 -->
    <script type="text/javascript"
					src="http://www.dhresource.com/dhs/fob/js/common/track/dhta.js"></script>
    <script>
 var GROUP_LIST = {"data":{"pageBean":{"count":0,"endNo":0,"nextPageNo":0,"page":1,"pageSize":100,"pages":0,"prePageNo":1,"startNo":1},"result":[]},"code":1,"msg":"success"};
 var GROUP_LIST_SELECTED = "";
 </script>
    <div class="mainlayout clearfix j-productgroup">
      <div class="ml-title">产品组：</div>
      <a id="a_productgrop"></a>
      <p class="helptips"> 产品组新增二级分组功能。产品组有二级分组时，请选择二级分组。否则产品将会归到未分组，影响使用。 <span
							class="helpicon" title="产品组帮助" data-helpid="productGroupHelp"></span> </p>
      <div class="margintop10">
        <input id="productgroupid" name="productgroupid" value=""
							type="hidden">
        <select class="j-select-root">
          <option
								value="">请选择产品分组</option>
        </select>
        <select style="display: none;" class="j-select-sub">
        </select>
      </div>
    </div>
    <!-- 产品简短描述 开始 -->
    <div id="productdescTip" class="mainlayout clearfix">
      <div class="ml-title"> <span class="required">*</span>产品简短描述： </div>
      <a id="a_productdesc"></a>
      <p class="helptips"> 商品参数，如：颜色、尺寸、款式、配件、贸易方式等。<span class="helpicon" title="产品简短描述帮助"
							helptipval="productdescTip"></span> </p>
      <div class="margintop10">
        <textarea style="ime-mode: disabled;" id="description"
							class="attr-textarea tareaheight addwid402" name="description" value="${(product.description)!}"></textarea>
        <span class="helptips marginleft10">您还可以输入<b
							id="productdescLengthSpan" class="color444">500</b><span
							class="color000">/<span>500</span> </span>个字符</span> </div>
      <div>
        <div></div>
        <div></div>
        <div></div>
      </div>
      <div style="display: none;" id="productdescErrTip"
						class="tip-error"></div>
    </div>
    <!-- 产品简短描述 结束 -->
    <!-- 产品详细描述 开始 -->
    <div id="featureshtmlTip" class="mainlayout clearfix">
      <div class="ml-title"> <span class="required">*</span>产品详细描述： </div>
      <p class="helptips"> 详细描述一般包含产品功能属性、产品细节图片、支付物流、售后服务、公司实力等内容。<span class="helpicon"
							title="产品详细描述帮助" helptipval="featureshtmlTip"></span> </p>
      <div class="margintop10">
        <select id="tpath" class="attr-select">
          <option selected="selected" value="">-选择产品详细描述模板-</option>
          <option value="86C69D17F12DF3BFE0400A0AD40A2CA1">Garden</option>
        </select>
      </div>
      <a id="a_featureshtml"></a> <br>
      <div style="width: 930px; max-width: 930px;">
        <div id="elm" class=" edui-default">
          <div style="width: 100%; z-index: 999;" id="edui1"
								class="edui-editor  edui-default">
            <div id="edui1_toolbarbox"
									class="edui-editor-toolbarbox edui-default">
              <div id="edui1_toolbarboxouter"
										class="edui-editor-toolbarboxouter edui-default">
                <div class="edui-editor-toolbarboxinner edui-default">
                  <div id="edui2" onselectstart="return false;"
												class="edui-toolbar   edui-default"
												onmousedown='return $EDITORUI["edui2"]._onMouseDown(event, this);'>
                    <div id="edui3"
													class="edui-box edui-combox edui-for-fontfamily edui-default">
                      <div id="edui3_state"
														onmouseup='$EDITORUI["edui3"].Stateful_onMouseUp(event, this);'
														class=" edui-default" title="字体"
														onmousedown='$EDITORUI["edui3"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui3"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui3"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-combox-body edui-default">
                          <div id="edui3_button_body"
																class="edui-box edui-button-body edui-default"
																onclick='$EDITORUI["edui3"]._onButtonClick(event, this);'>字体</div>
                          <div class="edui-box edui-splitborder edui-default"></div>
                          <div class="edui-box edui-arrow edui-default"
																onclick='$EDITORUI["edui3"]._onArrowClick();'></div>
                        </div>
                      </div>
                    </div>
                    <div id="edui11"
													class="edui-box edui-combox edui-for-fontsize edui-default">
                      <div id="edui11_state"
														onmouseup='$EDITORUI["edui11"].Stateful_onMouseUp(event, this);'
														class=" edui-default" title="字号"
														onmousedown='$EDITORUI["edui11"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui11"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui11"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-combox-body edui-default">
                          <div id="edui11_button_body"
																class="edui-box edui-button-body edui-default"
																onclick='$EDITORUI["edui11"]._onButtonClick(event, this);'>字号</div>
                          <div class="edui-box edui-splitborder edui-default"></div>
                          <div class="edui-box edui-arrow edui-default"
																onclick='$EDITORUI["edui11"]._onArrowClick();'></div>
                        </div>
                      </div>
                    </div>
                    <div id="edui22"
													class="edui-box edui-button edui-for-bold edui-default">
                      <div id="edui22_state"
														onmouseup='$EDITORUI["edui22"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui22"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui22"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui22"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui22_body"
																class="edui-button-body edui-default" title="加粗"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui22"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui23"
													class="edui-box edui-button edui-for-italic edui-default">
                      <div id="edui23_state"
														onmouseup='$EDITORUI["edui23"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui23"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui23"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui23"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui23_body"
																class="edui-button-body edui-default" title="斜体"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui23"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui24"
													class="edui-box edui-button edui-for-underline edui-default">
                      <div id="edui24_state"
														onmouseup='$EDITORUI["edui24"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui24"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui24"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui24"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui24_body"
																class="edui-button-body edui-default" title="下划线"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui24"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui25"
													class="edui-box edui-button edui-for-strikethrough edui-default">
                      <div id="edui25_state"
														onmouseup='$EDITORUI["edui25"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui25"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui25"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui25"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui25_body"
																class="edui-button-body edui-default" title="删除线"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui25"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui26"
													class="edui-box edui-separator  edui-default"></div>
                    <div id="edui27"
													class="edui-box edui-splitbutton edui-for-forecolor edui-default edui-colorbutton">
                      <div id="edui27_state"
														onmouseup='$EDITORUI["edui27"].Stateful_onMouseUp(event, this);'
														class=" edui-default" title="字体颜色"
														onmousedown='$EDITORUI["edui27"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui27"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui27"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-splitbutton-body edui-default">
                          <div id="edui27_button_body"
																class="edui-box edui-button-body edui-default"
																onclick='$EDITORUI["edui27"]._onButtonClick(event, this);'>
                            <div class="edui-box edui-icon edui-default"></div>
                            <div id="edui27_colorlump" class="edui-colorlump"></div>
                          </div>
                          <div class="edui-box edui-splitborder edui-default"></div>
                          <div class="edui-box edui-arrow edui-default"
																onclick='$EDITORUI["edui27"]._onArrowClick();'></div>
                        </div>
                      </div>
                    </div>
                    <div id="edui30"
													class="edui-box edui-splitbutton edui-for-backcolor edui-default edui-colorbutton">
                      <div id="edui30_state"
														onmouseup='$EDITORUI["edui30"].Stateful_onMouseUp(event, this);'
														class=" edui-default" title="背景色"
														onmousedown='$EDITORUI["edui30"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui30"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui30"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-splitbutton-body edui-default">
                          <div id="edui30_button_body"
																class="edui-box edui-button-body edui-default"
																onclick='$EDITORUI["edui30"]._onButtonClick(event, this);'>
                            <div class="edui-box edui-icon edui-default"></div>
                            <div id="edui30_colorlump" class="edui-colorlump"></div>
                          </div>
                          <div class="edui-box edui-splitborder edui-default"></div>
                          <div class="edui-box edui-arrow edui-default"
																onclick='$EDITORUI["edui30"]._onArrowClick();'></div>
                        </div>
                      </div>
                    </div>
                    <div id="edui33"
													class="edui-box edui-separator  edui-default"></div>
                    <div id="edui34"
													class="edui-box edui-button edui-for-justifyleft edui-default">
                      <div id="edui34_state"
														onmouseup='$EDITORUI["edui34"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui34"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui34"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui34"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui34_body"
																class="edui-button-body edui-default" title="居左对齐"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui34"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui35"
													class="edui-box edui-button edui-for-justifycenter edui-default">
                      <div id="edui35_state"
														onmouseup='$EDITORUI["edui35"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui35"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui35"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui35"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui35_body"
																class="edui-button-body edui-default" title="居中对齐"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui35"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui36"
													class="edui-box edui-button edui-for-justifyright edui-default">
                      <div id="edui36_state"
														onmouseup='$EDITORUI["edui36"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui36"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui36"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui36"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui36_body"
																class="edui-button-body edui-default" title="居右对齐"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui36"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui37"
													class="edui-box edui-separator  edui-default"></div>
                    <div id="edui38"
													class="edui-box edui-button edui-for-indent edui-default">
                      <div id="edui38_state"
														onmouseup='$EDITORUI["edui38"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui38"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui38"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui38"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui38_body"
																class="edui-button-body edui-default" title="首行缩进"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui38"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui39"
													class="edui-box edui-separator  edui-default"></div>
                    <div id="edui40"
													class="edui-box edui-menubutton edui-for-insertorderedlist edui-default">
                      <div id="edui40_state"
														onmouseup='$EDITORUI["edui40"].Stateful_onMouseUp(event, this);'
														class=" edui-default" title="有序列表"
														onmousedown='$EDITORUI["edui40"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui40"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui40"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-menubutton-body edui-default">
                          <div id="edui40_button_body"
																class="edui-box edui-button-body edui-default"
																onclick='$EDITORUI["edui40"]._onButtonClick(event, this);'>
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                          <div class="edui-box edui-splitborder edui-default"></div>
                          <div class="edui-box edui-arrow edui-default"
																onclick='$EDITORUI["edui40"]._onArrowClick();'></div>
                        </div>
                      </div>
                    </div>
                    <div id="edui47"
													class="edui-box edui-menubutton edui-for-insertunorderedlist edui-default">
                      <div id="edui47_state"
														onmouseup='$EDITORUI["edui47"].Stateful_onMouseUp(event, this);'
														class=" edui-default" title="无序列表"
														onmousedown='$EDITORUI["edui47"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui47"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui47"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-menubutton-body edui-default">
                          <div id="edui47_button_body"
																class="edui-box edui-button-body edui-default"
																onclick='$EDITORUI["edui47"]._onButtonClick(event, this);'>
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                          <div class="edui-box edui-splitborder edui-default"></div>
                          <div class="edui-box edui-arrow edui-default"
																onclick='$EDITORUI["edui47"]._onArrowClick();'></div>
                        </div>
                      </div>
                    </div>
                    <div id="edui54"
													class="edui-box edui-menubutton edui-for-lineheight edui-default">
                      <div id="edui54_state"
														onmouseup='$EDITORUI["edui54"].Stateful_onMouseUp(event, this);'
														class=" edui-default" title="行间距"
														onmousedown='$EDITORUI["edui54"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui54"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui54"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-menubutton-body edui-default">
                          <div id="edui54_button_body"
																class="edui-box edui-button-body edui-default"
																onclick='$EDITORUI["edui54"]._onButtonClick(event, this);'>
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                          <div class="edui-box edui-splitborder edui-default"></div>
                          <div class="edui-box edui-arrow edui-default"
																onclick='$EDITORUI["edui54"]._onArrowClick();'></div>
                        </div>
                      </div>
                    </div>
                    <div id="edui63"
													class="edui-box edui-separator  edui-default"></div>
                    <div id="edui64"
													class="edui-box edui-button edui-for-undo edui-default">
                      <div id="edui64_state"
														onmouseup='$EDITORUI["edui64"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui64"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui64"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui64"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui64_body"
																class="edui-button-body edui-default" title="撤销"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui64"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui65"
													class="edui-box edui-button edui-for-redo edui-default">
                      <div id="edui65_state"
														onmouseup='$EDITORUI["edui65"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui65"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui65"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui65"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui65_body"
																class="edui-button-body edui-default" title="重做"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui65"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui66"
													class="edui-box edui-separator  edui-default"></div>
                    <div id="edui67"
													class="edui-box edui-splitbutton edui-for-inserttable edui-default">
                      <div id="edui67_state"
														onmouseup='$EDITORUI["edui67"].Stateful_onMouseUp(event, this);'
														class=" edui-default" title="插入表格"
														onmousedown='$EDITORUI["edui67"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui67"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui67"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-splitbutton-body edui-default">
                          <div id="edui67_button_body"
																class="edui-box edui-button-body edui-default"
																onclick='$EDITORUI["edui67"]._onButtonClick(event, this);'>
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                          <div class="edui-box edui-splitborder edui-default"></div>
                          <div class="edui-box edui-arrow edui-default"
																onclick='$EDITORUI["edui67"]._onArrowClick();'></div>
                        </div>
                      </div>
                    </div>
                    <div id="edui70"
													class="edui-box edui-button edui-for-deletetable edui-default">
                      <div id="edui70_state"
														onmouseup='$EDITORUI["edui70"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui70"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui70"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui70"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui70_body"
																class="edui-button-body edui-default" title="删除表格"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui70"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui71"
													class="edui-box edui-separator  edui-default"></div>
                    <div id="edui78"
													class="edui-box edui-button edui-for-link edui-default">
                      <div id="edui78_state"
														onmouseup='$EDITORUI["edui78"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui78"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui78"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui78"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui78_body"
																class="edui-button-body edui-default" title="超链接"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui78"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui79"
													class="edui-box edui-button edui-for-unlink edui-default">
                      <div id="edui79_state"
														onmouseup='$EDITORUI["edui79"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui79"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui79"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui79"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui79_body"
																class="edui-button-body edui-default" title="取消链接"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui79"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui80"
													class="edui-box edui-button edui-for-cleardoc edui-default">
                      <div id="edui80_state"
														onmouseup='$EDITORUI["edui80"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui80"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui80"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui80"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui80_body"
																class="edui-button-body edui-default" title="清空文档"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui80"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui81"
													class="edui-box edui-button edui-for-fullscreen edui-default">
                      <div id="edui81_state"
														onmouseup='$EDITORUI["edui81"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui81"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui81"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui81"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui81_body"
																class="edui-button-body edui-default" title="全屏"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui81"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div id="edui82" onselectstart="return false;"
												class="edui-toolbar   edui-default"
												onmousedown='return $EDITORUI["edui82"]._onMouseDown(event, this);'>
                    <div id="edui83"
													class="edui-box edui-button edui-for-upload edui-default">
                      <div id="edui83_state"
														onmouseup='$EDITORUI["edui83"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui83"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui83"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui83"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui83_body"
																class="edui-button-body edui-default" title="上传本地图片"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui83"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default">上传本地图片</div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui84"
													class="edui-box edui-button edui-for-albums edui-default">
                      <div id="edui84_state"
														onmouseup='$EDITORUI["edui84"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui84"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui84"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui84"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui84_body"
																class="edui-button-body edui-default" title="图片相册"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui84"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default">图片相册</div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui85"
													class="edui-box edui-button edui-for-relatedproduct edui-default">
                      <div id="edui85_state"
														onmouseup='$EDITORUI["edui85"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui85"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui85"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui85"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui85_body"
																class="edui-button-body edui-default" title="插入关联产品"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui85"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default">插入关联产品</div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui86"
													class="edui-box edui-separator  edui-default"></div>
                    <div id="edui87"
													class="edui-box edui-button edui-for-source edui-default">
                      <div id="edui87_state"
														onmouseup='$EDITORUI["edui87"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui87"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui87"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui87"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui87_body"
																class="edui-button-body edui-default" title="源代码"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui87"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div id="edui88"
													class="edui-box edui-button edui-for-preview edui-default">
                      <div id="edui88_state"
														onmouseup='$EDITORUI["edui88"].Stateful_onMouseUp(event, this);'
														class=" edui-default"
														onmousedown='$EDITORUI["edui88"].Stateful_onMouseDown(event, this);'
														onmouseleave='$EDITORUI["edui88"].Stateful_onMouseLeave(event, this);'
														onmouseenter='$EDITORUI["edui88"].Stateful_onMouseEnter(event, this);'>
                        <div class="edui-button-wrap edui-default">
                          <div id="edui88_body"
																class="edui-button-body edui-default" title="预览效果"
																onmousedown="return false;"
																onclick='return $EDITORUI["edui88"]._onClick();'
																unselectable="on">
                            <div class="edui-box edui-icon edui-default"></div>
                            <div class="edui-box edui-label edui-default">预览效果</div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div style="display: none;" id="edui1_toolbarmsg"
										class="edui-editor-toolbarmsg edui-default">
                <div id="edui1_upload_dialog"
											class="edui-editor-toolbarmsg-upload edui-default"
											onclick='$EDITORUI["edui1"].showWordImageDialog();'>点击上传</div>
                <div class="edui-editor-toolbarmsg-close edui-default"
											onclick='$EDITORUI["edui1"].hideToolbarMsg();'>x</div>
                <div id="edui1_toolbarmsg_label"
											class="edui-editor-toolbarmsg-label edui-default"></div>
                <div style="height: 0px; overflow: hidden; clear: both;"
											class=" edui-default"></div>
              </div>
            </div>
            <div style="height: 540px; overflow: hidden;"
									id="edui1_iframeholder"
									class="edui-editor-iframeholder edui-default">
              <iframe id="baidu_editor_0" height="100%" frameBorder="0"
										width="100%" scroll="no"></iframe>
            </div>
            <div id="edui1_bottombar"
									class="edui-editor-bottomContainer edui-default">
              <table class=" edui-default">
                <tbody class=" edui-default">
                  <tr class=" edui-default">
                    <td id="edui1_elementpath"
													class="edui-editor-bottombar edui-default">请勿输入非英文字符和符号</td>
                    <td id="edui1_wordcount"
													class="edui-editor-wordcount edui-default">您还可以输入<strong>80000</strong>/80000个字符</td>
                    <td style="display: none;" id="edui1_scale"
													class="edui-editor-scale edui-default"><div
														class="edui-editor-icon edui-default"></div></td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div id="edui1_scalelayer" class=" edui-default"></div>
          </div>
        </div>
      </div>
      <div style="display: none;" id="featureshtmlErrTip"
						class="tip-error"></div>
    </div>
    <!-- 产品详细描述 结束 -->
    <!-- 产品视频 开始 -->
    <div id="vadiourlTip" class="mainlayout clearfix j-list-item">
      <div class="ml-title">产品视频链接：</div>
      <a id="a_vadiourl"></a>
      <div>
        <input id="videourl" class="attr-text-input addwid402"
							name="videourl" maxLength="300" value="" size="120" type="text">
        <span class="helpicon" title="导入视频帮助" helptipval="vadiourlTip"></span> </div>
      <div style="display: none;" class="tip-error" data-name="产品视频链接">
        <p></p>
      </div>
    </div>
    <!-- 产品视频结束 -->
    <!-- title产品内容描述 结束 -->
    <!-- title产品包装信息 开始 -->
    <div class="titlebox">
      <h3>4、产品包装信息</h3>
    </div>
    <!-- 包装后重量 开始 -->
    <div class="mainlayout clearfix">
      <div class="ml-title"> <span class="required">*</span>包装后重量： </div>
      <a id="a_productweight"></a> <a id="a_baseqt"></a> <a id="a_stepqt"></a> <a id="a_stepweight"></a>
      <div id="packTip_3">
        <input onblur="isRedrawTemplateTable();" id="productweight"
							class="attr-text-input j-textchange"
							onkeyup="inputFloat(this,2);checkProductWeight(this.value,this);"
							name="productweight" value="" size="6" type="text">
        <span
							id="span_productweight" class="marginleft10">公斤（KG）/<span
							id="sortbyunit2" class="j-unit" name="sortbyunit2"> 件 </span> </span> <span
							class="helpicon" title="包装后重量帮助" helptipval="packTip_3"></span> </div>
      <div style="display: none;" id="productweightErrTip"
						class="tip-error">
        <p id="productweightTipMsg"></p>
      </div>
      <div id="packTip_4" class="margintop10">
        <input id="isonlyweight"
							onclick="showOnlyWeight(this.checked,true);" name="isonlyweight"
							value="1" type="checkbox">
        <span class="marginleft5">产品计重阶梯设定</span><span
							class="helptips marginleft10">依据产品件数设置产品重量，适合体积小、重量大产品。<a
							href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0401&amp;artid=AEF02D27855321F1E04010AC0B64209F"
							target="_blank">查看详情</a><span class="helpicon" title="产品计重阶梯设定帮助"
							helptipval="packTip_4"></span> </span>
        <div style="display: none;" id="div_onlyweight"
							class="proladderset">
          <div class="margintop5"> 买家购买
            <input onblur="checkWeightBaseQT();"
									style="ime-mode: disabled;" id="baseqt"
									class="attr-text-input addwid60 margindoublev5"
									onkeyup="inputRightInt(this);checkWeightBaseQT();"
									name="baseqt" maxLength="5" value="" type="text">
            件以内，按单位产品重量计算运费。 </div>
          <p class="margintop5"> 在此基础上，买家每多买
            <input onblur="checkWeightStepQT();"
									style="ime-mode: disabled;" id="stepqt"
									class="attr-text-input addwid50 margindoublev5"
									onkeyup="inputRightInt(this);checkWeightStepQT();"
									name="stepqt" maxLength="5" value="" type="text">
            <span
									id="sortbyunit2" name="sortbyunit2">件</span>，重量增加
            <input
									onblur="checkWeightStepWeightQT();" style="ime-mode: disabled;"
									id="stepweight" class="attr-text-input addwid50 margindoublev5"
									onkeyup="inputFloat(this,2);checkWeightStepWeightQT();"
									name="stepweight" maxLength="6" value="" type="text">
            公斤。 </p>
          <div class="p-warn clearfix">
            <div class="p-warn-inner">当您填写完整以上自定义计重的信息后，系统会按照以上设定来计算总运费，忽略产品包装尺寸；错误设定自定义计重信息可能导致您承受运费损失，尤其对于体积重大于毛重的产品，请谨慎选择填写。</div>
          </div>
          <div style="display: none;" id="baseqtErrTip" class="tip-error">
            <p>请填写产品计重阶梯的数量！</p>
          </div>
          <div style="display: none;" id="stepqtErrTip" class="tip-error">
            <p>请填写产品计重阶梯的增加数量！</p>
          </div>
          <div style="display: none;" id="stepweightErrTip"
								class="tip-error">
            <p>请填写产品计重阶梯的增加重量，单位为公斤！</p>
          </div>
        </div>
      </div>
    </div>
    <!-- 包装后重量 结束 -->
    <!-- 包装后尺寸 开始 -->
    <div id="packTip_5" class="mainlayout clearfix">
      <div class="ml-title"> <span class="required">*</span>包装后尺寸： </div>
      <a id="a_sizelen"></a><a id="a_sizewidth"></a><a id="a_sizeheight"></a>
      <div>
        <input
							onblur="checkSizeNull(1);checkProductWeightSize();isRedrawTemplateTable();"
							style="color: rgb(148, 148, 148);" id="sizelen"
							onchange="inputFloat(this,2);"
							class="attr-text-input addwid60  j-textchange"
							onkeyup="inputFloat(this,2);checkProductWeightSize();"
							onclick="hideSizeMsg(this);" name="sizelen" value="长" size="6"
							type="text">
        <span class="margindoublev10">*</span>
        <input
							onblur="checkSizeNull(2);checkProductWeightSize();isRedrawTemplateTable();"
							style="color: rgb(148, 148, 148);" id="sizewidth"
							onchange="inputFloat(this,2);"
							class="attr-text-input addwid60  j-textchange"
							onkeyup="inputFloat(this,2);checkProductWeightSize();"
							onclick="hideSizeMsg(this);" name="sizewidth" value="宽" size="6"
							type="text">
        <span class="margindoublev10">*</span>
        <input
							onblur="checkSizeNull(3);checkProductWeightSize();isRedrawTemplateTable();"
							style="color: rgb(148, 148, 148);" id="sizeheight"
							onchange="inputFloat(this,2);"
							class="attr-text-input addwid60  j-textchange"
							onkeyup="inputFloat(this,2);checkProductWeightSize();"
							onclick="hideSizeMsg(this);" name="sizeheight" value="高" size="6"
							type="text">
        <span class="marginleft10">单位均为：厘米</span> <span
							class="helpicon" title="单位帮助" helptipval="packTip_5"></span> </div>
      <div style="display: none;" id="div_weightalert"
						class="p-warn clearfix">
        <div class="p-warn-inner"> 物流公司会根据产品包装后重量和产品包装体积重两者的较高值来计算运费。根据您填写的产品包装尺寸，DHgate估算出您产品的体积重约为<span
								id="shippingsizeweight"></span>公斤，超过了产品包装后重量，因此DHgate会根据您产品的体积重来计算运费。 <span class="p-warn-help-warp"> <span
								class="p-warn-help-icon"
								onmouseover="$('#div_weightalert_help').show()"
								onmouseout="$('#div_weightalert_help').hide()"></span> <span
								style="display: none;" id="div_weightalert_help"
								class="p-warn-help-inner">
          <table border="0" cellSpacing="0" cellPadding="0" width="100%">
            <tbody>
              <tr>
                <th align="left">物流公司计算体积重的方式：</th>
              </tr>
              <tr>
                <td align="center">重量 = 长 (cm)x 宽(cm)x 高(cm)/6000
                  公斤（kg）</td>
              </tr>
            </tbody>
          </table>
          </span> </span> </div>
      </div>
      <div style="display: none;" id="sizelenErrTip" class="tip-error">
        <p id="sizelenTipMsg">您需要输入包装的长度！</p>
      </div>
      <div style="display: none;" id="sizewidthErrTip" class="tip-error">
        <p id="sizewidTipMsg">您需要输入包装的宽度！</p>
      </div>
      <div style="display: none;" id="sizeheightErrTip" class="tip-error">
        <p id="sizehigTipMsg">您需要输入包装的高度！</p>
      </div>
    </div>
    <!-- 包装后尺寸 结束 -->
    <!-- title产品包装信息 结束 -->
    <!-- 运费设置开始 -->
    <div id="shippingmodelidTip_1" class="titlebox">
      <h3>5、设置运费</h3>
      <span class="helpicon" title="设置运费帮助"
						helptipval="shippingmodelidTip_1"></span> <a
						id="a_shippingmodelid"></a> </div>
    <!------- 运费设置列表开始 ------->
    <div class="j-list-item">
      <!------- 大标题开始 ------->
      <div id="shippingmodelidTip"
						class="mainlayout addzindex01 clearfix">
        <div class="addwid800 clearfix"> <span class="tourBtn fltrig">
          <input
								onclick="showShippingCalculatorWin('');" value="标准运费计算器"
								type="button">
          </span>
          <div class="ml-title"> <span class="required">*</span>选择运费模板： </div>
          <!-- 产品运费选择内容开始 -->
          <div class="syi-select-dropdown-list syi-lfselect">
            <div id="selectTemplateDiv" class="syi-simulation-select">
              <input id="shippingmodelname" class="syi-input15"
										name="shippingmodelname" readOnly="readonly" value=""
										type="text">
              <div class="syi-simulation-arrow"></div>
            </div>
            <div style="display: none;" id="templatesDiv"
									class="syi-category-list select-two">
              <ul id="templatesUL">
              </ul>
              <div style="display: none;" id="noTemplateDiv" class="catemore"> 您目前还没有创建任何运费模板。<br>
                <a
											href="/mydhgate/product/transport/template.do?act=preCreateOrdinary"
											target="_blank">创建模板</a> </div>
              <iframe></iframe>
            </div>
          </div>
          <!-- 产品运费选择内容结束 -->
          <a class="marginleft10"
								onclick="$('#shippingmodelidInfoTip').show();"
								href="http://seller.dhgate.com/frttemplate/pageload.do?act=pageload&amp;dhpath=10001,0205"
								target="_blank">管理运费模板</a><a style="display: none;"
								id="saveTemplateLink" class="marginleft10"
								onclick="showSaveAsDiv();return false;"
								href="javascript:void(0);">保存此设置为模板...</a> <span
								style="display: none;" id="savingTemplateSpan"
								class="syi-loading">模板保存中...</span><span style="display: none;"
								id="savedTemplateSpan" class="syi-correct marginleft10">模板保存成功</span> </div>
      </div>
      <!------- 大标题结束 ------->
      <!------- 运费设置列表开始 ------->
      <div style="display: none;" id="templateTableDiv"
						class="syi-shipping-content addzindex02 clearfix">
        <div class="syi-shippingset-tit">
          <ul>
            <li class="wid160">物流公司</li>
            <li class="wid320">送达国家</li>
            <li class="wid190">运费设置</li>
            <li class="wid209 tipstion">运费(含燃油费)
              <p class="syi-font3"> 运送
                <input id="caculateQuantity" class="j-textchange" value="1"
											size="2" type="text">
                件(包) 至
                <select
											id="caculateCountry" class="syi-select6">
                  <option value="">选择送达国家</option>
                  <option value="CN">中国</option>
                  <option value="US">美国</option>
                  <option value="HK">香港</option>
                  <option value="UK">英国</option>
                  <option value="CA">加拿大</option>
                  <option value="ES">西班牙</option>
                  <option value="DE">德国</option>
                  <option value="AU">澳大利亚</option>
                  <option value="FR">法国</option>
                  <option value="BR">巴西</option>
                  <option value="RU">俄罗斯</option>
                  <option value="VN">越南</option>
                  <option value="CL">智利</option>
                  <option value="AF">阿富汗</option>
                  <option value="AL">阿尔巴尼亚</option>
                  <option value="DZ">阿尔及利亚</option>
                  <option value="AS">美属萨摩亚</option>
                  <option value="AD">安道尔(安多拉)</option>
                  <option value="AO">安哥拉</option>
                  <option value="AI">安圭拉岛</option>
                  <option value="AG">安提瓜岛</option>
                  <option value="AR">阿根廷</option>
                  <option value="AM">亚美尼亚</option>
                  <option value="AW">阿鲁巴岛</option>
                  <option value="AT">奥地利</option>
                  <option value="AZ">阿塞拜疆</option>
                  <option value="BS">巴哈马群岛</option>
                  <option value="BH">巴林群岛</option>
                  <option value="BD">孟加拉国</option>
                  <option value="BB">巴巴多斯岛</option>
                  <option value="BY">白俄罗斯</option>
                  <option value="BE">比利时</option>
                  <option value="BZ">伯利兹城</option>
                  <option value="BJ">贝宁湾</option>
                  <option value="BM">百慕大群岛</option>
                  <option value="BT">不丹</option>
                  <option value="BO">玻利维亚</option>
                  <option value="BA">波斯尼亚</option>
                  <option value="BW">博茨瓦纳</option>
                  <option value="VG">英属维尔京群岛</option>
                  <option value="BN">文莱</option>
                  <option value="BG">保加利亚</option>
                  <option value="BF">布基纳法索</option>
                  <option value="BI">布隆迪</option>
                  <option value="KH">柬埔寨</option>
                  <option value="CM">喀麦隆</option>
                  <option value="CV">佛得角共和国</option>
                  <option value="KY">开曼群岛</option>
                  <option value="CF">中非共和国</option>
                  <option value="TD">乍得</option>
                  <option value="CO">哥伦比亚</option>
                  <option value="KM">科摩罗</option>
                  <option value="CK">库克群岛</option>
                  <option value="CR">哥斯达黎加</option>
                  <option value="HR">克罗地亚</option>
                  <option value="CU">古巴</option>
                  <option value="CY">塞浦路斯</option>
                  <option value="CZ">捷克</option>
                  <option value="CD">刚果 金</option>
                  <option value="DK">丹麦</option>
                  <option value="DJ">吉布提</option>
                  <option value="DM">多米尼加</option>
                  <option value="DO">多米尼加共和国</option>
                  <option value="TL">东帝汶</option>
                  <option value="EC">厄瓜多尔</option>
                  <option value="EG">埃及</option>
                  <option value="SV">萨尔瓦多</option>
                  <option value="GQ">赤道几内亚</option>
                  <option value="ER">厄立特里亚</option>
                  <option value="EE">爱沙尼亚</option>
                  <option value="ET">埃塞俄比亚</option>
                  <option value="FO">法罗群岛</option>
                  <option value="FK">福克兰群岛</option>
                  <option value="FJ">斐济</option>
                  <option value="FI">芬兰</option>
                  <option value="GF">法属圭亚那</option>
                  <option value="PF">法属波利尼西亚</option>
                  <option value="GA">加蓬</option>
                  <option value="GM">冈比亚</option>
                  <option value="GE">格鲁吉亚</option>
                  <option value="GH">加纳</option>
                  <option value="GI">直布罗陀</option>
                  <option value="GR">希腊</option>
                  <option value="GL">格陵兰</option>
                  <option value="GD">格林纳达</option>
                  <option value="GP">瓜德罗普岛</option>
                  <option value="GU">关岛</option>
                  <option value="GT">危地马拉</option>
                  <option value="GN">几内亚</option>
                  <option value="GW">几内亚比绍共和国</option>
                  <option value="GY">圭亚那</option>
                  <option value="HT">海地</option>
                  <option value="HN">洪都拉斯</option>
                  <option value="HU">匈牙利</option>
                  <option value="IS">冰岛</option>
                  <option value="IN">印度</option>
                  <option value="ID">印尼</option>
                  <option value="IR">伊朗</option>
                  <option value="IQ">伊拉克</option>
                  <option value="IE">爱尔兰</option>
                  <option value="IL">以色列</option>
                  <option value="IT">意大利</option>
                  <option value="CI">科特迪瓦</option>
                  <option value="JM">牙买加</option>
                  <option value="JP">日本</option>
                  <option value="JO">约旦</option>
                  <option value="KZ">哈萨克</option>
                  <option value="KE">肯尼亚</option>
                  <option value="KG">吉尔吉斯斯坦</option>
                  <option value="KI">基里巴斯</option>
                  <option value="KW">科威特</option>
                  <option value="LA">老挝国</option>
                  <option value="LV">拉脱维亚</option>
                  <option value="LB">黎巴嫩</option>
                  <option value="LS">莱索托</option>
                  <option value="LR">利比里亚</option>
                  <option value="LY">利比亚</option>
                  <option value="LI">列支敦士登</option>
                  <option value="LT">立陶宛</option>
                  <option value="LU">卢森堡</option>
                  <option value="MO">澳门</option>
                  <option value="MK">马其顿</option>
                  <option value="MG">马达加斯加岛</option>
                  <option value="MW">马拉维</option>
                  <option value="MY">马来西亚</option>
                  <option value="MV">马尔代夫</option>
                  <option value="ML">马里</option>
                  <option value="MT">马耳他</option>
                  <option value="MH">马绍尔群岛</option>
                  <option value="MQ">马提尼克</option>
                  <option value="MR">毛利塔尼亚</option>
                  <option value="MU">毛里求斯</option>
                  <option value="MX">墨西哥</option>
                  <option value="FM">密克罗尼西亚</option>
                  <option value="MD">摩尔多瓦</option>
                  <option value="MC">摩纳哥</option>
                  <option value="MN">蒙古</option>
                  <option value="ME">黑山</option>
                  <option value="MS">蒙特塞拉特岛</option>
                  <option value="MA">摩洛哥</option>
                  <option value="MZ">莫桑比克</option>
                  <option value="MM">缅甸</option>
                  <option value="NA">纳米比亚</option>
                  <option value="NR">瑙鲁</option>
                  <option value="NP">尼泊尔</option>
                  <option value="AN">荷属安的列斯群岛</option>
                  <option value="NL">荷兰</option>
                  <option value="NC">新喀里多尼亚</option>
                  <option value="NZ">新西兰</option>
                  <option value="NI">尼加拉瓜</option>
                  <option value="NE">尼日尔</option>
                  <option value="NG">尼日利亚</option>
                  <option value="NU">纽埃</option>
                  <option value="NF">诺福克</option>
                  <option value="MP">北马里亚纳群岛</option>
                  <option value="NO">挪威</option>
                  <option value="OM">阿曼</option>
                  <option value="PK">巴基斯坦</option>
                  <option value="PW">帕劳群岛</option>
                  <option value="PA">巴拿马</option>
                  <option value="PG">巴布亚新几内亚</option>
                  <option value="PY">巴拉圭</option>
                  <option value="PE">秘鲁</option>
                  <option value="PH">菲律宾共和国</option>
                  <option value="PL">波兰</option>
                  <option value="PT">葡萄牙</option>
                  <option value="PR">波多黎各</option>
                  <option value="QA">卡塔尔</option>
                  <option value="RE">留尼汪岛</option>
                  <option value="RO">罗马尼亚</option>
                  <option value="RW">卢旺达</option>
                  <option value="KN">圣基茨和尼维斯</option>
                  <option value="LC">圣卢西亚</option>
                  <option value="VC">圣文森特和格林纳丁斯</option>
                  <option value="WS">萨摩亚</option>
                  <option value="SM">圣马力诺</option>
                  <option value="ST">圣多美和普林西比</option>
                  <option value="SA">沙特阿拉伯</option>
                  <option value="SN">塞内加尔</option>
                  <option value="RS">塞尔维亚共和国</option>
                  <option value="SC">塞舌尔</option>
                  <option value="SL">塞拉利昂</option>
                  <option value="SG">新加坡</option>
                  <option value="SK">斯洛伐克</option>
                  <option value="SI">斯洛文尼亚</option>
                  <option value="SB">所罗门</option>
                  <option value="SO">索马里</option>
                  <option value="ZA">南非</option>
                  <option value="KR">韩国</option>
                  <option value="LK">斯里兰卡</option>
                  <option value="SD">苏丹</option>
                  <option value="SR">苏里南</option>
                  <option value="SZ">斯威士兰</option>
                  <option value="SE">瑞典</option>
                  <option value="CH">瑞士</option>
                  <option value="SY">叙利亚共和国</option>
                  <option value="TW">台湾</option>
                  <option value="TJ">塔吉克斯坦</option>
                  <option value="TZ">坦桑尼亚</option>
                  <option value="TH">泰国</option>
                  <option value="CG">刚果 布</option>
                  <option value="TG">多哥</option>
                  <option value="TO">汤加</option>
                  <option value="TT">特立尼达和多巴哥</option>
                  <option value="TN">突尼斯</option>
                  <option value="TR">土耳其</option>
                  <option value="TM">土库曼斯坦</option>
                  <option value="TC">特克斯和凯科斯群岛</option>
                  <option value="TV">图瓦卢</option>
                  <option value="VI">美属维尔京群岛</option>
                  <option value="UG">乌干达</option>
                  <option value="UA">乌克兰</option>
                  <option value="AE">阿拉伯联合酋长国</option>
                  <option value="UY">乌拉圭</option>
                  <option value="UZ">乌兹别克斯坦</option>
                  <option value="VU">瓦努阿图</option>
                  <option value="VA">梵蒂冈</option>
                  <option value="VE">委内瑞拉</option>
                  <option value="WF">瓦利斯群岛</option>
                  <option value="YE">也门</option>
                  <option value="ZM">赞比亚</option>
                  <option value="ZW">津巴布韦</option>
                </select>
              </p>
              <div style="left: -34px; top: 60px; display: block;"
										class="tiparrow-posbox j-package-tips">
                <div style="width: 240px;" class="tiparrow-box"> 使用运费计算请填写完整"<a href="#vadiourlTip">产品包装信息</a>" </div>
              </div>
            </li>
          </ul>
        </div>
        <!--运费及物流设置内容 ajax渲染-->
        <div class="j-shipping-box"></div>
        <!--国家内容白色 弹层-->
        <div style="display: none;"
							class="syi-shippingset-bar j-shipping-bar"> <b class="downarrow"></b> </div>
        <div style="display: none;"
							class="syi-country-wrap j-country-warp">
          <div class="syi-country-inner j-wrap-content"></div>
          <div class="syi-country-shadow"></div>
        </div>
        <!--国家内容白色 弹层-->
      </div>
      <div style="display: none;" id="shippingmodelidErrTip"
						class="tip-error"></div>
    </div>
    <!--国家太多时显示的tip 开始-->
    <div style="display: none; position: absolute; z-index: 1000;"
					id="countryTip" class="country_pop"> <a class="close_cpop" onclick="hideCoutriesTip();return false;"
						href="#"></a>
      <div class="syi-line"></div>
      <div id="coutryZoneDiv" class="country_popcont"></div>
      <iframe></iframe>
    </div>
    <!--国家太多时显示的tip 结束-->
    <!------- 运费设置列表结束 ------->
    <!-- 运费设置结束 -->
    <!--初始化vo-->
    <script>
           //var g_shippingmodeVo = com.dhgate.syi.model.ShippingmodeVO@47e818c1;
           //var g_shippingmodeVo = "null-value";
    </script>
    <!------- 运费设置列表结束 ------->
    <!-- title其他信息 开始 -->
    <div class="titlebox">
      <h3>6、其他信息</h3>
    </div>
    <!-- 工厂编号产品 开始 
    <div class="mainlayout clearfix" id="keywordTip">
        <div class="ml-title">工厂产品编号：</div>
        <div>
			<input class="attr-text-input marginright10" id="factoryproductname" name="factoryproductname" maxlength="25" type="text" value="" />
		</div>
    </div>-->
    <!-- 工厂产品编号 结束 -->
    <!-- 产品有效期 开始 -->
    <div id="vailddayTip" class="mainlayout clearfix">
      <div class="ml-title">产品有效期：</div>
      <a id="a_vaildday"></a> <span class="spanaddwid70">
      <input
						class="marginright5" name="vaildday" value="90" CHECKED=""
						type="radio">
      90天</span> <span class="spanaddwid70">
      <input
						class="marginright5" name="vaildday" value="30" type="radio">
      30天</span> <span class="spanaddwid70 widauto">
      <input
						class="marginright5" name="vaildday" value="14" type="radio">
      14天</span> <span class="helpicon" title="产品有效期帮助" helptipval="vailddayTip"></span> </div>
    <!-- 产品有效期 结束 -->
    <!-- 店铺会员专区产品 开始 -->
    <input id="specialzone0" value="0" type="hidden">
    <!-- 店铺会员专区产品 结束 -->
    <!-- VIP专供产品 开始 -->
    <input id="productvip0" value="0" type="hidden">
    <!-- VIP专供产品 结束 -->
    <!--对频繁上传产品的卖家显示验证码-->
    <!-- 敦煌网网络服务使用协议 开始 -->
    <div class="chousexybox">
      <input id="dhgateagree" onclick="clickagreee();" CHECKED="checked"
						type="checkbox">
      <span class="marginleft5">同意接受<a
						href="http://policy.dhgate.com/policy_list.php?catalogno=110305"
						target="_blank">《敦煌网产品发布规则》</a> </span> </div>
    <!-- 敦煌网网络服务使用协议 结束 -->
    <!-- title其他信息 结束 -->
    <!-- 完成提交开始 -->
    <div id="syi_submit_id" class="syi-submit"> <strong id="errormsgid" class="error-edit-text">网络繁忙，请稍后重试，如果问题仍然存在，请联系敦煌网客服部门。</strong><br>
      <button id="btn_submitproduct" type="button"> <span id="loadingimg" class="submit-syi"><img
							class="syi-img-show"
							src="http://image.dhgate.com/2008/web20/seller/img/loadings.gif"> <span id="submitopt">提 交</span> </span> </button>
      <input type="submit" valu="保存">
      <!--<button type="button"  id="btn_previewproduct">
			<span class="preview" id="previewopt"><span>预览</span></span>
		</button>-->
    </div>
    <!-- 完成提交结束 -->
    <div class="studybox"> <a
						href="http://survey.dhgate.com/index.php?sid=72953&amp;lang=zh-Hans&amp;dhsurveybuyerid=ff808081482fd3fd01485e24266e5056"
						target="_blank"><span class="studyicon">产品上传不方便？我要提意见</span> </a> </div>
    <!-- Top 开始 -->
    <div style="right: 261px;" id="returnTopBox" class="syi-returntop">
      <div class="returntopbox"> <a href="#syiTop"></a> </div>
    </div>
    <!-- Top 结束 -->
    <!-- footer文件调用开始 -->
    <div class="headerlayout">
      <iframe id="headiframe" height="81"
						src="http://seller.dhgate.com/syihtml/footer_syi.html"
						frameBorder="0" width="100%" name="head" scrolling="no"></iframe>
    </div>
    <!-- footer文件调用结束 -->
    <input id="rid" name="rid" value="lBATqvUqWMSEb8fQE" type="hidden">
    <input id="requestid" name="requestid" value="" type="hidden">
    <input id="productid" name="productid" value="" type="hidden">
    <input id="itemcode" name="itemcode" value="" type="hidden">
    <input id="inp_catepubid" name="catepubid" value="135002"
					type="hidden">
    <input id="imglistid" name="imglist"
					value="" type="hidden">
    <input id="prospeclistid"
					name="prospeclist" value="" type="hidden">
    <input
					id="shippingmodelid" name="shippingmodelid" value="" type="hidden">
    <input id="isquickup" name="isquickup" value="0" type="hidden">
    <input id="viewSource" name="viewSource" value="" type="hidden">
    <input id="repeatGroupId" name="repeatGroupId" value=""
					type="hidden">
    <input id="invetoryQty" value="231"
					type="hidden">
    <input id="isHaveSpec" value="0"
					type="hidden">
    <input id="commissionRate"
					value="0.12,0.045,300" type="hidden">
    <input
					id="commissionOrderAmount" value="" type="hidden">
    <input
					id="oldSkuInfo" name="oldSkuInfo" value="" type="hidden">
    <input
					id="forEditOldCatePubid" name="forEditOldCatePubid" value=""
					type="hidden">
    <div style="display: none;" id="div_proSkuInfo"></div>
    <input id="proSkuInfo" name="proSkuInfo" value="" type="hidden">
    <input id="customAttrList" name="specselfDef" value="" type="hidden">
    <div style="display: none;" id="div_customattrlist"></div>
    <input id="saleSectionData" name="discountRange" value=""
					type="hidden">
    <input id="productInventorylist"
					name="productInventorylist" value="" type="hidden">
    <input
					id="sourceItemcode" name="sourceItemcode" value="" type="hidden">
    <input id="attrlistid" name="attrlist" value="" type="hidden">
    <input id="tdProSaleSetId" name="tdProSaleSetId" value=""
					type="hidden">
    <div style="display: none;" id="div_attrlistid"></div>
    <input id="sourcetype" name="sourcetype" value="" type="hidden">
  </form>
  <input id="fromMD5" name="fromMD5" value="" type="hidden">
  <input
				id="accuratelydescribe" value="" type="hidden">
  <input
				id="oneday" value="" type="hidden">
  <input id="pagetype"
				value="1" type="hidden">
  <input id="sortorder" value=""
				type="hidden">
  <input id="orderby" value="" type="hidden">
  <input id="modelname" value="" type="hidden">
  <input
				id="platform" value="product" type="hidden">
  <input
				id="pagenum" value="" type="hidden">
  <input id="micTag"
				value="" type="hidden">
  <input id="oldSyiVersionURL"
				value="" type="hidden">
  <input id="isfactory" value="0"
				type="hidden">
  <input id="supplierid"
				value="ff808081482fd3fd01485e24266e5056" type="hidden">
  <input
				id="nickname" value="sunvsoft" type="hidden">
  <input
				id="inventoryLocationVal" value="CN" type="hidden">
  <input
				id="isProdMove" value="" type="hidden">
  <input
				id="isShowMoveTip" value="" type="hidden">
  <input
				id="minprice" type="hidden">
  <input id="ekeywords"
				type="hidden">
  <input id="ikeywords" type="hidden">
  <input id="isValidCategory" value="" type="hidden">
  <input
				id="googleShoppingRequired" value="" type="hidden">
  <div style="display: none;" id="div_price_copying"
				class="syi-price-copy">
    <p class="color4">本操作仅限复制数量区间与备货期。</p>
    <p>请勾选或者直接点击要复制到的规格：</p>
    <p class="pmar">
      <input id="inp_temp_sp" onclick="selectAll(this,'inp_des_sp')"
						value="" type="checkbox">
      全选 </p>
    <ul id="ul_price_copying">
    </ul>
    <div class="syi-line"></div>
    <div class="syi-category-submit"> <span class="yellowBtn">
      <input onclick="CopyingPriceSp();"
						value="确 定" type="button">
      </span> <span class="tourBtn">
      <input
						onclick="priceclose();" value="取 消" type="button">
      </span> </div>
    <iframe></iframe>
  </div>
  <div style="width: 400px; display: none;" id="saveAsDiv">
    <table style="width: 400px;" class="noshade-pop-table">
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
                  <div class="noshade-pop-title"> <span>另保存模版</span> </div>
                  <div class="box2">
                    <p> <span class="widtitle"><span class="colorf00">*</span>模板名称：</span> <span class="wid225contxt clearfix"> <span
														class="padbottom10 clearfix">
                      <input
															id="templateNameInput"
															class="attr-text-input addwid140  clearfix"
															maxLength="15" size="30" type="text">
                      <span
															class="color5">最多15个字符</span> </span> <span
														style="display: none;" id="saveErrorSpan"
														class="tip-error"></span> </span> </p>
                  </div>
                  <div class="boxcenter clearfix"> <span class="yellowBtn">
                    <input
													onclick="saveTempate();" value="确定" type="button">
                    </span> </div>
                </div>
                <div class="noshade-pop-bot"></div>
                <a class="noshade-pop-close"
											onclick="javascript:jQuery.modal.close();" href="#"></a> </div>
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
  </div>
  <div style="width: 420px; display: none;" id="addproductgroupdiv"
				class="tc_warp">
    <div class="tc_title">
      <dl>
        <dt>添加新产品组</dt>
        <dd> <a class="modalClose" href="#"><img alt="close"
								src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif"> </a> </dd>
      </dl>
    </div>
    <div class="tc_main">
      <div class="tc_content">
        <div class="box2 ">
          <table class="table1" border="0" cellSpacing="0" cellPadding="0"
								width="100%">
            <tbody>
              <tr>
                <td vAlign="top" width="80" align="right"><span
											class="color2">*</span>产品组名称：</td>
                <td><input id="productgroupnamediv" class="input1"

											name="productgroupnamediv" maxLength="20" value="" size="30"
											type="text"></td>
              </tr>
              <tr>
                <td vAlign="top" width="80" align="right">产品组介绍：</td>
                <td><textarea id="productgroupcontextdiv" cols="48"
												rows="5" name="productgroupcontextdiv"></textarea></td>
              </tr>
            </tbody>
          </table>
          <div style="display: none;" id="productGroupErrTip"
								class="p-warn1 clearfix">
            <p></p>
          </div>
          <div class="tc_content_button center">
            <button onclick="addProductGroup();" type="button"> <span style="color: rgb(255, 255, 255);" class="button1_lt"><span
										class="button1_ri">确认</span> </span> </button>
  
            <button onclick="closewindow();" type="button"> <span style="color: rgb(108, 108, 108);" class="button2_lt"><span
										class="button2_ri">取消</span> </span> </button>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div style="top: 25px; display: none; z-index: 999;"
				id="brandsSearchtable" class="posionabs">
    <table style="width: 700px;" class="noshade-pop-table bggery">
      <tbody>
        <tr>
          <td class="t-lt"></td>
          <td class="t-mid"></td>
          <td class="t-ri"></td>
        </tr>
        <tr>
          <td class="m-lt"></td>
          <td class="m-mid"><div id="brandsSearchDiv" class="mid-warp">
              <div class="noshade-pop-content">
                <div class="noshade-pop-title"> <span>选择品牌</span> </div>
                <div class="syi-simulation-content-search"> 品牌搜索：
                  <input style="ime-mode: disabled;"
												onkeydown="return(clickButton());" id="queryBrands_txt"
												class="syi-input3" name="queryBrands_txt" value=""
												type="text">
                  <span class="yellowBtn">
                  <input
												onclick="javascript:brandQuery();" name="name1" value="搜索"
												type="button">
                  </span> <a class="fltrig"
												href="/mydhgate/product/brands.do?act=sellerbrandlist&amp;dhpath=10001,0217"
												target="_blank">管理品牌</a> </div>
                <div class="syi-line4"></div>
                <div class="syi-simulation-content-list">
                  <div id="div_index_id"> 索引：<a class="f-bold">A</a><b style="display: none;">A</b>|<a
													href="">B</a><b style="display: none;">B</b>|<a href="">C</a><b
													style="display: none;">C</b>|<a href="">D</a><b
													style="display: none;">D</b>|<a href="">E</a><b
													style="display: none;">E</b>|<a href="">F</a><b
													style="display: none;">F</b>|<a href="">G</a><b
													style="display: none;">G</b>|<a href="">H</a><b
													style="display: none;">H</b>|<a href="">I</a><b
													style="display: none;">I</b>|<a href="">J</a><b
													style="display: none;">J</b>|<a href="">K</a><b
													style="display: none;">K</b>|<a href="">L</a><b
													style="display: none;">L</b>|<a href="">M</a><b
													style="display: none;">M</b>|<a href="">N</a><b
													style="display: none;">N</b>|<a href="">O</a><b
													style="display: none;">O</b>|<a href="">P</a><b
													style="display: none;">P</b>|<a href="">Q</a><b
													style="display: none;">Q</b>|<a href="">R</a><b
													style="display: none;">R</b>|<a href="">S</a><b
													style="display: none;">S</b>|<a href="">T</a><b
													style="display: none;">T</b>|<a href="">U</a><b
													style="display: none;">U</b>|<a href="">V</a><b
													style="display: none;">V</b>|<a href="">W</a><b
													style="display: none;">W</b>|<a href="">X</a><b
													style="display: none;">X</b>|<a href="">Y</a><b
													style="display: none;">Y</b>|<a href="">Z</a><b
													style="display: none;">Z</b> </div>
                  <div style="display: block;"
												class="syi-simulation-content-ul">
                    <ul id="ul_brands_list_id">
                    </ul>
                  </div>
                  <div style="display: none;" id="nobrandtips"
												class="syi-simulation-content-list syi-error"> 该关键字没有匹配到品牌，请您重新尝试别的英文关键字，您可以选择<a
													onclick="selectedBrand('99','无品牌','','无品牌');return false;"
													href="#">无品牌</a>或者<a
													href="http://seller.dhgate.com/mydhgate/product/brands.do?act=sellerbrandlist&amp;dhpath=10001,0217"
													target="_blank">管理品牌</a> </div>
                  <div style="display: none;"
												class="p-warn3 p-warn3-mar clearfix">
                    <p>对不起，您搜索的结果为0条，请重新输入您要搜索的品牌名称！</p>
                  </div>
                  <div class="syi-line4"></div>
                  <div id="div_page_code" class="syi-simulation-content-page"></div>
                  <div class="syi-category-submit"> <span class="tourBtn">
                    <input
													onclick="javascript:btnSelBrandCancel();"
													name="btn_selBrand_cancel" value="取 消" type="button">
                    </span> </div>
                </div>
                <div class="noshade-pop-bot"></div>
                <a class="noshade-pop-close"
											onclick="javascript:btnSelBrandCancel();" href="#"></a> </div>
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
    <iframe></iframe>
  </div>
  <!--  ---------------------    用户引导  开始     ----------------------------  -->
  <input id="readnewsyi" name="readnewsyi" value="show" type="hidden">
  <!--  ---------------------    用户引导  完     ----------------------------  -->
  <div style="width: 480px; display: none;" id="div_htmltemp"
				class="tc_warp">
    <table style="width: 480px;" class="noshade-pop-table bggery">
      <tbody>
        <tr>
          <td class="t-lt"></td>
          <td class="t-mid"></td>
          <td class="t-ri"></td>
        </tr>
        <tr>
          <td class="m-lt"></td>
          <td class="m-mid"><div id="brandsSearchDiv" class="mid-warp">
              <div class="noshade-pop-content">
                <div class="noshade-pop-title"> <span>以下为必填项</span> </div>
                <div class="tc_content">
                  <div class="box1"> <span id="p_agreement"></span>
                    <div class="tc_content_button center"> <span class="yellowBtn">
                      <input
														onclick="setHTMLDescription('elm');"
														name="btn_selBrand_cancel" value="确定" type="button">
                      </span> </div>
                  </div>
                </div>
                <div class="noshade-pop-bot"></div>
                <a class="noshade-pop-close"
											onclick="javascript:jQuery.modal.close();" href="#"></a> </div>
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
  </div>
  <input id="idOpenHelpIconShow" type="hidden">
  <!-- -弹出层 end-- -->
</div>
<!--丢失属性产品提示弹层 开始-->
<div style="display: none;"
		class="new-guide-step1 png_bg j-dialog-missattribute">
  <div class="guidetxtbox"> 由于类目升级，您当前编辑的产品所属类目属性已改变，您可以点击<span class="rcolor">产品填写参考</span>查看变更前的产品信息。 </div>
  <span class="guide-iknow j-closer" conduct="iknow">我知道了~</span>
  <div class="guide-arrow001 png_bg"></div>
  <a class="guide-close-button png_bg j-closer"
			href="javascript:void(0);" conduct="iknow"></a> </div>
<!--丢失属性产品提示弹层 结束-->
<!-- 返回修改类目提示弹层 开始 -->
<div style="width: 400px; display: none;"
		class="j-dialog-returncategory">
  <div class="box1 clearfix">
    <p class="j-dialog-msg p1">由于类目升级，您当前修改的产品所属类目已改变，请您先重新选择类目后再继续修改产品信息。</p>
    <div class="align-center pop-button clearfix"> <span class="yellowBtn valmiddle j-btn-return">
      <input
					value="返回修改类目" type="button">
      </span> </div>
  </div>
</div>
<!-- 返回修改类目提示弹层 结束 -->
<script type="text/javascript">
    	if(typeof($conf) == 'undefined'){
    		var $conf = {};
    	}
    	$conf['version'] = '20141013';
    </script>
<script type="text/javascript"
		src="http://www.dhresource.com/dhs/mos/js/syi/20141013/syisku.js?t=20140326"></script>
<script type="text/javascript"
		src="http://www.dhresource.com/dhs/mos/js/syi/20141013/ueditor/editor_config.js"></script>
<script type="text/javascript"
		src="http://www.dhresource.com/dhs/mos/js/syi/20141013/ueditor/editor_all.js"></script>
<script type="text/javascript"
		src="http://www.dhresource.com/dhs/mos/js/syi/20141013/ueditor/dhedite.js"></script>
<script type="text/javascript"
		src="http://js.dhresource.com/seller/syi/20141013/newSyiMain.js"></script>
<script type="text/javascript">
    //初始化数据
    var pid = $('#productid').val();
    var g_user_cate_punish_array = [];
	    <!--
    var _dhq = _dhq || [];
    
    (function() {
        var dha = document.createElement('script'); dha.type = 'text/javascript'; dha.async = true;
        dha.src = ('https:' == document.location.protocol ? 'https://secure.dhgate.com/scripts/dhta.js' : 'http://www.dhresource.com/dhs/fob/js/common/track/dhta.js');
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(dha, s);
    })();
    
    
    function pageviewevent(){
      try{
        var supplierid = $("#supplierid").val();
    	var track_pid =  $("#productid").val();
      	_dhq.push(["setVar","supplierid",supplierid]);
    	_dhq.push(["setVar","pid",track_pid]);
    	_dhq.push(["setVar","requestid","lBATqvUqWMSEb8fQE"]);
    	_dhq.push(["event", "Public_S0003"]);
      }catch(e){}
    }
    
    $(document).ready(function(){
        pageviewevent();
    });
//-->

			g_category = {"admittanceDto":null,"attributeList":null,"catePubId":"135002","categoryPath":null,"categoryPathChinese":null,"children":null,"excludeKeywords":null,"inlucdeKeywords":null,"leaf":"1","minPrice":null,"pareCatePubId":"135","prodLineId":19961,"pubName":"Dummy Phones","pubNameCn":"手机模型","remark":"手机模型。","selected":false,"stockPeriod":2,"stockWarnRatio":0.1,"updateBy":"php","updateTime":1311835562000,"valid":"1"};
	    		 g_bInitProductData=false;
		 	 	g_inventory_list = null;
	      $(document).ready(function () {
    	// 初始化价格
		//initProductSpecification();
		
        // 价格区间备货期上方的提示层注册事件
        $("#inventoryperiodknow" ).live("click", function (e) {
        	e.preventDefault();
    		knowInventoryPeriodHip();
            return false;
        });
     });
	 
	        function openSyiChatWindow() {
    		 // 用户相关的参数,用于在服务端显示用户的登录名
    		 var userinfo = "#params:seller_new_lv,0,sellerusername," + $("#nickname").val() + ",supplierid," + $("#supplierid").val() + ",userId," + $("#nickname").val();
             var url = 'http://ichat.dhgate.com/looyu/chat/p.do?c=10001&g=177492&f=79287&r=' + encodeURIComponent(userinfo);
             var widthSize = 950;
             var heightSize = 680;
             var posTop = (screen.height - heightSize) / 2;
             var posLeft = (screen.width - widthSize) / 2;
             var p = "height="+ heightSize+ ",width="+ widthSize + ",directories=no,location=no,menubar=no,resizable=yes,status=no,toolbar=no,top="+ posTop + ",left=" + posLeft;
             try {
             var cw = window.open(url, 'chat_cs_syi', p);
             cw.focus();
             } catch (e) {
             }
        }
    	
    	$(document).ready(function () {

            $("#syi_chat_window" ).live("click", function (e) {
                e.preventDefault();
    			openSyiChatWindow();
                return false;
            });
    	});
	    $(document).ready(function(){

        $("html").css({ "overflow":"hidden"});
        $("body").css({ "overflow-x":"hidden"});

    });
</script>
<div></div>
<div style="display: none;" class="dh-dialog-1414202990665">
  <table class="noshade-pop-table j-dialog-container">
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
              <div class="noshade-pop-title j-dialog-title-container"> <span class="j-dialog-title">操作提示</span> </div>
              <div class="noshade-pop-inner j-dialog-inner-container"></div>
              <div class="noshade-pop-bot j-dialog-bot-container"></div>
            </div>
            <a class="noshade-pop-close j-dialog-closer" href="javascript:;"></a> </div></td>
        <td class="m-ri"></td>
      </tr>
      <tr>
        <td class="b-lt"></td>
        <td class="b-mid"></td>
        <td class="b-ri"></td>
      </tr>
    </tbody>
  </table>
</div>
<div style="display: none;" class="dh-dialog-1414202990666">
  <table class="noshade-pop-table j-dialog-container">
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
              <div class="noshade-pop-title j-dialog-title-container"> <span class="j-dialog-title">操作提示</span> </div>
              <div class="noshade-pop-inner j-dialog-inner-container"></div>
              <div class="noshade-pop-bot j-dialog-bot-container"></div>
            </div>
            <a class="noshade-pop-close j-dialog-closer" href="javascript:;"></a> </div></td>
        <td class="m-ri"></td>
      </tr>
      <tr>
        <td class="b-lt"></td>
        <td class="b-mid"></td>
        <td class="b-ri"></td>
      </tr>
    </tbody>
  </table>
</div>
<div style="width: 780px; display: none;"
		class="j-dialog-relatedproduct">
  <div class="poppad01">
    <div class="public-lr-box clearfix">
      <div class="public-r-box"> <span>
        <input
						class="public-txt-input color999 marginright10 j-temp-name"
						value="模板名称" type="text">
        </span><span class="tourBtn">
        <input
						class="j-btn-search" value="搜 索" type="button">
        </span> </div>
      <div class="public-l-box marginleft10"> <span>最多可以选择 <b class="colorf50">3</b> 个关联产品模板</span> </div>
    </div>
    <!-- 列表 开始 -->
    <div class="bg-list rew-bg">
      <table border="0" cellSpacing="0" cellPadding="0" width="100%">
        <tbody>
          <tr>
            <th class="padleft10" width="45%">模板名称</th>
            <th width="20%">使用此模板的产品</th>
            <th width="20%">最后更新时间</th>
            <th class="last" width="15%">操作</th>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="bg-list rew-hg">
      <!-- 列表 开始 -->
      <table class="j-temp-list" border="0" cellSpacing="0"
					cellPadding="0" width="100%">
      </table>
    </div>
    <!-- 列表 结束 -->
    <!--分页 开始-->
    <div class="commonpage j-relatedproduct-pager"></div>
    <!--分页 结束-->
    <div class="margintop10 marginlr10 clearfix j-view-list"></div>
    <div style="display: none;" class="tips-common j-error-tip"> <span class="tips-error">错误提示</span> </div>
  </div>
  <div class="box1">
    <div class="align-center clearfix"> <span class="bigyellow-button valmiddle marginright10">
      <input
					class="j-btn-confirm" value="确 定" type="button">
      </span> <span
					class="biggrey-button">
      <input class="j-btn-cancel"
					value="取 消" type="button">
      </span> </div>
  </div>
</div>
<div style="display: none;" class="dh-dialog-1414202991080">
  <table class="noshade-pop-table j-dialog-container">
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
              <div class="noshade-pop-title j-dialog-title-container"> <span class="j-dialog-title">操作提示</span> </div>
              <div class="noshade-pop-inner j-dialog-inner-container"></div>
              <div class="noshade-pop-bot j-dialog-bot-container"></div>
            </div>
            <a class="noshade-pop-close j-dialog-closer" href="javascript:;"></a> </div></td>
        <td class="m-ri"></td>
      </tr>
      <tr>
        <td class="b-lt"></td>
        <td class="b-mid"></td>
        <td class="b-ri"></td>
      </tr>
    </tbody>
  </table>
</div>
<div
		style="left: 0px; top: 0px; width: 0px; height: 0px; position: fixed;"
		id="edui_fixedlayer" class=" edui-default">
  <div style="display: none;" id="edui89"
			class="edui-popup  edui-bubble edui-default">
    <div id="edui89_body" class="edui-popup-body edui-default">
      <iframe
					style="left: 0px; top: 0px; position: absolute; z-index: -1; background-color: transparent;"
					class=" edui-default" height="100%" src="javascript:"
					frameBorder="0" width="100%"></iframe>
      <div class="edui-shadow edui-default"></div>
      <div id="edui89_content" class="edui-popup-content edui-default"> </div>
    </div>
  </div>
</div>
<div style="display: none; position: fixed; z-index: 3001;"
		id="idPop_e" class="guidedbox">
  <div class="box">
    <div id="guidedBoxImgList"></div>
    <a id="close_e" class="guidedclosed" onclick="idPopSave();"></a>
    <div class="guided-steps-box">
      <div style="display: none;" class="gsboxleft"> <span id="pagenumbox">1</span>/<span class="pageallnum">6</span> </div>
      <div class="gsboxright">
        <ul id="guidedBoxBtnList">
          <li><span class="guidestartread">开始浏览新变化</span><span
							id="close_e_1" class="guideiknow" onclick="idPopSave();">我知道了</span> </li>
          <li><span class="guidednext">下一步</span></li>
          <li><span class="guidedpre">上一步</span><span
							class="guidednext">下一步</span></li>
          <li><span class="guidedpre">上一步</span><span
							class="guidednext">下一步</span></li>
          <li><span class="guidedpre">上一步</span><span
							class="guidednext">下一步</span></li>
          <li><span class="guidedpre">上一步</span><span
							class="guidednext">下一步</span></li>
          <li><span class="guidedpre">上一步</span><span id="close_e_2"
							class="guideend" onclick="idPopSave();">完成</span></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="greybox"></div>
  <input id="ViewNewUserWizard" type="hidden">
</div>
<script id="guidedBoxLazyLoadImg" type="text/plain" name="elm">
			<div><img src="http://www.dhresource.com/dhs/mos/image/syi/new/img.jpg" width="698" height="373" /></div><div><img src="http://www.dhresource.com/dhs/mos/image/syi/new/img001.jpg" width="698" height="373" /></div><div><img src="http://www.dhresource.com/dhs/mos/image/syi/new/img002.jpg" width="698" height="373" /></div><div><img src="http://www.dhresource.com/dhs/mos/image/syi/new/img003.jpg" width="698" height="373" /></div><div><img src="http://www.dhresource.com/dhs/mos/image/syi/new/img004.jpg" width="698" height="373" /></div><div><img src="http://www.dhresource.com/dhs/mos/image/syi/new/img005.jpg" width="698" height="373" /></div><div><img src="http://www.dhresource.com/dhs/mos/image/syi/new/img006.jpg" width="698" height="373" /></div>
            </script>
<div style="display: none; position: fixed; z-index: 3001;"
		id="idPop_helpIconShow">
  <table style="width: 373px;" class="noshade-pop-table">
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
                <div class="noshade-pop-title"> <span>温馨提示</span> </div>
                <div class="boxcenter clearfix">
                  <p> 帮助信息已经关闭！<br>
                    如果您需要再次查看帮助，请点击帮助提示图标<img
												class="ver-align-middle marginleft10"
												src="http://www.dhresource.com/dhs/mos/image/syi/new/help.png"> </p>
                  <span class="tourBtn">
                  <input id="idPop_help_close02"
											value="知道了" type="button">
                  </span> </div>
              </div>
              <div class="noshade-pop-bot"></div>
              <a id="idPop_help_close01" class="noshade-pop-close"
									onclick="document.body.onbeforeunload=null;" href="#"></a> </div>
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
</div>
<!-- 代码 结束 -->
