<div class="screenlet">
    <form method="post" action="<@ofbizUrl><#if entity??>updateDxSupplierProtocol<#else>createDxSupplierProtocol</#if></@ofbizUrl>" id="EditProductStore"
          name="EditProductStore" novalidate="novalidate">
        <input type="hidden" name="supplierStoreId"   value="${parameters.supplierStoreId!}">
        <input type="hidden" name="dxStoreId"   value="${parameters.dxStoreId!}">

            <h3>签约</h3>
        </div>
        
       
        <div class="screenlet-body">
            <table class="basic-table">
                <tbody> 
                <tr>
                    <td class="label">签约内容：</td>
                    <td>
                    	<textarea rows="2"   cols="60" id="protlcalContent" name="protlcalContent" ><#if entity??>${(entity.protlcalContent)!}</#if></textarea>
                </tr>
               <tr>
                    <td>&nbsp;</td>
                    <td>
                    	<input value="保 存" class="btn btn-info" type="submit">&nbsp;&nbsp;&nbsp;
                    </td>
                    
                </tr>
            </table>
        </div>
    
    
 </form>
</div>

