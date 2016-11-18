<#-- 
<script src="/portal/seller/images/product/dc.js" type="text/javascript"></script>
<script src="/portal/seller/images/product/zh-cn.js" type="text/javascript"></script>
<script src="/portal/seller/images/product/codemirror.js" type="text/javascript"></script>
<script src="/portal/seller/images/product/codemirror.js" type="text/javascript"></script>
-->
<script>
	<#if  productFeatureCategoryApplList?has_content>
		var productFeatureCategoryIdList = [];
		var basicFlagValue =""
		<#list productFeatureCategoryApplList as featureCategory>
			productFeatureCategoryIdList.push("${featureCategory.productFeatureCategoryId!''}");
			<#if featureCategory_index==0>
				basicFlagValue+="${featureCategory.productFeatureCategoryId!''}";
			<#else>
				basicFlagValue+="_${featureCategory.productFeatureCategoryId!''}";
			</#if>
		</#list>
		var productFeatureCategoryIdListSize = productFeatureCategoryIdList.length;
		var flagVal = undefined;
		var pfci = undefined;
		var pfi = undefined;
		var idx = undefined;
		var _idx = undefined;
		var idx_ = undefined;
		var _idx_ = undefined;
	</#if>
</script>
<#assign baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()/>
<script src="/portal/seller/images/uploadify/scripts/swfobject.js" type="text/javascript"></script>
<script src="/portal/seller/images/uploadify/scripts/jquery.uploadify.v2.1.0.js" type="text/javascript"></script>
<script src="/portal/images/js/jquery.ui.dialog.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="/portal/seller/images/uploadify/css/uploadify.css"/>
<link rel="stylesheet"  href="/portal/seller/images/product/syi20130506.css" type="text/css"/>
<link rel="stylesheet"  href="/portal/seller/images/product/weddingTemplate.css" type="text/css"/>
<!--<link rel="stylesheet"  href="/portal/seller/images/product/ueditor.css" type="text/css">-->
<link rel="stylesheet"  href="/portal/seller/images/product/codemirror.css" type="text/css"/>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<script src="/portal/seller/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<form id="syi_form" name="syi_form" method="post" onsubmit="validFormFields();" autocomplete="off" action="<#if entity?has_content>updateProductEn<#else>createProductEn</#if>" method="post">
	<#if entity?has_content>
		<input type="hidden" name="productId" id="productId" value="${entity.productId?if_exists}"/>
	</#if>	
	<input type="hidden" name="productTypeId" value="FINISHED_GOOD"/>
	<input type="hidden" name="currencyUomId" value="USD"/>
	<input type='hidden' name='productStoreId' id='productStoreId' value="${productStoreId?if_exists}"/>
	<input type='hidden' name='productTypeCategoryId' value="${productTypeCategoryId}">
	<input type='hidden' name='goodType' id='goodType' value="<#if entity??>${entity.goodType!}<#else>sigleGood</#if>">
	<div id="postMain">
		<div class="postmargin">
			<a name="syiTop" id="syiTop"></a>
	    	<!-- 头文件调用结束 -->
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
				<div class="layer-b-bg">
					<span class="layer-l"></span>
					<span class="layer-r"></span>
					<div class="cat-titleconbox">
		           		<b>当前已选择的产品类目：</b>
		           		<span class="navbox" style="width:500px;">
		   					<#if parentFirstName??>
		   						${parentFirstName}<span style="font-family: Comic Sans MS;color: #000;padding: 0px 6px;">&gt;</span>
		   					</#if>
		   					<#if parentName??>
		   						${parentName}<span style="font-family: Comic Sans MS;color: #000;padding: 0px 6px;">&gt;</span>
							</#if>
		   					<#if categoryName??>
		   						${categoryName}
							</#if>
						</span>
						<a class="marginleft20" href="EditProductEn" >«返回修改类目</a>
			 		</div>
				</div>
			</div>
			<!-- 已选择类目 结束 -->
    
			<!-- 错误信息 开始 -->
			<div id="errorMsgDiv" style="display:none;" class="syi-all-error clearfix">
		    	<div class="syi-all-error-lt"></div>
				<div class="syi-all-error-ri">
					<p class="p1"><b>您还有下述表单项填写不正确，请点击相应链接进行修改。</b></p>
					<ul id="errorUL"></ul>
				</div>
			</div>
    		<!-- 错误信息 结束 -->
	
    		<!-- title产品基本信息 开始 -->
     		<div class="titlebox"><h3>1、产品基本信息</h3></div>
 			<!-- title产品基本信息 结束 -->
	 
      		<!-- 产品标题 开始 -->
      	<!-- 产品标题 开始 -->
    		<div class="mainlayout clearfix" id="productnameTip">
        		<div class="ml-title">
        			<span class="required">*</span>产品标题： 
        		</div>
				<a id="a_productname"></a>
        		<div>
					<input id="internalName" name="internalName" value="<#if entity?has_content>${entity.internalName?if_exists}</#if>"  class="attr-text-input addwid800" maxlength="350" type="text">
					<span id="productnameTip" class="helptips marginleft10">最多可以输入<#-- <b class="color444" id="productNameLengthSpan">0</b><span class="color000">/--><span class="color444">350</span></span>个字符</span></span>
					<span class="helpicon" title="产品标题帮助" helptipval="productnameTip"></span>
				</div>
				<div id="productnameErrTip" class="tip-error" style="display: none;">
					<span>请填写产品标题，最大140个字符</span>
				</div>		
			</div>
			<#--
      		<div class="mainlayout clearfix" id="productnameTip">
        		<div class="ml-title">
        			<span class="required">*</span>产品中文标题： 
        		</div>
				<a id="a_productname"></a>
        		<div>
					<input id="productNameZh" name="productNameZh" value="<#if entity?has_content>${entity.productNameZh?if_exists}</#if>" style=" color: rgb(153, 153, 153);" class="attr-text-input addwid800" maxlength="350" type="text">
					<span id="productnameTip" class="helptips marginleft10">最多可以输入<span class="color444">350</span></span>个字符</span></span>
					<span class="helpicon" title="产品标题帮助" helptipval="productnameTip"></span>
				</div>
				<div id="productnameErrTip" class="tip-error" style="display: none;">
					<span>请填写产品标题，最大140个字符</span>
				</div>
			</div>
    		<div class="mainlayout clearfix" id="productnameTip">
        		<div class="ml-title">
        			<span class="required">*</span>产品俄文标题： 
        		</div>
				<a id="a_productname"></a>
        		<div>
					<input id="productNameRu" name="productNameRu" value="<#if entity?has_content>${entity.productNameRu?if_exists}</#if>" style="ime-mode: disabled; color: rgb(153, 153, 153);" class="attr-text-input addwid800" maxlength="350" type="text">
					<span id="productnameTip" class="helptips marginleft10">最多可以输入<span class="color444">350</span></span>个字符</span></span>
					<span class="helpicon" title="产品标题帮助" helptipval="productnameTip"></span>
				</div>
				<div id="productnameErrTip" class="tip-error" style="display: none;">
					<span>请填写产品标题，最大140个字符</span>
				</div>
			</div>
			-->
			<!-- 产品标题 结束 -->
			<div class="mainlayout clearfix" id="productnameTip">
        		<div class="ml-title">
        			<span class="required">*</span>自定义商品分类： 
        		</div>
				<a id=""></a>
        		<div>
        			<select style='width:100px;'></select>
				</div>
			</div>
			<!-- 产品关键词 开始 -->
			<div class="mainlayout clearfix" id="keywordTip">
				<div class="ml-title">产品关键词：</div>
				<a id="a_keyword1"></a>
				<a id="a_keyword2"></a>
				<a id="a_keyword3"></a>
				<div>
		        	<#if productContentKeyWordList?has_content>
						<#assign productContentKeyWord = productContentKeyWordList[0].getRelatedOne("Content")?if_exists>
					</#if>	
					<input type="hidden"  class="attr-text-input marginright10" style="ime-mode: disabled; color: rgb(153, 153, 153);" maxlength="40" name="keyWordContentId" value="<#if productContentKeyWord??>${productContentKeyWord.contentId?if_exists}</#if>"/>
					<#--class=attr-text-input--><input class="marginright10" maxlength="40" size="60" name="metaKeywords" id="keyword2" value="<#if productContentKeyWord?has_content>${productContentKeyWord.description?if_exists}</#if>"  type="text">
					<#--<input class="attr-text-input marginright10" maxlength="40" name="keyword3" id="keyword3" style="ime-mode:disabled;display: none;" type="text"><span id="keywordbutton" class="tourBtn"><input value="添加多个关键词" onclick="showOtherKeywords();" type="button"></span>-->
					<span class="helpicon" title="产品关键词帮助" helptipval="keywordTip"></span>
				</div>
				<div id="keyword1ErrTip" class="tip-error" style="display:none;"></div>
				<div id="keyword2ErrTip" class="tip-error" style="display:none;"></div>
				<div id="keyword3ErrTip" class="tip-error" style="display:none;"></div>
			</div>
			<!-- 产品关键词 结束 -->
			<!-- 产品基本属性 开始 -->
			<#assign refList = delegator.findByAnd("CategoryRefTypeAttribute", {"productCategoryId" : (entity.productTypeCategoryId)!parameters.productTypeCategoryId}) />
			<div class="mainlayout clearfix" id="keywordTip" style="display:<#if refList?has_content>''<#else>none</#if>">
				<div class="ml-title"><span class="required">*</span>产品基本属性：</div>
				<div>
		        	<span class="helptips">设置完整的产品属性有助于买家更容易找到您的产品</span><span class="helpicon" helptipval="keywordTip"></span>
		        	<div class="product-attributes">
						<#if entity?has_content&&entity.productTypeCategoryId?? || parameters.productTypeCategoryId??>
							<table class="table-property j-attrs-list" id="attribBody">
								<tbody>
									
									<#if entity?has_content&&refList?has_content>
										<#list refList as ref>
											<#assign attr = delegator.findByPrimaryKey("TypeAttribute", {"attributeId" : ref.attributeId}) />
											<tr id="background_tr">
												<!-- <td class="label">${attr.attributeName!}|${attr.attributeZhName!}|${attr.attributeRuName!}：</td> -->
												<td class="label">${attr.attributeName!}：</td>
												<td class="border02 width85">
													<#assign attribs = delegator.findByAnd("ProductTypeAndAttribute", {"attrName" : attr.attributeId,"productId":entity.productId})>
													<#if "SELECT"==attr.entryWay>
														<select	name="attr_${attr.attributeId!}" id="${attr.attributeId!}">
															<option value="">请选择</option>
															<#assign attrOptions = delegator.findByAnd("AttrOptionalValue", {"attributeId" : attr.attributeId})>
	
															<#if attribs?has_content>
																<#list attrOptions as e>
																	<option value="${e.optionalId!}"<#if e.optionalId==attribs[0].attrValue>selected=selected</#if>>${e.optionalName!}</option>
																</#list>
															<#else>
																<#list attrOptions as e>
																	<option value="${e.optionalId!}">${e.optionalName!}</option>
																</#list>
															</#if>
														</select>
													<#elseif "TEXTAREA"==attr.entryWay>
														<textarea name="attr_${attr.attributeId!}" id="${attr.attributeId!}" cols="45" rows="5" maxlength="120" class="textarea01">${attribs[0].attrValue!}</textarea>
													<#else>
														<#if attribs?has_content>
															<input type="text" name="attr_${attr.attributeId!}" maxlength="120" id="${attr.attributeId!}" class="input200" value="${attribs[0].attrValue!}">
														<#else>
															<input type="text" name="attr_${attr.attributeId!}" id="${attr.attributeId!}" class="input200" value="" maxlength="120">
														</#if>
													</#if>
												</td>
											</tr>
										</#list>
									</#if>
								</tbody>
							</table>
						</#if>
					</div>
				</div>
			</div>
			<div id="display_div_brand" style="display:none;">
				<div class="syi-properties-ri syi-rposition" id="div_brand_id" style="display:none;">
					<div class="posionrel clearfix">
				  		<div class="drop-down" id="selectBrandsDiv" onclick="onSelectBrandsClick();">
		                	<span class="drop-down-value text-indent" id="brandNameSpan">- 无品牌 -</span>
		                	<span class="drop-down-default"></span>
		                	<div class="chouse-down-box text-indent" id="brandsDiv" style="display: none;"></div>
		                	<iframe></iframe>
		         		</div>
		  			</div>
				</div>
				<input value="99" name="brandid" id="brandid" type="hidden"/>
				<input value="" name="brandName" id="brandName" type="hidden"/>
			</div>
			<!-- 产品基本属性 结束 -->
			<#if  productFeatureCategoryApplList?has_content>
				<!-- 产品规格 开始 -->
				<div class="mainlayout j-basic-standard-container clearfix">
					<div class="ml-title">
						产品规格： 
					</div>
					<p class="helptips">产品的不同规格，可以设置不同的零售价，并在前台展示给买家</p>
		    		<!-- ----- 产品基本属性结束 -----  -->
					<div class="product-attributes5" id="j-attribute-list" >
		            	<table id="specTable" class="table-bordered"  width='900px'>
							<#list productFeatureCategoryApplList as featureCategory>
								<tr class="j-attr-item" data-id="1009138" data-isother="0" data-defined="1" data-style="3">
									<#assign featureCategoryGeneriv = featureCategory.getRelatedOne("ProductFeatureCategory")?if_exists>
									<#assign productFeatures = featureCategoryGeneriv.getRelated("ProductFeature", Static["org.ofbiz.base.util.UtilMisc"].toList("defaultSequenceNum"))>
									<#assign choseFeatureIds = Static["org.ofbiz.ebiz.product.ProductHelper"].getChoseFeatureIds(delegator,(entity.productId)!,featureCategory.productFeatureCategoryId!)?if_exists >
									<input type=hidden name="specId" value="${featureCategoryGeneriv.productFeatureCategoryId?if_exists}"/>
									<input type=hidden name="n[${featureCategoryGeneriv.productFeatureCategoryId?if_exists}]" value="${featureCategoryGeneriv.description?if_exists}"/>
									<input type=hidden name="t[${featureCategoryGeneriv.productFeatureCategoryId?if_exists}]" value="0"/>
									<td class="bktit">
										<span class="required">*</span>
										${featureCategoryGeneriv.description?if_exists}
										<#if featureCategoryGeneriv.descriptionZh??>|${featureCategoryGeneriv.descriptionZh!}</#if>
										<#if featureCategoryGeneriv.descriptionRu??>|${featureCategoryGeneriv.descriptionRu!}</#if>
										：
									</td>
									<td class="bkcon j-attrList" data-aid="1009138">
										<#list productFeatures as feature>
											<#assign checkVal = false />
											<#list choseFeatureIds![] as cfi>
												<#if cfi==feature.productFeatureId>
													<#assign checkVal = true />
												</#if>
											</#list>
											<label class="cheack-box-pb">
												<input value="${feature.productFeatureId}" name='unKnown' <#if checkVal>checked="checked"</#if> data-text="${feature.description}" onclick="add('${featureCategoryGeneriv.productFeatureCategoryId}','${feature.productFeatureId}','0','${feature.description}','','','${feature.description}',this)" data-etext="White" class="cheack-box-input j-attr-checkbox" type="checkbox">
												<span class="colorbox" style="display:none;"><img src="" height="11" width="11"></span>
												<span class="marginright10">
													${feature.description}
												</span>
											</label>
										</#list>	
									</td>
								</tr>
							</#list>
							<tr>
								<td colspan='2'>
									<span class="tourBtn">
									<#if entity??>
										<input value="添加子商品" id='btn_featureadd' type="button">
									<#else>
										<input value="生成子商品" id='btn_feature' onclick='changeFeatrueValues()' type="button">
									</#if>
									</span>
								</td>
							</tr>
						</table>
						<#if entity??>
			            	<#if specValueList??>
			            		<div style='overflow: auto;'>
			            		<table border="0" wdith='90%' cellpadding="0" cellspacing="0" class="table-bordered">
									<tbody id="specsHead">
										<tr class="title02">
											<#-- 
											<td class="border07 width15">货号</td>
											-->
											<#assign productFeatureCategoryId = "">
											<#list specValueList as spec>
												<#if productFeatureCategoryId != spec.productFeatureCategoryId>
													<input type="hidden" name="specId" value="${spec.productFeatureCategoryId!}"/><#rt>
													<input type="hidden" name="st[${spec.productFeatureCategoryId!}]" value="${spec_index}"/><#rt>
													<td class="border07">
														<#assign pfcGv = spec.getRelatedOne("ProductFeatureCategory")>
														${pfcGv.description!} 
													</td>
												</#if>
												<#assign valId=spec.productFeatureId><#rt>
												<input type="hidden" name="valId_${spec.productFeatureCategoryId!}_${spec_index}" value='${valId!}'/>
												<input type="hidden" name="valId[${spec.productFeatureCategoryId!}]" value='${valId!}'/>
												<input type="hidden" name="sv[${valId!}][val]" id="sv[${valId!}][val]" value='${spec.description!}'/>
												<input type="hidden" name="sv[${valId!}][img]" value='123'/>
												<input type="hidden" name="sv[${valId!}][ord]" value='10'/>
												<input type="hidden" name="sv[${valId!}][relaImg]" value='1'/>
												<#assign productFeatureCategoryId = spec.productFeatureCategoryId>
											</#list>
											<td class="border07 width20">美元</td>
											<td class="border07 width10">人民币</td>
											<td class="border07 width10">卢布</td>
											<td class="border07 width5">库存</td>
											<td class="border07 width5">图片</td>
											<#--
											<td class="border06 width5">操作</td>
											-->
										</tr>
									</tbody>
									<tbody id="specsBody">
										<#if entity?has_content>
											<#assign assocToProducts = Static["org.ofbiz.entity.util.EntityUtil"].filterByDate(delegator.findByAnd("ProductAssoc",{'productId':entity.productId,'productAssocTypeId':'PRODUCT_VARIANT'}, Static["org.ofbiz.base.util.UtilMisc"].toList("sequenceNum ASC"))?if_exists) />
										</#if>
										<#if assocToProducts??><#rt>
											<#list assocToProducts as comm><#rt>
												<#assign rid=comm_index+1 />
												<#assign commId="${comm.productIdTo}" /><#rt>
												<#assign p = delegator.findByPrimaryKey("Product",Static["org.ofbiz.base.util.UtilMisc"].toMap("productId",comm.productIdTo))>
												<tr name="flagIdList${rid!}">
													<input type="hidden" name="rid" value="${rid}" />
													<input type="hidden" name="vvv[${rid}][cid]" value="${commId!}" /><!--productId-->
													<input type="hidden" id="flagIdList${rid!}" name="flagIdList"/>
													<#--
													<td class="border07">
														<input type="text"	name="sp_goodsNo_${rid}" readonly="true" class="input100" value="${p.goodsNo?if_exists}" maxlength="20"  size="5"/>
													</td>
													-->
													<#assign pSpecFeatures = Static["org.ofbiz.entity.util.EntityUtil"].filterByDate(delegator.findByAnd("ProductFeatureAndAppl",{'productId':comm.productIdTo}, Static["org.ofbiz.base.util.UtilMisc"].toList("productFeatureCategoryId"))?if_exists) />
												   	<#if pSpecFeatures?has_content>
														<#list pSpecFeatures as specFeature>
															<#assign specId="${specFeature.productFeatureCategoryId!}" />
															<td class="border07" specId="${specId!}">
																<input onclick="showSpecValuesLay(this,${rid},'u',${specId!"null"},${specFeature.productFeatureId!"null"})" type="text" name="v[${rid}][spec${specId!}]"  readonly class="specTxt" value="${specFeature.description!}" title="${specFeature.description!}" size="5"/>
																<input type="hidden" name="vvv[${rid}][valId${specId!}]" id="v[${rid}][valId${specId!}]" value="${specFeature.productFeatureId!}" />
															</td>
														</#list>
													</#if>
													
													<#assign priceList = Static["org.ofbiz.entity.util.EntityUtil"].filterByDate(delegator.findByAnd("ProductPrice",{'productId':comm.productIdTo,'productPriceTypeId':'DEFAULT_PRICE'}, Static["org.ofbiz.base.util.UtilMisc"].toList("fromDate"))?if_exists) />
													<#if priceList?has_content>	
													  	<#assign usdPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"USD"})?if_exists  />
													  	<#assign cnyPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"CNY"})?if_exists  />
													  	<#assign rurPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"RUR"})?if_exists  />
													</#if>	
													<#assign result = dispatcher.runSync("getProductInventoryAvailable", Static["org.ofbiz.base.util.UtilMisc"].toMap("productId", comm.productIdTo))/>
													<!-- 子商品多币种价格 -->
													<td class="border07">
														<input type="text" name="sp_price_${rid}" value="<#if usdPrice?has_content>${usdPrice[0].price}</#if>" class="currency input40" maxlength="10" size="5"/>
													</td>
													<td>
														<input type="text" name="sp_ZhPrice_${rid}" value="<#if cnyPrice?has_content>${cnyPrice[0].price}</#if>" class="currency input40" maxlength="10" size="5"/>
													</td>
													<td>
														<input type="text" name="sp_RuPrice_${rid}" value="<#if rurPrice?has_content>${rurPrice[0].price}</#if>" class="currency input40" maxlength="10" size="5"/>
													</td>
													<td class="border07"><input type=text name="orderNum_${rid}"  readonly class=input40 value="<#if result??>${result.availableToPromiseTotal?if_exists}</#if>" maxlength="8"  size="5"/>
													</td>
													<td><input type="hidden" name="imgUrl_${rid}"  id="imgUrl_${rid}"><input  type="file" onchange="fileImport('imgPath_${rid}')"  name="imgPath_${rid}"  id="imgPath_${rid}" />
													<img src="${p.smallImageUrl!}" id="logoPhoto_${rid}" width='30px' height='30px'></td>
													<#-->
													<td class="border06">
														<input name="input3" type="button"	class="input02" value="删除" onclick="delComm(this,${rid})" />
													</td>-->
												</tr>
												<#if pSpecFeatures?has_content>
													<script>
														$("#flagIdList${rid}").val(basicFlagValue);
														flagVal = undefined;
														flagVal = $("#flagIdList${rid}").val();
														<#list pSpecFeatures as specFeature>
															pfci = "${specFeature.productFeatureCategoryId!}";
															pfi = "${specFeature.productFeatureId!}";
															idx = flagVal.indexOf(pfci);
															_idx = flagVal.indexOf("_"+pfci);
															idx_ = flagVal.indexOf(pfci+"_");
															_idx_ = flagVal.indexOf("_"+pfci+"_");
	
															if(pfci && pfci!="" && pfi && pfi!="" && idx!=-1){ 
																if(productFeatureCategoryIdListSize && productFeatureCategoryIdListSize>1){
																	if(idx==0){
																		if(idx_==0)flagVal = "@"+pfi+flagVal.substring(pfci.length);
																	}else if(_idx!=-1){
																		if(flagVal.substring(idx)==pfci){
																			flagVal = flagVal.substring(0,idx)+"@"+pfi;
																		}else if(_idx_!=-1){
																			flagVal = flagVal.substring(0,idx)+"@"+pfi+flagVal.substring(idx+pfci.length);
																		}
																	}
																}else{
																	if(idx==0)aa = "@"+pfi;
																}
															}
														</#list>
														$("#flagIdList${rid}").val(flagVal);
													</script>
												</#if>
											</#list>
										</#if>
									</tbody>
								</table>
							</#if>
							<div style='display:none'>
				            	<#if productFeatureCategoryApplList??>
				            		<#list productFeatureCategoryApplList as featureCategory>
				            			<table>
							       	  		<tbody id="specBody${featureCategory.productFeatureCategoryId}">
							       	  			<#--
													add('${featureCategoryGeneriv.productFeatureCategoryId}','${feature.productFeatureId}','0','${feature.description}','','','${feature.description}')
							       	  				add(id, vid, type, value, image, pdtImgs,sysVal)
							       	  				elmId='val'+vid;
						       	  				-->
							       	  			<#assign choseFeatureValues = Static["org.ofbiz.ebiz.product.ProductHelper"].getChoseFeatureValues(delegator,(entity.productId)!,featureCategory.productFeatureCategoryId!)?if_exists />
												<#if choseFeatureValues?? && choseFeatureValues?size&gt;0>
													<#list choseFeatureValues as feature>
														<tr id="tr_${featureCategory.productFeatureCategoryId}_${feature.productFeatureId}">
															<td class="border06">
																<input type=hidden id='val${feature.productFeatureId}' name="v[${featureCategory.productFeatureCategoryId}]" value="${feature.productFeatureId}"/>
																<input name="d[${feature.productFeatureId}][sysVal]" type="text" value="${feature.description}" class="input40" readonly=readonly />
															</td>
											            	<td class="border07" style="display:none;">
											            		<input name="d[${feature.productFeatureId}][v]" type="hidden" value="${feature.description}" class="input40" />
										            		</td>
											            	<td class="border07">
											            		<img src="/portal/seller/images/up.png" alt="向上" onclick="up(this)"/>
											            		<img src="/portal/seller/images/down.png" alt="向下" onclick="down(this)"/>
											            		<img src="/portal/seller/images/delete.gif" alt="删除该规格" onclick="del(this,'${feature.productFeatureId}');"/>
										            		</td>
											            </tr>
													</#list>
												</#if>
							       	  		</tbody>
				    					</table>
				    				</#list>	
				    			</#if>	
							</div>
						<#else>
							<div style='display:none'>
				            	<#if productFeatureCategoryApplList??>
				            		<#list productFeatureCategoryApplList as featureCategory>
				            			<table>
							       	  		<tbody id="specBody${featureCategory.productFeatureCategoryId}"></tbody>
				    					</table>
				    				</#list>	
				    			</#if>	
							</div>
						</#if>
						<div>
							<table class="table-property j-sale-attrs-list"></table>
						</div>
						<!-- 规格列表 wangyg -->
						<div id="specsDiv" style="overflow:auto;">
			            	<table  border="0" cellpadding="0" cellspacing="0" width='600px' class="table-bordered">
		            			<tbody id="specsHead">
		            			</tbody>
		            			<tbody id="specsBody">
		            			</tbody>
			            	</table>
						</div>
						<#--<div id="div_self_defind_attr" class="j-list-item"><table class="table-property"><tbody><tr><td class="bktit addborderline">自定义规格</td><td class="bkcon addborderline"></td></tr><tr><td class="bktit"></td><td class="bkcon addpadtop j-attrList" data-aid="9999"><table class="edit-properties j-cattr-box" style=""><thead><tr><th>自定义规格名称</th><th>自定义图片（JPG格式，≤200K，可不添加）</th><th></th></tr></thead><tbody class="j-customAttr-box"></tbody></table><p class="marginbottom5 clearfix"><a href="#" class="addmoreprop j-addCustomAttr"><span></span>增加自定义规格</a></p></td></tr></tbody></table><div style="display:none" class="tip-error" id="msgdiv_9999" data-anchor="div_self_defind_attr" data-id="tips-saletype" data-name="自定义规格">您选取的图片中有大于200K的图片</div></div>-->
		  			</div>
	  			</div>
  			</#if>
  			</div>
			<!-- 产品规格 结束 -->
			
	 		<!-- 属性图片上传入口参数   -->
			<input id="functionname_avim" name="functionname_avim" value="avim" type="hidden"><!--功能名   	不可以为空-->
			<input id="imagebannername_avim" name="imagebannername_avim" value="" type="hidden">	<!--水印名  现在是用户名-->
			<!-- 产品基本属性 结束 -->
			<!-- title产品销售信息开始 -->
			<!-- title产品包装信息 开始 -->
			<div class="titlebox" id="a_productprice"><h3>2、产品销售信息</h3></div>
	     	﻿<input name="noSpecWholeSaleIncome" value="" type="hidden">
			<input id="catePubDiscount" value="" type="hidden">
			<input name="cateMinPrice" id="cateMinPrice" value="0.01" type="hidden">
			<input name="noSpecPrice" id="noSpecPrice" type="hidden">
			<!-- title产品包装信息 结束 -->
			<a id="tips-sale-foot"></a>
			<div class="j-sale-container">
	    		<a id="a_saleinfo"></a>
				<!-- 销售计量单位 开始 -->
				<div class="mainlayout clearfix j-list-item j-help" data-helpid="saleUnit">
					<div class="ml-title"><span class="required">*</span>销售计量单位：</div>
					<a id="a_measureid"></a>
					<select name="quantityUomId" id="quantityUomId">
						<option value="">请选择数量单位</option>
						<#-- 
						<#list quantityUomList as uom>
						-->
							<option <#if entity?has_content && entity.quantityUomId?has_content &&  entity.quantityUomId =='OTH_piece'>selected=selected</#if> value="OTH_piece">每件</option><#--${uiLabelMap[uom.uomId]} -->
						    <option <#if entity?has_content && entity.quantityUomId?has_content &&  entity.quantityUomId =='OTH_set'>selected=selected</#if> value="OTH_set">每套</option>
						<#-- 
						</#list>
						-->
					</select>
					示例：12美元/<span class="j-unit-no" name="sortbyunit">件</span>
	        		<span class="helpicon" title="销售计量单位帮助" data-helpid="saleUnit"></span>
	        		<input id="measurename" value="件" type="hidden">
	        		<div data-anchor="j-saleBox" data-id="tips-unit" class="tip-error" style="display:none;" data-name="销售计量单位"></div>
	    		</div>
	    		<!-- 销售计量单位 结束 -->
		
	    		<!-- 销售方式 开始 -->
				<#--<div class="mainlayout clearfix j-list-item j-help" data-helpid="saleType"><div class="ml-title"><span class="required">*</span>销售方式：</div><div class="marginbottom10 clearfix"><label><input name="sortby" id="sortbyradio1" data-name="件" checked="checked" value="1" type="radio"><span class="marginleft5 marginright10"><label for="gg">按件卖</label>（单位：<span class="j-unit-no" name="sortbyunit">件</span>）</span></label></div><div class="marginbottom10 clearfix"><label><input name="sortby" id="sortbyradio2" data-name="包" value="2" type="radio"><span class="marginleft5">按包卖</span></label><span><span class="j-sale-bao" style="display: none; ">                （每包产品的数量：<input id="packquantity" name="packquantity" value="1" class="input2" size="6" maxlength="8" type="text"><span class="j-unit-no" name="sortbyunit">件</span>）</span></span><span class="helpicon" title="销售方式帮助" data-helpid="saleType"></span></div><div style="display:none" class="tip-error" data-anchor="j-saleBox" data-id="tips-packquantity" data-name="销售方式"><p></p></div></div>    -->
				<!-- 销售方式 结束 -->
				
				<!-- 库存状态 开始 -->
				<#--<div class="mainlayout clearfix j-list-item"><div class="ml-title"><span class="required">*</span>备货状态：</div><div class="marginbottom10 clearfix j-moreinstock-container"><label><input name="inventoryStatus" checked="checked" value="1" type="radio"><span class="marginleft5 marginright10">有备货，备货所在地</span></label><span><span data-code="CN" class="j-item"><select id="inventoryLocation" name="inventoryLocation" class="syi-select5"><option title="中国" value="CN" selected="selected">中国</option><option title="津巴布韦" value="ZW">津巴布韦</option></select><a href="javascript:;" class="marginright10 j-act-remove" style="display:none;">删除</a></span><a href="javascript:;" class="add-address j-act-attach">增加备货地</a></span><span class="helptips">（有现货，可立即发货，备货期不大于两天）</span><div class="tip-error j-error-tip" style="display:none;"></div></div><div class="marginbottom10 clearfix"><label><input name="inventoryStatus" value="0" type="radio"><span class="marginleft5">待备货，客户一次最大购买数量为</span></label><span class="j-nostock-label"><input disabled="disabled" data-helpid="maxSaleQty" class="attr-text-input addwid60 margindoublev5 j-help" name="maxSaleQty" value="10000" type="text"><span class="j-unit">件</span><span class="helptips">（暂无现货需采购）</span></span><span data-helpid="stockHelp" title="产品备货帮助" class="helpicon"></span></div><div style="display:none" class="tip-error" data-id="tips-maxSaleQty" data-anchor="j-saleBox" data-name="库存状态"><p></p></div></div>-->
				<!-- 库存状态 结束 -->
			
				<!-- 备货数量 开始 -->
				<div class="mainlayout clearfix j-list-item j-stock-input">
					<div class="ml-title"><span class="required">*</span>备货数量：</div>
					<div class="clearfix">
			        	<input class="attr-text-input addwid60 j-sale-inventory" name="inventory" <#if entity??>readonly</#if> value="<#if entity??&&resultQohTotal??>${resultQohTotal.availableToPromiseTotal!}</#if>" type="text" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}">
			        	<#--<span class="marginleft5 marginright20 j-unit">件</span>-->
					</div>
					
					
					<div style="display:none" class="tip-error" data-id="j-saleBox" data-anchor="j-saleBox" data-name="库存数量">
						<p></p>
					</div>
				</div>
				<div class="mainlayout clearfix j-list-item j-stock-input">
					<div class="ml-title"><span class="">*</span>是否参与导购：</div>
					<div class="clearfix">
						<select><option>是</option><option>否</option></select>
						
						<span class=""></span>导购佣金：<input  name="yongjin"  type="text" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}">
					</div>
				</div>	
				<div class="mainlayout clearfix j-list-item j-stock-input">
				<div class="ml-title"><span class="required">*</span>是否参与分销：</div>
					<div class="clearfix">
						<select><option>是</option><option>否</option></select>
						
			        	<input type='hidden' value='RUR'>最低售价
			        	<input class="attr-text-input addwid140 j-help"  name="price444" value="<#if rurPrice??>${(rurPrice[0].price)!}</#if>" type="text" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}">
			        	<input type='hidden'>最高售价
			        	<input class="attr-text-input addwid140 j-help"  name="pric555" value="<#if usdPrice??>${usdPrice[0].price!}</#if>" type="text" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}">
					</div>
				</div>	
				<!-- 备货数量 结束 -->
				<!-- 备货期 开始 -->
				<#--<div class="mainlayout clearfix j-list-item"><div class="ml-title"><span class="required">*</span>备货期：</div><div class="clearfix"><div><span class="j-set-unifyperiod-container" style="display:none;"><input checked="checked" class="j-set-unifyperiod" name="isLeadingtime" type="checkbox">统一设置备货期</span><input name="proLeadingtime" data-helpid="proLeading" class="attr-text-input addwid60 marginright5 j-help" value="2" type="text">天<span class="helptips marginleft20 j-leadingtime-tip">有备货的产品备货期小于等于2天</span></div><div style="display:none" class="tip-error" data-id="tips-leadingtime" data-anchor="tips-sale-foot" data-name="备货期"><p></p></div></div></div>    -->
    			<!-- 备货期 结束 -->
				<#--<div style="display: none;" class="mainlayout clearfix j-stock-box j-list-item"><div class="ml-title">备货总量：</div><div class="clearfix"><div><b class="color009b02 j-stock-totalnum">0</b><span class="j-unit">件</span><span class="helptips marginleft20">产品备货数量的总和</span></div><div data-name="库存总量" data-anchor="tips-sale-foot" data-id="tips-stockNum" class="tip-error" style="display:none"><p></p></div></div></div>-->

    			<!-- 产品价格 开始 -->
    			<#--<div id="tips-sale" class="mainlayout clearfix" style="position:relative;"><div class="ml-title"><span class="required">*</span>产品价格区间：</div><div><div class="helptips"><span class="j-price-tipstxt">您可以最多添加4个价格区间<span class="colorF60"><span class="tipstion"><span class="commission"></span><div class="tiparrow-posbox" style="display: none;top:-40px;"><div class="tiparrow-box"></div></div></span>阶梯佣金计算公式</span></span><span class="helpicon" title="阶梯佣金计算公式帮助" data-helpid="expressions"></span></div></div>   <div style="display: none;" class="marginbottom10 clearfix j-price-typeList">   <label><input value="2" checked="checked" name="setdiscounttype" type="radio"><span class="marginleft5 ver-align-middle marginright20">统一设置价格</span></label>   <label><input value="1" name="setdiscounttype" type="radio"><span class="marginleft5 ver-align-middle">分别设置价格</span></label>   </div>       -->
	        	<!-- 统一设置价格区域-->
	          	<div class="j-list-item j-sectionA-box" style="display:none">
	              	<div class="setwhoprice setshow marginbottom10">
	                  	<div class="ladderprice">
	                      	<div class="j-section-list">
	                      		<p class="j-item">
	                      			<input value="1" class="attr-text-input addwid50 margindoublev5 j-section-stock" type="text">
	                      			<span class="marginright20"><span class="j-unit">件</span>以上</span>
	                      			实际收入：US$      
									<input class="attr-text-input addwid50 margindoublev5 j-section-price" type="text">
	                       			<span class="marginright20">/<span class="j-unit">件</span></span>
	                       			买家价格： US$<span class="j-section-salePrice"></span>
	                       			<a href="#" class="j-section-del" style="display: none;">删除</a>
	                   			</p>
	               			</div>
	                      	<p><a href="#" class="addmoreprop j-section-add"><span></span>增加区间</a></p>
	                  	</div>
	              	</div>
	              	<div class="tip-error j-tip-error" style="display:none;"></div>
	          	</div>
	          	<!-- sku 绘制区域-->
	          	<div style="display: none;" id="skuDiv" class="j-sku-container">
	              	<div style="display: none;" class="rtab-warp syi-rtab j-sku-tab">
						<b class="prev j-tab-prev" style="display:none;"><a href="#"></a></b>
						<div style="width: 700px; overflow: hidden; float: left;" class="j-sku-tab-move">
		                  	<div style="width:2000px">
		                    	<ul style="margin-left: 1px;" class="j-sku-tab-list"><li class="j-item current" data-code="CN"><a href="javascript:;"><span class="j-span-name">中国</span></a></li></ul>
		                  	</div>
						</div>
						<b class="next j-tab-next" style="display:none;"><a href="#"></a></b>
					</div>
					<div class="j-sku-list">
						<div style="display: block;" class="marginbottom10 stocking-inf-box clearfix j-item" data-code="CN" data-name="中国">
			            	<table>
			            		<thead>
			            			<tr>
				            			<th style="display: none;" class="j-status">销售状态</th>
				            			<th style="display: none;" class="j-income">
				            				<span class="required">*</span>
				            				实际收入
				            				<span data-helpid="skuPrice" title="销售价格帮助" class="helpicon"></span>
				            				<div style="display: none;" class="clearfix j-batch-container">
				            					<input class="attr-text-input addwid30 marginright5 j-input-batch-income" type="text">
				            					<span class="tourBtn j-btn-batch-income"><input value="批量设置" type="button"></span>
			            					</div>
		            					</th>
				            			<th style="display: none;" class="j-price">买家价格</th><th class="j-stock"><span class="required">*</span>备货数量<span data-helpid="stockNum" title="备货数量帮助" class="helpicon"></span><div style="display: none;" class="clearfix j-batch-container"><input class="attr-text-input addwid30 marginright5 j-input-batch-stock" type="text"><span class="tourBtn j-btn-batch-stock"><input value="批量设置" type="button"></span></div></th>
				            			<th style="display: none;" class="j-period"><span class="required">*</span>备货期<div style="display: none;" class="clearfix j-batch-container"><input class="attr-text-input addwid30 marginright5 j-input-batch-period" type="text"><span class="tourBtn j-btn-batch-period"><input value="批量设置" type="button"></span></div></th>
				            			<th class="j-productcode">商品编码<span data-helpid="skuCode" title="商品编码帮助" class="helpicon"></span></th>
			            			</tr>
			            		</thead>
			            		<tbody id="specsBody">
			            			<tr class="j-line" data-id="noSku">
			            				<td style="display: none;" class="j-status">
			            					<select class="attr-select addwid70 j-select-status">
			            						<option value="1" selected="selected">可销售</option>
			            						<option value="0">不可销售</option>
			        						</select>
			    						</td>
			    						<td style="display: none;" class="j-income">
			    							US $<input class="attr-text-input addwid50 colornamebox j-input-income" type="text">
			    							<span class="j-span-income" style="display:none;"></span>/<span class="j-unit">件</span>
										</td>
										<td style="display: none;" class="j-price">
											<div class="j-div-price"></div>
										</td>
										<td class="j-stock">
											<input class="attr-text-input addwid60 colornamebox j-input-stock" type="text">/<span class="j-unit">件</span>
										</td>
										<td style="display: none;" class="j-period">
											<input style="" class="attr-text-input addwid60 colornamebox j-input-period" value="2" type="text"><span style="display: none;" class="j-span-period">2</span>天
										</td>
										<td class="j-productcode">
											<input class="attr-text-input addwid140 colornamebox j-input-productcode" type="text">
										</td>
									</tr>
			            		</tbody>
			        		</table>
			    		</div>
					</div>
				</div>
	  	
	          	<!-- 分别设置价格区域-->
	          	<div class="j-list-item j-sectionB-box" style="display:none;">
	              	<div class="setwhoprice setshow marginbottom10">
	                  	<div class="ladderprice padbottom10">
	                      	<a class="fltrig j-price-previewBtn" href="#">价格预览</a>
	                      	<span class="required">*</span>设置产品的价格区间
	                  	</div>
	                  	<div class="ladderprice">
	                      	<div class="j-section-list">
	                      	<p class="j-item">购买<input value="1" class="attr-text-input addwid50 margindoublev5 j-section-stock" type="text"><span class="j-unit">件</span>及以上时，为表格中填写的实际收入。</p>
	                  	</div>
						<p><a class="addmoreprop j-section-add" href="#"><span></span>添加批发区间</a></p>
	              	</div>
				</div>
				<div class="tip-error j-tip-error" style="display:none;"></div>
			</div>
			<!-- 产品价格 结束 -->
			<#if productFeatureCategoryApplList??>
				<div class="mainlayout clearfix j-goodcode-box j-list-item">
					<div class="ml-title">价格：</div>
					<div class="clearfix">
			        	<#if priceList?has_content>	
						  	<#assign usdPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"USD"})?if_exists  />
						  	<#assign cnyPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"CNY"})?if_exists  />
						  	<#assign rurPrice = Static["org.ofbiz.entity.util.EntityUtil"].filterByAnd(priceList,{"currencyUomId":"RUR"})?if_exists  />
						</#if>
						成本价<input type='hidden' name='currencyUomId_1' value='CNY'>
			        	<input class="attr-text-input addwid140 j-help"  name="price_1" value="<#if cnyPrice??>${(cnyPrice[0].price)!}</#if>" type="text" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}">
			        	<span class="required">*</span>
			        	供货价
			        	<input class="attr-text-input addwid140 j-help"  name="price22" value="<#if cnyPrice??>${(cnyPrice[0].price)!}</#if>" type="text" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}">
					</div>
				</div>
			</#if>
			<!-- 商品编码 开始 -->
			<#-- 
			<div class="mainlayout clearfix j-goodcode-box j-list-item">
				<div class="ml-title">商品编码：</div>
				<div class="clearfix">
					<input class="attr-text-input addwid140 j-help" data-helpid="skuCode" name="goodsNo" value="<#if entity??>${entity.goodsNo!}</#if>"  type="text">
					<div style="display:none" class="tip-error" data-id="tips-skucode" data-anchor="tips-sale-foot" data-name="商品编码">
						<p></p>
					</div>
				</div>
			</div>
			-->
			</div>
			<!-- 商品编码 结束 -->
			
			<!-- title产品销售信息 结束 -->
			<!-- title产品销售信息 结束 -->
			     
			<!-- title产品内容描述 开始 -->
			<div class="titlebox"><h3>3、产品内容描述</h3></div>
			
			<!-- 产品图片 开始 -->
			<!-- 产品图片 开始 -->
			<div class="mainlayout clearfix">
				<div class="ml-title"><span class="required">*</span>产品图片：</div>
				<script type="text/javascript">
			  		var imgId=1;
			  		var check='checked';
			  		$(document).ready(function(){	
						$("#uploadify").uploadify({
			    			'uploader':'/portal/seller/images/uploadify/scripts/uploadify.swf',
							'cancelImg':'/portal/seller/images/uploadify/cancel.png',
							'script':'<@ofbizUrl>uploadProductImage</@ofbizUrl>',
							'folder': 'UploadFile',
							'queueID': 'fileQueue',
							'auto': true,
							'multi': true,
							'onComplete': function(event,queueId,fileObj,response,data){
								var filePath = jQuery.parseJSON(response).filePath;
			   					//var imgId=$('#imagePreview input:last[name="imgId"]').val();
			   					//imgId=imgId?parseInt(imgId)+1:1;
			   					var h='';
			   					if(imgId!=1)check='';
			   					h+='<table width=100 border=0 cellspacing=0 cellpadding=0 style=\'float:left;margin-right:15px;margin-top:15px;\'>';
			   					h+='<input type=hidden name=imgId value="'+imgId+'"/>';
			   					h+='<input type=hidden name=[new]'+imgId+' value="1"/>';		       
			   					h+='<input type=hidden name=[path]'+imgId+' value="'+filePath+'"/>';
			   					h+='<tr>';
			   					h+='<td colspan=2 align=left><div style="display:block;height:120px;width:120px;border:1px solid #ccc;text-align:center;"><img border=0 align=absmiddle src="'+filePath+'" onload="resizeImg(120,120,this);" onclick="window.open(\''+filePath+'\')" style=\' cursor: pointer\'/></div></td>';
			   					h+='</tr>';
			   					h+='<tr>';
			   					h+='<td width=27% height=25><a href=# onclick="deleteFile(this,\'new\',\''+filePath+'\')">删除</a>';
			   					h+='<input type=radio name=listImg id=radio3 value='+imgId+' '+check+' />';
			   					h+='         是否主图</td>';
			   					h+='</tr>';
			   					//h+='<tr>';
			   					//h+='<td height=26 colspan=2><p>';
			   					//h+='<input name=[imgalt]'+imgId+' type=text class=textInput value=添加图片说明 onclick="if(this.value==\'添加图片说明\')this.value=\'\'" onblur="if(this.value==\'\')this.value=\'添加图片说明\'"/>';
			   					//h+='</p></td>';
			   					//h+='</tr>';
			   					h+='<tr>';
			   					h+='<td height=26 colspan=2><p>';
			   					h+='<input name=[imgseq]'+imgId+' type=text class=textInput value=1 onclick="if(this.value==\'1\')this.value=\'\'" onblur="if(this.value==\'\')this.value=\'1\'"/>';
			   					h+='</p></td>';
			   					h+='</tr>';
			   					h+='</table>';
			  					$('#imagePreview').append(h);
			  					imgId++;
							},
			            	'onUploadSuccess': 'myUplaodifyComplete',
							'fileQueue': 'fileQueue',
							'fileExt': '*.jpg;*.jpeg;*.gif;*.png;',
							'fileDesc': '*.jpg;*.jpeg;*.gif;*.png;'
						});
			    	});  
					function resizeImg(pWidth,pHeight,thisObj){
						var img = new Image();
						img.src = thisObj.src;
						var Ratio = 1;
						var w = img.width;
						var h = img.height;
						var wRatio = pWidth / w;
						var hRatio = pHeight / h;
						Ratio = wRatio>hRatio?hRatio:wRatio;
						if (Ratio<1){
							w = w * Ratio;
							h = h * Ratio;
						}
						thisObj.height = h;
						thisObj.width = w;
					}
			
					function myUplaodifyComplete(event,queueId,fileObj,response,data){  
					   	var filePath = jQuery.parseJSON(response).filePath;
					   	//var imgId=$('#imagePreview input:last[name="imgId"]').val();
					   	//imgId=imgId?parseInt(imgId)+1:1;
					   	var h='';
					   	h+='<table width=100 border=0 cellspacing=0 cellpadding=0>';
					   	h+='<input type=hidden name=imgId value="'+imgId+'"/>';
					   	h+='<input type=hidden name=[new]'+imgId+' value="1"/>';		       
					   	h+='<input type=hidden name=[path]'+imgId+' value="'+filePath+'"/>';
					   	h+='<tr>';
					   	h+='<td colspan=2 align=left><div style="display:block;height:120px;width:120px;border:1px solid #ccc;text-align:center;"><img border=0 align=absmiddle src="'+filePath+'" onload="resizeImg(120,120,this);" onclick="window.open(\''+filePath+'\')" style=\' cursor: pointer\'/></div></td>';
					   	h+='</tr>';
					   	h+='<tr>';
					   	h+='<td width=27% height=25><a href=# onclick="deleteFile(this,\'new\',\''+filePath+'\')">删除</a>';
					   	h+='<input type=radio name=listImg id=radio3 value='+imgId+' />';
					   	h+='         生成列表图</td>';
					   	h+='</tr>';
					   	//h+='<tr>';
					   	//h+='<td height=26 colspan=2><p>';
					   	//h+='<input name=[imgalt]'+imgId+' type=text class=textInput value=添加图片说明 onclick="if(this.value==\'添加图片说明\')this.value=\'\'" onblur="if(this.value==\'\')this.value=\'添加图片说明\'"/>';
					   	//h+='</p></td>';
					   	//h+='</tr>';
					   	h+='<tr>';
					   	h+='<td height=26 colspan=2><p>';
					   	h+='<input name=[imgseq]'+imgId+' type=text class=textInput value=1 onclick="if(this.value==\'1\')this.value=\'\'" onblur="if(this.value==\'\')this.value=\'1\'"/>';
					   	h+='</p></td>';
					   	h+='</tr>';
					   	h+='</table>';
					  	$('#imagePreview').append(h);
					  	imgId++;
					}
					//删除文件
					window.deleteFile=function(elm, flag ,path){
						if(path && confirm('产品图片删除后将不能恢复，是否确认删除该图片?')){
				 			if(flag != 'new'){
					 			jQuery.ajax({
							        url: "deleteProductContentImage",
							        type: 'POST',
							        data: {contentId : flag<#if entity?has_content>,productId : '${entity.productId?if_exists}'</#if>},
							        error: function(msg) {
							            showErrorAlert("删除失败 : " + msg);
							        },
							        success: function(msg) {
							        }
							    });
					 		}
							$(elm).parents('table:first').remove();
						}
					};
				</script>
				<div>
					<div id="fileQueue" class="fileQueue"></div><#-- style="margin:0; height:0;" -->
					<input type="file" name="uploadify" id="uploadify" />
				</div>
				<div id="imagePreview" class="shopping_img">
					<#if productContentList?has_content>
						<#list productContentList as productContent>
							<#-- content purpose contentPurposeTypeId="EB_PROD_INFO" show -->
							<#--assign content = productContent.getRelatedOne("Content")?if_exists>
							<#if content?has_content>
							<assign contentPurpose = delegator.findByAnd("ContentPurpose",{'contentId':content.contentId,'contentPurposeTypeId':'EB_PROD_INFO'})?if_exists />
							<#if contentPurpose?has_content-->
							<table width="100" border="0" cellspacing="0" cellpadding="0" style="float:left;margin-right:15px;margin-top:15px;">
								<input type=hidden name=imgId value="${productContent_index}" />
								<input type=hidden name='[old]${productContent_index}' value="${productContent.contentId}"/>
								<input type=hidden name=[path]${productContent_index} value="${productContent.contentName?if_exists}" />
								<tr>
									<td colspan="2" align="left">
										<div style="display: block; visibility: visible; height: 120px;width:120px; border: 1px solid rgb(204, 204, 204);text-align:center;">
											<img border=0 src="${productContent.contentName?if_exists}"  onload="resizeImg(120,120,this);" onclick="window.open('${productContent.contentName?if_exists}')" width="120px" height="120px" style=" cursor: pointer" align=absmiddle />
										</div>
									</td>
								</tr>
								<tr>
									<td width="27%" height="25" colspan="2">
										<a href="#" onclick="deleteFile(this,'${productContent.contentId?if_exists}','${productContent.contentName?if_exists}')">删除</a>
										<input type=radio name=listImg id=radio3<#if productContent.extendFlag?has_content && productContent.extendFlag=='Y'>checked</#if> value='${productContent_index}'/>是否生成主图
									</td>
								</tr>
								<#--
								<tr>
									<td height="26" colspan="2">
									<p><input name="[imgalt]${productContent_index}" type="text"
										 value="${productContent.description?if_exists}" onclick="if(this.value=='添加图片说明')this.value=''"
										onblur="if(this.value=='')this.value='添加图片说明'" /></p>
									</td>
								</tr>
								-->
								<tr>
									<td height="26" colspan="2">
										<p>
											<input name="[imgseq]${productContent_index}" type="text" value="${productContent.sequenceNum?if_exists}" onclick="if(this.value=='1')this.value=''" onblur="if(this.value=='')this.value='1'" />
										</p>
									</td>
								</tr>
							</table>
							<#--/#if>
							</#if-->
						</#list>
					</#if>
				</div>
				<!--
				</td>
				<td class="m-ri"></td>
				</tr>
				<tr>
				<td class="b-lt"></td>
				<td class="b-mid"></td>
				<td class="b-ri"></td>
				</tr>
				</tbody>
				</table>
				-->
			</div>
			<#-- 
			<div class="mainlayout clearfix j-productgroup">
			<div class="ml-title">产品组：</div>
			<a id="a_productgrop"></a>
			<p class="helptips">
			产品组新增二级分组功能。产品组有二级分组时，请选择二级分组。否则产品将会归到未分组，影响使用。
			<span class="helpicon" title="产品组帮助" data-helpid="productGroupHelp"></span>
			</p>
			<div class="margintop10">
			<input id="productgroupid" name="productgroupid" value="" type="hidden">
			<select class="j-select-root"><option selected="selected" value="">请选择产品分组</option></select>
			<select class="j-select-sub" style="display:none;"></select>
			</div>
			</div>
			-->
			<!-- 产品简短描述 开始 -->
			<div class="mainlayout clearfix" id="productdescTip">
				<div class="ml-title">
					<span class="required">*</span>产品简短描述：
				</div>
				<a id="a_productdesc"></a>
				<p class="helptips">商品参数，如：颜色、尺寸、款式、配件、贸易方式等。<span class="helpicon" title="产品简短描述帮助" helptipval="productdescTip"></span></p>
				<div class="margintop10">
					<textarea name="description" cols="45" rows="5" class="attr-textarea tareaheight addwid402" id="description" maxlength="120"><#if entity?has_content>${entity.description?if_exists}</#if></textarea>
					<#--
					
					<span class="helptips marginleft10">您还可以输入<b class="color444" id="productdescLengthSpan">500</b><span class="color000">/<span>500</span></span>个字符</span>
				       -->
				</div>
				<div>
		        	<div></div>
					<div></div>
					<div></div>
				</div>
				<div id="productdescErrTip" class="tip-error" style="display:none;"></div>
			</div>
			<!-- 产品简短描述 结束 -->
			<!-- 产品详细描述 开始 -->
			<div class="mainlayout clearfix" id="featureshtmlTip">
				<div class="ml-title"><span class="required">*</span>产品详细描述：</div>
				<p class="helptips">详细描述一般包含产品功能属性、产品细节图片、支付物流、售后服务、公司实力等内容。<span class="helpicon" title="产品详细描述帮助" helptipval="featureshtmlTip"></span></p>
				<a id="a_featureshtml"></a>
				<br>
				<div style="">
					<#if (entity.longDescription)??>
						<#assign longDescriptionObj = StringUtil.wrapString(entity.longDescription)>
					<#else>
						<#assign longDescriptionObj = StringUtil.wrapString("")>
					</#if>
					<!-- 加载编辑器的容器 -->
					<script id="container" name="longDescription" type="text/plain">
				       	 这里写你的初始化内容
					</script>
					<!-- 配置文件 -->
					<script type="text/javascript" src="/portal/images/ueditor/ueditor.config.js"></script>
					<!-- 编辑器源码文件 -->
					<script type="text/javascript" src="/portal/images/ueditor/ueditor.all.js"></script>
					<!-- 实例化编辑器 -->
					<script type="text/javascript">
				        var ue = UE.getEditor('container');
				        ue.ready(function() {
						    //设置编辑器的内容
						     ue.setContent('${longDescriptionObj!}');
						    $("#edui2").css("line-height","20px");
						});
					</script>	
					<#--
					<div class=" edui-default" id="elm"><div style="z-index: 999; width: 100%;" id="edui1" class="edui-editor  edui-default"><div id="edui1_toolbarbox" class="edui-editor-toolbarbox edui-default"><div id="edui1_toolbarboxouter" class="edui-editor-toolbarboxouter edui-default"><div class="edui-editor-toolbarboxinner edui-default"><div style="-moz-user-select: none;" id="edui2" class="edui-toolbar   edui-default" onselectstart="return false;" onmousedown='return $EDITORUI["edui2"]._onMouseDown(event, this);'><div id="edui3" class="edui-box edui-combox edui-for-fontfamily edui-default"><div class=" edui-default" title="字体" id="edui3_state" onmousedown='$EDITORUI["edui3"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui3"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui3"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui3"].Stateful_onMouseOut(event, this);'><div class="edui-combox-body edui-default"><div id="edui3_button_body" class="edui-box edui-button-body edui-default" onclick='$EDITORUI["edui3"]._onButtonClick(event, this);'>字体</div><div class="edui-box edui-splitborder edui-default"></div><div class="edui-box edui-arrow edui-default" onclick='$EDITORUI["edui3"]._onArrowClick();'></div></div></div></div><div id="edui11" class="edui-box edui-combox edui-for-fontsize edui-default"><div class=" edui-default" title="字号" id="edui11_state" onmousedown='$EDITORUI["edui11"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui11"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui11"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui11"].Stateful_onMouseOut(event, this);'><div class="edui-combox-body edui-default"><div id="edui11_button_body" class="edui-box edui-button-body edui-default" onclick='$EDITORUI["edui11"]._onButtonClick(event, this);'>字号</div><div class="edui-box edui-splitborder edui-default"></div><div class="edui-box edui-arrow edui-default" onclick='$EDITORUI["edui11"]._onArrowClick();'></div></div></div></div><div id="edui22" class="edui-box edui-button edui-for-bold edui-default"><div class=" edui-default" id="edui22_state" onmousedown='$EDITORUI["edui22"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui22"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui22"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui22"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui22_body" unselectable="on" title="加粗" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui22"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui23" class="edui-box edui-button edui-for-italic edui-default"><div class=" edui-default" id="edui23_state" onmousedown='$EDITORUI["edui23"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui23"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui23"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui23"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui23_body" unselectable="on" title="斜体" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui23"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui24" class="edui-box edui-button edui-for-underline edui-default"><div class=" edui-default" id="edui24_state" onmousedown='$EDITORUI["edui24"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui24"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui24"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui24"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui24_body" unselectable="on" title="下划线" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui24"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui25" class="edui-box edui-button edui-for-strikethrough edui-default"><div class=" edui-default" id="edui25_state" onmousedown='$EDITORUI["edui25"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui25"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui25"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui25"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui25_body" unselectable="on" title="删除线" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui25"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui26" class="edui-box edui-separator  edui-default"></div><div id="edui27" class="edui-box edui-splitbutton edui-for-forecolor edui-default edui-colorbutton"><div class=" edui-default" title="字体颜色" id="edui27_state" onmousedown='$EDITORUI["edui27"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui27"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui27"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui27"].Stateful_onMouseOut(event, this);'><div class="edui-splitbutton-body edui-default"><div id="edui27_button_body" class="edui-box edui-button-body edui-default" onclick='$EDITORUI["edui27"]._onButtonClick(event, this);'><div class="edui-box edui-icon edui-default"></div><div id="edui27_colorlump" class="edui-colorlump"></div></div><div class="edui-box edui-splitborder edui-default"></div><div class="edui-box edui-arrow edui-default" onclick='$EDITORUI["edui27"]._onArrowClick();'></div></div></div></div><div id="edui30" class="edui-box edui-splitbutton edui-for-backcolor edui-default edui-colorbutton"><div class=" edui-default" title="背景色" id="edui30_state" onmousedown='$EDITORUI["edui30"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui30"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui30"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui30"].Stateful_onMouseOut(event, this);'><div class="edui-splitbutton-body edui-default"><div id="edui30_button_body" class="edui-box edui-button-body edui-default" onclick='$EDITORUI["edui30"]._onButtonClick(event, this);'><div class="edui-box edui-icon edui-default"></div><div id="edui30_colorlump" class="edui-colorlump"></div></div><div class="edui-box edui-splitborder edui-default"></div><div class="edui-box edui-arrow edui-default" onclick='$EDITORUI["edui30"]._onArrowClick();'></div></div></div></div><div id="edui33" class="edui-box edui-separator  edui-default"></div><div id="edui34" class="edui-box edui-button edui-for-justifyleft edui-default"><div class=" edui-default" id="edui34_state" onmousedown='$EDITORUI["edui34"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui34"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui34"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui34"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui34_body" unselectable="on" title="居左对齐" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui34"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default"></div></div></div></div></div><div id="edui35" class="edui-box edui-button edui-for-justifycenter edui-default"><div class=" edui-default" id="edui35_state" onmousedown='$EDITORUI["edui35"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui35"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui35"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui35"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui35_body" unselectable="on" title="居中对齐" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui35"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default"></div></div></div></div></div><div id="edui36" class="edui-box edui-button edui-for-justifyright edui-default"><div class=" edui-default" id="edui36_state" onmousedown='$EDITORUI["edui36"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui36"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui36"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui36"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui36_body" unselectable="on" title="居右对齐" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui36"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default"></div></div></div></div></div><div id="edui37" class="edui-box edui-separator  edui-default"></div><div id="edui38" class="edui-box edui-button edui-for-indent edui-default"><div class=" edui-default" id="edui38_state" onmousedown='$EDITORUI["edui38"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui38"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui38"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui38"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui38_body" unselectable="on" title="首行缩进" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui38"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui39" class="edui-box edui-separator  edui-default"></div><div id="edui40" class="edui-box edui-menubutton edui-for-insertorderedlist edui-default"><div class=" edui-default" title="有序列表" id="edui40_state" onmousedown='$EDITORUI["edui40"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui40"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui40"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui40"].Stateful_onMouseOut(event, this);'><div class="edui-menubutton-body edui-default"><div id="edui40_button_body" class="edui-box edui-button-body edui-default" onclick='$EDITORUI["edui40"]._onButtonClick(event, this);'><div class="edui-box edui-icon edui-default"></div></div><div class="edui-box edui-splitborder edui-default"></div><div class="edui-box edui-arrow edui-default" onclick='$EDITORUI["edui40"]._onArrowClick();'></div></div></div></div><div id="edui47" class="edui-box edui-menubutton edui-for-insertunorderedlist edui-default"><div class=" edui-default" title="无序列表" id="edui47_state" onmousedown='$EDITORUI["edui47"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui47"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui47"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui47"].Stateful_onMouseOut(event, this);'><div class="edui-menubutton-body edui-default"><div id="edui47_button_body" class="edui-box edui-button-body edui-default" onclick='$EDITORUI["edui47"]._onButtonClick(event, this);'><div class="edui-box edui-icon edui-default"></div></div><div class="edui-box edui-splitborder edui-default"></div><div class="edui-box edui-arrow edui-default" onclick='$EDITORUI["edui47"]._onArrowClick();'></div></div></div></div><div id="edui54" class="edui-box edui-menubutton edui-for-lineheight edui-default"><div class=" edui-default" title="行间距" id="edui54_state" onmousedown='$EDITORUI["edui54"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui54"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui54"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui54"].Stateful_onMouseOut(event, this);'><div class="edui-menubutton-body edui-default"><div id="edui54_button_body" class="edui-box edui-button-body edui-default" onclick='$EDITORUI["edui54"]._onButtonClick(event, this);'><div class="edui-box edui-icon edui-default"></div></div><div class="edui-box edui-splitborder edui-default"></div><div class="edui-box edui-arrow edui-default" onclick='$EDITORUI["edui54"]._onArrowClick();'></div></div></div></div><div id="edui63" class="edui-box edui-separator  edui-default"></div><div id="edui64" class="edui-box edui-button edui-for-undo edui-default"><div class=" edui-default" id="edui64_state" onmousedown='$EDITORUI["edui64"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui64"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui64"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui64"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui64_body" unselectable="on" title="撤销" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui64"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui65" class="edui-box edui-button edui-for-redo edui-default"><div class=" edui-default" id="edui65_state" onmousedown='$EDITORUI["edui65"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui65"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui65"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui65"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui65_body" unselectable="on" title="重做" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui65"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui66" class="edui-box edui-separator  edui-default"></div><div id="edui67" class="edui-box edui-splitbutton edui-for-inserttable edui-default"><div class=" edui-default" title="插入表格" id="edui67_state" onmousedown='$EDITORUI["edui67"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui67"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui67"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui67"].Stateful_onMouseOut(event, this);'><div class="edui-splitbutton-body edui-default"><div id="edui67_button_body" class="edui-box edui-button-body edui-default" onclick='$EDITORUI["edui67"]._onButtonClick(event, this);'><div class="edui-box edui-icon edui-default"></div></div><div class="edui-box edui-splitborder edui-default"></div><div class="edui-box edui-arrow edui-default" onclick='$EDITORUI["edui67"]._onArrowClick();'></div></div></div></div><div id="edui70" class="edui-box edui-button edui-for-deletetable edui-default"><div class=" edui-default" id="edui70_state" onmousedown='$EDITORUI["edui70"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui70"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui70"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui70"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui70_body" unselectable="on" title="删除表格" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui70"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui71" class="edui-box edui-separator  edui-default"></div><div id="edui78" class="edui-box edui-button edui-for-link edui-default"><div class="edui-default" id="edui78_state" onmousedown='$EDITORUI["edui78"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui78"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui78"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui78"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui78_body" unselectable="on" title="超链接" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui78"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default"></div></div></div></div></div><div id="edui79" class="edui-box edui-button edui-for-unlink edui-default"><div class=" edui-default" id="edui79_state" onmousedown='$EDITORUI["edui79"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui79"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui79"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui79"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui79_body" unselectable="on" title="取消链接" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui79"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui80" class="edui-box edui-button edui-for-cleardoc edui-default"><div class=" edui-default" id="edui80_state" onmousedown='$EDITORUI["edui80"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui80"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui80"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui80"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui80_body" unselectable="on" title="清空文档" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui80"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default"></div></div></div></div></div><div id="edui81" class="edui-box edui-button edui-for-fullscreen edui-default"><div class=" edui-default" id="edui81_state" onmousedown='$EDITORUI["edui81"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui81"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui81"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui81"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui81_body" unselectable="on" title="全屏" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui81"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default"></div></div></div></div></div></div><div style="-moz-user-select: none;" id="edui82" class="edui-toolbar   edui-default" onselectstart="return false;" onmousedown='return $EDITORUI["edui82"]._onMouseDown(event, this);'><div id="edui83" class="edui-box edui-button edui-for-upload edui-default"><div class=" edui-default" id="edui83_state" onmousedown='$EDITORUI["edui83"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui83"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui83"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui83"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui83_body" unselectable="on" title="上传本地图片" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui83"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default">上传本地图片</div></div></div></div></div><div id="edui84" class="edui-box edui-button edui-for-albums edui-default"><div class=" edui-default" id="edui84_state" onmousedown='$EDITORUI["edui84"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui84"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui84"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui84"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui84_body" unselectable="on" title="图片相册" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui84"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default">图片相册</div></div></div></div></div><div id="edui85" class="edui-box edui-button edui-for-relatedproduct edui-default"><div class=" edui-default" id="edui85_state" onmousedown='$EDITORUI["edui85"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui85"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui85"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui85"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui85_body" unselectable="on" title="插入关联产品" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui85"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default">插入关联产品</div></div></div></div></div><div id="edui86" class="edui-box edui-separator  edui-default"></div><div id="edui87" class="edui-box edui-button edui-for-source edui-default"><div class=" edui-default" id="edui87_state" onmousedown='$EDITORUI["edui87"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui87"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui87"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui87"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui87_body" unselectable="on" title="源代码" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui87"]._onClick();'><div class="edui-box edui-icon edui-default"></div></div></div></div></div><div id="edui88" class="edui-box edui-button edui-for-preview edui-default"><div class=" edui-default" id="edui88_state" onmousedown='$EDITORUI["edui88"].Stateful_onMouseDown(event, this);' onmouseup='$EDITORUI["edui88"].Stateful_onMouseUp(event, this);' onmouseover='$EDITORUI["edui88"].Stateful_onMouseOver(event, this);' onmouseout='$EDITORUI["edui88"].Stateful_onMouseOut(event, this);'><div class="edui-button-wrap edui-default"><div id="edui88_body" unselectable="on" title="预览效果" class="edui-button-body edui-default" onmousedown="return false;" onclick='return $EDITORUI["edui88"]._onClick();'><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default">预览效果</div></div></div></div></div></div></div></div><div id="edui1_toolbarmsg" class="edui-editor-toolbarmsg edui-default" style="display:none;"><div id="edui1_upload_dialog" class="edui-editor-toolbarmsg-upload edui-default" onclick='$EDITORUI["edui1"].showWordImageDialog();'>点击上传</div><div class="edui-editor-toolbarmsg-close edui-default" onclick='$EDITORUI["edui1"].hideToolbarMsg();'>x</div><div id="edui1_toolbarmsg_label" class="edui-editor-toolbarmsg-label edui-default"></div><div class=" edui-default" style="height:0;overflow:hidden;clear:both;"></div></div></div><div style="height: 540px; overflow: hidden;" id="edui1_iframeholder" class="edui-editor-iframeholder edui-default"><iframe id="baidu_editor_0" scroll="no" frameborder="0" height="100%" width="100%"></iframe></div><div id="edui1_bottombar" class="edui-editor-bottomContainer edui-default"><table class=" edui-default"><tbody class=" edui-default"><tr class=" edui-default"><td id="edui1_elementpath" class="edui-editor-bottombar edui-default">请勿输入非英文字符和符号</td><td id="edui1_wordcount" class="edui-editor-wordcount edui-default">您还可以输入<strong>80000</strong>/80000个字符</td><td style="display: none;" id="edui1_scale" class="edui-editor-scale edui-default"><div class="edui-editor-icon edui-default"></div></td></tr></tbody></table></div><div class=" edui-default" id="edui1_scalelayer"></div></div></div>
					-->
				</div>
				<div id="featureshtmlErrTip" class="tip-error" style="display:none;"></div>
			</div>
			<!-- 产品详细描述 结束 -->
		    
			<!-- 产品视频 开始 -->
			<div class="mainlayout clearfix j-list-item" id="vadiourlTip" style='display:none'>
				<div class="ml-title">产品视频链接：</div>
				<a id="a_vadiourl"></a>
				<div>
					<input class="attr-text-input addwid402" id="videourl" size="120" name="videourl" maxlength="300" type="text">
					<span class="helpicon" title="导入视频帮助" helptipval="vadiourlTip"></span>
				</div>
				<div style="display:none" class="tip-error" data-name="产品视频链接">
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
				<div class="ml-title"><span class="required">*</span>包装后重量：</div>
				<a id="a_productweight"></a>
				<a id="a_baseqt"></a>
				<a id="a_stepqt"></a>
				<a id="a_stepweight"></a>
				<div id="packTip_3">
					<input id="productweight" name="productWeight" onkeyup="inputFloat(this,2);checkProductWeight(this.value,this);" onblur="isRedrawTemplateTable();" value="<#if entity?has_content>${entity.productWeight?if_exists}</#if>" size="6" class="attr-text-input j-textchange" type="text" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}">
					<span class="marginleft10" id="span_productweight">公斤（KG）/<span id="sortbyunit2" class="j-unit" name="sortbyunit2">件</span></span>
					<span class="helpicon" title="包装后重量帮助" helptipval="packTip_3"></span>
				</div>
				<div id="productweightErrTip" class="tip-error" style="display:none;">
					<p id="productweightTipMsg"></p>
				</div>
				
				<div class="margintop10" id="packTip_4"  style='display:none'>
					<input id="isonlyweight" name="isonlyweight" value="1" onclick="showOnlyWeight(this.checked,true);" type="checkbox">
					<span class="marginleft5">产品计重阶梯设定</span>
					<span class="helptips marginleft10" style='display:none'>
						依据产品件数设置产品重量，适合体积小、重量大产品。
						<a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0401&amp;artid=AEF02D27855321F1E04010AC0B64209F" target="_blank">查看详情</a>
						<span class="helpicon" title="产品计重阶梯设定帮助" helptipval="packTip_4"></span>
					</span>
					<div class="proladderset" id="div_onlyweight" style="display:none">
						<div class="margintop5">
							买家购买
							<input class="attr-text-input addwid60 margindoublev5" name="baseqt" id="baseqt" maxlength="5" onkeyup="inputRightInt(this);checkWeightBaseQT();" onblur="checkWeightBaseQT();" style="ime-mode:disabled;" type="text">件以内，按单位产品重量计算运费。
						</div>
						<p class="margintop5">
							在此基础上，买家每多买
							<input class="attr-text-input addwid50 margindoublev5" name="stepqt" id="stepqt" maxlength="5" onkeyup="inputRightInt(this);checkWeightStepQT();" onblur="checkWeightStepQT();" style="ime-mode:disabled;" type="text">
							<span id="sortbyunit2" name="sortbyunit2">件</span>
							，重量增加
							<input class="attr-text-input addwid50 margindoublev5" name="stepweight" id="stepweight" maxlength="6" onkeyup="inputFloat(this,2);checkWeightStepWeightQT();" onblur="checkWeightStepWeightQT();" style="ime-mode:disabled;" type="text">
							公斤。
						</p>
	    				<div class="p-warn clearfix">
							<div class="p-warn-inner">当您填写完整以上自定义计重的信息后，系统会按照以上设定来计算总运费，忽略产品包装尺寸；错误设定自定义计重信息可能导致您承受运费损失，尤其对于体积重大于毛重的产品，请谨慎选择填写。</div>
	    				</div>
	    				<div id="baseqtErrTip" class="tip-error" style="display:none;">
							<p>请填写产品计重阶梯的数量！</p>
						</div>
			    		<div id="stepqtErrTip" class="tip-error" style="display:none;">
							<p>请填写产品计重阶梯的增加数量！</p>
						</div>
	    				<div id="stepweightErrTip" class="tip-error" style="display:none;">
							<p>请填写产品计重阶梯的增加重量，单位为公斤！</p>
						</div>	
					</div>
				</div>
			</div>
			<!-- 包装后重量 结束 -->
			<!-- 包装后尺寸 开始 -->
			<div class="mainlayout clearfix" id="packTip_5">
				<div class="ml-title">
					<span class="required">*</span>包装后尺寸：
				</div>
				<input type='hidden' name='heightUomId' value='LEN_cm'>
				<input type='hidden' name='widthUomId' value='LEN_cm'>
				<input type='hidden' name='depthUomId' value='LEN_cm'>
				<a id="a_sizelen"></a><a id="a_sizewidth"></a><a id="a_sizeheight"></a>
				<div>
					长:<input class="attr-text-input addwid60  j-textchange" size="6" id="sizelen" name="productDepth" value="<#if entity?has_content>${(entity.productDepth)!''}<#else></#if>" style="color:#949494;" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}" onchange="inputFloat(this,2);" onkeyup="inputFloat(this,2);checkProductWeightSize();" onblur="checkSizeNull(1);checkProductWeightSize();isRedrawTemplateTable();" onclick="hideSizeMsg(this);" type="text">
					<#-- <span class="margindoublev10">*</span>-->
					宽:<input class="attr-text-input addwid60  j-textchange" size="6" id="sizewidth" name="productWidth" value="<#if entity?has_content>${(entity.productWidth)!''}<#else></#if>" style="color:#949494;" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}" onchange="inputFloat(this,2);" onkeyup="inputFloat(this,2);checkProductWeightSize();" onblur="checkSizeNull(2);checkProductWeightSize();isRedrawTemplateTable();" onclick="hideSizeMsg(this);" type="text">
					<#-- <span class="margindoublev10">*</span>-->
					高:<input class="attr-text-input addwid60  j-textchange" size="6" id="sizeheight" name="productHeight" value="<#if entity?has_content>${(entity.productHeight)!''}<#else></#if>" style="color:#949494;" onchange="if(/^[0-9]+([.]{0,1}[0-9]+){0,1}$/.test(this.value)!=true){alert('只能输入数字');this.value='';}" onchange="inputFloat(this,2);" onkeyup="inputFloat(this,2);checkProductWeightSize();" onblur="checkSizeNull(3);checkProductWeightSize();isRedrawTemplateTable();" onclick="hideSizeMsg(this);" type="text">
					<span class="marginleft10">单位均为：厘米</span>
					<span class="helpicon" title="单位帮助" helptipval="packTip_5"></span>
				</div>
				<div id="div_weightalert" style="display:none" class="p-warn clearfix">
					<div class="p-warn-inner">
						物流公司会根据产品包装后重量和产品包装体积重两者的较高值来计算运费。根据您填写的产品包装尺寸，DHgate估算出您产品的体积重约为
						<span id="shippingsizeweight"></span>
						公斤，超过了产品包装后重量，因此DHgate会根据您产品的体积重来计算运费。
						<span class="p-warn-help-warp">
							<span class="p-warn-help-icon" onmouseover="$('#div_weightalert_help').show()" onmouseout="$('#div_weightalert_help').hide()"></span>
							<span class="p-warn-help-inner" id="div_weightalert_help" style="display:none;">
								<table width="100%" border="0" cellpadding="0" cellspacing="0">
									<tbody>
										<tr>
											<th align="left">物流公司计算体积重的方式：</th>
										</tr>
										<tr>
											<td align="center">重量 = 长 (cm)x 宽(cm)x 高(cm)/6000 公斤（kg）</td>
										</tr>
									</tbody>
								</table>
							</span>
		            	</span>
		           	</div>
				</div>
			
				<div id="sizelenErrTip" class="tip-error" style="display:none;">
					<p id="sizelenTipMsg">您需要输入包装的长度！</p>
				</div>
				<div id="sizewidthErrTip" class="tip-error" style="display:none;">
					<p id="sizewidTipMsg">您需要输入包装的宽度！</p>
				</div>
				<div id="sizeheightErrTip" class="tip-error" style="display:none;">
					<p id="sizehigTipMsg">您需要输入包装的高度！</p>
				</div>
			</div>
			<!-- 包装后尺寸 结束 -->
			<!-- title产品包装信息 结束 -->
			     
			<!-- 运费设置开始 -->
			<div class="titlebox" id="shippingmodelidTip_1" style='display:none'>
			 	<h3>5、设置运费</h3>
			 	<span class="helpicon" title="设置运费帮助" helptipval="shippingmodelidTip_1"></span>
				<a id="a_shippingmodelid"></a>
			</div>
			<!------- 运费设置列表开始 ------->
			<div class="j-list-item" style='display:none'>
				<!------- 大标题开始 ------->
				<div class="mainlayout clearfix j-shippingarea-container">
					<div class="ml-title">
						<span class="required">*</span>选择运费模板：
					</div>
					<div class="addwid800 tipstion" style="height:25px">
						<span class="helptips">服装面料(Clothing Fabric)类目下的产品，订单最多的国家为美国，美国买家主要采用DHL物流。</span>
						<a href="javascript:;" class="j-shippingarea-trigger">详细</a>
						<div class="tiparrow-box addrbox j-shippingarea-tip" style="display: none;">
							<div class="tiparrow-b" style="left:214px;"></div>
							<p>服装面料 类目下，主要的订单国家和物流使用情况如下：</p>
							<table class="addrtips">
								<tbody>
									<tr class="addrtit">
										<td>二级类目</td>
										<td>发货订单量占比</td>
										<td>收货国家</td>
										<td>主要物流</td>
										<td>物流占比</td>
									</tr>
						 		</tbody>
					 		</table>
						</div>
					</div>
					<div class="addwid800 clearfix">
						<span class="tourBtn fltrig">
							<input value="标准运费计算器" onclick="showShippingCalculatorWin('');" type="button">
						</span>
						<!-- 产品运费选择内容开始 -->
						<div class="syi-select-dropdown-list syi-lfselect">
							<div class="syi-simulation-select" id="selectTemplateDiv">
								<input readonly="readonly" class="syi-input15" name="shippingmodelname" id="shippingmodelname" type="text">
								<div class="syi-simulation-arrow"></div>
							</div>
							<div class="syi-category-list select-two" style="display:none" id="templatesDiv">
								<ul id="templatesUL"></ul>
								<div class="catemore" id="noTemplateDiv" style="display: none;">
									您目前还没有创建任何运费模板。<br>
									<a href="http://seller.dhgate.com/mydhgate/product/transport/template.do?act=preCreateOrdinary" target="_blank">创建模板</a>
								</div>
								<iframe></iframe>
							</div>
						</div>
						<!-- 产品运费选择内容结束 -->
						<a href="http://seller.dhgate.com/frttemplate/pageload.do?act=pageload&amp;dhpath=10001,0205" target="_blank" class="marginleft10" onclick="$('#shippingmodelidInfoTip').show();">管理运费模板</a><a href="javascript:void(0);" onclick="showSaveAsDiv();return false;" style="display: none;" class="marginleft10" id="saveTemplateLink">保存此设置为模板...</a>
						<span class="syi-loading" id="savingTemplateSpan" style="display: none;">模板保存中...</span>
						<span class="syi-correct marginleft10" id="savedTemplateSpan" style="display: none;">模板保存成功</span>
					</div>
				</div>
				<!------- 大标题结束 ------->
				<!------- 运费设置列表开始 ------->
				<div class="syi-shipping-content addzindex02 clearfix" style="display: none;" id="templateTableDiv">
					<div class="syi-shippingset-tit">
						<ul>
							<li class="wid160">物流公司</li>
							<li class="wid320">送达国家</li>
							<li class="wid190">运费设置</li>
							<li class="wid209 tipstion">
	                			运费(含燃油费)
								<p class="syi-font3">
	                        		运送<input value="1" size="2" class="j-textchange" id="caculateQuantity" type="text">件(包) 至
									<select id="caculateCountry" class="syi-select6">
										<option selected="selected" value="">选择送达国家</option>
										<option value="CN">中国</option>
										<option value="US">美国</option>
										<option value="ZW">津巴布韦</option>
									</select>
								</p>
								<div style="left: -34px; top: 60px; display: block;" class="tiparrow-posbox j-package-tips">
									<div class="tiparrow-box" style="width:240px;">
										使用运费计算请填写完整"<a href="#vadiourlTip">产品包装信息</a>"
				
									</div>
								</div>
							</li>
						</ul>
					</div>
					<!--运费及物流设置内容 ajax渲染-->
					<div class="j-shipping-box"></div>
						<!--国家内容白色 弹层-->
						<div class="syi-shippingset-bar j-shipping-bar" style="display:none">
							<b class="downarrow"></b>
						</div>
						<div style="display:none;" class="syi-country-wrap j-country-warp">
							<div class="syi-country-inner j-wrap-content"></div>
							<div class="syi-country-shadow"></div>
						</div>
						<!--国家内容白色 弹层-->
					</div>
					<div style="display: none;" id="shippingmodelidErrTip" class="tip-error"></div>
				<!--国家太多时显示的tip 开始-->
				<div class="country_pop" style="display: none;position:absolute;z-index: 1000;" id="countryTip">
					<a href="#" class="close_cpop" onclick="hideCoutriesTip();return false;"></a>
					<div class="syi-line"></div>
					<div class="country_popcont" id="coutryZoneDiv"></div>
					<iframe></iframe>
				</div>
				<!--国家太多时显示的tip 结束-->
			</div>
			<!------- 运费设置列表结束 ------->
			<!-- 运费设置结束 -->
			<!--初始化vo-->
			<script>
           		//var g_shippingmodeVo = com.dhgate.syi.model.ShippingmodeVO@60711762;
           		//var g_shippingmodeVo = "null-value";
			</script>
			<!------- 运费设置列表结束 ------->
    
			<!-- title其他信息 开始 -->
			<div class="titlebox"><h3>5、其他信息</h3></div>
    
			<!-- 工厂编号产品 开始 
			<div class="mainlayout clearfix" id="keywordTip">
			<div class="ml-title">工厂产品编号：</div>
			<div>
			<input class="attr-text-input marginright10" id="factoryproductname" name="factoryproductname" maxlength="25" type="text" value="" />
			</div>
			</div>-->
			
			<!-- 工厂产品编号 结束 -->
			
			<!-- 产品有效期 开始 -->
			<div class="mainlayout clearfix" id="vailddayTip">
				<div class="ml-title"></div>
	         	<span class="spanaddwid70" style="width:250px;height:35px;">
		  			开始时间：<input class="Wdate" type="text" name="introductionDate" value="${(entity.introductionDate)!}" style="height:30px;width:180px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">		  			  	
	  			  	<!--
	  			  	<#assign introductionDate="">
					<#if entity?has_content&&entity.introductionDate??><#assign introductionDate=entity.introductionDate></#if>
					<@htmlTemplate.renderDateTimeField name="introductionDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="${introductionDate?if_exists}" size="25" maxlength="30" id="introductionDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
	  			  	-->
		  		</span>
		  		<span class="spanaddwid70" style="width:250px;">
		  			结束时间：
	  				<!--
	  			  	<#assign salesDiscontinuationDate="">
					<#if entity?has_content&&entity.salesDiscontinuationDate??><#assign salesDiscontinuationDate=entity.salesDiscontinuationDate></#if>
					<@htmlTemplate.renderDateTimeField name="salesDiscontinuationDate" event="" action="" className="" alert="" title="Format: yyyy-MM-dd HH:mm:ss.SSS" value="${salesDiscontinuationDate?if_exists}" size="25" maxlength="30" id="salesDiscontinuationDate" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
	  				-->
	  				<input class="Wdate" type="text" name="salesDiscontinuationDate" value="${(entity.salesDiscontinuationDate)!}" style="height:30px;width:180px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})">	
	 		  	</span>
	 		  	<br/>
		 		<!--
				<span class="helpicon" title="产品有效期帮助" helptipval="vailddayTip"></span>
		 		-->
			</div>
			<!-- 产品有效期 结束 -->
			<!-- 店铺会员专区产品 开始 -->
			<input id="specialzone0" value="0" type="hidden">
			<!-- 店铺会员专区产品 结束 -->
    
			<!-- VIP专供产品 开始 -->
			<input id="productvip0" value="0" type="hidden">
			<!-- VIP专供产品 结束 -->
			<!--对频繁上传产品的卖家显示验证码-->
			<!-- 卖易通网网络服务使用协议 开始 -->
			<div class="chousexybox" style='display:none'>
				<input id="dhgateagree" checked="checked" onclick="clickagreee();" type="checkbox">
				<span class="marginleft5">
					同意接受<a href="http://policy.dhgate.com/policy_list.php?catalogno=110305" target="_blank">《卖易通网产品发布规则》</a>
				</span>
			</div>
			<!-- 卖易通网网络服务使用协议 结束 -->
	
			<!-- title其他信息 结束 -->
			<!-- 完成提交开始 -->
			<div id="syi_submit_id" class="syi-submit">
   				<strong id="errormsgid" class="error-edit-text">网络繁忙，请稍后重试，如果问题仍然存在，请联系卖易通网客服部门。</strong>
   				<br/>
				<button type="button" id="btn_submitproduct" onclick='validFormFields();'>
					<span id="loadingimg" class="submit-syi" style="height:38px;">
						<img src="/portal/seller/images/product/loadings.gif" class="syi-img-show">
						<span id="submitopt">提 交</span>
					</span>
					
				</button>
				<!--<button type="button"  id="btn_previewproduct">
					<span class="preview" id="previewopt"><span>预览</span></span>
				</button>-->
			</div>
			<br/>
			<br/>
			<!-- 完成提交结束 -->
			<div class="studybox"  style='display:none'>
				<a target="_blank" href="http://survey.dhgate.com/index.php?sid=72953&amp;lang=zh-Hans&amp;dhsurveybuyerid=ff808081482fd3fd01485e24266e5056"><span class="studyicon">产品上传不方便？我要提意见</span></a>
			</div>
	
			<!-- 翻译 开始 -->
			<div style="right: 261px;display:none;" id="translateBox" class="syi-translate">
				<div class="show-translabox"></div>
				<div class="translabox">
					<a href="http://fanyi.baidu.com/" target="_blank" class="jinshan"></a>
					<a href="http://fanyi.youdao.com/" target="_blank" class="youdao"></a>
					<a href="http://translate.google.cn/" target="_blank" class="google"></a>
				</div>
				<!-- 产品填写参考 开始 -->
				<div class="syi-proreference-box" style="display:none;">
					<div class="syi-proreference">
						<a href="http://seller.dhgate.com/syi/showProdInfo.do?itemcode=" target="_blank" title="点此查看调整之前的产品信息" class="proreferencebox">产品填写参考</a>
					</div>
				</div>
				<!-- 产品填写参考 结束 -->
			</div>
			<!-- 翻译 结束 -->
			<div style="top: 371px; right: 261px;" id="onLineChatBox" class="syi-onlinechat">
				<div class="show-onlinechat"></div>
				<div class="onlinechatbox">
					<a id="syi_chat_window" href="javascript:void(0);" class="onlinechat" target="_blank"></a>
				</div>
			</div>			
	
			<!-- Top 开始 -->
			<div style="right: 261px;" id="returnTopBox" class="syi-returntop">
				<div style="display: block;" class="returntopbox">
					<a href="#syiTop"></a>
				</div>
			</div>
			<!-- Top 结束 -->
			<!-- footer文件调用开始 -->
			<div class="headerlayout">
				
			</div>
			<!-- footer文件调用结束 -->
			<!--<input name="rid" id="rid" value="1F8D32hmqSpL5KHm3" type="hidden">-->

			<input name="requestid" id="requestid" value="" type="hidden">
			<input name="productid" id="productid" value="" type="hidden">
			<input name="itemcode" id="itemcode" value="" type="hidden">
			<input name="catepubid" id="inp_catepubid" value="014024002" type="hidden">
			
			<input name="imglist" id="imglistid" value="" type="hidden">
			<input name="prospeclist" id="prospeclistid" value="" type="hidden">
			<input name="shippingmodelid" id="shippingmodelid" value="" type="hidden">
			<input name="isquickup" id="isquickup" value="0" type="hidden">
			<input name="viewSource" id="viewSource" value="" type="hidden">
			<input name="repeatGroupId" id="repeatGroupId" value="" type="hidden">
			<input id="invetoryQty" value="231" type="hidden">
			<input id="isHaveSpec" value="0" type="hidden">
			<input id="commissionRate" value="0.12,0.045,300" type="hidden">
			<input id="commissionOrderAmount" value="" type="hidden">
			   
			<input id="oldSkuInfo" name="oldSkuInfo" value="" type="hidden">
			<input id="forEditOldCatePubid" name="forEditOldCatePubid" value="" type="hidden">
			<div id="div_proSkuInfo" style="display:none;">
				[{"class":"###","inventoryLocation":"CN","leadingTime":2,"skuInfoList":[{"class":"#","attrList":[],"status":"1","price":"","stock":"","skuCode":"","id":"noSku"}]}]
			</div>
			<input id="proSkuInfo" name="proSkuInfo" value="[{&quot;class&quot;:&quot;###&quot;,&quot;inventoryLocation&quot;:&quot;CN&quot;,&quot;leadingTime&quot;:2,&quot;skuInfoList&quot;:[{&quot;class&quot;:&quot;#&quot;,&quot;attrList&quot;:[],&quot;status&quot;:&quot;1&quot;,&quot;price&quot;:&quot;&quot;,&quot;stock&quot;:&quot;0&quot;,&quot;skuCode&quot;:&quot;&quot;,&quot;id&quot;:&quot;noSku&quot;}]}]" type="hidden">
			<input id="customAttrList" name="specselfDef" value="[]" type="hidden">
			<div id="div_customattrlist" style="display:none;">[]</div>
			<input id="saleSectionData" name="discountRange" value="[{&quot;startqty&quot;:&quot;1&quot;,&quot;discount&quot;:&quot;&quot;}]" type="hidden">
			<input name="productInventorylist" id="productInventorylist" value="" type="hidden">
			<input name="sourceItemcode" id="sourceItemcode" value="" type="hidden">
			<input name="attrlist" id="attrlistid" value="" type="hidden">
			<input name="tdProSaleSetId" id="tdProSaleSetId" value="" type="hidden">
			<div style="display:none;" id="div_attrlistid">
				[{"attrId":99,"attrName":"BRAND","attrNameCn":null,"buyAttr":null,"class":"com.dhgate.syi.model.ProductAttributeVO","hasattrval":null,"hasspecification":null,"isUsedSaleAttr":"0","isbrand":"1","iscustomsized":null,"itemcode":null,"l2supplierid":null,"prodAttrId":null,"productid":null,"saleAttr":null,"selectedattrid":null,"selectedattrvalid":null,"selectedbuyid":null,"selectedsaleid":null,"selfDefine":null,"style":null,"type":null,"valueList":[{"attrId":null,"attrName":null,"attrValId":99,"brandsVO":null,"catePubAttrvalId":null,"class":"com.dhgate.syi.model.ProductAttributeValueVO","iscustomsized":"0","isprivate":null,"isselected":null,"isverified":null,"itemcode":null,"l2supplierid":null,"lineAttrvalName":"","lineAttrvalNameCn":"","marker":null,"picUrl":"","prodAttrId":null,"prodAttrValId":null,"productid":null}]}]
			</div>
			<input name="sourcetype" id="sourcetype" value="" type="hidden">
		</div>
	</div>
	</div>
  			</div>
</form>

<#--
<div id="postHelp" style="display: block;">
	<a class="postclosed helpicon" href="#"></a>
	<div class="posthelpbox" id="layouttip">
		<h2>帮助信息</h2>
		<span>
			<strong>产品标题</strong>
		</span>
		<span>产品标题是匹配关键词搜索、影响产品曝光率的关键，最多可以填写140个字符，可以包括产品基本功能、特点、性能等。</span>
		<span>例如：Brand New Men's long sleeve shirt 100% cotton five colors 10pcs/lot drop shipping(风格+颜色+款式+配饰+布料+促销信息+打包方式+是否支持代发货等)</span>
		<span style='display:none'>
			<a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0201&amp;artid=B0565B802FE5676DE04010AC0B642EEE" target="_blank">查看产品标题设置技巧</a>
		</span>
		<div id="helpTipid" style="display:none">productnameTip</div>
	</div>
	<div id="helpTipid" style="display:none">default</div>
</div>
-->

<!--丢失属性产品提示弹层 开始-->
<div class="new-guide-step1 png_bg j-dialog-missattribute" style="display:none;">
	<div class="guidetxtbox">
		由于类目升级，您当前编辑的产品所属类目属性已改变，您可以点击<span class="rcolor">产品填写参考</span>查看变更前的产品信息。
	</div>
	<span class="guide-iknow j-closer" conduct="iknow">我知道了~</span>
	<div class="guide-arrow001 png_bg"></div>
	<a class="guide-close-button png_bg j-closer" href="javascript:void(0);" conduct="iknow"></a>
</div>
<!--丢失属性产品提示弹层 结束-->

<!-- 返回修改类目提示弹层 开始 -->
<div class="j-dialog-returncategory" style="width:400px;display:none">
	<div class="box1 clearfix">
		<p class="j-dialog-msg p1">由于类目升级，您当前修改的产品所属类目已改变，请您先重新选择类目后再继续修改产品信息。</p>
		<div class="align-center pop-button clearfix">
			<span class="yellowBtn valmiddle j-btn-return"><input value="返回修改类目" type="button"></span>
		</div>
	</div>
</div>
<!-- 返回修改类目提示弹层 结束 -->

<#--
<script type="text/javascript" src="/portal/seller/images/product/syisku.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/editor_config.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/editor_all.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/dhedite.js"></script>	
<script type="text/javascript" src="/portal/seller/images/product/newSyiMain.js"></script><div><div class="j-dialog-loading" style="display:none;width:900px;"><div class="syiloadding"></div></div><div class="j-dialog-previewprice" style="display:none;width:900px;"></div></div>
-->
<script type="text/javascript">
	function showBrandsAndAttrib(productTypeCategoryId){
		$.getJSON('<@ofbizUrl>/getProductBrandsAndAttr</@ofbizUrl>',{productCategoryId:productTypeCategoryId},function(r){
			if(r){	
				//显示品牌数据
				//var elm=$('#brandName');
				//elm.html("<option value='-1'>请选择品牌</option>");
				//$(r.brands).each(function(){
				//	elm.append("<option value='"+this.id+"'>"+unescape(this.brandName)+"</option>");
				//});	
				//显示自定义属性
				var f={},str='';
				if(r.attribs)$(r.attribs).each(function(i){
					var g=this.attributeGroupId,val;
					
					str+='<tr id="background_tr"><td class="border03 width15">'+this.attributeName+'：</td><td class="border02 width85">';
					switch(this.entryWay){
						case 'TEXT':
							str+='<input type="text" name="attr_'+this.attributeId+'" id="'+this.attributeId+'" class="input200" maxlength="30"/>';break;
						case 'TEXTAREA':
							str+='<textarea name="attr_'+this.attributeId+'" cols="45" rows="5" class="textarea01" maxlength="120" id="'+this.attributeId+'"></textarea>';break;
						case 'SELECT':
							str+='<select name="attr_'+this.attributeId+'" id="'+this.attributeId+'"><option value="">请选择</option>';
							val=this.inputValue;
							if(val){
								$(val).each(function(){
									str+='<option value="'+escape(this.optionalId)+'">'+this.optionalName+'</option>';
								});
							}
							str+='</select>';
					}
					str+='<span id="msg_'+this.attributeId+'" style="display:none" class="err"></span>';
					str+='</td></tr>';
				});	
				$('#attribBody').html(str);		
			}
		})
	}	
	var f=document.syi_form,ret=[],ret1=[],getFormValue=function(isA,k,i,n){//获取表单值
 		var elms=f[n?(k+'['+i+']['+n+']'):k];
 		if(elms){
 			if(isA){
 				var vs=[];
 				$(elms).each(function(){
 					vs.push(this.value)
 				});
 				return vs 
 			}
 			return elms.value
 		}
	};
	//保存规格
	function changeFeatrueValues(){
		$("#goodType").val("specGood");
		//var specIds=getFormValue(1,'specId'),b;
		var specIds=[],b,ret=[];
		$.each($("#specTable").find('input[name=specId]'),function(i,ele){
			specIds.push(ele.value);
		});
		
		//把表单数据封闭成规格值
		$(specIds).each(function(){
			var sId=this,obj={specId:sId, name:decodeURIComponent(getFormValue(0,"n["+sId+"]")), 'type':getFormValue(0,"t["+sId+"]"), values:[]},valIds=getFormValue(1,'v['+sId+']');
			if(valIds){
				$(valIds).each(function(){
					var vId=this,v=getFormValue(0, 'd', vId, 'v');
					if(v){
						//获取tr的索引，用来做规格排序用
						var elmId='val'+vId,tr=$('#'+elmId).parents('tr:first')[0];//orderNum:getFormValue(0, 'd', vId, 'n')
						specValue={valId:vId, value:v, orderNum:tr.rowIndex, type:obj.type, specId:sId, sysVal:getFormValue(0, 'd', vId, 'sysVal')};
						obj.values.push(specValue);
					}
				});		
				ret.push(obj);
			}else{
				b=1;
				//alert('请添加至少一个“'+obj.name+'”规格值!');
	       	 	$('#specsBody').empty();
				return 0
			}
		});
		if(!b){
			//回调函数
			funBack(ret);
			$("#ret").data("ret",ret);
		}
	}
	var needNewThead = <#if entity?? && specValueList??>false<#else>true</#if>;
    function funBack(a){//获取规格值
	  	var specArr=a,trData=[];
	  	var html='',vhtml='';
	  	//增加表头
	  	html+='<tr class="title02">';
	  	//html+='<td class="border07 width15">商品编号</td>';
	  	$(specArr).each(function(){
	      	var specId=this.specId,type=this.type;
 		  	//表头列
	      	html+='<td class="border07">'+this.name+'</td>';	      
  	      	//规格值隐藏变量      
	  		html+='<input type=hidden name="specId" value='+specId+' />';
	      	html+='<input type=hidden name=st['+specId+'] id=st['+specId+'] value='+type+' />';
	      	var c = 0;
     	 	$(this.values).each(function(n){
	         	var valId=this.valId,elm;
         		html+='<input type=hidden name="valId_'+specId+'_'+ c +'" value='+valId+' />';
	         	html+='<input type=hidden name="valId['+specId+']" id="valId['+specId+']" value='+valId+' />';
	         	html+='<input type=hidden name="sv['+valId+'][val]" id="sv['+valId+'][val]" value='+this.value+' />';
	         	html+='<input type=hidden name="sv['+valId+'][sysVal]" value="'+this.sysVal+'"/>';//系统规格值(用来显示)
	         	if(this.orderNum)html+='<input type=hidden name="sv['+valId+'][ord]" value="'+this.orderNum+'"/>';
	         	c++;
         	});
 		});
     	//updateSpecColumns(specArr);
     	html+='<td class="border07 ">美元</td>';
     	html+='<td class="border07 ">卢比</td>';
     	html+='<td class="border07 ">人民币</td>';
     	html+='<td class="border07 ">库存数量</td>';
     	html+='<td class="border07 width5">图片</td>';
     	//html+='<td class="border06 width5">操作</td>';
     	html+='</tr>';
     	if(needNewThead){
     		$('#specsHead').html(html);
     		needNewThead = false;
     	}
     	last_add=0;
     	$.each($("input[name=rid]"),function(i,obj){
     		var tempVal = obj.value;
     		if(tempVal && parseInt(tempVal)>last_add)last_add=tempVal;
     	});
     	var alreadyExists = {};
     	$.each($('input[name=flagIdList]'),function(i,k){
     		alreadyExists[k.value] = k.id;
     	});
     	//如果是第一次开启规格才生成货品
     	//***var rid=$('#specsBody tr:last input[name="rid"]').val()||0;
     	//***if(rid==0){	
			//把数据转为行数据
			specToRow(trData, [], specArr,0,specArr.length);
			//增加数据
	        $(trData).each(function(){
	        	var flagValue = '';
				$(this).each(function(i,obj){
					flagValue+='@'+obj.valId+'_';
				});
				if(flagValue.length>0){
					flagValue = flagValue.substring(0,flagValue.length-1);
				}
				if(alreadyExists[flagValue]){
					//var existTr = $("tr[name="+alreadyExists[flagValue]+"]")[0].outerHTML;
					//vhtml += existTr;
					alreadyExists[flagValue] = undefined;
				}else{
		      		vhtml += addRow(0, ++last_add, this)
		      	}
	       	}); 
	       	$.each(alreadyExists,function(k,v){
	       		if(v)$("tr[name="+v+"]").remove();
	       	});
	        //$('#specsBody').html(vhtml);
	        $('#specsBody').append(vhtml);
	        $('#specsDiv').show();
	        $('#specGoodDiv').show();
     	/***}else{
			if($('#specsDiv').css('display')=='none'){
				$('#specsDiv').show();
        	}
	 	}***/
     	vhtml=null;       	       			
     	html=null;
 	}
 	updateSpecColumns=function(newSpecs){	
		//更新规格对应的td
		var specIds=getSaveFormValue(1,'specId'),state={};//原规格Id
		$(specIds).each(function(){//获取原来的规格
			var specId=this;
			state[specId]=0;
		});
		//生成cell
		$('#specsBody tr').each(function(i){ 
			var h='',tr=this,td=$(tr).children('td:eq(1)'),rid=$(tr).find("input[name='rid']").val();
			$(newSpecs).each(function(){
				if(specId){
					  var specId=this.specId,cell=$(tr).children('td[specId='+specId+']');
					  if(!cell.length)
						    h+='<td class="border07" specId="'+specId+'">'+addCell(1, rid, specId)+'</td>';
					  else
							  td=cell;
					  state[specId]=1;
				  }
			})
			if(h&&td)td.after(h);
		});		
		//移除已经被删除的规格
		$('#specsBody tr td[specId]').each(function(){
			var specId=$(this).attr('specId');
			if(!state[specId])$(this).remove();
		});
		return state
	}	
	var fn_n=function(preStr,i){//生成变量名
		return preStr+i;
	}
	var last_add=0;
	var fn=function(i,n){
		//生成变量名
		return 'vvv['+i+']['+n+']';
	}	
	//(0, ++0, trData->)
	addRow=function(ept, i, colsData){
		//增加子商品行
		var h='<tr name="flagIdList'+i+'">';
		//商品序号
		//h+='<input type="hidden" name="rid" value="'+i+'"/>';
		var flagValue = '';
		$(colsData).each(function(){
			flagValue+='@'+this.valId+'_';
		});
		if(flagValue.length>0){
			flagValue = flagValue.substring(0,flagValue.length-1);
		}
		h+='<input type="hidden" name="flagIdList" id="flagIdList'+i+'" value="'+flagValue+'"/>';

		//h+='<td class="border07"><input type="text" name="'+fn_n('sp_goodsNo_',i)+'" class="input100 textInput" value="" maxlength="30" size="5"/></td>';
		//显示规格值
		$(colsData).each(function(){	
			h+='<td class="border07" specId="'+this.specId+'">'+addCell(ept, i, this)+'</td>';
		});
	    h+='<td class="border07"><input type="text" name="'+fn_n('sp_price_',i)+'"    size="5"/>';
	    h+='<td class="border07"><input type="text" name="'+fn_n('sp_ZhPrice_',i)+'" class="specTxt textInput digits" maxlength="10" size="5"/></td>';
	    h+='<td class="border07"><input type="text" name="'+fn_n('sp_RuPrice_',i)+'" class="specTxt textInput digits" maxlength="10" size="5"/></td>';
	    h+='<td class="border07"><input type="text" name="'+fn_n('sp_inventory_',i)+'" class="specTxt textInput digits" maxlength="10" size="5"/></td>';
	    h+='<td class="" style="width:30px;"><input type="hidden" name="imgUrl_'+i+'"  id="imgUrl_'+i+'"><input  type=\"file\" onchange=\"fileImport(\'imgPath_'+i+'\')\"  name=\"imgPath_'+i+'\"  id=\"imgPath_'+i+'\" /><img src=\"\" id=\"logoPhoto_'+i+'\" style=\"width:30px;heigth:30px;\"></td>';
	    //h+='<td class="border06"><input name="input3" type="button" class="input02" value="删除" onclick="delComm(this,'+i+')"/></td>';
	    h+='</tr>';		
		return h
	}

	specToRow=function specToRow(r, p, a, i, l){
		/*
		返回规格每个tr的数据数组
		r:返回数值
		p:当前路径数组
		a:源数据数组
		i:当前处理索引
		l:源数据数组长度
		*/
		if(i<l){
			var values=a[i].values;
			if(i+1==l){
				$(values).each(function(){
					r.push(p.concat(this));
				});
			}else{
				$(values).each(function(){
					p.push(this);
					specToRow(r, p, a, i+1, l);
					p.pop();
				});			
			}
		}
	}
	addCell=function(ept, i, cellData){
		//增加列
		var h='';
		if(ept){
			var onclick='showSpecValuesLay(this,'+i+',\'a\','+cellData+',-1)';
			h+='<span class="specMenu" onclick="'+onclick+'">请选择</span><input type=hidden name="'+fn(i,'spec'+cellData)+'"/>';
		}else{
			var onclick='showSpecValuesLay(this,'+i+',\'u\','+cellData.specId+','+cellData.valId+')';
			if(cellData.type=='1'){
	    		h+='<input type=hidden name="'+fn(i,'spec'+cellData.specId)+'" value="'+cellData.value+'"/><img class="specImage" onclick="'+onclick+'" src="'+cellData.image+'" alt="'+cellData.value+'" name="" width="26" height="26" align="absmiddle" style="background-color: #006699" />';
			}else{
				h+='<input onclick="'+onclick+'" size="5" type="text" name="'+fn(i,'spec'+cellData.specId)+'" class="specTxt" value="'+cellData.value+'" readonly />';
			}
			h+='<input type="hidden" name="'+fn(i,'valId'+cellData.specId)+'" id="'+fn(i,'valId'+cellData.specId)+'" value="'+cellData.valId+'"/>' 
		}		
		return h		
 	}
 	//添加一个货品
 	$('#btnAddGood').click(function(){
 		//如果已经打开规格
		var a=getSaveFormValue(1,'specId');
 		if(a&&a.length){
 			var html,rid=$('#specsBody tr:last input[name="rid"]').val()||0,i;
 			if(rid||rid==0){
 				var specIds=getSaveFormValue(1,'specId'),rid=parseInt(rid)+1;
				//新增商品序号
				html = addRow(1, rid, specIds)
 				$('#specsBody').append(html);
 			}
 		}
 	});
 	//关闭规格
 	$('#btnCloseSpec').click(function(){
 		var productId=$('#productId').val(),fn=function(){
 			$('#specsDiv').hide();
 			$('#specsBody').empty();
			//显示全局
			$('#globalInfo').show(); 
			
 		};
		if(confirm('关闭规格后现有已添加商品的数据将全部丢失,确认要关闭规格吗?')){
			if(productId){
				$.getJSON('<@ofbizUrl>/findProductOrderAssoc</@ofbizUrl>',{productId:productId},function(r){
					if(r&&r.status=='ok'){ 	
						fn()
					}else{
						alert('由于该商品有订单存在,暂不能关闭规格!')
					}
				});				
			}else{
				fn()
			}
		}
 	});
 	//获取表单值getEditValue('sv',vId,'val')
 	var getEditValue=function(pre, id, name){
 		var k = pre+'['+id+']'+(name?'['+name+']':''),v=getSaveFormValue(0,k);
 		return v
 	};
 	//删除子商品
 	window.delComm=function(elm, rid){
 		var productIdTo=getEditValue('v',rid,'cid');
	 	if(confirm('商品删除后将不能恢复，确认要删除?')){	
			if(productIdTo){
				$.getJSON('<@ofbizUrl>/findProductOrderAssoc</@ofbizUrl>',{<#if productId?has_content>productId:${productId?if_exists},</#if>productIdTo:productIdTo},function(r){
					if(r){
						if(r.status=='ok')
							$(elm).parents('tr').remove()
						else if(r&&r.num)
							alert('由于商品存在订单删除失败!');
					}
				}); 		
	 		}
			else{
 				$(elm).parents('tr').remove()
 			}	 		
 		}
 	}
 	var fEd=document.syi_form;
   function getSaveFormValue(isA,k){
   		//获取表单值
 		var elms=fEd[k];
 		if(elms){
 			if(isA){
 				var vs=[];
 				$(elms).each(function(){
 					vs.push(this.value)
 				});
 				return vs 
 			}
 			return elms.value
 		}
 	}
	//增加规格值
	function add(id, vid, type, value, image, pdtImgs,sysVal,checkElement){
		if(!checkElement.checked){
			if(confirm("确认取消该属性值？\n提示：该操作将删除对应表格列造成输入数据无法恢复！")){
			}else{
				$(checkElement).attr("checked",true);
				return false;
			}
		}
		var s='' , elmId='val'+vid;
		if(checkElement.checked){
			if($('#'+elmId).length==0){//如果规格不存在才添加
				var h='<input type=hidden id='+elmId+' name=v['+id+'] value="'+vid+'"/>';
				if(type=='1'){//图片规格
					s+='<tr id="tr_'+id+'_'+vid+'">';
		            s+='<td class="border06">'+h+'<img src="'+(sysVal||image)+'" width="20" height="20" alt="'+value+'"/><input type=hidden name=d['+vid+'][sysVal] value="'+(sysVal||image)+'"/></td>';
		            //s+='<td class="border07"><input name=d['+vid+'][v] type="text" value="'+value+'" class="input40" /></td>';
		            s+='<td class="border07"><img id="img['+vid+']" src="'+image+'" width="20" height="20" align="absmiddle" /><span>'+getFlash(vid)+'</span></td>';
		            s+='<td class="border07"><span id=span'+vid+'>'+getRelaImg(vid, pdtImgs)+'</span><input type="button" class="input02" value="选择" onclick="select_image('+vid+')"/></td>';
		            s+='<td class="border07"><img src="/portal/seller/images/up.png" alt="向上" onclick="up(this)"/><img src="/portal/seller/images/down.png" alt="向下" onclick="down(this)"/><img src="/portal/seller/images/delete.gif" alt="删除该规格" onclick="del(this,'+vid+')"/></td>';
		           	s+='</tr>'
				}else{
					s+='<tr id="tr_'+id+'_'+vid+'"><td class="border06">'+h+'<input name="d['+vid+'][sysVal]" type="text" value="'+(sysVal||value)+'" class="input40" readonly=readonly /></td>';
		            s+='<td class="border07" style="display:none;"><input name=d['+vid+'][v] type="hidden" value="'+value+'" class="input40" /></td>';
		            s+='<td class="border07"><img src="/portal/seller/images/up.png" alt="向上" onclick="up(this)"/><img src="/portal/seller/images/down.png" alt="向下" onclick="down(this)"/><img src="/portal/seller/images/delete.gif" alt="删除该规格" onclick="del(this,'+vid+')"/></td>';
		            s+='</tr>'
				}
				$('#specBody'+id).append(s);
			}
		}else{
			$('#tr_'+id+'_'+vid).remove();
		}
		//changeFeatrueValues();//修改表格生成
	}; 	
//更新规格值
window.uptSpecValue=function(elm, i, specId, specValueId, value, image){
	var h=addCell(0, i, {specId:specId, valId:specValueId, type:getEditValue('st',specId), value:value, image:image});
	$('#specLay').hide();
	//如果已有vvv规格 则不添加
	//var specName=fn(i,'spec'+specId);
	//if($("#syi_form").find("[name='+specName+']").length==0){
		$('#specsBody input[name="'+fn(i,'spec'+specId)+'"]').parents('td:first').html(h);
	//}
}
	$(document).ready(function () {
		<#if !entity??>
		showBrandsAndAttrib('${productTypeCategoryId}');//获取属性
		</#if>
		/*
        $("#syi_chat_window" ).live("click", function (e) {
            e.preventDefault();
			openSyiChatWindow();
            return false;
        }); */
	});
    $(document).ready(function(){
	    //$("html").css({ "overflow":"hidden"});
	    $("body").css({ "overflow-x":"hidden"});
  
    });
<#-- 
     //初始化数据
    var pid = $('#productid').val();
    var g_user_cate_punish_array = [];
	

			g_category = {"admittanceDto":null,"attributeList":null,"catePubId":"014024002","categoryPath":null,"categoryPathChinese":null,"children":null,"excludeKeywords":null,"inlucdeKeywords":null,"leaf":"1","minPrice":null,"pareCatePubId":"014024","prodLineId":15203,"pubName":"Fabric","pubNameCn":"布料","remark":"布料辅料","selected":false,"stockPeriod":2,"stockWarnRatio":0.1,"updateBy":"aa8824ed91514b30e04010ac0b646c2d","updateTime":1337329861000,"valid":"1"};
	    		 g_bInitProductData=false;
		 	 	g_inventory_list = null;
	      $(document).ready(function () {
    	// 初始化价格
		//initProductSpecification();
		
        // 价格区间备货期上方的提示层注册事件
        /*
        $("#inventoryperiodknow" ).live("click", function (e) {
        	e.preventDefault();
    		knowInventoryPeriodHip();
            return false;
        }); */
     });
    -->
        
      
function fileImport(fileId){
	var fileValue = $("#"+fileId).val();
	if(fileValue!=''){
		var flag = true;
		var extName = fileValue.substring(fileValue.lastIndexOf(".")+1,fileValue.length);
		if(extName !="jpg" && extName !="png"){
			flag = false;
		}	
		if(flag){
			$("#syi_form").attr("enctype","multipart/form-data");
			$("#syi_form").attr("encoding","multipart/form-data");
			$("#syi_form").attr("target","fileName_iframe");
			$("#syi_form").attr("action","commonAjaxFileUpload?fileId="+fileId);
			$("#syi_form").submit();
		}else{
			alert("格式不正确，请上传图片文件，扩展名为.jpg或者.png");
		}
	}else{
		alert("请选择文件");
	}
}

function fileImport_callBack(filePath,fileName,fileId){
    var action='<#if entity?has_content>updateProductEn<#else>createProductEn</#if>';
	$("#syi_form").attr("enctype","application/x-www-form-urlencoded");
	$("#syi_form").attr("encoding","application/x-www-form-urlencoded");
	$("#syi_form").attr("target","");
	$("#syi_form").attr("action",action);
	var num = fileId.substring(fileId.indexOf("_")+1,fileId.length);
	if(fileId=='imgPath_'+num){
		$("#logoPhoto_"+num).attr("src",filePath);
		//$("#imgPath_"+num).val(filePath);
		$("#imgUrl_"+num).val(filePath);
	}
}

function validFormFields(){
	var internalName = $("#internalName").val();
	var inventory = $("input[name=inventory]").val();
	var price1 = $("input[name=price_1]").val();
	var price2 = $("input[name=price_2]").val();
	var price3 = $("input[name=price_3]").val();
	var imgs = $("input[name^='[path]']");
	if(!internalName){
		alert("产品标题不能为空");
		return false;
	}
	if(!inventory){
		alert("备货数量不能为空");
		return false;
	}
	if(!price1&&!price2&&!price3){
		alert("价格不能为空");
		return false;
	}
	if(imgs.length==0){
		alert("商品图片不能为空");
		return false;
	}
	document.syi_form.submit();
}
</script>

<iframe name="fileName_iframe" style="display:none"></iframe>

<div></div>
<div style="display: none;" class="dh-dialog-1418433940789">
	<table class="noshade-pop-table j-dialog-container">
		<tbody>
			<tr>
				<td class="t-lt"></td>
				<td class="t-mid"></td>
				<td class="t-ri"></td>
			</tr>
			<tr>
				<td class="m-lt"></td>
				<td class="m-mid">
					<div class="mid-warp">
						<div class="noshade-pop-content">
							<div class="noshade-pop-title j-dialog-title-container">
								<span class="j-dialog-title">操作提示</span>
							</div>
							<div class="noshade-pop-inner j-dialog-inner-container"></div>
							<div class="noshade-pop-bot j-dialog-bot-container"></div>
						</div>
						<a href="javascript:;" class="noshade-pop-close j-dialog-closer"></a>
					</div>
				</td>
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
	<div style="display: none;" class="dh-dialog-1418433940792">
		<table class="noshade-pop-table j-dialog-container">
			<tbody>
				<tr>
					<td class="t-lt"></td>
					<td class="t-mid"></td>
					<td class="t-ri"></td>
				</tr>
				<tr>
					<td class="m-lt"></td>
					<td class="m-mid">
						<div class="mid-warp">
							<div class="noshade-pop-content">
								<div class="noshade-pop-title j-dialog-title-container">
									<span class="j-dialog-title">操作提示</span>
								</div>
								<div class="noshade-pop-inner j-dialog-inner-container"></div>
								<div class="noshade-pop-bot j-dialog-bot-container"></div>
							</div>
							<a href="javascript:;" class="noshade-pop-close j-dialog-closer"></a>
						</div>
					</td>
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
	<div style="display: none;" class="dh-dialog-1418433940793">
		<table class="noshade-pop-table j-dialog-container">
			<tbody>
				<tr>
					<td class="t-lt"></td>
					<td class="t-mid"></td>
					<td class="t-ri"></td>
				</tr>
				<tr>
					<td class="m-lt"></td>
					<td class="m-mid">
						<div class="mid-warp">
							<div class="noshade-pop-content">
								<div class="noshade-pop-title j-dialog-title-container">
									<span class="j-dialog-title">操作提示</span>
								</div>
								<div class="noshade-pop-inner j-dialog-inner-container"></div>
								<div class="noshade-pop-bot j-dialog-bot-container"></div>
							</div>
							<a href="javascript:;" class="noshade-pop-close j-dialog-closer"></a>
						</div>
					</td>
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
	<div style="display: none;" class="dh-dialog-1418433940795">
		<table class="noshade-pop-table j-dialog-container">
			<tbody>
				<tr>
					<td class="t-lt"></td>
					<td class="t-mid"></td>
					<td class="t-ri"></td>
				</tr>
				<tr>
					<td class="m-lt"></td>
					<td class="m-mid">
						<div class="mid-warp">
							<div class="noshade-pop-content">
								<div class="noshade-pop-title j-dialog-title-container">
									<span class="j-dialog-title">操作提示</span>
								</div>
								<div class="noshade-pop-inner j-dialog-inner-container"></div>
								<div class="noshade-pop-bot j-dialog-bot-container"></div>
							</div>
							<a href="javascript:;" class="noshade-pop-close j-dialog-closer"></a>
						</div>
					</td>
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
	<div class="j-dialog-relatedproduct" style="width:780px;display:none">
		<div class="poppad01">
			<div class="public-lr-box clearfix">
				<div class="public-r-box">
				<span><input value="模板名称" class="public-txt-input color999 marginright10 j-temp-name" type="text"></span>
				<span class="tourBtn"><input value="搜 索" class="j-btn-search" type="button"></span>
			</div>
			<div class="public-l-box marginleft10">
				<span>最多可以选择<b class="colorf50">3</b>个关联产品模板</span>
			</div>
		</div>
		<!-- 列表 开始 -->
		<div class="bg-list rew-bg">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
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
			<table class="j-temp-list" width="100%" border="0" cellpadding="0" cellspacing="0"></table>
		</div>
		<!-- 列表 结束 -->
		<!--分页 开始-->
		<div class="commonpage j-relatedproduct-pager">
		</div>
		<!--分页 结束-->
		<div class="margintop10 marginlr10 clearfix j-view-list">
		</div>
		<div class="tips-common j-error-tip" style="display:none;">
			<span class="tips-error">错误提示</span>
		</div>
	</div>
	<div class="box1">
		<div class="align-center clearfix">
			<span class="bigyellow-button valmiddle marginright10">
				<input class="j-btn-confirm" value="确 定" type="button">
			</span>
			<span class="biggrey-button">
				<input class="j-btn-cancel" value="取 消" type="button">
			</span>
		</div>
	</div>
</div>
<div style="display: none;" class="dh-dialog-1418433940902">
	<table class="noshade-pop-table j-dialog-container">
		<tbody>
			<tr>
				<td class="t-lt"></td>
				<td class="t-mid"></td>
				<td class="t-ri"></td>
			</tr>
			<tr>
				<td class="m-lt"></td>
				<td class="m-mid">
					<div class="mid-warp">
						<div class="noshade-pop-content">
							<div class="noshade-pop-title j-dialog-title-container">
								<span class="j-dialog-title">操作提示</span>
							</div>
							<div class="noshade-pop-inner j-dialog-inner-container">
							</div>
							<div class="noshade-pop-bot j-dialog-bot-container">
							</div>
						</div>
						<a href="javascript:;" class="noshade-pop-close j-dialog-closer"></a>
					</div>
				</td>
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
<div class="guidedbox" id="idPop_e" style="display: none; position: fixed; z-index: 3001;">
	<div class="box">
		<div id="guidedBoxImgList">
		</div>
		<a class="guidedclosed" id="close_e" onclick="idPopSave();"></a>
		<div class="guided-steps-box">
			<div class="gsboxleft" style="display:none">
				<span id="pagenumbox">1</span>/<span class="pageallnum">6</span>
			</div>
			<div class="gsboxright">
				<ul id="guidedBoxBtnList">
					<li><span class="guidestartread">开始浏览新变化</span><span class="guideiknow" id="close_e_1" onclick="idPopSave();">我知道了</span></li>
					<li><span class="guidednext">下一步</span></li>
					<li><span class="guidedpre">上一步</span><span class="guidednext">下一步</span></li>
					<li><span class="guidedpre">上一步</span><span class="guidednext">下一步</span></li>
					<li><span class="guidedpre">上一步</span><span class="guidednext">下一步</span></li>
					<li><span class="guidedpre">上一步</span><span class="guidednext">下一步</span></li>
					<li><span class="guidedpre">上一步</span><span class="guideend" id="close_e_2" onclick="idPopSave();">完成</span></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="greybox"></div>
	<input id="ViewNewUserWizard" type="hidden">
</div>

<script type="text/plain" id="guidedBoxLazyLoadImg" name="elm">
	<div>
		<img src="http://www.dhresource.com/dhs/mos/image/syi/new/img.jpg" width="698" height="373" />
	</div>
	<div>
		<img src="http://www.dhresource.com/dhs/mos/image/syi/new/img001.jpg" width="698" height="373" />
	</div>
	<div>
		<img src="http://www.dhresource.com/dhs/mos/image/syi/new/img002.jpg" width="698" height="373" />
	</div>
	<div>
		<img src="http://www.dhresource.com/dhs/mos/image/syi/new/img003.jpg" width="698" height="373" />
	</div>
	<div>
		<img src="http://www.dhresource.com/dhs/mos/image/syi/new/img004.jpg" width="698" height="373" />
	</div>
	<div>
		<img src="http://www.dhresource.com/dhs/mos/image/syi/new/img005.jpg" width="698" height="373" />
	</div>
	<div>
		<img src="http://www.dhresource.com/dhs/mos/image/syi/new/img006.jpg" width="698" height="373" />
	</div>
</script>
<div id="idPop_helpIconShow" style="display: none; position: fixed; z-index: 3001;">
	<table style="width:373px; display:;" class="noshade-pop-table">
		<tbody>
			<tr>
				<td class="t-lt"></td>
				<td class="t-mid"></td>
				<td class="t-ri"></td>
			</tr>
			<tr>
				<td class="m-lt"></td>
				<td class="m-mid">
					<div class="mid-warp">
						<div class="noshade-pop-content">
							<div class="noshade-pop-inner">
								<div class="noshade-pop-title">
									<span>温馨提示</span>
								</div>
								<div class="boxcenter clearfix">
									<p>帮助信息已经关闭！<br>如果您需要再次查看帮助，请点击帮助提示图标<img class="ver-align-middle marginleft10" src="/portal/seller/images/product/help.png"></p>
									<span class="tourBtn"><input value="知道了" id="idPop_help_close02" type="button"></span>
								</div>
							</div>
							<div class="noshade-pop-bot"></div>
							<a id="idPop_help_close01" href="#" onclick="document.body.onbeforeunload=null;" class="noshade-pop-close"></a>
						</div>
					</div>
				</td>
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
	
<div class=" edui-default" style="position: fixed; left: 0px; top: 0px; width: 0px; height: 0px;" id="edui_fixedlayer">
	<div style="display: none;" id="edui89" class="edui-popup  edui-bubble edui-default">
		<div id="edui89_body" class="edui-popup-body edui-default">
			<iframe class=" edui-default" style="position:absolute;z-index:-1;left:0;top:0;background-color: transparent;" src="javascript:" frameborder="0" height="100%" width="100%"></iframe>
			<div class="edui-shadow edui-default"></div><div id="edui89_content" class="edui-popup-content edui-default">
			</div>
		</div>
	</div>
</div>