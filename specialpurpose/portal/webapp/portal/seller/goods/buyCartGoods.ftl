
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
		
		$(".breadcrumb").append("<li class='active'>报表管理</li><li class='active'>购物车商品</li>")
		
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
          <ul class="nav-tabs" style="padding-top:10px; padding-bottom:20px; border:none;"> 
           <li id="li1"> <a class="blue" href="/portal/control/shoppingCartHistoryHTML"> <span id="shelfProductNum"> 報表頁面&nbsp; </span> </a> </li> 
           <li> <a class="blue" href="/portal/control/shoppingCartHistoryPdf"> <span id="auditFailProductNum"> 导出pdf&nbsp;</span> </a> </li> 
           <li> <a class="blue" href="/portal/control/shoppingCartHistory.xls"> <span id="downShelfProductNum"> 导出EXCEL&nbsp;</span> </a> </li> 
          </ul> 
          <div class="propbox tipstion"> 
          </div> 
         </div> 
         <div class="">
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         </div>  
       <#--  <div class="page-content"> 
          <div class="screenlet-title-bar" style="font-size:14px; color:#555; font-weight:bold;">
             <a class="blue" href="/portal/control/shoppingCartHistoryHTML">HTML</a>
             <br class="clear" />
          </div>
          <div class="screenlet-title-bar" style="font-size:14px; color:#555; font-weight:bold;">
             <a class="blue" href="/portal/control/shoppingCartHistoryPdf">导出pdf</a>
             <br class="clear" />
          </div> 
          <div class="screenlet-title-bar" style="font-size:14px; color:#555; font-weight:bold;">
             <a class="blue" href="/portal/control/shoppingCartHistory.xls">导出EXCEL</a>
             <br class="clear" />
          </div>
          
           <div style="padding-top:15px;"> 
           <form> 
            <label>起始时间：</label> 
            <span class="view-calendar"> <input id="start_order_time" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="startOrderDate" maxlength="30" size="25" type="text" value="" /> </span> 
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
            <span class="view-calendar"> <input id="end_order_time" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="endOrderDate" maxlength="30" size="25" type="text" value="" /> </span> 
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
            <input id="orderStatus" type="hidden" name="statusId" value="ORDER_APPROVED" /> 
            <input type="submit" value="查询" /> 
           </form> 
          </div> -->
          <div class="page-content-area"> 
          <!-- <div class="page-header" style="padding-bottom:5px;"> 
            <h1 style="padding-top:15px; font-size:18px;">购物车商品列表</h1> 
           </div> -->
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
                 <td><a class="sort-order" href="">商品名</a></td> 
                 <td><a class="sort-order" href="">金额</a></td> 
                 <td><a class="sort-order" href="">加入日期</a></td> 
                 <td><a class="sort-order" href="">客户名</a></td> 
                 <td><a class="sort-order" href="">个数</a></td> 
   
                </tr>
                <#if shoppingCartHistoryList?has_content>
                    <#list shoppingCartHistoryList as shl>
                 
                <tr> 
                 <td class="center"><label class="position-relative"> 
                 <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td>${shl.internalName!}</td> 
                 <td class="hidden-480">${shl.modifiedPrice!}</td> 
                 <td>${shl.fromDate!}</td> 
                 <td>${shl.firstName!}${shl.lastName!} </td> 
                 <td class="hidden-480">${shl.quantity!}</td>               
                </tr> 
                    </#list>
                </#if>
                
                <!-- <tr> 
                 <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10060">WSCO10060</a></td> 
                 <td class="hidden-480">￥ 515.05</td> 
                 <td>2014-10-20 20:25:40.0</td> 
                 <td>李四</td> 
                 <td class="hidden-480">3</td> 
                 <td> 
                  <div class="hidden-sm hidden-xs action-buttons"> 
                   <a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10060"> 查看 </a>
                  </div> </td> 
                </tr> 
                <tr> 
                 <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10070">WSCO10070</a></td> 
                 <td class="hidden-480">￥ 91.00</td> 
                 <td>2014-10-20 20:28:41.0</td> 
                 <td>王五</td> 
                 <td class="hidden-480">4</td> 
                 <td> 
                  <div class="hidden-sm hidden-xs action-buttons"> 
                   <a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10070"> 查看 </a> 
                  </div> </td> 
                </tr> -->
               </tbody> 
              </table> 
             <!--  <div id="Pagination" class="flickr"></div> -->
             </div> 
            </div> 
           </div> 
          </div> 
          <!-- /.page-content-area --> 
         </div>