package org.extErp.sysCommon.sms;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.ofbiz.base.util.Debug;

public class SendMsg_webchinese {
	
	public static final String module = SendMsg_webchinese.class.getName();
	
	/**
	 * 发送短信
	 * @param smsMob 发送的目标手机号（如：13888888886,13888888887,1388888888）
	 * @param context  发送内容
	 * @return
	 */
	public static String sendSmsWj(String smsMob,String context){
		String resultStr = "false";
		StringBuffer phoNum = new StringBuffer();
		try {
			for(String num:smsMob.split(",")){
				if(isMobileNO(num)){
					phoNum.append(num+",");
				}
			}
			if(!("".equals(phoNum.toString()))){
				phoNum.deleteCharAt(phoNum.lastIndexOf(","));
				smsMob = phoNum.toString();
			}else{
				return null;
			}
//			smsMob = "18610035780";
			HttpClient client = new HttpClient();
			PostMethod post = new PostMethod("http://gbk.sms.webchinese.cn"); 
			post.addRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=gbk");
			NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob",""+smsMob+""),
					new NameValuePair("smsText",""+context+"【医学参考】")};
			post.setRequestBody(data);
			client.executeMethod(post);
//			Header[] headers = post.getResponseHeaders();
//			int statusCode = post.getStatusCode();
//			System.out.println("statusCode:"+statusCode);
//			for(Header h : headers){
//				System.out.println(h.toString());
//			}
			String result = new String(post.getResponseBodyAsString().getBytes("gbk")); 
//			System.out.println(result);
			if(Integer.parseInt(result)<0){
				resultStr = "短信发送失败！";
				Debug.logError("内容为："+context+",的短信发送失败！错误代码："+result, module);
			}
			resultStr = "true";
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultStr;
	}

	public static void main(String[] args)throws Exception{
		/*HttpClient client = new HttpClient();
		PostMethod post = new PostMethod("http://gbk.sms.webchinese.cn"); 
		post.addRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=gbk");//��ͷ�ļ�������ת��
		NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob","18610035780"),new NameValuePair("smsText","李华医生依据您的病情建议您来复诊，请登录应用查看医生出诊日期。【医学参考】")};
//		NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob","18610035780"),new NameValuePair("smsText","系统已为您创建了《医学参考》账户。用户名为18610035780，密码为785216，本次就诊信息已添加，请登录完善，以便医生对您进行随访跟踪治疗。【医学参考】")};
//		NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob","18610035780"),new NameValuePair("smsText","骨科学频道主编李华邀请您担任该频道下的编委。询问您是否同意。【医学参考】")};
//		NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob","18610035780"),new NameValuePair("smsText","您的文章《胸腰椎不稳定性爆裂骨折能否只固定不融合？》同行讨论很活跃，建议是否将该文章转为医学参考报社项目，让更多医生受益。请登录医学参考应用处理。【医学参考】")};
//		NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob","18610035780"),new NameValuePair("smsText","您的验证码是：885394，请于2分钟内正确输入。【医学参考】")};
//		NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob","18610035780"),new NameValuePair("smsText","“李华”发起医学参考报项目《覆盖层》，邀请您担任联合发起人，询问您是否同意。请登录医学参考应用处理。【医学参考】")};
//		NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob","18610035780"),new NameValuePair("smsText","骨科学频道李华主编邀请您成为该频道的编辑，询问您是否同意。请登录医学参考应用处理。【医学参考】")};
//		NameValuePair[] data ={ new NameValuePair("Uid", "zi_feng_lin"),new NameValuePair("Key", "ab3046cc85b9d8beff1b"),new NameValuePair("smsMob","18801044452"),new NameValuePair("smsText","骨科学频道李华主编邀请您成为该频道的编辑，询问您是否同意，您的医学参考账户18610035780，密码111111。请登录医学参考应用处理。http://182.92.185.73/yxck【医学参考】")};
		post.setRequestBody(data);
		
		client.executeMethod(post);
		Header[] headers = post.getResponseHeaders();
		int statusCode = post.getStatusCode();
		System.out.println("statusCode:"+statusCode);
		for(Header h : headers)
		{
		System.out.println(h.toString());
		}
		String result = new String(post.getResponseBodyAsString().getBytes("gbk")); 
		System.out.println(result); //��ӡ������Ϣ״̬
		
		
		post.releaseConnection();*/
		
//		System.out.println(isMobileNO("12110176500"));
	
	}
	
	public static boolean isMobileNO(String mobiles) {
		Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$");
		Matcher m = p.matcher(mobiles);
	return m.matches();
	}

}