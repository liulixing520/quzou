
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">

        <form action="<@ofbizUrl>setCategoryRefTypeAttributeMutil</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm" id="productCategoryForm">
            <input type="hidden" name="productCategoryId" id="productCategoryId" value="${productCategoryId}"/>
			           
            <table cellspacing="0" class="table table-striped table-bordered table-hover dataTable no-footer" >
				  <tr>
				  <td>
				 <#list typeAttributeList as typeAttribute>
				 	
				 	<input type='checkbox'
				 	 <#list categoryRefTypeAttributeList as pfa>
				 	 <#if pfa.attributeId==typeAttribute.attributeId>
				 	 	checked
				 	 </#if>
				 	</#list>
				 	 name='attributeId'   value='${typeAttribute.attributeId}'>
				 
				 	${typeAttribute.attributeName!}  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 </#list>
				</td>
				</tr>
              
            
            </table>
            <div class="col-md-offset-3 col-md-9">
                <button class="btn btn-info" type="submit" name="submitButton">保存</button>
                &nbsp; &nbsp; &nbsp;
                <a href="/manage/control/CategoryTreeEn" <button="" class="btn" type="button">取消
                </a>
            </div>  
        </form>
    </div>
</div>
		