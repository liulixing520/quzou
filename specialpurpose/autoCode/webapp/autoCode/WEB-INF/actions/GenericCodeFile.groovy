/*
 * 生成实体xml文件
 * 
 */
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.security.Security;
import org.ofbiz.entity.model.ModelReader;
import org.ofbiz.entity.model.ModelEntity;
import org.ofbiz.entity.model.ModelViewEntity;
import org.ofbiz.entity.model.ModelViewEntity.ModelAlias;
import org.ofbiz.entity.model.ModelField;
import org.ofbiz.entity.model.ModelFieldType;
import org.ofbiz.entity.GenericEntity;
import org.ofbiz.base.location.ComponentLocationResolver;
import org.ofbiz.base.util.FileUtil;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilFormatOut;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityFieldMap;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.base.util.*;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.sql.Date;
import java.sql.Time;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;
import javolution.util.FastSet;
import org.ofbiz.entity.GenericPK;
import org.extErp.sysCommon.util.*;


Map<String, Object> paramMap = UtilHttp.getParameterMap(request);
String entityName=paramMap.entityName;
String projectName=paramMap.projectName;
String packageName=paramMap.packageName;
String modelNameLower=paramMap.modelNameLower;
String relationEntity=paramMap.relationEntity;
String controlText=request.getParameter("controlText");
String screensText=request.getParameter("screensText");
String formsText=request.getParameter("formsText");
String serviceText=request.getParameter("serviceText");
String simpleText=request.getParameter("simpleText");
String dataText=request.getParameter("dataText");

String editFtlText=request.getParameter("editFtlText");//${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_edit.ftl
String listFtlText=request.getParameter("listFtlText");//${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_list.ftl
String easyuiFTLText=request.getParameter("easyuiFTLText");//${projectName}/webapp/${projectName}/${modelNameLower}/${entityName}_list.ftl
String editAndFtlText=request.getParameter("editAndFtlText");//${projectName}/webapp/${projectName}/${modelNameLower}/${entityName!}And${relationEntity!}_edit.ftl
String easyuiGroovyText=request.getParameter("easyuiGroovyText");//${projectName}/webapp/${projectName}/WEB-INF/actions/${modelNameLower}/get${entityName}.groovy

String EventsJavaText=request.getParameter("EventsJavaText");//${packageName}.${projectName}.${modelNameLower}.${entityName}Events.java
String servicesJavaText=request.getParameter("servicesJavaText");//${packageName}.${projectName}.${modelNameLower}.${entityName}Services.java


if(UtilValidate.isEmpty(projectName))
    projectName = "sysCommon";
if(UtilValidate.isEmpty(modelNameLower))
    modelNameLower = "demo";
modelNameFirstUpper = (String)(modelNameLower.charAt(0)).toUpperCase();
modelNameFirstUpper = modelNameFirstUpper + modelNameLower.substring(1);
def ant = new AntBuilder();
if("limsCommon".equals(projectName) || "sysCommon".equals(projectName))
    pFilePath = "specialpurpose"
else
    pFilePath = "hot-deploy"
    
//Events.java文件追加
if(UtilValidate.isNotEmpty(EventsJavaText)){
   packageName = packageName.replace(".", "/");
   String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/src/"+packageName+"/"+projectName+"/"+modelNameLower+"/"+entityName+"Events.java").toString();
   fPathStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/src/"+packageName+"/"+projectName+"/"+modelNameLower;
   File fPath = new File(fPathStr);
   if(!fPath.exists()){
       ant.mkdir(
		dir:fPathStr
	);  
   }
   File f = new File(demoFile);
   if(f.exists()){
	ant.delete(file:demoFile); 
   }
   if(!f.exists()){
       conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/Java.java";
       conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/src/"+packageName+"/"+projectName+"/"+modelNameLower+"/"+entityName+"Events.java";
       ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
   }
   OfbizExtUtil.appendFileText(demoFile,"//auto java template",EventsJavaText);
}
//Services.java文件追加
if(UtilValidate.isNotEmpty(servicesJavaText)){
    packageName = packageName.replace(".", "/");
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/src/"+packageName+"/"+projectName+"/"+modelNameLower+"/"+entityName+"Services.java").toString();
    fPathStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/src/"+packageName+"/"+projectName+"/"+modelNameLower;
    File fPath = new File(fPathStr);
    if(!fPath.exists()){
	ant.mkdir(
		dir:fPathStr
	);  
    }
    File f = new File(demoFile);
    if(f.exists()){
	ant.delete(file:demoFile); 
    }
    if(!f.exists()){
	conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/Java.java";
	conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/src/"+packageName+"/"+projectName+"/"+modelNameLower+"/"+entityName+"Services.java";
	ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
    }
    OfbizExtUtil.appendFileText(demoFile,"//auto java template",servicesJavaText);
}
//groovy文件追加
if(UtilValidate.isNotEmpty(easyuiGroovyText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/webapp/"+projectName+"/WEB-INF/actions/"+modelNameLower+"/get"+entityName+".groovy").toString();
    fPathStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/WEB-INF/actions/"+modelNameLower;
    File fPath = new File(fPathStr);
    if(!fPath.exists()){
	ant.mkdir(
		dir:fPathStr
	);  
    }
    File f = new File(demoFile);
    if(!f.exists()){
	conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/Groovy.groovy";
	conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/WEB-INF/actions/"+modelNameLower+"/get"+entityName+".groovy";
	ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
    }
    OfbizExtUtil.appendFileText(demoFile,"//auto groovy template",easyuiGroovyText);
}
//编辑ftl文件追加
if(UtilValidate.isNotEmpty(editFtlText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/webapp/"+projectName+"/"+modelNameLower+"/"+entityName+"_edit.ftl").toString();
    fPathStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/"+modelNameLower;
    File fPath = new File(fPathStr);
    if(!fPath.exists()){
	ant.mkdir(
		dir:fPathStr
	);  
    }
    File f = new File(demoFile);
    if(!f.exists()){
	conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/ftl.ftl";
	conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/"+modelNameLower+"/"+entityName+"_edit.ftl";
	ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
    }
    OfbizExtUtil.appendFileText(demoFile,"<br>",editFtlText);
}
//easyui列表ftl文件追加
if(UtilValidate.isNotEmpty(easyuiFTLText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/webapp/"+projectName+"/"+modelNameLower+"/"+entityName+"_list.ftl").toString();
    fPathStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/"+modelNameLower;
    File fPath = new File(fPathStr);
    if(!fPath.exists()){
	ant.mkdir(
		dir:fPathStr
	);  
    }
    File f = new File(demoFile);
    if(!f.exists()){
	conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/ftl.ftl";
	conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/"+modelNameLower+"/"+entityName+"_list.ftl";
	ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
    }
    OfbizExtUtil.appendFileText(demoFile,"<br>",easyuiFTLText);
}
//列表ftl文件追加
if(UtilValidate.isNotEmpty(listFtlText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/webapp/"+projectName+"/"+modelNameLower+"/"+entityName+"_list.ftl").toString();
    fPathStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/"+modelNameLower;
    File fPath = new File(fPathStr);
    if(!fPath.exists()){
	ant.mkdir(
		dir:fPathStr
	);  
    }
    File f = new File(demoFile);
    if(!f.exists()){
	conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/ftl.ftl";
	conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/"+modelNameLower+"/"+entityName+"_list.ftl";
	ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
    }
    OfbizExtUtil.appendFileText(demoFile,"<br>",listFtlText);
}
//编辑主从ftl文件追加
if(UtilValidate.isNotEmpty(editAndFtlText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/webapp/"+projectName+"/"+modelNameLower+"/"+entityName+"And"+relationEntity+"_edit.ftl").toString();
    fPathStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/"+modelNameLower;
    File fPath = new File(fPathStr);
    if(!fPath.exists()){
	ant.mkdir(
		dir:fPathStr
	);  
    }
    File f = new File(demoFile);
    if(!f.exists()){
	conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/ftl.ftl";
	conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/"+modelNameLower+"/"+entityName+"And"+relationEntity+"_edit.ftl";
	ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
    }
    OfbizExtUtil.appendFileText(demoFile,"<br>",editAndFtlText);
}
//control文件追加
if(UtilValidate.isNotEmpty(controlText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/webapp/"+projectName+"/WEB-INF/"+modelNameLower+"-controller.xml").toString();
    File f = new File(demoFile);
    if(!f.exists()){
	conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/controller.xml";
	conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/webapp/"+projectName+"/WEB-INF/"+modelNameLower+"-controller.xml";
	ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
    }
    OfbizExtUtil.appendFileText(demoFile,"</request-map>",controlText);
}
//screens文件追加
if(UtilValidate.isNotEmpty(screensText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/widget/"+modelNameFirstUpper+"Screens.xml").toString();
    File f = new File(demoFile);
    if(!f.exists()){
        conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/Screens.xml";
        conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/widget/"+modelNameFirstUpper+"Screens.xml";
        ant.copy(
 		file:conStr,
 		tofile:conToStr,
 		encoding:'utf-8'
 	);
    }
    OfbizExtUtil.appendFileText(demoFile,"</screen>",screensText);
}
//forms文件追加
if(UtilValidate.isNotEmpty(formsText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"//widget/"+modelNameFirstUpper+"Forms.xml").toString();
    File f = new File(demoFile);
    if(!f.exists()){
        conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/Forms.xml";
        conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/widget/"+modelNameFirstUpper+"Forms.xml";
        ant.copy(
 		file:conStr,
 		tofile:conToStr,
 		encoding:'utf-8'
 	);
        OfbizExtUtil.appendFileText(demoFile,"widget-form.xsd\">",formsText);
    }else
	OfbizExtUtil.appendFileText(demoFile,"</form>",formsText);
}
//services文件追加
if(UtilValidate.isNotEmpty(serviceText)){
   String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/servicedef/services_"+modelNameLower+".xml").toString();
   File f = new File(demoFile);
   if(!f.exists()){
       conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/services.xml";
       conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/servicedef/services_"+modelNameLower+".xml";
       ant.copy(
		file:conStr,
		tofile:conToStr,
		encoding:'utf-8'
	);
   }
   OfbizExtUtil.appendFileText(demoFile,"</service>",serviceText);
}
//simple文件追加
if(UtilValidate.isNotEmpty(simpleText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/script/"+modelNameFirstUpper+"Services.xml").toString();
    File f = new File(demoFile);
    if(!f.exists()){
        conStr = System.getProperty("ofbiz.home")+"/specialpurpose/autoCode/template/ScriptServices.xml";
        conToStr = System.getProperty("ofbiz.home")+"/"+pFilePath+"/"+projectName+"/script/"+modelNameFirstUpper+"Services.xml";
        ant.copy(
 		file:conStr,
 		tofile:conToStr,
 		encoding:'utf-8'
 	);
        OfbizExtUtil.appendFileText(demoFile,"simple-methods.xsd\">",simpleText);
    }else
	OfbizExtUtil.appendFileText(demoFile,"</simple-method>",simpleText);
}
//种子数据文件追加
if(UtilValidate.isNotEmpty(dataText)){
    String demoFile=ComponentLocationResolver.getBaseLocation("component://"+projectName+"/data/MenuTreeData.xml").toString();
    OfbizExtUtil.appendFileText(demoFile,"/>",dataText);
    dispatcher.runSync("parseEntityXmlFile", UtilMisc.toMap("userLogin",userLogin,"xmltext","<entity-engine-xml>"+dataText+"</entity-engine-xml>"));
}
//热加载services
//dispatcher.getDispatchContext().getNoCacheGlobalServiceMap();

return "success";
