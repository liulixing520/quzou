package com.mobileStore.product;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.ObjectType;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilNumber;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityExpr;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.order.shoppingcart.CartItemModifyException;
import org.ofbiz.order.shoppingcart.MultiCheckOutEvents;
import org.ofbiz.order.shoppingcart.MultiShoppingCartEvents;
import org.ofbiz.order.shoppingcart.MultiWebShoppingCart;
import org.ofbiz.order.shoppingcart.ShoppingCart;
import org.ofbiz.order.shoppingcart.ShoppingCartHelper;
import org.ofbiz.order.shoppingcart.ShoppingCartItem;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.product.config.ProductConfigWorker;
import org.ofbiz.product.config.ProductConfigWrapper;
import org.ofbiz.product.product.ProductWorker;
import org.ofbiz.product.store.ProductStoreSurveyWrapper;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.product.store.ProductStoreWorkerExt;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.webapp.control.RequestHandler;

public class ProductEvents {

	private static final String module = ProductEvents.class.getName();

	public static String searchSuggestion(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String keyword = request.getParameter("keyword");
		List<Map<String, Object>> a = FastList.newInstance();
		try {
			if (keyword != null && !keyword.trim().equals("")) {
				EntityFindOptions efo = new EntityFindOptions();
				efo.setDistinct(true);
				efo.setMaxRows(6);
				List<EntityExpr> keyConds = UtilMisc.toList(EntityCondition.makeCondition("productName", EntityOperator.LIKE, "%" + keyword + "%"), EntityCondition.makeCondition("internalName", EntityOperator.LIKE, "%" + keyword + "%"), EntityCondition.makeCondition("productNameZh", EntityOperator.LIKE, "%" + keyword + "%"));
				List<GenericValue> eli = delegator.findList("FilterProductView", EntityCondition.makeCondition(keyConds, EntityOperator.OR), UtilMisc.toSet("internalName"), UtilMisc.toList("-productId"), efo, false);
				for (GenericValue gv : eli) {
					Map<String, Object> m = FastMap.newInstance();
					String name = gv.getString("productName");
					if (name == null)
						name = gv.getString("productNameZh");
					if (name == null)
						name = gv.getString("internalName");
					m.put("wname", name);
					a.add(m);
				}
			}
		} catch (Exception e) {

		}
		request.setAttribute("searchTipList", a);
		return "success";
	}

	public static String AjaxFilterProdsList(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Object totalProdInfoList = session.getAttribute("totalProdInfoList");
		Object showProdInfoList = session.getAttribute("showProdInfoList");
		String oper = request.getParameter("oper");
		if (oper == null) {
			return "error";
		}
		try {
			if (oper.equals("PAGE_ADD")) {
				if (showProdInfoList == null) {
					return "error";
				}
				String pageStr = request.getParameter("page");
				int page = Integer.parseInt(pageStr);
				List<Map<String, Object>> prodInfoList = (List<Map<String, Object>>) showProdInfoList;
				int listSize = prodInfoList.size();
				int totalPage = listSize / 15;
				if (listSize % 15 != 0)
					totalPage++;
				if (page > totalPage) {
					page = totalPage;
				}
				List<Map<String, Object>> returnList = FastList.newInstance();
				for (int i = 0; i < listSize; i++) {
					if (i >= (page - 1) * 15 && i < page * 15)
						returnList.add(prodInfoList.get(i));
				}
				request.setAttribute("showProdInfoList", returnList);
			}
			if (oper.equals("ATTR_FILTER")) {
				if (totalProdInfoList == null) {
					return "error";
				}
				List<Map<String, Object>> returnList = FastList.newInstance();
				List<Map<String, Object>> totalList = (List<Map<String, Object>>) totalProdInfoList;
				String expressionKey = request.getParameter("expressionKey");
				boolean hasAvailableAttr = false;
				Map<String, String> filterMap = FastMap.newInstance();
				if (expressionKey != null && !expressionKey.trim().equals("")) {
					String[] attriKVArr = expressionKey.split(",");
					for (String attriKV : attriKVArr) {
						String[] attr_k_v = attriKV.split(":");
						if (attr_k_v.length == 2) {
							String attrName = attr_k_v[0].trim();
							String attrValue = attr_k_v[1].trim();
							if (!attrName.equals("") && !attrValue.equals("")) {
								hasAvailableAttr = true;
								filterMap.put(attrName, attrValue);
							}
						}
					}
				}
				if (hasAvailableAttr) {
					for (Map<String, Object> prodInfo : totalList) {
						Map<String, String> attrInfo = (Map<String, String>) prodInfo.get("attrInfo");
						for (Map.Entry<String, String> entry : attrInfo.entrySet()) {
							String key = entry.getKey();
							String val = entry.getValue();
							if (filterMap.containsKey(key) && filterMap.get(key).equals(val)) {
								if (!returnList.contains(prodInfo))
									returnList.add(prodInfo);
							}
						}
					}
				}
				String sort = request.getParameter("sort");
				if (returnList.size() > 0 && sort != null && !sort.trim().equals("")) {
					if (sort.equals("1")) {
						// 销量
						Collections.sort(returnList, new Comparator<Map<String, Object>>() {
							public int compare(Map<String, Object> b1, Map<String, Object> b2) {
								return ((BigDecimal) b1.get("saleQuantity")).compareTo((BigDecimal) b2.get("saleQuantity"));
							}
						});
					}
					if (sort.equals("2")) {
						// 价格高低
						Collections.sort(returnList, new Comparator<Map<String, Object>>() {
							public int compare(Map<String, Object> b1, Map<String, Object> b2) {
								return ((BigDecimal) b2.get("price")).compareTo((BigDecimal) b1.get("price"));
							}
						});
					}
					if (sort.equals("3")) {
						// 价格低高
						Collections.sort(returnList, new Comparator<Map<String, Object>>() {
							public int compare(Map<String, Object> b1, Map<String, Object> b2) {
								return ((BigDecimal) b1.get("price")).compareTo((BigDecimal) b2.get("price"));
							}
						});
					}
					if (sort.equals("4")) {
						// 评价数 销量暂代
						Collections.sort(returnList, new Comparator<Map<String, Object>>() {
							public int compare(Map<String, Object> b1, Map<String, Object> b2) {
								return ((BigDecimal) b1.get("saleQuantity")).compareTo((BigDecimal) b2.get("saleQuantity"));
							}
						});
					}
				}
				session.setAttribute("showProdInfoList", returnList);

				for (int i = 0; i < returnList.size(); i++) {
					if (i >= 15)
						returnList.remove(i);
				}
				request.setAttribute("showProdInfoList", returnList);
			}
		} catch (Exception e) {
			Debug.logError(e, module);
			return "error";
		}
		return "success";
	}

	public static String quickOrderInfo(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		HttpSession session = request.getSession();
		String productId = request.getParameter("add_product_id");
		String number = request.getParameter("quantity");
		BigDecimal quantity = new BigDecimal(1);
		if (number != null) {
			quantity = new BigDecimal(number);
		}
		if (productId == null || productId.trim().equals("")) {
			request.setAttribute("_ERROR_MESSAGE_", "产品标识丢失，请重试！");
			return "error";
		}
		String productStoreId = ProductStoreWorkerExt.getProductCurrentStoreId(request, productId);
		ShoppingCart cart = new MultiWebShoppingCart(request, null, null, productStoreId);

		Map<String, Object> result = null;
		String parentProductId = null;
		String itemType = null;
		String itemDescription = null;
		String productCategoryId = null;
		String priceStr = null;
		BigDecimal price = null;
		String quantityStr = null;
		String reservStartStr = null;
		String reservEndStr = null;
		Timestamp reservStart = null;
		Timestamp reservEnd = null;
		String reservLengthStr = null;
		BigDecimal reservLength = null;
		String reservPersonsStr = null;
		BigDecimal reservPersons = null;
		String accommodationMapId = null;
		String accommodationSpotId = null;
		String shipBeforeDateStr = null;
		String shipAfterDateStr = null;
		Timestamp shipBeforeDate = null;
		Timestamp shipAfterDate = null;
		String numberOfDay = null;

		// not used right now: Map attributes = null;
		String catalogId = CatalogWorker.getCurrentCatalogId(request);
		Locale locale = UtilHttp.getLocale(request);

		// Get the parameters as a MAP, remove the productId and quantity
		// params.
		Map<String, Object> paramMap = UtilHttp.getCombinedMap(request);

		String itemGroupNumber = (String) paramMap.get("itemGroupNumber");

		// Get shoppingList info if passed
		String shoppingListId = (String) paramMap.get("shoppingListId");
		String shoppingListItemSeqId = (String) paramMap.get("shoppingListItemSeqId");
		if (paramMap.containsKey("ADD_PRODUCT_ID")) {
			productId = (String) paramMap.remove("ADD_PRODUCT_ID");
		} else if (paramMap.containsKey("add_product_id")) {
			Object object = paramMap.remove("add_product_id");
			try {
				productId = (String) object;
			} catch (ClassCastException e) {
				List<String> productList = UtilGenerics.checkList(object);
				productId = productList.get(0);
			}
		}
		if (paramMap.containsKey("PRODUCT_ID")) {
			parentProductId = (String) paramMap.remove("PRODUCT_ID");
		} else if (paramMap.containsKey("product_id")) {
			parentProductId = (String) paramMap.remove("product_id");
		}

		if (paramMap.containsKey("ADD_CATEGORY_ID")) {
			productCategoryId = (String) paramMap.remove("ADD_CATEGORY_ID");
		} else if (paramMap.containsKey("add_category_id")) {
			productCategoryId = (String) paramMap.remove("add_category_id");
		}
		if (productCategoryId != null && productCategoryId.length() == 0) {
			productCategoryId = null;
		}

		if (paramMap.containsKey("ADD_ITEM_TYPE")) {
			itemType = (String) paramMap.remove("ADD_ITEM_TYPE");
		} else if (paramMap.containsKey("add_item_type")) {
			itemType = (String) paramMap.remove("add_item_type");
		}

		if (UtilValidate.isEmpty(productId)) {
			// before returning error; check make sure we aren't adding a
			// special item type
			if (UtilValidate.isEmpty(itemType)) {
				request.setAttribute("_ERROR_MESSAGE_", "没有找到商品信息");
				return "error"; // not critical return to same page
			}
		} else {
			try {
				String pId = ProductWorker.findProductId(delegator, productId);
				if (pId != null) {
					productId = pId;
				}
			} catch (Throwable e) {
				Debug.logWarning(e, module);
			}
		}

		// check for an itemDescription
		if (paramMap.containsKey("ADD_ITEM_DESCRIPTION")) {
			itemDescription = (String) paramMap.remove("ADD_ITEM_DESCRIPTION");
		} else if (paramMap.containsKey("add_item_description")) {
			itemDescription = (String) paramMap.remove("add_item_description");
		}
		if (itemDescription != null && itemDescription.length() == 0) {
			itemDescription = null;
		}
		ShoppingCartHelper cartHelper = new ShoppingCartHelper(delegator, dispatcher, cart);

		// Get the ProductConfigWrapper (it's not null only for configurable
		// items)
		ProductConfigWrapper configWrapper = null;
		configWrapper = ProductConfigWorker.getProductConfigWrapper(productId, cart.getCurrency(), request);

		if (configWrapper != null) {
			if (paramMap.containsKey("configId")) {
				try {
					configWrapper.loadConfig(delegator, (String) paramMap.remove("configId"));
				} catch (Exception e) {
					Debug.logWarning(e, "Could not load configuration", module);
				}
			} else {
				// The choices selected by the user are taken from request and
				// set in the wrapper
				ProductConfigWorker.fillProductConfigWrapper(configWrapper, request);
			}
			if (!configWrapper.isCompleted()) {
				// The configuration is not valid
				request.setAttribute("product_id", productId);
				request.setAttribute("_EVENT_MESSAGE_", "configWrapper出错");
				return "error";
			} else {
				// load the Config Id
				ProductConfigWorker.storeProductConfigWrapper(configWrapper, delegator);
			}
		}

		// Check for virtual products
		if (ProductWorker.isVirtual(delegator, productId)) {

			if ("VV_FEATURETREE".equals(ProductWorker.getProductVirtualVariantMethod(delegator, productId))) {
				// get the selected features.
				List<String> selectedFeatures = new LinkedList<String>();
				Enumeration<String> paramNames = UtilGenerics.cast(request.getParameterNames());
				while (paramNames.hasMoreElements()) {
					String paramName = paramNames.nextElement();
					if (paramName.startsWith("FT")) {
						selectedFeatures.add(request.getParameterValues(paramName)[0]);
					}
				}

				// check if features are selected
				if (UtilValidate.isEmpty(selectedFeatures)) {
					request.setAttribute("paramMap", paramMap);
					request.setAttribute("product_id", productId);
					request.setAttribute("_EVENT_MESSAGE_", "----------------------selectedFeatures");
					return "error";
				}

				String variantProductId = ProductWorker.getVariantFromFeatureTree(productId, selectedFeatures, delegator);
				if (UtilValidate.isNotEmpty(variantProductId)) {
					productId = variantProductId;
				} else {
					request.setAttribute("paramMap", paramMap);
					request.setAttribute("product_id", productId);
					request.setAttribute("_EVENT_MESSAGE_", "------------------------variantProductId");
					return "error";
				}

			} else {
				request.setAttribute("paramMap", paramMap);
				request.setAttribute("product_id", productId);
				request.setAttribute("_EVENT_MESSAGE_", "------------------------VV_FEATURETREE");
				return "error";
			}
		}

		// get the override price
		if (paramMap.containsKey("PRICE")) {
			priceStr = (String) paramMap.remove("PRICE");
		} else if (paramMap.containsKey("price")) {
			priceStr = (String) paramMap.remove("price");
		}
		if (priceStr == null) {
			priceStr = "0"; // default price is 0
		}

		if ("ASSET_USAGE_OUT_IN".equals(ProductWorker.getProductTypeId(delegator, productId))) {
			if (paramMap.containsKey("numberOfDay")) {
				numberOfDay = (String) paramMap.remove("numberOfDay");
				reservStart = UtilDateTime.addDaysToTimestamp(UtilDateTime.nowTimestamp(), 1);
				reservEnd = UtilDateTime.addDaysToTimestamp(reservStart, Integer.valueOf(numberOfDay));
			}
		}

		// get the renting data
		if ("ASSET_USAGE".equals(ProductWorker.getProductTypeId(delegator, productId)) || "ASSET_USAGE_OUT_IN".equals(ProductWorker.getProductTypeId(delegator, productId))) {
			if (paramMap.containsKey("reservStart")) {
				reservStartStr = (String) paramMap.remove("reservStart");
				if (reservStartStr.length() == 10)
					reservStartStr += " 00:00:00.000000000";
				if (reservStartStr.length() > 0) {
					try {
						reservStart = java.sql.Timestamp.valueOf(reservStartStr);
					} catch (Exception e) {
						Debug.logWarning(e, "Problems parsing Reservation start string: " + reservStartStr, module);
						reservStart = null;
						request.setAttribute("_ERROR_MESSAGE_", "----------------------------reservStartStr");
						return "error";
					}
				} else
					reservStart = null;
			}

			if (paramMap.containsKey("reservEnd")) {
				reservEndStr = (String) paramMap.remove("reservEnd");
				if (reservEndStr.length() == 10)
					reservEndStr += " 00:00:00.000000000";
				if (reservEndStr.length() > 0) {
					try {
						reservEnd = java.sql.Timestamp.valueOf(reservEndStr);
					} catch (Exception e) {
						Debug.logWarning(e, "Problems parsing Reservation end string: " + reservEndStr, module);
						reservEnd = null;
						request.setAttribute("_ERROR_MESSAGE_", "-----------------------------reservEnd");
						return "error";
					}
				} else
					reservEnd = null;
			}

			if (reservStart != null && reservEnd != null) {
				reservLength = new BigDecimal(UtilDateTime.getInterval(reservStart, reservEnd)).divide(new BigDecimal("86400000"));
			}

			if (reservStart != null && paramMap.containsKey("reservLength")) {
				reservLengthStr = (String) paramMap.remove("reservLength");
				// parse the reservation Length
				try {
					reservLength = (BigDecimal) ObjectType.simpleTypeConvert(reservLengthStr, "BigDecimal", null, locale);
				} catch (Exception e) {
					Debug.logWarning(e, "Problems parsing reservation length string: " + reservLengthStr, module);
					reservLength = BigDecimal.ONE;
					request.setAttribute("_ERROR_MESSAGE_", "------------------------reservStart");
					return "error";
				}
			}

			if (reservStart != null && paramMap.containsKey("reservPersons")) {
				reservPersonsStr = (String) paramMap.remove("reservPersons");
				// parse the number of persons
				try {
					reservPersons = (BigDecimal) ObjectType.simpleTypeConvert(reservPersonsStr, "BigDecimal", null, locale);
				} catch (Exception e) {
					Debug.logWarning(e, "Problems parsing reservation number of persons string: " + reservPersonsStr, module);
					reservPersons = BigDecimal.ONE;
					request.setAttribute("_ERROR_MESSAGE_", "---------------------------------reservPersons");
					return "error";
				}
			}

			// check for valid rental parameters
			if (UtilValidate.isEmpty(reservStart) && UtilValidate.isEmpty(reservLength) && UtilValidate.isEmpty(reservPersons)) {
				request.setAttribute("product_id", productId);
				request.setAttribute("_EVENT_MESSAGE_", "---------------------------------------reservLength");
				return "error";
			}

			// check accommodation for reservations
			if ((paramMap.containsKey("accommodationMapId")) && (paramMap.containsKey("accommodationSpotId"))) {
				accommodationMapId = (String) paramMap.remove("accommodationMapId");
				accommodationSpotId = (String) paramMap.remove("accommodationSpotId");
			}
		}

		// get the quantity
		if (paramMap.containsKey("QUANTITY")) {
			quantityStr = (String) paramMap.remove("QUANTITY");
		} else if (paramMap.containsKey("quantity")) {
			quantityStr = (String) paramMap.remove("quantity");
		}
		if (UtilValidate.isEmpty(quantityStr)) {
			quantityStr = "1"; // default quantity is 1
		}

		// parse the price
		try {
			price = (BigDecimal) ObjectType.simpleTypeConvert(priceStr, "BigDecimal", null, locale);
		} catch (Exception e) {
			Debug.logWarning(e, "Problems parsing price string: " + priceStr, module);
			price = null;
		}

		// parse the quantity
		try {
			quantity = (BigDecimal) ObjectType.simpleTypeConvert(quantityStr, "BigDecimal", null, locale);
			// For quantity we should test if we allow to add decimal quantity
			// for this product an productStore : if not then round to 0
			if (!ProductWorker.isDecimalQuantityOrderAllowed(delegator, productId, cart.getProductStoreId())) {
				quantity = quantity.setScale(0, UtilNumber.getBigDecimalRoundingMode("order.rounding"));
			} else {
				quantity = quantity.setScale(UtilNumber.getBigDecimalScale("order.decimals"), UtilNumber.getBigDecimalRoundingMode("order.rounding"));
			}
		} catch (Exception e) {
			Debug.logWarning(e, "Problems parsing quantity string: " + quantityStr, module);
			quantity = BigDecimal.ONE;
		}

		// get the selected amount
		String selectedAmountStr = null;
		if (paramMap.containsKey("ADD_AMOUNT")) {
			selectedAmountStr = (String) paramMap.remove("ADD_AMOUNT");
		} else if (paramMap.containsKey("add_amount")) {
			selectedAmountStr = (String) paramMap.remove("add_amount");
		}

		// parse the amount
		BigDecimal amount = null;
		if (UtilValidate.isNotEmpty(selectedAmountStr)) {
			try {
				amount = (BigDecimal) ObjectType.simpleTypeConvert(selectedAmountStr, "BigDecimal", null, locale);
			} catch (Exception e) {
				Debug.logWarning(e, "Problem parsing amount string: " + selectedAmountStr, module);
				amount = null;
			}
		} else {
			amount = BigDecimal.ZERO;
		}

		// check for required amount
		if ((ProductWorker.isAmountRequired(delegator, productId)) && (amount == null || amount.doubleValue() == 0.0)) {
			request.setAttribute("product_id", productId);
			request.setAttribute("_EVENT_MESSAGE_", "--------------------------------------");
			return "product";
		}

		// get the ship before date (handles both yyyy-mm-dd input and full
		shipBeforeDateStr = (String) paramMap.remove("shipBeforeDate");
		if (UtilValidate.isNotEmpty(shipBeforeDateStr)) {
			if (shipBeforeDateStr.length() == 10)
				shipBeforeDateStr += " 00:00:00.000";
			try {
				shipBeforeDate = java.sql.Timestamp.valueOf(shipBeforeDateStr);
			} catch (IllegalArgumentException e) {
				Debug.logWarning(e, "Bad shipBeforeDate input: " + e.getMessage(), module);
				shipBeforeDate = null;
			}
		}

		// get the ship after date (handles both yyyy-mm-dd input and full
		// timestamp)
		shipAfterDateStr = (String) paramMap.remove("shipAfterDate");
		if (UtilValidate.isNotEmpty(shipAfterDateStr)) {
			if (shipAfterDateStr.length() == 10)
				shipAfterDateStr += " 00:00:00.000";
			try {
				shipAfterDate = java.sql.Timestamp.valueOf(shipAfterDateStr);
			} catch (IllegalArgumentException e) {
				Debug.logWarning(e, "Bad shipAfterDate input: " + e.getMessage(), module);
				shipAfterDate = null;
			}
		}

		// check for an add-to cart survey
		List<String> surveyResponses = null;
		if (productId != null) {
			// String productStoreId =
			// ProductStoreWorker.getProductStoreId(request);
			List<GenericValue> productSurvey = ProductStoreWorker.getProductSurveys(delegator, productStoreId, productId, "CART_ADD", parentProductId);
			if (UtilValidate.isNotEmpty(productSurvey)) {
				// TODO: implement multiple survey per product
				GenericValue survey = EntityUtil.getFirst(productSurvey);
				String surveyResponseId = (String) request.getAttribute("surveyResponseId");
				if (surveyResponseId != null) {
					surveyResponses = UtilMisc.toList(surveyResponseId);
				} else {
					String origParamMapId = UtilHttp.stashParameterMap(request);
					Map<String, Object> surveyContext = UtilMisc.<String, Object> toMap("_ORIG_PARAM_MAP_ID_", origParamMapId);
					GenericValue userLogin = cart.getUserLogin();
					String partyId = null;
					if (userLogin != null) {
						partyId = userLogin.getString("partyId");
					}
					String formAction = "/additemsurvey";
					String nextPage = RequestHandler.getOverrideViewUri(request.getPathInfo());
					if (nextPage != null) {
						formAction = formAction + "/" + nextPage;
					}
					ProductStoreSurveyWrapper wrapper = new ProductStoreSurveyWrapper(survey, partyId, surveyContext);
					request.setAttribute("surveyWrapper", wrapper);
					request.setAttribute("surveyAction", formAction);
					return "survey";
				}
			}
		}
		if (surveyResponses != null) {
			paramMap.put("surveyResponses", surveyResponses);
		}

		GenericValue productStore = ProductStoreWorker.getProductStore(request);
		if (productStore != null) {
			String addToCartRemoveIncompat = productStore.getString("addToCartRemoveIncompat");
			String addToCartReplaceUpsell = productStore.getString("addToCartReplaceUpsell");
			try {
				if ("Y".equals(addToCartRemoveIncompat)) {
					List<GenericValue> productAssocs = null;
					EntityCondition cond = EntityCondition.makeCondition(UtilMisc.toList(EntityCondition.makeCondition(EntityCondition.makeCondition("productId", EntityOperator.EQUALS, productId), EntityOperator.OR, EntityCondition.makeCondition("productIdTo", EntityOperator.EQUALS, productId)), EntityCondition.makeCondition("productAssocTypeId", EntityOperator.EQUALS, "PRODUCT_INCOMPATABLE")), EntityOperator.AND);
					productAssocs = delegator.findList("ProductAssoc", cond, null, null, null, false);
					productAssocs = EntityUtil.filterByDate(productAssocs);
					List<String> productList = FastList.newInstance();
					for (GenericValue productAssoc : productAssocs) {
						if (productId.equals(productAssoc.getString("productId"))) {
							productList.add(productAssoc.getString("productIdTo"));
							continue;
						}
						if (productId.equals(productAssoc.getString("productIdTo"))) {
							productList.add(productAssoc.getString("productId"));
							continue;
						}
					}
					for (ShoppingCartItem sci : cart) {
						if (productList.contains(sci.getProductId())) {
							try {
								cart.removeCartItem(sci, dispatcher);
							} catch (CartItemModifyException e) {
								Debug.logError(e.getMessage(), module);
							}
						}
					}
				}
				if ("Y".equals(addToCartReplaceUpsell)) {
					List<GenericValue> productList = null;
					EntityCondition cond = EntityCondition.makeCondition(UtilMisc.toList(EntityCondition.makeCondition("productIdTo", EntityOperator.EQUALS, productId), EntityCondition.makeCondition("productAssocTypeId", EntityOperator.EQUALS, "PRODUCT_UPGRADE")), EntityOperator.AND);
					productList = delegator.findList("ProductAssoc", cond, UtilMisc.toSet("productId"), null, null, false);
					if (productList != null) {
						for (ShoppingCartItem sci : cart) {
							if (productList.contains(sci.getProductId())) {
								try {
									cart.removeCartItem(sci, dispatcher);
								} catch (CartItemModifyException e) {
									Debug.logError(e.getMessage(), module);
								}
							}
						}
					}
				}
			} catch (GenericEntityException e) {
				Debug.logError(e.getMessage(), module);
			}
		}

		// check for alternative packing
		if (ProductWorker.isAlternativePacking(delegator, productId, parentProductId)) {
			GenericValue parentProduct = null;
			try {
				parentProduct = delegator.findOne("Product", UtilMisc.toMap("productId", parentProductId), false);
			} catch (GenericEntityException e) {
				Debug.logError(e, "Error getting parent product", module);
			}
			BigDecimal piecesIncluded = BigDecimal.ZERO;
			if (parentProduct != null) {
				piecesIncluded = new BigDecimal(parentProduct.getLong("piecesIncluded"));
				quantity = quantity.multiply(piecesIncluded);
			}
		}

		// Translate the parameters and add to the cart
		result = cartHelper.addToCart(catalogId, shoppingListId, shoppingListItemSeqId, productId, productCategoryId, itemType, itemDescription, price, amount, quantity, reservStart, reservLength, reservPersons, accommodationMapId, accommodationSpotId, shipBeforeDate, shipAfterDate, configWrapper, itemGroupNumber, paramMap, parentProductId);

		Integer itemId = (Integer) result.get("itemId");
		if (UtilValidate.isNotEmpty(itemId)) {
			request.setAttribute("itemId", itemId);
		}
		if (cart.size() < 1) {
			return "error";
		}
		session.setAttribute("quickOrderCart", cart);
		session.setAttribute("orderFrom", "QUICK_ORDER");
		Object defaultContactMechId = session.getAttribute("defaultContactMechId");
		if (defaultContactMechId != null) {
			return "prodsSettlement";
		} else {
			return "shipInfo";
		}
	}

	public static String checkoutCart(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.removeAttribute("orderFrom");
		String setResult = MultiCheckOutEvents.setCheckOutPages(request, response);
		Object defaultContactMechId = session.getAttribute("defaultContactMechId");
		if (defaultContactMechId != null) {
			return setResult;
		} else {
			return "shipInfo";
		}
	}

	public static String setDefaultContactMechId(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String contactMechId = request.getParameter("contactMechId");
		if (contactMechId == null || contactMechId.trim().equals("")) {
			request.setAttribute("_ERROR_MESSAGE_", "收货地址标识丢失，请重试！");
			return "error";
		}
		session.setAttribute("defaultContactMechId", contactMechId);
		return "success";
	}

	public static String modifyProductQuantity(HttpServletRequest request, HttpServletResponse response) {
		MultiShoppingCartEvents.addToCart(request, response);
		return "success";
	}
}