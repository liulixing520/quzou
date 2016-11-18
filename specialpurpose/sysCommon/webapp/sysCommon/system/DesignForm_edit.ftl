<@htmlTemplate.navTitle titleProperty/>
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
	<script type="text/javascript" src="/sysCommon/images/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="/sysCommon/images/ckeditor/plugins/entitybutton/plugin.js"></script>
	<script type="text/javascript">
	 function goForm() {
		 $('#myCkeditorForm').form('submit', {
				url : "jeecgDemoController.do?saveCkeditor",
				dataType:"json",
				success : function(data) {
					var mydata = eval("("+data+")");
					alert(mydata.msg);
				}
		});
     }
	</script>

<form action="jeecgDemoController.do?saveCkeditor" method="post" id="myCkeditorForm">
		<table class='basic-table'>
		<input type="hidden" value="" name="id"/>
		<textarea cols="80" id="editor1" name="contents" rows="20" onmouseup="getId()">
			${contents!}
		</textarea>
		<script>

			// This call can be placed at any point after the
			// <textarea>, or inside a <head><script> in a
			// window.onload event handler.

			// Replace the <textarea id="editor"> with an CKEditor
			// instance, using default configurations.
			
			var editor = CKEDITOR.replace( 'editor1');
			

		</script>
		</table>
	</form>
		<div class="buttonBarOuter"> 
    		<div id='toolBar' class="buttonBar">
				<a class="l-btn"  onclick="submitForm('EditLimsStudent')" >
					<span class="l-btn-left">
						<span class="l-btn-text icon-save l-btn-icon-left">
							保存
						</span>
					</span>
				</a>
				<a class="l-btn" onclick="javascript:window.history.back();" href="javascript:void(0);">
					<span class="l-btn-left">
						<span class="l-btn-text icon-no l-btn-icon-left">
							返回
						</span>
					</span>
				</a>
    		</div>
		</div>
</div>
	