<div class="wrap">
    <div id="employee" style="min-height: 500px;">
        <form action="createUserSecurityGroup" name="MyForm" id="MyForm" method="post">
        <div class="employee_block">
            <h3>分配权限<em></em></h3>
            <ul class="employee_info">
                <li>
                    <label class="title">权限：</label>
                    <select name="groupId" class="kingkong-input shop " style="width: 322px;height: 37px;" >
					<#assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"SEC_GRP_TYPE" }, ["-sequenceId"])?if_exists>
					<#if enums?has_content><#list enums as enum> 
	     				<option<#if entity?? && entity.groupId == enum.enumId> selected</#if> value="${enum.enumId}">${enum.description}</option>
					</#list></#if>
		        </select>
                </li>
                <li>
                    <label class="title">人员：</label>
                    <input class="inp-text kingkong-input name selectTransferPut" id="customerName" type="text" name="customerName" value="${(entity.userLoginId)!}"/>
                    <input type="hidden" name="userLoginId" id="userLoginId" value="${(entity.userLoginId)!}">
	                 <#if customerList?has_content>
				        <ul class="transferAccountsSelect" id="transferAccountsSelect" style="display: none;max-height:500px;height: 119px;top: 82px;left: 119px;">
				          <#list customerList as item>
				            <li title="${(item.userLoginId)!}"  alt="${(item.userLoginId)!}" style="margin-top: 0px;">
				              <div class="transfer_name">${(item.userLoginId)!}
				              </div>
				            </li>
				          </#list>
				        </ul>
				      </#if>
                </li>
            </ul>
           <div class="gestores_list" style="float: left;margin: 20px 0 0 50px;">
                <a class="submit" href="javascript:" onclick="history.go(-1)" >返回</a>
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
				"customerName":{		
					required:true//表示必填，如果有的地方不是必须让用户填写的，可以不加这个规则。
				}
			},
			messages:{
				"customerName":{
					required:"请选择一个人员"
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
        });
    }

</script>
<script type="text/javascript">

function checkUserName(){
	var isOk = false;

 	var partyId =$("#userLoginId").val();
 	
 	if(!partyId){
        $("#customerName").siblings(".error").text("请选择系统内部人员!");		
        $("#customerName").siblings(".error").show();		
 	}else{
 		isOk=true;
 	}
   return isOk;
}

function checkAndSubmit(){
		$("#customerName").siblings(".error").text("");
		if(!checkUserName()){
    		return false;
    	}
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
        $("#customerName").val($(this).attr("title"));
        $("#userLoginId").val($(this).attr("title"));
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

    $("#customerName").on("keyup",function(){
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
