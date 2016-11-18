<div class="formBar" >
	<ul>
	<li><a class="button" href="#" onclick="javascript:addUserToDis();"><span>添加</span></a></li>
	<li><a class="button" href="#" onclick='javascript:closeDialog();'><span>关闭</span></a></li>
	</ul>
</div>  
<script type="text/javascript">
	function addUserToDis(){
		var checkboxes = $("input:checked[type=checkbox][name=orderIndexs]");
		if (checkboxes.length == 0) {
			alert("请选择要添加的用户名");
			return;
		}
		var hiddens = "";
		for (var i = 0, ci; ci = checkboxes[i]; i++){
			$("input[type=hidden][name=distRegions_user_"+ci.value+"]").each(function(){
				if($(this).attr("value") == ci.value){
					$("input[type=hidden][name=distRegions_user_"+ci.value+"]").remove();
				}
			});
			hiddens += "<input type='hidden' id='distRegions_user_"+ci.value+"' name='distRegions_user_"+ci.value+"' value='"+ci.value+"'/>";
		}
		$("#distribution_users").append(hiddens);
		$.pdialog.closeCurrent();
	}
	$(document).ready(function(){});
		$("#distribution_users").find("input[type=hidden][name^='distRegions_user_']").each(function(){
			var checkboxes = $("input:[type=checkbox][name=orderIndexs]");
			for (var i = 0, ci; ci = checkboxes[i]; i++){
				if($(this).attr("value") == ci.value){
					$("#"+ci.id).attr("checked","checked");
				}
			}
		});

</script>