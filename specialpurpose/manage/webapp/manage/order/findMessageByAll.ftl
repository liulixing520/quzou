       <div class="listheight" style="height:75%; width:100%; overflow-y: auto;">      
                        <table id="sample-table-2"
                               class="table table-striped table-bordered table-hover dataTable no-footer"
                               role="grid" aria-describedby="sample-table-2_info" align="center">
                           
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    公告标题
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    公告内容
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="" style="text-align:center;">
                                    公告时间
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="" style="text-align:center;">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            
                            <tbody>
						 		<#if messageList?has_content>
						        <#list messageList as messagelist>
	                                <tr class="odd">
	                                     <td style="text-align:center;">${(messagelist.messageTitle)!}</td>
	                                     <td style="text-align:center;">
	                                     <#if messagelist.messageContent?length gt 100>${(messagelist.messageContent[0..100])?if_exists}..<#else>${messagelist.messageContent?if_exists}</#if>
	                                     </td>
	                                     <td style="text-align:center;">${(messagelist.lastUpdatedStamp)!}</td>
	                                     <td>
		                                     <div class="hidden-sm hidden-xs action-buttons" style="text-align:center;">
		                                     <a class="green" href="<@ofbizUrl>manage_findMessageByOne</@ofbizUrl>?messageId=${(messagelist.messageId)!}"> <image src="../../portal/images/cc_.jpg"> </a>
		                                     </div>
	                                     </td>
	                                </tr>
                                </#list>
                                </#if>	
                            </tbody>
                            
                        </table>
                        
</div>

