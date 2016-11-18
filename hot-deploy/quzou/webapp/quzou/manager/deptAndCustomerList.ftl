<style>
	.tingyong td{
		background:#D3D3D3;
	}
</style>
<div class="main">
	<!--面包屑-->
	<div class="crumb">
    	<ul>
        	<li>
            	部门名称：
            </li>
            <li>
            	<a href="deptAndCustomerList?deptId=${parameters.deptId!}">${(entity.deptName)!}</a>
            </li>
        </ul>
    </div>
	<div class="com_sea_bigbox">
	    <form name="customerForm" id="searchCustomer" action="<@ofbizUrl>deptAndCustomerList</@ofbizUrl>">
	    <div class="filter_stock">
			<div class="filter_info">
			    <div class="fl">
			    	<input type="hidden" name="deptId"  value="${parameters.deptId!}" />
			    	<label class="ff_label ml30">计步器号：</label>
			    	<input type="hidden" name="cardId_op"  value="contains" />
			    	<input type="text" class="inp-text ff_calendar" name="cardId" id="cardId" value="${parameters.cardId!}" />
			    	<label class="ff_label" style="margin-left:36px;">姓名：</label>
			    	<input type="hidden" name="userLoginId_op"  value="contains" />
			    	<input type="text" class="inp-text" name="userLoginId" id="userLoginId" value="${parameters.userLoginId!}" />
			    </div>
			    <div class="fi_search_btn"><a href="javascript:document.customerForm.submit();" class="btn mm btn-confirm membetSetMarT" style="margin-right:20px;">查询</a>
			     <a href="javascript:void(0);" class="btn mm btn-confirm membetSetMarT" onclick="addDeptCustomerDialog()">添加</a>
			    </div>
			    
			</div>
		</div>
	   </form>
	</div>

	<div class="clear"></div>
	<div class="wrap2 member_table table pb20">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="nursing">
	        <tr>
	            <th width="3%" class="td_checked"><input type="checkbox" class="checkAll" data-name="1"/></th>
	            <th width="20%">计步器号</th>
	            <th width="20%">姓名</th>
	        </tr>
	<#if listIt?has_content>
		<#list listIt as item>
			<tr>
				<td><input type="checkbox" name="customerId" value="${item.customerId!}" class="checkItem"  data-name="1"/></td>
				<td>${item.cardId!}</td>
				<td>${item.userLoginId!}</td>
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
	        	<a id="zantingBtn" href="javascript:" onclick="deleteFromDept()" class="btn mm btn-default">删除</a>
	        </div>
	    </div>


	<#assign url="deptAndCustomerList?1=1"/>
	<#if parameters.deptId?has_content>
		<#assign url=url+"&deptId=${(parameters.deptId)!}"/>
	</#if>
	<#if parameters.cardId?has_content>
		<#assign url=url+"&cardId=${(parameters.cardId)!}&cardId_op=contains"/>
	</#if>
	<#if parameters.userLoginId?has_content>
		<#assign url=url+"&userLoginId=${(parameters.userLoginId)!}&userLoginId_op=contains"/>
	</#if>
	<#assign url=url?replace("deptAndCustomerList","")/>
	<#import "component://quzou/webapp/quzou/includes/htmlFtlMacroLibrary.ftl" as p>
			  <@p.showPage requestUrl1="deptAndCustomerList"
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
	function deleteFromDept(a){
		var deptId = '${parameters.deptId!}';
		var c ="确定删除选中的数据？";
		if(confirm(c)) {
			var ids=$("input[name='customerId']:checked").map(function() { return this.value; }).get().join();
			$.ajax({
			  type: 'POST',
			  url: 'deleteFromDept',
			  data: {customerIds:ids,deptId:deptId},
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

</script>
<script type="text/javascript">
    function addDeptCustomerDialog(){
           window.location.href="addDeptCustomerDialog?deptId=${(parameters.deptId)!}";
    };
</script>