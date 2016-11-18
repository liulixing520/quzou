	<#-- 
	<form name="MybuyerForm" method="post" action="" id="mybuyerformid">
	<table width="100%" cellpadding="0" cellspacing="0"
		bordercolor="#c8d9e9">
		<input name="selectedBuyerIds" id="selectedBuyerIds" type="hidden" value="">
		<tr>
			<td>买家：</td><td><input name="buyernickname" size="25" type="text" id="textfield" size="10" maxlength="20" value=""> </td>
			<td>昵称：</td><td><input name="mybuyernickname" size="25"  type="text" id="textfield2" size="10" maxlength="20" value=""></td>
			<td>买家所在国家：<select name="buyercountryid" size="1" id="select"  class="oSelect1">
							<option value="">选择国家</option>
					</select> 
			</td>
		</tr>
		<tr>
			<td >下单日期：</td><td>
			<input id="startdate" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="startdate" maxLength="30" size="25" type="text" >
			<script type="text/javascript">
		         jQuery(function () {
		            // 时间设置
		            jQuery('#startdate').datetimepicker({
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
		     </td><td>
		     到 </td><td>
			 <input id="enddate" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="enddate" maxLength="30" size="25" type="text" value="${endTime?if_exists}">
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
		      </script></td>
		     <td><button type="button" onclick="search()"> <span class="button1_lt"><span class="button1_ri">搜索</span></button></td>
		    </tr>
			
		</table>			
			
				
			
			
			 
			
			
			
	</form>
	 添加群发按钮 start -->
	 <#-- 
		<div style="float: right;">
			排序查看： <select name="orderbycount" id="orderbycount" size="1"
				class="oSelect1" onchange="orderbyrfxcount()">
				<option value="0">选择交易次数</option>
				<option value="1">低到高</option>
				<option value="2">高到低</option>
			</select> <select name="orderbyGMV" id="orderbyGMV" size="1" class="oSelect2"
				onchange="orderbygmv()">
				<option value="0">选择交易总额数</option>
				<option value="1">低到高</option>
				<option value="2">高到低</option>
			</select>
		</div>
	添加群发按钮 end -->
	<#-- 
<table width="100%" border="1" cellpadding="0" cellspacing="0"
		bordercolor="#c8d9e9">
		<tbody>
			<tr class="bbg">
				<td width="40"><input type="checkbox" value="">
				</td>
				<td width="70">买家</td>
				<td>昵称</td>
				<td>买家级别</td>
				<td>信用度</td>
				<td>12个月内好评率</td>
				<td>交易次数</td>
				<td>交易总金额</td>
				<td>最后一次交易时间</td>
				<td>操作</td>
				<td>备注</td>
			</tr>

		</tbody>
	</table>
	-->
	
         <script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script> 
         <script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script> 
         <script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script> 
         <script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script> 
         <script src="/portal/images/js/jquery.pagination.js" type="text/javascript"></script> 
         <link rel="stylesheet" type="text/css" href="../seller/css/javascript.css" /> 
         <link rel="stylesheet" href="/portal/images/css/pagination.css" type="text/css" /> 
         <style type="text/css">
			.nav-tabs li{list-style:none;}
			.nav-tabs li.current a{background:#b3d9ff; color:#000; font-weight:bold;}
		</style> 
         <script type="text/javascript">
	$(function(){
		<!--
		startId=$("#orderStatus").val();
		$("li").remove(".current");
		if(startId==""){
			$("#li1").attr("class", "current"); 
		}else{
			$("#"+startId).attr("class", "current");
		}
		-->
		$(".breadcrumb").html("<li><i class='ace-icon fa fa-home home-icon'></i><a href='/portal/control/sellerIndex'>首页</a></li><li class='active'>报表管理</li><li class='active'>商品销售量列表</li>")
		$("#ORDER_APPROVED").attr("class", "current"); 
		function pageselectCallback(page_id, jq) {
               //alert(page_id); 回调函数，进一步使用请参阅说明文档
               //TranUrl(page_id);
        }
        $("#Pagination").pagination("3", {
               callback: pageselectCallback,//PageCallback() 为翻页调用次函数。
               prev_text: " 上一页",
               next_text: "下一页 ",
               items_per_page: 10, //每页的数据个数
               num_display_entries: 4, //两侧首尾分页条目数
               current_page:"0",   //当前页码
               num_edge_entries: 2, //连续分页主体部分分页条目数
               link_to:"?page=__id__"
        });
         function  TranUrl(page_id){
         	var url=location.href;
         	//var startOrderDate=$("#start_order_time").val();
         	//var endOrderDate=$("#end_order_time").val();
         	var statusId=$("#orderStatus").val();
         	if(statusId.length>0){
         		url=url+"statusId="+statusId
         	}
			location.href=url+"&page="+page_id;
         }
	})

</script> 
         <div class="rtab-warp" id="newGuideTarget2" style="padding-left:15px; padding-top:5px;"> 
         <#-- 
          <ul class="nav-tabs" style="padding-top:10px; padding-bottom:20px; border:none;"> 
           <li id="li1"> <a href="/portal/control/user_myorder?statusId=ORDER_CREATED"> <span id="shelfProductNum"> 15日商品销售额&nbsp; </span> </a> </li> 
           <li id="ORDER_APPROVED"> <a href="/portal/control/user_myorder?statusId=ORDER_APPROVED"> <span id="auditFailProductNum"> 30日商品销售额&nbsp;</span> </a> </li> 
           <li id="ORDER_SENT" > <a href="/portal/control/user_myorder?statusId=ORDER_SENT"> <span id="downShelfProductNum"> 半年商品销售额 &nbsp;</span> </a> </li> 
           <li id="ORDER_COMPLETED"> <a href="/portal/control/user_myorder?statusId=ORDER_COMPLETED"> <span id="auditFailProductNum2"> 一年商品销售额 &nbsp;</span> </a> </li> 
          </ul>
          --> 
          <div class="propbox tipstion"> 
          </div> 
         </div> 
         <div class="">
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         </div> 
         <div class="page-content" style="border:1px solid #ccc;margin:15px; margin-top:5px;"> 
          <div class="page-content-area"> 
           <div class="page-header" style="padding-bottom:5px; height:50px;"> 
            <h1 style="padding-top:15px; font-size:18px; float:left;">商品销售量列表</h1>
            <a class="smallSubmit" style="float:right; margin-top:5px;" href="<@ofbizUrl>MySalesVolumeGoodsReport.xls</@ofbizUrl>">导出EXCEL</a> 
           </div>
           <div class="row"> 
            <div class="col-xs-12"> 
             <div class="table-header"> 
             </div> 
             <!-- <div class="table-responsive"> --> 
             <!-- <div class="dataTables_borderWrap"> --> 
             <div> 
              <table cellspacing="0" class="basic-table hover-bar"> 
               <tbody> 
                <tr class="header-row-2"> 
                 <td class="sort-order"> <label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="sort-order" href="">商品名称</a></td> 
                 <td><a class="sort-order" href="">商品销售量</a></td>
                 <td><a class="sort-order" href="">商品描述</a></td> 
                 <td><a class="sort-order" href="">商品单价</a></td>
                 <#--  
                 <td><a class="sort-order" href="">第二金额</a></td> 
 				-->
                </tr>
                <#if mySalseVolumeGoods?has_content>
                	<#list mySalseVolumeGoods as product>
                	
                	<tr> 
                 		<td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 		<td><a class="blue" href="#">${product.internalName!}</a></td> 
                 		<td class="hidden-480">${product.totalQuantity!}</td> 
                 		<td>${product.itemDescription!}</td>
                 		<td><@ofbizCurrency amount=product.unitPrice isoCode="USD" /></td><#--${party.totalGrandAmount!}  --> 
                 		<#--<td class="hidden-480"><@ofbizCurrency amount=party.totalSubRemainingAmount isoCode="USD" /></td> ${party.totalSubRemainingAmount!} -->

                	</tr>
                	</#list> 
                </#if>
                <#--
                <tr> 
                 <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10040">WSCO10040</a></td> 
                 <td class="hidden-480">12134</td> 
                 <td>2014-10-20 19:35:02.0</td> 
                 <td>有货</td> 
                 <td class="hidden-480">323</td> 

                </tr> 
                <tr> 
                 <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10060">WSCO10060</a></td> 
                 <td class="hidden-480">33423</td> 
                 <td>2014-10-20 20:25:40.0</td> 
                 <td>有货</td> 
                 <td class="hidden-480">3434</td> 

                </tr> 
                <tr> 
                 <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10070">WSCO10070</a></td> 
                 <td class="hidden-480">6545</td> 
                 <td>2014-10-20 20:28:41.0</td> 
                 <td>有货</td> 
                 <td class="hidden-480">7667</td> 
                </tr>
                --> 
               </tbody> 
              </table> 
              <#-- 
              <div id="Pagination" class="flickr"></div> 
              -->
             </div> 
            </div> 
           </div> 
          </div> 
          <!-- /.page-content-area --> 
         </div>