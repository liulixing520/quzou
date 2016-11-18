 <link href="../seller/css/skin4.css" rel="stylesheet" type="text/css" />
 <link href="../seller/css/seller.css" rel="stylesheet" type="text/css" /> 
 <link href="../seller/css/general_popup_box.css" rel="stylesheet" type="text/css" /> 
 <link href="../seller/css/activity-manage201409.css" rel="stylesheet" type="text/css" /> 
 
  <style type="text/css">
  #right{float:left; width:auto; padding-left:6px;} 
  </style>
  
  <div class="content"> 
   <div class="layout clearfix"> 
   
    <div class="col-main"> 
     <div class="col-main-warp"> 
      <div id="right">
       
       <form id="actyform" action="<@ofbizUrl>subProductAdvisoryToSeller</@ofbizUrl>" method="post"> 

         <div class="activity-list"> 
          <div class="activity-detail"> 
           <dl> 
            <dt>
             	卖家名称：
            </dt> 
            <dd></dd>
            
            <dt></dt>
            <dd>
            	<span class="countdown"><strong class="setcountdown">
            	 <#if proList?has_content>
                   <#list proList as pro> 
            	       ${(pro.storeName)!}
            	   </#list>
            	</#if>
            	</strong></span>
            </dd> 
            
           </dl> 

          </div> 
         </div> 


         <div>
         <br/>
         	 <textarea id="story" name="story" rows="10" style="width:600px; margin-left:110px;"></textarea>
         	     <div class="autpost-con02 clearfix" style="margin-bottom:50px; margin-left:366px;"> 
             <span>
             
              <!--RF_PRODINFO  区分 作用 -->
              <input value="RF_PRODINFO"  id="custRequestTypeId" name="custRequestTypeId" type="hidden" >
               
              <!--卖家的ID 或者说是店铺的ID--> 
              <input value="${(parameters.productStoreId)!}"  id="productStoreId" name="productStoreId" type="hidden" >
              <!--买家的ID--> 
              <input value="${(userLogin.partyId)!}"  id="fromPartyId" name="fromPartyId" type="hidden"> 
               <!--商品的ID--> 
              <input value="${(parameters.productId)!}"  id="productId" name="productId" type="hidden"> 
           
               <input type="submit" class="smallSubmit" value="提交" />
             </span> 
         </div>
         <br/>
         <div>
        </div>
        <div>
        
        </div> 
       </form> 
       
       
      </div> 
   </div> 
</div> 
    
    
    
    

 