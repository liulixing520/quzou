package org.extErp.sysCommon.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;
import javolution.util.FastSet;
import jxl.Sheet;
import jxl.Workbook;
import oracle.sql.TIMESTAMP;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.extErp.sysCommon.document.DocumentUtils;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.ObjectType;
import org.ofbiz.base.util.StringUtil;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilHttp;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntity;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityComparisonOperator;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityFunction;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.jdbc.SQLProcessor;
import org.ofbiz.entity.model.ModelField;
import org.ofbiz.entity.model.ModelUtil;
import org.ofbiz.security.Security;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;
public class OfbizExtUtil
{
    public static final String module = OfbizExtUtil.class.getName();

    /**
     * 
     * convertParamStrsToList(/处理in类型 strings转换为list用)<br/>
     * 
     * @param inMap
     */
    public static void convertParamStrsToList(Map<Object, Object> parameters, Map<Object, Object> inputFields)
    {
	try
	{
	    for (Map.Entry mapEntry : parameters.entrySet())
	    {
		Object entryValue = mapEntry.getValue();
		if (mapEntry.getKey().toString().indexOf("_op") != -1 && (entryValue.equals("in") || entryValue.equals("not-in")))
		{
		    String idKey = mapEntry.getKey().toString().substring(0, mapEntry.getKey().toString().indexOf("_op"));
		    if (parameters.get(idKey) instanceof String)
		    {
			inputFields.put(idKey, StringUtil.split(parameters.get(idKey).toString(), ","));
		    } else if (parameters.get(idKey) instanceof List)
		    {
			inputFields.put(idKey, parameters.get(idKey));
		    }
		}
	    }
	} catch (Exception e)
	{
	    Debug.logWarning("类型转换错误", null);
	}
    }

    /**
     * 
     * convertParamStrsToList(/处理in类型 strings转换为list用)<br/>
     * 
     * @param inMap
     */
    public static void convertParamStrsToList(Map<Object, Object> inputFields)
    {
	try
	{
	    for (Map.Entry mapEntry : inputFields.entrySet())
	    {
		Object entryValue = mapEntry.getValue();
		if (mapEntry.getKey().toString().indexOf("_op") != -1 && (entryValue.equals("in") || entryValue.equals("not-in")))
		{

		    String idKey = mapEntry.getKey().toString().substring(0, mapEntry.getKey().toString().indexOf("_op"));
		    if (inputFields.get(idKey) instanceof String)
		    {
			inputFields.put(idKey, StringUtil.split(inputFields.get(idKey).toString(), ","));
		    } else if (inputFields.get(idKey) instanceof List)
		    {
			inputFields.put(idKey, inputFields.get(idKey));
		    }
		}
	    }
	} catch (Exception e)
	{
	    Debug.logWarning("类型转换错误", null);
	}
    }

    /**
     * 
     * filterInput(这里用一句话描述这个方法的作用)<br/>
     * (这里描述这个方法适用条件 – 可选)<br/>
     * 
     * @param inputFields
     * @param filterInput
     * @return
     */
    public static Map filterInput(Map<Object, Object> inputFields, String[] filterInput)
    {
	Map<String, Object> whereMap = FastMap.newInstance();
	try
	{
	    for (Map.Entry mapEntry : inputFields.entrySet())
	    {
		boolean isWhere = true;
		for (int i = 0; i < filterInput.length; i++)
		{
		    if (mapEntry.getKey().toString().equals(filterInput[i]))
		    {
			isWhere = false;
			break;
		    }
		}
		if (isWhere)
		{
		    whereMap.put(mapEntry.getKey().toString(), mapEntry.getValue().toString());
		}
	    }
	} catch (Exception e)
	{
	    Debug.logWarning("类型转换错误", null);
	}
	return whereMap;
    }

    /**
     * 
     * same as performFind but now returning a list instead of an
     * iterator Extra parameters viewIndex: startPage of the partial
     * list (0 = first page) viewSize: the length of the page (number
     * of records) Extra output parameter: listSize: size of the
     * totallist list : the list itself.
     * 
     * @param dctx
     * @param context
     * @return Map
     */
    public static Map<String, Object> performFindSqlList(DispatchContext dctx, Map<String, Object> context)
    {
	Integer viewSize = (Integer) context.get("viewSize");
	if (viewSize == null)
	    viewSize = Integer.valueOf(20); // default
	context.put("viewSize", viewSize);
	Integer viewIndex = (Integer) context.get("viewIndex");
	if (viewIndex == null)
	    viewIndex = Integer.valueOf(0); // default
	context.put("viewIndex", viewIndex);
	Delegator delegator = dctx.getDelegator();

	Map<String, Object> result = performFindList(delegator, context);
	return result;
    }

    /**
     * 
     * performFindList(传入sql，wheremap执行直连查询)<br/>
     * (仿FindServices.performFindList)<br/>
     * 
     * @param delegator
     * @param querySql
     * @param viewIndex
     * @param viewSize
     * @param parameters
     *            -与FindServices.performFindList 输入条件相同
     * @param context
     * @return
     */
    public static Map<String, Object> performFindList(Delegator delegator, Map<String, ?> context)
    {
	StringBuffer bf = new StringBuffer();
	String querySql = context.get("querySql").toString();
	Map<String, ?> inputFields = (Map<String, ?>) context.get("inputFields");
	List<EntityCondition> condList = createConditionList(inputFields, null, delegator, context);
	for (EntityCondition cond : condList)
	{
	    bf.append(" and " + cond.toString());
	}
	return querySqlPage(delegator, querySql + bf.toString(), context);

    }

    /**
     * 
     * querySql(执行sql-返回查询表头和数据)<br/>
     * (这里描述这个方法适用条件 – 可选)<br/>
     * 
     * @param delegator
     * @param querySql
     * @return
     */
    public static Map<String, Object> querySql(Delegator delegator, String querySql)
    {
	SQLProcessor du = new SQLProcessor(delegator, delegator.getGroupHelperInfo("org.ofbiz"));
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	int numberOfColumns;
	Map<String, Object> resultMap = FastMap.newInstance();
	List<String> columns = FastList.newInstance();// 表头ColumnName
	List<Map<String, Object>> records = FastList.newInstance();// 结果集list-map
	if (querySql.toUpperCase().startsWith("SELECT"))
	{
	    try
	    {
		Debug.log(querySql);
		rs = du.executeQuery(querySql);
		if (rs != null)
		{
		    rsmd = rs.getMetaData();
		    numberOfColumns = rsmd.getColumnCount();
		    for (int i = 1; i <= numberOfColumns; i++)
		    {
			columns.add(ModelUtil.dbNameToVarName(rsmd.getColumnName(i)));// 实体名称
		    }
		    while (rs.next())
		    {
			Map<String, Object> record = FastMap.newInstance();
			for (int i = 1; i <= numberOfColumns; i++)
			{
			    if (i <= columns.size())
			    {
				record.put(columns.get(i - 1).toString(), rs.getObject(i));
			    }
			}
			records.add(record);
		    }
		    rs.close();
		}

	    } catch (Exception exc)
	    {
		Debug.logWarning("查询出错", exc.toString());
		try
		{
		    rs.close();
		} catch (SQLException e)
		{
		    // TODO Auto-generated catch block
		    Debug.logWarning("连接出错", exc.toString());
		}
	    }
	}
	resultMap.put("columns", columns);
	resultMap.put("records", records);
	return resultMap;
    }

    /**
     * Parses input parameters and returns an
     * <code>EntityCondition</code> list.
     * 
     * @param parameters
     * @param fieldList
     * @param queryStringMap
     * @param delegator
     * @param context
     * @return returns an EntityCondition list
     */
    public static List<EntityCondition> createConditionList(Map<String, ? extends Object> parameters, Map<String, ?> queryStringMap, Delegator delegator, Map<String, ?> context)
    {
	String dataSourceType = "org.ofbiz";
	Set<String> processed = FastSet.newInstance();
	Set<String> keys = FastSet.newInstance();
	Map<String, ModelField> fieldMap = FastMap.newInstance();
	List<EntityCondition> result = FastList.newInstance();
	for (Map.Entry<String, ? extends Object> entry : parameters.entrySet())
	{
	    String parameterName = entry.getKey();
	    if (processed.contains(parameterName))
	    {
		continue;
	    }
	    keys.clear();
	    String fieldName = parameterName;
	    Object fieldValue = null;
	    String operation = null;
	    boolean ignoreCase = false;
	    if (parameterName.endsWith("_ic") || parameterName.endsWith("_op"))
	    {
		fieldName = parameterName.substring(0, parameterName.length() - 3);
	    } else if (parameterName.endsWith("_value"))
	    {
		fieldName = parameterName.substring(0, parameterName.length() - 6);
	    }
	    String key = fieldName.concat("_ic");
	    if (parameters.containsKey(key))
	    {
		keys.add(key);
		ignoreCase = "Y".equals(parameters.get(key));
	    }
	    key = fieldName.concat("_op");
	    if (parameters.containsKey(key))
	    {
		keys.add(key);
		operation = (String) parameters.get(key);
	    }
	    key = fieldName.concat("_value");
	    if (parameters.containsKey(key))
	    {
		keys.add(key);
		fieldValue = parameters.get(key);
	    }
	    if (fieldName.endsWith("_fld0") || fieldName.endsWith("_fld1"))
	    {
		if (parameters.containsKey(fieldName))
		{
		    keys.add(fieldName);
		}
		fieldName = fieldName.substring(0, fieldName.length() - 5);
		if (UtilValidate.isNotEmpty(fieldValue))
		{
		    if (dataSourceType.equals("localoracle"))
		    {
			fieldValue = "to_date('" + fieldValue + "','yyyy-mm-dd hh24:mi:ss')";
		    } else if (dataSourceType.equals("localmysql"))
		    {
			// TODO:
		    }
		}

	    }
	    if (parameters.containsKey(fieldName))
	    {
		keys.add(fieldName);
	    }
	    processed.addAll(keys);

	    if (fieldValue == null)
	    {
		fieldValue = parameters.get(fieldName);
	    }
	    if (ObjectType.isEmpty(fieldValue) && !"empty".equals(operation))
	    {
		continue;
	    }
	    result.add(createSingleCondition(fieldName, operation, fieldValue, ignoreCase, delegator, context));
	    /*
	     * for (String mapKey : keys) { //
	     * queryStringMap.put(mapKey, parameters.get(mapKey)); }
	     */
	}
	return result;
    }

    /**
     * Creates a single <code>EntityCondition</code> based on a set of
     * parameters.
     * 
     * @param modelField
     * @param operation
     * @param fieldValue
     * @param ignoreCase
     * @param delegator
     * @param context
     * @return return an EntityCondition
     */
    public static EntityCondition createSingleCondition(String fieldName, String operation, Object fieldValue, boolean ignoreCase, Delegator delegator, Map<String, ?> context)
    {
	EntityCondition cond = null;
	EntityComparisonOperator<?, ?> fieldOp = null;
	fieldName = ModelUtil.javaNameToDbName(fieldName);
	try
	{
	    if (operation != null)
	    {
		if (operation.equals("contains"))
		{
		    fieldOp = EntityOperator.LIKE;
		    fieldValue = "%" + fieldValue + "%";
		} else if ("not-contains".equals(operation) || "notContains".equals(operation))
		{
		    fieldOp = EntityOperator.NOT_LIKE;
		    fieldValue = "%" + fieldValue + "%";
		} else if (operation.equals("empty"))
		{
		    return EntityCondition.makeCondition(fieldName, EntityOperator.EQUALS, null);
		} else if (operation.equals("like"))
		{
		    fieldOp = EntityOperator.LIKE;
		    fieldValue = fieldValue + "%";
		} else if ("not-like".equals(operation) || "notLike".equals(operation))
		{
		    fieldOp = EntityOperator.NOT_LIKE;
		    fieldValue = fieldValue + "%";
		} else if ("opLessThan".equals(operation))
		{
		    fieldOp = EntityOperator.LESS_THAN;
		} else if ("upToDay".equals(operation))
		{
		    fieldOp = EntityOperator.LESS_THAN;
		} else if ("upThruDay".equals(operation))
		{
		    fieldOp = EntityOperator.LESS_THAN_EQUAL_TO;
		} else if (operation.equals("greaterThanFromDayStart"))
		{
		    String timeStampString = (String) fieldValue;
		    Object startValue = ObjectType.simpleTypeConvert(fieldValue, "java.sql.Date", null, (Locale) context.get("locale"), false);
		    return EntityCondition.makeCondition(fieldName, EntityOperator.GREATER_THAN_EQUAL_TO, startValue);

		} else if (operation.equals("sameDay"))
		{
		    /*
		     * String timeStampString = (String) fieldValue;
		     * Object startValue =
		     * modelField.getModelEntity().convertFieldValue
		     * (modelField, dayStart(timeStampString, 0),
		     * delegator, context); EntityCondition startCond
		     * = EntityCondition.makeCondition(fieldName,
		     * EntityOperator.GREATER_THAN_EQUAL_TO,
		     * startValue); Object endValue =
		     * modelField.getModelEntity().convertFieldValue
		     * (modelField, dayStart(timeStampString, 1),
		     * delegator, context); EntityCondition endCond =
		     * EntityCondition.makeCondition(fieldName,
		     * EntityOperator.LESS_THAN, endValue); return
		     * EntityCondition.makeCondition(startCond,
		     * endCond);
		     */
		} else
		{
		    fieldOp = entityOperators.get(operation);
		}
	    } else
	    {
		fieldOp = EntityOperator.EQUALS;
	    }
	    Object fieldObject = fieldValue;

	    if ((fieldOp != EntityOperator.IN && fieldOp != EntityOperator.NOT_IN) || !(fieldValue instanceof Collection<?>))
	    {

		fieldObject = ObjectType.simpleTypeConvert(fieldValue, "String", null, (Locale) context.get("locale"), false);
	    }
	    if (ignoreCase && fieldObject instanceof String)
	    {
		cond = EntityCondition.makeCondition(EntityFunction.UPPER_FIELD(fieldName), fieldOp, EntityFunction.UPPER(((String) fieldValue).toUpperCase()));
	    } else
	    {
		if (fieldObject.equals(GenericEntity.NULL_FIELD.toString()))
		{
		    fieldObject = null;
		}
		if (fieldObject.toString().indexOf("to_date") != -1)
		{
		    cond = EntityCondition.makeConditionWhere(fieldName + fieldOp + fieldObject);
		} else
		{
		    cond = EntityCondition.makeCondition(fieldName, fieldOp, fieldObject);
		}

	    }
	    if (EntityOperator.NOT_EQUAL.equals(fieldOp) && fieldObject != null)
	    {
		cond = EntityCondition.makeCondition(UtilMisc.toList(cond, EntityCondition.makeCondition(fieldName, null)), EntityOperator.OR);
	    }
	} catch (Exception e)
	{
	    Debug.logWarning("构造查询条件出错", e.toString());
	}

	return cond;
    }

    /**
     * 
     * querySqlPage(执行sql-返回查询表头和数据-带分页)<br/>
     * (这里描述这个方法适用条件 – 可选)<br/>
     * 
     * @param delegator
     * @param querySql
     * @return
     */
    public static Map<String, Object> querySqlPage(Delegator delegator, String querySql, Map<String, ?> context)
    {
	String dataSourceType ="org.ofbiz";
		//EntityConfigUtil.getDelegatorInfo(delegator.getDelegatorBaseName()).groupMap.get("org.ofbiz");
	SQLProcessor du = new SQLProcessor(delegator, delegator.getGroupHelperInfo("org.ofbiz"));
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	int numberOfColumns;
	int allCount = 0;
	Map<String, Object> resultMap = FastMap.newInstance();
	List<String> columns = FastList.newInstance();// 表头ColumnName
	List<Map<String, Object>> records = FastList.newInstance();// 结果集list-map
	String countSql = "";
	String thisQuerySql = "";
	boolean isDistinct = false;
	Integer viewSize = (Integer) context.get("viewSize");
	Integer viewIndex = (Integer) context.get("viewIndex");
	if (UtilValidate.isNotEmpty(context.get("distinct")) && context.get("distinct").equals("Y"))
	{
	    isDistinct = true;
	}
	if (querySql.toUpperCase().startsWith("SELECT"))
	{
	    try
	    {
		if (dataSourceType.equals("localoracle"))
		{
		    thisQuerySql = " SELECT * FROM ( SELECT ROWNUM NO,a.* from (select "
			    + querySql.substring(6, querySql.length())
			    + (UtilValidate.isNotEmpty(context.get("orderBy")) ? (" order by  " + (context.get("orderBy").toString().indexOf("-") != -1 ? (ModelUtil
				    .javaNameToDbName(context.get("orderBy").toString()).replace("-", "") + " desc ") : ModelUtil.javaNameToDbName(context.get("orderBy")
				    .toString()))) : "")

			    + (UtilValidate.isNotEmpty(context.get("sort")) ? (" sort  " + context.get("sort")) : "") + "  )a  where ROWNUM<=" + (viewSize * (viewIndex + 1))
			    + ")o   where NO>" + (viewSize * viewIndex) + "";
		    if (isDistinct)
		    {
			thisQuerySql = thisQuerySql.replace("ROWNUM NO,", "ROWNUM NO,o.* FROM ( SELECT  DISTINCT");
			thisQuerySql = thisQuerySql.replace(")a where NO>", ")a) where o.NO>");
		    }
		} else if (dataSourceType.equals("localmysql"))
		{
		    thisQuerySql = querySql + " AND 1=1 limit " + (viewSize * viewIndex) + " , " + (viewSize * (viewIndex + 1));
		} else
		{
		    // TODO 需完善其他数据库分页
		}

		if (isDistinct)
		{
		    countSql = " SELECT COUNT(*)     FROM ( SELECT DISTINCT " + querySql.substring(6, querySql.length()) + ")";
		} else
		{
		    countSql = " SELECT COUNT(*)  " + querySql.substring(querySql.toUpperCase().indexOf(" FROM "), querySql.length());
		}
		System.out.println(thisQuerySql);
		System.out.println(countSql);
		rs = du.executeQuery(thisQuerySql);
		if (rs != null)
		{
		    rsmd = rs.getMetaData();
		    numberOfColumns = rsmd.getColumnCount();
		    for (int i = 1; i <= numberOfColumns; i++)
		    {
			columns.add(ModelUtil.dbNameToVarName(rsmd.getColumnName(i)));// 实体名称
		    }
		    while (rs.next())
		    {
			Map<String, Object> record = FastMap.newInstance();
			for (int i = 1; i <= numberOfColumns; i++)
			{
			    if (i <= columns.size())
			    {
			    	Object o = rs.getObject(i);
			    	record.put(columns.get(i - 1).toString(),o);
			    	if(o!=null && o instanceof Timestamp)
			    	{
			    		Timestamp tt = (Timestamp)o;
			    		Date date = new Date(tt.getTime());
			    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒 ");
			    		record.put(columns.get(i - 1).toString(),sdf.format(date));
			    	}

				if (o != null && o instanceof TIMESTAMP)
				{
				    TIMESTAMP t = (TIMESTAMP) o;
				    Timestamp tt = t.timestampValue();
				    Date date = new Date(tt.getTime());
				    SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒 ");
				    record.put(columns.get(i - 1).toString(), sdf.format(date));
				}
				//record.put(columns.get(i - 1).toString(), rs.getObject(i));
			    }
			}
			records.add(record);
		    }
		    rs.close();
		}
		rs = du.executeQuery(countSql);
		if (rs != null && rs.next())
		{
		    allCount = rs.getInt(1);
		}
		rs.close();
	    } catch (Exception exc)
	    {
		Debug.logWarning("查询出错", exc.toString());
		try
		{
		    if (rs != null)
		    {
			rs.close();
		    }
		} catch (SQLException e)
		{
		    // TODO Auto-generated catch block
		    Debug.logWarning("连接出错", exc.toString());
		}
	    }
	}
	resultMap.put("columns", columns);
	resultMap.put("list", records);
	resultMap.put("listSize", allCount);
	return resultMap;
    }

    private static String dayStart(String timeStampString, int daysLater)
    {
	String retValue = null;
	Timestamp ts = null;
	Timestamp startTs = null;
	try
	{
	    ts = Timestamp.valueOf(timeStampString);
	} catch (IllegalArgumentException e)
	{
	    timeStampString += " 00:00:00.000";
	    try
	    {
		ts = Timestamp.valueOf(timeStampString);
	    } catch (IllegalArgumentException e2)
	    {
		return retValue;
	    }
	}
	startTs = UtilDateTime.getDayStart(ts, daysLater);
	retValue = startTs.toString();
	return retValue;
    }

    public static Map<String, EntityComparisonOperator<?, ?>> entityOperators;

    static
    {
	entityOperators = FastMap.newInstance();
	entityOperators.put("between", EntityOperator.BETWEEN);
	entityOperators.put("equals", EntityOperator.EQUALS);
	entityOperators.put("greaterThan", EntityOperator.GREATER_THAN);
	entityOperators.put("greaterThanEqualTo", EntityOperator.GREATER_THAN_EQUAL_TO);
	entityOperators.put("in", EntityOperator.IN);
	entityOperators.put("not-in", EntityOperator.NOT_IN);
	entityOperators.put("lessThan", EntityOperator.LESS_THAN);
	entityOperators.put("lessThanEqualTo", EntityOperator.LESS_THAN_EQUAL_TO);
	entityOperators.put("like", EntityOperator.LIKE);
	entityOperators.put("notLike", EntityOperator.NOT_LIKE);
	entityOperators.put("not", EntityOperator.NOT);
	entityOperators.put("notEqual", EntityOperator.NOT_EQUAL);
    }

    /**
     * 
     * isCn(是否包含中文)<br/>
     * (这里描述这个方法适用条件 – 可选)<br/>
     * 
     * @param str
     * @return
     */
    public static boolean isIncludeCn(String str)
    {

	boolean isGB2312 = false;
	if (str.length() < str.getBytes().length)
	{
	    isGB2312 = true;
	}
	return isGB2312;
    }
    
    /**
     * 构造OR结构 SQL块,valueArrStr/valueList至少有一个不为空
     * @param key
     * @param valueStr
     * @param valueList
     * @return
     */
    public static String constractORSql(String key,String valueArrStr,List<String> valueList)
    {
    	if(UtilValidate.isNotEmpty(key) && (UtilValidate.isNotEmpty(valueArrStr) || UtilValidate.isNotEmpty(valueList))){
    		List<String> valStrList = FastList.newInstance();
    		if(UtilValidate.isNotEmpty(valueArrStr))
    		{
    			String[] valueSplit_half_array = valueArrStr.split(",");
    			for(String holeStr:valueSplit_half_array)
    			{
    				String[] valueSplit_hole_array = holeStr.split("，");
    				for(String baseStr:valueSplit_hole_array)
    				{
    					valStrList.add(baseStr);
    				}
    			}
    		}
    		
    		if(UtilValidate.isNotEmpty(valueList))
    		{
    			valStrList.addAll(valueList);
    		}
    		
    		String dbName = ModelUtil.javaNameToDbName(key);
    		StringBuilder whereSB = new StringBuilder(" (1=0 ");
    		for(String val:valStrList){
    			whereSB.append("OR "+dbName+" like '%"+val.trim()+"%' ");
    		}
    		whereSB.append(") ");
    		return whereSB.toString();
    	}
    	return "";
    }

    /**
     * 
     * exportExcel(通用导出excel)<br/>
     * 
     * @param request
     * @param response
     * @param resultList
     * @param filedNames
     *            :实体字段名称","隔开
     * @param filedCnNames
     *            ：中文名称","隔开
     * @param fileName
     *            ：下载的文件名称
     * @return
     * @throws IOException
     */
    public static String exportExcel(HttpServletRequest request, HttpServletResponse response, List resultList, String filedNames, String filedCnNames, String fileName)
	    throws IOException
    {
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	Map<String, Object> paramMap = UtilHttp.getParameterMap(request);
	List<String> filedNameList = StringUtil.split(filedNames, ",");
	List<String> filedCnNameList = StringUtil.split(filedCnNames, ",");
	try
	{
	    // 写excel开始
	    HSSFWorkbook wb = new HSSFWorkbook();
	    // 创建sheet
	    HSSFSheet sheet = wb.createSheet();
	    // 样式
	    HSSFCellStyle cellStyle = wb.createCellStyle();
	    // 设定单元格样式 指定单元格居中对齐
	    cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    // 指定单元格自动换行
	    cellStyle.setWrapText(true);
	    // 设置单元格字体
	    HSSFFont font = wb.createFont();
	    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    font.setFontName("宋体");
	    font.setFontHeight((short) 220);
	    cellStyle.setFont(font);
	    HSSFRow row = sheet.createRow(0);
	    // 创建一个单元格
	    HSSFCell cell = null;
	    for (int i = 0; i < filedCnNameList.size(); i++)
	    {
		cell = row.createCell(i);
		cell.setCellValue(filedCnNameList.get(i));
		cell.setCellStyle(cellStyle);
	    }

	    for (int i = 0; i < resultList.size(); i++)
	    {
		Map dataValue = (Map) resultList.get(i);
		row = sheet.createRow(i + 1);// 创建数据行
		row.setHeight((short) 400);// 设置行高
		cell = row.createCell(0);
		cell.setCellValue(i + 1);
		for (int f = 0; f < filedNameList.size(); f++)
		{
		    cell = row.createCell(f);
		    cell.setCellValue(dataValue.get(filedNameList.get(f)) != null ? dataValue.get(filedNameList.get(f)).toString() : "");
		}
	    }
	    OutputStream os = response.getOutputStream();
	    response.setContentType("application/vnd.ms-excel");
	    String contentDisposition = DocumentUtils.getContentDisposition((fileName != null ? fileName : "导出列表") + ".xls", request.getHeader("user-agent"));
	    response.setHeader("Content-Disposition", contentDisposition);
	    wb.write(os);
	    os.flush();
	    os.close();
	    os = null;
	    response.flushBuffer();

	} catch (Exception e)
	{
	    e.printStackTrace();
	    Debug.logError(e, module);
	    return "error";
	}
	return null;
    }

    /**
     * 
     * exportExcel(通用导出excel)<br/>
     * 
     * @param request
     * @param response
     * @param resultList
     * @param filedNames
     *            :实体字段名称","隔开
     * @param filedTypes
     *            :实体字段类型","隔开;1：字符型，2：数字型
     * @param filedCnNames
     *            ：中文名称","隔开
     * @param fileName
     *            ：下载的文件名称
     * @return
     * @throws IOException
     */
    public static String exportExcel(HttpServletRequest request, HttpServletResponse response, List resultList, String filedNames, String filedTypes, String filedCnNames,
	    String fileName) throws IOException
    {
	Delegator delegator = (Delegator) request.getAttribute("delegator");
	Map<String, Object> paramMap = UtilHttp.getParameterMap(request);
	List<String> filedNameList = StringUtil.split(filedNames, ",");
	boolean hasType = false;
	List<String> filedTypeList = null;
	if (filedTypes != null)
	{
	    hasType = true;
	    filedTypeList = StringUtil.split(filedTypes, ",");
	}
	List<String> filedCnNameList = StringUtil.split(filedCnNames, ",");
	try
	{
	    // 写excel开始
	    HSSFWorkbook wb = new HSSFWorkbook();
	    // 创建sheet
	    HSSFSheet sheet = wb.createSheet();
	    // 样式
	    HSSFCellStyle cellStyle = wb.createCellStyle();
	    // 设定单元格样式 指定单元格居中对齐
	    cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

	    HSSFCellStyle numberCellStyle = wb.createCellStyle();
	    // numberCellStyle.setDataFormat(Short.parseShort("2"));
	    numberCellStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	    // 指定单元格自动换行
	    // cellStyle.setWrapText(true);
	    // 设置单元格字体
	    HSSFFont font = wb.createFont();
	    font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	    font.setFontName("宋体");
	    font.setFontHeight((short) 220);
	    cellStyle.setFont(font);
	    HSSFRow row = sheet.createRow(0);
	    // 创建一个单元格
	    HSSFCell cell = null;
	    for (int i = 0; i < filedCnNameList.size(); i++)
	    {
		cell = row.createCell(i);
		cell.setCellValue(filedCnNameList.get(i));
		cell.setCellStyle(cellStyle);
	    }

	    for (int i = 0; i < resultList.size(); i++)
	    {
		Map dataValue = (Map) resultList.get(i);
		row = sheet.createRow(i + 1);// 创建数据行
		row.setHeight((short) 400);// 设置行高
		cell = row.createCell(0);
		cell.setCellValue(i + 1);
		for (int f = 0; f < filedNameList.size(); f++)
		{
		    cell = row.createCell(f);
		    Object o = dataValue.get(filedNameList.get(f));
		    // 按照类型写
		    if (hasType && filedTypeList != null)
		    {
			String fieldType = filedTypeList.get(f);
			if (fieldType != null)
			{
			    if (fieldType.equals("1"))
			    {
				cell.setCellType(HSSFCell.CELL_TYPE_STRING);
				cell.setCellValue(o != null ? o.toString() : "");
			    }
			    if (fieldType.equals("2"))
			    {
				cell.setCellStyle(numberCellStyle);
				cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
				float value = 0f;
				try
				{
				    value = Float.parseFloat(o.toString());
				    cell.setCellValue(value);
				} catch (Exception e)
				{
				    cell.setCellValue(o != null ? o.toString() : "");
				}
			    }
			}
		    } else
		    {
			cell.setCellValue(o != null ? o.toString() : "");
		    }

		}
	    }
	    OutputStream os = response.getOutputStream();
	    response.setContentType("application/vnd.ms-excel");
	    String contentDisposition = DocumentUtils.getContentDisposition((fileName != null ? fileName : "导出列表") + ".xls", request.getHeader("user-agent"));
	    response.setHeader("Content-Disposition", contentDisposition);
	    wb.write(os);
	    os.flush();
	    os.close();
	    os = null;
	    response.flushBuffer();

	} catch (Exception e)
	{
	    e.printStackTrace();
	    Debug.logError(e, module);
	    return "error";
	}
	return "success";
    }

    /**
     * 
     * exportExcel(通用导出excel)<br/>
     * 
     * @param request
     * 
     * @param filedNames
     *            :实体字段名称List
     * @return list类型map-<字段名称：值>
     * @throws IOException
     */
    public static List<Map> importExcel(HttpServletRequest request, List filedNames)
	    throws IOException
    {
	List<Map> resultList = FastList.newInstance();
	try
	{
	    FileItemFactory factory = new DiskFileItemFactory();
	    ServletFileUpload upload = new ServletFileUpload(factory);
	    List<FileItem> lst = upload.parseRequest(request);
	    FileItem fi = null;
	    for (int i = 0; i < lst.size(); i++)
	    {

		fi = lst.get(i);
		if (!fi.isFormField())
		{
		    InputStream inputStream = new BufferedInputStream(fi.getInputStream());
		    Workbook workbook = Workbook.getWorkbook(inputStream);
		    Sheet sheet1 = workbook.getSheet(0);
		    int r = 1;
		    while (r < sheet1.getRows())
		    {
		    	if(UtilValidate.isNotEmpty(sheet1.getCell(0, r).getContents())){
		    		Map map = FastMap.newInstance();
		    		for (int f = 0; f < filedNames.size(); f++)
		    		{
		    			map.put(filedNames.get(f), sheet1.getCell(f, r).getContents());
		    		}
		    		resultList.add(map);
		    	}
		    	r++;
		    }
		}
	    }

	} catch (Exception e)
	{
	    e.printStackTrace();
	    Debug.logError(e, module);
	}
	return resultList;
    }
    /**
     * 批量终结实体
     * 
     * @param dctx
     * @param context
     * @return
     * @throws GenericEntityException
     */
    public static Map<String, Object> commonThruEntity(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Delegator delegator = dctx.getDelegator();
	Map result = ServiceUtil.returnSuccess();
	String ids = (String) context.get("ids");
	String entityId = (String) context.get("entityId");
	List<String> idList = StringUtil.split(ids, ",");
	for (String id : idList)
	{
	    GenericValue gv = delegator.findByPrimaryKey(context.get("entityName").toString(), UtilMisc.toMap(entityId, id));
	    gv.set("thruDate", UtilDateTime.nowTimestamp());
	    if (UtilValidate.isNotEmpty(gv))
	    {
		gv.store();
	    }
	}

	// MessageUtil.returnTitleMessage(result, true, "delete");
	return result;
    }

    /*
     * 追加文本到文件指定位置
     */
    public static boolean appendFileText(String filePath, String splitName, String content) throws IOException
    {
	try
	{
	    File f = new File(filePath);
	    FileInputStream fs = null;
	    InputStreamReader inReader = null;
	    BufferedReader br = null;
	    StringBuffer sb = new StringBuffer();
	    String textinLine;
	    fs = new FileInputStream(f);
	    inReader = new InputStreamReader(fs);
	    br = new BufferedReader(inReader);

	    while (true)
	    {
		textinLine = br.readLine();
		if (textinLine == null)
		    break;
		sb.append(textinLine + "\r\n");
	    }
	    String textToEdit1 = splitName;
	    int cnt1 = sb.lastIndexOf(textToEdit1);
	    sb.replace(cnt1, cnt1 + textToEdit1.length(), textToEdit1 + "\r\n" + content);

	    fs.close();
	    inReader.close();
	    br.close();

	    FileWriter fstream = new FileWriter(f);
	    BufferedWriter outobj = new BufferedWriter(fstream);
	    outobj.write(sb.toString());
	    outobj.close();
	} catch (Exception e)
	{
	    System.err.println("Error: " + e.getMessage());
	    return false;
	}
	return true;
    }

    /*
     * 替换文本到文件特殊表示
     */
    public static boolean replaceFileText(String filePath, Map<Object, Object> replaceMap) throws IOException
    {
	try
	{
	    File f = new File(filePath);
	    FileInputStream fs = null;
	    InputStreamReader inReader = null;
	    BufferedReader br = null;
	    StringBuffer sb = new StringBuffer();
	    String textinLine;
	    fs = new FileInputStream(f);
	    inReader = new InputStreamReader(fs);
	    br = new BufferedReader(inReader);

	    while (true)
	    {
		textinLine = br.readLine();
		if (textinLine == null)
		    break;
		sb.append(textinLine + "\r\n");
	    }
	    String contentStr=sb.toString();
	    for (Map.Entry mapEntry : replaceMap.entrySet())
	    {
		contentStr = contentStr.replace(mapEntry.getKey().toString(), mapEntry.getValue().toString());
	    }
	    fs.close();
	    inReader.close();
	    br.close();

	    FileWriter fstream = new FileWriter(f);
	    BufferedWriter outobj = new BufferedWriter(fstream);
	    outobj.write(contentStr);
	    outobj.close();
	} catch (Exception e)
	{
	    System.err.println("Error: " + e.getMessage());
	    return false;
	}
	return true;
    }

    /*
     * 判断全选
     */
    public static boolean hasPermission(String permission,Security security, GenericValue userLogin) throws IOException
    {
	boolean hasPermission=false;
	try
	{
	    if(permission.indexOf("_")!=-1){
		hasPermission=security.hasEntityPermission(permission.split("_")[0], "_" + permission.split("_")[1], userLogin);
	    }else{
		hasPermission = security.hasPermission(permission, userLogin);
	    }
	} catch (Exception e)
	{
	    System.err.println("Error: " + e.getMessage());
	    return false;
	}
	return hasPermission;
    }
	/*
	 * 转化字符串参数值为对应数据库类型
	 */
    public static Object transferStringToOtherType(String fieldValue,int sqlJdbcUtil_type){
    	switch (sqlJdbcUtil_type) {
	    	case 1:
	        	return fieldValue;//String
	        case 2:
	        	return DateTimeUtils.toTimestamp(fieldValue);//java.sql.Timestamp
	        case 3:
	        	Date a = DateTimeUtils.toDate(fieldValue);
	    		return new java.sql.Time(a.getTime());//java.sql.Time
	        case 4:
	        	return DateTimeUtils.toSqlDate(fieldValue,null);//java.sql.Date
	        case 5:
	            return Integer.parseInt(fieldValue);//java.lang.Integer
	        case 6:
	            return Long.parseLong(fieldValue);//java.lang.Long
	        case 7:
	            return Float.parseFloat(fieldValue);//java.lang.Float
	        case 8:
	            return Double.parseDouble(fieldValue);//java.lang.Double
	        case 9:
	            return new BigDecimal(fieldValue);//java.math.BigDecimal
	        case 10:
	            return Boolean.parseBoolean(fieldValue);//java.lang.Boolean
	        case 11:
	            return null;//BinaryStream??
	        case 12:
	        	return null;//Blob
	        case 13:
	            return null;//Clob
	        case 14:
	            return UtilDateTime.toDate(fieldValue);//java.util.Date
	        case 15:
	            return null;//List
    	}
    	return null;
    }
    /*
     * 转化字符串参数值为数据库类型
     */
    public static Object transferStringToOtherSimpleType(String fieldValue,String type){
    	if(type.equals("blob")||type.equals("byte-array")||type.equals("object")){
    		//无法解析
    		return null;
    	}else if(type.equals("date-time")){
    		//Date a = DateTimeUtils.toDate(fieldValue);
    		return DateTimeUtils.toTimestamp(fieldValue);//java.sql.Timestamp
    	}else if(type.equals("date")){
    		return DateTimeUtils.toSqlDate(fieldValue,null);
    	}else if(type.equals("time")){
    		Date a = DateTimeUtils.toDate(fieldValue);
    		return new java.sql.Time(a.getTime());
    	}else if(type.equals("currency-amount")||type.equals("currency-precise")||type.equals("fixed-point")){
    		return new BigDecimal(fieldValue);
    	}else if(type.equals("floating-point")){
    		return Double.parseDouble(fieldValue);
    	}else if(type.equals("numeric")){
    		return Long.parseLong(fieldValue);
    	}else{
    		return fieldValue;
    	}
    }
    
    public static List reloadOrder(List outputList,final String order) {
		 //根据Collections.sort重载方法来实现  
		 if(UtilValidate.isEmpty(outputList)){
			 return outputList;
		 }
			 try { 
				 Collections.sort(outputList,new Comparator<Map<String,BigDecimal>>(){  
					 public int compare(Map<String,BigDecimal> b1, Map<String,BigDecimal> b2) {  
						 return b2.get(order).compareTo(b1.get(order));  
					 }  
				 });
			 } catch (Exception e) {
				 try {
					
					 Collections.sort(outputList,new Comparator<Map<String,Timestamp>>(){  
						 public int compare(Map<String,Timestamp> b1, Map<String,Timestamp> b2) {  
							 return b2.get(order).compareTo(b1.get(order));  
						 }  
					 });
				} catch (Exception e2) {
					Collections.sort(outputList,new Comparator<Map<String,String>>(){  
						 public int compare(Map<String,String> b1, Map<String,String> b2) {  
							 return b2.get(order).compareTo(b1.get(order));  
						 }  
					 });
				}
			 }
		 return outputList;
	}
}
