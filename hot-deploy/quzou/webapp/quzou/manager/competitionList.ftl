<style>
	.tingyong td{
		background:#D3D3D3;
	}
</style>
<div class="main">
	<div class="com_sea_bigbox">
	    <form name="competitionForm" id="searchCustomer" action="<@ofbizUrl>competitionList</@ofbizUrl>">
	    
	    <div class="filter_stock">
			<div class="filter_info">
			    <div class="fl">
			    	<label class="ff_label" style="margin-left:36px;">名称：</label>
			    	<input type="hidden" name="cName_op"  value="contains" />
			    	<input type="text" class="inp-text" name="cName" id="cName" value="${parameters.cName!}" />
			    	<label class="ff_label ml30">状态：</label>
			    	<select class="kingkong-input" id="status" name="status">
		                <option value=""> </option>
				    	<#assign enumerations = delegator.findByAnd("Enumeration", Static["org.ofbiz.base.util.UtilMisc"].toMap("enumTypeId", "compeStatus"), null, false)>
		                <#list enumerations as enumeration>
		                  <option <#if "${enumeration.enumCode}" == "${parameters.status!}">selected="selected"</#if> value="${enumeration.enumCode}">${enumeration.description}</option>
		                </#list>
		            </select>
			    	<label class="ff_label ml30">首页展示：</label>
			    	<select class="kingkong-input" id="isShow" name="isShow">
			    		<option value=""></option>
		                <option value="0" <#if "${(parameters.isShow)!}"=="0">selected="selected"</#if> >不展示</option>
	                	<option value="1" <#if "${(parameters.isShow)!}"=="1">selected="selected"</#if> >展示</option>
		            </select>
			    </div>
			    <div class="fi_search_btn"><a href="javascript:document.competitionForm.submit();" class="btn mm btn-confirm membetSetMarT" style="margin-right:20px;">查询</a>
			    	<a href="javascript:exportCompetitionDialog();" class="btn mm btn-confirm membetSetMarT">导出</a></div>
			</div>
		</div>
	   </form>
	</div>

	<div class="clear"></div>
	<div class="wrap2 member_table table pb20">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="nursing">
	        <tr>
	            <th width="3%" class="td_checked"><input type="checkbox" class="checkAll" data-name="1"/></th>
	            <th width="25%">封面图片</th>
	            <th width="36%">赛事名称</th>
	            <th width="16%">简短描述</th>
	            <#--
	            <th width="16%">开始日期</th>
	            <th width="16%">结束日期</th>
	            <th width="16%">上传截止日期</th>
	            <th width="10%">最小步数</th>
	            <th width="10%">最大步数</th>
	            <th width="16%">每百步数系数</th>
	            -->
	            <th width="15%">发布日期</th>
	            <th width="8%">状态</th>
	            <th width="8%">首页展示</th>
	            <th width="15%">操作</th>
	        </tr>
	<#if listIt?has_content>
		<#list listIt as competition>
			<tr>
				<td><input type="checkbox" name="competitionId" value="${competition.cId!}" class="checkItem"  data-name="1"/></td>
				<td><img style="width: 140px;height: 75px;" src="/quzou/upload/${competition.cPic!}"/></td>
				<td>
	            	<a class="name" href="javascript:void(0);" href="addCompetition?cId=${competition.cId!}">${(competition.cName)!}</a>
	            </td>
				<td>${competition.shortDescription!}</td>
				 <#--
				<td>${(competition.startDate?string('yyyy-MM-dd'))!}</td>
				<td>${(competition.endDate?string('yyyy-MM-dd'))!}</td>
				<td>${(competition.uploadEndDate?string('yyyy-MM-dd'))!}</td>
				<td>${competition.minStep!}</td>
				<td>${competition.maxStep!}</td>
				<td>${competition.stepCoefficient!}</td>
				-->
				<td>${(competition.publishDate?string('yyyy-MM-dd'))!}</td>
				<td>
					<#if "${(competition.status)!}"=="0">未开始</#if>
		            <#if "${(competition.status)!}"=="1">进行中</#if>
		            <#if "${(competition.status)!}"=="2">已结束</#if>
		            <#if "${(competition.status)!}"=="3">已取消</#if>
				</td>
				<td>
					<#if "${(competition.isShow)!}"=="0">不展示</#if>
		            <#if "${(competition.isShow)!}"=="1">展示</#if>
				</td>
				<td><a href="addCompetition?cId=${competition.cId!}">编辑</a>
					<a href="javascript:void(0);" onclick="viewCustomer('${competition.cId!}')">查看成员</a>
				</td>
			</tr>
		</#list>
	</#if>
	    </table>

	    <div class="table_control">
	        <div class="t_c_inp">
	            <input type="checkbox" class="checkAll" id="checkAll" data-name="1">
	            <label for="checkAll">全选</label>
	        </div>
	      <#--  <div class="t_c_btn">
	        	<a id="deleteBtn" href="javascript:" class="btn mm btn-default">删除</a>
	        </div>-->
	         <div class="t_c_btn">
	        	<a id="qiyongBtn" href="javascript:" onclick="setEnabledMember('1')" class="btn mm btn-default">启用</a>
	        </div>
	         <div class="t_c_btn">
	        	<a id="zantingBtn" href="javascript:" onclick="setEnabledMember('2')" class="btn mm btn-default">停用</a>
	        </div>
	         <div class="t_c_btn">
	        	<a id="qiyongBtn" href="javascript:" onclick="setShowMember('1')" class="btn mm btn-default">展示</a>
	        </div>
	         <div class="t_c_btn">
	        	<a id="zantingBtn" href="javascript:" onclick="setShowMember('0')" class="btn mm btn-default">不展示</a>
	        </div>
	    </div>


	<#assign url="competitionList?1=1"/>
	<#if parameters.cName?has_content>
		<#assign url=url+"&cName=${(parameters.cName)!}"/>
	</#if>
	<#if parameters.status?has_content>
		<#assign url=url+"&status=${(parameters.status)!}"/>
	</#if>
	<#if parameters.isShow?has_content>
		<#assign url=url+"&isShow=${(parameters.isShow)!}"/>
	</#if>
	<#assign url=url?replace("competitionList","")/>
	<#import "component://quzou/webapp/quzou/includes/htmlFtlMacroLibrary.ftl" as p>
			  <@p.showPage requestUrl1="competitionList"
			  requestUrl2=url
			  listSize=listSize viewSize=viewSize viewIndex=viewIndex isAuth=true/>
	</div>
</div>
<!--弹窗start -->
<script type="text/javascript" src="../images/js/jquery.cm_dialog.js"></script>

<script type="text/javascript">
    function exportCompetitionDialog(){
    	var cids = $("input[name='competitionId']:checked").length;
		if(cids==0){
			alert("请选择一项赛事");
		}else if(cids>1){
			alert("只能选择一项赛事");
		}
		var ids=$("input[name='competitionId']:checked").map(function() { return this.value; }).get().join();
        $(this).cm_dialog({
            url: "exportCompetitionDialog?cId="+ids,
            width: '810px',
        });
		
    };
</script>
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
		var c ="";
		if(a=='1'){
			c="确定启用选中的赛事？"
		}else{
			c="确定停用选中的赛事？"
		}
		if(confirm(c)) {
			var ids=$("input[name='competitionId']:checked").map(function() { return this.value; }).get().join();
			$.ajax({
			  type: 'POST',
			  url: 'ajaxUpdateCompetition',
			  data: {ids:ids,status:a},
			  success: function(data) {
			   location.reload();
			  }
			});
		}
	}
	function setShowMember(a){
		var c ="";
		if(a=='1'){
			c="确定在首页展示选中的赛事？"
		}else{
			c="确定不在首页展示选中的赛事？"
		}
		if(confirm(c)) {
			var ids=$("input[name='competitionId']:checked").map(function() { return this.value; }).get().join();
			$.ajax({
			  type: 'POST',
			  url: 'ajaxUpdateCompetition',
			  data: {ids:ids,isShow:a},
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
	function viewCustomer(cId){
		window.location.href="viewCustomers?cId="+cId;
	}
</script>
