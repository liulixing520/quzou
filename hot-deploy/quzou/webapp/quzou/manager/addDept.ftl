<div class="wrap">
    <div id="employee">
        <form action="createCompanyAndDept" name="MyForm" id="MyForm" method="post">
        <div class="employee_block">
        	<h3>团队信息<em></em></h3>
            <ul class="employee_info">
                <li>
                    <label class="title">团队：</label>
                    <input class="inp-text kingkong-input name" id="deptName" name="deptName" type="text" name="userLoginId" value="${(dept.deptName)!}" />
                </li>
                <li>
                    <label class="title">单位：</label>
                    <input class="inp-text kingkong-input name selectTransferPut" id="companyName" type="text" name="companyName" value="${(dept.companyName)!}"/>
	                    <#if companyList?has_content>
				        <ul class="transferAccountsSelect" id="transferAccountsSelect" style="display: none;max-height:110px;top:82px;">
				          <#list companyList as item>
				            <li title="${(item.companyName)!}" alt="${(item.companyId)!}" style="margin-top: 0px;">
				              <div class="transfer_name">${(item.companyName)!}
				              </div>
				            </li>
				          </#list>
				        </ul>
				      </#if>
                </li>
            </ul>
           <div class="gestores_list" style="float: left;margin: 20px 0 0 120px;">
                <a action="submit" class="submit tj" href="javascript:void(0)" >提交</a>
            </div>
        </div>
        </form>
    </div>
</div>

<script type="text/javascript" src="../images/js/public.js"></script>
<!--弹窗start -->
<script type="text/javascript" src="../images/js/jquery.cm_dialog.js"></script>
<script src="../images/js/std.min.js"></script>

<!--表单验证-->
<script type="text/javascript">

	$(document).ready(function(){
		$("#MyForm").validate({
			errorElement : "span",
			onfocusout : false,
			rules:{
				"deptName":{		
					required:true
				},
				"companyName":{
					required:true
				}
			},
			messages:{
				"deptName":{
					required:"请输入部门名称"
				},
				"companyName":{
					required:"请输入单位名称"
				}
			}
		});

	});

	$(".tj").click(function(){
		 if($("#MyForm").valid()){
		     checkAndSubmit();
		 }else{
		 	return false;
		 }
	});

</script>
<script type="text/javascript">
    function disabledSubmitButton(){
        $(document.createElement("div")).css({
            top:0,
            left:0,
            width:$(document).width(),
            height:$(document).height(),
            position:"absolute",
            opacity:0.3,
            background:"white",
            zIndex:9999,
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

</script>
<script type="text/javascript">

function checkAndSubmit(){
        disabledSubmitButton();
    	document.MyForm.submit();

}

 $(function(){
    $(".employee_info .selectTransferPut").focus(function(){
      $(this).siblings("ul").slideDown();
      $("#isMyself").removeAttr("checked");
    }).click(function(){
      return false;
    });


    $(document).click(function(){
      $(".transferAccountsSelect").slideUp();
    });

    $(".transferAccountsSelect").click(function(){
      return false;
    });
  });

 $(function(){
      $("#transferAccountsSelect").on('click','li',function(){
        $("#companyName").val($(this).attr("title"));
        $(".transferAccountsSelect").hide();
      });
  });
</script>
<script>
  /*
   * 公司下拉列表
  */
  $(function(){
    var transferAccountsSelect     = $("#transferAccountsSelect");
    var transferAccountsSelectData = transferAccountsSelect.clone();

    $("#companyName").on("keyup",function(){
      var value = $.trim($(this).val());

      //----如果值为空,那么写入全部
      if(value.length === 0){
        transferAccountsSelect.html(transferAccountsSelectData.html());
      }
      //----如果值不为空
      else{
        //清空html
        transferAccountsSelect.html("");

        //枚举,找到匹配的li并且克隆之后追加到列表中
        $("li > div.transfer_name",transferAccountsSelectData).each(function(){
          var name = $(this).text();
          var tel = $(this).siblings('div.transfer_tel').text();
          if(name.indexOf(value) !== -1 || tel.indexOf(value) !== -1){
            transferAccountsSelect.append($(this).parent().clone());
          }
        });
      }
    });
  });
</script>
