package org.ofbiz.ebiz.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.apache.http.client.HttpClient;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.ParseException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.NameValuePair;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilIO;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

public class UtilHttpClient {
	private static String module = UtilHttpClient.class.getName();

	private String respStatus = null;
	private List<String> headers =null;
	private String respContent = null;

	public HttpClient getClient() {
		HttpClient client = new DefaultHttpClient();// 获取HttpClient对象
		return client;
	}

	private void releaseConnection(HttpRequestBase request) {
		if (request != null) {
			request.releaseConnection();
		}
	}

	private void showResponse(HttpResponse response) throws ParseException,
			IOException {
		Debug.log("requset result:");
		this.respStatus = response.getStatusLine().toString();
		Debug.log(this.respStatus);// 响应状态
		Debug.log("-----------------------------------");
		Header[] heard = response.getAllHeaders();// 响应头
		this.headers = FastList.newInstance();
		Debug.log("response heard:");
		for (int i = 0; i < heard.length; i++) {
			this.headers.add(heard[i].toString());
			Debug.log(heard[i].toString());
		}
		Debug.log("-----------------------------------");
		HttpEntity entity = response.getEntity();// 响应实体/内容
		Debug.log("response content length:" + entity.getContentLength());
		Debug.log("response content:");
		this.respContent = EntityUtils.toString(entity);
		Debug.log(this.respContent);
	}

	public String getRespContent() {
		return respContent;
	}

	public void setRespContent(String respContent) {
		this.respContent = respContent;
	}

	public void doGet(String uri) {// get方法提交
		HttpGet getMethod = null;
		getMethod = new HttpGet(uri);// 获取HttpGet对象，使用该对象提交get请求
		exctueRequest(getMethod);
	}

	public void doPost(String uri, HttpEntity entity) {// post方法提交
		HttpPost postMethod = null;
		postMethod = new HttpPost(uri);
		postMethod.setEntity(entity);// 设置请求实体，例如表单数据
		exctueRequest(postMethod); // 执行请求，获取HttpResponse对象

	}

	public HttpResponse exctueRequest(HttpRequestBase request) {
		HttpResponse response = null;

		try {
			Debug.log("excute request:" + request.getURI());
			Debug.log("-----------------------------------");
			response = this.getClient().execute(request);// 执行请求，获取HttpResponse对象
			showResponse(response);
			int statuscode = response.getStatusLine().getStatusCode();// 处理重定向
			if ((statuscode == HttpStatus.SC_MOVED_TEMPORARILY)
					|| (statuscode == HttpStatus.SC_MOVED_PERMANENTLY)
					|| (statuscode == HttpStatus.SC_SEE_OTHER)
					|| (statuscode == HttpStatus.SC_TEMPORARY_REDIRECT)) {

				Header redirectLocation = response.getFirstHeader("Location");
				String newuri = redirectLocation.getValue();
				if ((newuri != null) || (!newuri.equals(""))) {
					Debug.log("redirect to " + newuri);
					request.setURI(new URI(newuri));
					response = this.getClient().execute(request);
					showResponse(response);
				} else {
					Debug.log("Invalid redirect");
				}

			}
		} catch (Exception e) {
			Debug.log(e);
		} finally {
			releaseConnection(request);// 释放连接
		}
		return response;

	}

	public static Map doPost(String strUrl, Map<String, Object> params,
			Map addParams) {
		Map result = FastMap.newInstance();
		UtilHttpClient client = new UtilHttpClient();

		List<NameValuePair> formparams = new ArrayList<NameValuePair>();// 设置表格参数
		for (Map.Entry<String, Object> entry : params.entrySet()) {
			formparams.add(new BasicNameValuePair(entry.getKey(), entry
					.getValue().toString()));
		}
		// formparams.add(new BasicNameValuePair("usrname", "admin"));
		// formparams.add(new BasicNameValuePair("password", "123456"));
		UrlEncodedFormEntity uefEntity = null;
		try {
			uefEntity = new UrlEncodedFormEntity(formparams, "UTF-8");// 获取实体对象
		} catch (UnsupportedEncodingException e) {
			Debug.log(e);
		}
		client.doPost(strUrl, uefEntity);

		// String contentEncoding = httpEnt.getContentEncoding().getValue();
		String content = client.getRespContent();

		/*
		Document doc = null;
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		try {
			DocumentBuilder builder = factory.newDocumentBuilder();
			doc = builder.parse(content);
		} catch (ParserConfigurationException e) {
			Debug.log(e);
		} catch (IllegalStateException e) {
			Debug.log(e);
		} catch (SAXException e) {
			Debug.log(e);
		} catch (IOException e) {
			Debug.log(e);
		}
		*/

		// result.put("contentEncoding", contentEncoding);
		Debug.log("content=" + content, module);
		result.put("content", content);
		/*
		if (doc != null) {
			String xmlContent = doc.toString();
			Debug.log("xmlContent=" + xmlContent, module);
			result.put("xmlContent", xmlContent);
		}
		*/

		return result;
	}

	public String getRespStatus() {
		return respStatus;
	}

	public void setRespStatus(String respStatus) {
		this.respStatus = respStatus;
	}

	public List<String> getHeaders() {
		return headers;
	}

	public void setHeaders(List<String> headers) {
		this.headers = headers;
	}

	/**
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 */
	public static Map<String, Object> testPost(DispatchContext dctx, Map<String, Object> context) {
		Delegator delegator = dctx.getDelegator();
        LocalDispatcher dispatcher = dctx.getDispatcher();
        GenericValue userLogin = (GenericValue) context.get("userLogin");
        String postUrl = (String)context.get("postUrl");
        String postParams = (String)context.get("postParams");
        Map<String, Object> result = ServiceUtil.returnSuccess();
       
        Map<String,Object> mapPara = UtilHttp.getQueryStringOnlyParameterMap(postParams);
        Map ret = UtilHttpClient.doPost(postUrl, mapPara, null);
        result.put("content",ret.get("content"));
        return result;
	}
}
