<form name="formFp" id="formFp" action="updateQzCustomerLog" method="post">
<div class="moneyAllotContent">
	<div class="moneyAllot_title"><a class="ri" href="javascript:"><img id="cm_closeMsg_cancel" src="../images/images/Images/close_icon.gif"></a>修改日志</div>
    <div class="member_table table">
            <input type="hidden" name="logId" id="logId"  value="${entity.logId!}"/>
    		<ul class="employee_info">
                <li>
                    <label class="title">计步器号：</label>${(entity.logId)!}
                </li>
                <li>
                    <label class="title">计步日期：</label>${(entity.stepDate)!}
                </li>
                <li>
                    <label class="title">步数：</label>
                    <input class="kingkong-input" id="stepNumber" type="text" name="stepNumber" value="${(entity.stepNumber)!}" />
                </li>
            </ul>
    </div>
    
    <div class="fr mt20 mb20">
    	<div class="com_btn fl mr20"><a href="javascript:" class="popClose">取消</a></div>
    	<div class="com_btn com_btn_red fl mr20"><a class="tj" href="javascript:" >确定</a></div>
    </div>
</div>
</form>
<script type="text/javascript" src="../images/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript">
  $(function(){

      $('#endDate').daterangepicker({
        startDate: '2014-01-01',
        timePicker: true,
        timePickerIncrement: 1,
        format: 'YYYY-MM-DD',
        singleDatePicker: true,
        showDropdowns:true
      });
      $('#startDate').daterangepicker({
        startDate: '2014-01-01',
        timePicker: true,
        timePickerIncrement: 1,
        format: 'YYYY-MM-DD',
        singleDatePicker: true,
        showDropdowns:true
      });
  });
  
	$(".tj").click(function(){
		 if($("#formFp").valid()){
	        disabledSubmitButton();
			document.formFp.submit();
		 }else{
		 	return false;
		 }
	});
	
  function disabledSubmitButton(){
        $(document.createElement("div")).css({
            top:0,
            left:0,
            width:$(document).width(),
            height:$(document).height(),
            position:"absolute",
            opacity:0.3,
            background:"white",
            zIndex:113000,
            cursor:"not-allowed"
        }).appendTo("body");

        $(document).on("keydown",function(e){
            if(e.keyCode === 8){
                return false;
            }
        });

        $("[action='submit']").addClass("disabled").mousedown(function(){
            return false;
        }).css({
            color:"white",
            background:"#7D7D7D",
            borderColor:"transparent"
        });
    }
    
  $(document).ready(function(){
		$("#formFp").validate({
			errorElement : "span",
			onfocusout : false,
			rules:{
				"startDate":{		
					required:true
				},
				"endDate":{		
					required:true
				},
				"stepNumber":{		
					required:true
				}
			},
			messages:{
				"startDate":{
					required:"请输入起始日期"
				},
				"endDate":{
					required:"请输入结束日期"
				},
				"stepNumber":{
					required:"请输入步数"
				}
			}
		});

	});
</script>