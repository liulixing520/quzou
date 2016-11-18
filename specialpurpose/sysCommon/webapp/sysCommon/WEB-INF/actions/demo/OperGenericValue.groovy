oper = parameters.oper
entityName = parameters.entityName
idName = parameters.idField
idValue = parameters.id
if(oper=='add' && idValue=='_empty'){
	parameters.remove("id")
}

reader = delegator.getModelReader()
modelEntity = reader.getModelEntity(entityName)

pkCount = modelEntity.getPksSize()
pkName = modelEntity.getFirstPkFieldName()
fi = modelEntity.getFieldsIterator()

def entity;
if(oper=="edit" || oper=="del"){
	tMap = [:]
	tMap[idName]=idValue
	if(pkCount==1 && pkName==idName){
		entity = delegator.findOne(entityName,tMap,false)
	}else{
		temporaryList = delegator.findByAnd(entityName, tMap,null,false)
		if(temporaryList.size()>0)
		entity = temporaryList.get(0)
	}
	if(oper=="del"){
		entity.remove()
		return 'success'
	}
}else{
	//entity.setNonPKFields(parameters);
	if(pkCount==1){
		entity = delegator.makeValue(entityName);
		tMap = [:]
		tMap[pkName] = delegator.getNextSeqId(entityName)
		entity.setPKFields(tMap)
	}
}
if(entity){
	while(fi.hasNext()){
		mf = fi.next();
		fieldName = mf.getName()
		fieldValue = parameters[fieldName]
		if(fieldValue){
			typeStr = mf.getType()
			//int type = org.ofbiz.entity.jdbc.SqlJdbcUtil.getType(modelFieldTypeReader.getModelFieldType(mf.getType()).getJavaType());
			try{
				//Object transValue = transferStringToOtherType(fieldValue,type)
				transValue = org.extErp.sysCommon.util.OfbizExtUtil.transferStringToOtherSimpleType(fieldValue,typeStr)
				entity.set(fieldName, transValue);
			}catch(Exception e){
				Debug.logError(e, 'OperGenericValue')
			}
		}
	}
	if(oper=="edit"){
		entity.store()
	}else if(oper=="add"){
		entity.create()
	}
}