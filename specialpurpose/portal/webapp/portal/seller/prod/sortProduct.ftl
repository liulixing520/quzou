
<form name="form1" id='form1'  method="post" action="updateProductSort">
<input type='hidden' name='productId' value='${entity.productId}'>
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
			
					<table  class="basic-table" cellspacing="0">
		        		<tr class=""><td >名茶抢购</td><td ><input type='text' value='${entity.sort1!}' name='sort1'></td></tr>
		            	<tr class=""><td >热卖推荐</td><td ><input type='text' value='${entity.sort2!}' name='sort2'></td></tr>
		            	<tr class=""><td >猜你喜欢</td><td ><input type='text' value='${entity.sort3!}' name='sort3'></td></tr>
		            	<tr class=""><td >新品上架</td><td ><input type='text' value='${entity.sort4!}' name='sort4'></td></tr>
		            	<tr class=""><td >实惠多多</td><td ><input type='text' value='${entity.sort5!}' name='sort5'></td></tr>
    				</table>
			
		</div>
		<div class="buttonBarOuter">
    		<div class="buttonBar">
				<input type="button" onclick="javascript:submitDialogForm('form1');" class="input01" id="btn_save" value="保存" />
			</div>	
		</div>	
</div>	
</form>