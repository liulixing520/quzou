<div class="formBar" >
		<ul>
		<li><a class="button" id='addButton' href="#" onclick="javascript:addProToOrder();"  ><span>添加</span></a></li>
		<li><a class="button" href="#" onclick='javascript:closeDialog();'><span>关闭</span></a></li>
		</ul>
				
	</div>  
<script language='javascript'>
function addProToOrder(){
		var flag = 'N';
		$("input[type=text][name^='quantity_']").each(function(){
			if($(this).val()!="")flag = 'Y';
		});
		if(flag == 'N'){
			alert('请选择商品');
			return false;
		}
		document.getElementById('addButton').disable=true;
		jQuery.ajax({
	    	        url: jQuery("#LookupBulkAddProducts").attr("action"),
	    	        type: 'POST',
	    	        async: false,
	    	        data:jQuery("#LookupBulkAddProducts").serializeArray(),
	    	        error: function(json) {
	    	           //alert(msg);
	    	        },
	    	        success: function(json) {
	   					//alert(json.message); 因为直接调用原ofbiz代码-无返回消息
	   					if(json._ERROR_MESSAGE_){
	   						alert(json._ERROR_MESSAGE_);
	   					}else{
	   						alert('操作成功');
	   					}
	   					//DWZ.msg("添加成功")
	    	        }
	    	    });
	   document.getElementById('addButton').disable=false; 	  
	   closeDialog();
}
</script>	