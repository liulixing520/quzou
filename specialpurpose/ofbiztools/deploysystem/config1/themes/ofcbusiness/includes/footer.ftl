
<#if layoutSettings.VT_FTR_JAVASCRIPT?has_content>
    <#list layoutSettings.VT_FTR_JAVASCRIPT as javaScript>
        <script type="text/javascript" src="<@ofbizContentUrl>${StringUtil.wrapString(javaScript)}</@ofbizContentUrl>" type="text/javascript"></script>
    </#list>
</#if>

</div>
<!-- footer -->
<div id="footer">
    <div class="poweredBy"><span>Powered by <a href="#" class="noicon">OFC</a></span><span>Copyright 2001-${nowTimestamp?string("yyyy")} </span><span><#include "ofbizhome://runtime/svninfo.ftl" /></span></div>

</div>
<!-- footer -->
</body>
</html>

