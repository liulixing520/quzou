
  <script type="text/javascript">

$(function () { 
    $('#myTab a:first').tab('show');//初始化显示哪个tab 
  
    $('#myTab a').click(function (e) { 
      e.preventDefault();//阻止a链接的跳转行为 
      $(this).tab('show');//显示当前选中的链接及关联的content 
    }) 
}) 
function gotopage(target){
	window.location.href="/manage/control/mng_ShowOrder?"+$("#orderForm").serialize()+"&viewIndex="+target;
    //cpage = target;
    //alert(target);
    //ourstr=setpage();
    //document.getElementById("setpage").innerHTML =ourstr;
}

function setpage(cpage,totalpage,pagesize,setpage){
		var cpagee=cpage;
		var count=1;
		var outstr="";
        if(totalpage<=15){
                for (count=1;count<=totalpage;count++){
                        if (count<10) {countt ="0"+count+"";}else{countt =""+count+"";}
                        if(count!=cpagee){
                                outstr = outstr + "<a href='javascript:void(0)' onclick='gotopage("+count+")'>["+countt+"]<\/a> ";
                        }else{
                                outstr = outstr + "["+countt+"] ";
                        }
                }
        }
        if(totalpage>15){
                if(parseInt((cpage-1)/15) == 0){
                        outstr = outstr + "<font face='webdings'>7<\/font> ";
                        for (count=1;count<=15;count++){
                                if (count<10) {countt ="0"+count+"";}else{countt =""+count+"";}
                                if(count!=cpagee){
                                        outstr = outstr + "<a href='javascript:void(0)' onclick='gotopage("+count+")'>["+countt+"]<\/a> ";
                                }else{
                                        outstr = outstr + "["+countt+"] ";
                                }
                        }
                        outstr = outstr + "<a href='javascript:void(0)' onclick='gotopage("+count+")'><font face='webdings'>8<\/font><\/a> ";
                }else if(parseInt((cpage-1)/15) == parseInt(totalpage/15)){
                        outstr = outstr + "<a href='javascript:void(0)' onclick='gotopage("+(parseInt((cpage-1)/15)*15)+")'><font face='webdings'>7<\/font><\/a> ";
                        for (count=parseInt(totalpage/15)*15+1;count<=totalpage;count++){
                                if (count<10) {countt ="0"+count+"";}else{countt =""+count+"";}
                                if(count!=cpagee){
                                        outstr = outstr + "<a href='javascript:void(0)' onclick='gotopage("+count+")'>["+countt+"]<\/a> ";
                                }else{
                                        outstr = outstr + "["+countt+"] ";
                                }
                        }
                        outstr = outstr + "<font face='webdings'>8<\/font> ";
                }else{
                        outstr = outstr + "<a href='javascript:void(0)' onclick='gotopage("+(parseInt((cpage-1)/15)*15)+")'><font face='webdings'>7<\/font><\/a> ";
                        for (count=parseInt((cpage-1)/15)*15+1;count<=parseInt((cpage-1)/15)*15+15;count++){
                                if (count<10) {countt ="0"+count+"";}else{countt =""+count+"";}
                                if(count!=cpagee){
                                        outstr = outstr + "<a href='javascript:void(0)' onclick='gotopage("+count+")'>["+countt+"]<\/a> ";
                                }else{
                                        outstr = outstr + "["+countt+"] ";
                                }
                        }
                        outstr = outstr + "<a href='javascript:void(0)' onclick='gotopage("+count+")'><font face='webdings'>8<\/font><\/a> ";
                }

    }    
    
    ourstr = "<div id='setpage'>共"+totalpage+"页|第"+cpage+"页 每页" + pagesize +"个　" + outstr + "<\/div>";
  	document.getElementById(setpage).innerHTML =ourstr;
}


</script>
<div class="rtab-warp" id="newGuideTarget2" style="padding-left:15px; padding-top:5px;"> 

   <ul class="nav nav-tabs" id="myTab"> 
    	<li id="li1" class="active"> <a href="<@ofbizUrl>mng_ShowOrder</@ofbizUrl>"> <span id="shelfProductNum"> 全部&nbsp; </span> </a> </li> 
        <li id="ORDER_CREATED"> <a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_CREATED</@ofbizUrl>"> <span id="shelfProductNum"> 待付款&nbsp; </span> </a> </li>
        <#--  
        <li id="ORDER_PROCESSING"> <a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_PROCESSING</@ofbizUrl>"> <span id="auditProductNum"> 处理中 &nbsp;</span> </a> </li>
        --> 
        <li id="ORDER_APPROVED"> <a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_APPROVED</@ofbizUrl>"> <span id="auditFailProductNum"> 待发货 &nbsp;</span> </a> </li> 
        <li id="ORDER_SENT"> <a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_SENT</@ofbizUrl>"> <span id="downShelfProductNum"> 已发货 &nbsp;</span> </a> </li>
        <li id="ORDER_COMPLETED"> <a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_COMPLETED</@ofbizUrl>"> <span id="auditFailProductNum2"> 已完成 &nbsp;</span> </a> </li> 
        <li id="ORDER_REJECTED"> <a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_REJECTED</@ofbizUrl>"> <span id="downShelfProductNum2"> 已退款 &nbsp;</span> </a> </li>
        <li id="ORDER_CANCELLED"> <a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_CANCELLED</@ofbizUrl>"> <span id="downShelfProductNum2"> 已取消 &nbsp;</span> </a> </li>   
    </ul> 
    <div class="propbox tipstion"> 
    </div> 
</div>
<div class=""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div class="page-content" style=" margin:15px; margin-top:5px;">
<div style="padding-top:15px;">
	<form id="orderForm" name="orderForm" class="pageForm">
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
      <input type="hidden" id="orderStatus2" name="orderStatusId" value="${orderStatusId?if_exists}"/>
      <input type="submit" class="btn btn-primary" value="查询" />
</form>
</div>
    <div class="page-content-area">

<div class="row">
  <div class="col-xs-12">
  <table cellspacing="0" class="table table-bordered table-striped table-condensed"> 
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
     <td> <a class="sort-order" href="">快递单号</a> </td>
     <td> <a class="sort-order" href="">发票</a> </td>
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
            <td>${status.get("description",locale)}</td>
            <#-- invoices -->
            <#assign invoices = delegator.findByAnd("OrderItemBilling", Static["org.ofbiz.base.util.UtilMisc"].toMap("orderId", "${orderHeader.orderId}"), Static["org.ofbiz.base.util.UtilMisc"].toList("invoiceId"), false) />
            <#assign distinctInvoiceIds = Static["org.ofbiz.entity.util.EntityUtil"].getFieldListFromEntityList(invoices, "invoiceId", true)>
            <#assign orderTrackings = delegator.findByAnd("OrderItemShipGroup",{"orderId", orderHeader.orderId},null, false) />
            <#if orderTrackings?has_content>
            	<#assign orderTracking = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(orderTrackings) />
            	<#if orderTracking?has_content && orderTracking.trackingNumber?has_content>
            		<td class="hidden-480">${(orderTracking.trackingNumber)!}</td>
            	<#else>
            		<td class="hidden-480">无</td>
            	</#if>
            <#else>
            	<td class="hidden-480">无</td>
            </#if>

            <#if distinctInvoiceIds?has_content>
            <td class="hidden-480"><#list distinctInvoiceIds as invoiceId> <a href="<@ofbizUrl>invoice.pdf?invoiceId=${invoiceId}</@ofbizUrl>" class="buttontext">(${invoiceId} PDF) </a> </#list></td>
            <#else>
            <td class="hidden-480">无</td>
            </#if>
               	<td>
              	<a class="blue" href="/manage/control/OrderDetail?orderId=${orderHeader.orderId}"> 查看</i> </a>
              	<#if orderHeader.statusId=='ORDER_APPROVED'>
              		<#assign orderStoreId = orderHeader.productStoreId!''/>
              		<#assign storeOwners = delegator.findByAnd("ProductStoreRole",{"roleTypeId":"OWNER","productStoreId":orderStoreId})/>
              		<#if storeOwners?? && storeOwners?size &gt; 0>
              			<#assign storeOwner = storeOwners[0].partyId />
              		</#if>
                	<!--|<a class="red" href="/manage/control/sendOrder?orderId=${orderHeader.orderId}&partyId=${storeOwner!}&backUrl=/manage/control/mng_ShowOrder">发货</i></a>-->
                	|<a class="red" href="javascript:submitpayment('${orderHeader.orderId}','${storeOwner!}');">发货</i></a>
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
<input value="hehe" type="button" style="display:none" onclick="dakai()" id="submitpayment"/>
<link rel="stylesheet" href="/portal/seller/images/product/easydialog.css" type="text/css"/>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.js"></script>
<script type="text/javascript" src="/portal/seller/images/product/easydialog.min.js"></script>
<style type="text/css">
.easyDialog_wrapper{width:500px;}
.easyDialog_wrapper .easyDialog_title{margin:0;}
.easyDialog_wrapper .easyDialog_text{padding-left:50px;}

</style>
<div id="imgBox" style="display:none">
	<div class="easyDialog_footer" style="padding-left:100px; padding-bottom:10px;">
	<a href="javascript:sendOrder();" class="btn_highlight" style="float:left; margin-left:20px; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">提交</a>
	<a href="javascript:location.reload();" class="btn_normal" style="float:left; height:30px; line-height:30px; padding:0 20px;text-decoration:none;">取消</a>
	</div>
</div>
<script>

function dakai(){
	easyDialog.open({
		container : {
			header : '${uiLabelMap.Pleaseorder}',
			content : $('#imgBox').html()
		}
	});
	$("#closeBtn").attr("href","javascript:location.reload()");
};
function submitpayment(oderID,partyId){
	jQuery.ajax({
            type: "get",//使用get方法访问后台
            url: "/manage/control/ajaxSendOrder?orderId="+oderID+"&partyId="+partyId+"&backUrl=/manage/control/mng_ShowOrder",//要访问的后台地址
            data:{},//要发送的数据
            success: function (msg) {//msg为返回的数据，在这里做数据绑定
                $('#imgBox').html(msg+$('#imgBox').html());
                document.getElementById('submitpayment').click();
                document.getElementsByName("form")[0].submit();
            }
      });
}



</script>

<script>
function sendOrder(){
			/**var trackingNumber = $("#trackingNumber").val();
			var contactMecheId = $("#contactMecheId").val();*/
			
			var trackingNumber = $("input[id='trackingNumber']")[1].value;
			
			var contactMecheId = $("select[id='contactMecheId']")[1].value;
			
			var orderId = $("#orderId").val();
			if(!trackingNumber){
				alert("快递单号不能为空！");
				return;
			}
			if(!orderId){
				alert("订单信息丢失！");
				return;
			}
			if(!contactMecheId){
				alert("请选择发货地址！");
				return;
			}
			jQuery.ajax({
				url:'doSendOrder',
				type:'POST',
				data:{trackingNumber:trackingNumber,contactMecheId:contactMecheId,orderId:orderId},
				success:function(r){
					if(r._ERROR_MESSAGE_){
						alert(r._ERROR_MESSAGE_);
					}else{
						alert('发货成功');
						location.reload();
					}
				}
			});
		}
	</script>
</div>
<div id="setpage"></div>