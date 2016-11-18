/**
 * 微信公众平台开发模式(JAVA) SDK
 * (c) 2012-2013 ____′↘夏悸 <wmails@126.cn>, MIT Licensed
 * http://www.jeasyuicn.com/wechat
 */
package com.weixin;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.weixin.util.HttpKit;

/**
 * 微信常用的API
 *
 * @author xueyb
 * @date 2015-1-25 下午3:01:20
 */
public class Weixin {
    private static final String ACCESSTOKEN_URL = "https://qyapi.weixin.qq.com/cgi-bin/gettoken";
    private static final String MESSAGE_URL = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=";
    private static final String DEFAULT_CHARSET = "UTF-8";
    private static Class<?> messageProcessingHandlerClazz = null;

    /**
     * 获取access_token
     *
     * @return
     * @throws Exception
     */
    public static String getAccessToken(String corpid, String corpsecret) throws Exception {
    	String jsonStr = HttpKit.get(ACCESSTOKEN_URL.concat("?corpid=") + corpid + "&corpsecret=" + corpsecret);
    	Map<String, Object> map = JSONObject.parseObject(jsonStr);
        return map.get("access_token").toString();
    }
    /**
     * 发送文本消息
     *
     * @param openId 用户ID "@all"表示所有用户
     * @param text
     * @throws Exception
     */
    public static String sendText(String accessToken, String openId, String text) throws Exception {
        Map<String, Object> json = new HashMap<String, Object>();
        Map<String, Object> textObj = new HashMap<String, Object>();
        textObj.put("content", text);
        json.put("touser", openId);
        json.put("msgtype", "text");
        json.put("agentid", "0");
        //json.put("totag", "@all");
        //json.put("toparty", "@all");
        json.put("text", textObj);
        json.put("safe", "0");
        String result = HttpKit.post(MESSAGE_URL.concat(accessToken), JSONObject.toJSONString(json));
        return result;
    }
    
    public static void main(String[] args) {
		String appId = "wx9a348639a75bea35";
		String secret = "QRPTCu_yHjbCIszZx3nOvdmz8uvSJUljab0XV8UG0N9t3f8ILDZZOnOX2TTZeXDP";
		try {
			String access_token = getAccessToken(appId, secret);
			String sendMsg = sendText(access_token, "bohbohman", "http://123.57.134.108:8080/yxck/control/ShareDetails?meetingId=10020&type=Meeting");
			System.out.println(sendMsg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
