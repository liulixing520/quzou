<div class="nav_wrap">
    <div class="nav clearfix">
        <div class="wrap">
            <ul class="nav_ul fl" style="width:820px">
                <li <#if "${(headerItem)!}"=="orderGoods">class="cur"</#if>><a href="orderGoods">进货</a></li>
                <li <#if "${(headerItem)!}"=="returnGoods">class="cur"</#if>><a href="returnGoods">退货</a></li>
                <li <#if "${(headerItem)!}"=="useGoods">class="cur"</#if>><a href="useGoods">领用</a></li>
                <li <#if "${(headerItem)!}"=="damage">class="cur"</#if>><a href="damage">报损</a></li>
                <li <#if "${(headerItem)!}"=="budan">class="cur"</#if>><a href="budan">补单</a></li>
                <li <#if "${(headerItem)!}"=="inventory">class="cur"</#if>><a href="inventory">盘点</a></li>
                <li <#if "${(headerItem)!}"=="stock">class="cur"</#if>><a href="stock">库存</a></li>
                <li <#if "${(headerItem)!}"=="Balance">class="cur"</#if>><a href="Balance">结存</a></li>
                <li <#if "${(headerItem)!}"=="deliverGoods">class="cur"</#if>><a href="deliverGoods">发货</a></li>
            </ul>
            <div class="nav_r ri tr" data-text="+添加">
            	<#if "${(headerItem)!}"=="orderGoods"><a href="addPurchaseBox?inventoryTypeId=jinhuo">+添加进货</a></#if>
            	<#if "${(headerItem)!}"=="returnGoods"><a href="addPurchaseBox?inventoryTypeId=returnGoods">+添加退货</a></#if>
                <#if "${(headerItem)!}"=="useGoods"><a href="addUseGoods?inventoryTypeId=lingyong">+添加领用</a></#if>
            	<#if "${(headerItem)!}"=="damage"><a href="addPurchaseBox?inventoryTypeId=damage">+添加报损</a></#if>
            	<#if "${(headerItem)!}"=="budan"><a href="addPurchaseBox?inventoryTypeId=budan">+添加补单</a></#if>
            	<#if "${(headerItem)!}"=="deliverGoods"><a href="addPurchaseBox?inventoryTypeId=deliverGoods">+添加发货</a></#if>
            </div>
            
            
        </div>
    </div>
</div>
<script type="text/javascript">
$(function(){
	$(".nav").tiptop();
});
</script>