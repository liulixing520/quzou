<style>
	.tingyong td{
		background:#D3D3D3;
	}
</style>
<div class="main">
	<div class="com_sea_bigbox">
	    <form name="competitionForm" id="searchCustomer" action="<@ofbizUrl>talentShowList</@ofbizUrl>">
	    
	    <div class="filter_stock">
			<div class="filter_info">
			    <div class="fl">
			    	<label class="ff_label" style="margin-left:36px;">标题：</label>
			    	<input type="hidden" name="showTitle_op"  value="contains" />
			    	<input type="text" class="inp-text" name="showTitle" id="showTitle" value="${parameters.cName!}" />
			    	<label class="ff_label ml30">首页展示：</label>
			    	<select class="kingkong-input" id="isShow" name="isShow">
			    		<option value=""></option>
		                <option value="0" <#if "${(parameters.isShow)!}"=="0">selected="selected"</#if> >不展示</option>
	                	<option value="1" <#if "${(parameters.isShow)!}"=="1">selected="selected"</#if> >展示</option>
		            </select>
			    </div>
			    <div class="fi_search_btn"><a href="javascript:document.competitionForm.submit();" class="btn mm btn-confirm membetSetMarT">查询</a></div>
			</div>
		</div>
	   </form>
	</div>

	<div class="clear"></div>
	<div class="wrap2 member_table table pb20">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="nursing">
	        <tr>
	            <th width="3%" class="td_checked"><input type="checkbox" class="checkAll" data-name="1"/></th>
	            <th width="20%"></th>
	            <th width="36%">达人秀标题</th>
	            <th width="16%">简短描述</th>
	            <th width="15%">发布日期</th>
	            <th width="15%">首页展示</th>
	            <th width="16%">操作</th>
	        </tr>
	<#if listIt?has_content>
		<#list listIt as item>
			<tr>
				<td><input type="checkbox" name="showId" value="${item.showId!}" class="checkItem"  data-name="1"/></td>
				<td><img style="width: 140px;height: 75px;" src="/quzou/upload/${item.showPic!}"/></td>
				<td>${item.showTitle!}</td>
				<td>${item.description!}</td>
				<td>${(item.publishDate?string('yyyy-MM-dd'))!}</td>
				<td>
					<#if "${(item.isShow)!}"=="0">不展示</#if>
		            <#if "${(item.isShow)!}"=="1">展示</#if>
				</td>
				<td><a href="addTalentShow?showId=${item.showId!}">编辑</a></td>
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
	        </div>
	         <div class="t_c_btn">
	        	<a id="qiyongBtn" href="javascript:" onclick="setEnabledMember('1')" class="btn mm btn-default">启用</a>
	        </div>
	         <div class="t_c_btn">
	        	<a id="zantingBtn" href="javascript:" onclick="setEnabledMember('2')" class="btn mm btn-default">停用</a>
	        </div>
	        -->
	         <div class="t_c_btn">
	        	<a id="qiyongBtn" href="javascript:" onclick="setShowMember('1')" class="btn mm btn-default">展示</a>
	        </div>
	         <div class="t_c_btn">
	        	<a id="zantingBtn" href="javascript:" onclick="setShowMember('0')" class="btn mm btn-default">不展示</a>
	        </div>
	    </div>


	<#assign url="talentShowList?1=1"/>
	<#if parameters.showTitle?has_content>
		<#assign url=url+"&showTitle=${(parameters.showTitle)!}"/>
	</#if>
	<#if parameters.isShow?has_content>
		<#assign url=url+"&isShow=${(parameters.isShow)!}"/>
	</#if>
	<#assign url=url?replace("talentShowList","")/>
	<#import "component://quzou/webapp/quzou/includes/htmlFtlMacroLibrary.ftl" as p>
			  <@p.showPage requestUrl1="talentShowList"
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
		var c ="";
		if(a=='1'){
			c="确定启用选中的达人秀？"
		}else{
			c="确定停用选中的达人秀？"
		}
		if(confirm(c)) {
			var ids=$("input[name='showId']:checked").map(function() { return this.value; }).get().join();
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
			c="确定在首页展示选中的达人秀？"
		}else{
			c="确定不在首页展示选中的达人秀？"
		}
		if(confirm(c)) {
			var ids=$("input[name='showId']:checked").map(function() { return this.value; }).get().join();
			$.ajax({
			  type: 'POST',
			  url: 'ajaxUpdateTalentShow',
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
