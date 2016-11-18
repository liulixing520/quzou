<script language='javascript'>
function toggleAll(e, formName) {
    var cform = document[formName];
    var len = cform.elements.length;
    for (var i = 0; i < len; i++) {
        var element = cform.elements[i];
        if (element.name.substring(0, 10) == "_rowSubmit" && element.checked != e.checked) {
            toggle(element);
        }
    }
}
function checkToggle(e, formName) {
    var cform = document[formName];
    if (e.checked) {
        var len = cform.elements.length;
        var allchecked = true;
        for (var i = 0; i < len; i++) {
            var element = cform.elements[i];
            if (element.name.substring(0, 10) == "_rowSubmit" && !element.checked) {
                allchecked = false;
            }
            cform.selectAll.checked = allchecked;
        }
    } else {
        cform.selectAll.checked = false;
    }
}
function toggle(e) {
    e.checked = !e.checked;
}
function addProToOrder(){
    form = document.getElementById("selectAllForm");
	if(validateForm(form)==undefined){
		var flag = 'N';
		var checkboxes = $("input:checked[type=checkbox][name^='_rowSubmit_o_']");
	    if (checkboxes.length == 0) {
			alert('请选择退换货商品');
			return false;
		}
	    $.ajax({
          type: "Post",
          url: "<@ofbizUrl>/requestReturn</@ofbizUrl>",
          data: jQuery('#selectAllForm').serialize(),
          success: function(data) {alert
              if(data._ERROR_MESSAGE_) {
					 alert(data._ERROR_MESSAGE_);
				 }
				 else{
					 alert('操作成功!');closeDialog();
				 }
          },
          error: function(err) {
              alert(err);
          }
      });
	}
}
function changeReturnType(id1,id2){
		if(id1=="RTN_REFUND"){
			document.getElementById("returnTypeOne").style.display = "none";
			document.getElementById("returnTypeTwo").style.display = "none";
			document.getElementById("returnTypeThree").style.display = "none";
			document.getElementById("returnTypeFour").style.display = "none";
		}else{
			document.getElementById("returnTypeOne").style.display = "";
			document.getElementById("returnTypeTwo").style.display = "";
			document.getElementById("returnTypeThree").style.display = "";
			document.getElementById("returnTypeFour").style.display = "";
		}
		var checkboxes = $("input:[type=hidden][name^='returnTypeId_o_']");
		$("input[type=hidden][name^='returnTypeId_o_']").each(function(){
			$(this).val(id1);
		});
	}
//returnTypeOne
</script>
<div class="pageContent">
    <div class="pageContent" layoutH="42">
        <form name="selectAllForm" id="selectAllForm" method="post" action="<@ofbizUrl>requestReturn</@ofbizUrl>">
          <input type="hidden" name="_checkGlobalScope" value="Y"/>
          <input type="hidden" name="_useRowSubmit" value="Y"/>
          <input type="hidden" name="returnHeaderTypeId" value="CUSTOMER_RETURN"/>
          <input type="hidden" name="fromPartyId" value="${party.partyId}"/>
          <input type="hidden" name="toPartyId" value="${toPartyId?if_exists}"/>
          <input type="hidden" name="orderId" value="${orderId}"/>
          <#if (orderHeader.currencyUom)?has_content>
          <input type="hidden" name="currencyUomId" value="${orderHeader.currencyUom}"/>
          </#if>
          <table border="0" width="100%" cellpadding="2" cellspacing="0">
            <tr>
              <td colspan="7"><h3>${uiLabelMap.OrderReturnItemsFromOrder}</h3></td>
            </tr>
            <tr><td colspan="7">&nbsp;</td></tr>
            <tr>
              <td colspan="1" width="80px"><h3>退换货类型:</h3></td>
              <td colspan="6" align="left">
              	<input name="returnTypeId" type="radio" value="RTN_REFUND" onclick="changeReturnType('RTN_REFUND','RTN_REPLACE')" checked/>
      		    	退货
      		    <input name="returnTypeId" type="radio" value="RTN_REPLACE" onclick="changeReturnType('RTN_REPLACE','RTN_REFUND')"/>
      		    	换货
			  </td>
            </tr>
            <tr><td colspan="7">&nbsp;</td></tr>
            <tr>
              <td>
                <input type="checkbox" name="selectAll" value="Y" onclick="javascript:toggleAll(this, 'selectAllForm');"/><span class="tableheadtext">${uiLabelMap.CommonSelectAll}</span>&nbsp;
			  </td>
              <td><div class="tableheadtext">商品编号</div></td>
              <td><div class="tableheadtext">商品名称</div></td>
              <td><div class="tableheadtext">${uiLabelMap.CommonQuantity}</div></td>
              <td><div class="tableheadtext">单价</div></td>
              <td><div class="tableheadtext">${uiLabelMap.OrderReason}</div></td>
              <td><div class="tableheadtext">备注</div></td>
            </tr>
            <tr><td colspan="7"><hr /></td></tr>
            <#if returnableItems?has_content>
              <#assign rowCount = 0>
              <#list returnableItems.keySet() as orderItem>
              <#if !orderItem.orderAdjustmentId?has_content>    <#-- filter orderAdjustments -->
                <input type="hidden" name="orderId_o_${rowCount}" value="${orderItem.orderId}"/>
                <input type="hidden" name="orderItemSeqId_o_${rowCount}" value="${orderItem.orderItemSeqId}"/>
                <input type="hidden" name="description_o_${rowCount}" value="${orderItem.itemDescription?if_exists}"/>
                <#-- <input type="hidden" name="returnItemType_o_${rowCount}" value="ITEM"/> -->
                <#assign returnItemType = returnItemTypeMap.get(returnableItems.get(orderItem).get("itemTypeKey"))?if_exists/>
                <input type="hidden" name="returnItemTypeId_o_${rowCount}" value="${returnItemType}"/>
                <input type="hidden" name="returnPrice_o_${rowCount}" value="${returnableItems.get(orderItem).get("returnablePrice")}"/>

                <#-- need some order item information -->
                <#assign orderHeader = orderItem.getRelatedOne("OrderHeader")>
                <#assign itemCount = orderItem.quantity>
                <#assign itemPrice = orderItem.unitPrice>
                <#-- end of order item information -->

                <tr>
                   <td align="left">
                    <input type="checkbox" name="_rowSubmit_o_${rowCount}" value="Y" onclick="javascript:checkToggle(this, 'selectAllForm');"/>
                  </td>
                  <td>
                    <div class="tabletext">
                      <#if orderItem.productId?exists>
                        &nbsp;${orderItem.productId}
                        <input type="hidden" name="productId_o_${rowCount}" value="${orderItem.productId}"/>
                      </#if>
                    </div>
                  </td>
                  <td>
                    <div class="tabletext">
                      ${orderItem.itemDescription}
                    </div>
                  </td>
                  <td>
                    <input type="text" class="inputBox required digits" max='${returnableItems.get(orderItem).get("returnableQuantity")}' maxlength="6" size="6" name="returnQuantity_o_${rowCount}" value="0"/>
                   	 <br/><div>最大数量：<span style="color:red">${returnableItems.get(orderItem).get("returnableQuantity")}</span></div>
                  </td>
                  <td>
                    <div class="tabletext"><@ofbizCurrency amount=returnableItems.get(orderItem).get("returnablePrice") isoCode=orderHeader.currencyUom/></div>
                  </td>
                  <td>
                    <select name="returnReasonId_o_${rowCount}" class="selectBox">
                      <#list returnReasons as reason>
                        <option value="${reason.returnReasonId}">${reason.get("description",locale)?default(reason.returnReasonId)}</option>
                      </#list>
                    </select>
                  <input type="hidden" name="returnTypeId_o_${rowCount}" value="RTN_REFUND"/>
                  </td>
                  <td>
                    <textarea name="comments_o_${rowCount}" class="inputBox" maxlength="120"></textarea>
                  </td>
                 
                </tr>
                <tr><td colspan="7"><hr /></td></tr>
                <#assign rowCount = rowCount + 1>
              </#if>
              </#list>
              <input type="hidden" name="_rowCount" value="${rowCount}"/>
              <tr id="returnTypeOne" style="display:none">
                <td colspan="7"><div class="tableheadtext">${uiLabelMap.OrderSelectShipFromAddress}:</td>
              </tr>
              <tr id="returnTypeTwo" style="display:none"><td colspan="7"><hr /></td></tr>
              <tr id="returnTypeThree" style="display:none">
                <td colspan="7">
                  <table cellspacing="1" cellpadding="2" width="100%">
                    <#list shippingContactMechList as shippingContactMech>
                      <#assign shippingAddress = shippingContactMech.getRelatedOne("PostalAddress")>
                      <tr>
                        <td width="99%" valign="top" nowrap="nowrap">
                          <div class="tabletext">
                          <input type="radio" name="originContactMechId" value="${shippingAddress.contactMechId}" <#if shippingContactMech_index==0>checked</#if>/>
                            <#if shippingAddress.toName?has_content><b>${uiLabelMap.CommonTo}:</b>&nbsp;${shippingAddress.toName}</#if>
                            <#if shippingAddress.attnName?has_content><b>${uiLabelMap.PartyAddrAttnName}:</b>&nbsp;${shippingAddress.attnName}</#if>
                            <#if shippingAddress.stateProvinceGeoId?has_content>
                            <#assign stateProvince = delegator.findOne("Geo", {"geoId" : shippingAddress.stateProvinceGeoId}, true)>
                            &nbsp;${stateProvince.geoName}
                            </#if>
                            <#if shippingAddress.city?has_content>
                            <#assign city = delegator.findOne("Geo", {"geoId" : shippingAddress.cityGeoId}, true)>
                            &nbsp;${city.geoName}</#if>
                            <#if shippingAddress.countyGeoId?has_content>
                            <#assign country = delegator.findOne("Geo", {"geoId" : shippingAddress.countyGeoId}, true)>
                            &nbsp;${country.geoName}
                            </#if>
                            <#if shippingAddress.address1?has_content>&nbsp;${shippingAddress.address1}</#if>
                            <#if shippingAddress.postalCode?has_content>&nbsp;${shippingAddress.postalCode}</#if>
                            <#--a href="<@ofbizUrl>editcontactmech?DONE_PAGE=checkoutoptions&amp;contactMechId=${shippingAddress.contactMechId}</@ofbizUrl>" class="buttontext">[${uiLabelMap.CommonUpdate}]</a-->
                          </div>
                        </td>
                      </tr>
                    </#list>
                  </table>
                </td>
              </tr>
              <tr id="returnTypeFour" style="display:none"><td colspan="7"><hr /></td></tr>
            <#else>
              <tr><td colspan="7"><div class="tabletext">${uiLabelMap.OrderNoReturnableItems} ${uiLabelMap.CommonNbr}${orderId}</div></td></tr>
            </#if>
          </table>
        </form>
    </div>
	<div class="formBar" >
		<ul>
		<li><a class="button" href="#" onclick="javascript:addProToOrder();"  ><span>确定</span></a></li>
		<li><a class="button" href="#" onclick='javascript:closeDialog();'><span>关闭</span></a></li>
		</ul>
				
	</div> 
</div>