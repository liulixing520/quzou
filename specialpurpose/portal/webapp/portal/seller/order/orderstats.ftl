<div class="pageHeader" id="ReportDiv" layouth="55">
<script language="javascript">
	function selectYear(obj){
		var productStoreId = $('#productStoreIdDiv').val();
		if(obj.value){
		    jQuery.ajax({
		        url: "orderStatisticsReport",
		        type: 'POST',
		        data:{year:obj.value,productStoreId:productStoreId},
		        error: function(msg) {
		           //alert(msg);
		        },
		        success: function(msg) {
		        jQuery('#ReportDiv').html(msg);
				$('#ReportDiv').initUI();
		        }
		    });
	     }
	}
	function selectMonth(obj){
		var productStoreId = $('#productStoreIdDiv').val();
		if(obj.value){
		    jQuery.ajax({
		        url: "orderStatisticsReport",
		        type: 'POST',
		        data:{month:obj.value,productStoreId:productStoreId},
		        error: function(msg) {
		           //alert(msg);
		        },
		        success: function(msg) {
		        jQuery('#ReportDiv').html(msg);
				$('#ReportDiv').initUI();
		        }
		    });
		}
	}
	function selectYearMonth(year,month){
			var productStoreId = $('#productStoreIdDiv').val();
		    jQuery.ajax({
		        url: "orderStatisticsReport",
		        type: 'POST',
		        data:{monthSel:month,yearSel:year,productStoreId:productStoreId},
		        error: function(msg) {
		           //alert(msg);
		        },
		        success: function(msg) {
		        jQuery('#ReportDiv').html(msg);
				$('#ReportDiv').initUI();
		        }
		    });
	}
    function selectCustomDate(){
            var fromDate = $('#fromDateDiv').val();
            var thruDate = $('#thruDateDiv').val();
            var customType = $('#customType').val();
            var productStoreId = $('#productStoreIdDiv').val();
    		if(!fromDate){
    			alert("请输入开始日期");
    			return false;
    		}
    		if(!thruDate){
    			alert("请输入结束日期");
    			return false;
    		}
    		if(!customType){
    			alert("请选择报表类型");
    			return false;
    		}
		    jQuery.ajax({
		        url: "orderStatisticsReport",
		        type: 'POST',
		        data:{customType:customType,fromDate:fromDate,thruDate:thruDate,productStoreId:productStoreId},
		        error: function(msg) {
		           //alert(msg);
		        },
		        success: function(msg) {
		        jQuery('#ReportDiv').html(msg);
				$('#ReportDiv').initUI();
		        }
		    });
	}  
</script>
<table>
	<tr>
		<td>
			店铺：
			<select name="productStoreId" id="productStoreIdDiv" class="required">
				<option value="" >请选择所属店铺</option>
				<#if productStoreList?has_content>
					<#list productStoreList as productStore>
						<option value="${productStore.productStoreId?if_exists}" <#if productStoreId?has_content><#if productStoreId == productStore.productStoreId>selected=selected</#if></#if>>${productStore.storeName?if_exists}</option>
					</#list>
				</#if>
			</select>	
			<#assign year = year?default(2012)>
			<select id="year" name="year" onchange="selectYear(this)" >
				<option value="">查看年报</option>
				<#list nowYear-3..nowYear-1 as setYear>
					<option value="${setYear}" <#if setYear == year>selected="selected"</#if>>${setYear}</option>
				</#list>
			</select>
			<#assign month = month?default(12)>
			<select id="month" name="month" onchange="selectMonth(this)" >
				<option value="">查看月报</option>
				<#if (nowMonth >=6)>
					<#list nowMonth-5..nowMonth as setMonth>
						<option value="${setMonth}" <#if setMonth == month>selected="selected"</#if>>${nowYear}年${setMonth}月</option>
					</#list>
				<#else>
					<#list 1..nowMonth as setMonth>
						<option value="${setMonth}" <#if setMonth == month>selected="selected"</#if>>${nowYear}年${setMonth}月</option>
					</#list>
				</#if>
			</select>
			选择时间：
			<input type="text" name="fromDate" id="fromDateDiv" <#if fromDate?has_content>value="${fromDate}"</#if> readonly="true" class="date textInput readonly valid" size="10">
			-
			<input type="text" name="thruDate" id="thruDateDiv" <#if thruDate?has_content>value="${thruDate}"</#if> readonly="true" class="date textInput readonly valid" size="10">
			<select id="customType" name="customType">
				<option value="">报表类型</option>
				<option value="month" <#if customType?has_content><#if customType == 'month'>selected="selected"</#if></#if>>月报表</option>
				<option value="day" <#if customType?has_content><#if customType == 'day'>selected="selected"</#if></#if>>日报表</option>
			</select>
			<input type="button" onclick="javascript:selectCustomDate();" value="查询">
		</td>
		<td>
			<form name="orderStatsReport" onsubmit="javascript:submitFormDisableSubmits(this)" class="basic-form" id="orderStatsReport" target="_BLANK" action="orderStatsReport" method="post">
				<input type="hidden" value="${reportType!}" name="reportType" id="reportType">
				<#if reportType?has_content><#if reportType == "year"><input type="hidden" value="${year!}" name="year"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "day"><input type="hidden" value="${month!}" name="month"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "yearMonthSel"><input type="hidden" value="${yearSel!}" name="year"><input type="hidden" value="${monthSel!}" name="month"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "yearCustom"><input type="hidden" value="${fromDate!}" name="fromDate"><input type="hidden" value="${thruDate!}" name="thruDate"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "dayCustom"><input type="hidden" value="${fromDate!}" name="fromDate"><input type="hidden" value="${thruDate!}" name="thruDate"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<input type="submit" value="生成Excel报表" name="submit" <#if !reportType?has_content>disabled</#if>>
			</form>
		</td>
		<td>
			<form name="orderStatsBarReport" onsubmit="javascript:submitFormDisableSubmits(this)" class="basic-form" id="orderStatsBarReport" target="_BLANK" action="orderStatsBarReport" method="post">
				<input type="hidden" value="${reportType!}" name="reportType" id="reportType">
				<#if reportType?has_content><#if reportType == "year"><input type="hidden" value="${year!}" name="year"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "day"><input type="hidden" value="${month!}" name="month"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "yearMonthSel"><input type="hidden" value="${yearSel!}" name="year"><input type="hidden" value="${monthSel!}" name="month"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "yearCustom"><input type="hidden" value="${fromDate!}" name="fromDate"><input type="hidden" value="${thruDate!}" name="thruDate"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "dayCustom"><input type="hidden" value="${fromDate!}" name="fromDate"><input type="hidden" value="${thruDate!}" name="thruDate"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<input type="submit" value="生成柱状图" name="submit" <#if !reportType?has_content>disabled</#if>>
			</form>
		</td>
		<td>
			<form name="orderStatsLineReport" onsubmit="javascript:submitFormDisableSubmits(this)" class="basic-form" id="orderStatsLineReport" target="_BLANK" action="orderStatsLineReport" method="post">
				<input type="hidden" value="${reportType!}" name="reportType" id="reportType">
				<#if reportType?has_content><#if reportType == "year"><input type="hidden" value="${year!}" name="year"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "day"><input type="hidden" value="${month!}" name="month"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "yearMonthSel"><input type="hidden" value="${yearSel!}"name="year"><input type="hidden" value="${monthSel!}" name="month"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "yearCustom"><input type="hidden" value="${fromDate!}" name="fromDate"><input type="hidden" value="${thruDate!}" name="thruDate"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<#if reportType?has_content><#if reportType == "dayCustom"><input type="hidden" value="${fromDate!}" name="fromDate"><input type="hidden" value="${thruDate!}" name="thruDate"><input type="hidden" value="${productStoreId!}" name="productStoreIdStr"></#if></#if>
				<input type="submit" value="生成曲线图" name="submit" <#if !reportType?has_content>disabled</#if>>
			</form>
		</td>
	</tr>
</table>
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="border04 overall_03">
          <tr class="title02">
            <td align="right">日期</td>
            <td align="right">总订单</td>
            <td align="right">总销售额</td>
            <td align="right">总订单运费</td>
            <td align="right">有效订单</td>
            <td align="right">有效销售额</td>
            <td align="right">有效订单运费</td>
            <td align="right">成功订单</td>
            <td align="right">成功销售额</td>
            <td align="right">成功订单运费</td>
            <td align="right">无效订单</td>
            <td align="right">无效销售额</td>
          </tr>
          <#if yearResultList?has_content>
          	  <#assign monthItemCount = 0>
          	  <#assign monthItemTotal = 0>
          	  <#assign monthItemShippingTotal = 0>
          	  
          	  <#assign monthItemValidCount = 0>
          	  <#assign monthItemValidTotal = 0>
          	  <#assign monthItemValidShippingTotal = 0>
          	  
          	  <#assign monthItemCompletedCount = 0>
          	  <#assign monthItemCompletedTotal = 0>
          	  <#assign monthItemCompletedShippingTotal = 0>
          	  
          	  <#assign monthItemCancleCount = 0>
          	  <#assign monthItemCancleTotal = 0>
	          <#list yearResultList as monthResult>
		          <tr>
		            <td class="border03 width35"><a href="#" onclick="javascript:selectYearMonth('${monthResult.currentMonth.substring(0,4)}','${monthResult.currentMonth.substring(5,7)}');"  >${monthResult.currentMonth}</a></td>
		            <td class="border03 width35">${monthResult.monthItemCount?string.number}</td>
		            <td class="border03 width35">${monthResult.monthItemTotal?string.number}</td>
		            <td class="border03 width35">${monthResult.monthItemShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${monthResult.monthItemValidCount}</td>
		            <td class="border03 width35">${monthResult.monthItemValidTotal?string.number}</td>
		            <td class="border03 width35">${monthResult.monthItemValidShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${monthResult.monthItemCompletedCount}</td>
		            <td class="border03 width35">${monthResult.monthItemCompletedTotal?string.number}</td>
		            <td class="border03 width35">${monthResult.monthItemCompletedShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${monthResult.monthItemCancleCount}</td>
		            <td class="border03 width35">${monthResult.monthItemCancleTotal?string.number}</td>
		          </tr>
		          <#assign monthItemCount = monthItemCount + monthResult.monthItemCount>
	          	  <#assign monthItemTotal = monthItemTotal + monthResult.monthItemTotal>
	          	  <#assign monthItemShippingTotal = monthItemShippingTotal + monthResult.monthItemShippingTotal>
	          	  
	          	  <#assign monthItemValidCount = monthItemValidCount + monthResult.monthItemValidCount>
	          	  <#assign monthItemValidTotal = monthItemValidTotal + monthResult.monthItemValidTotal>
	          	  <#assign monthItemValidShippingTotal = monthItemValidShippingTotal + monthResult.monthItemValidShippingTotal>
	          	  
	          	  <#assign monthItemCompletedCount = monthItemCompletedCount + monthResult.monthItemCompletedCount>
	          	  <#assign monthItemCompletedTotal = monthItemCompletedTotal + monthResult.monthItemCompletedTotal>
	          	  <#assign monthItemCompletedShippingTotal = monthItemCompletedShippingTotal + monthResult.monthItemCompletedShippingTotal>
	          	  
	          	  <#assign monthItemCancleCount = monthItemCancleCount + monthResult.monthItemCancleCount>
	          	  <#assign monthItemCancleTotal =  monthItemCancleTotal + monthResult.monthItemCancleTotal>
	          </#list>
	          <tr>
	            <td class="border03 width35">合计</td>
	            <td class="border03 width35">${monthItemCount?string.number}</td>
	            <td class="border03 width35">${monthItemTotal?string.number}</td>
	            <td class="border03 width35">${monthItemShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${monthItemValidCount}</td>
	            <td class="border03 width35">${monthItemValidTotal?string.number}</td>
	            <td class="border03 width35">${monthItemValidShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${monthItemCompletedCount}</td>
	            <td class="border03 width35">${monthItemCompletedTotal?string.number}</td>
	            <td class="border03 width35">${monthItemCompletedShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${monthItemCancleCount}</td>
	            <td class="border03 width35">${monthItemCancleTotal?string.number}</td>
	          </tr>
          </#if>
          <#if yearCustomResultList?has_content>
          	  <#assign monthItemCount = 0>
          	  <#assign monthItemTotal = 0>
          	  <#assign monthItemShippingTotal = 0>
          	  
          	  <#assign monthItemValidCount = 0>
          	  <#assign monthItemValidTotal = 0>
          	  <#assign monthItemValidShippingTotal = 0>
          	  
          	  <#assign monthItemCompletedCount = 0>
          	  <#assign monthItemCompletedTotal = 0>
          	  <#assign monthItemCompletedShippingTotal = 0>
          	  
          	  <#assign monthItemCancleCount = 0>
          	  <#assign monthItemCancleTotal = 0>
	          <#list yearCustomResultList as monthResult>
		          <tr>
		            <td class="border03 width35"><a href="#" onclick="javascript:selectYearMonth('${monthResult.currentMonth.substring(0,4)}','${monthResult.currentMonth.substring(5,7)}');"  >${monthResult.currentMonth}</a></td>
		            <td class="border03 width35">${monthResult.monthItemCount?string.number}</td>
		            <td class="border03 width35">${monthResult.monthItemTotal?string.number}</td>
		            <td class="border03 width35">${monthResult.monthItemShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${monthResult.monthItemValidCount}</td>
		            <td class="border03 width35">${monthResult.monthItemValidTotal?string.number}</td>
		            <td class="border03 width35">${monthResult.monthItemValidShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${monthResult.monthItemCompletedCount}</td>
		            <td class="border03 width35">${monthResult.monthItemCompletedTotal?string.number}</td>
		            <td class="border03 width35">${monthResult.monthItemCompletedShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${monthResult.monthItemCancleCount}</td>
		            <td class="border03 width35">${monthResult.monthItemCancleTotal?string.number}</td>
		          </tr>
		          <#assign monthItemCount = monthItemCount + monthResult.monthItemCount>
	          	  <#assign monthItemTotal = monthItemTotal + monthResult.monthItemTotal>
	          	  <#assign monthItemShippingTotal = monthItemShippingTotal + monthResult.monthItemShippingTotal>
	          	  
	          	  <#assign monthItemValidCount = monthItemValidCount + monthResult.monthItemValidCount>
	          	  <#assign monthItemValidTotal = monthItemValidTotal + monthResult.monthItemValidTotal>
	          	  <#assign monthItemValidShippingTotal = monthItemValidShippingTotal + monthResult.monthItemValidShippingTotal>
	          	  
	          	  <#assign monthItemCompletedCount = monthItemCompletedCount + monthResult.monthItemCompletedCount>
	          	  <#assign monthItemCompletedTotal = monthItemCompletedTotal + monthResult.monthItemCompletedTotal>
	          	  <#assign monthItemCompletedShippingTotal = monthItemCompletedShippingTotal + monthResult.monthItemCompletedShippingTotal>
	          	  
	          	  <#assign monthItemCancleCount = monthItemCancleCount + monthResult.monthItemCancleCount>
	          	  <#assign monthItemCancleTotal =  monthItemCancleTotal + monthResult.monthItemCancleTotal>
	          </#list>
	          <tr>
	            <td class="border03 width35">合计</td>
	            <td class="border03 width35">${monthItemCount?string.number}</td>
	            <td class="border03 width35">${monthItemTotal?string.number}</td>
	            <td class="border03 width35">${monthItemShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${monthItemValidCount}</td>
	            <td class="border03 width35">${monthItemValidTotal?string.number}</td>
	            <td class="border03 width35">${monthItemValidShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${monthItemCompletedCount}</td>
	            <td class="border03 width35">${monthItemCompletedTotal?string.number}</td>
	            <td class="border03 width35">${monthItemCompletedShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${monthItemCancleCount}</td>
	            <td class="border03 width35">${monthItemCancleTotal?string.number}</td>
	          </tr>
          </#if>
          <#if dayResultList?has_content>
          	  <#assign dayItemCount = 0>
          	  <#assign dayItemTotal = 0>
          	  <#assign dayItemShippingTotal = 0>
          	  
          	  <#assign dayItemValidCount = 0>
          	  <#assign dayItemValidTotal = 0>
          	  <#assign dayItemValidShippingTotal = 0>
          	  
          	  <#assign dayItemCompletedCount = 0>
          	  <#assign dayItemCompletedTotal = 0>
          	  <#assign dayItemCompletedShippingTotal = 0>
          	  
          	  <#assign dayItemCancleCount = 0>
          	  <#assign dayItemCancleTotal = 0>
	          <#list dayResultList as dayResult>
		          <tr>
		            <td class="border03 width35">${dayResult.currentDay}</td>
		            <td class="border03 width35">${dayResult.dayItemCount?string.number}</td>
		            <td class="border03 width35">${dayResult.dayItemTotal?string.number}</td>
		            <td class="border03 width35">${dayResult.dayItemShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${dayResult.dayItemValidCount}</td>
		            <td class="border03 width35">${dayResult.dayItemValidTotal?string.number}</td>
		            <td class="border03 width35">${dayResult.dayItemValidShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${dayResult.dayItemCompletedCount}</td>
		            <td class="border03 width35">${dayResult.dayItemCompletedTotal?string.number}</td>
		            <td class="border03 width35">${dayResult.dayItemCompletedShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${dayResult.dayItemCancleCount}</td>
		            <td class="border03 width35">${dayResult.dayItemCancleTotal?string.number}</td>
		          </tr>
		          <#assign dayItemCount = dayItemCount + dayResult.dayItemCount>
	          	  <#assign dayItemTotal = dayItemTotal + dayResult.dayItemTotal>
	          	  <#assign dayItemShippingTotal = dayItemShippingTotal + dayResult.dayItemShippingTotal>
	          	  
	          	  <#assign dayItemValidCount = dayItemValidCount + dayResult.dayItemValidCount>
	          	  <#assign dayItemValidTotal = dayItemValidTotal + dayResult.dayItemValidTotal>
	          	  <#assign dayItemValidShippingTotal = dayItemValidShippingTotal + dayResult.dayItemValidShippingTotal>
	          	  
	          	  <#assign dayItemCompletedCount = dayItemCompletedCount + dayResult.dayItemCompletedCount>
	          	  <#assign dayItemCompletedTotal = dayItemCompletedTotal + dayResult.dayItemCompletedTotal>
	          	  <#assign dayItemCompletedShippingTotal = dayItemCompletedShippingTotal + dayResult.dayItemCompletedShippingTotal>
	          	  
	          	  <#assign dayItemCancleCount = dayItemCancleCount + dayResult.dayItemCancleCount>
	          	  <#assign dayItemCancleTotal =  dayItemCancleTotal + dayResult.dayItemCancleTotal>
	          </#list>
	          <tr>
	            <td class="border03 width35">合计</td>
	            <td class="border03 width35">${dayItemCount?string.number}</td>
	            <td class="border03 width35">${dayItemTotal?string.number}</td>
	            <td class="border03 width35">${dayItemShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${dayItemValidCount}</td>
	            <td class="border03 width35">${dayItemValidTotal?string.number}</td>
	            <td class="border03 width35">${dayItemValidShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${dayItemCompletedCount}</td>
	            <td class="border03 width35">${dayItemCompletedTotal?string.number}</td>
	            <td class="border03 width35">${dayItemCompletedShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${dayItemCancleCount}</td>
	            <td class="border03 width35">${dayItemCancleTotal?string.number}</td>
	          </tr>
          </#if>
          <#if dayCustomResultList?has_content>
          	  <#assign dayItemCount = 0>
          	  <#assign dayItemTotal = 0>
          	  <#assign dayItemShippingTotal = 0>
          	  
          	  <#assign dayItemValidCount = 0>
          	  <#assign dayItemValidTotal = 0>
          	  <#assign dayItemValidShippingTotal = 0>
          	  
          	  <#assign dayItemCompletedCount = 0>
          	  <#assign dayItemCompletedTotal = 0>
          	  <#assign dayItemCompletedShippingTotal = 0>
          	  
          	  <#assign dayItemCancleCount = 0>
          	  <#assign dayItemCancleTotal = 0>
	          <#list dayCustomResultList as dayResult>
		          <tr>
		            <td class="border03 width35">${dayResult.currentDay}</td>
		            <td class="border03 width35">${dayResult.dayItemCount?string.number}</td>
		            <td class="border03 width35">${dayResult.dayItemTotal?string.number}</td>
		            <td class="border03 width35">${dayResult.dayItemShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${dayResult.dayItemValidCount}</td>
		            <td class="border03 width35">${dayResult.dayItemValidTotal?string.number}</td>
		            <td class="border03 width35">${dayResult.dayItemValidShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${dayResult.dayItemCompletedCount}</td>
		            <td class="border03 width35">${dayResult.dayItemCompletedTotal?string.number}</td>
		            <td class="border03 width35">${dayResult.dayItemCompletedShippingTotal?string.number}</td>
		            
		            <td class="border03 width35">${dayResult.dayItemCancleCount}</td>
		            <td class="border03 width35">${dayResult.dayItemCancleTotal?string.number}</td>
		          </tr>
		          <#assign dayItemCount = dayItemCount + dayResult.dayItemCount>
	          	  <#assign dayItemTotal = dayItemTotal + dayResult.dayItemTotal>
	          	  <#assign dayItemShippingTotal = dayItemShippingTotal + dayResult.dayItemShippingTotal>
	          	  
	          	  <#assign dayItemValidCount = dayItemValidCount + dayResult.dayItemValidCount>
	          	  <#assign dayItemValidTotal = dayItemValidTotal + dayResult.dayItemValidTotal>
	          	  <#assign dayItemValidShippingTotal = dayItemValidShippingTotal + dayResult.dayItemValidShippingTotal>
	          	  
	          	  <#assign dayItemCompletedCount = dayItemCompletedCount + dayResult.dayItemCompletedCount>
	          	  <#assign dayItemCompletedTotal = dayItemCompletedTotal + dayResult.dayItemCompletedTotal>
	          	  <#assign dayItemCompletedShippingTotal = dayItemCompletedShippingTotal + dayResult.dayItemCompletedShippingTotal>
	          	  
	          	  <#assign dayItemCancleCount = dayItemCancleCount + dayResult.dayItemCancleCount>
	          	  <#assign dayItemCancleTotal =  dayItemCancleTotal + dayResult.dayItemCancleTotal>
	          </#list>
	          <tr>
	            <td class="border03 width35">合计</td>
	            <td class="border03 width35">${dayItemCount?string.number}</td>
	            <td class="border03 width35">${dayItemTotal?string.number}</td>
	            <td class="border03 width35">${dayItemShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${dayItemValidCount}</td>
	            <td class="border03 width35">${dayItemValidTotal?string.number}</td>
	            <td class="border03 width35">${dayItemValidShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${dayItemCompletedCount}</td>
	            <td class="border03 width35">${dayItemCompletedTotal?string.number}</td>
	            <td class="border03 width35">${dayItemCompletedShippingTotal?string.number}</td>
	            
	            <td class="border03 width35">${dayItemCancleCount}</td>
	            <td class="border03 width35">${dayItemCancleTotal?string.number}</td>
	          </tr>
          </#if>
</table>
</div>