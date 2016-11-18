package org.ofbiz.quzou;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.quzou.util.ExportExcel;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class QzCompetitionEvents {

	/**
	 * 导出赛事成绩
	 * 
	 * Create a MemberBase. If no memberId is specified a numeric memberId is
	 * retrieved from the MemberBase sequence.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 */
	public static String exportCompetition(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		String cId = request.getParameter("cId");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		List<String> listOrder = FastList.newInstance();
		listOrder.add("-integral");
		try {
			GenericValue gValue = delegator.findOne("QzCompetition", false, UtilMisc.toMap("cId",cId));
			Map<String, Object> results = dispatcher.runSync("getExportData", UtilMisc.toMap("cId",cId,"startDate",startDate,"endDate",endDate));
			List<Map<String, Object>> list = (List<Map<String, Object>>) results.get("outputList");
			List<Map<String, Object>> list2 = (List<Map<String, Object>>) results.get("outputList2");
			String filedNames = "deptName,userLoginId,integral,stepNumber"; 
			String filedNames2 = "deptName,integral,stepNumber"; 
			ExportExcel.exportExcel(request, response, list, filedNames,list2,filedNames2, (String)gValue.get("cName"));
		} catch (GenericEntityException e) {
			e.printStackTrace();
			return "error";	
		} catch (IOException e) {
			e.printStackTrace();
			return "error";	
		} catch (GenericServiceException e) {
			e.printStackTrace();
			return "error";	
		}
		return "success";
	}
	/**
	 * 导出健走日志
	 * 
	 * Create a MemberBase. If no memberId is specified a numeric memberId is
	 * retrieved from the MemberBase sequence.
	 * 
	 * @param dctx
	 *            The DispatchContext that this service is operating in.
	 * @param context
	 *            Map containing the input parameters.
	 * @return Map with the result of the service, the output parameters.
	 * @throws ParseException 
	 */
	public static String exportLog(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String cardId = request.getParameter("cardId");
		String userLoginId = request.getParameter("userLoginId");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date1 = new java.sql.Date(sdf.parse(startDate).getTime());
		Date date2 = new java.sql.Date(sdf.parse(endDate).getTime());
		List<String> listOrder = FastList.newInstance();
		listOrder.add("-integral");
		try {
			List<EntityExpr> expr2 = FastList.newInstance();
			if(UtilValidate.isNotEmpty(cardId)){
				expr2.add(EntityCondition.makeCondition("cardId", EntityOperator.LIKE, "%"+cardId+"%"));
			}
			if(UtilValidate.isNotEmpty(userLoginId)){
				expr2.add(EntityCondition.makeCondition("userLoginId", EntityOperator.LIKE, "%"+userLoginId+"%"));
			}
			if(UtilValidate.isNotEmpty(startDate)){
				expr2.add(EntityCondition.makeCondition("stepDate", EntityOperator.GREATER_THAN_EQUAL_TO, date1));
			}
			if(UtilValidate.isNotEmpty(endDate)){
				expr2.add(EntityCondition.makeCondition("stepDate", EntityOperator.LESS_THAN_EQUAL_TO, date2));
			}
			
            List<GenericValue> list = delegator.findList("QzCustomerLogView", EntityCondition.makeCondition(expr2), null,UtilMisc.toList("-stepDate"),  null, false);
			String filedNames = "cardId,userLoginId,companyName,stepNumber,stepDate"; 
			ExportExcel.exportLog(request, response, list, filedNames, "日志导出列表");
		} catch (GenericEntityException e) {
			e.printStackTrace();
			return "error";	
		} catch (IOException e) {
			e.printStackTrace();
			return "error";	
		}
		return "success";
	}
	
}
