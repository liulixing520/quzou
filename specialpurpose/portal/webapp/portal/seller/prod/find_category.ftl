<table class="basic-table hover-bar" cellspacing="0" width="100%">
		<thead>
			<tr class='header-row-2'>
				<td width="400px">分类名称</td>
				<td width="60px">分类等级</td>
				<td width="60px">分类排序</td>
				<td style="text-align:center;width:120px">状态</td>
				<td style="text-align:center;width:60px">是否显示</td>
				<td style="width:60px">操作</td>
			</tr>
		</thead>
		<tbody>
		 <#list productCategoryList as productCategoryMap>
		 	<tr id="${productCategoryMap.catCode}" show="yes" name="name_${productCategoryMap.productCategory.productCategoryId}">
				<td style="padding-left:<#if productCategoryMap?? && productCategoryMap.lev!=1>${((productCategoryMap.lev-1)*28)}</#if>px">
				<img height=12 width=12 style="cursor:hand" <#if productCategoryMap.childCount gt 0>onclick="tree(this)"</#if> id="img_${productCategoryMap.catCode}" src="/images/-.gif"/>
				${productCategoryMap.productCategory.categoryName?if_exists}
				</td>
				<td style="text-align:center">${productCategoryMap.lev?if_exists}</td>
				<td style="text-align:center">${productCategoryMap.productCategory.sequenceNum?if_exists}</td>
				<#if Static["org.ofbiz.base.util.UtilValidate"].isDateBeforeNow(productCategoryMap.productCategory.thruDate)><td id="show_${productCategoryMap.productCategory.productCategoryId}" style="color:red; text-align:center">隐藏<#else><td id="show_${productCategoryMap.productCategory.productCategoryId}" style="text-align:center">显示</#if></td>
				<td style="text-align:center">
					<a id="a_${productCategoryMap.productCategory.productCategoryId}" href="#" <#if Static["org.ofbiz.base.util.UtilValidate"].isDateBeforeNow(productCategoryMap.productCategory.thruDate)>title="显示"<#else>title="隐藏"</#if> style="cursor:hand"><img <#if Static["org.ofbiz.base.util.UtilValidate"].isDateBeforeNow(productCategoryMap.productCategory.thruDate)>id="0"<#else>id="1"</#if> onclick="updateStatus('${productCategoryMap.productCategory.productCategoryId?if_exists}','${productCategoryMap.productCategory.prodCatalogCategoryTypeId?if_exists}','${productCategoryMap.productCategory.prodCatalogId?if_exists}','${productCategoryMap.productCategory.fromDate?if_exists}',this);" <#if Static["org.ofbiz.base.util.UtilValidate"].isDateBeforeNow(productCategoryMap.productCategory.thruDate)>src="/images/itea/delete.gif"<#else>src="/images/itea/face.gif"</#if> width="16" height="16"/></a>
				</td>
				<td><a rel='EditCategory' title="编辑"  href="<@ofbizUrl>EditCategory?productCategoryId=${productCategoryMap.productCategory.productCategoryId?if_exists}</@ofbizUrl>" class="btnEdit">编辑</a></td>
			</tr>
		 </#list>
			
		</tbody>
	</table>
<script language="javascript"> 	
function tree(t){
	var tt = t.parentNode.parentNode.parentNode;
	if(tt.show == "yes"){
		tt.show = "no";
		t.src = "/images/+.gif";
	}else{
		tt.show = "yes";
		t.src = "/images/-.gif";
	}
	$("tr[id^='" + tt.id + "']").each(function(){
		if(tt != this){
			if(tt.show == "yes"){
				this.show = "yes";
				$(this).show();
				$("#img_" + this.id)[0].src = t.src;
			}
			if(tt.show == "no"){
				this.show = "no";
				$(this).hide();
				$("#img_" + this.id)[0].src = t.src;
			}
		}	
	})
}
function stopBubble(e) {
	//如果提供了事件对象，则这是一个非IE浏览器
	if ( e && e.stopPropagation )
	    //因此它支持W3C的stopPropagation()方法
	    e.stopPropagation();
	else{
	    //否则，我们需要使用IE的方式来取消事件冒泡
	    if( window.event&&window.event.cancelBubble)
	    window.event.cancelBubble = true;
		}
}
function updateStatus(productCategoryId,prodCatalogCategoryTypeId,prodCatalogId,fromDate, t){
	stopBubble(window.event);
	s = t.id;
	if(s == 1){
		s = 0;
	}else{
		s = 1;
	}
	$.ajax({
		   type: "POST",
		   url: "deleteProductCategoryTree",
		   data: "productCategoryId="+productCategoryId+"&prodCatalogCategoryTypeId="+prodCatalogCategoryTypeId+"&prodCatalogId="+prodCatalogId+"&fromDate="+fromDate,
		   success: function(msg){
		   		if(s == 1 || s == "1"){
		   			t.src = "/images/itea/face.gif";
		   			$("#show_"+productCategoryId).html("显示");
		   			$("#show_"+productCategoryId).css("color","");
		   			$("#a_"+productCategoryId).attr("title","隐藏");
					$("#a_"+productCategoryId).css("color","red");
		   		}else{
		   			t.src = "/images/itea/delete.gif";
		   			$("#show_"+productCategoryId).html("隐藏");
		   			$("#show_"+productCategoryId).css("color","red");
		   			$("#a_"+productCategoryId).attr("title","显示");
		   			$("#a_"+productCategoryId).css("color","");
		   		}
		   		t.id=s;
		   }
		}); 
}
</script>