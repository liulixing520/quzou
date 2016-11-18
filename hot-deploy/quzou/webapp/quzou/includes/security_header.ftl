<#--是否具有添加安全组权限 -->
<#assign canAddSecurityGroup = security.hasPermission("PCPOS_createSecurityGroup", session) >
<#--是否具有添加安全许可权限 -->
<#assign canAddSecurityPermission = security.hasPermission("PCPOS_addSecurityPermission", session) >

<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl">
                <li <#if "${parameters.thisRequestUri}"=="securityGroup"||"${parameters.thisRequestUri}"=="securityGroupNewPermission"> class="cur"</#if> ><a href="securityGroup">安全组</a></li>
                <li <#if "${parameters.thisRequestUri}"=="securityPermission"> class="cur"</#if> ><a href="securityPermission">安全许可</a></li>
            </ul>

             <#if "${parameters.thisRequestUri}"=="securityGroup" && canAddSecurityGroup>
                <div class="nav_r ri tr navTarget" data-text="添加安全组"><a href="#" id="securityAddGroup">添加安全组</a></div>
            </#if>
             <#if "${parameters.thisRequestUri}"=="securityPermission" && canAddSecurityPermission>
                <div class="nav_r ri tr navTarget" data-text="添加安全组许可"><a href="#" id="securityAddPermission">添加安全许可</a></div>
            </#if>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        $(".nav").tiptop();

    <#if canAddSecurityGroup>
        $('#securityAddGroup').on('click',function(){
            var option = {
                    url: "securityNewGroup",
                    width: '500px'
                };
            $(this).cm_dialog(option);
        });
    </#if>
    <#if canAddSecurityPermission>
        $('#securityAddPermission').on('click',function(){
            var option = {
                    url: "securityNewPermission",
                    width: '810px'
                };
            $(this).cm_dialog(option);
        });
    </#if>
    });
</script>
