<table class="table" width="100%" layoutH="78">
	<thead>
		<tr>
			<td>操作</td>
			<td>地区名称</td>
			<td>排序</td>
			<td>地区码</td>
		</tr>
	</thead>
	<tbody>
	  <#if geoList??&&geoList?size gt 0>
        <#list geoList as geo>
          <tr class="border_tr <#if geo_index%2==0>background_tr</#if>" id="${geo.geoId!}" regionPath=",${geo.geoId!}," status="close">
            <td class="width20" style="border-left:none">
              <a rel='EditRegion' title="编辑"  href="<@ofbizUrl>EditRegion?geoId=${geo.geoId?if_exists}</@ofbizUrl>" class="btnEdit">编辑</a>
			  <a rel='EditRegion' title="添加子地区"  href="<@ofbizUrl>EditRegion?pGeoId=${geo.geoId?if_exists}</@ofbizUrl>" class="btnAdd">添加子地区</a>
			  <a title="删除" href="#" onclick="deleteSysRegions('${geo.geoId!}')"><img src="/images/itea/delete.gif"></a>
			</td>
            <td class="width30">
              <span style="cursor:hand" onclick="showChildRegions1('${geo.geoId}',',${geo.geoId},',1)">${geo.geoName!}</span>
            </td>
            <td class="width20">
              ${geo.sequenceNum!}
            </td>
            <td class="width10" style="border-right:none">${geo.geoCode!}&nbsp;</td>
          </tr>
        </#list>
      <#else>
    	  <tr class="border_tr">
            <td colspan="10" style="border-left:none;text-align:center;border-right:none; " >没有地区</td>
          </tr>
      </#if>
	</tbody>
</table>
<script language="javascript"> 
function showChildRegions1(id,regionPath,regionGrade){
	var status=$("#"+id).attr("status");
	if(status == "close"){
		$("#"+id).attr("status","open");
	}else if(status == "open"){
		$("#"+id).attr("status","close");
		var a = $("#"+id).attr("regionPath");
		$("tr[regionPath!='"+a+"'][regionPath^='"+a+"']").remove();
		return;
	}
	$.getJSON("<@ofbizUrl>/getChildGeos</@ofbizUrl>", {"parentGeoId": id,"regionPath": regionPath,"regionGrade":regionGrade}, function (data) {
		var h = "";
		if (data.length == 0) {
		} else {
			for (var i = 0, ci; ci = data.data[i]; i++) {
				h += "<tr id='"+ ci.geo.geoId+"' regionPath='"+ci.regionPath+"' class='border_tr' status='close'>";
				h += "  <td class='width20' style='border-left:none'>";
				h += "    <div><a rel='EditRegion' title='编辑' target='navTab' href='<@ofbizUrl>EditRegion?geoId="+ci.geo.geoId+"</@ofbizUrl>' class='btnEdit'>编辑</a>";
				if(ci.regionGrade!=3)
				h += "    <a rel='EditRegion' title='添加子地区' target='navTab' href='<@ofbizUrl>EditRegion?pGeoId="+ci.geo.geoId+"</@ofbizUrl>' class='btnAdd'>添加子地区</a>";
				h += "     <a  href='#' onclick=\"deleteSysRegions('"+ci.geo.geoId+"')\"><img src='/images/itea/delete.gif'></a>";
				h += "  </div></td>";
				h += "  <td class='width30' style='padding-left:"+(ci.regionGrade-1)*20+"px'>";
				h += "    <span style='cursor:hand' onclick=\"showChildRegions1('"+ci.geo.geoId+"','"+ci.regionPath+"',"+ci.regionGrade+")\">"+ci.geo.geoName+"</span>";
				h += "  </td>";
				h += "  <td class='width20'>";
				h += "    "+(ci.geoAssoc.sequenceNum==null?"":ci.geoAssoc.sequenceNum);
				h += "  </td>";
				h += "  <td class='width20' style='border-right:none'>"+(ci.geo.geoCode==null?"":ci.geo.geoCode)+"&nbsp;</td>";
				h += "</tr>";
				$("#"+id).after(h);
				$("#"+ci.geo.geoId).initUI();
				h = "";
			}
		}
	});
}
function deleteSysRegions(geoId){
	var deletingRegionPath = $("#"+geoId).attr("geoId");
	if(confirm("确定要删除吗?(有子地区的不能删除)")){
		$.ajax({
			type:"post",
			dataType:"json",
			url:"deleteRegion",
			data:"geoId="+geoId,
			complete:function(){},
			success:function(msg){
				if(msg){
					if(deletingRegionPath == null || deletingRegionPath == ""){
						$("#"+geoId).remove();
					}else{
						$("tr[regionPath^='"+deletingRegionPath+"']").remove();
					}
					alert("删除成功");
				}
			}
		});
	}
}
</script>