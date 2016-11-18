/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *******************************************************************************/
package org.ofbiz.order.shoppingcart;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.order.shoppingcart.ShoppingCart;
import org.ofbiz.product.store.ProductStoreWorkerExt;
import org.ofbiz.webapp.stats.VisitHandler;
import org.ofbiz.webapp.website.WebSiteWorker;

/**
 * WebShoppingCart.java
 *
 * Extension of {@link org.ofbiz.order.shoppingcart.ShoppingCart ShoppingCart}
 * class which provides web presentation layer specific functionality
 * related specifically to user session information.
 */
@SuppressWarnings("serial")
public class MultiWebShoppingCart extends ShoppingCart {
	
	public MultiWebShoppingCart(HttpServletRequest request, Locale locale, String currencyUom,String productStoreId) {
        // for purchase orders, bill to customer partyId must be set - otherwise, no way to know who we're purchasing for.  supplierPartyId is furnished
        // by order manager for PO entry.
        // TODO: refactor constructor and the getCartObject method which calls them to multiple constructors for different types of orders
        super((Delegator)request.getAttribute("delegator"), ProductStoreWorkerExt.getProductStoreId(request,productStoreId),
                WebSiteWorker.getWebSiteId(request), (locale != null ? locale : ProductStoreWorkerExt.getStoreLocale(request,productStoreId)),
                (currencyUom != null ? currencyUom : ProductStoreWorkerExt.getStoreCurrencyUomId(request,productStoreId)),
                request.getParameter("billToCustomerPartyId"),
                (request.getParameter("supplierPartyId") != null ? request.getParameter("supplierPartyId") : request.getParameter("billFromVendorPartyId")));

        HttpSession session = request.getSession(true);
        this.userLogin = (GenericValue) session.getAttribute("userLogin");
        this.autoUserLogin = (GenericValue) session.getAttribute("autoUserLogin");
        this.orderPartyId = (String) session.getAttribute("orderPartyId");
        String visitId = VisitHandler.getVisitId(session);
		GenericValue visitor = VisitHandler.getVisitor(request, null);
		this.setAddParams("visitId", visitId);
		this.setAddParams("visitorId", visitor.getString("visitorId"));
		this.setAddParams("sessionId", session.getId());
    }

    public MultiWebShoppingCart(HttpServletRequest request) {
        this(request, UtilHttp.getLocale(request), UtilHttp.getCurrencyUom(request),ProductStoreWorkerExt.getProductStoreId(request,null));
    }

    /** Creates a new cloned ShoppingCart Object. */
    public MultiWebShoppingCart(ShoppingCart cart) {
        super(cart);
    }
    
}
