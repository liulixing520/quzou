package org.ofbiz.quzouwx;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Random;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastMap;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.extErp.sysCommon.util.JsonUtil;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.service.DispatchContext;
/**
 * 核心服务类
 * 
 */
public class WechatServices {

	public static String APPLICATION_JSON = "application/json";
	
	/** 支付密钥，商户平台 > API安全 > 密钥管理 中进行设置 */
    private static final String API_KEY = "FDEE29E914BABB180E0F82942E6D730F";
    
	/** 应用ID */
	public static final String AppID = "wx00b8a71c1cfc4f43";
	/** 应用密钥 */
	public static final String AppSecret = "321f089be6d4551acdebea4651358379";
    /**回调授权**/
    public static final String DOMAIN = "www.quzou365.com.cn";
    
	/** AccessToken */
 	public static String AccessToken = "";
	public static String jsapi_ticket = "";


	/**
	 * 获取access_token接口调用凭证
	 * 
	 * @param request
	 * @return
	 */
	public static Map<String, Object> wechatGetToken(DispatchContext dctx,
			Map<String, ? extends Object> context) {
		JSONObject json = new JSONObject();
		Map<String, Object> map = FastMap.newInstance();
		if (UtilValidate.isEmpty(AccessToken)) {
			map = getResponse(WechatURL.GetToken
					+ "?grant_type=client_credential&appid=" + AppID + "&secret="
					+ AppSecret, json.toString());
			AccessToken = (String) map.get("access_token");
		}else {
			map.put("access_token", AccessToken);
		}
		Debug.log("AccessToken==="+AccessToken);
		return map;
	}
	
	/**
	 * 将AccessToken置为空
	 * 
	 * @param request
	 * @return
	 */
	public static Map<String, Object> timingRun(DispatchContext dctx,
			Map<String, ? extends Object> context) {
		Map<String, Object> map = FastMap.newInstance();
		AccessToken = null;
		jsapi_ticket = null;
		return map;
	}
	
	
	
	/**
	 * 根据openid获取用户信息
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> getUserByOpenId(DispatchContext dctx,Map<String, ? extends Object> context){
		String access_token = (String) wechatGetToken(dctx,context).get("access_token");
		String next_openid = (String) context.get("openid");
		String lang = (String) context.get("lang");
		String jsonStr = "";
		Map resultMap = getResponse(WechatURL.GetUserByOpendId+"?access_token="+access_token+"&openid="+next_openid+"&lang="+lang,jsonStr);
		if(UtilValidate.isNotEmpty(resultMap.get("errcode"))){
			AccessToken = "";
			access_token = (String) wechatGetToken(dctx,context).get("access_token");
			resultMap = getResponse(WechatURL.GetUserByOpendId+"?access_token="+access_token+"&openid="+next_openid+"&lang="+lang,jsonStr);
		}
		resultMap = JsonUtil.jsonFromMap(resultMap);
		return resultMap;
	}
	/**
	 * 请求接口
	 * @param serviceName
	 * @param jsonStr
	 * @return
	 */
	public static Map<String, Object> getResponse(String serviceName,
			String jsonStr) {
		String urlstr = WechatURL.BASEURL + serviceName;  
		Map<String, Object> resultMap = FastMap.newInstance();
		try {

			URL httpclient = new URL(urlstr);
			HttpURLConnection conn = (HttpURLConnection) httpclient
					.openConnection();
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(20000);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.connect();
			OutputStream os = conn.getOutputStream();
			System.out.println("req:" + jsonStr);
			os.write(jsonStr.getBytes("UTF-8"));// 传入参数
			os.flush();
			os.close();

			InputStream is = conn.getInputStream();
			int size = is.available();
			byte[] jsonBytes = new byte[size];
			is.read(jsonBytes);
			String message = new String(jsonBytes, "UTF-8");
			System.out.println("resp:" + message);
			resultMap = parserToMap(message);

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	/**
	 * 转换成map
	 * @param s
	 * @return
	 */
	public static Map<String, Object> parserToMap(String s) {
		Map map = new HashMap();
		JSONObject json = JSONObject.fromObject(s);
		Iterator keys = json.keys();
		while (keys.hasNext()) {
			String key = (String) keys.next();
			String value = json.get(key).toString();
			if (value.startsWith("{") && value.endsWith("}")) {
				map.put(key, parserToMap(value));
			} else {
				if (value.startsWith("[\"") && value.endsWith("\"]")) {
					//JSONArray  
			        JSONArray jsonArray = JSONArray.fromObject(value);  
			        List<String> stringListJson = (List)jsonArray;  
			        map.put(key, stringListJson);
				}else if (value.startsWith("[{") && value.endsWith("}]")) {
			        	//JSONArray  
			        	JSONArray jsonArray = JSONArray.fromObject(value);  
			        	List<Map<String, Object>> mapListJson = (List)jsonArray;  
			        	map.put(key, mapListJson);
				}else {
					map.put(key, value);
				}
			}

		}
		return map;
	}
	
	
	public static String getAccess_token() {
		String access_token = null;
		if(UtilValidate.isEmpty(AccessToken)){
			StringBuffer action = new StringBuffer();
			action.append(WechatURL.BASEURL).append(WechatURL.GetToken)
			// 获取token
			.append("?grant_type=client_credential")
			.append("&appid=" + AppID).append("&secret=" + AppSecret);
			
			URL url;
			try {
				url = new URL(action.toString());
				HttpURLConnection http = (HttpURLConnection) url.openConnection();
				http.setRequestMethod("GET");
				http.setRequestProperty("Content-Type",
						"application/x-www-form-urlencoded");
				http.setDoInput(true);
				InputStream is = http.getInputStream();
				int size = is.available();
				byte[] buf = new byte[size];
				is.read(buf);
				String resp = new String(buf, "UTF-8");
				JSONObject jsonObject = JSONObject.fromObject(resp);
				System.out.println("access_token:" + jsonObject.toString());
				Object object = jsonObject.get("access_token");
				if (object != null) {
					access_token = String.valueOf(object);
				}
				AccessToken = access_token;
				return access_token;
			} catch (MalformedURLException e) {
				e.printStackTrace();
				return access_token;
				
			} catch (IOException e) {
				e.printStackTrace();
				return access_token;
				
			}
		}else {
			return AccessToken;
		}
	}

    /**
     * 微信验证
     * @param request
     * @param response
     * @throws IOException
     */
    public static String checkLogin(HttpServletRequest request,  
            HttpServletResponse response) throws IOException {  
        String code = request.getParameter("code");  
        HttpSession session = request.getSession();  
        boolean isValidCode = true;  
        String serviceUrl = URLEncoder.encode("http://" + DOMAIN+request.getRequestURI(), "utf-8");  
               
        Map map = request.getParameterMap();
        String parmString = "?";
        for(Iterator iter = map.entrySet().iterator();iter.hasNext();){ 
            Map.Entry element = (Map.Entry)iter.next(); 
            String strKey = element.getKey().toString();//获取参数
            Object ov=element.getValue(); //获取参数值
            String[] value=new String[1];
            if(ov instanceof String[]){
             value=(String[])ov;
            }else{
             value[0]=ov.toString();
            }
            
            String strValue = value[0];
            parmString +=strKey+"="+strValue+"&";
        }
        parmString = parmString.substring(0, parmString.length()-1);
        //检查是否已验证或者验证是否通过  
        if (code == null || code.equals("authdeny")) {  
            isValidCode = false;  
        }  
        serviceUrl = serviceUrl+parmString;
        //如果session未空或者取消授权，重定向到授权页面  
        if ((!isValidCode) && session.getAttribute("userInfo") == null) {  
            StringBuilder oauth_url = new StringBuilder();  
            oauth_url.append("https://open.weixin.qq.com/connect/oauth2/authorize?");  
            oauth_url.append("appid=").append(AppID);  
            oauth_url.append("&redirect_uri=").append(serviceUrl);  
            oauth_url.append("&response_type=code");  
            oauth_url.append("&scope=snsapi_userinfo");  
            oauth_url.append("&state=1#wechat_redirect");  
            response.sendRedirect(oauth_url.toString());  
        }  
        //如果用户同意授权并且，用户session不存在，通过OAUTH接口调用获取用户信息  
        
        if (isValidCode && session.getAttribute("userInfo") == null) {  
                JSONObject obj = getAccessToken(AppID,AppSecret, code);  
                String token = obj.getString("access_token");  
                String openid = obj.getString("openid");  
                JSONObject userInfo = getUserInfo(token, openid);  
                session.setAttribute("userInfo", userInfo);
                
        }  
        return "success";
    }  
  
  
    /** 
     * 获取授权令牌 
     * */  
    public static JSONObject getAccessToken(String appid, String secret,  
            String code) {  
        StringBuilder url = new StringBuilder();  
        url.append("https://api.weixin.qq.com/sns/oauth2/access_token?");  
        url.append("appid=" + appid);  
        url.append("&secret=").append(secret);  
        url.append("&code=").append(code);  
        url.append("&grant_type=authorization_code"); 
        Map resultMap = getResponseUrl(url.toString());
        return JSONObject.fromObject(resultMap);  
    }  
  
    //获取用户信息  
    public static JSONObject getUserInfo(String token, String openid) {  
        StringBuilder url = new StringBuilder();  
        url.append("https://api.weixin.qq.com/sns/userinfo?");  
        url.append("access_token=" + token);  
        url.append("&openid=").append(openid);  
        url.append("&lang=zh_CN");  
        Map resultMap = getResponseUrl(url.toString());
        return JSONObject.fromObject(resultMap);  
    } 
    
    /**
	 * 请求接口
	 * @param serviceName
	 * @param jsonStr
	 * @return
	 */
	public static Map<String, Object> getResponseUrl(String serviceUrl) {
		String urlstr = serviceUrl;  
		Map<String, Object> resultMap = FastMap.newInstance();
		try {

			URL httpclient = new URL(urlstr);
			HttpURLConnection conn = (HttpURLConnection) httpclient
					.openConnection();
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(20000);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.connect();
			OutputStream os = conn.getOutputStream();
			System.out.println("req:" + serviceUrl);
			os.write(serviceUrl.getBytes("UTF-8"));// 传入参数
			os.flush();
			os.close();

			InputStream is = conn.getInputStream();
			int size = is.available();
			byte[] jsonBytes = new byte[size];
			is.read(jsonBytes);
			String message = new String(jsonBytes, "UTF-8");
//			System.out.println("resp:" + message);
			resultMap = parserToMap(message);

		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	
	public static String getJsapi_tiket(String token) {
		String jsapiTicket = null;
		if(UtilValidate.isEmpty(jsapi_ticket)){
			 /**获取ticket的请求URL，需要token作为参数*/
            String getTicket = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?type=jsapi&access_token=" + token;
            jsapi_ticket = (String) getResponseUrl(getTicket).get("ticket");
            return jsapi_ticket;
		}else {
			return jsapi_ticket;
		}
	}
	
	/**
	 * 获取签名
	 * @param request
	 * @param response
	 * @return
	 */
	public static String creatConfigSign(HttpServletRequest request,HttpServletResponse response){
		
		/**全局map，该map存放前端ajax请求的返回值信息，包括wx.config中的配置参数值，也包括wx.chooseWXPay中的配置参数值*/
        SortedMap<Object, Object> params = new TreeMap<Object, Object>();
		SortedMap<Object, Object> configMap = new TreeMap<Object, Object>();
		String timeStamp = (System.currentTimeMillis()+"").substring(0,10);
		String clientUrl = request.getParameter("clientUrl");
		/**使用JSSDK支付，需要另一个凭证，也就是ticket。这个是JSSDK中使用到的。*/
        /**获取ticket，需要token作为参数传递,由于token有有效期限制，和调用次数限制，你可以缓存到session或者数据库中.有效期设置为小于7200秒*/
        String token = getAccess_token();
        Debug.log("获取的token值为:" + token);
        /**获取ticket*/
        String jsapi_ticket = getJsapi_tiket(token);
        // 获取到ticket凭证之后，需要进行一次签名
        String config_nonceStr = getNonceStr();// 获取随机字符串
        // 加入签名的参数有4个，分别是： noncestr、jsapi_ticket、timestamp、url，注意字母全部为小写
        configMap.put("jsapi_ticket", jsapi_ticket);
        configMap.put("noncestr", config_nonceStr);
        configMap.put("timestamp", timeStamp);
        configMap.put("url", clientUrl);
        //该签名是用于前端js中wx.config配置中的signature值。
        Debug.log("configMap=="+configMap);
        String config_sign = createSign_wx_config("UTF-8", configMap);
     // 将config_nonceStr、jsapi_ticket 、config_timestamp、config_sign一同传递到前端
        // 这几个参数名称和上面获取预支付prepay_id使用的参数名称是不一样的，不要混淆了。
        // 这几个参数是提供给前端js代码在调用wx.config中进行配置的参数，wx.config里面的signature值就是这个config_sign的值，以此类推
        params.put("appId", AppID);
        params.put("config_nonceStr", config_nonceStr);
        params.put("config_timestamp", timeStamp);
        params.put("config_sign", config_sign);
        
        // 将map转换为json字符串，传递给前端ajax回调
        Debug.log("用于wx.config配置的json：" + params.toString());
        JsonUtil.toJsonObject(params, response);
		return "success";
	}	
	/**
     * 获取32位随机字符串
     * 
     * 作者: zhoubang 
     * 日期：2015年6月26日 下午3:51:44
     * @return
     */
    public static String getNonceStr() {
        Random random = new Random();
        return MD5Util.MD5Encode(String.valueOf(random.nextInt(10000)), "UTF-8");
    }
    
    // SHA1加密，该加密是对wx.config配置中使用到的参数进行SHA1加密，这里不需要key参与加密
    public static String createSign_wx_config(String characterEncoding, SortedMap<Object, Object> parameters) {
        StringBuffer sb = new StringBuffer();
        Set<Entry<Object, Object>> es = parameters.entrySet();
        Iterator<Entry<Object, Object>> it = es.iterator();
        while (it.hasNext()) {
            Map.Entry<Object, Object> entry = (Map.Entry<Object, Object>) it.next();
            String k = (String) entry.getKey();
            Object v = entry.getValue();
            if (null != v && !"".equals(v)) {
                sb.append(k + "=" + v + "&");
            }
        }
        String str = sb.toString();
        String sign = Sha1Util.getSha1(str.substring(0, str.length() - 1));
        return sign;
    }
    /**
     * sign签名，必须使用MD5签名，且编码为UTF-8
     * 
     * 作者: zhoubang 日期：2015年6月10日 上午9:31:24
     * 
     * @param characterEncoding
     * @param parameters
     * @return
     */
    public static String createSign_ChooseWXPay(String characterEncoding, SortedMap<Object, Object> parameters) {
        StringBuffer sb = new StringBuffer();
        Set<Entry<Object, Object>> es = parameters.entrySet();
        Iterator<Entry<Object, Object>> it = es.iterator();
        while (it.hasNext()) {
            Map.Entry<Object, Object> entry = (Map.Entry<Object, Object>) it.next();
            String k = (String) entry.getKey();
            Object v = entry.getValue();
            if (null != v && !"".equals(v) && !"sign".equals(k) && !"key".equals(k)) {
                sb.append(k + "=" + v + "&");
            }
        }
        /** 支付密钥必须参与加密，放在字符串最后面 */
        sb.append("key=" + API_KEY);
        String sign = MD5Util.MD5Encode(sb.toString(), characterEncoding).toUpperCase();
        return sign;
    }



}
