package org.ofbiz.product.store;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

public class StoreServices {
	public static final String module = StoreServices.class.getName();
	public static final String LABEL_RESOURCE = "CmsUiLabels";
	private static String ofbizHome = System.getProperty("ofbiz.home");
	public static final String DATE_FOLDER_FORMAT = "yyyyMMdd";

	public static final Boolean useDebug = UtilProperties.getPropertyAsBoolean("contentUpload.properties", "isable.debug.config", false);

	public static Map<String, Object> calculateShipCost(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException {

		Delegator delegator = dctx.getDelegator();
		BigDecimal shippingEstimateAmount = BigDecimal.ZERO;

		try {
			Object productStoreShipMethId = context.get("productStoreShipMethId");
			Object shippingContactMechId = context.get("shippingContactMechId");
			if (productStoreShipMethId != null && shippingContactMechId != null) {
				GenericValue address = delegator.findOne("PostalAddress", true, UtilMisc.toMap("contactMechId", shippingContactMechId));
				if (address != null) {
					String countryGeoId = address.getString("countryGeoId");
					String stateProvinceGeoId = address.getString("stateProvinceGeoId");
					if (countryGeoId == null) {
						countryGeoId = "CHN";
					}
					if (!countryGeoId.equals("CHN")) {
						stateProvinceGeoId = "_NA_";
					}
					GenericValue productStoreShipConfig = delegator.findOne("ProductStoreShipConfig", false, UtilMisc.toMap("productStoreShipMethId", productStoreShipMethId, "shippingCountry", countryGeoId, "shippingProvince", stateProvinceGeoId));
					if (productStoreShipConfig != null) {
						BigDecimal firstWeight = productStoreShipConfig.getBigDecimal("firstWeight");
						BigDecimal firstCost = productStoreShipConfig.getBigDecimal("firstCost");
						BigDecimal addWeight = productStoreShipConfig.getBigDecimal("addWeight");
						BigDecimal addCost = productStoreShipConfig.getBigDecimal("addCost");
						BigDecimal totalWeight = BigDecimal.ZERO;
						List<Map<String, Object>> shippableItemInfo = (List<Map<String, Object>>) context.get("shippableItemInfo");
						if (shippableItemInfo != null) {
							for (Map<String, Object> m : shippableItemInfo) {
								BigDecimal weight = (BigDecimal) m.get("weight");
								BigDecimal quantity = (BigDecimal) m.get("quantity");
								if (weight != null && quantity != null)
									totalWeight = totalWeight.add(weight.multiply(quantity));
							}
						}
						shippingEstimateAmount = shippingEstimateAmount.add(firstCost);
						if (totalWeight.compareTo(firstWeight) > 0) {
							totalWeight = totalWeight.subtract(firstWeight);
							BigDecimal addTimes = totalWeight.divide(addWeight, 2);
							double d = Math.ceil(addTimes.doubleValue());
							addTimes = new BigDecimal(d);
							shippingEstimateAmount = shippingEstimateAmount.add(addTimes.multiply(addCost));
							return UtilMisc.toMap("shippingEstimateAmount", shippingEstimateAmount);
						} else {
							return UtilMisc.toMap("shippingEstimateAmount", shippingEstimateAmount);
						}
					}
				}
			}

		} catch (Exception e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}
		return ServiceUtil.returnError("未找到目标地区运费配置信息！");
	}
}
