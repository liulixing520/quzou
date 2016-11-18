package com.easemob.server.example.httpclient.apidemo;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.extErp.sysCommon.util.DateTimeUtils;
import org.extErp.sysCommon.util.JsonUtil;
import org.json.JSONArray;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilValidate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;

public class HuanXinUtil {

	private static JsonNodeFactory factory = new JsonNodeFactory(false);
	private static Logger LOGGER = LoggerFactory.getLogger(EasemobMessages.class);
	
    public static String createHuanxUser(String username,String password){
    	String statusCode = null;
    	ObjectNode datanode = JsonNodeFactory.instance.objectNode();
    	datanode.put("username",username);
    	datanode.put("password", password);
    	
    	EasemobIMUsers easemobIMUsers = new EasemobIMUsers();
    	ObjectNode createNewIMUserSingleNode = easemobIMUsers.createNewIMUserSingle(datanode);
    	if (null != createNewIMUserSingleNode) {
    		LOGGER.info("注册IM用户[单个]: " + createNewIMUserSingleNode.toString());
    		JSONObject oneJsonObject = JSONObject.fromObject(createNewIMUserSingleNode.toString());
    		if(UtilValidate.isNotEmpty(oneJsonObject)){
    			if(UtilValidate.isNotEmpty(oneJsonObject.get("statusCode"))){
    				statusCode = oneJsonObject.get("statusCode").toString();
    			}
    		}
    	}
    	
    	return statusCode;
    }
    
    /**
	 * 创建群组
	 * @param groupname  //群组名称, 此属性为必须的
	 * @param desc	//群组描述, 此属性为必须的
	 * @param publicV	//是否是公开群, 此属性为必须的,为false时为私有群
	 * @param maxusers	//群组成员最大数(包括群主), 值为数值类型,默认值200,此属性为可选的
	 * @param approval	//加入公开群是否需要批准, 默认值是true（加群需要群主批准）, 此属性为可选的,只作用于公开群
	 * @param owner	//群组的管理员, 此属性为必须的
	 * @param userList	//群组成员,此属性为可选的,但是如果加了此项,数组元素至少一个（注：群主jma1不需要写入到members里面）
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static Map<String, String> creteGroup(String groupname,String desc,Boolean publicV,String maxusers,Boolean approval,String owner,List<String> userList) {
		Map<String, String> resultMap = new HashMap<String, String>();
		ObjectNode dataObjectNode = JsonNodeFactory.instance.objectNode();
		dataObjectNode.put("groupname", groupname);
		dataObjectNode.put("desc", desc);
		dataObjectNode.put("public", publicV);
		dataObjectNode.put("maxusers", maxusers);
		dataObjectNode.put("approval", approval);
		dataObjectNode.put("owner", owner);
		ArrayNode arrayNode = JsonNodeFactory.instance.arrayNode();
		if(UtilValidate.isNotEmpty(userList)){
			for (String string : userList) {
				arrayNode.add(string);
			}
		}
		dataObjectNode.put("members", arrayNode);
		
		EasemobChatGroups easemobChatGroups = new EasemobChatGroups();
		ObjectNode creatChatGroupNode = easemobChatGroups.creatChatGroups(dataObjectNode);
		if(UtilValidate.isNotEmpty(creatChatGroupNode)){
			JSONObject oneJsonObject = JSONObject.fromObject(creatChatGroupNode.toString());
			if(UtilValidate.isNotEmpty(oneJsonObject)){
				if(UtilValidate.isNotEmpty(oneJsonObject.get("statusCode"))){
					resultMap.put("statusCode", oneJsonObject.get("statusCode").toString());
				}
				if(UtilValidate.isNotEmpty(oneJsonObject.get("data"))){
					JSONObject dataObject = JSONObject.fromObject(oneJsonObject.get("data").toString());
					if(UtilValidate.isNotEmpty(dataObject) && UtilValidate.isNotEmpty(dataObject.get("groupid"))){
						resultMap.put("groupId", dataObject.get("groupid").toString());
					}
				}
			}
		}
		return resultMap;
	}
	/**
	 * 往群组中添加一个人
	 * @param addToChatgroupid 群组ID
	 * @param toAddUsername	添加人用户名
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public static String addGroupUser(String addToChatgroupid,String toAddUsername) {
		String statusCode = null;
		
		EasemobChatGroups easemobChatGroups = new EasemobChatGroups();
		ObjectNode addUserToGroupNode = easemobChatGroups.addUserToGroup(addToChatgroupid, toAddUsername);
		if(UtilValidate.isNotEmpty(addUserToGroupNode)){
			JSONObject oneJsonObject = JSONObject.fromObject(addUserToGroupNode.toString());
			if(UtilValidate.isNotEmpty(oneJsonObject)){
				if(UtilValidate.isNotEmpty(oneJsonObject.get("statusCode"))){
					statusCode = oneJsonObject.get("statusCode").toString();
				}
			}
		}
		return statusCode;
	}
	
	/**
	 * 批量删除用户
	 * @param limit	建议这个数值在100-500之间，不要过大
	 * @return
	 */
	public static String deleteHuanxinUser(Long limit) {
		String statusCode = null;
        ObjectNode deleteIMUserByUsernameBatchNode = com.easemob.server.example.jersey.apidemo.EasemobIMUsers.deleteIMUserByUsernameBatch(limit, null);
        if(UtilValidate.isNotEmpty(deleteIMUserByUsernameBatchNode.toString())){
			JSONObject oneJsonObject = JSONObject.fromObject(deleteIMUserByUsernameBatchNode.toString());
			if(UtilValidate.isNotEmpty(oneJsonObject)){
				if(UtilValidate.isNotEmpty(oneJsonObject.get("statusCode"))){
					statusCode = oneJsonObject.get("statusCode").toString();
				}
			}
		}
		return statusCode;
	}
	
	/**
	 * 判断用户是否在线
	 * @param targetuserPrimaryKey 环信用户名
	 * @return offline不在线   online在线
	 */
	public static String isUserStatus(String targetuserPrimaryKey) {
		String resutlStatus = "offline";
        ObjectNode usernode = EasemobMessages.getUserStatus(targetuserPrimaryKey);
        if(UtilValidate.isNotEmpty(usernode.toString())){
			JSONObject oneJsonObject = JSONObject.fromObject(usernode.toString());
			if(UtilValidate.isNotEmpty(oneJsonObject)){
				if(UtilValidate.isNotEmpty(oneJsonObject.get("statusCode")) && "200".equals(oneJsonObject.get("statusCode").toString())){
					String data = oneJsonObject.get("data").toString();
					JSONObject twoJsonObject = JSONObject.fromObject(data);
					if(UtilValidate.isNotEmpty(twoJsonObject) && "online".equals(twoJsonObject.get(targetuserPrimaryKey))){
						resutlStatus = "online";
					}
				}
			}
		}
		return resutlStatus;
	}
	
	/**
	 * 删除群组
	 * @param toDelChatgroupid 环信群组ID
	 * @return 200为操作成功
	 */
	public static String deleteHuanXinGroup(String toDelChatgroupid) {
		String statusCode = null;
		ObjectNode deleteChatGroupNode =  EasemobChatGroups.deleteChatGroups(toDelChatgroupid) ;
		if(UtilValidate.isNotEmpty(deleteChatGroupNode.toString())){
			JSONObject oneJsonObject = JSONObject.fromObject(deleteChatGroupNode.toString());
			if(UtilValidate.isNotEmpty(oneJsonObject)){
				if(UtilValidate.isNotEmpty(oneJsonObject.get("statusCode"))){
					statusCode = oneJsonObject.get("statusCode").toString();
				}
			}
		}
		return statusCode;
	}
	
	/**
     * 获取某天至今的聊天记录
     * @param acquisitionTime 获取哪一天的格式为（yyyy-MM-dd）
     */
    public static List<Map<String, String>> getChattingRecords(Date acquisitionTime,Date stopTimestamp,String cursor){
    	
    	String currentTimestamp = String.valueOf(stopTimestamp.getTime());
        String senvenDayAgo = String.valueOf(acquisitionTime.getTime());
        ObjectNode queryStrNode1 = factory.objectNode();
        queryStrNode1.put("ql", "select * where  timestamp > " + senvenDayAgo + " and timestamp < " + currentTimestamp);
        queryStrNode1.put("limit", "50");
        queryStrNode1.put("cursor", cursor);
        ObjectNode messages1 = EasemobChatMessage.getChatMessages(queryStrNode1);
        List<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
        if(UtilValidate.isNotEmpty(messages1.toString())){
        	Map mapOne = (Map) JsonUtil.toMapByRowsTestTwo(messages1.toString());
        	String searchCursor = (String) mapOne.get("cursor");
        	List listOne = (List) mapOne.get("entities");
        	if(UtilValidate.isNotEmpty(listOne)){
        		for (Object object : listOne) {
        			Map<String, String> resultMap = new HashMap<String, String>();
					Map mapTwo = (Map) object;
					resultMap.put("chatUuid", UtilValidate.isNotEmpty(mapTwo.get("uuid"))?mapTwo.get("uuid").toString():null);
					resultMap.put("chatType", UtilValidate.isNotEmpty(mapTwo.get("chat_type"))?mapTwo.get("chat_type").toString():null);
					resultMap.put("chatFrom", UtilValidate.isNotEmpty(mapTwo.get("from"))?mapTwo.get("from").toString():null);
					resultMap.put("chatMsgId", UtilValidate.isNotEmpty(mapTwo.get("msg_id"))?mapTwo.get("msg_id").toString():null);
					resultMap.put("chatGroupType", UtilValidate.isNotEmpty(mapTwo.get("type"))?mapTwo.get("type").toString():null);
					resultMap.put("chatTimestamp", UtilValidate.isNotEmpty(mapTwo.get("timestamp"))?mapTwo.get("timestamp").toString():null);
					resultMap.put("chatTo", UtilValidate.isNotEmpty(mapTwo.get("to"))?mapTwo.get("to").toString():null);
					
					Map mapThree = (Map) mapTwo.get("payload");
					if(UtilValidate.isNotEmpty(mapThree)){
						List listTwo = (List) mapThree.get("bodies");
						if(UtilValidate.isNotEmpty(listTwo)){
							Map mapFour = (Map) listTwo.get(0);
							if(UtilValidate.isNotEmpty(mapFour)){
								resultMap.put("chatMsg", UtilValidate.isNotEmpty(mapFour.get("msg"))?mapFour.get("msg").toString():null);
								resultMap.put("msgType", UtilValidate.isNotEmpty(mapFour.get("type"))?mapFour.get("type").toString():null);
								resultMap.put("msgLength", UtilValidate.isNotEmpty(mapFour.get("length"))?mapFour.get("length").toString():null);
								resultMap.put("msgUrl", UtilValidate.isNotEmpty(mapFour.get("url"))?mapFour.get("url").toString():null);
								resultMap.put("msgFilename", UtilValidate.isNotEmpty(mapFour.get("filename"))?mapFour.get("filename").toString():null);
								resultMap.put("msgSecret", UtilValidate.isNotEmpty(mapFour.get("secret"))?mapFour.get("secret").toString():null);
								resultMap.put("msgLat", UtilValidate.isNotEmpty(mapFour.get("lat"))?mapFour.get("lat").toString():null);
								resultMap.put("msgLng", UtilValidate.isNotEmpty(mapFour.get("lng"))?mapFour.get("lng").toString():null);
								resultMap.put("msgAddr", UtilValidate.isNotEmpty(mapFour.get("addr"))?mapFour.get("addr").toString():null);
							}
						}
						Map mapFive = (Map) mapThree.get("ext");
						if(UtilValidate.isNotEmpty(mapFive) && UtilValidate.isNotEmpty(mapFive.get("senderInfo")) &&
								!"{}".equals(mapFive.get("senderInfo"))){
							Map mapSix = (Map) mapFive.get("senderInfo");
							if(UtilValidate.isNotEmpty(mapFive.get("senderInfo"))){
								resultMap.put("senderInfoName", UtilValidate.isNotEmpty(mapFive.get("name"))?mapFive.get("name").toString():null);
								resultMap.put("senderInfoHeadUrl", UtilValidate.isNotEmpty(mapFive.get("headUrl"))?mapFive.get("headUrl").toString():null);
							}
						}
					}
					resultList.add(resultMap);
				}
        	}
        	
        	if(UtilValidate.isNotEmpty(searchCursor)){
        		List<Map<String, String>> resultListOne = getChattingRecords(acquisitionTime,stopTimestamp,searchCursor);
        		resultList.addAll(resultListOne);
        	}
        }
        System.out.println(DateTimeUtils.nowDate("yyyy-MM-dd HH:mm:ss")+"从环信服务器取数据<"+resultList.size()+">条。");
//        Debug.log(DateTimeUtils.nowDate("yyyy-MM-dd HH:mm:ss")+"从环信服务器取数据<"+resultList.size()+">条。");
        return resultList;
    }
	
	
	public static void main(String[] args) {
//		System.out.println(deleteHuanxinUser(300l));
//		System.out.println(createHuanxUser("11111111","111111"));
//		System.out.println(isUserStatus("13260235627"));
//		System.out.println(deleteHuanXinGroup("143131320481524"));
//		try {
//			System.out.println("########"+getChattingRecords(DateTimeUtils.assignNewDate(new Date(), 0, 0, -2), null).size());
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		String data = "[{dateTime:'2015-6-11','week':'星期四',dayType:'[):]'}]";
//		Map json = JSONObject.fromObject(data);
		List json = net.sf.json.JSONArray.fromObject(data);
		System.out.println(((Map)json.get(0)).get("dayType"));
	}
}
