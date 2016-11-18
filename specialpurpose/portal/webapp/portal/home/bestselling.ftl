<#if stores?has_content>
<div class="mod bestselling-area" id="weekly-bestsellings">
    <div class="mod-hd">
        <h3>${uiLabelMap.PortalRecommendSeller}</h3>
    </div>
    <div class="mod-box">
        <div class="ui-slidebox util-clearfix" data-widget-cid="widget-39">
            <div class="ui-slidebox-wrap">
                <div class="ui-slidebox-container">
                    <div class="ui-slidebox-slider" data-role="slider" style="margin-left: 0px;">



                        <ul id="groomSeller">
                            <#list stores as store>
                                <#assign productStoreTitleText><@productStoreTitle productStore=store/></#assign>
                                <#assign productStoreSubTitleText><@productStoreSubTitle productStore=store/></#assign>
                                <li style="width: 180px; visibility: visible;">
                                    <a href="<@ofbizUrl>sellerhome?productStoreId=${store.productStoreId}</@ofbizUrl>" title="${productStoreTitleText}">
                                        <div class="bs-pro-img">
                                            <img width="170" height="170" src="${productStore.productStoreLogo}">
                                        </div>
                                    </a>
                                    <br>
                                    <a class="bs_seller" href="<@ofbizUrl>sellerhome?productStoreId=${store.productStoreId}</@ofbizUrl>" title="${productStoreTitleText}">
                                        <p>
                                            ${uiLabelMap.PortalSeller2}：
                                            <#if productStoreTitleText?length gt 64>${(productStoreTitleText[0..64])?if_exists}..<#else>${productStoreTitleText?if_exists}</#if>
                                        </p>
                                    </a>
                                    <a class="bs_seller" href="<@ofbizUrl>sellerhome?productStoreId=${store.productStoreId}</@ofbizUrl>" title="${productStoreSubTitleText}">
                                        <p  style="width:170px;height:40px;text-overflow: ellipsis;word-wrap: normal;overflow: hidden;">
                                            ${uiLabelMap.PortalMainProducts}：
                                            ${(store.subtitle)!"店主无介绍"}
                                            <#if productStoreSubTitleText?length gt 64>${(productStoreSubTitleText[0..64])?if_exists}..<#else>${productStoreSubTitleText?if_exists}</#if>
                                        </p>
                                    </a>
                                </li>
                            </#list>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="ui-slidebox-prev" style="">
                <a class="" href="javascript:void(0)" data-role="prev" id="groomSellerPrev" onclick="groomSellerLeftRun();">
                    <span><font class="OUTFOX_JTR_TRANS_NODE">上一个</font></span>
                </a>
            </div>
            <div class="ui-slidebox-next" style="">
                <a class="" href="javascript:void(0)" data-role="next" id="groomSellerNext" onclick="groomSellerRightRun();">
                    <span><font class="OUTFOX_JTR_TRANS_NODE">下一个</font></span>
                </a>
            </div>
        </div>
    </div>

</div>

<script>
    var show = 0;
    var everyW=180;	//每个商品的宽度
    var everyN=5;	//每次滑动几格
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
</#if>

<#macro productStoreTitle productStore>
    <#assign productStoreTitleInfo = Static["org.ofbiz.product.store.EbizProductStoreContentWrapper"].getProductStoreContentAsText(productStore, "TITLE", request)/>
    <#if productStoreTitleInfo?has_content>
    ${productStoreTitleInfo!}
    <#else>
    ${(productStore.title)!}
    </#if>
</#macro>

<#macro productStoreSubTitle productStore>
    <#assign productStoreSubTitleInfo = Static["org.ofbiz.product.store.EbizProductStoreContentWrapper"].getProductStoreContentAsText(productStore, "SUB_TITLE", request)/>
    <#if productStoreSubTitleInfo?has_content>
    ${productStoreSubTitleInfo!}
    <#else>
    ${(productStore.subtitle)!}
    </#if>
</#macro>