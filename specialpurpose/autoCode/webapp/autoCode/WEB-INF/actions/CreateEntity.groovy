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
import org.extErp.sysCommon.util.*;
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


ModelReader reader = delegator.getModelReader();
Map<String, Object> paramMap = UtilHttp.getParameterMap(request);
String entityName=paramMap.entityName;

List filedNameList=(List)paramMap.get("filedName");
List filedCnNameList=(List)paramMap.get("filedCnName");
List filedTypeList=(List)paramMap.get("filedType");
List isPKeyList=(List)paramMap.get("isPKey");
List isRefList=(List)paramMap.get("isRef");
List relEntityList=(List)paramMap.get("relEntity");
StringBuffer bf=new StringBuffer();

bf.append("    <entity entity-name=\""+entityName+"\" package-name=\"demo\" title=\""+parameters.entityDes+"\">");
for(int i=0;i<filedNameList.size();i++){
    bf.append("\r\n        <field name=\""+filedNameList.get(i)+"\" type=\""+filedTypeList.get(i)+"\"><description>"+filedCnNameList.get(i)+"</description></field>");
}

//工作流相关字段
if(paramMap.get("hasWorkflow")=="Y"){
    bf.append("\r\n        <field name=\"nextActive\" type=\"short-varchar\" ><description>下一活动</description></field>");
    bf.append("\r\n        <field name=\"joinPersonId\" type=\"short-varchar\"><description>参与人</description></field>");
}
//默认添加起始和终止日期
bf.append("\r\n        <field name=\"fromDate\" type=\"date-time\"></field>");
bf.append("\r\n        <field name=\"thruDate\" type=\"date-time\"></field>");

bf.append("\r\n");
for(int i=0;i<filedNameList.size();i++){
    if(isPKeyList.get(i).equals("Y")){
	bf.append("        <prim-key field=\""+filedNameList.get(i)+"\" />");
    }
}
for(int i=0;i<filedNameList.size();i++){	
    if(isRefList.get(i)!=null&&isRefList.get(i).equals("Y")){
	bf.append("\r\n  <relation type=\"one\" fk-name=\""+relEntityList.get(i)+filedNameList.get(i)+"\" rel-entity-name=\""+relEntityList.get(i)+"\"> ");
	//获取关联实体的主键
	String pkFiled="";
	ModelEntity refModelEntity = reader.getModelEntity(relEntityList.get(i));
	List refFieldList = FastList.newInstance();
	refFieldIterator = refModelEntity.getFieldsIterator();
	while (refFieldIterator.hasNext()) {
	    ModelField field = refFieldIterator.next();
	    if(field.getIsPk()){
		pkFiled= field.getName();
		break;
	    }
	}
	bf.append("\r\n <key-map field-name=\""+filedNameList.get(i)+"\" rel-field-name=\""+pkFiled+"\"/>  </relation>");
    }
   
}
bf.append("\r\n");
bf.append("    </entity>");


String demoEntity=ComponentLocationResolver.getBaseLocation("component://sysCommon/entitydef/entitymodel_demo.xml").toString();
org.extErp.sysCommon.util.OfbizExtUtil.appendFileText(demoEntity,"</entity>",bf.toString());



reader.getNoCacheEntityNames();
//生成数据库表
helperInfo = delegator.getGroupHelperInfo("org.ofbiz");
dbUtil = new org.ofbiz.entity.jdbc.DatabaseUtil(helperInfo);
modelEntities = delegator.getModelEntityMapByGroup("org.ofbiz");
dbUtil.createTable(reader.getModelEntity(entityName),modelEntities,false);
dbUtil.createForeignKeys(reader.getModelEntity(entityName),modelEntities,null);
//dbUtil.checkDb(modelEntities, null,false);

//生成工作流基础文件并导入至workflow表
if(paramMap.get("hasWorkflow")=="Y"){
    String xpdlPath=System.getProperty("ofbiz.home")+"/specialpurpose/workflow/"+entityName+"_Xpdl.xml";
    //File f = new File(xpdlPath);
    def ant = new AntBuilder();
    //if(!f.exists()){
        conStr = System.getProperty("ofbiz.home")+"/framework/resources/templates/Xpdl.xml";
        ant.copy(
    	     file:conStr,
    	     tofile:xpdlPath,
    	     encoding:'utf-8'
         );
    //}
    OfbizExtUtil.replaceFileText(xpdlPath,UtilMisc.toMap("XXXXX",parameters.entityDes,"XXX",entityName));
    toBeStored = null;
    toBeStored=org.ofbiz.workflow.definition.XpdlReader.readXpdl(UtilURL.fromFilename(xpdlPath), delegator);
    delegator.storeAll(toBeStored);
}
context.entityName=entityName;
context.userOper=paramMap.userOper;
return "success";
