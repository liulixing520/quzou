package org.ofbiz.quzou.util;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;
import net.sf.json.JSONObject;

import org.extErp.sysCommon.content.UtilFileUpload;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.GenericServiceException;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ModelService;
import org.ofbiz.service.ServiceUtil;

public class UploadExcel {

	public static final String module = UploadExcel.class.getName();
	
	public static String uploadExcel(HttpServletRequest request, HttpServletResponse response) {
		try {
			String fullFilePath = request.getSession().getServletContext().getRealPath("/")+"upload/";
			Map<String, Object> context = UtilFileUpload.uploadFile(fullFilePath, request);
			Debug.log("filePath=============="+context.get("filePath"));
			Debug.log("fileName=============="+context.get("fileName"));
			String inType = request.getParameter("inType");
			inType = inType.split("_")[0];
			Map<String, String[]> map2 = request.getParameterMap();
			Debug.log("map======="+map2);
			Map<String, Object> msgMap = FastMap.newInstance(); 
			String filePath = fullFilePath+(String)context.get("filePath");
			if (inType.equals("customer")) {
				msgMap = uploadCustomer(request,filePath);
			}else if(inType.equals("team")) {
				msgMap = uploadTeam(request,filePath);
			}else if(inType.equals("customerAndCompet")) {
				msgMap = uploadCustomerAndCompet(request,filePath);
			}
			Map<String, Object> map = FastMap.newInstance();
			if(UtilValidate.isNotEmpty(context.get("filePath"))){
				map.put("filePath", context.get("filePath"));
				map.put("fileName", context.get("fileName"));
			}
			Debug.log("checkError"+msgMap.get("checkError"));
			Debug.log("checkLog"+msgMap.get("checkLog"));
			map.put("err", msgMap.get("checkError").toString());
			map.put("log", msgMap.get("checkLog").toString());
			toJsonObject(map, response);
		} catch (Exception e) {
			e.printStackTrace();
			return ModelService.RESPOND_ERROR;
		}
		return ModelService.RESPOND_SUCCESS;
	}
	
	/**
	 * 验证导入用户名单
	 * @param request
	 * @param response
	 * @return
	 */
	public static Map<String, Object> uploadCustomer(HttpServletRequest request, String myFilePath) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		List<HashMap<String, String>> excleList = null;
		StringBuffer checkError = new StringBuffer();
		StringBuffer checkLog = new StringBuffer();
		Map<String, Object> map = FastMap.newInstance();
		try {
			if(UtilValidate.isNotEmpty(myFilePath)){
				File myFile = new File(myFilePath);
				excleList = JXLExcelUtil.getExcleList(myFile, 0, 2);
			}else {
				checkError.append("文件不存在！★");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			TransactionUtil.begin();
			
			for (int i = 0; i < excleList.size(); i++) {
				if(checkLog.length()> 250){
					break;
				}
				Map<String, Object> serviceMap = FastMap.newInstance();
				HashMap<String, String> RowllMap = excleList.get(i);
				if(RowllMap.isEmpty()){
					continue;
				}
				if((RowllMap.get("0")== null) && (RowllMap.get("1")== null) && (RowllMap.get("2")==null) && (RowllMap.get("3")== null)){
					continue;
				}
				// 验证会员名称不能为空
				if (RowllMap.get("0") == null || RowllMap.get("0").equals("")) {
					checkError.append("第" + (i + 3) + "行的单位名称不能为空！★");
					continue;
				}
				// 验证验证姓名不能为空
				if (RowllMap.get("1") == null || RowllMap.get("1").equals("")) {
					checkError.append("第" + (i + 3) + "行的姓名不能为空！★");
				}
				// 验证验证手机号码不能为空
				if (RowllMap.get("2") == null || RowllMap.get("2").equals("")) {
					checkError.append("第" + (i + 3) + "行的手机号码不能为空！★");
				}
				// 验证验证计步器串号不能为空
				if (RowllMap.get("3") == null || RowllMap.get("3").equals("")) {
					checkError.append("第" + (i + 3) + "行的计步器串号不能为空！★");
				}
				try {
					List<GenericValue> users = delegator.findByAnd("Person",UtilMisc.toMap("cardId",RowllMap.get("3")));
					if(UtilValidate.isNotEmpty(users)){
						checkLog.append("计步器号"+RowllMap.get("3")+"已经存在！★");
					}
				} catch (GenericEntityException e) {
					e.printStackTrace();
					checkError.append("查询错误");
				}
				if(UtilValidate.isEmpty(checkError)){
					/**判断用户名是否存在*/
					String userLoginId = RowllMap.get("1"); 
					try {
						GenericValue user = EntityUtil.getFirst(delegator.findByAnd("QzCustomer", UtilMisc.toMap("userLoginId",userLoginId.trim())));
						if(UtilValidate.isNotEmpty(user)){
							String telephone = RowllMap.get("2");
							int lenth = telephone.length();
							String sb = telephone.substring(lenth-4, lenth);
							userLoginId = userLoginId+""+sb;
							checkLog.append(userLoginId+"★");
							String userTelephone = (String)user.get("telephone");
							if(!userTelephone.equals(telephone)){
								serviceMap.put("companyName", RowllMap.get("0"));
								serviceMap.put("firstName", RowllMap.get("1"));
								serviceMap.put("userLoginId", userLoginId);
								serviceMap.put("telephone", RowllMap.get("2"));
								serviceMap.put("cardId", RowllMap.get("3"));
								serviceMap.put("userLogin", userLogin);
								dispatcher.runSync("createQzCustomer", serviceMap);	
							}
						}else {
							serviceMap.put("companyName", RowllMap.get("0"));
							serviceMap.put("firstName", RowllMap.get("1"));
							serviceMap.put("userLoginId", userLoginId);
							serviceMap.put("telephone", RowllMap.get("2"));
							serviceMap.put("cardId", RowllMap.get("3"));
							serviceMap.put("userLogin", userLogin);
							dispatcher.runSync("createQzCustomer", serviceMap);
						}
					} catch (GenericEntityException e) {
						e.printStackTrace();
						checkError.append("查询错误");
					} catch (GenericServiceException e) {
						e.printStackTrace();
						checkError.append("新增失败");
					}
				}
				
			}
			TransactionUtil.commit();
		} catch (GenericTransactionException e1) {
			e1.printStackTrace();
			try {
                TransactionUtil.rollback();
            } catch (GenericTransactionException e2) {
            	checkError.append("提交失败，已回滚");
            }
		}
		
		map.put("checkError", checkError);
		map.put("checkLog", checkLog);
		return map;
	}
	
	/**
	 * 验证导入团队名单
	 * @param request
	 * @param response
	 * @return
	 */
	public static Map<String, Object> uploadTeam(HttpServletRequest request, String myFilePath) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		List<HashMap<String, String>> excleList = null;
		StringBuffer checkError = new StringBuffer();
		StringBuffer checkLog = new StringBuffer();
		Map<String, Object> map = FastMap.newInstance();
		try {
			if(UtilValidate.isNotEmpty(myFilePath)){
				File myFile = new File(myFilePath);
				excleList = JXLExcelUtil.getExcleList(myFile, 0, 2);
			}else {
				checkError.append("文件不存在！★");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			TransactionUtil.begin();
			
			for (int i = 0; i < excleList.size(); i++) {
				Map<String, Object> serviceMap = FastMap.newInstance();
				// 验证单位不能为空
				HashMap<String, String> RowllMap = excleList.get(i);
				if(RowllMap.isEmpty()){
					continue;
				}
				if(RowllMap.get("0").equals("") && RowllMap.get("1").equals("") && RowllMap.get("2").equals("") && RowllMap.get("3").equals("")){
					continue;
				}
				if (RowllMap.get("0") == null || RowllMap.get("0").equals("")) {
					checkError.append("第" + (i + 3) + "行的单位名称不能为空！★");
					continue;
				}
				// 验证团队不能为空
				if (RowllMap.get("1") == null || RowllMap.get("1").equals("")) {
					checkError.append("第" + (i + 3) + "行的团队不能为空！★");
				}
				// 验证验证姓名不能为空
				if (RowllMap.get("2") == null || RowllMap.get("2").equals("")) {
					checkError.append("第" + (i + 3) + "行的姓名不能为空！★");
				}
				// 验证验证手机号码不能为空
				if (RowllMap.get("3") == null || RowllMap.get("3").equals("")) {
					checkError.append("第" + (i + 3) + "行的手机号码不能为空！★");
				}
				// 验证验证计步器串号不能为空
				if (RowllMap.get("4") == null || RowllMap.get("4").equals("")) {
					checkError.append("第" + (i + 3) + "行的计步器串号不能为空！★");
				}
				if(UtilValidate.isEmpty(checkError)){
					try {
						serviceMap.put("companyName", RowllMap.get("0"));
						serviceMap.put("deptName", RowllMap.get("1"));
						serviceMap.put("userLogin", userLogin);
						Map<String, Object> map3 = dispatcher.runSync("createCompanyAndDept", serviceMap);
						String deptId = (String)map3.get("deptId");
						
						/**判断用户名是否存在*/
						String userLoginId = RowllMap.get("2"); 
						try {
							GenericValue user = delegator.findOne("UserLogin", false, UtilMisc.toMap("userLoginId",userLoginId.trim()));
							if(UtilValidate.isNotEmpty(user)){
								Map<String, Object> serviceMap2 = FastMap.newInstance();
								serviceMap2.put("customerId", user.get("partyId"));
								serviceMap2.put("deptId", deptId);
								serviceMap2.put("userLogin", userLogin);
								dispatcher.runSync("createPersonAndDept", serviceMap2);
							}
						} catch (GenericEntityException e) {
							e.printStackTrace();
							checkError.append("新增失败");
						}
						
						
					} catch (GenericServiceException e) {
						e.printStackTrace();
						checkError.append("新增失败");
					}
				}
			}
			TransactionUtil.commit();
		} catch (GenericTransactionException e1) {
			e1.printStackTrace();
			try {
                TransactionUtil.rollback();
            } catch (GenericTransactionException e2) {
            	checkError.append("提交失败，已回滚");
            }
		}
		
		map.put("checkError", checkError);
		map.put("checkLog", checkLog);
		return map;
	}
	
	/**
	 * 验证导入参与赛事人员
	 * @param request
	 * @param response
	 * @return
	 */
	public static Map<String, Object> uploadCustomerAndCompet(HttpServletRequest request, String myFilePath) {
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		GenericValue userLogin = (GenericValue) request.getSession().getAttribute("userLogin");
		String inType = request.getParameter("inType");
		String cId = inType.split("_")[1];
		List<HashMap<String, String>> excleList = null;
		StringBuffer checkError = new StringBuffer();
		StringBuffer checkLog = new StringBuffer();
		Map<String, Object> map = FastMap.newInstance();
		try {
			if(UtilValidate.isNotEmpty(myFilePath)){
				File myFile = new File(myFilePath);
				excleList = JXLExcelUtil.getExcleList(myFile, 0, 2);
			}else {
				checkError.append("文件不存在！★");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			TransactionUtil.begin();
			for (int i = 0; i < excleList.size(); i++) {
				Map<String, Object> serviceMap = FastMap.newInstance();
				// 验证单位名称不能为空
				HashMap<String, String> RowllMap = excleList.get(i);
				if(RowllMap.isEmpty()){
					continue;
				}
				if(RowllMap.get("0").equals("") && RowllMap.get("1").equals("")){
					continue;
				}
				if (RowllMap.get("0") == null || RowllMap.get("0").equals("")) {
					checkError.append("第" + (i + 3) + "行的单位名称不能为空！★");
					continue;
				}
				// 验证验证团队不能为空
				if (RowllMap.get("1") == null || RowllMap.get("1").equals("")) {
					checkError.append("第" + (i + 3) + "行的团队不能为空！★");
				}
			
				if(UtilValidate.isEmpty(checkError)){
					try {
							/**创建单位跟团队**/
							Map<String, Object> inMap = FastMap.newInstance();
							inMap.put("companyName", RowllMap.get("0"));
							inMap.put("deptName", RowllMap.get("1"));
							inMap.put("userLogin", userLogin);
							Map<String, Object> map3 = dispatcher.runSync("createCompanyAndDept", inMap);
							String deptId = (String)map3.get("deptId");
							/**创建关联关系 团队跟赛事关联，人跟赛事关联，团队跟人关联**/
							Map<String, Object> inMap2 = FastMap.newInstance();
							inMap2.put("deptId", deptId);
							inMap2.put("cId", cId);
							inMap2.put("userLogin", userLogin);
							Map<String, Object> map4 = dispatcher.runSync("createRelationShip", inMap2);
					} catch (GenericServiceException e) {
						e.printStackTrace();
						checkError.append("新增失败");
					}
				}
			}
			TransactionUtil.commit();
		} catch (GenericTransactionException e1) {
			e1.printStackTrace();
			try {
                TransactionUtil.rollback();
            } catch (GenericTransactionException e2) {
            	checkError.append("提交失败，已回滚");
            }
		}
		map.put("checkError", checkError);
		map.put("checkLog", checkLog);
		return map;
	}
	
	
	public static void toJsonObject(Map attrMap, HttpServletResponse response) {
		JSONObject json = JSONObject.fromObject(attrMap);
		String jsonStr = json.toString();
		if (jsonStr == null) {
			Debug.logError("JSON Object was empty; fatal error!", module);
		}
		// set the X-JSON content type
		response.setContentType("text/html");
		// jsonStr.length is not reliable for unicode characters
		try {
			response.setContentLength(jsonStr.getBytes("UTF8").length);
		} catch (UnsupportedEncodingException e) {
			Debug.logError("Problems with Json encoding", module);
		}
		// return the JSON String
		Writer out;
		try {
			out = response.getWriter();
			out.write(jsonStr);
			out.flush();
		} catch (IOException e) {
			Debug.logError("Unable to get response writer", module);
		}
	}
}
