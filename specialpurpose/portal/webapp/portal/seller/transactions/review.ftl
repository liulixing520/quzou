
     <div class="content profile">
            <h2 class="title" style='font-size:20px'>客户咨询</h2>
            <div class="profile_detail clearfix">
         <div> 
          <table cellspacing="0" class="table-bordered"> 
           <tbody> 
            <tr class="header-row-2"> 
              <td> <label class="position-relative"> <input type="checkbox" class="ace" /> <span class="lbl"></span> </label> </td> 
             <td> <a class="sort-order" href="">日期</a> </td> 
             <td> <a class="sort-order" href="">客户名</a> </td> 
             <td> <a class="sort-order" href="">内容</a> </td> 
             <td> <a class="sort-order" href="">操作</a> </td> 
            </tr> 
            <#if curList?has_content>
                <#list curList as cur>
		            <tr> 
		             <td class="center"><label class="position-relative">
		              <input type="checkbox" class="ace" /> 
		              <span class="lbl"></span> </label> 
		              </td> 
		             <td>${cur.createdDate!}</td> 
		              <#if perListItem?has_content>
                         <#list perListItem as per>
                             <#if (per.partyId==cur.fromPartyId)>
		                       <td>${per.firstName!} ${per.lastName!}</td> 
		                     </#if>
		                </#list>
                       </#if>
		            <#--  <td class="hidden-480">${cur.custRequestTypeId!}</td>  -->
		             
		            <#--   <#if curListItem?has_content>
                         <#list curListItem as curit>
		              <td>${curit.story!}</td> 
		                </#list>
                       </#if> -->
                       
                       	<#if curListItem?has_content>
                         <#list curListItem as curit>
                             <#if (cur.custRequestId==curit.custRequestId)>
		                       <td>${curit.story!}</td> 
		                     </#if>
		                </#list>
                       </#if>
		             <td> <a class="blue" href="/portal/control/reviewDetail?fromPartyId=${cur.fromPartyId!}&custRequestId=${cur.custRequestId!}"> 查看与操作</a></td> 
		            </tr> 
                </#list>
             </#if>
           </tbody> 
          </table> 
         </div> 
    </div>
  