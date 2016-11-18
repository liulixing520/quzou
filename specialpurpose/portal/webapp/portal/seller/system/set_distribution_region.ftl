<form id="Distributionform" name="Distributionform">
<div class="pageContent">
	<table class="table" layoutH="58" targetType="dialog" width="80%">
		<thead>
			<tr>
				<th width="150px">&nbsp;<input type="checkbox" name="selectAll" value="0" onclick="javascript:toggleAll(this);"/>配送区域名称</th>
				<#if feeType == 'weight'>
					<th style="text-align:center;width:180px">首重费用</th>
					<th style="text-align:center;width:180px">续重费用</th>
				<#else>
					<th>设置运费</th>
				</#if>
			</tr>
		</thead>
		<tbody>
		<#list geoList as geo>
			<tr>
				<td width="150px">
					<#assign g = delegator.findByPrimaryKey("Geo",Static["org.ofbiz.base.util.UtilMisc"].toMap("geoId",geo.geoIdTo))>
					<input type="checkbox" id="regionId${geo.geoIdTo?if_exists}" name="regionId" value="${geo.geoIdTo?if_exists}" onclick="javascript:checkToggle(this);" title="${g.get("geoName",locale)}"/>&nbsp;${g.get("geoName",locale)}
					<input type="hidden" id="hidd_${geo.geoIdTo?if_exists}" value="default"/>
				</td>
				<#if feeType == 'weight'>
					<td width="180px">
						<input type="text" name="firstMoney${geo.geoIdTo?if_exists}" id="firstMoney${geo.geoIdTo?if_exists}" class="digits" size="10"/>元
		   		      	<select name="firstUnit${geo.geoIdTo?if_exists}" id="firstUnit${geo.geoIdTo?if_exists}">
		      	      	  <option value="1:WT_kg">1kg</option>
		      	      	  <option value="10:WT_kg">10kg</option>
		      	      	  <option value="20:WT_kg">20kg</option>
		      	      	  <option value="50:WT_kg">50kg</option>
		      	      	  <option value="100:WT_kg">100kg</option>
		      	      	  <option value="200:WT_kg">200kg</option>
		      	      	  <option value="500:WT_kg">500kg</option>
						  <option value="1000:WT_kg">1000kg</option>
				        </select>
					</td>
					<td width="180px">
						<input type="text" name="additionalMoney${geo.geoIdTo?if_exists}" id="additionalMoney${geo.geoIdTo?if_exists}" class="digits" size="10"/>元
		   		      	<select name="additionalUnit${geo.geoIdTo?if_exists}" id="additionalUnit${geo.geoIdTo?if_exists}">
		      	      	  <option value="1:WT_kg">1kg</option>
		      	      	  <option value="10:WT_kg">10kg</option>
		      	      	  <option value="20:WT_kg">20kg</option>
		      	      	  <option value="50:WT_kg">50kg</option>
		      	      	  <option value="100:WT_kg">100kg</option>
		      	      	  <option value="200:WT_kg">200kg</option>
		      	      	  <option value="500:WT_kg">500kg</option>
						  <option value="1000:WT_kg">1000kg</option>
				        </select>
					</td>
				<#else>
					<td><input type="text" class="digits" name="carriage_${geo.geoIdTo?if_exists}" id="carriage_${geo.geoIdTo?if_exists}" size="10"/>元</td>
					
				
				</#if>
			</tr>
		</#list>
		</tbody>
	</table>
</div>
</form>
<br/>
<input type="button" value="添加配送地区" id="add" class="botinput" name="button3">
<script type="text/javascript">
function toggle(e) {
    if(!e.checked){
    	<#--判断别的配送区域是否有这个区域-->
    	$.getJSON('<@ofbizUrl>/getIfExistsByGeoId</@ofbizUrl>',{geoId:e.value},function(r){
			if(r&&r.status=='ok'){ 	
				e.checked = !e.checked;
			}else{
	            e.checked =false;
				alert("别的配送区域里已经添加了 "+e.title+" 区域！");
			}
		});	
    }
    else{
	    e.checked = !e.checked;
	    deleteHidden(e.value);
    }
    
}
var cform = document.Distributionform;
function toggleAll() {
    var len = cform.elements.length;
    for (var i = 0; i < len; i++) {
        var e = cform.elements[i];
        if (e.name == "regionId") {
            toggle(e);
        }
    }
}
function checkToggle(e) {
    if (e.checked) {
    	<#--判断别的配送区域是否有这个区域-->
	    $.getJSON('<@ofbizUrl>/getIfExistsByGeoId</@ofbizUrl>',{geoId:e.value},function(r){
			if(r&&r.status=='ok'){ 	
				var len = cform.elements.length;
		        var allchecked = true;
		        for (var i = 0; i < len; i++) {
		            var element = cform.elements[i];
		            if (element.name == "regionId" && !element.checked) {
		                allchecked = false;
		            }
		            cform.selectAll.checked = allchecked;
		        }
			}else{
	            e.checked =false;
				alert("别的配送区域里已经添加了该区域！");
			}
		});		
    } else {
        cform.selectAll.checked = false;
        deleteHidden(e.value);
    }
}
<#if feeType == 'weight'>
function deleteHidden(val) {
    $("input[type=hidden][name=distRegions_weightId_regionId_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_weightId_firstMoney_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_weightId_additionalMoney_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_weightId_firstDimension_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_weightId_additionalDimension_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_weightId_firstUnit_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_weightId_additionalUnit_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_weightId_opened_"+val+"]").remove();
}
$("#add").bind("click",function (){
	if(validateForm(document.getElementById("Distributionform")) == false){return;}
	var hiddens = "";
	//配送方式的首重金额
	var firstMoney = $("#firstMoneyTxt").val();
	//配送方式的续重金额
	var additionalMoney = $("#additionalMoneyTxt").val();
	//配送方式的首重单位
	var firstUnit = $("#firstUnitSel").val();
	//配送方式的续重单位
	var additionalUnit = $("#additionalUnitSel").val();
	var checkboxes = $("input:checked[type=checkbox][name=regionId]");
	for (var i = 0, ci; ci = checkboxes[i]; i++){
		//配送地区的首重金额
		var regionFirstMoney = $("#firstMoney" + ci.value).val();
		//配送地区的续重金额
		var regionAdditionalMoney = $("#additionalMoney" + ci.value).val();
		//配送地区的首重单位
		var regionFirstUnit = $("#firstUnit" + ci.value).val();
		//配送地区的续重单位
		var regionAdditionalUnit = $("#additionalUnit" + ci.value).val();
		//是否打开
		var isOpened = $("#hidd_"+ci.value).val();
		$("input[type=hidden][name=distRegions_weightId_regionId_"+ci.value+"]").each(function(){
			if($(this).attr("value") == ci.value){
				deleteHidden(ci.value);
			}
		});
		hiddens += "<input type='hidden' name='distRegions_weightId_regionId_"+ci.value+"' id='distRegions_weightId_regionId_"+ci.value+"' value='"+ci.value+"'/>";
		hiddens += "<input type='hidden' name='distRegions_weightId_firstMoney_"+ci.value+"' id='distRegions_weightId_firstMoney_"+ci.value+"'value='"+regionFirstMoney+"'/>";
		hiddens += "<input type='hidden' name='distRegions_weightId_additionalMoney_"+ci.value+"' id='distRegions_weightId_additionalMoney_"+ci.value+"' value='"+regionAdditionalMoney+"'/>";
		hiddens += "<input type='hidden' name='distRegions_weightId_firstDimension_"+ci.value+"' id='distRegions_weightId_firstDimension_"+ci.value+"' value='"+regionFirstUnit.split(":")[0]+"'/>";
		hiddens += "<input type='hidden' name='distRegions_weightId_additionalDimension_"+ci.value+"' id='distRegions_weightId_additionalDimension_"+ci.value+"' value='"+regionAdditionalUnit.split(":")[0]+"'/>";
		hiddens += "<input type='hidden' name='distRegions_weightId_firstUnit_"+ci.value+"' id='distRegions_weightId_firstUnit_"+ci.value+"' value='"+regionFirstUnit.split(":")[1]+"'/>";
		hiddens += "<input type='hidden' name='distRegions_weightId_additionalUnit_"+ci.value+"' id='distRegions_weightId_additionalUnit_"+ci.value+"' value='"+regionAdditionalUnit.split(":")[1]+"'/>";
		hiddens += "<input type='hidden' name='distRegions_weightId_opened_"+ci.value+"' id='distRegions_weightId_opened_"+ci.value+"' value='"+isOpened+"'/>";
	}
	$("#distribution_regions").append(hiddens);
	$("#hidd_modified").val("modified");
	$.pdialog.closeCurrent();
});
<#else>
function deleteHidden(val) {
    $("input[type=hidden][name=distRegions_unitId_regionId_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_unitId_carriage_"+val+"]").remove();
	$("input[type=hidden][name=distRegions_unitId_opened_"+val+"]").remove();
}
$("#add").bind("click",function(){
	if(validateForm(document.getElementById("Distributionform")) == false){return;}
	var checkboxes = $("input:checked[type=checkbox][name=regionId]");
	var hiddens = "";
	for (var i = 0, ci; ci = checkboxes[i]; i++){
		//配送地区的运费
		var regionCarriage = $("#carriage_" + ci.value).val();
		//是否打开
		var isOpened = $("#hidd_"+ci.value).val();
		$("input[type=hidden][name=distRegions_unitId_regionId_"+ci.value+"]").each(function(){
			if($(this).attr("value") == ci.value){
				deleteHidden(ci.value);
			}
		});
		hiddens += "<input type='hidden' id='distRegions_unitId_regionId_"+ci.value+"' name='distRegions_unitId_regionId_"+ci.value+"' value='"+ci.value+"'/>";
		hiddens += "<input type='hidden' id='distRegions_unitId_carriage_"+ci.value+"' name='distRegions_unitId_carriage_"+ci.value+"' value='"+regionCarriage+"'/>";
		hiddens += "<input type='hidden' id='distRegions_unitId_opened_"+ci.value+"' name='distRegions_unitId_opened_"+ci.value+"' value='"+isOpened+"'/>";
	}
	$("#distribution_regions").append(hiddens);
	$("#hidd_modified").val("modified");
	$.pdialog.closeCurrent();
});
</#if>
$(document).ready(function(){});
	<#if feeType == 'weight'>
		$("#distribution_regions").find("input[type=hidden][name^='distRegions_weightId_regionId_']").each(function(){
			$("#regionId"+this.value).attr("checked","checked");
			var  firstMoney = document.getElementById("firstMoney" + this.value);
			firstMoney.setAttribute("value", document.getElementById("distRegions_weightId_firstMoney_" + this.value).value);
			var v1= $("#distRegions_weightId_firstDimension_"+this.value).val()+":"+$("#distRegions_weightId_firstUnit_"+this.value).val();
			$("#firstUnit"+this.value+" option[value='"+v1+"']").attr("selected", true);
			var  additionalMoney = document.getElementById("additionalMoney" + this.value);
			additionalMoney.setAttribute("value", document.getElementById("distRegions_weightId_additionalMoney_" + this.value).value);
			var v2= $("#distRegions_weightId_additionalDimension_"+this.value).val()+":"+$("#distRegions_weightId_additionalUnit_"+this.value).val();
			$("#additionalUnit"+this.value+" option[value='"+v2+"']").attr("selected", true);
		});
	<#else>
		$("#distribution_regions").find("input[type=hidden][name^='distRegions_unitId_regionId_']").each(function(){
			$("#regionId"+this.value).attr("checked","checked");
			var  carriage = document.getElementById("carriage_" + this.value);
			carriage.setAttribute("value", document.getElementById("distRegions_unitId_carriage_" + this.value).value);
		});
	</#if>

</script>