       <div class="main-wrap">
          <div class="main-content">
            <div class="ui-tab ui-tab-primary detail-tab ui-switchable" data-widget-cid="widget-29">
              <ul class="ui-tab-nav ui-switchable-nav" style="width: 960px;">
                <li class="ui-switchable-trigger ui-tab-active"> <a ><font> ${uiLabelMap.PortalUserPayProductDetails}</font></a> </li>
                <!--<li class="ui-switchable-trigger"> <a > <font>${uiLabelMap.DeliverytimecostCf}</font></a> </li>
                <li class="ui-switchable-trigger"> <a > <font>${uiLabelMap.PaymentCf}</font></a> </li>-->
                <li class="ui-switchable-trigger"> <a  onclick="changeShowText(this,'pdtReview')"> <font>${uiLabelMap.BuyerReviewsCf}</font></a> </li> 
                <#-- <li class="ui-switchable-trigger"> <a href="javascript:void(0)"><font>交易历史 </font></a> </li>  -->
              </ul>
              <div class="ui-tab-body ui-switchable-content">
                <div id="pdt" class="ui-tab-pane ui-switchable-panel" style="display: block;">
                  <div id="product-desc" class="product-desc">
                  	 <#assign ProductAttributeList = delegator.findByAnd("Product", {"productId" : productId}, null, false)>
					        <#if ProductAttributeList??>
							    <#list ProductAttributeList as attr> 
							     <#if (attr.description??)>
				                    <div class="ui-box ui-box-normal product-params">
				                      <h2 class="ui-box-title"><font>${uiLabelMap.ProductDescriptionCf}</font></h2>
				                      <div class="ui-box-body">
				                        <dl class="ui-attr-list util-clearfix">
				                          <div class="params">
											    <dl>  
										 			<!-- <dt><span class="brand"></span></dt> -->
															<dd style="margin-left:0px;">
					                                          ${attr.description!}
															</dd>
				 							    </dl>			 
				                      		</div>
				                      		</dl>
				                      	</div>
				                    </div>
			                    </#if>
                    	</#list>
					</#if>
                   <#-- <div class="ui-box ui-box-normal product-params">
                      <h2 class="ui-box-title"><font>${uiLabelMap.PortalItemSepcCf}</font></h2>
                      <div class="ui-box-body">
                        <dl class="ui-attr-list util-clearfix">
                          <div class="params">
                                                
	                          	<#assign ProductAttributeList = delegator.findByAnd("ProductAttribute", {"productId" : productId}, null, false)>
					            <#if ProductAttributeList??>
									<#list ProductAttributeList as attr> 
										<#assign TypeAttribute = delegator.findByPrimaryKey("TypeAttribute",Static["org.ofbiz.base.util.UtilMisc"].toMap("attributeId",attr.attrName))?if_exists>
										<dl>  
						 					<dt><span class="brand">${TypeAttribute.attributeName!}:</span></dt>
											<dd title="">
												<#assign language=locale.language>
												<#if "SELECT"=TypeAttribute.entryWay>
													<#assign AttrOptionalValue = delegator.findByPrimaryKey("AttrOptionalValue",Static["org.ofbiz.base.util.UtilMisc"].toMap("optionalId",attr.attrValue))?if_exists>
													<#if AttrOptionalValue??>
															${AttrOptionalValue.optionalName!}
													</#if>
												<#else>
														${attr.attrValue!}
												</#if>	
											</dd>
 										</dl>	
									</#list>
								</#if> 
                      		</div>
                      		</dl>
                      	</div>
                    </div>  -->
                    <div id="custom-description" class="ui-box ui-box-normal product-custom-desc" data-widget-cid="widget-40">
                      <h2 class="ui-box-title"><font>${uiLabelMap.PortalDescriptionCf}</font></h2>
                      <div class="ui-box-body">
                                  <#-- Long description of product -->
						          <div style="clear: both;">${productContentWrapper.get("LONG_DESCRIPTION")?if_exists}</div>
						          <div style="clear: both;">${productContentWrapper.get("WARNINGS")?if_exists}</div>
                        <#-- <div style="clear: both;">
                          <div style="clear: both;">
                            <div> <img alt="HS" src="../images/0010.jpg"></div>
                            <p> <a href="javascript:void(0)"></a></p>
                            <p> <a href="javascript:void(0)"></a></p>
                            <p>&nbsp; </p>
                            <p>&nbsp; </p>
                            <p>&nbsp; </p>
                          </div>
                          <p><img alt="tape" src="../images/0012.jpg"> </p>
                          <p><img alt="tape" src="../images/0013.jpg"> </p>
                          <p> <img alt="tape" src="../images/0014.jpg"> </p>
                        </div> -->
   
                      </div>
                    </div> 
				
			  	
					
					
			  <div id="relate-product-by-keywords" class="ui-box ui-box-normal relate-product-by-keywords">
              <h2 class="ui-box-title"><font>${uiLabelMap.PortalWatchedCf}</font></h2>
              <div class="ui-box-body">
                <div id="rpbk-from-otherseller" class="ui-slidebox ui-slidebox-horizontal util-clearfix" style="visibility: visible;">
                 <#-- <h4 class="ui-box-body-subtitle"><font>${uiLabelMap.PortalSellersCf}</font></h4> -->
                  <div class="ui-slidebox-wrap">
                    <div class="ui-slidebox-container">
                      <div class="ui-slidebox-slider" data-role="slider" style="margin-left: -1px;">
                      
                       ${setRequestAttribute("optExcludeProductStoreId","${(product.primaryProductStoreId)!}")} <!--获取其他  店铺的ID -->
                       ${screens.render("component://portal/widget/CatalogScreens.xml#showProductToRightToFor")}
                       ${setRequestAttribute("optExcludeProductStoreId","")}  <!-- 获取其他   店铺的ID End-->
                        <#-- <ul id="groomSeller">
 
                              <li style="width: 175.6px; visibility: visible;">
                                <div class="ui-slidebox-item" data-product-id="1960977156">
                                  <div class="ui-slidebox-item-thumb"> <a href="javascript:void(0)"> <img src="../images/0021.jpg"> </a> </div>
                                  <div class="ui-slidebox-item-info"> <a class="ui-slidebox-item-title" href="javascript:void(0)"><font>原始Phicomm C230W俄罗斯一口…… </font></a>
                                    <div class="ui-slidebox-item-row ui-cost"><b class="notranslate"><font>47.49美元 </font></b><font>/块 </font></div>
                                  </div>
                                </div>
                              </li>
                              <li style="width: 175.6px; visibility: visible;">
                                <div class="ui-slidebox-item">
                                  <div class="ui-slidebox-item-thumb"> <a href="" rel="nofollow"> <img src="../images/0022.jpg"> </a> </div>
                                  <div class="ui-slidebox-item-info"> <a class="ui-slidebox-item-title" href="javascript:void(0)"><font>DOOGEE匕首DG550 MTK6592八面体C… </font></a>
                                    <div class="ui-slidebox-item-row ui-cost"><b class="notranslate"><font>150.09美元 </font></b><font>/块 </font></div>
                                  </div>
                                </div>
                              </li>
                              <li style="width: 175.6px; visibility: visible;">
                                <div class="ui-slidebox-item">
                                  <div class="ui-slidebox-item-thumb"> <a href=""> <img src="../images/0023.jpg"> </a> </div>
                                  <div class="ui-slidebox-item-info"> <a class="ui-slidebox-item-title" href="javascript:void(0)">小觅Redmi红米1 s 4.7英寸… </font></a>
                                    <div class="ui-slidebox-item-row ui-cost"><b class="notranslate"><font>150.99美元 </font></b><font>/块 </font></div>
                                  </div>
                                </div>
                              </li>
                              <li style="width: 175.6px; visibility: visible;">
                                <div class="ui-slidebox-item">
                                  <div class="ui-slidebox-item-thumb"> <a href=""> <img src="../images/0024.jpg"> </a> </div>
                                  <div class="ui-slidebox-item-info"> <a class="ui-slidebox-item-title" href="javascript:void(0)">Doogee KISSME DG580 5.5英寸MTK65…… </font></a>
                                    <div class="ui-slidebox-item-row ui-cost"><b class="notranslate"><font>109.24美元 </font></b><font>/块 </font></div>
                                  </div>
                                </div>
                              </li>
                              <li style="width: 175.6px; visibility: visible;">
                                <div class="ui-slidebox-item">
                                  <div class="ui-slidebox-item-thumb"> <a href=""> <img src="../images/0025.jpg"> </a> </div>
                                  <div class="ui-slidebox-item-info"> <a class="ui-slidebox-item-title" href="javascript:void(0)">PULID到4.5英寸960 IPS港务x540…… </font></a>
                                    <div class="ui-slidebox-item-row ui-cost"><b class="notranslate"><font>69.99美元 </font></b><font>/块 </font></div>
                                  </div>
                                </div>
                              </li>
                              
                            </ul> -->
                      </div>
                    </div>
                  </div>
                  <div class="ui-slidebox-prev" style=""><a class="" href="javascript:void(0)" data-role="prev" id="groomSellerPrev" onclick="groomSellerLeftRun();">
                   <img src="../images/right.png" /></a></div>
                  <div class="ui-slidebox-next" style=""><a class="" href="javascript:void(0)" data-role="next" id="groomSellerNext" onclick="groomSellerRightRun();">
                   <img src="../images/left.png" /></a></div>
                  </div>
                
              </div>
            </div>
			
            <#--  <div class="related-searches">
              <div class="title"> <strong><font>平板电脑相关类目: </font></strong> </div>
              <a class="width-fix" href=""><font>tk106 gps跟踪器 </font></a> 
              <a class="width-fix" href=""><font>iphone自行车gps </font></a> 
              <a class="width-fix" href=""><font>iphone的gps的自行车 </font></a>
              <div class="view-more-content" id="ralatemorecontent"> 
              <a class="width-fix" href=""><font>iphone的gps跟踪器 </font></a> 
              <a class="width-fix" href=""><font>ip追踪定位器 </font></a> <a class="width-fix" href=""><font>ipad跟踪应用程序 </font></a> 
              <a class="width-fix" href=""><font>iphone股票追踪 </font></a> <a class="width-fix" href=""><font>iphone汽车应用 </font></a> 
              <a class="width-fix" href=""><font>iphone的gps设备 </font></a>
                <div>
                  <div class="title"><strong><font>批发gps tk103: </font></strong></div>
                  <a class="width-fix" href=""><font>批发gps tk </font></a> 
                  <a class="width-fix" href=""><font>批发garmin gps </font></a> 
                  <a class="width-fix" href=""><font>批发汽车gps </font></a> 
                  <a class="width-fix" href=""><font>批发高尔夫gps </font></a> 
                  <a class="width-fix" href=""><font>批发摩托车gps </font></a> 
                  <a class="width-fix" href="">批发导航gps </font></a> 
                  <a class="width-fix" href=""><font>批发gps跟踪器tk103 </font></a> 
                  <a class="width-fix" href=""><font>批发gps gt06 </font></a> 
                  <a class="width-fix" href=""><font>批发gps tk 103 </font></a> 
                  </div>
                <div>
                  <div class="title"><strong><font>gps tk103价格: </font></strong></div>
                  <a class="width-fix" href="">步跟踪器的价格 </font></a> 
                  <a class="width-fix" href=""><font>欧洲跟踪价格 </font></a> 
                  <a class="width-fix" href=""><font>步走的价格 </font></a> 
                  <a class="width-fix" href=""><font>欧洲跟踪价格 </font></a> 
                  <a class="width-fix" href=""><font>优秀的跟踪价格 </font></a> 
                  <a class="width-fix" href=""><font>excel跟踪价格 </font></a> 
                  <a class="width-fix" href=""><font>excel跟踪价格 </font></a> 
                  <a class="width-fix" href=""><font>运动跟踪价格 </font></a> 
                  <a class="width-fix" href=""><font>独家跟踪价格 </font></a> </div>
                <div>
                  <div class="title"><strong><font>gps tk103推广: </font></strong></div>
                  <a class="width-fix" href=""><font>iphone紧急呼叫促销 </font></a> 
                  <a class="width-fix" href=""><font>iphone的gps信号促进 </font></a> 
                  <a class="width-fix" href=""><font>gps运动跟踪促销 </font></a> 
                  <a class="width-fix" href=""><font>步骤柜台促销 </font></a> 
                  <a class="width-fix" href=""><font>步上推广 </font></a> 
                  <a class="width-fix" href=""><font>步骤数计步器促销 </font></a> 
                  <a class="width-fix" href=""><font>excel用户推广 </font></a> 
                  <a class="width-fix" href=""><font>excel用户推广 </font></a> 
                  <a class="width-fix" href=""><font>步骤设计推广 </font></a> 
                  </div>
              </div>
            </div> -->
            
					
                  </div>
                </div>

              </div>
             </div>			
          </div>
        </div> 
        
<script>
	function changeShowText(obj,tId){
		$(obj).parent().parent().find("li").removeClass("ui-tab-active");
		$(obj).parent().addClass("ui-tab-active");
		$("#"+tId).parent().find(".ui-switchable-panel").css("display","none");
		$("#"+tId).css("display","block");
	}
    var show = 0;
    var everyW=180;	//每个商品的宽度
    var everyN=1;	//每次滑动几格
    var sellingGoodsRollWidth=document.getElementById("sellingGoodsRoll").offsetWidth;
    var sellingGoodsRollW=everyW*5*-1
    function groomSellerRightRun(){
    if((sellingGoodsRollWidth*-1)>sellingGoodsRollW){
       	return;
       }
      show-=everyW*everyN;
      if(show<=sellingGoodsRollW){
      	show=sellingGoodsRollW;
      }
      document.getElementById("groomSeller").style.marginLeft = show+"px";
   }
    function groomSellerLeftRun(){
        if((sellingGoodsRollWidth*-1)>sellingGoodsRollW){
       	return;
       }
      show+=everyW*everyN;
      if(show>=0){
      show=0;
      }
      document.getElementById("groomSeller").style.marginLeft= show+"px";
   }
</script>