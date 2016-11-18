	 <!-- Begin Template component://portal/webapp/portal/seller/transactions/myorder.ftl --> 
     <script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script> 
     <script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script> 
     <script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script> 
     <script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script> 
     <link rel="stylesheet" type="text/css" href="../seller/css/javascript.css" /> 
     <style type="text/css">
		.nav-tabs li{list-style:none;}
		.nav-tabs li.current a{background:#b3d9ff; color:#000; font-weight:bold;}
	 </style> 
     <script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>交易</li><li class='active'>客户咨询</li>")
		startId=$("#orderStatus").val();
		$("li").remove(".current");
		if(startId==""){
			$("#li1").attr("class", "current"); 
		}else{
			$("#"+startId).attr("class", "current");
		}
	}); 
  </script> 
     <div class="rtab-warp" id="newGuideTarget2" style="padding-left:15px; padding-top:5px;"> 
      <ul class="nav-tabs" style="padding-top:10px; padding-bottom:20px; border:none;"> 
       <li id="li1"> <a href="#"> <span id="shelfProductNum"> 全部&nbsp; </span> </a> </li> 
       <li id="ORDER_CREATED"> <a href="#"> <span id="shelfProductNum"> 最新&nbsp; </span> </a> </li> 
       <li id="ORDER_PROCESSING"> <a href="#"> <span id="auditProductNum"> 未答复 &nbsp;</span> </a> </li> 
       <li id="ORDER_APPROVED"> <a href="#"> <span id="auditFailProductNum"> 已答复 &nbsp;</span> </a> </li>  
      </ul> 
      <div class="propbox tipstion"> 
      </div> 
     </div> 
     <div class="">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
     </div> 
     <div class="page-content" style="border:1px solid #ccc; margin:15px; margin-top:5px;"> 
      <div class="screenlet-title-bar" style="font-size:14px; color:#555; font-weight:bold;">
       搜索选项
       <br class="clear" />
      </div> 
      <div style="padding-top:15px;"> 
       <form class="basic-form"> 
        <label>起始时间：</label> 
        <span class="view-calendar"> <input id="start_order_time" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="minDate" maxlength="30" size="25" type="text" value="" /> </span> 
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
        <span class="view-calendar"> <input id="end_order_time" title="格式: yyyy-MM-dd HH:mm:ss.SSS" name="maxDate" maxlength="30" size="25" type="text" value="" /> </span> 
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
        <input type="hidden" id="orderStatus" name="statusId" value="" /> 
        <input type="submit" value="查询" /> 
       </form> 
      </div> 
      <div class="page-content-area"> 
       <div class="page-header" style="padding-bottom:5px;"> 
        <h1 style="padding-top:15px; font-size:18px;">客户咨询内容列表</h1> 
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
             <td> <label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
             <td> <a class="sort-order" href="">日期</a> </td> 
             <td> <a class="sort-order" href="">客户名</a> </td> 
             <td> <a class="sort-order" href="">客户类型</a> </td> 
             <td> <a class="sort-order" href="">内容</a> </td> 
             <td> <a class="sort-order" href="">操作</a> </td> 
            </tr> 
            <tr> 
             <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
             <td>2014-11-26 18:06:44.0</td> 
             <td>张三</td> 
             <td class="hidden-480">VIP</td> 
             <td>已批准，发大水开发聚少离多飞说减肥类军绿色惊动了覅额说减肥类...</td> 

             <td> <a class="blue" href="/portal/control/reviewDetail"> 查看与操作</a></td> 
            </tr> 
            <tr> 
             <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
             <td>2014-11-24 21:46:47.0</td> 
             <td>李四</td> 
             <td class="hidden-480">VIP</td> 
             <td>已批准，发大水力法加点善良劫匪但神经分裂束带结发</td> 
    
             <td> <a class="blue" href="/portal/control/reviewDetail"> 查看与操作 </a></td> 
            </tr> 
            <tr> 
             <td class="center"><label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
             <td>2014-11-19 17:26:34.0</td> 
             <td>王五</td> 
             <td class="hidden-480">普通</td> 
             <td>已批准，为什么，没说分路口水电费地方</td> 
             <td> <a class="blue" href="/portal/control/reviewDetail"> 查看与操作 </a></td> 
            </tr> 
           </tbody> 
          </table> 
         </div> 
        </div> 
       </div> 
      </div> 
     </div>
    </div>
  