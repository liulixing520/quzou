<style>
	.tingyong td{
		background:#D3D3D3;
	}
</style>
<div class="main">
	<div class="com_sea_bigbox">
	    <form name="customerForm" id="searchCustomer" action="<@ofbizUrl>companyAndDeptList</@ofbizUrl>">
	    
	    <div class="filter_stock">
			<div class="filter_info">
			    <div class="fl">
			    	<label class="ff_label" style="margin-left:36px;">团队：</label>
			    	<input type="hidden" name="deptName_op"  value="contains" />
			    	<input type="text" class="inp-text" name="deptName" id="deptName" value="${parameters.deptName!}" />
			    	<label class="ff_label" style="margin-left:36px;">单位：</label>
			    	<input type="hidden" name="companyName_op"  value="contains" />
			    	<input type="text" class="inp-text selectTransferPut" name="companyName" id="companyName" value="${parameters.companyName!}" />
			    	<#if companyList?has_content>
				        <ul class="transferAccountsSelect" id="transferAccountsSelect" style="display: none;max-height:300px;top:35px;left:316px;">
				          <#list companyList as item>
				            <li title="${(item.companyName)!}" alt="${(item.companyId)!}" style="margin-top: 0px;">
				              <div class="transfer_name">${(item.companyName)!}
				              </div>
				            </li>
				          </#list>
				        </ul>
				      </#if>
			    </div>
			    <div class="fi_search_btn"><a href="javascript:document.customerForm.submit();" class="btn mm btn-confirm membetSetMarT" style="margin-right:20px;">查询</a>
			    <a href="javascript:void(0);" class="btn mm btn-confirm membetSetMarT" onclick="uploadTeam()">导入</a></div>
			    
			</div>
		</div>
	   </form>
	</div>

	<div class="clear"></div>
	<div class="wrap2 member_table table pb20">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="nursing">
	        <tr>
	            <th width="3%" class="td_checked"><input type="checkbox" class="checkAll" data-name="1"/></th>
	            <th width="26%">团队</th>
	            <th width="50%">单位</th>
	        </tr>
	<#if listIt?has_content>
		<#list listIt as item>
			<tr>
				<td><input type="checkbox" name="deptId" value="${item.deptId!}" class="checkItem"  data-name="1"/></td>
				<td><a href="deptAndCustomerList?deptId=${item.deptId!}" >${item.deptName!}</a></td>
				<td>${item.companyName!}</td>
			</tr>
		</#list>
	</#if>
	    </table>

	    <div class="table_control">
	        <div class="t_c_inp">
	            <input type="checkbox" class="checkAll" id="checkAll" data-name="1">
	            <label for="checkAll">全选</label>
	        </div>
	        <div class="t_c_btn">
	        	<a id="qiyongBtn" href="javascript:" onclick="setEnabledMember()" class="btn mm btn-default">删除</a>
	        </div>
	    </div>


	<#assign url="companyAndDeptList?1=1"/>
	<#if parameters.deptName?has_content>
		<#assign url=url+"&deptName=${(parameters.deptName)!}"/>
	</#if>
	<#if parameters.companyName?has_content>
		<#assign url=url+"&companyName=${(parameters.companyName)!}"/>
	</#if>
	<#assign url=url?replace("companyAndDeptList","")/>
	<#import "component://quzou/webapp/quzou/includes/htmlFtlMacroLibrary.ftl" as p>
			  <@p.showPage requestUrl1="companyAndDeptList"
			  requestUrl2=url
			  listSize=listSize viewSize=viewSize viewIndex=viewIndex isAuth=true/>
	</div>
</div>
<script type="text/javascript" src="../images/js/jquery.cm_dialog.js"></script>

<script type="text/javascript">
	$(function(){
		$('#birthDate').daterangepicker({
			timePicker: false,
			timePickerIncrement: 1,
			format: 'YYYY-MM-DD',
			singleDatePicker: true,
			showDropdowns:true
		});

	<#--	$("#deleteBtn").click(function() {
	 		var checkedNum = $("input[name='baseId']:checked").length;
			if(checkedNum == 0) {
				alert("请选择至少一个会员！");
				return;
			}
			if(confirm("确定删除选中会员?")) {
				var ids=$("input[name='baseId']:checked").map(function() { return this.value; }).get().join();
				$.ajax({
				  type: 'POST',
				  url: 'setYuemeiPartysStatus',
				  data: {partyIds:ids,partyStatusId:"PARTY_DISABLED"},
				  success: function(data) {
				  }
				});
			}
		});
		-->
	});
	function setEnabledMember(a){
		var c ="确定删除选中的团队？";
		if(confirm(c)) {
			var ids=$("input[name='deptId']:checked").map(function() { return this.value; }).get().join();
			$.ajax({
			  type: 'POST',
			  url: 'deletCompanyAndDept',
			  data: {deptIds:ids},
			  success: function(data) {
			   location.reload();
			  }
			});
		}
	}
	<#--上传数据-->
	function uploadTeam(){
		 var option = {
	        url: "uploadDialog?inType=team",
	        width: '410px'
	      };
		$(this).cm_dialog(option);
	}

	var zhuandianAjax = function(){
		var b = $(".alert-window .zd-zhuanr-select option:selected").val();
		var a = $("#zd-name").attr("v");
		$.ajax({
		  type: 'POST',
		  url: 'setPartyProductStore',
		  data: {partyId:a,productStoreId:b},
		  success: function(data) {
		  	 alert("转店成功！");
		  	 location.reload();
		  },
		  error: function(e) {
			alert(e);
		  }
		});
		return false;
	}
</script>
<script>
 $(function(){
    $(".selectTransferPut").focus(function(){
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
