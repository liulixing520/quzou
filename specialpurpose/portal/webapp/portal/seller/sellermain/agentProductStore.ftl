 
 <div class="rtab-warp" id="newGuideTarget2" style="padding-left:15px; padding-top:5px;">
    <ul class="nav-tabs" style="padding-top:10px; padding-bottom:20px; border:none;">
        <li class="current" id="li1"><a href="/portal/control/agentProductStore"> <span id="shelfProductNum"> 未签约分销商家&nbsp; </span> </a></li>
        <li id="ORDER_CREATED"><a href="/portal/control/agentProductStore?agent=Y"> <span id="shelfProductNum"> 已签约分销商家&nbsp; </span> </a></li>
    </ul>
    <div class="propbox tipstion">
    </div>
</div>
       <div class="listheight" style="height:75%; width:100%; overflow-y: auto;">      
                        <table id="sample-table-2"
                               class="table-bordered"
                               role="grid" aria-describedby="sample-table-2_info" align="center">
                           
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    店铺名称
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    签约时间
                                </th>
                               
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="" style="text-align:center;">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            
                            <tbody>
						 		<#if storeList?has_content>
						        <#list storeList  as store>
	                                <tr class="odd">
	                                     <td style="text-align:center;">${store.storeName!}</td>
	                                     <td style="text-align:center;">${store.lastUpdatedStamp!}</td>
	                                     <td>
		                                     <div class="hidden-sm hidden-xs action-buttons" style="text-align:center;">
		                                     	<a href='agentProductStoreSave?productStoreId=${store.productStoreId}'>签约</a>
		                                     </div>
	                                     </td>
	                                </tr>
                                </#list>
                                </#if>	
                            </tbody>
                            
                        </table>
                        
</div>

