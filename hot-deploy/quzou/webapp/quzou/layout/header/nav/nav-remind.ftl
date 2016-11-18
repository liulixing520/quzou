<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl">
               	<li <#if "${parameters.thisRequestUri}"=="nursing">class="cur"</#if>><a href="nursing">护理时间提醒</a></li>
               	<li <#if "${parameters.thisRequestUri}"=="appointment">class="cur"</#if>><a href="appointment">预约提醒</a></li>
               	<li <#if "${parameters.thisRequestUri}"=="birthday">class="cur"</#if>><a href="birthday">生日提醒</a></li>
               	<li <#if "${parameters.thisRequestUri}"=="feedback">class="cur"</#if>><a href="feedback">回访提醒</a></li>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
	});
</script>