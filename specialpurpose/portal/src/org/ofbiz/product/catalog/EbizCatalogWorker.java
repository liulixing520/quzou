package org.ofbiz.product.catalog;


import javax.servlet.ServletRequest;

import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.product.catalog.CatalogWorker;

public class EbizCatalogWorker {
	public static final String module = EbizCatalogWorker.class.getName();
	
	public static final String PortalConfigName = "PortalConfig.properties";
	
	public static String getNavMenuCatalogId(ServletRequest request){
		String navMenuCatalogId = null;
		navMenuCatalogId = UtilProperties.getPropertyValue(PortalConfigName, "MENU_CATALOG_ID");
		if(UtilValidate.isEmpty(navMenuCatalogId)){
			navMenuCatalogId = CatalogWorker.getCurrentCatalogId(request);
		}
		return navMenuCatalogId;
	}
	
}
