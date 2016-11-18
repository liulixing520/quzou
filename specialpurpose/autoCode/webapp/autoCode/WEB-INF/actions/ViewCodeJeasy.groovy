import org.ofbiz.entity.Delegator;
import org.ofbiz.security.Security;
import org.ofbiz.entity.model.ModelReader;
import org.ofbiz.entity.model.ModelEntity;
import org.ofbiz.entity.model.ModelField;
import org.ofbiz.entity.model.ModelFieldType;
import org.ofbiz.entity.model.ModelRelation;
import org.ofbiz.entity.model.ModelKeyMap;
import javolution.util.FastList;
import javolution.util.FastMap;


//排序
List editFieldlist=(List)parameters.editField;
List searchFieldlist=(List)parameters.searchField;
List listFieldlist=(List)parameters.listField;
String[] sortNumArray = new String[editFieldlist.size()];
Map sortMap=new HashMap();
for(int i=0;i<editFieldlist.size();i++){
    int value=Integer.valueOf(parameters.get("editFieldSort_"+editFieldlist.get(i)));
    sortMap.put("sort_"+value, editFieldlist.get(i));
    sortNumArray[i]=value;
}
Arrays.sort(sortNumArray);
List sortList=java.util.Arrays.asList(sortNumArray);
context.editSortList=sortList;
context.editSortMap=sortMap;


sortNumArray = new String[searchFieldlist.size()];
sortMap=new HashMap();
for(int i=0;i<searchFieldlist.size();i++){
    int value=Integer.valueOf(parameters.get("searchFieldSort_"+searchFieldlist.get(i)));
    sortMap.put("sort_"+value, searchFieldlist.get(i));
    sortNumArray[i]=value;
}
Arrays.sort(sortNumArray);
sortList=java.util.Arrays.asList(sortNumArray);
context.searchSortList=sortList;
context.searchSortMap=sortMap;


sortNumArray = new String[listFieldlist.size()];
sortMap=new HashMap();
for(int i=0;i<listFieldlist.size();i++){
    int value=Integer.valueOf(parameters.get("listFieldSort_"+listFieldlist.get(i)));
    sortMap.put("sort_"+value, listFieldlist.get(i));
    sortNumArray[i]=value;
}
Arrays.sort(sortNumArray);
sortList=java.util.Arrays.asList(sortNumArray);
context.listSortList=sortList;
context.listSortMap=sortMap;


//获取从表信息
List subFieldList = FastList.newInstance();
relationEntity=parameters.relationEntity;
ModelReader reader = delegator.getModelReader();
if(relationEntity){
ModelEntity modelEntity = reader.getModelEntity(relationEntity);

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
    subFieldList.add(fieldMap);
}
context.subFieldList=subFieldList;
context.relationEntity=relationEntity;
}

