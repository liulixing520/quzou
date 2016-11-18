<div class="pageContent">
	<form action="<#if productStoreMsg??>updateTemplate<#else>createTemplate</#if>?navTabId=autoSendMgr&callbackType=closeCurrent&ajax=1" method="post" 
	 class="single_editor" onsubmit="return iframeCallback(this, navTabAjaxDone)" >
		<div class="pageFormContent" layoutH="97">
			<input type="hidden" name="productStoreId"  value='<#if productStoreId??>${productStoreId!}</#if>'/>
			<input type="hidden" name="msgTypeId"  value='<#if msgTypeId??>${msgTypeId!}</#if>'/>
			<input type="hidden" name="eventTypeId"  value='<#if eventTypeId??>${eventTypeId!}</#if>'/>
			<table cellspacing="0" class="basic-table">
			    <tr >
				    <td colspan="2"class='border03'Style="text-align:left">
					   &nbsp;&nbsp;&nbsp;&nbsp; ${eventType.description!}${msgType.description!}模板&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">(请参考操作须知编辑模板)</font>
				    </td>
			    </tr>
			    
			    <tr class='background_tr' style="display:<#if msgTypeId!='SMS'><#else>none</#if>">
			    
				    <td class='border03' style="width:100px">
						<span id="EditCmsArticle_title_title">${uiLabelMap.templateTitle}
						</span>    
					</td>
					<td class='border02'>
						<input type="text" name="subject" class="required" 
						         size="30"     maxlength="16"  value='<#if (productStoreMsg.subject)??>${productStoreMsg.subject!}</#if>' autocomplete="off"/>
				    </td>
				 </tr>
				 
				 <#--<tr class='background_tr'>
				    <td class='border03'>
						<span id="EditCmsArticle_websiteId_title">${uiLabelMap.templatePurpose}
						</span>    </td>
				    <td class='border02'>
						<select name="contentPurposeTypeId"  size="1"  style='width:100px;'>
						 	<#list templatePurposeList as templatePurpose>
					 			<option <#if  (template.contentPurposeTypeId)?? && templatePurpose.contentPurposeTypeId==template.contentPurposeTypeId>selected=selected</#if>  value='${templatePurpose.contentPurposeTypeId!}'>
					 			${templatePurpose.description!}</option>
							</#list>
						</select>
					</td>
				</tr>-->
				<#if msgTypeId!="SMS">
				<tr >
				    <td class='border03' rowspan='2'>
						<span>${uiLabelMap.templateContent}
						</span>
					</td>
					<td class='border02'>
						<span style="color:red;font-size:20">*注意:编辑器内图片宽度不能超过750否则页面无法完全显示！</span>
					</td>
				</tr>
				<tr>
					<td class='border02' colspan="4">
						<#--<textarea name="textData" class="editor"  cols="100"   rows="20"   upLinkUrl="uploadImage" upLinkExt="zip,rar,txt" 
									upImgUrl="uploadImage" upImgExt="jpg,jpeg,gif,png" 
									upFlashUrl="uploadImage" upFlashExt="swf"
									upMediaUrl="uploadImage" upMediaExt:"avi"><#if (template.textData)??>${template.textData!}</#if></textarea>-->
						
						
						
							<#if productStoreMsg??>
								<#assign textData = StringUtil.wrapString(electronicText.textData)>
							</#if>
							<#assign FCK=JspTaglibs["/WEB-INF/tags/FCKeditor.tld"]>
							<@FCK.editor instanceName="content" value="${textData!}" height="350"></@FCK.editor>
						
					 </td>
				</tr>
				<#else>
				<tr>
				<td class='border03'>
					<span>${uiLabelMap.templateContent}</span>
				</td>
				<td class='border02'>
					<textarea name="content"  cols="100"   rows="5">${(productStoreMsg.content)!}</textarea>
				</td>
				</tr>
				</#if>
			</table>
			<br/><br/>
			<font color="red">
			操作须知：<br/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;①、您将要编辑的是信息模板，模板里面会使用到一些默认<b>占位符号</b>代替因对象、事件、时间不同而形成的动态内容，
			<br/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;②、事件涉及占位符说明：
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注册用户：<font color="red">会员称呼：</font>{partyId}；<!--{registerVeryficationLinkUrl}：<font color="red">验证用户链接；</font>--><font color="red">登录账号</font>：{username}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单创建：<font color="red">会员称呼：</font>{partyId}；<font color="red">订单号：</font>{orderId}；<font color="red">订单内商品列表：</font>{productIdList}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单付款：<font color="red">会员称呼：</font>{partyId}；<font color="red">订单号：</font>{orderId}；<font color="red">订单内商品列表：</font>{productIdList}；<font color="red">本次付款金额：</font>{paymentAmount}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单发货：<font color="red">会员称呼：</font>{partyId}；<font color="red">订单号：</font>{orderId}；<font color="red">订单内商品列表：</font>{productIdList}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单退货：<font color="red">会员称呼：</font>{partyId}；<font color="red">订单号：</font>{orderId}；<font color="red">退回商品列表：</font>{returnBackProductIdList}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单退款：<font color="red">会员称呼：</font>{partyId}；<font color="red">订单号：</font>{orderId}；<font color="red">退回金额：</font>{returnBackPayment}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;订单取消：<font color="red">会员称呼：</font>{partyId}；<font color="red">订单号：</font>{orderId}；<font color="red">订单内商品列表：</font>{productIdList}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户收货：<font color="red">会员称呼：</font>{partyId}；<font color="red">订单号：</font>{orderId}；<font color="red">订单内商品列表：</font>{productIdList}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;修改密码：<font color="red">会员称呼：</font>{partyId}；<font color="red">登录账号</font>：{username}；<font color="red">新密码：</font>{newPassword}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;找回密码：<font color="red">会员称呼：</font>{partyId}；<font color="red">登录账号</font>：{username}；<font color="red">新密码：</font>{findBackPassword}；<font color="red">当前日期：</font>{nowDate}
			</font><br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;会员卡绑定账户：<font color="red">会员称呼：</font>{partyId}；<font color="red">会员卡号：</font>{memberCardId}；<font color="red">当前日期：</font>{nowDate}</font>
			<br/><br/>
			<font color="red">&nbsp;&nbsp;&nbsp;&nbsp;③、操作示例:</font>
			<br/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;模板：
			<br/><br/>
			<font color="red">{partyId}</font>:<br/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;您的编号为<font color="red">{orderId}</font>的订单(包含以下商品：<font color="red">{productIdList}</font>)已经发货，请关注快递公司动向并保持联系方式畅通!
			<br/><br/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			-----商城
			<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<font color="red">{nowDate}</font>
			<br/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发送效果：
			<br/><br/>
			Mr.Jone:<br/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;您的编号为order9527的订单(包含以下商品：巴罗洛、意大利葡萄酒)已经发货，请关注快递公司动向并保持联系方式畅通!
			<br/><br/><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			-----商城
			<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			2012-05-20
			</font>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">${uiLabelMap.CommonSave}</button></div></div></li>
				<li><div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
			</ul>
		</div>
	</form>
</div>
