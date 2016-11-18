package org.ofbiz.system;

import java.io.IOException;
import java.io.InputStream;
import org.apache.commons.httpclient.HttpException;

public interface Client {
	
	public int executeMethod() throws HttpException, IOException;
	
	public String getResponseBodyAsString() throws IOException;
	
	public byte[] getResponseBody() throws IOException;
	
	public InputStream getResponseBodyAsStream() throws IOException;
	
	public void shutDown();
}
