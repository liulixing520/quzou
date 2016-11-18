<form name="formFp" id="formFp" action="createQzCustomerLog" method="post">
<div class="moneyAllotContent">
	<div class="moneyAllot_title"><a class="ri" href="javascript:"><img id="cm_closeMsg_cancel" src="../images/images/Images/close_icon.gif"></a>补录数据</div>
    <div class="member_table table">
            <input type="hidden" name="cardId" id="cardId"  value="${parameters.cardId!}"/>
            <input type="hidden" name="customerId" id="customerId"  value="${parameters.customerId!}"/>
    		<ul class="employee_info">
                <li>
                    <label class="title">起始日期：</label>
                    <input class="kingkong-input" style="width:100px;" id="startDate" type="text" readonly name="startDate" value="${(entity.stepDate)!}" />
                    	至
                    <input class="kingkong-input" style="width:100px;" id="endDate" type="text" readonly name="endDate" value="${(entity.endDate)!}" />
                </li>
                <li>
                    <label class="title">最低步数：</label>
                    <input class="kingkong-input" id="stepNumber" type="text" name="stepNumber" value="${(entity.stepNumber)!}" />
                </li>
                <li>
                    <label class="title">每次增加步数：</label>
                    <input class="kingkong-input" id="stepAvg" type="text" name="stepAvg" value="${(entity.stepAvg)!}" />
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
        }).get(0).onclick = null;
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
				},
				"stepAvg":{		
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
					required:"请输入最低步数"
				},
				"stepAvg":{
					required:"请输入每次增加步数"
				}
			}
		});

	});
</script>