package org.extErp.sysCommon.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class PrintWriterUtil
{
    public static void print(HttpServletResponse response, Object obj)
    {
	try
	{
	    PrintWriter pw = response.getWriter();
	    pw.print(obj);
	    pw.flush();
	    pw.close();
	} catch (IOException e)
	{
	    e.printStackTrace();
	}
    }
}
