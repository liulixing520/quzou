<style>
	.tingyong td{
		background:#D3D3D3;
	}
</style>
<div class="main">
	<div class="com_sea_bigbox">
	    <form name="customerForm" id="searchCustomer" action="<@ofbizUrl>customerLogList</@ofbizUrl>">
	    
	    <div class="filter_stock">
			<div class="filter_info">
			    <div class="fl">
			    	<label class="ff_label" style="margin-left:36px;">计步器号：</label>
			    	<input type="hidden" name="cardId_op" id="cardId_op"  value="contains" />
			    	<input type="text" class="inp-text" style="width:80px;" name="cardId" id="cardId" value="${(parameters.cardId)!}" />
			    	<label class="ff_label" style="margin-left:36px;">姓名：</label>
			    	<input type="hidden" name="userLoginId_op" id="userLoginId_op" value="contains" />
			    	<input type="text" class="inp-text" style="width:80px;" name="userLoginId" id="userLoginId" value="${(parameters.userLoginId)!}" />
			    	<!--<label class="ff_label" style="margin-left:36px;">单位名称：</label>
			    	<input type="hidden" name="companyName_op"  value="contains" />
			    	<input type="text" class="inp-text selectTransferPut"  name="companyName" id="companyName" value="${(parameters.companyName)!}" />
			    	  <#if companyList?has_content>
				        <ul class="transferAccountsSelect" id="transferAccountsSelect" style="display: none;max-height:300px;top:35px;left:473px;">
				          <#list companyList as item>
				            <li title="${(item.companyName)!}" alt="${(item.companyId)!}" style="margin-top: 0px;">
				              <div class="transfer_name">${(item.companyName)!}
				              </div>
				            </li>
				          </#list>
				        </ul>
				      </#if>
				      -->
				    <label class="ff_label" style="margin-left:36px;">开始时间：</label>
			    	<input type="hidden" name="stepDate_fld0_op" id="stepDate_fld0_op" value="greaterThanFromDayStart" />
			    	<input type="text" class="inp-text" style="width:80px;" name="stepDate_fld0_value" id="startDate" value="${(parameters.stepDate_fld0_value)!}" />
				    <label class="ff_label" style="margin-left:36px;">结束时间：</label>
			    	<input type="hidden" name="stepDate_fld1_op" id="stepDate_fld1_op" value="upThruDay" />
			    	<input type="text" class="inp-text" style="width:80px;" name="stepDate_fld1_value" id="endDate" value="${(parameters.stepDate_fld1_value)!}" />
			    </div>
			    <div class="fi_search_btn">
			    	<a href="javascript:document.customerForm.submit();" class="btn mm btn-confirm membetSetMarT" style="margin-right:20px;">查询</a>
			    	<a href="javascript:void(0);" class="btn mm btn-confirm membetSetMarT" onclick="exportLog()">导出</a>
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
	            <th width="16%">计步器号</th>
	            <th width="16%">姓名</th>
	            <th width="16%">单位名称</th>
	            <th width="16%">步数</th>
	            <th width="16%">计步日期</th>
	            <th width="16%">上传日期</th>
	            <th width="16%">操作</th>
	        </tr>
		<#if listIt?has_content>
			<#list listIt as customer>
				<tr>
					<td><input type="checkbox" name="logId" value="${customer.logId!}" class="checkItem"  data-name="1"/></td>
					<td>${(customer.cardId)!}</td>
					<td>${(customer.userLoginId)!}</td>
					<td>${(customer.companyName)!}</td>
					<td>${(customer.stepNumber)!}</td>
					<td>${(customer.stepDate?string('yyyy-MM-dd'))!}</td>
					<td>${(customer.uploadDate?string('yyyy-MM-dd HH:mm:ss'))!}</td>
					<td><a href="javascript:void(0)" onclick="addCustomerLog('${customer.logId!}')">修改</a></td>
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


	<#assign url="memberHomeList?1=1"/>
	<#if parameters.userLoginId?has_content>
		<#assign url=url+"&userLoginId=${(parameters.userLoginId)!}&userLoginId_op=contains"/>
	</#if>
	<#if parameters.cardId?has_content>
		<#assign url=url+"&cardId=${(parameters.cardId)!}&cardId_op=contains"/>
	</#if>
	<#if parameters.companyName?has_content>
		<#assign url=url+"&companyName=${(parameters.companyName)!}&companyName_op=contains"/>
	</#if>
	<#assign url=url?replace("memberHomeList","")/>
	<#import "component://quzou/webapp/quzou/includes/htmlFtlMacroLibrary.ftl" as p>
			  <@p.showPage requestUrl1="customerLogList"
			  requestUrl2=url
			  listSize=listSize viewSize=viewSize viewIndex=viewIndex isAuth=true/>
	</div>
</div>
<script type="text/javascript" src="../images/js/jquery.cm_dialog.js"></script>

<div style="display:none;" id="zhuan">
	<div class="changeStore">
	  <div class="zhuanTitle"><a class="ri" href="javascript:"><img id="cm_closeMsg_cancel" src="../images/images/Images/close_icon.gif"></a>转店操作</div>
	    <div class="changeContent">
		    <div id="zd-name" v="" class="changeName">姓名：</div>
			<div id="zd-zhuanc" class="changeName">转出门店：</div>
			<div class="changeName">
				<span>转入门店：</span>
				<select  class="zd-zhuanr-select">
					<#if storeList?has_content>
						<#list storeList as item>
							<option value="${item.productStoreId}">${item.storeName}</option>
						</#list>
					</#if>
				</select>
			</div>
	    </div>
	     <div class="fr mt20">
	          <div class="com_btn com_btn_red fl mr20" style="border: 1px solid transparent">
				<a onclick="zhuandianAjax()" href="javascript:void(0)">确定</a>
			  </div>
			  <div class="com_btn com_btn_red fl mr20" style="border: 1px solid transparent">
				<a class="close" href="javascript:void(0)">取消</a>
			  </div>
	     </div>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		$('#startDate').daterangepicker({
			timePicker: false,
			timePickerIncrement: 1,
			format: 'YYYY-MM-DD',
			singleDatePicker: true,
			showDropdowns:true
		});
		$('#endDate').daterangepicker({
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
		var c ="确定删除选中的数据？";
		if(confirm(c)) {
			var ids=$("input[name='logId']:checked").map(function() { return this.value; }).get().join();
			$.ajax({
			  type: 'POST',
			  url: 'deletCustomerLog',
			  data: {ids:ids},
			  success: function(data) {
			   location.reload();
			  }
			});
		}
	}
	<#--a转出门店名称，b转出会员名称，c转出会员Id-->
	function zhuandian(a,b,c){
		$("#zd-zhuanc").html('转出门店：'+a);
		$("#zd-name").html('姓名：'+b);
		$("#zd-name").attr("v",c)
		<#--会员转店操作-->
		var option = {
			html: $("#zhuan").html(),
			width: '410px',
			height:'210px'
		};
		$(this).cm_dialog(option);
	}
	<#--ajax转店操作,a会员ID，b转入门店id-->

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
<script type="text/javascript">
    function addCustomerLog(logId){
        $(this).cm_dialog({
            url: "addCustomerLog?logId="+logId,
            width: '810px',
        });
    };
    function exportLog(){
    
	    var cardId = $("#cardId").val();
	    var userLoginId = $("#userLoginId").val();
	    var startDate = $("#startDate").val();
	    var endDate = $("#endDate").val();
	    if(startDate=="" || endDate ==""){
	    	alert("请先选择起止日期");
	    	return;
	    }
	    var url = "exportLog?noConditionFind=Y";
	    if(cardId!=""&&cardId!=null&&cardId!=undefined){
	    	url+="&cardId="+cardId;
	    }
	    if(cardId!=""&&cardId!=null&&cardId!=undefined){
	    	url+="&userLoginId="+userLoginId;
	    }
	    if(startDate!=""&&startDate!=null&&startDate!=undefined){
			url+="&startDate="+startDate;
		}
	    if(endDate!=""&&endDate!=null&&endDate!=undefined){
			url+="&endDate="+endDate;
		}
    	window.location.href=url;
    }
</script>