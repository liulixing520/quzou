 <link href="../seller/css/skin4.css" rel="stylesheet" type="text/css" />
  <link href="../seller/css/seller.css" rel="stylesheet" type="text/css" /> 
  <link href="../seller/css/general_popup_box.css" rel="stylesheet" type="text/css" /> 
  <link href="../seller/css/activity-manage201409.css" rel="stylesheet" type="text/css" /> 
  <style type="text/css">
  #right{float:left; width:auto; padding-left:6px;} 
  </style>
  <script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>交易</li><li class='active'>客户咨询</li><li class='active'>客户咨询详情</li>");
	}); 
  </script>
  <div class="content"> 
   <div class="layout clearfix"> 
    <div class="col-main"> 
     <div class="col-main-warp"> 
      <div id="right"> 
       
        <div class="activity-list-warp"> 
                		          <#if curList?has_content>
                         <#list curList as cur>
        		                  <div class="activity-list"> 
					          <div class="activity-detail"> 
					           <dl> 
					            <dt>
					             	买家询问：
					            </dt> 
					            <dd>
					           
					            </dd>
					            <dt>
					            </dt>
					            <dd>
					            	<span class="countdown">时间：<strong class="setcountdown" starttime="1421121600000">
					            	${cur.lastUpdatedStamp!}</strong></span>
					            </dd> 
					           </dl> 
					           <dl class="activity-requirement"> 
					            <dt>
					             
					            </dt> 
					            <dd>
					              ${cur.story!}
					            </dd> 
					           </dl> 
					
					
					          </div> 
					         </div> 
        
                      </#list>
         </#if>

      <#if comLists?has_content>
         <#list comLists as coms> 
              <#if (coms.roleTypeIdFrom??&&coms.roleTypeIdFrom=="seller")>
			         <div class="activity-list"> 
			          <div class="activity-detail"> 
			           <dl> 
			            <dt>
			             	卖家回答：
			            </dt> 
			            <dd>
			           
			            </dd>
			            <dt>
			            </dt>
			            <dd>
			            	<span class="countdown">时间：<strong class="setcountdown" starttime="1421121600000">
			            	${coms.entryDate!}</strong></span>
			            </dd> 
			           </dl> 
			           <dl class="activity-requirement"> 
			            <dt>
			             
			            </dt> 
			            <dd>
			              ${coms.content!}
			            </dd> 
			           </dl> 
			
			
			          </div> 
			         </div> 
			 <#elseif (coms.roleTypeIdFrom??&&coms.roleTypeIdFrom=="customer") >         
			        <div class="activity-list"> 
			          <div class="activity-detail"> 
			           <dl> 
			            <dt>
			             	买家回答：
			            </dt> 
			            <dd>
			           
			            </dd>
			            <dt>
			            </dt>
			            <dd>
			            	<span class="countdown">时间：<strong class="setcountdown" starttime="1421121600000">
			            	${coms.entryDate!}</strong></span>
			            </dd> 
			           </dl> 
			           <dl class="activity-requirement"> 
			            <dt>
			             
			            </dt> 
			            <dd>
			              ${coms.content!}
			            </dd> 
			           </dl> 
			
			
			          </div> 
			         </div>  
			         
			    <#else>	    
				    <!--没有数据-->     
		         </#if>       
			         
                     </#list>
         </#if> 
         
        <form id="actyform" action="<@ofbizUrl>subStoreProductAdvisory</@ofbizUrl>" method="post">  
         <div>
         <br/>
         	 <textarea id="content" name="content" rows="10" style="width:600px; margin-left:110px;"></textarea>
         	         <div class="autpost-con02 clearfix" style="margin-bottom:50px; margin-left:366px;"> 
          <span>
          <!-- 卖家  这里获取的是 登录的卖家 10200-->
          <input value="${(userLogin.partyId)!}"  id="partyIdFrom" name="partyIdFrom" type="hidden"> 
          <!-- 买家 -->
          <input value="${(parameters.fromPartyId)!}"  id="partyIdTo" name="partyIdTo" type="hidden"> 
          
          <input value="${(parameters.custRequestId)!}"  id="parentCommEventId" name="parentCommEventId" type="hidden"> 
          
          <!--卖家回复标示-->
          <input value="seller"  id="roleTypeIdFrom" name="roleTypeIdFrom" type="hidden"> 
          
          <input type="submit" class="smallSubmit" value="回复" /></span> 
        </div>
        </form> 
         	 <br/>
         <div>
        </div>
        <div>
        
        </div> 
      
      </div> 
     </div> 
    </div> 

 