
     <div class="content profile">
            <h2 class="title" style='font-size:20px'>我的咨询</h2>
            <div class="profile_detail clearfix">
         <div> 
          <table class="points_table tab_content" cellspacing="0" width="100%">
           <tbody> 
            <tr class="header-row-2"> 
             <td> <label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
             <td> <a class="sort-order" href="">${uiLabelMap.DateCf}</a> </td> 
             <td> <a class="sort-order" href="">${uiLabelMap.ShopNameCf}</a> </td> 
             <td> <a class="sort-order" href="">${uiLabelMap.QuestionDateCf}</a> </td> 
             <td> <a class="sort-order" href="">${uiLabelMap.ContentCf}</a> </td> 
             <td> <a class="sort-order" href="">${uiLabelMap.OperatingCf}</a> </td> 
            </tr> 
            <#if curList?has_content>
                  <#list curList as cur>
                    <tr> 
		             <td class="center"><label class="position-relative">
		              <input type="checkbox" class="ace" /> 
		              <span class="lbl"></span> </label> 
		              </td> 
		             <td>${cur.createdDate!}</td> 
		             <#if proList?has_content>
                         <#list proList as pro>
                             <#if (pro.productStoreId==cur.productStoreId)>
		                       <td>${pro.storeName!}</td> 
		                     </#if>
		                </#list>
                       </#if>
		             <td class="hidden-480">${cur.custRequestDate!}</td> 
		             
		               <#if curListItem?has_content>
                         <#list curListItem as curit>
                             <#if (cur.custRequestId==curit.custRequestId)>
		                       <td>${curit.story!}</td> 
		                     </#if>
		                </#list>
                       </#if>
                       
		             <td> <a class="blue" href="/portal/control/user_reviewDetail?custRequestId=${cur.custRequestId!}&productStoreId=${cur.productStoreId!}"> ${uiLabelMap.CheckWithTheOperatingCf} </a></td> 
		            </tr> 
                 </#list>
             </#if>
           </tbody> 
          </table> 
         </div> 
    </div>
  