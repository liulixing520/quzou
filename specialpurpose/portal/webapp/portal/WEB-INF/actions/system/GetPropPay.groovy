import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.product.store.ProductStoreWorker;


//小区的ID
pId=parameters.city3Id?:null;
println "============1==========="+pId;

//户主名字
houseHolder=parameters.houseHolder?:null;
println "============2==========="+houseHolder;
//户主身份证
idCard=parameters.idCard?:null;
println "============3==========="+idCard;


pruList = delegator.findByAnd("PropertyUser", [ptcId:pId,houseHolder:houseHolder,idCard:idCard], null, false);
if(pruList){
	context.pruList=pruList;
}

pruIdVal=pruList.pruId;
println "============4==========="+pruIdVal;
prpList = delegator.findByAnd("PropertyPayment", [pruId:pruIdVal], null, false);
if(prpList){
	context.prpList=prpList;
}


prtList = delegator.findByAnd("PropertyPaymentType", null, null, false);

if(prtList){
	context.prtList=prtList;
}
println "============6==========="+context.prtList;






