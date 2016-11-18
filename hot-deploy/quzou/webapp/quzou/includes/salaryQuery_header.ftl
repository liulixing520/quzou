<#assign canViewSalaryRule  = security.hasPermission("PCPOS_viewSalaryRule", session)>
<#assign canAddSalaryRule   = security.hasPermission("PCPOS_addSalaryRule", session)>


<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl ">
                 <li <#if "${parameters.thisRequestUri}"=="salaryQuery"> class="cur"</#if> ><a href="salaryQuery">薪酬查询</a></li>
                <#-- <li <#if "${parameters.thisRequestUri}"=="salaryGroup"> class="cur"</#if> ><a href="salaryGroup">组</a></li> -->
                <#if canViewSalaryRule>
                    <li <#if "${parameters.thisRequestUri}"=="salaryRule" || "${parameters.thisRequestUri}"=="salarySetupAll" || "${parameters.thisRequestUri}"=="EditSalarySetupAll"> class="cur"</#if> ><a href="salaryRule">薪酬规则</a></li>
                </#if>


            </ul>
            <#if "${parameters.thisRequestUri}"=="salaryRule" && canAddSalaryRule>
            	<div class="nav_r ri tr navTarget" data-text="添加薪酬规则"><a href="salarySetupAll">添加薪酬规则</a></div>
            </#if>
           <#--  <#if "${parameters.thisRequestUri}"=="salaryGroup">
            	<div class="nav_r ri tr navTarget" data-text="添加组"><a href="#" id="salaryAddGroup">添加组</a></div>
            </#if>-->

        </div>
    </div>
</div>

<!--弹窗start -->
<script type="text/javascript" src="/ofcupload/images/js/jquery.cm_dialog.js"></script>
<!--弹窗end -->
<script type="text/javascript">
	$(function(){
		$(".nav").tiptop();
		$('#salaryAddGroup').on('click',function(){
			var option = {
					url: "salaryNewGroup",
					width: '810px'
				};
	    	$(this).cm_dialog(option);
		});

	});
</script>
