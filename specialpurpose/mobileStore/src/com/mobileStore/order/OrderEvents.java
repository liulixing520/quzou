package com.mobileStore.order;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;

import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceAuthException;
import org.ofbiz.service.ServiceValidationException;

public class OrderEvents {
	private static final String module = OrderEvents.class.getName();

	public static String orderCancel(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String orderId = request.getParameter("orderId");
		List<Map<String, Object>> a = FastList.newInstance();
		try {
			if (orderId != null && !orderId.trim().equals("")) {
				GenericValue oh = delegator.findOne("OrderHeader", false, UtilMisc.toMap("orderId", orderId));
				if (oh != null) {
					oh.set("statusId", "ORDER_CANCELLED");
				}
				oh.store();
			}
		} catch (Exception e) {

		}
		return "success";
	}

	public static String shippingAddressCU(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		HttpSession session = request.getSession();
		GenericValue userLogin = (GenericValue) session.getAttribute("userLogin");
		String contactMechId = request.getParameter("contactMechId");

		String partyId = userLogin.getString("partyId");
		String userLoginId = userLogin.getString("userLoginId");
		Map<String, Object> context = UtilHttp.getParameterMap(request);
		context.put("partyId", partyId);
		context.put("userLoginId", userLoginId);
		context.put("userLogin", userLogin);
		try {
			if (contactMechId == null || contactMechId.trim().equals("")) {
				ModelService pService = dispatcher.getDispatchContext().getModelService("createPostalAddress");
				Map<String, Object> paramMap = pService.makeValid(context, ModelService.IN_PARAM);
				Map<String, Object> resultMap1 = dispatcher.runSync("createPostalAddress", paramMap);
				contactMechId = (String) resultMap1.get("contactMechId");
				context.put("contactMechId", contactMechId);
				ModelService pService1 = dispatcher.getDispatchContext().getModelService("createPartyContactMech");
				Map<String, Object> paramMap1 = pService1.makeValid(context, ModelService.IN_PARAM);
				dispatcher.runSync("createPartyContactMech", paramMap1);
			} else {
				GenericValue pa = delegator.findOne("PostalAddress", false, UtilMisc.toMap("contactMechId", contactMechId));
				pa.setNonPKFields(context);
				pa.store();
			}
		} catch (ServiceAuthException e) {
			e.printStackTrace();
			return "error";
		} catch (ServiceValidationException e) {
			e.printStackTrace();
			return "error";
		} catch (GenericServiceException e) {
			e.printStackTrace();
			return "error";
		} catch (GenericEntityException e) {
			e.printStackTrace();
			return "error";
		}
		if (contactMechId != null) {
			session.setAttribute("defaultContactMechId", contactMechId);
		}
		return "success";
	}
}
