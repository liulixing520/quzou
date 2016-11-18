/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
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
import org.ofbiz.base.util.UtilFormatOut;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
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
import java.sql.Timestamp;
import java.sql.Date;
import java.sql.Time;
import javolution.util.FastList;
import javolution.util.FastMap;
import javolution.util.FastSet;
import org.ofbiz.entity.GenericPK;



entityName = parameters.get("entityName");

listField	=FastList.newInstance();
if(parameters.get("listField")!=null){
	listField=UtilMisc.toList(parameters.get("listField"));
}
searchField	=FastList.newInstance();
if(parameters.get("searchField")!=null){
	searchField=UtilMisc.toList(parameters.get("searchField"));
}
searchAdvancedField=FastList.newInstance();
if(parameters.get("searchAdvancedField")!=null){
	searchAdvancedField=UtilMisc.toList(parameters.get("searchAdvancedField"));
}
editField=FastList.newInstance();
if(parameters.get("editField")!=null){
	editField=UtilMisc.toList(parameters.get("editField"));
}

//前台参数全部传入ftl
request.setAttribute("parameters",parameters);
request.setAttribute("modelNameLower",parameters.get("modelName").toLowerCase())
request.setAttribute("entityNameLower",parameters.get("entityName").toLowerCase())
request.setAttribute("searchField",searchField);
request.setAttribute("searchAdvancedField",searchAdvancedField);
request.setAttribute("editField",editField);
request.setAttribute("listField",listField);



//编辑表单参数
Map editFieldMap=new HashMap();
for(int i=0;i<editField.size();i++){
	editFieldMap.put("editFieldDesc_"+editField.get(i),parameters.get("editFieldDesc_"+editField.get(i)));
	editFieldMap.put("editFieldRelName_"+editField.get(i),parameters.get("editFieldRelName_"+editField.get(i)));
	editFieldMap.put("editFieldRelEntityName_"+editField.get(i),parameters.get("editFieldRelEntityName_"+editField.get(i)));
	editFieldMap.put("editFieldRequired_"+editField.get(i),parameters.get("editFieldRequired_"+editField.get(i)));
	editFieldMap.put("editFieldSort_"+editField.get(i),parameters.get("editFieldSort_"+editField.get(i)));
	editFieldMap.put("editFieldType_"+editField.get(i),parameters.get("editFieldType_"+editField.get(i)));
	editFieldMap.put("editEnumType_"+editField.get(i),parameters.get("editEnumType_"+editField.get(i)));
	
}
request.setAttribute("editFieldMap",editFieldMap);

//查询表单参数
Map searchFieldMap=new HashMap();
for(int i=0;i<searchField.size();i++){
	searchFieldMap.put("searchFieldDesc_"+searchField.get(i),parameters.get("editFieldDesc_"+searchField.get(i)));
	searchFieldMap.put("searchFieldRelName_"+searchField.get(i),parameters.get("editFieldRelName_"+searchField.get(i)));
	searchFieldMap.put("searchFieldRelEntityName_"+searchField.get(i),parameters.get("editFieldRelEntityName_"+searchField.get(i)));
	searchFieldMap.put("searchFieldType_"+searchField.get(i),parameters.get("editFieldType_"+searchField.get(i)));
	searchFieldMap.put("searchFieldSort_"+searchField.get(i),parameters.get("searchFieldSort_"+searchField.get(i)));
	
}
request.setAttribute("searchFieldMap",searchFieldMap);

//高级查询表单参数
Map searchAdvancedFieldMap=new HashMap();
if(parameters.get("hasSearchAdvanced")!=null&&parameters.get("hasSearchAdvanced").equals("Y")){
	for(int i=0;i<searchAdvancedField.size();i++){
		searchAdvancedFieldMap.put("searchFieldDesc_"+searchAdvancedField.get(i),parameters.get("editFieldDesc_"+searchAdvancedField.get(i)));
		searchAdvancedFieldMap.put("searchFieldRelName_"+searchAdvancedField.get(i),parameters.get("editFieldRelName_"+searchAdvancedField.get(i)));
		searchAdvancedFieldMap.put("searchFieldRelEntityName_"+searchAdvancedField.get(i),parameters.get("editFieldRelEntityName_"+searchAdvancedField.get(i)));
		searchAdvancedFieldMap.put("searchFieldType_"+searchAdvancedField.get(i),parameters.get("editFieldType_"+searchAdvancedField.get(i)));
		
		searchAdvancedFieldMap.put("searchFieldSort_"+searchAdvancedField.get(i),parameters.get("searchFieldSort_"+searchAdvancedField.get(i)));
		
	}
}
request.setAttribute("searchAdvancedField",searchAdvancedField);
request.setAttribute("searchAdvancedFieldMap",searchAdvancedFieldMap);

//列表参数
Map listFieldMap=new HashMap();
for(int i=0;i<listField.size();i++){
	listFieldMap.put("listFieldDesc_"+listField.get(i),parameters.get("editFieldDesc_"+listField.get(i)));
	listFieldMap.put("listFieldRelName_"+listField.get(i),parameters.get("editFieldRelName_"+listField.get(i)));
	listFieldMap.put("listFieldRelEntityName_"+listField.get(i),parameters.get("editFieldRelEntityName_"+listField.get(i)));
	listFieldMap.put("listFieldType_"+listField.get(i),parameters.get("editFieldType_"+listField.get(i)));
	//listFieldMap.put("listFieldHasInitSort_"+listField.get(i),parameters.get("listFieldHasInitSort_"+listField.get(i)));
	listFieldMap.put("listFieldHasSort_"+listField.get(i),parameters.get("listFieldHasSort_"+listField.get(i)));
	
	
}
request.setAttribute("listFieldMap",listFieldMap);


ModelReader reader = delegator.getModelReader();
ModelEntity modelEntity = reader.getModelEntity(entityName);

groupByFields = FastList.newInstance();
functionFields = FastList.newInstance();

if (modelEntity instanceof ModelViewEntity) {
    aliases = modelEntity.getAliasesCopy()
    for (ModelAlias alias : aliases) {
        if (alias.getGroupBy()) {
            groupByFields.add(alias.getName());
        } else if (alias.getFunction()) {
            functionFields.add(alias.getName());
        }
    }
}


//实体字段属性
List fieldList = FastList.newInstance();
fieldIterator = modelEntity.getFieldsIterator();
while (fieldIterator.hasNext()) {
    ModelField field = fieldIterator.next();
    ModelFieldType type = delegator.getEntityFieldType(modelEntity, field.getType());

    Map fieldMap = FastMap.newInstance();
    fieldMap.put("name", field.getName());
    fieldMap.put("isPk", (field.getIsPk() == true) ? "Y" : "N");
    fieldMap.put("javaType", type.getJavaType());
    fieldMap.put("sqlType", type.getSqlType());
    fieldMap.put("param", (parameters.get(field.getName()) != null ? parameters.get(field.getName()) : ""));

    fieldList.add(fieldMap);
}
request.setAttribute("modelEntity",modelEntity);
request.setAttribute("entityTitle",modelEntity.getTitle());
request.setAttribute("fieldList",fieldList);

relations = [];
for (rit = modelEntity.getRelationsIterator(); rit.hasNext();) {
    mapRelation = [:];

    modelRelation = rit.next();
    relFields = [];
    for (kit = modelRelation.getKeyMaps().iterator(); kit.hasNext();) {
        mapFields = [:];
        keyMap = kit.next();
        mapFields.fieldName = keyMap.getFieldName();
        mapFields.relFieldName = keyMap.getRelFieldName();

        relFields.add(mapFields);
    }
    mapRelation.relFields = relFields;
    mapRelation.title = modelRelation.getTitle();
    mapRelation.relEntityName = modelRelation.getRelEntityName();
    mapRelation.type = modelRelation.getType();
    mapRelation.fkName = modelRelation.getFkName();

    //  实体字段属性
    ModelEntity refModelEntity = reader.getModelEntity(modelRelation.getRelEntityName());
    List refFieldList = FastList.newInstance();
    refFieldIterator = refModelEntity.getFieldsIterator();
    while (refFieldIterator.hasNext()) {
        ModelField field = refFieldIterator.next();
        ModelFieldType type = delegator.getEntityFieldType(refModelEntity, field.getType());

        Map fieldMap = FastMap.newInstance();
        fieldMap.put("name", field.getName());
        fieldMap.put("isPk", (field.getIsPk() == true) ? "Y" : "N");
        if(type!=null){
        	fieldMap.put("javaType", type.getJavaType());
        	fieldMap.put("sqlType", type.getSqlType());
        }
        fieldMap.put("param", (parameters.get(field.getName()) != null ? parameters.get(field.getName()) : ""));
        //add by wangyg
        fieldMap.put("description",field.getDescription());
        System.out.println("name:"+field.getName()+"Des:"+field.getDescription());
        refFieldList.add(fieldMap);
    }
    
    mapRelation.relEntity=refFieldList;
    relations.add(mapRelation);
}
request.setAttribute("relations",relations);


//保存表单编辑扫数据库
String xmlParam=org.ofbiz.base.util.UtilXml.toXml(UtilHttp.getParameterMap(request));
Map xmlMap=UtilMisc.toMap("relEntityName", entityName,"designFormName",entityName,"xmlMap",xmlParam,"designFormType","stand","userLogin",userLogin);
dispatcher.runSync("createDesignForm", xmlMap);

return "success";
