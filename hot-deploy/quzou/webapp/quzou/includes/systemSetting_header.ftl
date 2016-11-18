<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl">
                <li <#if "${parameters.thisRequestUri}"=="productStoreSetting"> class="cur"</#if> ><a href="productStoreSetting">门店设置</a></li>
                <li <#if "${parameters.thisRequestUri}"=="productStoreTarget"> class="cur"</#if> ><a href="productStoreTarget">门店目标值设置</a></li>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
	});
</script>
