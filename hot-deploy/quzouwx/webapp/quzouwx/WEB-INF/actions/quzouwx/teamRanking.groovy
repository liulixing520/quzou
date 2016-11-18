	//auto groovy template
	import org.ofbiz.base.util.*
	import org.ofbiz.entity.*
	import org.ofbiz.entity.condition.*
	import org.ofbiz.entity.util.*
	import java.util.*
	import org.extErp.sysCommon.util.*
	import org.extErp.sysCommon.util.OfbizExtUtil;
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.math.RoundingMode;
	
	outputList2 = [];
	competition = delegator.findOne("QzCompetition",[cId:parameters.cId],false);
	//团队成绩
	competiAndDeptList = delegator.findByAnd("QzCompetiAndDeptView",[cId:parameters.cId]);
	
	minStep = new BigDecimal(competition.minStep);
	maxStep = new BigDecimal(competition.maxStep);
	stepCoefficient = new BigDecimal(competition.stepCoefficient);
	
	for(GenericValue item:competiAndDeptList){
		deptAndCustomerList = delegator.findByAnd("QzDeptAndCustomerView",[deptId:item.deptId]);
		companyAndDept = EntityUtil.getFirst(delegator.findByAnd("companyAndDept",[deptId:item.deptId]));
		deptMap=[:];
		totalIntegral = 0;
		totalStepNumber = 0;
		for(GenericValue deptCus:deptAndCustomerList){
			List<EntityCondition> listCdt = UtilMisc.<EntityCondition>toList(
					EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, deptCus.customerId),
					EntityCondition.makeCondition("stepDate", EntityOperator.GREATER_THAN_EQUAL_TO, competition.startDate),
					EntityCondition.makeCondition("stepDate", EntityOperator.LESS_THAN_EQUAL_TO,  competition.endDate));
			List<GenericValue> itemList=delegator.findList("CustomerLogAndCustomer",  EntityCondition.makeCondition(listCdt), null, null, null, false);
			
			tempCustomer = EntityUtil.getFirst(delegator.findByAnd("QzCustomer",[partyId:deptCus.customerId]));
			deptAndCustomer = EntityUtil.getFirst(delegator.findByAnd("QzDeptAndCustomerView",[customerId:deptCus.customerId]));
			
			CusStepNumber= 0;
			CusIntegral = 0;
			for(GenericValue gv:itemList){
				stepNumber = new BigDecimal(gv.stepNumber);
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
			totalStepNumber = totalStepNumber +CusStepNumber;
			totalIntegral = totalIntegral +CusIntegral;
		}
		deptMap.put("stepNumber",new BigDecimal(totalStepNumber));
		deptMap.put("integral",new BigDecimal(totalIntegral));
		companyName = "";
		deptName = "";
		if(UtilValidate.isNotEmpty(companyAndDept)){
			companyName = companyAndDept.companyName;
			deptName = companyAndDept.deptName;
		}
		deptMap.put("companyName",companyName);
		deptMap.put("deptId",item.deptId);
		deptMap.put("deptName",deptName);
		outputList2.add(deptMap);
	}
	outputList2 = OfbizExtUtil.reloadOrder(outputList2,"integral");
	
	teamRank = 0;
	rank = 1;
	for(Map<String,Object> result:outputList2){
		 //  从关联表获取信息
		Debug.log("customer................................."+customer);
		if(customer){
			statistics = delegator.findByAnd("QzStatistics",[cId:parameters.cId,customerId:customer.partyId]);
			
			Debug.log("customer.partyId................................."+customer.partyId);
			Debug.log("statistics................................."+statistics);
			Debug.log("parameters.cId................................."+parameters.cId);
			if(statistics){
				Debug.log("statistics>>>"+statistics[0].deptId);
				Debug.log("result.deptId>>>"+result.deptId);
				if(statistics[0]){
					if(result.deptId == statistics[0].deptId){
						teamRank = rank;
					}
				}
				relationList = delegator.findByAnd("QzRelation",[cId:parameters.cId,deptId:result.deptId]);
				result.relations = relationList.size();
			}
		}
		rank++;
	}
	context.teamRank = teamRank;
	context.statisticsList = outputList2;
	
		
