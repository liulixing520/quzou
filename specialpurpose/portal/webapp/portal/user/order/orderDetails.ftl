<link rel="stylesheet" href="/portal/images/css/dingdan.css" type="text/css"/>
<style type="text/css">
.ftx04{color:#F00;}
#orderinfo .total {display: block; padding:20px 0 30px 0;}
#orderinfo .total .extra{float:right;padding:10px 20px 0 0;border-top:1px solid #ccc;font-size:16px;font-weight:bold;}
#orderinfo .total .extra b{font-size:24px;}
#orderinfo .total ul{}
#orderinfo .total ul li{list-style:none;}
#orderinfo, #ordermess {
border: 1px solid #DADADA;
padding: 0 5px 10px;
background: #EDEDED;
overflow: visible;}
#orderinfo .mt, #ordermess .mt {
padding: 0 8px;
height: 30px;
line-height: 30px;
font-size: 14px;}
#orderinfo .mc, #ordermess .mc {
padding: 5px 8px;
background: #fff;
overflow: visible;}
#orderinfo .mc dl {
padding: 10px 5px;
border-top: 1px solid #EDEDED;
margin-bottom:0;
}
#orderinfo .mc dl.fore {
border-top: 0;}
#orderinfo .mc dt {
margin-bottom: 4px;
font-weight: bold;
}
#orderinfo dl li {
font-family: simsun; list-style:none; line-height:25px;
}
#orderinfo dl dd ul{padding:0;margin:0;}

#orderstate {
border: 1px solid #EED97C;
padding: 0 5px;
background: #FFFCEB;
}
#orderstate .mt {
padding: 4px 8px;
height: 35px;
line-height: 35px;
border-bottom: 1px dotted #EED97C;
}
#orderstate .mt strong {
font-size: 14px;
}
.ftx14{color: #12A000;}
#orderstate .mc {
padding: 10px 8px;
}


</style>
<script type="text/javascript">

    $(function(){
    	$(".breadcrumb").append("<li class='active'>${uiLabelMap.TransactionCf}</li><li class='active'>${uiLabelMap.PortalUserOrder}</li><li class='active'>${uiLabelMap.PortalUserOrderInformation}</li>")
    	<#--
    	setBreadcrumb($("#orderDetail").val());
    	-->
    });
  
</script>
	<input type="hidden" id="orderDetail" value="${uiLabelMap.PortalUserViewDetails}"> </input>
   <div class="content profile" > 
      <h2 class="title" style='font-size:20px'>订单详情</h2>
            
    <#--xia mian yi ju shi js jia de -->
    <#assign status = orderHeader.getRelatedOne("StatusItem", true) /> 
     <strong>${uiLabelMap.PortalUserOrderNumber}：${(orderHeader.orderId)!}&nbsp;&nbsp;&nbsp;&nbsp;${uiLabelMap.PortalUserState}：<span class="ftx14"><#--${(localOrderReadHelper.getStatusString(locale))!}-->${(status.get("description",locale))!}</span><span id="pay-button-5329200077"></span> </strong> 
    </div>
    <#-- 
    <div class="mc">
      There is no description information 
    </div>
    -->  
   <!--进度条-->
   <#--已发送 -->
   <#if orderHeader.statusId=="ORDER_SENT">
    <div class="section4" id="process">
    <div class="node fore ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserSubmitOrder}</li>
        <li class="tx3" id="track_time_0">${orderHeader.orderDate?string("yyyy-MM-dd HH:mm:ss")}<br></li>
      </ul>
    </div>
    <div class="proce ready">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserSuccessfulPayment}</li>
        <li class="tx3" id="track_time_4">${orderHeader.orderDate?string("yyyy-MM-dd HH:mm:ss")}</li>
      </ul>
    </div>
    <div class="proce ready">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserCommodityOutLibrary}</li>
        <li class="tx3" id="track_time_1">2014-10-28 <br>
          15:40:55</li>
      </ul>
    </div>
    <div class="proce ready proce3">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready3">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserReceiptWait}</li>
        <#-- 
        <li class="tx3" id="track_time_5">2014-10-28 <br>
          20:34:25</li>
          -->
      </ul>
    </div>
    <div class="proce ready proce2">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready2">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserCompleted}</li>
        <#-- 
        <li class="tx3" id="track_time_6">2014-10-29 <br>
          11:18:22</li>
          -->
      </ul>
    </div>
  </div>
  </#if>
  <#-- 已创建-->
     <#if orderHeader.statusId=="ORDER_CREATED">
    <div class="section4" id="process">
    <div class="node fore ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserSubmitOrder}</li>
        <li class="tx3" id="track_time_0">${orderHeader.orderDate?string("yyyy-MM-dd HH:mm:ss")}<br></li>
      </ul>
    </div>
    <div class="proce ready proce3">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready3">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserSuccessfulPayment}</li>
        <li class="tx3" id="track_time_4"></li>
      </ul>
    </div>
    <div class="proce ready proce2">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready2">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserCommodityOutLibrary}</li>
        <#-- 
        <li class="tx3" id="track_time_1">2014-10-28 <br>
          15:40:55</li>
          -->
      </ul>
    </div>
    <div class="proce ready proce2">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready2">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserReceiptWait}</li>
        <#-- 
        <li class="tx3" id="track_time_5">2014-10-28 <br>
          20:34:25</li>
          -->
      </ul>
    </div>
    <div class="proce ready proce2">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready2">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserCompleted}</li>
        <#-- 
        <li class="tx3" id="track_time_6">2014-10-29 <br>
          11:18:22</li>
          -->
      </ul>
    </div>
  </div>
  </#if>
  <#-- 已付款-->
       <#if orderHeader.statusId=="ORDER_APPROVED">
    <div class="section4" id="process">
    <div class="node fore ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserSubmitOrder}</li>
        <li class="tx3" id="track_time_0">${orderHeader.orderDate?string("yyyy-MM-dd HH:mm:ss")}<br></li>
      </ul>
    </div>
    <div class="proce ready">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserSuccessfulPayment}</li>
        <li class="tx3" id="track_time_4">${orderHeader.orderDate?string("yyyy-MM-dd HH:mm:ss")}</li>
      </ul>
    </div>
    <div class="proce ready proce3">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready3">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserCommodityOutLibrary}</li>
        <#-- 
        <li class="tx3" id="track_time_1">2014-10-28 <br>
          15:40:55</li>
          -->
      </ul>
    </div>
    <div class="proce ready proce2">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready2">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserReceiptWait}</li>
        <#-- 
        <li class="tx3" id="track_time_5">2014-10-28 <br>
          20:34:25</li>
          -->
      </ul>
    </div>
    <div class="proce ready proce2">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready2">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserCompleted}</li>
        <#-- 
        <li class="tx3" id="track_time_6">2014-10-29 <br>
          11:18:22</li>
          -->
      </ul>
    </div>
  </div>
  </#if>
  
  <#-- 已完成-->
       <#if orderHeader.statusId=="ORDER_COMPLETED">
    <div class="section4" id="process">
    <div class="node fore ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserSubmitOrder}</li>
        <li class="tx3" id="track_time_0">${orderHeader.orderDate?string("yyyy-MM-dd HH:mm:ss")}<br></li>
      </ul>
    </div>
    <div class="proce ready">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserSuccessfulPayment}</li>
        <li class="tx3" id="track_time_4"></li>
      </ul>
    </div>
    <div class="proce ready">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserCommodityOutLibrary}</li>
        <li class="tx3" id="track_time_1">2014-10-28 <br>
          15:40:55</li>
      </ul>
    </div>
    <div class="proce ready">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserReceiptWait}</li>
        <li class="tx3" id="track_time_5">2014-10-28 <br>
          20:34:25</li>
      </ul>
    </div>
    <div class="proce ready">
      <ul>
        <li class="tx1">&nbsp;</li>
      </ul>
    </div>
    <div class="node ready">
      <ul>
        <li class="tx1">&nbsp;</li>
        <li class="tx2">${uiLabelMap.PortalUserCompleted}</li>
        <li class="tx3" id="track_time_6">2014-10-29 <br>
          11:18:22</li>
      </ul>
    </div>
  </div>
  </#if>
   <!--跟踪、付款信息、gis-->
    
   <!--留言--> 
   <!--订单信息--> 
   </div>
   
   <div class="profile_detail clearfix">
    <div class="mt"> 
     <strong>${uiLabelMap.PortalUserOrderInformation}</strong>
    </div> 
    <div class="mc"> 
     <!--顾客信息--> 
     <dl class="fore"> 
      <dt>
       ${uiLabelMap.PortalUserConsigneeInformation}
      </dt> 
      <#if orderItemShipGroups?has_content>
      <#assign groupIdx = 0>
    <#list orderItemShipGroups as shipGroup>
      <#if orderHeader?has_content>
        <#assign shippingAddress = shipGroup.getRelatedOne("PostalAddress", false)?if_exists>
        <#assign groupNumber = shipGroup.shipGroupSeqId?if_exists>
      <#else>
        <#assign shippingAddress = cart.getShippingAddress(groupIdx)?if_exists>
        <#assign groupNumber = groupIdx + 1>
      </#if>
      <#if shippingAddress?has_content>
      <#assign AddressGeoAllCn =Static["org.ofbiz.system.ContactMechTools"].
                            getAddressGeoAllCn(delegator,shippingAddress.stateProvinceGeoId,shippingAddress.cityGeoId,shippingAddress.countyGeoId)>
      <dd> 
       <ul> 
        <li>${uiLabelMap.PortalUserConsignee}：${shippingAddress.toName!shippingAddress.attnName}</li> 
        <li>${uiLabelMap.PortalUserAddress}：${AddressGeoAllCn?if_exists} ${shippingAddress.address1}</li> 
       </ul> 
      </dd>
      </#if>
      <#assign groupIdx = groupIdx + 1>
      <#assign estimatedDeliveryDate =shipGroup.estimatedDeliveryDate?if_exists>
    </#list><#-- end list of orderItemShipGroups -->
  </#if> 
     </dl> 
     <!-- 礼品购订单展示送礼人信息 --> 
     <!--配送、支付方式--> 
     <dl> 
      <dt>
       ${uiLabelMap.PortalUserPaymentAndDeliveryMethods}
      </dt> 
      <dd> 
       
       <ul> 
        <li>${uiLabelMap.PortalUserPayment}：<#if paymentMethodType?has_content>${paymentMethodType.get("description",locale)}</#if></li> 
        <li>${uiLabelMap.PortalUserShippingCharges}：<@ofbizCurrency amount=localOrderReadHelper.getShippingTotal()!'' isoCode=currencyUomId/></li> 
        <li>${uiLabelMap.PortalUserDeliveryDate}：${estimatedDeliveryDate!}</li> 
       </ul> 
      </dd> 
     </dl> 
     <!--发票 
     <dl> 
      <dt>
       发票信息
      </dt> 
      <dd> 
       <ul> 
        <li>发票类型：电子发票</li> 
        <li>发票抬头：个人</li> 
        <li>发票内容：明细</li> 
       </ul> 
      </dd> 
     </dl> 
     -->
     <!-- 礼品购订单展示寄语信息 --> 
     <!--备注--> 
     <#-- 
     <dl> 
      <dt>
       ${uiLabelMap.PortalUserRemark}
      </dt> 
      <dd> 
       <ul> 
        <li>There is no description information</li> 
       </ul> 
      </dd> 
     </dl> 
     -->
     <!--商品--> 
     <dl> 
      <dt> 
       <span>${uiLabelMap.PortalUserProductListing}</span> 
      </dt> 
      <dd> 
       <table cellpadding="0" cellspacing="0" width="100%" class="table-bordered"> 
       	<thead>
       	 <tr> 
          <th width="10%"> ${uiLabelMap.PortalUserProductNumber} </th> 
          <th width="12%"> ${uiLabelMap.PortalUserMoreProductImage} </th> 
          <th width="30%"> ${uiLabelMap.PortalUserProductName} </th> 
          <th width="10%"> ${uiLabelMap.PortalUserSalesPrice} </th>
           <th width="10%"> ${uiLabelMap.PortalUserBelongsStore}</th> 
          <th width="8%"> ${uiLabelMap.PortalUserIntegralValue}</th> 
          <th width="10%"> ${uiLabelMap.PortalUserProductsNumber} </th> 
          <th width="11%"> ${uiLabelMap.PortalUserInventoryStatus} </th> 
         </tr>
       	</thead>
        <tbody> 
        <#list orderItems as orderItem>
        	<#assign product = orderItem.getRelatedOne("Product", true)?if_exists/> <#-- should always exist because of FK constraint, but just in case -->
        	<#assign productStore = delegator.findOne("ProductStore", {"productStoreId" : (product.primaryProductStoreId)!''}, true)?if_exists/>
        	<#assign smallImageUrl = product.smallImageUrl?if_exists>
        	<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/images/defaultImage.jpg"></#if>
         <tr> 
          <td>${orderItem.productId!}</td> 
          <td> 
           <div> 
            <a target="_blank" href="<@ofbizCatalogAltUrl productId=orderItem.productId />"> <img width="50" height="50" src="${smallImageUrl}" title="${product.internalName?if_exists}"/> </a> 
           </div> </td> 
          <td> 
           <div class="al fl">
           <#assign productInfoName = Static["org.ofbiz.product.product.EbizProductContentWrapper"].getProductTitleByLocale(product,request)!!/> 
            <a class="flk13" target="_blank" href="<@ofbizCatalogAltUrl productId=orderItem.productId />" clstag="click|keycount|orderinfo|product_name">${productInfoName?if_exists}</a> <#-- ${orderItem.itemDescription?default("")}-->
           </div> 
           <div class="clr"></div> 
           <div id="coupon_933231" class="fl"></div> </td> 
          <td><span class="ftx04"><@ofbizCurrency amount=orderItem.unitPrice isoCode=currencyUomId/></span></td>
          <td><a target="_blank" href="<@ofbizUrl>sellerhome?productStoreId=${productStore.productStoreId?if_exists}</@ofbizUrl>">${productStore.storeName!}</a></td>  
          <td>0</td> 
          <td>${orderItem.quantity?string.number}</td> 
          <td>${uiLabelMap.PortalUserHaveGoods}</td> 
         </tr> 
         </#list>
         <#--
         <tr> 
          <td>896813</td> 
          <td> 
           <div> 
            <a target="_blank" href="#"> <img width="50" height="50" src="http://img10.360buyimg.com/N5/g13/M05/08/03/rBEhVFNWMy4IAAAAAAHLCGMFzKEAAMS0ANx39AAAcsg736.jpg" title="西部数据（WD） Elements 新元素系列 2.5英寸 USB3.0 移动硬盘 1TB（WDBUZG0010BBK）" /> </a> 
           </div> </td> 
          <td> 
           <div class="al fl"> 
            <a class="flk13" target="_blank" href="#" clstag="click|keycount|orderinfo|product_name"> 西部数据（WD） Elements 新元素系列 2.5英寸 USB3.0 移动硬盘 1TB（WDBUZG0010BBK）</a> 
           </div> 
           <div class="clr"></div> 
           <div id="coupon_896813" class="fl"></div> </td> 
          <td><span class="ftx04"> ￥449.00</span></td> 
          <td>0</td> 
          <td>1</td> 
          <td> 有货 </td> 
         </tr> 
         -->
        </tbody>
       </table> 
      </dd> 
     </dl> 
     <!--条形码--> 
     <!-- 商家运费险  --> 
    </div> 
    <!--金额--> 
    <div class="total"> 
     <ul> 
      <li><span>${uiLabelMap.PortalUserGoodsAmount}：</span><@ofbizCurrency amount=orderSubTotal isoCode=currencyUomId/></li> 
      <li><span>+ ${uiLabelMap.PortalUserShippingCosts}：</span><@ofbizCurrency amount=orderShippingTotal isoCode=currencyUomId/></li> 
     </ul> 
     <div style="clear:both;"></div>
     <div class="extra">
       ${uiLabelMap.PortalUserTotalPayable}：
      <span class="ftx04"><b><@ofbizCurrency amount=orderGrandTotal isoCode=currencyUomId/></b></span> 
     </div> 
    </div> 
   </div>
    
  </div>
   