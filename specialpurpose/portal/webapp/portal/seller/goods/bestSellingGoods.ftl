
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
		$(".breadcrumb").append("<li class='active'>报表管理</li><li class='active'>畅销商品</li>")
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
          <ul class="nav-tabs" style="padding-top:10px; padding-bottom:20px; border:none;"> 
           <li id="li1"> <a href="/portal/control/user_myorder?statusId=ORDER_CREATED"> <span id="shelfProductNum"> 今日畅销商品&nbsp; </span> </a> </li> 
           <li id="ORDER_APPROVED"> <a href="/portal/control/user_myorder?statusId=ORDER_APPROVED"> <span id="auditFailProductNum"> 三天畅销商品&nbsp;</span> </a> </li> 
           <li id="ORDER_SENT" > <a href="/portal/control/user_myorder?statusId=ORDER_SENT"> <span id="downShelfProductNum"> 一周畅销商品 &nbsp;</span> </a> </li> 
           <li id="ORDER_COMPLETED"> <a href="/portal/control/user_myorder?statusId=ORDER_COMPLETED"> <span id="auditFailProductNum2"> 一月畅销商品 &nbsp;</span> </a> </li> 
           <li id="ORDER_REJECTED"> <a href="/portal/control/user_myorder?statusId=ORDER_REJECTED"> <span id="downShelfProductNum2"> 三月畅销商品&nbsp;</span> </a> </li> 
           <li id="ORDER_CANCELLED"> <a href="/portal/control/user_myorder?statusId=ORDER_CANCELLED"> <span id="downShelfProductNum2"> 一年畅销商品&nbsp;</span> </a> </li>
          </ul> 
          <div class="propbox tipstion"> 
          </div> 
         </div> 
         <div class="">
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         </div> 
         <div class="page-content" style="border:1px solid #ccc;margin:15px; margin-top:5px;"> 
          <div class="page-content-area"> 
           <div class="page-header" style="padding-bottom:5px;"> 
            <h1 style="padding-top:15px; font-size:18px;">畅销商品列表</h1> 
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
                 <td><a class="sort-order" href="">商品名</a></td> 
                 <td><a class="sort-order" href="">销售量</a></td> 
                 <td><a class="sort-order" href="">上架日期</a></td> 
                 <td><a class="sort-order" href="">库存状态</a></td> 
                 <td><a class="sort-order" href="">剩余商品数量</a></td> 
                 <td><a class="sort-order" href="">操作</a></td> 
                </tr> 
                <tr> 
                 <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10040">WSCO10040</a></td> 
                 <td class="hidden-480">12134</td> 
                 <td>2014-10-20 19:35:02.0</td> 
                 <td>有货</td> 
                 <td class="hidden-480">323</td> 
                 <td> 
                  <div class="hidden-sm hidden-xs action-buttons"> 
                   <a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10040"> 查看 </a>  
                  </div> </td> 
                </tr> 
                <tr> 
                 <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10060">WSCO10060</a></td> 
                 <td class="hidden-480">33423</td> 
                 <td>2014-10-20 20:25:40.0</td> 
                 <td>有货</td> 
                 <td class="hidden-480">3434</td> 
                 <td> 
                  <div class="hidden-sm hidden-xs action-buttons"> 
                   <a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10060"> 查看 </a>
                  </div> </td> 
                </tr> 
                <tr> 
                 <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
                 <td><a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10070">WSCO10070</a></td> 
                 <td class="hidden-480">6545</td> 
                 <td>2014-10-20 20:28:41.0</td> 
                 <td>有货</td> 
                 <td class="hidden-480">7667</td> 
                 <td> 
                  <div class="hidden-sm hidden-xs action-buttons"> 
                   <a class="blue" href="/portal/control/user_myorderdetails?orderId=WSCO10070"> 查看 </a>
                  </div> </td> 
                </tr> 
               </tbody> 
              </table> 
              <div id="Pagination" class="flickr"></div> 
             </div> 
            </div> 
           </div> 
          </div> 
          <!-- /.page-content-area --> 
         </div>