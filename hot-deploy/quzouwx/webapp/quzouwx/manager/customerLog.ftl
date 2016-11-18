<body >
<div class="jzrz">
<div class="jzrz_xzsj">
 <font size="+1" color="#999">选择时间</font>&nbsp;<font color="#88d52e">|</font>&nbsp;<font size="+1" color="#333"><input type="text" class="sz_input" style="float: right;width: 32%;margin: 3% 10% 0 -14%;" id="stepDate" value="${stepDate!}" data-lastvalue='${stepDate!}' onfocus="WdatePicker({dateFmt:'yyyy-MM',onpicked: pickedDate})" /></font> 
</div>
<div class="jzrz_zbs">
  <div class="left"></div>
  <div class="jzcenter"></div>
  <div class="right"></div>
</div>
<#if customerLogAndCustomerList?has_content>
	<#list customerLogAndCustomerList as item>
		<div class="<#if (item_index % 2) == 1 >jzrz_content<#else>jzrz_hs_content</#if>" >
		  <div class="left">${(item.stepNumber)!}</div>
		  <div class="jzcenter">${(item.stepDate?string('yyyy-MM-dd'))!}</div>
		  <div class="right">${(item.uploadDate?string('yyyy-MM-dd'))!}</div>
		</div> 
	</#list>
</#if>
<div style="background:#fff;clear:both; height:80px;"></div>
</div>
<script>

	function pickedDate(){
	  var wp = $('#stepDate');
	  var lastvalue = wp.data("lastvalue");
	  var currentValue = $('#stepDate').val();
	  window.location.href="customerLog?stepDate="+currentValue;
	  wp.data('lastvalue', currentValue);
	}
	
</script>