<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl">
                <a href="findProduct?SEARCH_CATEGORY_ID=HOTMALL&SEARCH_SUB_CATEGORIES=Y"><li <#if parameters.SEARCH_CATEGORY_ID=="HOTMALL">class="cur"</#if>>精选热卖</li></a>
                <#--  modify by   subenkun   2014-10-24-->
                <#--<a href="findProduct?SEARCH_CATEGORY_ID=FA_RECHARGE&SEARCH_SUB_CATEGORIES=Y"><li <#if parameters.SEARCH_CATEGORY_ID=="FA_RECHARGE">class="cur"</#if>>充值卡</li></a>-->
                <a href="findProduct?SEARCH_CATEGORY_ID=BEAUTY_PRODUCT&SEARCH_SUB_CATEGORIES=Y"><li <#if parameters.SEARCH_CATEGORY_ID=="BEAUTY_PRODUCT">class="cur"</#if>>产品</li></a>
                <a href="findProduct?SEARCH_CATEGORY_ID=BEAUTY_ITEM&SEARCH_SUB_CATEGORIES=Y"><li <#if parameters.SEARCH_CATEGORY_ID=="BEAUTY_ITEM">class="cur"</#if>>项目</li></a>
                <a href="findProduct?SEARCH_CATEGORY_ID=BEAUTY_TREATMENT&SEARCH_SUB_CATEGORIES=Y"><li <#if parameters.SEARCH_CATEGORY_ID=="BEAUTY_TREATMENT">class="cur"</#if>>疗程</li></a>
                <a href="findProduct?SEARCH_CATEGORY_ID=BEAUTY_FANGAN&SEARCH_SUB_CATEGORIES=Y"><li <#if parameters.SEARCH_CATEGORY_ID=="BEAUTY_FANGAN">class="cur"</#if>>方案</li></a>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
	});
</script>