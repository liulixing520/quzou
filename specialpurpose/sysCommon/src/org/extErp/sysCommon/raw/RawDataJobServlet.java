package org.extErp.sysCommon.raw;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RawDataJobServlet extends HttpServlet implements Servlet
{

    /**
     * @see javax.servlet.http.HttpServlet#void
     *      (javax.servlet.http.HttpServletRequest,
     *      javax.servlet.http.HttpServletResponse)
     */
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

    }

    /**
     * @see javax.servlet.http.HttpServlet#void
     *      (javax.servlet.http.HttpServletRequest,
     *      javax.servlet.http.HttpServletResponse)
     */
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {

    }

    /**
     * @see javax.servlet.GenericServlet#void ()
     */
    public void init() throws ServletException
    {
	super.init();

		// 启动 线程
	java.util.Timer timer = null;
	timer = new java.util.Timer(true);
	// String intervalTime=
	// UtilProperties.getPropertyValue("content",
	// "content.temp.dir");
	timer.schedule(new RawDataJob(), 0, 300 * 10000);
    }

}
