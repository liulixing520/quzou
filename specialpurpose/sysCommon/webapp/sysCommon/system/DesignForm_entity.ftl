<script language='javascript'>
	function selectedEntity(selectIdValue,selectNameValue){
			var oEditor = parent.editor;
		    var value = selectNameValue+":<input type='text' name='"+selectIdValue+"'value='"+selectIdValue+"' >";
		    alert(value);
		    // Check the active editing mode.
		    if ( oEditor.mode == 'wysiwyg' )
		    {
		        oEditor.insertHtml( value );
		    }
		    else
		       alert( 'You must be in WYSIWYG mode!' );
		closeDialog('dialog');
	}
	
	function selectedRef(entityName){
		$.ajax({
					type:"post",
					datatype:"json",
					url:"getEntityFiled?entityName="+entityName,
					cache:false,
					success:function(result){
						var  tableHtml="<table class='basic-table hover-bar'><tr class='header-row'><td>全选</td><td>字段</td></tr>";
						for(var i=0;i<result.fieldList.length;i++){
							var filed=result.fieldList[i];
							tableHtml+="<tr><td><a href='#' onclick=\"javascript:selectedEntity('"+filed.name+"','"+filed.description+"');\">"+filed.description+"</a><td></tr>";
						}
						tableHtml+="</table>";
						$("#girdDiv").html(tableHtml);
					}
				});	
	}
</script>
<div>
<form action="jeecgDemoController.do?saveCkeditor" method="post" id="myCkeditorForm">
<select name="entityName" id="entityName" onchange='selectedRef(this.value)'><option value=""></option>
<#list requestAttributes.entitiesList as entity>
<option value='${entity.entityName}'>${entity.title}<option>
</#list>
</select>

<div id='girdDiv'></div>
</form>		
<div class="buttonBarOuter"> 
    		<div id='toolBar' class="buttonBar">
				<a class="l-btn"  onclick="selectedEntity('','name')" >
					<span class="l-btn-left">
						<span class="l-btn-text icon-save l-btn-icon-left">
							保存
						</span>
					</span>
				</a>
				<a class="l-btn" onclick="javascript:window.history.back();" href="javascript:void(0);">
					<span class="l-btn-left">
						<span class="l-btn-text icon-no l-btn-icon-left">
							关闭
						</span>
					</span>
				</a>
    		</div>
		</div>
</div>
	