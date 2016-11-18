import org.ofbiz.base.util.*;
import java.sql.*;
import java.util.Calendar;

fromDate = parameters.fromDate;
thruDate = parameters.thruDate;
productStoreId = parameters.productStoreId;
birtParameters = [:];
try {
		birtParameters.productStoreId = productStoreId;
		birtParameters.fromDate = parameters.fromDate;
		birtParameters.thruDate = parameters.thruDate;
} catch (e) {
   Debug.logError(e, "");
}
request.setAttribute("birtParameters", birtParameters);
return "success";
