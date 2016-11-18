<script language="javascript">
    function selectCustomDate(){
            var fromDate = $('#fromDateDiv').val();
            var thruDate = $('#thruDateDiv').val();
            var productStoreId = $('#productStoreIdDiv').val();
    		if(!fromDate){
    			alert("请输入开始日期");
    			return false;
    		}
    		if(!thruDate){
    			alert("请输入结束日期");
    			return false;
    		}
		    jQuery.ajax({
		        url: "invalidOrderStats",
		        type: 'POST',
		        data:{fromDate:fromDate,thruDate:thruDate,productStoreId:productStoreId},
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
<div class="pageHeader" id="ReportDiv" layouth="55">
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
			选择时间：
			<input type="text" name="fromDate" id="fromDateDiv" <#if fromDate?has_content>value="${fromDate}"</#if> readonly="true" class="date textInput readonly valid" size="10">
			-
			<input type="text" name="thruDate" id="thruDateDiv" <#if thruDate?has_content>value="${thruDate}"</#if> readonly="true" class="date textInput readonly valid" size="10">
			<input type="button" onclick="javascript:selectCustomDate();" value="查询">
		</td>
		<td>
			<form name="InvalidOrderStats" class="basic-form" id="InvalidOrderStats" target="_BLANK" action="invalidOrderStatsReport" method="post">
				<input type="hidden" <#if fromDate?has_content>value="${fromDate}"</#if> name="fromDate"><input type="hidden" <#if thruDate?has_content>value="${thruDate}"</#if> name="thruDate"><input type="hidden" <#if productStoreId?has_content>value="${productStoreId}"</#if> name="productStoreId">
				<input type="submit" value="导出Excel报表" name="submit" <#if !fromDate?has_content && !thruDate?has_content>disabled</#if>>
			</form>
		</td>
	</tr>
</table>
<table cellspacing="0" cellpadding="0" border="0" width="100%" class="border04 overall_03">
  <tr class="title02">
    <td align="center">日期</td>
    <td align="center">无效订单数</td>
    <td align="center">无效销售额</td>
  </tr>
  <#if dayResultList?has_content>
 	  <#assign total = 0>
  	  <#assign orderCount = 0>
      <#list dayResultList as resultMap>
      	<#assign total = total + resultMap.cancleTotal>
        <#assign orderCount = orderCount + resultMap.cancleCount>
      	<tr>
            <td  align="center">${resultMap.dailydate?if_exists}</td>
            <td  align="center">${resultMap.cancleCount?string.number}</td>
            <td  align="center"><@ofbizCurrency amount=resultMap.cancleTotal isoCode='CNY'/></td>
        <tr>
      </#list>
      <tr class="title02">
	    <td align="right">合计</td>
	    <td align="center">${orderCount?if_exists}</td>
	    <td align="center"><@ofbizCurrency amount=total isoCode='CNY'/></td>
	  </tr>
  </#if>
</table>
</div>