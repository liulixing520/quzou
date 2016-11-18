package org.ofbiz.ofc.tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HttpDBClient {

	
public static void main(String[] args) {
//	Connection conn = null;
//    Statement stmt = null;
//    ResultSet rs = null;
//    try {
//    	Class.forName("com.hg.httpdb.Driver");
//    	conn = DriverManager.getConnection("http://xdoc.sinaapp.com/httpdb", "xdoc", "123456");
//        stmt = conn.createStatement();
//        rs = stmt.executeQuery("select * from emp");
//        ResultSetMetaData rsmd = rs.getMetaData();
//        for (int i = 1; i <= rsmd.getColumnCount(); i++) {
//        	if (i > 1) {
//        		System.out.print(",");
//        	}
//        	System.out.print(rsmd.getColumnName(i));
//        }
//        while (rs.next()) {
//        	System.out.println();
//        	for (int i = 1; i <= rsmd.getColumnCount(); i++) {
//        		if (i > 1) {
//        			System.out.print(",");
//        		}
//        		System.out.print(rs.getObject(i));
//        	}
//        }
//    } catch (Exception e) {
//    	e.printStackTrace();
//    } finally {
//    	try {
//            if (rs != null) rs.close();
//            if (stmt != null) stmt.close();
//            if (conn != null) conn.close();
//        } catch (Exception e) {
//        }
//    }
	
	ss();
}


public static void ss() {
	List list=new ArrayList();
	Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
    	Class.forName("com.hg.httpdb.Driver");
    	conn = DriverManager.getConnection("http://xdoc.sinaapp.com/httpdb", "xdoc", "123456");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("select * from emp");
        ResultSetMetaData rsmd = rs.getMetaData();
        while (rs.next()) {
        	Map map=new HashMap();
        	for (int i = 1; i <= rsmd.getColumnCount(); i++) {
        		map.put(rsmd.getColumnName(i), rs.getObject(i));
        		list.add(map);
        	}
        }
    } catch (Exception e) {
    	e.printStackTrace();
    } finally {
    	try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
        }
    }
}

}