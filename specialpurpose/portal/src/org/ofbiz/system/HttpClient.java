package org.ofbiz.system;

import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.params.HttpConnectionParams;

public class HttpClient implements Client {
	
	private final MultiThreadedHttpConnectionManager connectionManager = new MultiThreadedHttpConnectionManager();
	
	private final org.apache.commons.httpclient.HttpClient client = new org.apache.commons.httpclient.HttpClient(connectionManager);

	private HttpConnectionParams hps = connectionManager.getParams();
	
	private final int TIMEOUT = 1000 * 10;
	
	private final int _SOTIMEOUT = 1000 * 3;

	private HttpMethod method;

	private int statusCode;

	public HttpClient(HttpMethod method) {
		this.method = method;
		this.hps.setConnectionTimeout(TIMEOUT);
	}
	
	public HttpClient(HttpMethod method,Integer tout) {
		this.method = method;
		this.hps.setConnectionTimeout(tout);
		this.hps.setSoTimeout(_SOTIMEOUT);
	}
	
	public int executeMethod() throws HttpException, IOException {
		this.statusCode = client.executeMethod(this.method);
		return this.statusCode;
	}
	
	public void setTimeout(int timeout) {
		this.hps.setConnectionTimeout(timeout);
	}
	
	public int getTimeout() {
		return this.hps.getConnectionTimeout();
	}

	public byte[] getResponseBody() throws IOException {
		return this.method.getResponseBody();
	}

	public InputStream getResponseBodyAsStream() throws IOException {
		return this.method.getResponseBodyAsStream();
	}

	public String getResponseBodyAsString() throws IOException {
		return this.method.getResponseBodyAsString();
	}
	
	public void shutDown() {
		if(this.method!=null) {
			this.method.abort();
			this.method.releaseConnection();
		}
		if(client!=null) {
			((MultiThreadedHttpConnectionManager) client
					.getHttpConnectionManager()).shutdown();
		}
	}

	public HttpMethod getMethod() {
		return method;
	}

	public void setMethod(HttpMethod method) {
		this.method = method;
	}

	protected void finalize() throws Throwable {
		shutDown();
		super.finalize();
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}
}
