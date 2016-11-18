<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">
<style type="text/css">
.nav-tabs li{list-style:none;}
.nav-tabs li.current a{background:#b3d9ff; color:#000; font-weight:bold;}
</style>

 
<div class="rtab-warp" id="newGuideTarget2" style="padding-left:15px; padding-top:5px;"> 
    <ul class="nav-tabs" style="padding-top:10px; padding-bottom:20px; border:none;">
    	<li id="li1"> <a href="<@ofbizUrl>myorder</@ofbizUrl>"> <span id="shelfProductNum"> 全部&nbsp; </span> </a> </li> 
        <li id="ORDER_CREATED"> <a href="<@ofbizUrl>myorder?orderStatusId=ORDER_CREATED</@ofbizUrl>"> <span id="shelfProductNum"> 待审核&nbsp; </span> </a> </li> 
        <li id="ORDER_PROCESSING"> <a href="<@ofbizUrl>myorder?orderStatusId=ORDER_PROCESSING</@ofbizUrl>"> <span id="auditProductNum"> 审核通过 &nbsp;</span> </a> </li> 
        <li id="ORDER_APPROVED"> <a href="<@ofbizUrl>myorder?orderStatusId=ORDER_APPROVED</@ofbizUrl>"> <span id="auditFailProductNum"> 审核未通过 &nbsp;</span> </a> </li>    
    </ul> 
    <div class="propbox tipstion"> 
    </div> 
</div>

<div class=""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div class="page-content" style="border:1px solid #ccc; margin:15px; margin-top:5px;">
<div class="screenlet-title-bar" style="font-size:14px; color:#555; font-weight:bold;">搜索选项<br class="clear"></div>
<div style="padding-top:15px;">
	<form class="basic-form">
	<label>起始时间：</label>
	<span class="view-calendar">
		<input id="start_order_time" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="minDate" maxLength="30" size="25" type="text" value="${minDate?if_exists}">
	</span>
	
    <script type="text/javascript">
         jQuery(function () {
            // 时间设置
            jQuery('#start_order_time').datetimepicker({
                 showSecond: true,
          timeFormat: 'HH:mm:ss',
          stepHour: 1,
          stepMinute: 1,
          stepSecond: 1,
          showOn: 'button',
          buttonImage: '',
          buttonText: '',
          buttonImageOnly: false,
          dateFormat: 'yy-mm-dd'
 
            });

        });
                
     </script>
     <label>&nbsp;&nbsp;&nbsp;终止时间：</label>
     <span class="view-calendar">
     	<input id="end_order_time" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="maxDate" maxLength="30" size="25" type="text" value="${maxDate?if_exists}">
     </span>
     <script type="text/javascript">
     jQuery(function () {
            // 时间设置
            jQuery('#end_order_time').datetimepicker({
                 showSecond: true,
          timeFormat: 'HH:mm:ss',
          stepHour: 1,
          stepMinute: 1,
          stepSecond: 1,
          showOn: 'button',
          buttonImage: '',
          buttonText: '',
          buttonImageOnly: false,
          dateFormat: 'yy-mm-dd'
 
            });

        });
                
      </script>
      <input type="hidden" id="orderStatus" name="statusId" value="${orderStatusId?if_exists}"/>
      <input type="submit" value="查询" />
</form>
</div>
    <div class="page-content-area">
        <div class="page-header" style="padding-bottom:5px;">
            <h1 style="padding-top:15px; font-size:18px;">退款订单列表</h1>
        </div>

<div class="row">
  <div class="col-xs-12">
    <div class="table-header"> </div>
    <!-- <div class="table-responsive"> -->
    <!-- <div class="dataTables_borderWrap"> -->
    <div>
  <table cellspacing="0" class="table-bordered"> 
   <tbody>
    <tr class="header-row-2">
     <td>
     	<label class="position-relative">
              <input type="checkbox" class="ace">
              <span class="lbl"></span>
        </label>
     </td> 
     <td> <a class="sort-order" href="">日期</a> </td> 
     <td> <a class="sort-order" href="">订单</a> </td> 
     <td> <a class="sort-order" href="">金额</a> </td> 
     <td> <a class="sort-order" href="">状态</a> </td>
     <#-- 
     <td> <a class="sort-order" href="">快递单号</a> </td>
     <td> <a class="sort-order" href="">发票</a> </td>
     --> 
     <td> <a class="sort-order" href="">操作</a> </td> 
    </tr> 
    <#if orderList?has_content>
        <#list orderList as orderHeader>
        <#assign status = orderHeader.getRelatedOne("StatusItem", true) />
        <tr>
            <td class="center"><label class="position-relative">
              <input type="checkbox" class="ace" />
              <span class="lbl"></span> </label>
            </td>
            <td><a href="#">${orderHeader.orderDate.toString()}</a> </td>
            <td>${orderHeader.orderId}</td>
            <td class="hidden-480"><@ofbizCurrency amount=orderHeader.grandTotal isoCode=orderHeader.currencyUom /></td>
            <td>已审核</td><#--${status.get("description",locale)} -->
            <#-- invoices -->
            <#assign invoices = delegator.findByAnd("OrderItemBilling", Static["org.ofbiz.base.util.UtilMisc"].toMap("orderId", "${orderHeader.orderId}"), Static["org.ofbiz.base.util.UtilMisc"].toList("invoiceId"), false) />
            <#assign distinctInvoiceIds = Static["org.ofbiz.entity.util.EntityUtil"].getFieldListFromEntityList(invoices, "invoiceId", true)>
            <#-- 
            <td class="hidden-480">无</td>
            <#if distinctInvoiceIds?has_content>
            <td class="hidden-480"><#list distinctInvoiceIds as invoiceId> <a href="<@ofbizUrl>invoice.pdf?invoiceId=${invoiceId}</@ofbizUrl>" class="buttontext">(${invoiceId} PDF) </a> </#list></td>
            <#else>
            <td class="hidden-480">无</td>
            </#if>
            -->
               <td>
              	<a class="blue" href="<@ofbizUrl>myorderDeail?orderId=${orderHeader.statusId}</@ofbizUrl>"> 查看</i> </a>
              	
              	     <#if orderHeader.statusId?has_content>
            			<#if orderHeader.statusId == "ORDER_CREATED">
            				|<a class="red" href="#">审核</i> </a>
            			</#if>
            			<#if orderHeader.statusId == "ORDER_PROCESSING">
            				|<a class="red" href="#">审核</i> </a>
            			</#if>
            			<#if orderHeader.statusId == "ORDER_APPROVED">
            				|<a class="red" href="#">审核</i> </a>
            			</#if>
            			<#if orderHeader.statusId == "ORDER_COMPLETED">
            				|<a class="red" href="#">审核</i> </a>
            			</#if> 
            		</#if> 
              </td>
          </tr>
        </#list>
        </#if>	
   </tbody>
  </table>
    </div>
  </div>
</div>
  </div>
    <!-- /.page-content-area -->
</div>