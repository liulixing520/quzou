import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.util.*;

//.ftl页面里面的from表单元素   
penmobile=parameters.penmobile;
penemail=parameters.penemail;
penName=parameters.penName;
pencertNo=parameters.pencertNo;

//获取TrePerson实体的 ID 值
penId=delegator.getNextSeqId("TrePerson");

//form表单元素 放到Map 里面
Map  map=UtilMisc.toMap("penId",penId,"penmobile",penmobile,"penemail",penemail,"penName",penName,"pencertNo",pencertNo);

//生成对象
TrePe = delegator.makeValue("TrePerson", map);

//执行保存
delegator.create(TrePe);




