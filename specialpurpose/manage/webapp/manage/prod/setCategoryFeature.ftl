
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">

        <form action="<@ofbizUrl>setProductFeatureCategoryApplMutil</@ofbizUrl>" method="post" style="margin: 0;" name="productCategoryForm" id="productCategoryForm" onsubmit="javascript:return checkCategoryName()">
            <input type="hidden" name="productCategoryId" id="productCategoryId" value="${productCategoryId}"/>
			           
            <table cellspacing="0" class="table table-striped table-bordered table-hover dataTable no-footer" >
				 
				  <tr>
				  <td>
				 <#list productFeatureCategoryList as productFeatureCategory>
				 	
				 	<input type='checkbox'
				 	 <#list productFeatureCategoryApplList as pfa>
				 	 <#if pfa.productFeatureCategoryId==productFeatureCategory.productFeatureCategoryId>
				 	 	checked
				 	 </#if>
				 	</#list>
				 	 name='productFeatureId'   value='${productFeatureCategory.productFeatureCategoryId}'>
				 
				 	${productFeatureCategory.description!}  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
		