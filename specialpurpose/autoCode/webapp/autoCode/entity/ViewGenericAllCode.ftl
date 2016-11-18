<div>
<#assign entityTitle=requestAttributes.selectEntityName>
<#assign projectName='lims'>
<#assign modelNameLower='lims'>
<#assign modelNameLower='lims'>
<#assign entityTitle='lims'>
    
<div>
<h2>拷贝代码至项目下后,运行 ant load-demo ||ant start <a href=''>详细说明</a></h2>
<h2>controller.xml [lims\webapp\${projectName}\WEB-INF\${modelNameLower}-controller.xml]<button onclick="copyCode('area1');return false;">复制</button></h2>	
<textarea cols='130' rows='15' id='area1'>
	<!--${entityTitle!}-->
	<request-map uri="Find${entityName}">
		<security https="false" auth="true" />
		<response name="success" type="view" value="Find${entityName}" />
	</request-map>
	<request-map uri="Edit${entityName}">
		<security https="false" auth="true" />
		<response name="success" type="view" value="Edit${entityName}" />
	</request-map>
	<request-map uri="create${entityName}">
    	<security https="false" auth="true"/>
	    <event type="service" invoke="create${entityName}"/>
	    <response name="success" type="request" value="json" />
        <response name="error" type="request" value="json" />
    </request-map>
    <request-map uri="update${entityName}">
        <security https="false" auth="true"/>
        <event type="service" invoke="update${entityName}"/>
        <response name="success" type="request" value="json" />
        <response name="error" type="request" value="json" />
    </request-map>
    <request-map uri="delete${entityName}">
        <security https="false" auth="true"/>
        <event type="service" invoke="delete${entityName}"/>
        <response name="success" type="request" value="json" />
        <response name="error" type="request" value="json" />
    </request-map>
    <!--批量删除${entityTitle!} -->
    <request-map uri="deleteAll${entityName}">
        <security https="false" auth="true"/>
        <event type="service" invoke="deleteAll${entityName}"/>
        <response name="success" type="request" value="json" />
        <response name="error" type="request" value="json" />
    </request-map>
    

	<view-map name="Find${entityName}" type="screenjui" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Find${entityName}" />
	<view-map name="Edit${entityName}" type="screenjui" 
		page="component://${projectName}/widget/${modelName}Screens.xml#Edit${entityName}" />
	
	</textarea>
</div>


<div><h2>service.xml  [lims\servicedef\services_${modelNameLower}.xml]<button onclick="copyCode('area4');return false;">复制service.xml</button></h2>	
	<textarea cols='130' rows='15' id='area4'>
	<!--${entityTitle!} -->
	<#if requestAttributes.parameters.javaType.equals("simple")>
		<service name="create${entityName}" engine="simple" default-entity-name="${entityName}"
	             location="component://${projectName}/script/com/yuanh/${modelName}Services.xml" invoke="create${entityName}" auth="true">
	        <description>Create ${entityName}-${entityTitle!}</description>
	        <auto-attributes include="pk" mode="OUT" optional="false" />
			<auto-attributes include="nonpk" mode="IN" optional="true" />
	    </service>
	     <service name="update${entityName}" engine="simple" default-entity-name="${entityName}"
	             location="component://${projectName}/script/com/yuanh/${modelName}Services.xml" invoke="update${entityName}" auth="true">
	        <description>Update ${entityName}-${entityTitle!}</description>
	        <auto-attributes include="pk" mode="IN" optional="false" />
			<auto-attributes include="nonpk" mode="IN" optional="true" />
	    </service>
	    <service name="delete${entityName}" engine="simple" default-entity-name="${entityName}"
	             location="component://${projectName}/script/com/yuanh/${modelName}Services.xml" invoke="delete${entityName}" auth="true">
	        <description>Delete ${entityName}-${entityTitle!}</description>
	        <auto-attributes mode="IN" include="pk" optional="false"/>
	    </service>
	    <service name="deleteAll${entityName}" engine="simple" default-entity-name="${entityName}"
	             location="component://${projectName}/script/com/yuanh/${modelName}Services.xml" invoke="deleteAll${entityName}" auth="true">
	        <description>Delete ${entityName}-${entityTitle!}</description>
	        <attribute name="ids"  mode="IN" type="String" optional="false"/>
	    </service>
    <#else>
	    <service name="create${entityName}" engine="java" default-entity-name="${entityName}"
	     		location="org.extErp.${projectName}.${modelNameLower}.${entityName}Services" invoke="create${entityName}" auth="true">
	        <description>Create ${entityName}-${entityTitle!}</description>
	        <auto-attributes include="pk" mode="OUT" optional="false" />
			<auto-attributes include="nonpk" mode="IN" optional="true" />
	    </service>
	     <service name="update${entityName}" engine="java" default-entity-name="${entityName}"
	             location="org.extErp.${projectName}.${modelNameLower}.${entityName}Services" invoke="update${entityName}" auth="true">
	        <description>Update ${entityName}-${entityTitle!}</description>
	        <auto-attributes include="pk" mode="IN" optional="false" />
			<auto-attributes include="nonpk" mode="IN" optional="true" />
	    </service>
	    <service name="delete${entityName}" engine="java" default-entity-name="${entityName}"
	             location="org.extErp.${projectName}.${modelNameLower}.${entityName}Services" invoke="delete${entityName}" auth="true">
	        <description>Delete ${entityName}-${entityTitle!}</description>
	        <auto-attributes mode="IN" include="pk" optional="false"/>
	    </service>
    </#if>
    </textarea>
</div>
<#if requestAttributes.parameters.javaType.equals("simple")>
<div><h2>simple.xml [lims\script\com\yuanh\${modelName}Services.xml]<button onclick="copyCode('area5');return false;">复制simple.xml</button></h2>	
	<textarea cols='130' rows='15' id='area5'>
    <!--${entityTitle!} -->
    <simple-method method-name="create${entityName}" short-description="Create ${entityName}">
        <make-value entity-name="${entityName}" value-field="newEntity"/>
   	    <if-empty field="parameters.${entityId}">
        	<sequenced-id sequence-name="${entityName}" field="newEntity.${entityId}"/>
        	 <else>
                <set field="newValue.${entityId}" from-field="parameters.${entityId}"/>
            </else>
		</if-empty>
        <set-nonpk-fields map="parameters" value-field="newEntity"/>
        <field-to-result field="newEntity.${entityId}" result-name="${entityId}"/>
        <create-value value-field="newEntity"/>
        <check-errors/>
    </simple-method>
    <simple-method method-name="update${entityName}" short-description="Update ${entityName}">
        <entity-one entity-name="${entityName}" value-field="lookedUpValue"/>
        <set-nonpk-fields value-field="lookedUpValue" map="parameters"/>
        <store-value value-field="lookedUpValue"/>
    </simple-method>
    <simple-method method-name="delete${entityName}" short-description="Delete ${entityName}">
        <now-timestamp field="nowTimestamp"/>
        <set field="parameters.thruDate" from-field="nowTimestamp"/>
        <set-service-fields service-name="update${entityName}" to-map="thisCtx" map="parameters"/>
        <call-service service-name="update${entityName}" in-map-name="thisCtx"/>
    </simple-method>
    <simple-method method-name="deleteAll${entityName}" short-description="Delete select ${entityName}">
        <call-bsh><![CDATA[
               ids = org.ofbiz.base.util.StringUtil.split(parameters.get("ids"),",");
               parameters.put("ids", ids);
        ]]></call-bsh>
        <if-not-empty field="parameters.ids">
       		<iterate entry="thisId" list="parameters.ids">
			<set from-field="thisId" field="thisMap.${entityId}" />
	        <call-service service-name="delete${entityName}" in-map-name="thisMap"></call-service>
			</iterate>
		</if-not-empty>	
    </simple-method>
	</textarea>
</div>
</#if>


<div><h2>权限(LimsMgrSecurityData.xml)和菜单初始数据(MenuTreeData.xml) <button onclick="copyCode('area6');return false;">复制</button></h2>	
<textarea cols='130' rows='15' id='area6'>
	<SecurityPermission permissionId="${entityName}_ADMIN" description="${entityTitle}全部权限"/>
	<SecurityPermission permissionId="${entityName}_ADD" description="${entityTitle}增加权限"/>
	<SecurityPermission permissionId="${entityName}_VIEW" description="${entityTitle}查看权限"/>
	<SecurityPermission permissionId="${entityName}_UPDATE" description="${entityTitle}修改权限"/>
	<SecurityPermission permissionId="${entityName}_DELETE" description="${entityTitle}删除权限"/>
	<SecurityGroupPermission groupId="FULLADMIN" permissionId="${entityName}_ADMIN"/><!-- 给FULLADMIN权限组赋予${entityName}全部权限 -->
	 	
	<MenuTree id="Edit${entityName}" itemName="${entityTitle!}添加" urlLocation="lims/control/Edit${entityName}" parentItemId="${modelName}Mgr" permission="${entityName}_ADD" rank="1"/>
	<MenuTree id="Find${entityName}" itemName="${entityTitle!}列表" urlLocation="lims/control/Find${entityName}" parentItemId="${modelName}Mgr" permission="${entityName}_VIEW" rank="2"/>
</textarea>
</div>

<script type="text/javascript">
function copyCode(id){
 var testCode=document.getElementById(id).value;
 if(copy2Clipboard(testCode)!=false){
  alert("生成的代码已经复制到粘贴板，你可以使用Ctrl+V 贴到需要的地方去了哦！  ");
 }
}
copy2Clipboard=function(txt){
 if(window.clipboardData){
  window.clipboardData.clearData();
  window.clipboardData.setData("Text",txt);
 }
 else if(navigator.userAgent.indexOf("Opera")!=-1){
  window.location=txt;
 }
 else if(window.netscape){
  try{
   netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
  }
  catch(e){
   alert("您的firefox安全限制限制您进行剪贴板操作，请打开’about:config’将signed.applets.codebase_principal_support’设置为true’之后重试，相对路径为firefox根目录/greprefs/all.js");
   return false;
  }
  var clip=Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
  if(!clip)return;
  var trans=Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
  if(!trans)return;
  trans.addDataFlavor('text/unicode');
  var str=new Object();
  var len=new Object();
  var str=Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
  var copytext=txt;str.data=copytext;
  trans.setTransferData("text/unicode",str,copytext.length*2);
  var clipid=Components.interfaces.nsIClipboard;
  if(!clip)return false;
  clip.setData(trans,null,clipid.kGlobalClipboard);
 }
}
</script>
