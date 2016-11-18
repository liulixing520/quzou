package org.ofbiz.ofc.tools;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

public class FlightService {

	public static final String module = FlightService.class.getName();
	
	/**
	 <entity entity-name="ReportSql" package-name="org.ofbiz.sql">
 	<field name="baseId" type="id-long-ne">
 	 <description>SQL ID</description>
 	</field>
 	<field name="sqlCommand" type="very-long">
 	 <description>SQL 语句</description>
 	</field>
 	<field name="sqlParameters" type="very-long">
 	 <description>SQL 参数</description>
 	</field>
 	<field name="description" type="description">
 	 <description>描述</description>
 	</field>
 	<field name="httpdbUrl" type="value">
    	 <description>远程地址</description>
    	</field>
    	<field name="httpdbUsername" type="value">
    	 <description>远程地址用户名</description>
    	</field>
    	<field name="httpdbPassword" type="value">
    	 <description>远程地址密码</description>
    	</field>
 	<prim-key field="baseId"/>
	</entity>
 */
	
	
	/**
	 * 国内出发
	 */
	public static Map<String, Object> domesticDeparture(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = dctx.getDelegator();
		
		String flightAirport = (String) context.get("flightAirport");
		String flightNumber = (String) context.get("flightNumber");
		String airCity = (String) context.get("airCity");
		String airCompany = (String) context.get("airCompany");
		String timeDays = (String) context.get("timeDays");
		String flightStarttime = (String) context.get("flightStarttime");
		String flightEndtime = (String) context.get("flightEndtime");
		
		List<Map> flightList = FastList.newInstance();
		try {
//			   
			   GenericValue sqlGv  = delegator.findOne("OfcSqlAction", UtilMisc.toMap("baseId","domesticDeparture"),true);
			   if (UtilValidate.isEmpty(sqlGv)&&UtilValidate.isEmpty(sqlGv.getString("sqlCommand"))) {return ServiceUtil.returnError("domesticDeparture sql is not set");}
			   String httpdbUrl = sqlGv.getString("httpdbUrl");
			   String httpdbUsername = sqlGv.getString("httpdbUsername");
			   String httpdbPassword = sqlGv.getString("httpdbPassword");
			   String sqlCommand = sqlGv.getString("sqlCommand");
			   if (UtilValidate.isNotEmpty(flightAirport)){
				   sqlCommand=sqlCommand.replace("1=1", "flightAirport='"+flightAirport+"'");
			   }
			   if (UtilValidate.isNotEmpty(airCity)){
				   sqlCommand=sqlCommand.replace("2=2", "airCity='"+airCity+"'");
			   }
			   flightList= executeQuery(sqlCommand,httpdbUrl,httpdbUsername,httpdbPassword);
			   result.put("flightList", flightList);
			
		} catch (Exception e) {
			Debug.logError(e, module);
			return ServiceUtil.returnError(e.getMessage());
		}
		return result;
	}
	
	/**
	 * 
	 * @param sql
	 * @param httpurl 服务端的地址
	 * @param username 服务端设置的用户名
	 * @param password 服务端设置的密码
	 * httpdb.xml 中设置
	<httpdb>
	<db name="mysql" password="123456" class="com.mchange.v2.c3p0.ComboPooledDataSource">
	   <property name="driverClass" value="com.mysql.jdbc.Driver"/>
	   <property name="jdbcUrl" value="jdbc:mysql://localhost:3306/test"/>
	   <property name="user" value="root"/>
	   <property name="password" value="root"/>
	   <property name="minPoolSize" value="1"/>
	   <property name="maxPoolSize" value="20"/>  
	   <property name="initialPoolSize" value="1"/>
	   <property name="maxIdleTime" value="60000"/>
	   <property name="acquireIncrement" value="1"/>
	</db>
</httpdb>

	 * @return
	 */
	private static List<Map> executeQuery(String sql,String httpurl,String username,String password) {
		List<Map> list=FastList.newInstance();
		Connection conn = null;
	    Statement stmt = null;
	    ResultSet rs = null;
	    try {
	    	Class.forName("com.hg.httpdb.Driver");
	    	//conn = DriverManager.getConnection("http://xdoc.sinaapp.com/httpdb", "xdoc", "123456");
	    	conn = DriverManager.getConnection(httpurl, username, password);
	        stmt = conn.createStatement();
	        rs = stmt.executeQuery(sql);
	        ResultSetMetaData rsmd = rs.getMetaData();
	        while (rs.next()) {
	        	Map map=new HashMap();
	        	for (int i = 1; i <= rsmd.getColumnCount(); i++) {
	        		map.put(rsmd.getColumnName(i), rs.getObject(i));
	        		list.add(map);
	        	}
	        }
	    } catch (Exception e) {
	    	Debug.logError(e.getMessage(), module);
	    } finally {
	    	try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	        	Debug.logError(e.getMessage(), module);
	        }
	    }
	    
	    return list;
	}

}
