<script language="javascript"> 
$("#addConfig").bind("click", function () {
    var h='';
    var checkboxes = $("input:checked[type=checkbox][name=orderIndexs]");
    if (checkboxes.length == 0) {
		alert("请选择要添加的关联商品");
		return;
	}
	for (var i = 0, ci; ci = checkboxes[i]; i++){
		 var id = ci.id.substring(8);
		 var pname = "ListProductConfig_productName" + id; 
		 var pdesc = "ListProductConfig_description" + id;
		 $("input[type=hidden][name=product_assocs]").each(function(){
				if($(this).attr("value") == ci.value){
					$('#body_assoc input[name="product_configs"][value="'+ci.value+'"]').parents('tr:first').remove();
				}
			});
		 	h+='<tr rel="+i+" target="sid_user" class="">';
		    h+='	<td style="width: 120px;"><input name=\'input4\' type=\'button\' class=\'input02\' value=\'取消\' onclick="delete_configs(\''+ci.value+'\',1)"/>';
		    h+='    <input type=\'hidden\' name=\'product_configs\' value='+ci.value+' />  ';
		    h+='   </td>';
		  	h+='	<td style="width: 200px;">'+$("#"+pname).val()+'</td>';
	    	h+='	<td style="width: 200px;">'+$("#"+pdesc).val()+'</td>';
		    h+='</tr>';
	}
    $('#body_config').append(h);
    $.pdialog.closeCurrent();
    
});
</script>
<div class="formBar" >
	<ul>
	<li><a class="button" href="#" id="addConfig"><span>添加</span></a></li>
	<li><a class="button" href="#" onclick='javascript:closeDialog();'><span>关闭</span></a></li>
	</ul>
</div> 
