package org.ofbiz.order.shoppingcart;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.ofbiz.entity.GenericValue;
import org.ofbiz.order.order.OrderReadHelper;
import org.ofbiz.order.shoppingcart.ShoppingCart.CartShipInfo;
import org.ofbiz.service.LocalDispatcher;

import javolution.util.FastList;
import javolution.util.FastMap;

public class MultiShoppingCartMap implements Serializable {

    private Map<String, ShoppingCart> cartMap = FastMap.newInstance();

    public MultiShoppingCartMap() {

    }

    public Map<String, ShoppingCart> getCartMap() {
	return cartMap;
    }

    public void setCartMap(Map<String, ShoppingCart> cartMap) {
	this.cartMap = cartMap;
    }

    public void addToCartMap(String productStoreId, ShoppingCart cart) {
    	if(shippingContactMechId!=null)
    		cart.setAllShippingContactMechId(shippingContactMechId);
    	this.cartMap.put(productStoreId, cart);
    }

    public boolean containsKey(Object key) {
	return cartMap.containsKey(key);
    }

    public ShoppingCart getFromCartMap(String productStoreId) {
	if (cartMap.containsKey(productStoreId)) {
	    return cartMap.get(productStoreId);
	}
	return null;
    }

    private String shippingContactMechId = null;

    public String getShippingContactMechId() {
	return this.shippingContactMechId;
    }

    public void setShippingContactMechId(String shippingContactMechId) {
		this.shippingContactMechId = shippingContactMechId;
		List<ShoppingCart> carts = getShoppingCartList();
		for(ShoppingCart cart:carts){
			cart.setAllShippingContactMechId(shippingContactMechId);
		}
    }

    private String checkOutPaymentId = null;

    public String getCheckOutPaymentId() {
	return this.checkOutPaymentId;
    }

    public void setCheckOutPaymentId(String checkOutPaymentId) {
	this.checkOutPaymentId = checkOutPaymentId;
    }

    public BigDecimal getTotalQuantity() {
	BigDecimal count = BigDecimal.ZERO;
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    String keyId = entry.getKey();
	    ShoppingCart cart = entry.getValue();
	    count = count.add(cart.getTotalQuantity());
	}
	return count;
    }

    /** Returns the shipping amount from the cart object. */
    public BigDecimal getTotalShipping() {
	BigDecimal tempShipping = BigDecimal.ZERO;
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    ShoppingCart cart = entry.getValue();
	    tempShipping = tempShipping.add(cart.getTotalShipping());
	}
	return tempShipping;
    }

    /** Returns the sub-total in the cart (item-total - discount). */
    public BigDecimal getSubTotal() {
	BigDecimal itemsTotal = BigDecimal.ZERO;
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    ShoppingCart cart = entry.getValue();
	    itemsTotal = itemsTotal.add(cart.getSubTotal());
	}
	return itemsTotal;
    }

    /** Returns the total from the cart, including tax/shipping. */
    public BigDecimal getGrandTotal() {
	BigDecimal grandTotal = BigDecimal.ZERO;
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    ShoppingCart cart = entry.getValue();
	    grandTotal = grandTotal.add(cart.getGrandTotal());
	}
	grandTotal = grandTotal.setScale(2, BigDecimal.ROUND_HALF_UP);
	return grandTotal;
    }

    public BigDecimal getDisplaySubTotal() {
	BigDecimal itemsTotal = BigDecimal.ZERO;
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    ShoppingCart cart = entry.getValue();
	    itemsTotal = itemsTotal.add(cart.getDisplaySubTotal());
	}
	return itemsTotal;
    }

    public BigDecimal getOrderOtherAdjustmentTotal() {
	BigDecimal otherAdjustmentTotal = BigDecimal.ZERO;
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    ShoppingCart cart = entry.getValue();
	    otherAdjustmentTotal = otherAdjustmentTotal.add(cart.getOrderOtherAdjustmentTotal());
	}
	return otherAdjustmentTotal;
    }

    /** Returns the sub-total in the cart (item-total - discount). */
    public BigDecimal getSubTotalForPromotions() {
	BigDecimal subTotalForPromotions = BigDecimal.ZERO;
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    ShoppingCart cart = entry.getValue();
	    subTotalForPromotions = subTotalForPromotions.add(cart.getSubTotalForPromotions());
	}
	return subTotalForPromotions;
    }

    public int size() {
	int intSize = 0;
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    ShoppingCart cart = entry.getValue();
	    intSize += cart.size();
	}
	return intSize;
    }

    public List<ShoppingCart> getShoppingCartList() {
	List<ShoppingCart> shoppingCartList = FastList.newInstance();
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    String keyId = entry.getKey();
	    ShoppingCart cart = entry.getValue();
	    shoppingCartList.add(cart);
	}
	return shoppingCartList;
    }

    public String getCurrency() {
	return this.getShoppingCartList().get(0).getCurrency();
    }

    public Locale getLocale() {
	return this.getShoppingCartList().get(0).getLocale();
    }

    public void clear() {
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    // String keyId = entry.getKey();
	    ShoppingCart cart = entry.getValue();
	    cart.clear();
	}
    }

    private String autoSaveListId;

    public String getAutoSaveListId() {
	return autoSaveListId;
    }

    public void setAutoSaveListId(String autoSaveListId) {
	this.autoSaveListId = autoSaveListId;
    }

    public void setOrderPartyId(String orderPartyId) {
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    // String keyId = entry.getKey();
	    ShoppingCart cart = entry.getValue();
	    cart.setOrderPartyId(orderPartyId);
	}
    }
    
    public void setCurrency(LocalDispatcher dispatcher, String currencyUom) throws CartItemModifyException{
	for (Map.Entry<String, ShoppingCart> entry : cartMap.entrySet()) {
	    ShoppingCart cart = entry.getValue();
	    cart.setCurrency(dispatcher, currencyUom);
	}
    }
}
