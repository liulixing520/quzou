

orderFrom = session.getAttribute("orderFrom")//"QUICK_ORDER"

distributorId = (String) session.getAttribute("_DISTRIBUTOR_ID_")
affiliateId = (String) session.getAttribute("_AFFILIATE_ID_")
visitId = VisitHandler.getVisitId(session)
webSiteId = WebSiteWorker.getWebSiteId(request)

shoppingCartMap = MultiShoppingCartEvents.getCartMap(request)
shoppingCartList = shoppingCartMap.getShoppingCartList()
orderIdList = []
for(cart in shoppingCartList){
	if(cart.size()>0){
        session.removeAttribute("_QUICK_REORDER_PRODUCTS_");

        boolean areOrderItemsExploded = explodeOrderItems(delegator, cart);

        //get the TrackingCodeOrder List
        List<GenericValue> trackingCodeOrders = TrackingCodeEvents.makeTrackingCodeOrders(request);
       	session.removeAttribute("_QUICK_REORDER_PRODUCTS_")

		orderId = cart.getOrderId()        
      	supplierPartyId =   cart.getAttribute("supplierPartyId")
       	originOrderId =  cart.getAttribute("originOrderId")
        
        cart.clearAllItemStatus()
        grandTotal = cart.getGrandTotal()
        context = cart.makeCartMap(dispatcher, areOrderItemsExploded)
        context.trackingCodeOrders = trackingCodeOrders
        if (distributorId) context.distributorId= distributorId
        if (affiliateId) context.affiliateId= affiliateId
        context.orderId= orderId
        context.supplierPartyId= supplierPartyId
        context.grandTotal= grandTotal
        context.userLogin= userLogin
        context.visitId= visitId
        if(!webSiteId)webSiteId = cart.getWebSiteId()
        context.webSiteId= webSiteId
        context.originOrderId= originOrderId
		storeResult = dispatcher.runSync("storeOrder", context)
        orderId = (String) storeResult.get("orderId")
        if (orderId) {
            cart.setOrderId(orderId)
            if (!cart.getFirstAttemptOrderId()) {
                cart.setFirstAttemptOrderId(orderId)
            }
        }
        orderItems = UtilGenerics.checkList(context.get("orderItems"))
        counter = 0;
        for(orderItem in orderItems) {
            productId = orderItem.productId
            if(productId){
            	try{
		            permUserLogin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "system"), true)
		            productStore = ProductStoreWorker.getProductStore(productStoreId, delegator)
		            product = delegator.findOne("Product", UtilMisc.toMap("productId", productId), false)
		            if (EntityTypeUtil.hasParentType(delegator, "ProductType", "productTypeId", product.getString("productTypeId"), "parentTypeId", "AGGREGATED")) {
		                org.ofbiz.product.config.ProductConfigWrapper config = this.cart.findCartItem(counter).getConfigWrapper();
		                Map<String, Object> inputMap = new HashMap<String, Object>();
		                inputMap.put("config", config);
		                inputMap.put("facilityId", productStore.getString("inventoryFacilityId"));
		                inputMap.put("orderId", orderId);
		                inputMap.put("orderItemSeqId", orderItem.getString("orderItemSeqId"));
		                inputMap.put("quantity", orderItem.getBigDecimal("quantity"));
		                inputMap.put("userLogin", permUserLogin);
		
		                Map<String, Object> prunResult = dispatcher.runSync("createProductionRunFromConfiguration", inputMap);
		                if (ServiceUtil.isError(prunResult)) {
		                    Debug.logError(ServiceUtil.getErrorMessage(prunResult) + " for input:" + inputMap, module);
		                }
		            }
	            	counter++
            	}catch(Exception e){}
            }
        }
        for(shoppingCartItem in cart.items()) {
            requirementId = shoppingCartItem.getRequirementId()
            if (requirementId) {
                try {
                    Map<String, Object> inputMap = ["requirementId": requirementId, "statusId": "REQ_ORDERED"]
                    inputMap.put("userLogin", userLogin);
                    dispatcher.runSync("updateRequirement", inputMap);
                } catch (Exception e) {
                }
            }
        }
        party = this.delegator.findOne("Party", ["partyId": userLogin.partyId], false)
        toBeStored = []
        if (party) {
            Iterator<GenericValue> emailIter = UtilMisc.toIterator(ContactHelper.getContactMechByType(party, "EMAIL_ADDRESS", false))
            while (emailIter != null && emailIter.hasNext()) {
                GenericValue email = emailIter.next();
                GenericValue orderContactMech = this.delegator.makeValue("OrderContactMech",
                        UtilMisc.toMap("orderId", orderId, "contactMechId", email.getString("contactMechId"), "contactMechPurposeTypeId", "ORDER_EMAIL"));
                toBeStored.add(orderContactMech);
                if (UtilValidate.isEmpty(ContactHelper.getContactMechByPurpose(party, "ORDER_EMAIL", false))) {
                    GenericValue partyContactMechPurpose = this.delegator.makeValue("PartyContactMechPurpose",
                            UtilMisc.toMap("partyId", party.getString("partyId"), "contactMechId", email.getString("contactMechId"), "contactMechPurposeTypeId", "ORDER_EMAIL", "fromDate", UtilDateTime.nowTimestamp()));
                    toBeStored.add(partyContactMechPurpose);
                }
            }
        }
        String additionalEmails = this.cart.getOrderAdditionalEmails()
        List<String> emailList = StringUtil.split(additionalEmails, ",")
        if (emailList == null) emailList = new ArrayList<String>()
        for(String email : emailList) {
            String contactMechId = this.delegator.getNextSeqId("ContactMech")
            GenericValue contactMech = this.delegator.makeValue("ContactMech",
                    UtilMisc.toMap("contactMechId", contactMechId, "contactMechTypeId", "EMAIL_ADDRESS", "infoString", email))

            GenericValue orderContactMech = this.delegator.makeValue("OrderContactMech",
                    UtilMisc.toMap("orderId", orderId, "contactMechId", contactMechId, "contactMechPurposeTypeId", "ORDER_EMAIL"))
            toBeStored.add(contactMech)
            toBeStored.add(orderContactMech)
        }

        if (toBeStored.size() > 0) {
            try {
                this.delegator.storeAll(toBeStored)
            } catch (GenericEntityException e) {
            }
        }
        
        
        
        
        if (callResult != null) {
            ServiceUtil.getMessages(request, callResult, null);
            if (ServiceUtil.isError(callResult)) {
                // messages already setup with the getMessages call, just return the error response code
                return "error";
            }
            if (callResult.get(ModelService.RESPONSE_MESSAGE).equals(ModelService.RESPOND_SUCCESS)) {
                // set the orderId for use by chained events
                String orderId = cart.getOrderId();
                orderIdList.add(orderId);
                request.setAttribute("orderId", orderId);
                request.setAttribute("orderAdditionalEmails", cart.getOrderAdditionalEmails());
            }
        }
        
        String issuerId = request.getParameter("issuerId");
        if (UtilValidate.isNotEmpty(issuerId)) {
            request.setAttribute("issuerId", issuerId);
        }
        

        //return cart.getOrderType().toLowerCase();
	}
}






































