<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl"  style="width:820px">
                <li <#if "${(headerItem)!}"=="statisticsOrder">class="cur"</#if>><a href="statisticsOrder">订单查询</a></li>
                <#--<li <#if "${(headerItem)!}"=="statisticsReFund">class="cur"</#if>><a href="statisticsReFund">转账退款</a></li>-->
               <#--V1.0不上此功能  modify by Ansen-->
               <#-- <li <#if "${(headerItem)!}"=="statisticsConsume">class="cur"</#if>><a href="statisticsConsume">消费查询</a></li> -->
                <li <#if "${(headerItem)!}"=="transactionDetails">class="cur"</#if>><a href="transactionDetails">交易明细</a></li>
                <li <#if "${(headerItem)!}"=="statisticsJournalingDay">class="cur"</#if>><a href="statisticsJournalingDay">日报表</a></li>
                <li <#if "${(headerItem)!}"=="statisticsJournalingMonth">class="cur"</#if>><a href="statisticsJournalingMonth">月报表</a></li>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
	});
</script>