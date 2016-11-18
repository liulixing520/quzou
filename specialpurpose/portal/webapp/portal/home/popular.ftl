${setRequestAttribute("optViewSize","6")}
<#assign likeProductIds =Static["org.ofbiz.product.store.RecommenderUtil"].youMayLike(request)?if_exists/>

<div class="xihuan">
    <div class="mod-hd">
        <h3><em>${uiLabelMap.PortalPopular}</em></h3>
    </div>
    <div class="popular-box clearfix" style="position: relative; border:1px solid #e8e8e8; width:208px;">
        <div class="popular-view">
            <div class="popular-panel-warp" style="height:513px; width: 208px;">
                <div class="popular-list" style="position: absolute; top: 0px; left: 0px;">
                	<#if likeProductIds?has_content>
                		<#list likeProductIds as productId> 
                		  ${setRequestAttribute("optProductId",  productId)}
                		  ${screens.render("component://portal/widget/CommonScreens.xml#popularList")}
                		   ${setRequestAttribute("optProductId",  "")}
                		</#list>
                	</#if>
                	<#--
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/TP_01.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">圣诞节礼物 圣诞小礼品批发 圣诞老人装饰品</a>
                            <a href="">精品装饰</a>
                            <a href="">装饰品</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/TP_02.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">圣诞节装饰品 金丝绒圣诞帽绒布高档圣诞帽</a>
                            <a href="">精品装饰</a>
                            <a href="">装饰品</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/TP_03.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">圣诞拍拍圈 啪啪圈手腕饰品 手圈活动道具 圣诞老人手腕小礼品</a>
                            <a href="">精品装饰</a>
                            <a href="">装饰品</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_04.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_05.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_06.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                </div>
                <div style="display: none; position: absolute; top: 0px; left: 0px;" class="popular-list">
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_06.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_06.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_06.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_06.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_06.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                    <dl class="clearfix">
                        <dt>
                            <img src="../images/P_06.jpg">
                        </dt>
                        <dd>
                            <a class="first" href="">似水流年礼服</a>
                            <a href="">选美的衣服</a>
                            <a href="">党的礼服</a>
                        </dd>
                    </dl>
                    -->
                </div>
            </div>
        </div>
         <#-- <div class="popular-page popular-trigger-warp clearfix zuoyou" style="z-index: 1;">
          <a href="javascript:void(0);"> < </a><a href="javascript:void(0);"> > </a> 
        </div>-->
    </div>
</div>