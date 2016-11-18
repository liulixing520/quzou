<#assign isProudct =     "${(parameters.SEARCH_CATEGORY_ID)!}" == "BEAUTY_PRODUCT"/>      <#-- 是产品？    -->
<#assign isItem =        "${(parameters.SEARCH_CATEGORY_ID)!}" == "BEAUTY_ITEM"/>         <#-- 是项目？    -->
<#assign isTreatment =   "${(parameters.SEARCH_CATEGORY_ID)!}" == "BEAUTY_TREATMENT"/>    <#-- 是疗程？    -->
<#assign isFangAn =      "${(parameters.SEARCH_CATEGORY_ID)!}" == "BEAUTY_FANGAN"/>       <#-- 是方案？    -->
<#assign isConsumable =  "${(parameters.SEARCH_CATEGORY_ID)!}" == "BEAUTYROOTCONSUME"/>   <#-- 是消耗品？  -->
<#assign isFixedAssets = "${(parameters.SEARCH_CATEGORY_ID)!}" == "fixed"/>               <#-- 是固定资产？-->
<#assign isBrand =       "${(parameters.productFeatureTypeId)!}"=="BRAND"/>               <#-- 是品牌？    -->
<#assign isStyle =       "${(parameters.productFeatureTypeId)!}"=="STYLE"/>               <#-- 是系列？    -->

<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl ">
                <#--<li <#if "${(parameters.SEARCH_CATEGORY_ID)!}"=="HOTMALL">class="cur"</#if>><a href="productBasicInfo?SEARCH_CATEGORY_ID=HOTMALL&SEARCH_SUB_CATEGORIES=Y">精选热卖</a></li>-->
               <#-- <li <#if "${(parameters.SEARCH_CATEGORY_ID)!}"=="FA_RECHARGE">class="cur"</#if>><a href="productBasicInfo?SEARCH_CATEGORY_ID=FA_RECHARGE&SEARCH_SUB_CATEGORIES=Y">充值卡</a></li> -->
                <li <#if isProudct>class="cur"</#if>><a href="<@ofbizUrl>productBasicInfo?SEARCH_CATEGORY_ID=BEAUTY_PRODUCT&SEARCH_SUB_CATEGORIES=Y</@ofbizUrl>">产品</a></li>
                <li <#if isItem>class="cur"</#if>><a href="<@ofbizUrl>productBasicInfo?SEARCH_CATEGORY_ID=BEAUTY_ITEM&SEARCH_SUB_CATEGORIES=Y</@ofbizUrl>">项目</a></li>
                <li <#if isTreatment>class="cur"</#if>><a href="<@ofbizUrl>productBasicInfo?SEARCH_CATEGORY_ID=BEAUTY_TREATMENT&SEARCH_SUB_CATEGORIES=Y</@ofbizUrl>">疗程</a></li>
                <li <#if isFangAn>class="cur"</#if>><a href="<@ofbizUrl>productBasicInfo?SEARCH_CATEGORY_ID=BEAUTY_FANGAN&SEARCH_SUB_CATEGORIES=Y</@ofbizUrl>">方案</a></li>

                <li <#if isConsumable>class="cur"</#if>><a href="<@ofbizUrl>productBasicInfo?SEARCH_CATEGORY_ID=BEAUTYROOTCONSUME&SEARCH_SUB_CATEGORIES=Y</@ofbizUrl>">消耗品</a></li>
                <li <#if isFixedAssets>class="cur"</#if>><a href="<@ofbizUrl>fixedBasicsInfo?SEARCH_CATEGORY_ID=fixed</@ofbizUrl>">固定资产</a></li>
                <li <#if isBrand> class="cur"</#if>><a title="品牌" href="<@ofbizUrl>brandManager?productFeatureTypeId=BRAND&productFeatureCategoryId=BUTYROOT001</@ofbizUrl>">品牌</a></li>
                <li <#if isStyle> class="cur"</#if>><a title="系列" href="<@ofbizUrl>brandManager?productFeatureTypeId=STYLE&productFeatureCategoryId=BUTYROOT002</@ofbizUrl>">系列</a></li>
            </ul>
            <#if isProudct>
                <#if security.hasPermission("PCPOS_addProduct", session)>
                    <div class="nav_r ri tr navTarget" data-text="+建立"><a href="<@ofbizUrl>addProduct?SEARCH_CATEGORY_ID=BEAUTY_PRODUCT</@ofbizUrl>">+建立新产品</a></div>
                </#if>
            </#if>
            <#if isItem>
                <#if security.hasPermission("PCPOS_addItem", session)>
                    <div class="nav_r ri tr navTarget" data-text="+建立"><a href="<@ofbizUrl>addProduct?SEARCH_CATEGORY_ID=BEAUTY_ITEM</@ofbizUrl>">+建立新项目</a></div>
                </#if>
            </#if>
            <#if isConsumable>
                <#if security.hasPermission("PCPOS_addConsumable", session)>
                    <div class="nav_r ri tr navTarget" data-text="+建立"><a href="<@ofbizUrl>addConsume?SEARCH_CATEGORY_ID=BEAUTYROOTCONSUME</@ofbizUrl>">+建立消耗品</a></div>
                </#if>
            </#if>
            <#if isFixedAssets>
                <#if security.hasPermission("PCPOS_addFixedAssets", session)>
                    <div class="nav_r ri tr navTarget" data-text="+建立"><a href="<@ofbizUrl>addFixed?SEARCH_CATEGORY_ID=fixed</@ofbizUrl>">+建立固定资产</a></div>
                </#if>
            </#if>
        </div>
    </div>
</div>
