<div class="pageContent">
	<form action="UpdatePaymentGatewayConfigAlipay?navTabId=EditPaymentGatewayConfig&callbackType=closeCurrent&ajax=1" method="post" 
 class="single_editor" onsubmit="return iframeCallback(this, navTabAjaxDone)" >
 	<input type="hidden" name="paymentGatewayConfigId" value="${(paymentGatewayAlipay.paymentGatewayConfigId)!'ALIPAY_CONFIG'}"/>
 
	<table cellspacing="0" class="basic-table">
	    <tr class="background_tr">
		    <td class="label" style="width:150px">
				<span id="EditCmsArticle_title_title">合作伙伴
				</span>    
			</td>
		    <td >
				<input type="text" name="partner" size="50"  value="${(paymentGatewayAlipay.partner)!}"/>
		    </td>
	    </tr>
	    <tr class='background_tr'>
		    <td class='border03'>
				<span id='EditCmsArticle_websiteId_title'>交易安全检验码
				</span>    
			</td>
		    <td class='border02'>
				<input type='text' name='partnerKey' size='50'  value="${(paymentGatewayAlipay.partnerKey)!}"/>
		 	</td>
	    </tr>
	    <tr class="background_tr">
		    <td class="label" style="width:80px">
				<span id="EditCmsArticle_title_title">签约支付宝账号
				</span>    
			</td>
		    <td >
				<input type="text" name="sellerEmail" size="50"  value="${(paymentGatewayAlipay.sellerEmail)!}"/>
		    </td>
	    </tr>
	    <tr class="background_tr">
		    <td class="label">
				<span id="EditCmsArticle_websiteId_title">服务器通知的Url
				</span>    
			</td>
		    <td >
				<input type="text" name="notifyUrl" size="70"  value="${(paymentGatewayAlipay.notifyUrl)!}"/>
		 	</td>
	    </tr>
	    <tr class="background_tr">
		    <td class="label" style="width:80px">
				<span id="EditCmsArticle_title_title">返回页面
				</span>    
			</td>
		    <td >
				<input type="text" name="returnUrl" size="70"  value="${(paymentGatewayAlipay.returnUrl)!}"/>
		    </td>
	    </tr>
    </table>
 	<div class="formBar">
		<ul>
			<li><div class="buttonActive"><div class="buttonContent"><button type="submit">${uiLabelMap.CommonSave}</button></div></div></li>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  
 </form>
</div>