<style type="text/css">
html{ width:100%; height:100%; background-color:#f1f1f1;}
body{width:100%; height:100%; background-color:#f1f1f1;}
</style>
<body >
<div class="znxx">
  <div class="znxx_title">站内消息动态</div>
  <div class="znxx_main" align="center">
    <ul> 
    	<#if webMsgList?has_content>
    		<#list webMsgList as item>
    			 <li>
			        <div class="znxx_con">
			        <div class="znxx_name">${item.createTime?string('yyyy-MM-dd HH:mm')}</div>
			        <div class="znxx_content">
			          <p class="p1">${item.msg!}</p>
			        </div>
			        <div style="clear:both;"></div>
			        </div>
			      </li>
    		</#list>
    	</#if>
      <div style="background:#f1f1f1;clear:both; height:40px;"></div>
    </ul>
  </div>

</div>
