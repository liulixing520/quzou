import java.util.List;

import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.GenericValue;

import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import java.sql.Date;

import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.util.*;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.math.RoundingMode;
import org.extErp.sysCommon.util.OfbizExtUtil;
import java.text.ParseException;
import java.text.SimpleDateFormat;

	outputMap =[:];
	outputList = [];
	outputList2 = [];
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	cId = parameters.cId;
	Date startDate = new java.sql.Date(sdf.parse(parameters.startDate).getTime());
	Date endDate = new java.sql.Date(sdf.parse(parameters.endDate).getTime());
	
	//获取参加赛事的人
	customerList = delegator.findByAnd("QzCompetiAndCustomerView",[cId:cId]);
	competition = delegator.findOne("QzCompetition",[cId:cId],false);
	//个人成绩
	minStep = new BigDecimal(competition.minStep);
	maxStep = new BigDecimal(competition.maxStep);
	stepCoefficient = new BigDecimal(competition.stepCoefficient);
	Debug.log("minStep>>>>>"+minStep);
	Debug.log("maxStep>>>>>"+maxStep);
	for(GenericValue item:customerList){
		cusMap=[:];
		List<EntityCondition> listCdt = UtilMisc.<EntityCondition>toList(
				EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, item.customerId),
				EntityCondition.makeCondition("stepDate", EntityOperator.GREATER_THAN_EQUAL_TO, startDate),
				EntityCondition.makeCondition("stepDate", EntityOperator.LESS_THAN_EQUAL_TO,  endDate));
		List<GenericValue> itemList=delegator.findList("CustomerLogAndCustomer",  EntityCondition.makeCondition(listCdt), null, null, null, false);
		customer = EntityUtil.getFirst(delegator.findByAnd("QzCustomer",[partyId:item.customerId]));
		deptAndCustomer = EntityUtil.getFirst(delegator.findByAnd("QzDeptAndCustomerView",[customerId:item.customerId]));
		
		CusIntegral = 0;
		CusStepNumber= 0;
		for(GenericValue gv:itemList){
			integral = 0 ;
			stepNumber =  new BigDecimal(gv.stepNumber);
			CusStepNumber = CusStepNumber+stepNumber;
//			Debug.log("stepNumber>>>>>>"+stepNumber);
			if(stepNumber >= minStep){
				if(stepNumber < maxStep){
					integral = stepNumber/(stepCoefficient * 100);
					integral = new BigDecimal(integral).setScale(0, RoundingMode.HALF_UP)
				}else if(stepNumber >= maxStep){
					integral = maxStep/(stepCoefficient * 100);
					integral = new BigDecimal(integral).setScale(0, RoundingMode.HALF_UP)
				}
			}
//			if(customer.partyId == "10183"){
//				Debug.log("integral>>>>>>"+integral);
//			}
			CusIntegral = CusIntegral+integral;
		}
		deptName = "";
		if(UtilValidate.isNotEmpty(deptAndCustomer)){
			deptName =deptAndCustomer.deptName; 
		}
		cusMap.put("deptName",deptName);
		cusMap.put("userLoginId",customer.userLoginId);
		cusMap.put("integral",new BigDecimal(CusIntegral).setScale(0, RoundingMode.HALF_UP));
		cusMap.put("stepNumber",CusStepNumber);
		outputList.add(cusMap);
	}
	//团队成绩
	competiAndDeptList = delegator.findByAnd("QzCompetiAndDeptView",[cId:cId]);
	for(GenericValue item:competiAndDeptList){
		deptAndCustomerList = delegator.findByAnd("QzDeptAndCustomerView",[deptId:item.deptId]);
		companyAndDept = EntityUtil.getFirst(delegator.findByAnd("companyAndDept",[deptId:item.deptId]));
		deptMap=[:];
		totalIntegral = 0;
		totalStepNumber = 0;
		for(GenericValue deptCus:deptAndCustomerList){
			List<EntityCondition> listCdt = UtilMisc.<EntityCondition>toList(
					EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, deptCus.customerId),
					EntityCondition.makeCondition("stepDate", EntityOperator.GREATER_THAN_EQUAL_TO, startDate),
					EntityCondition.makeCondition("stepDate", EntityOperator.LESS_THAN_EQUAL_TO,  endDate));
			List<GenericValue> itemList=delegator.findList("CustomerLogAndCustomer",  EntityCondition.makeCondition(listCdt), null, null, null, false);
			
			customer = EntityUtil.getFirst(delegator.findByAnd("QzCustomer",[partyId:deptCus.customerId]));
			deptAndCustomer = EntityUtil.getFirst(delegator.findByAnd("QzDeptAndCustomerView",[customerId:deptCus.customerId]));
			
			CusIntegral = 0;
			CusStepNumber= 0;
			for(GenericValue gv:itemList){
				integral = 0 ;
				stepNumber = new BigDecimal(gv.stepNumber);
				CusStepNumber = CusStepNumber+stepNumber;
//				Debug.log("stepNumber>>>>>>"+stepNumber);
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
			totalIntegral = totalIntegral +CusIntegral;
			totalStepNumber = totalStepNumber +CusStepNumber;
		}
		deptMap.put("integral",new BigDecimal(totalIntegral).setScale(0, RoundingMode.HALF_UP));
		deptMap.put("stepNumber",new BigDecimal(totalStepNumber));
		companyName = "";
		deptName = "";
		if(UtilValidate.isNotEmpty(companyAndDept)){
			companyName = companyAndDept.companyName;
			deptName = companyAndDept.deptName;
		}
		deptMap.put("companyName",companyName);
		deptMap.put("deptName",deptName);
		outputList2.add(deptMap);
	}
	Debug.log("到处结果完毕");
	outputList2 = OfbizExtUtil.reloadOrder(outputList2,"integral");
	outputList = OfbizExtUtil.reloadOrder(outputList,"integral");
	outputMap.outputList=outputList;//个人赛事结果集
	outputMap.outputList2=outputList2;//团队赛事结果集
	return outputMap;