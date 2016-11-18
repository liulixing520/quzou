package org.ofbiz.webapp.control;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharacterEncodingFilter implements Filter {
	protected String encoding = "UTF-8";
	protected FilterConfig filterConfig = null;
	protected boolean forceEncoding = false;

	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	public void setForceEncoding(boolean forceEncoding) {
		this.forceEncoding = forceEncoding;
	}

	@Override
	public void destroy() {
		this.encoding = null;
		this.filterConfig = null;
		this.forceEncoding = false;
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// Conditionally select and set the character encoding to be used
		if (this.forceEncoding || (request.getCharacterEncoding() == null)) {
			String encoding = selectEncoding(request);
			if (encoding != null) {
				request.setCharacterEncoding(encoding);
			}
		}
		// Pass control on to the next filter
		chain.doFilter(request, response);
	}

	private String selectEncoding(ServletRequest request) {
		return this.encoding;
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		this.encoding = filterConfig.getInitParameter("encoding");
		String value = filterConfig.getInitParameter("ignore");
		if (value == null)
			forceEncoding = true;
		else if (value.equalsIgnoreCase("true"))
			this.forceEncoding = true;
		else if (value.equalsIgnoreCase("yes"))
			this.forceEncoding = true;
		else
			this.forceEncoding = false;
	}
}
