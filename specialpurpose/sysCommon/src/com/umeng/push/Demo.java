package com.umeng.push;

import org.json.JSONArray;
import org.json.JSONObject;
import org.ofbiz.base.util.Debug;

import com.umeng.push.android.AndroidBroadcast;
import com.umeng.push.android.AndroidCustomizedcast;
import com.umeng.push.android.AndroidFilecast;
import com.umeng.push.android.AndroidGroupcast;
import com.umeng.push.android.AndroidUnicast;
import com.umeng.push.ios.IOSBroadcast;
import com.umeng.push.ios.IOSCustomizedcast;
import com.umeng.push.ios.IOSFilecast;
import com.umeng.push.ios.IOSGroupcast;
import com.umeng.push.ios.IOSUnicast;

public class Demo {
	private String appkey = null;
	private String appMasterSecret = null;
	private String timestamp = null;
	
	public Demo(String key, String secret) {
		try {
			appkey = key;
			appMasterSecret = secret;
			timestamp = Integer.toString((int)(System.currentTimeMillis() / 1000));
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
	
	public void sendAndroidBroadcast(String title,String text,String messageType,String mapString) throws Exception {
		AndroidBroadcast broadcast = new AndroidBroadcast();
		broadcast.setAppMasterSecret(appMasterSecret);
		broadcast.setPredefinedKeyValue("appkey", this.appkey);
		broadcast.setPredefinedKeyValue("timestamp", this.timestamp);
		broadcast.setPredefinedKeyValue("ticker", "Android broadcast ticker");
		broadcast.setPredefinedKeyValue("title",  title);
		broadcast.setPredefinedKeyValue("text",   text);
		broadcast.setPredefinedKeyValue("after_open", "go_app");
		broadcast.setPredefinedKeyValue("display_type", "notification");
		// TODO Set 'production_mode' to 'false' if it's a test device. 
		// For how to register a test device, please see the developer doc.
		broadcast.setPredefinedKeyValue("production_mode", "true");
		// Set customized fields
		broadcast.setExtraField("messageType", messageType);
		broadcast.setExtraField("map", mapString);
		broadcast.send();
	}
	
	public void sendAndroidUnicast() throws Exception {
		AndroidUnicast unicast = new AndroidUnicast();
		unicast.setAppMasterSecret(appMasterSecret);
		unicast.setPredefinedKeyValue("appkey", this.appkey);
		unicast.setPredefinedKeyValue("timestamp", this.timestamp);
		// TODO Set your device token
		unicast.setPredefinedKeyValue("device_tokens", "Ar1dWxVGste8_SCRkbEp6P5HLSb0QJsQRTvkF4ObomFI");
		unicast.setPredefinedKeyValue("ticker", "Android unicast ticker");
		unicast.setPredefinedKeyValue("title",  "消息标题");
		unicast.setPredefinedKeyValue("text",   "Android unicast text");
		unicast.setPredefinedKeyValue("after_open", "go_app");
		unicast.setPredefinedKeyValue("display_type", "notification");
		// TODO Set 'production_mode' to 'false' if it's a test device. 
		// For how to register a test device, please see the developer doc.
		unicast.setPredefinedKeyValue("production_mode", "true");
		// Set customized fields
		unicast.setExtraField("test", "helloworld");
		unicast.send();
	}
	
	public void sendAndroidGroupcast() throws Exception {
		AndroidGroupcast groupcast = new AndroidGroupcast();
		groupcast.setAppMasterSecret(appMasterSecret);
		groupcast.setPredefinedKeyValue("appkey", this.appkey);
		groupcast.setPredefinedKeyValue("timestamp", this.timestamp);
		/*  TODO
		 *  Construct the filter condition:
		 *  "where": 
		 *	{
    	 *		"and": 
    	 *		[
      	 *			{"tag":"test"},
      	 *			{"tag":"Test"}
    	 *		]
		 *	}
		 */
		JSONObject filterJson = new JSONObject();
		JSONObject whereJson = new JSONObject();
		JSONArray tagArray = new JSONArray();
		JSONObject testTag = new JSONObject();
		JSONObject TestTag = new JSONObject();
		testTag.put("tag", "test");
		TestTag.put("tag", "Test");
		tagArray.put(testTag);
		tagArray.put(TestTag);
		whereJson.put("and", tagArray);
		filterJson.put("where", whereJson);
		System.out.println(filterJson.toString());
		
		groupcast.setPredefinedKeyValue("filter", filterJson);
		groupcast.setPredefinedKeyValue("ticker", "Android groupcast ticker");
		groupcast.setPredefinedKeyValue("title",  "中文的title");
		groupcast.setPredefinedKeyValue("text",   "Android groupcast text");
		groupcast.setPredefinedKeyValue("after_open", "go_app");
		groupcast.setPredefinedKeyValue("display_type", "notification");
		// TODO Set 'production_mode' to 'false' if it's a test device. 
		// For how to register a test device, please see the developer doc.
		groupcast.setPredefinedKeyValue("production_mode", "true");
		groupcast.send();
	}
	
	public void sendAndroidCustomizedcast(String alias,String title,String text,String messageType,String mapString) throws Exception {
		AndroidCustomizedcast customizedcast = new AndroidCustomizedcast();
		customizedcast.setAppMasterSecret(appMasterSecret);
		customizedcast.setPredefinedKeyValue("appkey", this.appkey);
		customizedcast.setPredefinedKeyValue("timestamp", this.timestamp);
		// TODO Set your alias here, and use comma to split them if there are multiple alias.
		// And if you have many alias, you can also upload a file containing these alias, then 
		// use file_id to send customized notification.
		customizedcast.setPredefinedKeyValue("alias", alias);
		// TODO Set your alias_type here
		customizedcast.setPredefinedKeyValue("alias_type", "SINA_WEIBO");
		customizedcast.setPredefinedKeyValue("ticker", "Android customizedcast ticker");
		customizedcast.setPredefinedKeyValue("title",  title);
		customizedcast.setPredefinedKeyValue("text",   text);
		customizedcast.setPredefinedKeyValue("after_open", "go_app");
		customizedcast.setPredefinedKeyValue("display_type", "notification");
		customizedcast.setExtraField("messageType", messageType);
		customizedcast.setExtraField("map", mapString);
		// TODO Set 'production_mode' to 'false' if it's a test device. 
		// For how to register a test device, please see the developer doc.
		customizedcast.setPredefinedKeyValue("production_mode", "true");
		customizedcast.send();
	}
	
	public void sendAndroidFilecast() throws Exception {
		AndroidFilecast filecast = new AndroidFilecast();
		filecast.setAppMasterSecret(appMasterSecret);
		filecast.setPredefinedKeyValue("appkey", this.appkey);
		filecast.setPredefinedKeyValue("timestamp", this.timestamp);
		// TODO upload your device tokens, and use '\n' to split them if there are multiple tokens 
		filecast.uploadContents("aa"+"\n"+"bb");
		filecast.setPredefinedKeyValue("ticker", "Android filecast ticker");
		filecast.setPredefinedKeyValue("title",  "中文的title");
		filecast.setPredefinedKeyValue("text",   "Android filecast text");
		filecast.setPredefinedKeyValue("after_open", "go_app");
		filecast.setPredefinedKeyValue("display_type", "notification");
		filecast.send();
	}
	
	public void sendIOSBroadcast(String text,String messageType,String mapString) throws Exception {
		IOSBroadcast broadcast = new IOSBroadcast();
		broadcast.setAppMasterSecret(appMasterSecret);
		broadcast.setPredefinedKeyValue("appkey", this.appkey);
		broadcast.setPredefinedKeyValue("timestamp", this.timestamp);

		broadcast.setPredefinedKeyValue("alert", text);
		broadcast.setPredefinedKeyValue("badge", 0);
		broadcast.setPredefinedKeyValue("sound", "chime");
		// TODO set 'production_mode' to 'true' if your app is under production mode
		broadcast.setPredefinedKeyValue("production_mode", "false");
		// Set customized fields
		broadcast.setCustomizedField("messageType", messageType);
		broadcast.setCustomizedField("map", mapString);
		broadcast.send();
	}
	
	public void sendIOSUnicast() throws Exception {
		IOSUnicast unicast = new IOSUnicast();
		unicast.setAppMasterSecret(appMasterSecret);
		unicast.setPredefinedKeyValue("appkey", this.appkey);
		unicast.setPredefinedKeyValue("timestamp", this.timestamp);
		// TODO Set your device token
		unicast.setPredefinedKeyValue("device_tokens", "f24637c4f2e78a34d749a53faaf3cb1d22c99c011255f6876b21c363e84b774a");
		unicast.setPredefinedKeyValue("alert", "IOS 单播测试");
		unicast.setPredefinedKeyValue("badge", 0);
		unicast.setPredefinedKeyValue("sound", "chime");
		// TODO set 'production_mode' to 'true' if your app is under production mode
		unicast.setPredefinedKeyValue("production_mode", "false");
		// Set customized fields
		unicast.setCustomizedField("test", "helloworld");
		unicast.send();
	}
	
	public void sendIOSGroupcast() throws Exception {
		IOSGroupcast groupcast = new IOSGroupcast();
		groupcast.setAppMasterSecret(appMasterSecret);
		groupcast.setPredefinedKeyValue("appkey", this.appkey);
		groupcast.setPredefinedKeyValue("timestamp", this.timestamp);
		/*  TODO
		 *  Construct the filter condition:
		 *  "where": 
		 *	{
    	 *		"and": 
    	 *		[
      	 *			{"tag":"iostest"}
    	 *		]
		 *	}
		 */
		JSONObject filterJson = new JSONObject();
		JSONObject whereJson = new JSONObject();
		JSONArray tagArray = new JSONArray();
		JSONObject testTag = new JSONObject();
		testTag.put("tag", "iostest");
		tagArray.put(testTag);
		whereJson.put("and", tagArray);
		filterJson.put("where", whereJson);
		System.out.println(filterJson.toString());
		
		// Set filter condition into rootJson
		groupcast.setPredefinedKeyValue("filter", filterJson);
		groupcast.setPredefinedKeyValue("alert", "IOS 组播测试");
		groupcast.setPredefinedKeyValue("badge", 0);
		groupcast.setPredefinedKeyValue("sound", "chime");
		// TODO set 'production_mode' to 'true' if your app is under production mode
		groupcast.setPredefinedKeyValue("production_mode", "false");
		groupcast.send();
	}
	
	public void sendIOSCustomizedcast(String alias,String alert,String messageType,String mapString) throws Exception {
		IOSCustomizedcast customizedcast = new IOSCustomizedcast();
		customizedcast.setAppMasterSecret(appMasterSecret);
		customizedcast.setPredefinedKeyValue("appkey", this.appkey);
		customizedcast.setPredefinedKeyValue("timestamp", this.timestamp);
		// TODO Set your alias here, and use comma to split them if there are multiple alias.
		// And if you have many alias, you can also upload a file containing these alias, then 
		// use file_id to send customized notification.
		customizedcast.setPredefinedKeyValue("alias", alias);
		// TODO Set your alias_type here
		customizedcast.setPredefinedKeyValue("alias_type", "SINA_WEIBO");
		customizedcast.setPredefinedKeyValue("alert", alert);
		customizedcast.setPredefinedKeyValue("badge", 0);
		customizedcast.setPredefinedKeyValue("sound", "chime");
		// TODO set 'production_mode' to 'true' if your app is under production mode
		customizedcast.setPredefinedKeyValue("production_mode", "false");
		customizedcast.setCustomizedField("messageType", messageType);
		customizedcast.setCustomizedField("map", mapString);
		customizedcast.send();
	}
	
	public void sendIOSFilecast() throws Exception {
		IOSFilecast filecast = new IOSFilecast();
		filecast.setAppMasterSecret(appMasterSecret);
		filecast.setPredefinedKeyValue("appkey", this.appkey);
		filecast.setPredefinedKeyValue("timestamp", this.timestamp);
		// TODO upload your device tokens, and use '\n' to split them if there are multiple tokens 
		filecast.uploadContents("aa"+"\n"+"bb");
		filecast.setPredefinedKeyValue("alert", "IOS 文件播测试");
		filecast.setPredefinedKeyValue("badge", 0);
		filecast.setPredefinedKeyValue("sound", "chime");
		// TODO set 'production_mode' to 'true' if your app is under production mode
		filecast.setPredefinedKeyValue("production_mode", "false");
		filecast.send();
	}
	
	/**
	 * 单播
	 * @param alias  手机号 11111111111,22222222222
	 * @param title  标题
	 * @param text  内容
	 * @param messageType  类型枚举messagePushType
	 * @param mapString  参数map"{'aa':'11','bb':'22'}"
	 */
	public static void sendIOSAndAndroidMessage(String alias,String title,String text,String messageType,String mapString){
		Demo AndroidDemo = new Demo("549ba444fd98c5876b000851", "yp4slwl15uyw45kdp8llxorjb9qb97ks");
		Demo IosDemo = new Demo("555a910867e58e4d38003041", "6yynyuhr1j4yg5lknk7t1kfh3dd512l6");
		Demo AndroidPatientDemo = new Demo("549ba503fd98c5ba42001064", "rl1t6ffkjzfm6k5pfndfij3f68l89tql");
		try {
			AndroidDemo.sendAndroidCustomizedcast(alias,title,text,messageType,mapString);
			AndroidPatientDemo.sendAndroidCustomizedcast(alias,title,text,messageType,mapString);
			IosDemo.sendIOSCustomizedcast(alias,text,messageType,mapString);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 广播
	 * @param title  标题
	 * @param text  内容
	 * @param messageType  类型枚举messagePushType
	 * @param mapString  参数map"{'aa':'11','bb':'22'}"
	 */
	public static void sendIOSAndAndroidMessageBroadcast(String title,String text,String messageType,String mapString){
		Demo AndroidDemo = new Demo("549ba444fd98c5876b000851", "yp4slwl15uyw45kdp8llxorjb9qb97ks");
		Demo IosDemo = new Demo("555a910867e58e4d38003041", "6yynyuhr1j4yg5lknk7t1kfh3dd512l6");
		Demo AndroidPatientDemo = new Demo("549ba503fd98c5ba42001064", "rl1t6ffkjzfm6k5pfndfij3f68l89tql");
		try {
			AndroidDemo.sendAndroidBroadcast(title,text,messageType,mapString);
			AndroidPatientDemo.sendAndroidBroadcast(title,text,messageType,mapString);
			IosDemo.sendIOSBroadcast(text,messageType,mapString);
			Debug.log("广播推送成功！");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		// TODO set your appkey and master secret here
		//Demo demo = new Demo("50e26c315270156df0000031", "b3a09842d2c86177aa8268ee64f14f7e");
		//Demo demo = new Demo("549ba444fd98c5876b000851", "yp4slwl15uyw45kdp8llxorjb9qb97ks");
		//Demo demo = new Demo("54f96a2bfd98c59fb3000015", "edeull5geius6x3suxwpckbko4xcxdxm");
		try {
			//demo.sendAndroidUnicast();
			//demo.sendIOSBroadcast();
			//demo.sendAndroidCustomizedcast("111,222","标题","消息内容","joinMan","partyGv");
			//demo.sendAndroidBroadcast();
			//demo.sendIOSBroadcast();
			//demo.sendIOSCustomizedcast("147258,111111","IOS 个性化测试 就只给你推送！","joinMan","partyGv");
			//demo.sendIOSUnicast();
			/* TODO these methods are all available, just fill in some fields and do the test
			 * demo.sendAndroidBroadcast();
			 * demo.sendAndroidGroupcast();
			 * demo.sendAndroidCustomizedcast();
			 * demo.sendAndroidFilecast();
			 * 
			 * demo.sendIOSBroadcast();
			 * demo.sendIOSUnicast();
			 * demo.sendIOSGroupcast();
			 * demo.sendIOSCustomizedcast();
			 * demo.sendIOSFilecast();
			 */
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	

}
