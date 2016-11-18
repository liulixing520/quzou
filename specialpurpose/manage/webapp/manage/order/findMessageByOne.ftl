  <!--主要内容-->
<div id="list" layouth="15" class="pageFormContent">
  <div id="cont02" style="">
	  <#if messageByOne?has_content>
	  	<div class="content_temp">
		  	<div class="screenlet screenlet-title-bar">
									<ul>
										<li class="h3">发布日期  :[${messageByOne.lastUpdatedStamp!}] </li>
									</ul>
									<br class="clear">
			</div>
		    <!--公告基本信息 start-->
		        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="basic-table">
		    	<tbody>
		        <tr>
		  			<td class="label">公告标题：${messageByOne.messageTitle!}</td>
			      </tr>
		        <tr>
		  			<td class="label">公告内容：${messageByOne.messageContent!}</td>
			      </tr>
		        </tbody>
		        </table>
		    <!--公告基本信息 end-->
		  	<div class="screenlet screenlet-title-bar">
									<br class="clear">
			</div>
			<!--用户信息 start-->
			<div align="right">发布人  :[<font color=red>网站管理员</font>]</div> 
			<!--用户信息 end-->
	    </div>
	  </div>
	  </#if>
	  <div><a href="<@ofbizUrl>manage_findMessageByAll</@ofbizUrl>">返回</a></div>
   </div>
</div>