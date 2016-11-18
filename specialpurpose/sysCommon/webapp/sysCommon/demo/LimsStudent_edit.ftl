<@htmlTemplate.navTitle titleProperty/>
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
	<form name="EditLimsStudent" method="post" action="<#if entity??>updateLimsStudent<#else>createLimsStudent</#if>" 
		 id="EditLimsStudent" class="single_table"   >
			<input type="hidden" name="studentId" value="${studentId?if_exists}" />
			<table class="basic-table" cellspacing="0">
				<tbody>
				<tr>
					<td class="label"><span>学生姓名</span></td>
					<td >
					<input name="studentName" class="required" type="text" value="<#if entity??>${entity.studentName!}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				
					<td class="label"><span>邮箱地址</span></td>
					<td >
					<input name="studentEmail" class="required email" type="text" value="<#if entity??>${entity.studentEmail?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				</tr>
				<tr>
					<td class="label"><span>座位号</span></td>
					<td >
					<input name="seatNo" class="number" type="text" value="<#if entity??>${entity.seatNo?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				
					<td class="label"><span>出生年月</span></td>
					<td >
					<#assign birthDate="">
					<#if entity??&&entity.birthDate??><#assign birthDate=entity.birthDate></#if>
					<@htmlTemplate.renderDateField name="birthDate"  title="Format: yyyy-MM-dd" value="${birthDate!}" event="onchange" action="alertDialog(this.value)" className="required" readonly="true"/>
					</td>
					</td>
				</tr>
				<tr>
					<#assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"DOCUMENT_TYPE" })?if_exists>
					<td class="label"><span>性别</span></td>
					<td >
					<select name="gender" ><option></option>
		            	<#if enums?has_content>
		            		<#list enums as enum> 
		            			<option <#if entity??&&entity.gender??&&entity.gender==enum.enumId>selected </#if>  value='${enum.enumId!}'>${enum.description!}</option>
		            		</#list>
		            	</#if>
					  </select>
					</td>
				
					<td class="label"><span>星座</span></td>
					<td >
					<input name="sign" class="" type="text" value="<#if entity??>${entity.sign?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				</tr>
				<tr>
					<td class="label"><span> 班级名称</span></td>
					<td >
					<select name="classId">
		            	<option value=""></option>
		            		<#list LimsClassList as relEntity>
		            			<option <#if relEntity??&&entity??&&entity.classId??&&relEntity.classId==entity.classId>selected </#if>  
		            			value='${relEntity.classId}'>
		            			${relEntity.className}</option>
		            		</#list>
		            </select>
		            </td>
				
					<td class="label"><span>女朋友</span></td>
					<td >
					<@htmlTemplate.lookupField value='' formName="EditLimsStudent" showDescription="true" name="girlPartyId"  fieldFormName="LookupPerson"/>
					</td>
				</tr>
				<tr>
					<td class="label"><span>多/单选人员</span></td>
					<td >
						<input type='text' name='gggName'  id='gggName' >
						<input type='hidden' name='gggPartyId'  id='gggPartyId' >
						<a href='#' onclick="javascript:selectCheckallPerson('gggPartyId','gggName','N','10007')">选择</a>
					</td>
					<td class="label"><span>多/单选部门</span></td>
					<td >
						<input type='text' name='ggpName'  id='ggpName' >
						<input type='hidden' name='ggpPartyId'  id='ggpPartyId' >
						<a href='#' onclick="javascript:selectCheckallPartyGroup('ggpPartyId','ggpName','N')">选择</a>
					</td>
				</tr>		
				<tr>
					<td class="label"><span>多/单选人员-复杂查询</span></td>
					<td >
						<input type='text' name='gName'  id='gName' >
						<input type='hidden' name='gPartyId'  id='gPartyId' >
						<a href='#' onclick="javascript:selectCheckallPersonMutil('gPartyId','gName','N')">选择</a>
					</td>
					<td class="label"><span>多/单选本部门人员</span></td>
					<td >
						<input type='text' name='gppName'  id='gppName' >
						<input type='hidden' name='gppPartyId'  id='gppPartyId' >
						<a href='#' onclick="javascript:selectMyDepartmentPerson('gppPartyId','gppName','N')">选择</a>
					</td>
				</tr>		
				<tr>
					<td class="label"><span>多选班级</span></td>
					<td >
						<input type='text' name='mutilClassName'  id='mutilClassName' >
						<input type='hidden' name='mutilClassId'  id='mutilClassId' >
						<a href='#' onclick="javascript:selectMutilCommon('SelectMutilClass','mutilClassId','mutilClassName');">选择</a>
					</td>
					<td class="label"></td>
					
				</tr>		
			</tbody></table>
			
		</form>
		 </div> 
		 <@htmlTemplate.submitButton formId="EditLimsStudent"  dialogId="${parameters.dialogId!}" submitJs="${submitJs!}" oper="${parameters.oper!}" backHref="${parameters.backHref!}"/>
		
		
	</div>
	