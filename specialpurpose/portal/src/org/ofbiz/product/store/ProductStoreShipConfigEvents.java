package org.ofbiz.product.store;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;

public class ProductStoreShipConfigEvents {

	public static final String module = ProductStoreShipConfigEvents.class.getName();

	public static String delShipCostConfig(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String productStoreShipMethId = request.getParameter("productStoreShipMethId");
		String shippingCountry = request.getParameter("shippingCountry");
		String shippingProvince = request.getParameter("shippingProvince");
		if (productStoreShipMethId != null && shippingCountry != null && shippingProvince != null) {
			try {
				GenericValue productStoreShipConfig = delegator.findOne("ProductStoreShipConfig", false, UtilMisc.toMap("productStoreShipMethId", productStoreShipMethId, "shippingProvince", shippingProvince, "shippingCountry", shippingCountry));
				if (productStoreShipConfig == null) {
					request.setAttribute("info", "没有找到配置信息！");
					return "success";
				} else {
					productStoreShipConfig.remove();
				}
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
			}
		} else {
			request.setAttribute("info", "没有找到配置信息！");
			return "success";
		}
		return "success";
	}

	public static String modifyShipCostConfig(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String productStoreShipMethId = request.getParameter("productStoreShipMethId");
		String shippingCountry = request.getParameter("shippingCountry");
		String shippingProvince = request.getParameter("shippingProvince");
		String firstWeight = request.getParameter("firstWeight");
		String firstCost = request.getParameter("firstCost");
		String addWeight = request.getParameter("addWeight");
		String addCost = request.getParameter("addCost");
		String currencyUomId = request.getParameter("currencyUomId");
		if (productStoreShipMethId != null && shippingCountry != null && shippingProvince != null) {
			try {
				GenericValue productStoreShipConfig = delegator.findOne("ProductStoreShipConfig", false, UtilMisc.toMap("productStoreShipMethId", productStoreShipMethId, "shippingProvince", shippingProvince, "shippingCountry", shippingCountry));
				if (productStoreShipConfig == null) {
					request.setAttribute("info", "没有找到配置信息！");
					return "success";
				} else {
					productStoreShipConfig.set("firstWeight", new BigDecimal(firstWeight));
					productStoreShipConfig.set("firstCost", new BigDecimal(firstCost));
					productStoreShipConfig.set("addWeight", new BigDecimal(addWeight));
					productStoreShipConfig.set("addCost", new BigDecimal(addCost));
					productStoreShipConfig.set("currencyUomId", currencyUomId);
					productStoreShipConfig.store();
				}
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
				request.setAttribute("info", e.getMessage());
				return "success";
			}
		} else {
			request.setAttribute("info", "没有找到配置信息！");
			return "success";
		}
		return "success";
	}

	public static String createShipConfig(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String productStoreShipMethId = request.getParameter("productStoreShipMethId");
		String ids = request.getParameter("ids");
		String regionName = request.getParameter("regionName");
		String firstWeight = request.getParameter("firstWeight");
		String firstCost = request.getParameter("firstCost");
		String addWeight = request.getParameter("addWeight");
		String addCost = request.getParameter("addCost");
		String currencyUomId = request.getParameter("currencyUomId");

		String shippingCountry = null;
		String shippingProvince = null;
		for (String id : ids.split(",")) {
			if (regionName.equals("CHN")) {
				shippingCountry = "CHN";
				shippingProvince = id;
			} else {
				shippingCountry = id;
				shippingProvince = "_NA_";
			}
			try {
				delegator.create("ProductStoreShipConfig", UtilMisc.toMap("productStoreShipMethId", productStoreShipMethId, "shippingCountry", shippingCountry, "shippingProvince", shippingProvince, "firstWeight", new BigDecimal(firstWeight), "firstCost", new BigDecimal(firstCost), "addWeight", new BigDecimal(addWeight), "addCost", new BigDecimal(addCost), "currencyUomId", currencyUomId));
			} catch (GenericEntityException e) {
				Debug.logError(e, module);
				request.setAttribute("info", e.getMessage());
				return "success";
			}
		}
		return "success";
	}

}