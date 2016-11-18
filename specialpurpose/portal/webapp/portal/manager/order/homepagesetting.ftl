<#assign FCK=JspTaglibs["/WEB-INF/tags/FCKeditor.tld"]>
<script type="text/javascript">
 $(function(){ 
		$(".breadcrumb").append("<li class='active'>网站管理</li><li class='active'>页面设置</li>")
	}); 
</script>
<body background="../../images/allbg.gif" topMargin="8" leftMargin="8">
<div class="page-content">
    <div class="page-content-area">
        <div class="page-header" style="height:60px;clear:both;">
            <h1 style="float:left; padding-top:8px;">
                页面管理
            </h1>
        </div>

<#assign actionUrlStr="createHomePage">
<#if pageSettingList?has_content>
    <#assign actionUrlStr="updateHomePage">
</#if>
     <form method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>" id="EditProductStore"
          name="EditProductStore" novalidate="novalidate">
           <input type="hidden" name="homePageId" id="homePageId"
               value="${(pageSettingList.homePageId)!}">
        <div class="screenlet-body">
            <table class="basic-table">
                <tbody>
                 <#--<@FCK.editor instanceName="messageContentToOne" value="${messageContentToOne!}" height="415px"></@FCK.editor>	-->
                <tr>
                    <td class="label">站点底部信息：</td>
                    <td><textarea type="text" name="messageContentToOne" id="messageContentToOne" rows="2"
                                  cols="60">${(pageSettingList.messageContentToOne)!}</textarea></td>
                </tr>
                <tr>
                    <td class="label">关于我们：</td>
                    <td><textarea type="text" name="messageContentToTwo" id="messageContentToTwo" rows="2"
                                  cols="60">${(pageSettingList.messageContentToTwo)!}</textarea></td>
                </tr>
                <tr>
                    <td class="label">新手上路：</td>
                    <td><textarea type="text" name="messageContentToThree" id="messageContentToThree" rows="2"
                                  cols="60">${(pageSettingList.messageContentToThree)!}</textarea></td>
                </tr>
                <tr>
                    <td class="label">买家保护：</td>
                    <td><textarea type="text" name="messageContentToFour" id="messageContentToFour" rows="2"
                                  cols="60">${(pageSettingList.messageContentToFour)!}</textarea></td>
                </tr>
                 <tr>
                    <td>&nbsp;</td>
                    <td><input value="保 存" class="btn btn-info" type="submit"></td>
                </tr>
                </tbody>
             </table>
    </form>























     </div>
</div>     
</body>