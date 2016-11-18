import java.util.Locale;

import org.ofbiz.base.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.product.catalog.CatalogWorker;
import org.ofbiz.product.store.ProductStoreWorker;
import org.ofbiz.common.CommonWorkers;
import org.ofbiz.order.shoppingcart.*;
import org.ofbiz.webapp.control.*;

//productStore = ProductStoreWorker.getProductStore(request);

prodCatalog = CatalogWorker.getProdCatalog(request);
if (prodCatalog) {
    catalogStyleSheet = prodCatalog.styleSheet;
    if (catalogStyleSheet) globalContext.catalogStyleSheet = catalogStyleSheet;
    catalogHeaderLogo = prodCatalog.headerLogo;
    if (catalogHeaderLogo) globalContext.catalogHeaderLogo = catalogHeaderLogo;
}

//globalContext.productStore = productStore;
globalContext.checkLoginUrl = LoginWorker.makeLoginUrl(request, "checkLogin");
globalContext.catalogQuickaddUse = CatalogWorker.getCatalogQuickaddUse(request);

/*
session = request.getSession();
Locale locale = UtilHttp.getLocale(request, session, new Locale("zh_CN"));
session.setAttribute("locale",locale.toLanguageTag());
session.setAttribute("currencyUom",UtilHttp.getCurrencyUom(session, "CNY"));
*/