<#--
礼品卡支付：PayGiftCard
现金支付：PayCash
-->
<script language='javascript'>
function deleteGoods(goodsId){
try{
	jQuery.ajax({
        url: "<@ofbizUrl>deleteGoods</@ofbizUrl>?goodsId="+goodsId,
        type: 'POST',
        error: function(msg) {
        alert("failed");
           alert(msg);
        },
        success: function(msg) {
        	alert('删除成功');
			jQuery('#all_main').html(msg);
        }
    });
    }catch(e){alert(e.message);}
}

function viewCatdInfo(cardNo){
try{
	jQuery.ajax({
        url: "<@ofbizUrl>viewCatdInfo</@ofbizUrl>?cardNo="+cardNo,
        type: 'POST',
        error: function(msg) {
           alert(msg);
        },
        success: function(msg) {
			jQuery('#all_main').html(msg);
        }
    });
    }catch(e){alert(e.message);}
}

function addPNode(){
	$('#group').clone().show().appendTo("#grouptd"); 
}
function deletePNode(t){
	var pn = t.parentNode;
	pn.parentNode.removeChild(pn);
}
function add_tr(){
$("#grouptd").after('<tr class="title02"  > <td height="30" colspan="1"  style=" border-left:none"><b></b></td> <td>选择支付方式: <select name="checkOutPaymentId" id="checkOutPaymentId"> <option value="">请选择</option><option value="CASH">现金</option><option value="EXT_USER_ACCOUNT">站内余额</option><option value="GIFT_CARD">礼品卡</option> </select> 金额/卡号 <input type="text"  name="productNumber" id="" value="" /> </td> <td> <input type="button" name="button" id="button" value="添加" onclick="add_tr();" /></td><td><img src="/images/delete.gif" width="16" height="16" onclick="remove_tr(this)"/></td> </tr>');
}
function remove_tr(t){
		var vNum=$("#paymentTable tr").filter(".CaseRow").size()+1;//表格有多少个数据行;
		var vbtnDel=$(t);//得到点击的按钮对象
		var vTr=vbtnDel.parent("td").parent("tr");//得到父tr对象;
		
		if(vTr.attr("id")=="grouptd")
		{
			return;
		}else{
			vTr.remove();
		} 
	}
</script>
<#assign shoppingCartOrderType = "">
<#assign shoppingCartProductStore = "NA">
<#assign shoppingCartChannelType = "">
<#if shoppingCart?exists>
  <#assign shoppingCartOrderType = shoppingCart.getOrderType()>
  <#assign shoppingCartProductStore = shoppingCart.getProductStoreId()?default("_NA_")>
  <#assign shoppingCartChannelType = shoppingCart.getChannelType()?default("")>
<#else>
<#-- allow the order type to be set in parameter, so only the appropriate section (Sales or Purchase Order) shows up -->
  <#if parameters.orderTypeId?has_content>
    <#assign shoppingCartOrderType = parameters.orderTypeId>
  </#if>
</#if>
<!-- Sales Order Entry -->

<div id="all_main" class='pageContent'>
<!--checkout--PayCash---Payment---PayFinish--"poscheckout"-->

<form name="order_form" id="order_form" method="post" action='<@ofbizUrl>checkoutPos</@ofbizUrl>' class="order_form">
<input type="hidden" name="salesChannelEnumId" id="salesChannelEnumId" value="POS_SALES_CHANNEL"/>
<input type="hidden" name="may_split" value="false"/><!-- “送有现货的”? -->
<input type="hidden" name="is_gift" value="false"/><!-- 是否礼品 -->
<input type="hidden" name="checkoutpage" value="quick"/><!-- 快速下单 -->
<input type="hidden" name="navTabId" value="FindOrder"/>
<input type="hidden" name="finAcount" id="finAcount"   value=""/>
<input type="hidden" name="callbackType" value="closeCurrent"/>
<input type="hidden" name="type" value="add"/>
<input type="hidden" name="partyId" value=""/>
<input type="hidden" id="userId" name="userId" value="<#if customerInfo??&&customerInfo.userId??>${customerInfo.userId}</#if>"/>
<input type="hidden" id="isBuyProduct" name="isBuyProduct"/>
<input type="hidden" id="errorMessage"/>
<input type="hidden" value="SALES_ORDER" name="orderMode"  id="orderMode">
<input type="hidden"  name="USER_FIRST_NAME"  id="USER_FIRST_NAME">
<input type="hidden"  name="CONFIRM_PASSWORD"  id="CONFIRM_PASSWORD">
<input type="hidden"  name="getBillingAddress"  id="getBillingAddress" value="here">
<input type="hidden"  name="shipping_method"  id="shipping_method" value="NO_SHIPPING@_NA_">

  <!--功能区域-->
  <div layouth="56" class="pageFormContent" style="height: 158px; overflow: auto;">
  <div id="cont02">
  	<div class="content_temp">
    <!--选择用户 start-->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03" >
      <tr>
        <td width="300" colspan="2" class="border11" align="left">直营店铺&nbsp;：
        	<select  id="productStoreId" name="productStoreId">
                <#list productStores as productStore>
	                <#list productStores2![] as productStore2>
	                	<#if productStore2.productStoreId?trim==productStore.productStoreId?trim>
	                  	<option value="${productStore.productStoreId}">${productStore.storeName?if_exists}</option>
	                  	</#if>
	                </#list>
                </#list>
              </select>
         </td>
         <td   class="label"> </td>
         <td   class="border11" >
        </td>   
         <td class="border11"></td> <td class="border11"></td>  
         <td class="border11"></td> <td class="border11"></td>  
         <td class="border11"></td> <td class="border11"></td>  
      </tr>  
      <tr class="title02">
        <td height="30" colspan="10"  style=" border-left:none"><b>会员卡号：</b><input type="text" name="cardNo" id="cardNo" value="" /> 
        <input type="button" onclick="getBuyInfoByCardInfo()" name="cardNumber" id="" value="查询" />
        </td>
       </tr>
      <tr>
    	<td width="100" class="label" text-align="right">用户信息&nbsp;：</td>
    	<td width="100" class="label"><input type="text" readonly="false" name="userName" id="userName" value="" /></td>
    	<td width="100" class="border11" >
    		会员等级：
        </td>
    	<td width="100" class="border11" >
    		<input type="text" readonly="true" name="salesPercent" id="salesPercent" value="" size="16"/>
        </td>
         <td width="100" class="label">
        	 可用余额：
         </td>
         <td width="100" class="label">
        	 <input type="text" readonly="true" name="moneyLeft" id="moneyLeft" value="" size="16"/>
         </td>
         <td width="100" class="border11" >
         	积分：
         </td>   
         <td width="100" class="border11" >
         	<input type="text" readonly="true" name="Rcostcoin" id="costcoin" value="" size="16"/>
         </td>   
         <td class="border11" > </td>
         <td class="border11" > </td>  
      </tr> 
      </table>
    <!--选择用户 end-->
    <!--用户信息 end-->
    	
    <!--用户信息 end-->
     <!--商品信息 start-->
     <div id="carttab">
    <table id='proListTb' class="border04 overall_03" width="100%" border="0" cellspacing="0" cellpadding="0" >
      <tr class="title02">
        <td colspan="7">商品信息</td>
        <td colspan="1" align="right">
          <a class="button"  close="closeProdialog" width="580" height="380"  param="{}"
           href="<@ofbizUrl>LookupBulkAddProducts?partyId=document.getElementById('userName').value</@ofbizUrl>" target="dialog" mask="true" title="添加商品"><span>添加商品</span></a>
        </td>
        </tr>
      <tr class="background_tr">
        <td class="border06 width5">序号</td>
        <td class="border07 width15">商品编号</td>
        <td class="border07 width22">商品名称</td>
        <td class="border07 width10">单价</td>
        <td class="border07 width5">数量</td>
     	<td class="border07 width5">调整</td>
        <td class="border07 width7">小计</td>
        <td class="border07 width7">操作</td>
      </tr>
    
     <tr><td><input type="button" value="批量删除"/></td></tr>
    </table>
    </div>
     <!--商品信息 end--> 
   
    <!-- 订单总金额 -->
    <div id='totalDiv'>
    	<table width='100%' border='0' cellspacing='0' cellpadding='0' class='border04 overall_03'>
      <tr class='title02'>
        <td height='30' colspan='5'  style=' border-left:none'><b>订单总额</b></td>
      </tr>
      </table>
    </div>
     <!--可参与活动  begin-->
    <div id='promotoDiv'>
    	<table width='100%' border='0' cellspacing='0' cellpadding='0' class='border04 overall_03'>
      <tr class='title02'>
        <td height='30' colspan='5'  style=' border-left:none'><b>可参与活动</b></td>
      </tr>
      
       <tr>
        <td height='30' colspan='5'  style=' border-left:none' id="ProductPromoUseInfoDiv">&nbsp;&nbsp;&nbsp;
        <!--这里是不是该调用个接口-->
        <!--<input type="checkbox" name="huodong" id="huodong" value="1"/>-->
        <!--<b>&nbsp;&nbsp;满500赠300元提货卡</b>-->
        <!--added by dongyc 20120907 优惠活动-->
        <ul>    
            <#list shoppingCart.getProductPromoUseInfoIter() as productPromoUseInfo>
                <li>
                    <#-- TODO: when promo pretty print is done show promo short description here -->
                       ${uiLabelMap.OrderPromotion} <a href="<@ofbizUrl>showPromotionDetails?productPromoId=${productPromoUseInfo.productPromoId?if_exists}</@ofbizUrl>" class="button">${uiLabelMap.CommonDetails}</a>
                    <#if productPromoUseInfo.productPromoCodeId?has_content> - ${uiLabelMap.OrderWithPromoCode} [${productPromoUseInfo.productPromoCodeId}]</#if>
                    <#if (productPromoUseInfo.totalDiscountAmount != 0)> - ${uiLabelMap.CommonTotalValue} <@ofbizCurrency amount=(-1*productPromoUseInfo.totalDiscountAmount) isoCode=shoppingCart.getCurrency()/></#if>
                </li>
                <#if (productPromoUseInfo.quantityLeftInActions > 0)>
                    <li>- Could be used for ${productPromoUseInfo.quantityLeftInActions} more discounted item<#if (productPromoUseInfo.quantityLeftInActions > 1)>s</#if> if added to your cart.</li>
                </#if>
            </#list>
        </ul>
        </td>
      </tr>
      <tr><td><input name="productPromoCodeId" type="text" class="input80" id="productPromoCodeId" />
      <input name="usePromoCode"   onclick="javascript:useProductPromoCode();" type="button" value="使用优惠码" />
          
      	
      	</td></tr>
      </table>
    </div>
    <!--可参与活动 end-->
     <!--订单备注  begin-->
     <input type="hidden" name="orderAttributeNames" value="noteInfo"/>
    <div id='commentDiv'>
    	<table width='100%' border='0' cellspacing='0' cellpadding='0' class='border04 overall_03'>
      <tr class='title02'>
        <td height='30' colspan='5'  style=' border-left:none'><b>订单备注</b></td>
      </tr>
      <tr><td>
      		<input name="noteInfo" type="text" class="input80" maxlength="50"/>
      	</td>
      	</tr>
      </table>
    </div>
    <!--可参与活动 end-->
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
        <tr class="title02a">
          <td width="440" >使用提货卡&nbsp;&nbsp;&nbsp;&nbsp;：<input name="checkOutPaymentId_FINACT_VOUCHER" type="text" class="input80" id="checkOutPaymentId_FINACT_VOUCHER" /><span style="font-weight:normal"></span>
              	 金额：<span id="giftcardavailableBalance" style="font-weight:normal"></span>
              	<input name="amount_FINACT_VOUCHER" type="text" class="input80 currency" id="amount_FINACT_VOUCHER" />
          </td>
          
          <td>
          	<!-- 现在的提货卡只是做记录用
          	<input name="input6"  id="useIntegralsBtn" onclick="getGiftCardAvailableBlance()" type="button" value="查看提货卡余额" /><span id="mc_fc_av_Blance" style="color:red"/>
          	-->
          </td>
        </tr>
      </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
        <tr class="title02a">
          <input type="hidden"  name="checkOutPaymentId"  id="checkOutPaymentId" value="CASH">
          <td width="440" >&nbsp;使&nbsp;用&nbsp;现&nbsp;金&nbsp;&nbsp;&nbsp;&nbsp;：<input name="amount_CASH" type="text" class="input80 currency" id="amount_CASH" /><span style="font-weight:normal"></span></td>
          <td></td>
        </tr>
      </table>
    
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
        <tr class="title02a">
          <td width="440" >使用会员卡&nbsp;&nbsp;&nbsp;&nbsp;：<input name="checkOutPaymentId_STORE_USER_CARD" type="text" class="input80" id="checkOutPaymentId_STORE_USER_CARDPos" />
           密码：<input type="password" id="finAcountCardPasswordPos" maxlength="20"></td>
          <td>
          余额：<span id="availableBalancePos" style="font-weight:normal"></span><input name="input6"  id="useIntegralsBtn" onclick="getPosFinAccountAvailableBlance()" type="button" value="查看会员卡余额" /><span id="mc_fc_av_Blance" style="color:red"/>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="border04 overall_03">
        <tr class="title02a">
        	<input type="hidden" name="checkOutPaymentId_STORE_USER_ACCT" id="checkOutPaymentId_STORE_USER_ACCT" value=''  />
        	<input type="hidden" id="finAcountBalancePosAmount" value="">
          <td width="440" >使用账户余额：<input name="amount_STORE_USER_ACCT" id="amount_STORE_USER_ACCT" class="input80 currency" type="text"  value=''  />（您的余额：<span id='finAcountBalanceSpan'></span>  元）</td>
          <td >
          <!--
           <input name="input7" id="useAccountMoneyBtn" disabled onclick="useAccountMoeny()" type="button" value="确定" /><span id="accountMoneyError" style="color:red"/>
          -->
          </td>
        </tr>
      </table>
    <!--其他信息 start-->
  	</div>
  </div>
  </div>
</form>
<div class="formBar" >
		<ul>
		<li>
		<div class="button"><div class="buttonContent"><button id="quickPosOrderAddButton" class="button" onclick="javascript:ajaxSubmitPosOrderForms('order_form');" type="button">${uiLabelMap.CommonSave}</button></div></div>
		<div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  
</div>

