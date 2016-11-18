
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">

        <form action="<@ofbizUrl>setCategoryRefAttributeGroupMutil</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm" id="productCategoryForm">
            <input type="hidden" name="productCategoryId" id="productCategoryId" value="${productCategoryId}"/>
			           
            <table cellspacing="0" class="table-bordered" >
				 
				  <tr>
				  <td>
				 <#list typeAttributeGroupList as typeAttributeGroup>
				 	
				 	<input type='checkbox'
				 	 <#list categoryRefAttributeGroupList as pfa>
				 	 <#if pfa.attributeGroupId==typeAttributeGroup.attributeGroupId>
				 	 	checked
				 	 </#if>
				 	</#list>
				 	 name='attributeGroupId'   value='${typeAttributeGroup.attributeGroupId}'>
				 
				 	${typeAttributeGroup.attributeGroupName!}  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 </#list>
				</td>
				</tr>
              
            
            </table>
            <div class="col-md-offset-3 col-md-9">
                <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                &nbsp; &nbsp; &nbsp;
                <a href="setCategoryFeature" <button="" class="btn" type="button">取消
                </a>
            </div>  
        </form>
    </div>
</div>
		