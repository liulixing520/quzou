<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl ">
                <li <#if "${parameters.thisRequestUri}"=="memberHome" || "${parameters.thisRequestUri}"=="zhcon"
                	 || "${parameters.thisRequestUri}"=="memberHomePay" || "${parameters.thisRequestUri}"=="transfer"
                	 || "${parameters.thisRequestUri}"=="refund" || "${parameters.thisRequestUri}"=="zhconHistory">class="cur"</#if>><a href="memberHome?partyId=${(parameters.partyId)!}">个人中心</a></li>
                <li <#if "${parameters.thisRequestUri}"=="empConsumeRecord">class="cur"</#if>><a href="empConsumeRecord?partyId=${(parameters.partyId)!}">消费记录</a></li>
                <#--
                 <li <#if parameters.thisRequestUri?contains("findPayment")>class="cur"</#if>><a href="findPayment?partyId=${(parameters.partyId)!}">消费记录</a></li>

                -->

                <!--<li><a href="#">评价管理</a></li>
                <li <#if "${parameters.thisRequestUri}"=="memberCoins">class="cur"</#if>><a href="memberCoins?partyId=${(parameters.partyId)!}">会员积分</a></li>
                -->
                <li <#if "${parameters.thisRequestUri}"=="addCustomer">class="cur"</#if>><a href="addCustomer?partyId=${(parameters.partyId)!}">设置</a></li>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
	});
</script>
