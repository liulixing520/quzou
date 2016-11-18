<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl">
                <#if "${parameters.thisRequestUri}"=="registerEmployee"><li class="cur"><a href="registerEmployee">员工注册</a></li></#if>
                <#if "${parameters.thisRequestUri}"=="registerMember"><li class="cur"><a href="registerMember">会员注册</a></li></#if>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
	});
</script>