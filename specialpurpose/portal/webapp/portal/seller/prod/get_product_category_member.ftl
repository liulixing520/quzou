<script language="javascript"> 
$("#add").bind("click", function () {
	var checkboxes = $("input:checked[type=checkbox][name=orderIndexs]");
    if (checkboxes.length == 0) {
		alert("请选择要添加的关联分类！");
		return;
	}
    var h='';
    checkboxes.each(function(){
    	 var idStr = (this.id).substring(11);
		 var pname = "categoryName_o_" + idStr; 
		 var v = this.value;
		 $("input[type=hidden][name=product_categorys]").each(function(){
			if($(this).attr("value") == v){
				$('#body_category input[name="product_categorys"][value="'+v+'"]').parents('tr:first').remove();
			}
		});
		h+='<tr>';
	    h+='    <td><input type=\'hidden\' name=\'product_categorys\' value='+v+' />&nbsp;&nbsp;'+ $("#"+pname).val();
	    h+='	<img src=\'/images/delete.gif\' width=\'16\' height=\'16\' onclick=\'delete_categorys('+v+',1)\'/></td>';
	    h+='</tr>';
     });
    $('#body_category').append(h);
    $.pdialog.closeCurrent();
    
});
</script>
<div class="formBar" >
	<ul>
	<li><a class="button" href="#" id="add"><span>添加</span></a></li>
	<li><a class="button" href="#" onclick='javascript:closeDialog();'><span>关闭</span></a></li>
	</ul>
</div> 