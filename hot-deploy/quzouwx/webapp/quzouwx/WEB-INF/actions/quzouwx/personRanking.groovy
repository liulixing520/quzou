	//auto groovy template
	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import org.extErp.sysCommon.util.*
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.math.RoundingMode;
	
	
	outputList = [];
	//获取参加赛事的人
	customerList = delegator.findByAnd("QzCompetiAndCustomerView",[cId:parameters.cId]);
	competition = delegator.findOne("QzCompetition",[cId:parameters.cId],false);
	minStep = new BigDecimal(competition.minStep);
	maxStep = new BigDecimal(competition.maxStep);
	stepCoefficient = new BigDecimal(competition.stepCoefficient);
	
	for(GenericValue item:customerList){
		cusMap=[:];
		List<EntityCondition> listCdt = UtilMisc.<EntityCondition>toList(
				EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, item.customerId),
				EntityCondition.makeCondition("stepDate", EntityOperator.GREATER_THAN_EQUAL_TO, competition.startDate),
				EntityCondition.makeCondition("stepDate", EntityOperator.LESS_THAN_EQUAL_TO,  competition.endDate));
		List<GenericValue> itemList=delegator.findList("CustomerLogAndCustomer",  EntityCondition.makeCondition(listCdt), null, null, null, false);
		tempCustomer = EntityUtil.getFirst(delegator.findByAnd("QzCustomer",[partyId:item.customerId]));
		deptAndCustomer = EntityUtil.getFirst(delegator.findByAnd("QzDeptAndCustomerView",[customerId:item.customerId]));
		
		CusStepNumber= 0;
		CusIntegral = 0;
		for(GenericValue gv:itemList){
			stepNumber =  new BigDecimal(gv.stepNumber);
			CusStepNumber = CusStepNumber+stepNumber;
			
			integral = 0 ;
			if(stepNumber >= minStep){
				if(stepNumber < maxStep){
					integral = stepNumber/(stepCoefficient * 100);
					integral = new BigDecimal(integral).setScale(0, RoundingMode.HALF_UP)
				}else if(stepNumber >= maxStep){
					integral = maxStep/(stepCoefficient * 100);
					integral = new BigDecimal(integral).setScale(0, RoundingMode.HALF_UP)
				}
			}
			CusIntegral = CusIntegral+integral;
		}
		deptName = "";
		if(UtilValidate.isNotEmpty(deptAndCustomer)){
			deptName =deptAndCustomer.deptName; 
		}
		cusMap.put("headimgurl",tempCustomer.headimgurl);
		cusMap.put("deptName",deptName);
		cusMap.put("userLoginId",tempCustomer.userLoginId);
		cusMap.put("stepNumber",new BigDecimal(CusStepNumber));
		cusMap.put("integral",new BigDecimal(CusIntegral));
		cusMap.put("partyId",tempCustomer.partyId);
		outputList.add(cusMap);
	}
	
	outputList = OfbizExtUtil.reloadOrder(outputList,"integral");
	//日期类型转换
	for(Map<String,Object> result:outputList){
		 //  从关联表获取信息
		Debug.log("result.partyId---"+result.partyId);
		relationList = [];
		relationList = delegator.findByAnd("QzRelation",[cId:parameters.cId,customerId:result.partyId]);
		result.relations = relationList.size();
		
	}
	context.statisticsList = outputList;
	
		
