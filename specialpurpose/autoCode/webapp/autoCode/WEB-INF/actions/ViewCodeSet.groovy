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
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityConditionList;
import org.ofbiz.entity.condition.EntityFieldMap;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.base.util.Debug;
import java.sql.Timestamp;
import java.sql.Date;
import java.sql.Time;
import javolution.util.FastList;
import javolution.util.FastMap;
import javolution.util.FastSet;
import org.ofbiz.entity.GenericPK;

String entityName =parameters.get("entityName");
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

context.entityName = modelEntity.getEntityName();
context.plainTableName = modelEntity.getPlainTableName();

String hasViewPermission = (security.hasEntityPermission("ENTITY_DATA", "_VIEW", session) || security.hasEntityPermission(modelEntity.getPlainTableName(), "_VIEW", session)) == true ? "Y" : "N";
String hasCreatePermission = (security.hasEntityPermission("ENTITY_DATA", "_CREATE", session) || security.hasEntityPermission(modelEntity.getPlainTableName(), "_CREATE", session)) == true ? "Y" : "N";
String hasUpdatePermission = (security.hasEntityPermission("ENTITY_DATA", "_UPDATE", session) || security.hasEntityPermission(modelEntity.getPlainTableName(), "_UPDATE", session)) == true ? "Y" : "N";
String hasDeletePermission = (security.hasEntityPermission("ENTITY_DATA", "_DELETE", session) || security.hasEntityPermission(modelEntity.getPlainTableName(), "_DELETE", session)) == true ? "Y" : "N";

context.hasViewPermission = hasViewPermission;
context.hasCreatePermission = hasCreatePermission;
context.hasUpdatePermission = hasUpdatePermission;
context.hasDeletePermission = hasDeletePermission;


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
    //add by wangyg
    if(field.getDescription()==null){
    	fieldMap.put("description",field.getName());
    }else{
    	fieldMap.put("description",field.getDescription());
    }
    fieldList.add(fieldMap);
}
request.setAttribute("modelEntity",modelEntity);
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
        if(field.getDescription()==null){
        	fieldMap.put("description",field.getName());
        }else{
        	fieldMap.put("description",field.getDescription());
        }
        refFieldList.add(fieldMap);
    }
    mapRelation.relEntity=refFieldList;
    relations.add(mapRelation);
}
request.setAttribute("relations",relations);
request.setAttribute("enumTypes",delegator.findByAnd("EnumerationType",null));
return "success";
