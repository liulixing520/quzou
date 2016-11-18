<div class="nav_wrap">
	<div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl">
                <#if parameters.partyId?has_content>
                <!--<li><a href="updatePassword?partyId=${(parameters.partyId)!}">修改密码</a></li>-->
                </#if>
            </ul>
            <#if "${parameters.thisRequestUri}"!="registerEmployee">
                <#if security.hasPermission("PCPOS_addEmployee", session)>
                    <div class="nav_r ri tr">
                        <a href="addEmployee">员工注册</a>
                    </div>
                </#if>
            </#if>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
	});
</script>
