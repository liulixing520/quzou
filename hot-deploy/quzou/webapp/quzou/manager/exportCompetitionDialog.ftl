<form name="formFp" id="formFp" action="" method="post">
<div class="moneyAllotContent">
	<div class="moneyAllot_title"><a class="ri" href="javascript:"><img id="cm_closeMsg_cancel" src="../images/images/Images/close_icon.gif"></a>选择日期</div>
    <div class="member_table table">
            <input type="hidden" name="cId" id="cId"  value="${parameters.cId!}"/>
    		<ul class="employee_info">
                <li>
                    <label class="title">赛事名称：</label>${(competition.cName)!}
                </li>
                <li>
                    <label class="title">起始日期：</label>
                    <input class="kingkong-input" style="width:100px;" id="startDate" type="text" readonly name="startDate" value="${(competition.startDate)!}" />
                    	至
                    <input class="kingkong-input" style="width:100px;" id="endDate" type="text" readonly name="endDate" value="${(competition.endDate)!}" />
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
		 	var startDate = $("#startDate").val();
		 	var endDate = $("#endDate").val();
			window.location.href="exportCompetition?cId=${parameters.cId!}&startDate="+startDate+"&endDate="+endDate; 
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
				}
			},
			messages:{
				"startDate":{
					required:"请输入起始日期"
				},
				"endDate":{
					required:"请输入结束日期"
				}
			}
		});

	});
</script>