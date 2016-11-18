package netpay.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;

import chinapay.SecureLink;

public class NetPayReturnServices{

	public static final String module = NetPayReturnServices.class.getName();
	public static final String resource = "OfbizToolsUiLabels";
	public static String message="";
	/**
	 * 同步返回数据
	 * @param dctx
	 * @param context
	 */
	@SuppressWarnings({ "deprecation" })
	public static String netPayReturn(HttpServletRequest request,HttpServletResponse response) {
		String returnIsInfo="";
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher =(LocalDispatcher) request.getAttribute("dispatcher");
		try {
			GenericValue userLogin =delegator.findByPrimaryKey("UserLogin", UtilMisc.toMap("userLoginId","admin"));
			
			System.out.println("<====Receive PageReturnData Start!");
			//支付订单数据准备
//			String Version = request.getParameter("version");
			String MerId = request.getParameter("merid");
			String OrdId = request.getParameter("orderno");
			String TransAmt = request.getParameter("amount");// 12
			String CuryId = request.getParameter("currencycode");// 3
			String TransDate = request.getParameter("transdate");// 8
			String TransType = request.getParameter("transtype");// 4
			String Status = request.getParameter("status");//status表示交易状态只有"1001"表示支付成功，其他状态均表示未成功的交易。因此验证签名数据通过后，还需要判定交易状态代码是否为"1001"
//			String Priv1 = request.getParameter("Priv1");
			
			//try {
			//	Priv1 = Base64Util.base64Decoder(Priv1);
			//} catch (Exception e1) {
				// TODO Auto-generated catch block
			//	e1.printStackTrace();
			//}
			
			String ChkValue = request.getParameter("checkvalue");
			System.out.println(MerId+OrdId+TransAmt+CuryId+TransDate+TransType+Status+ChkValue);
			boolean buildOK = false;
			boolean res = false;
			int KeyUsage = 0;
			chinapay.PrivateKey key = new chinapay.PrivateKey();
			buildOK = key.buildKey("999999999999999", KeyUsage, System.getProperty("ofbiz.home") +"/hot-deploy/ofbiztools/config/netPay/PgPubk.key");
			
			if (!buildOK) {
				Debug.logError("build error!", module);
				returnIsInfo = "error";
				return returnIsInfo;
			}
			
			SecureLink sl = new SecureLink(key);
			res=sl.verifyTransResponse(MerId, OrdId, TransAmt, CuryId, TransDate, TransType, Status, ChkValue);
			GenericValue orderHeader = EntityUtil.getFirst(delegator.findByAnd("OrderHeader", UtilMisc.toMap("externalId", OrdId)));
			if (res){
				System.out.println("PageReturn Check OK!");
				//验证签名数据通过后，一定要判定交易状态代码是否为"1001"，实现代码请商户自行编写
				if(Status.equals("1001")){
					System.out.println(orderHeader);
					if(UtilValidate.isNotEmpty(orderHeader) && "ORDER_CREATED".equals(orderHeader.get("statusId"))){
	                    returnIsInfo="success";
	                    Map<String,Object> map = FastMap.newInstance();
	                    map.put("setItemStatus", "Y");
	                    map.put("statusId", "ORDER_APPROVED");
	                    map.put("orderId", orderHeader.getString("orderId"));
	                    map.put("userLogin", userLogin);
	                    Map<String,Object> result = dispatcher.runSync("changeOrderStatus", map);
	                    Debug.log("message====="+result);
	                }
				}
			}
			request.setAttribute("orderId", orderHeader.getString("orderId"));
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		} catch (GenericServiceException e) {
			Debug.logError(e.getMessage(), module);
			returnIsInfo = "error";
		}
		return returnIsInfo;
	}
}
