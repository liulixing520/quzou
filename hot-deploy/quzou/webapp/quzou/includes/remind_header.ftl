<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl">
              <#if security.hasPermission("PCPOS_viewNurseRemind", session)>
                <li <#if "${parameters.thisRequestUri}"=="nursing"> class="cur"</#if>><a href="nursing">护理提醒</a></li>
              </#if>
              <#if security.hasPermission("PCPOS_viewAppointment", session)>
                <li <#if "${parameters.thisRequestUri}"=="appointment"> class="cur"</#if>><a href="appointment">预约提醒</a></li>
              </#if>
              <#if security.hasPermission("PCPOS_viewBirthRemind", session)>
                <li <#if "${parameters.thisRequestUri}"=="birthday">    class="cur"</#if>><a href="birthday">生日提醒</a></li>
              </#if>
              <#if security.hasPermission("PCPOS_viewFeedbackRemind", session)>
                <li <#if "${parameters.thisRequestUri}"=="feedback"> class="cur"</#if>><a href="feedback">回访提醒</a></li>
              </#if>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
	});
</script>
