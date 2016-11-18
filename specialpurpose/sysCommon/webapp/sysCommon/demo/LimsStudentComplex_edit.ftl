	<div class="pageContent" id="pageContent">
	<div id="screenlet-body" class="screenlet-body" layoutH="96">
	<form name="EditLimsStudentComplex" method="post" action="<#if entity??>updateLimsStudentComplex<#else>createLimsStudentComplex</#if>" 
		 id="<#if entity??>EditLimsStudentComplex<#else>CreateLimsStudentComplex</#if>" class="single_table"   >
			<input type="hidden" name="studentId" value="${studentId?if_exists}" />
			<input type="hidden" name="navTabId" value="FindLimsStudentComplex" />
			<input type="hidden" name="callbackType" value="closeCurrent" />
			<table class="single_table_style" cellspacing="0">
				<tbody>
				<tr class="">

					<td class=""><span>学生姓名</span></td>
					<td class="">
					<input name="studentName" class="required" type="text" value="<#if entity??>${entity.studentName?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				</tr>
				<tr class="">

					<td class=""><span>邮箱地址</span></td>
					<td class="">
					<input name="studentEmail" class="" type="text" value="<#if entity??>${entity.studentEmail?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				</tr>
				<tr class="">

					<td class=""><span>座位号</span></td>
					<td class="">
					<input name="seatNo" class=" number" type="text" value="<#if entity??>${entity.seatNo?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				</tr>
				<tr class="">

					<td class=""><span>出生年月</span></td>
					<td class="">
					<input name="birthDate" class="date" type="text" value="<#if entity??>${entity.birthDate?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				</tr>
				<tr class="">

				 <#assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"gender" })?if_exists>
					<td class=""><span>性别</span></td>
					<td class="">
					<select name="gender" class=""><option></option>
		            	<#if enums?has_content>
		            		<#list enums as enum> 
		            			<option <#if entity??&&entity.gender==enum.enumId>selected </#if>  value='${enum.enumId}'>${enum.description}</option>
		            		</#list>
		            	</#if>
		            </select>
					</td>
				</tr>
				<tr class="">

				 <#assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"sign" })?if_exists>
					<td class=""><span>星座</span></td>
					<td class="">
					<select name="sign" class=""><option></option>
		            	<#if enums?has_content>
		            		<#list enums as enum> 
		            			<option <#if entity??&&entity.sign==enum.enumId>selected </#if>  value='${enum.enumId}'>${enum.description}</option>
		            		</#list>
		            	</#if>
		            </select>
					</td>
				</tr>
				<tr class="">

								
								 
					<td class=""><span> 班级名称</span></td>
					<td class="">
					<select name="classIdNo" class="">
		            	<option value=""></option>
		            		<#list LimsClassList as relEntity>
		            			<option <#if relEntity??&&entity??&&entity.classIdNo??&&relEntity.classId==entity.classIdNo>selected </#if>  
		            			value='${relEntity.classId}'>
		            			${relEntity.className}</option>
		            		</#list>
		            </select>
		            </td>
				</tr>
			</tbody></table>
		</form>
		 </div> 
		<div class="formBar" >
			<ul>
			<li><a class="button"  onclick="javascript:submitFormsSimple('<#if entity??>EditLimsStudentComplex<#else>CreateLimsStudentComplex</#if>');"  ><span>保存</span></a></li>
				<li><div class="button"><div class="buttonContent"><button class="close" type="button">关闭</button></div></div></li>
			</ul>
		</div>  
	</div>
	