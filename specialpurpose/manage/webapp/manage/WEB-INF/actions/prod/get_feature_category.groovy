import java.util.*;
import org.ofbiz.entity.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.base.util.*;
import org.ofbiz.base.util.collections.*;
import org.ofbiz.accounting.invoice.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.math.BigDecimal;
import java.math.MathContext;
import org.ofbiz.base.util.UtilNumber;
import javolution.util.FastList;
import javolution.util.FastMap;
featureList = FastMap.newInstance();
productId = parameters.get("productId");
product = delegator.findByPrimaryKey("Product", [productId : productId]);
if (product) {
	features = product.getRelated("ProductFeatureAppl");
	if (features) {
		features.each { feature ->
			featureList.put(feature.productFeatureId, feature.productFeatureId);
		}
		context.featureList = featureList.keySet().asList();
	}
}