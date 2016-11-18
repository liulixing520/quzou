
	<div>
		<select id="regionName" onchange="changeRegionChoose(this);">
			<option value='CHN'>国内</option>
			<option value='FOREIGN'>国际</option>
		</select>
	</div>
		<div id="checkDiv" style="width:75%;float:left;margin-right:0.5%;max-height:270px;min-height:100px;overflow:auto">
			<#list allChnProvinceList![] as allChnProvince>
				<input type="checkBox" autocomplete='off' name="chnProvinceId" value="${allChnProvince.geoId}">${allChnProvince.geoName}&nbsp;&nbsp;
			</#list>
			<#if !allChnProvinceList?? || allChnProvinceList?size==0>都配置好了…………</#if>
			<br>
			初重：<input id='_firstWeight' onblur='validNum(this,"初重")' style='width:50px;'/>KG
			初价：<input id='_firstCost' onblur='validNum(this,"初价")' style='width:50px;'/>
			续重：<input id='_addWeight' onblur='validNum(this,"续重")' style='width:50px;'/>KG
			续价：<input id='_addCost' onblur='validNum(this,"续价")' style='width:50px;'/>
			货币：<select id='_currencyUomId' style='width:90px;'>
				<option value='CNY'>人民币（CNY）</option>
				<option value='USD'>美元（USD）</option>
			</select><br/>
			<button class="confirm_btn" onclick="addConfig();" style="">保存配置</button>
		</div>
	
	<div style="float:left;;overflow:auto;width:70%">
		<table class="table-bordered">
			<tr class="header-row">
			
				<td>国家</td>
				<td>省/直辖市</td>
				<td>初重(KG)</td>
				<td>初价</td>
				<td>续重(KG)</td>
				<td>续价</td>
				<td>货币单位</td>
				<td>操作</td>
			</tr>
			<tbody id="showDiv">
				<#list productStoreShipConfig![] as conf>
					<#assign country = delegator.findOne("Geo",false,{"geoId":conf.shippingCountry!})?if_exists/>
					<#assign province = delegator.findOne("Geo",false,{"geoId":conf.shippingProvince!})?if_exists/>
					<tr id="${conf.productStoreShipMethId!}_${conf.shippingCountry!}_${conf.shippingProvince!}" >
						<td name="shippingCountryTr" geoId="${conf.shippingCountry!}">
							${(country.geoName)!}
						</td>
						<td name="shippingProvinceTr" geoId="${conf.shippingProvince!}">
							<#if conf.shippingProvince?? && conf.shippingProvince=='_NA_'>--<#else>${(province.geoName)!}</#if>
						</td>
						<td name="firstWeightTd">${conf.firstWeight!'0'}</td>
						<td name="firstCostTd">${conf.firstCost!'0.00'}</td>
						<td name="addWeightTd">${conf.addWeight!'0'}</td>
						<td name="addCostTd">${conf.addCost!'0.00'}</td>
						<td name="currencyUomIdTd" uomId="${conf.currencyUomId!}"><#if conf.currencyUomId?? && conf.currencyUomId=='USD'>美元（USD）<#else>人民币（CNY）</#if></td>
						<td name="operTd">
							<a href="javascript:void(0);" onclick="editThis('${conf.productStoreShipMethId!}_${conf.shippingCountry!}_${conf.shippingProvince!}');">编辑</a>
							<a href="javascript:void(0);" onclick="delThis('${conf.productStoreShipMethId!}_${conf.shippingCountry!}_${conf.shippingProvince!}')">删除</a>
						</td>
					</tr>
				</#list>
			</tbody>
		</table>
	</div>
</div>
</div>
<script type="text/javascript">
	var productStoreShipMethId = "${parameters.productStoreShipMethId!}";
	var allChnProvinceList = {};
	var allForeignCountryList = {};
	<#list allChnProvinceList![] as allChnProvince>
		allChnProvinceList["${allChnProvince.geoId}"]="${allChnProvince.geoName}";
	</#list>
	<#list allForeignCountryList![] as allForeignCountry>
		allForeignCountryList["${allForeignCountry.geoId}"]="${allForeignCountry.geoName}";
	</#list>
	function changeRegionChoose(obj){
		var checks = '';
		if(obj.value=="CHN"){
			$.each(allChnProvinceList,function(k,v){
				checks+="<input type='checkBox' autocomplete='off' name='chnProvinceId' value='"+k+"'>"+v+"&nbsp;&nbsp;";
			});
		}else{
			$.each(allForeignCountryList,function(k,v){
				checks+="<input type='checkBox' autocomplete='off' name='countryId' value='"+k+"'>"+v+"&nbsp;&nbsp;";
			});
		}
		$("#checkDiv").html(checks);
	}
	function editThis(trId){
		var tr = $("#"+trId);
		var oldHtml = tr.html();
		tr.data("oldHtml",oldHtml);
		var firstWeightTd = tr.children("td[name=firstWeightTd]");
		var firstCostTd = tr.children("td[name=firstCostTd]");
		var addWeightTd = tr.children("td[name=addWeightTd]");
		var addCostTd = tr.children("td[name=addCostTd]");
		var currencyUomIdTd = tr.children("td[name=currencyUomIdTd]");
		var operTd = tr.children("td[name=operTd]");
		
		var firstWeightVal = firstWeightTd.html();
		var firstCostVal = firstCostTd.html();
		var addWeightVal = addWeightTd.html();
		var addCostVal = addCostTd.html();
		var currencyUomIdVal = currencyUomIdTd.attr("uomId");
		
		firstWeightTd.html("<input id='"+trId+"_firstWeight' value='"+firstWeightVal+"' onblur='validNum(this,\"初重\")' style='width:50px;'/>");
		firstCostTd.html("<input id='"+trId+"_firstCost' value='"+firstCostVal+"' onblur='validNum(this,\"初价\")' style='width:50px;'/>");
		addWeightTd.html("<input id='"+trId+"_addWeight' value='"+addWeightVal+"' onblur='validNum(this,\"续重\")' style='width:50px;'/>");
		addCostTd.html("<input id='"+trId+"_addCost' value='"+addCostVal+"' onblur='validNum(this,\"续价\")' style='width:50px;'/>");
		currencyUomIdTd.html("<select id='"+trId+"_currencyUomId' style='width:80px;'><option value='USD' "+(currencyUomIdVal=='USD'&&'selected')+">美元（USD）</option><option value='CNY' "+(currencyUomIdVal=='USD'||'selected')+">人民币（CNY）</option></select>");
		
		//$(ele).html('保存');
		//$(ele).attr('onclick','saveThis("'+productStoreShipMethId+'")');
		operTd.html('<a href="javascript:void(0);" onclick="saveThis(\''+trId+'\');">保存</a>&nbsp;<a href="javascript:void(0);" onclick="cancelEdit(\''+trId+'\');">取消</a>');
	}
	function cancelEdit(trId){
		var tr = $("#"+trId);
		var oldHtml = tr.data("oldHtml");
		tr.html(oldHtml);
	}
	function delThis(trId){
		var tr = $("#"+trId);
		var shippingCountry = tr.children("td[name=shippingCountryTr]").attr("geoId");
		var shippingProvince = tr.children("td[name=shippingProvinceTr]").attr("geoId");
		$.ajax({
			url:'delShipCostConfig',
			type:'post',
			data:{productStoreShipMethId:productStoreShipMethId,shippingCountry:shippingCountry,shippingProvince:shippingProvince},
			success:function(r){
				if(r.info){alert(r.info);}else{location.reload();}
			}
		});
	}
	function saveThis(trId){
		var tr = $("#"+trId);
		var shippingCountry = tr.children("td[name=shippingCountryTr]").attr("geoId");
		var shippingProvince = tr.children("td[name=shippingProvinceTr]").attr("geoId");
		var firstWeight = $("#"+trId+"_firstWeight").val();
		var firstCost = $("#"+trId+"_firstCost").val();
		var addWeight = $("#"+trId+"_addWeight").val();
		var addCost = $("#"+trId+"_addCost").val();
		var currencyUomId = $("#"+trId+"_currencyUomId").val();
		if(firstWeight && firstCost && firstCost && addCost){
			$.ajax({
				url:'modifyShipCostConfig',
				type:'post',
				data:{
					productStoreShipMethId:productStoreShipMethId,
					shippingCountry:shippingCountry,
					shippingProvince:shippingProvince,
					firstWeight:firstWeight,
					firstCost:firstCost,
					addWeight:addWeight,
					addCost:addCost,
					currencyUomId:currencyUomId
				},
				success:function(r){
					if(r.info){alert(r.info);}else{location.reload();}
				}
			});
		}else{
			alert("不能有空值");
		}
	}
	function validNum(ele,name){
		var value = ele.value;
		var re = /^\d+(.\d+)?$/;
		
      	if(value && !re.test(value)){
           	ele.value = '';
           	alert(name+"必须是数字！");
      	}
	}
	function addConfig(){
		if(!productStoreShipMethId)return;
		var regionName = $("#regionName").val();
		var regionCheckboxes = [];
		if(regionName=='CHN'){
			regionCheckboxes = $("input[name=chnProvinceId]:checked");
		}else{
			regionCheckboxes = $("input[name=countryId]:checked");
		}
		if(regionCheckboxes.length==0){
			alert("请选择要设置重量的国家或地区！");
			return false;
		}
		var ids = [];
		$.each(regionCheckboxes,function(i,obj){
			ids.push(obj.value);
		});
		var firstWeight = $("#_firstWeight").val();
		var firstCost = $("#_firstCost").val();
		var addWeight = $("#_addWeight").val();
		var addCost = $("#_addCost").val();
		var currencyUomId = $("#_currencyUomId").val();
		$.ajax({
			url:'createShipConfig',
			type:'post',
			data:{
				productStoreShipMethId:productStoreShipMethId,
				ids:ids.join(","),
				regionName:regionName,
				firstWeight:firstWeight,
				firstCost:firstCost,
				addWeight:addWeight,
				addCost:addCost,
				currencyUomId:currencyUomId
			},
			success:function(r){
				if(r.info){alert(r.info);}else{location.reload();}
			}
		});
	}
	
</script>