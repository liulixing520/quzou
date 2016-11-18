<script language="javascript" src="/images/jquery/plugins/validate/lib/jquery.form.js" type="text/javascript"></script>
<script language='javascript'>
function submitProductLabForms(form){
try{
	if(validateForm(document.getElementById(form))==undefined){
	jQuery.ajax({
        url: jQuery("#"+form).attr("action"),
        type: 'POST',
        data:jQuery("#"+form).serializeArray(),
        error: function(msg) {
           alert(msg);
        },
        success: function(msg) {
			jQuery('#ProductLabDiv').html(msg);
			$('#ProductLabDiv').initUI();
			$.pdialog.closeCurrent();
    		alert('添加成功');
        }
    });
    }
    }catch(e){alert(e.message);}
}
</script>
<div>
    <div>
    <form method="post" action="<@ofbizUrl>createAjaxProductLab</@ofbizUrl>" name="createAjaxProductLab" id="createAjaxProductLab">
    	<input type="hidden" size="40" name="productId" value="${productId?if_exists}"/>
		<table width="100%" class="basic-table">
            <tr>
                <td height="28" class="border03 width15"><input type="text" size="40" name="labName" /></td>
                <td class="border02 width85"><a class="button" href="#" onclick="javascript:submitProductLabForms('createAjaxProductLab');"><span>添加</span></a></td>
            </tr> 
 		  </table>
        </form>
        </div>
</div>