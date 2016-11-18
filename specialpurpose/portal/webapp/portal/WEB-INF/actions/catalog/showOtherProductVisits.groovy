
import java.util.Map;
import javolution.util.FastMap;
import org.ofbiz.product.product.ProductVisitWorker;

Map inParams = FastMap.newInstance();

Map queryResult = ProductVisitWorker.findOtherProductVisit(request, inParams);

context.productIds = queryResult.productIdList;

