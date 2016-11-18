<div class="row-fluid sortable">
	<div class="box span12">
		<div class="box-content">
<div class="pageContent" id="pageContent">
	<div class="screenlet-body" id="screenlet-body">
	<legend>${titleProperty!}</legend>
	<form name="EditLimsClass" method="post" action="<#if entity??>updateLimsClassFile<#else>createLimsClassFile</#if>" 
		 id="EditLimsClass" class="single_table"  enctype="multipart/form-data" >
			<input type="hidden" name="classId" value="${classId?if_exists}" />
			<table class="basic-table" cellspacing="0">
				<tbody>
				<tr>
					<td class="label"><span>班级名称</span></td>
					<td >
					<input name="className" class="" type="text" value="<#if entity??>${entity.className?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				</tr>
				<tr>
					<td class="label"><span>班主任</span></td>
					<td >
					<input name="classTeacher" class="" type="text" value="<#if entity??>${entity.classTeacher?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
					</td>
				</tr>
				<tr>
					<td class="label"><span>班次</span></td>
					<td >
					<input name="sortNo" class=" number"  type="text" value="<#if entity??>${entity.sortNo?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if>/>
					</td>
				</tr>
			<#if entity??>
				<tr>
					<td class="label"><span>附件查看</span></td>
					<td >
					<@htmlTemplate.fileLink documentPurpose="LimsClass"  entityIdValue="${entity.classId}"/>
					</td>
				</tr>
			</#if>
				</tr>
				<tr>
					<td class="label"><span>附件</span></td>
					<td >
					<input type="file" name="filePath" />
					</td>
			</tr>
			</tbody></table>
		</form>
		 </div> 
		  <@htmlTemplate.submitButton formId="EditLimsClass"  dialogId="${parameters.dialogId!}" submitJs="${submitJs!}" oper="${parameters.oper!}" backHref="${parameters.backHref!}"/>
		
	</div>
				 </div> 
	 </div> 
</div>
	