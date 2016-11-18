package org.ofbiz.ebiz.product;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import javolution.util.FastList;
import javolution.util.FastMap;
import net.sf.json.JSONObject;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericValue;

public class JsonUtil
{
    private static Map<Class<? extends Object>, SimpleDateFormat> config = FastMap.newInstance();
    private static Map<Class<? extends Object>, SimpleDateFormat> configMark = FastMap.newInstance();// 全符号分割
    private static Map<Class<? extends Object>, SimpleDateFormat> configChinese = FastMap.newInstance();// 全中文分割
    static
    {
        config.put(Date.class, new SimpleDateFormat("yyyy-MM-dd"));
        config.put(Time.class, new SimpleDateFormat("HH时mm分ss秒"));
        config.put(Timestamp.class, new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒"));

        configMark.put(Date.class, new SimpleDateFormat("yyyy-MM-dd"));
        configMark.put(Time.class, new SimpleDateFormat("HH:mm:ss"));
        configMark.put(Timestamp.class, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));

        configChinese.put(Date.class, new SimpleDateFormat("yyyy年MM月dd日"));
        configChinese.put(Time.class, new SimpleDateFormat("HH时mm分ss秒"));
        configChinese.put(Timestamp.class, new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒"));
    }

    /**
     * Map转换json字符串，并response输出
     * 
     * @author wangyg
     * @param attrList
     * @param response
     */
    public static void toJsonObject(Map attrMap, HttpServletResponse response)
    {
        JSONObject json = JSONObject.fromObject(attrMap);
        String jsonStr = json.toString();
        if (jsonStr == null)
        {
            // Debug.logError("JSON Object was empty; fatal error!",
            // module);
        }
        // set the X-JSON content type
        response.setContentType("text/html");
        // jsonStr.length is not reliable for unicode characters
        try
        {
            response.setContentLength(jsonStr.getBytes("UTF8").length);
        } catch (UnsupportedEncodingException e)
        {
            // Debug.logError("Problems with Json encoding");
        }
        // return the JSON String
        Writer out;
        try
        {
            out = response.getWriter();
            out.write(jsonStr);
            out.flush();
        } catch (IOException e)
        {
            // Debug.logError("Unable to get response writer",
            // module);
        }
    }

    /**
     * list转换json字符串，并response输出
     * 
     * @author wangyg
     * @param attrList
     * @param response
     */
    public static void toJsonObjectList(List attrList, HttpServletResponse response)
    {
        String jsonStr = "[";
        for (Object attrMap : attrList)
        {
            JSONObject json = JSONObject.fromObject(attrMap);
            jsonStr = jsonStr + json.toString() + ',';
        }
        jsonStr = ((jsonStr.length() > 1) ? jsonStr.substring(0, jsonStr.length() - 1) : jsonStr) + "]";
        if (UtilValidate.isEmpty(jsonStr))
        {
            Debug.logError("JSON Object was empty; fatal error!", "json");
        }
        // set the X-JSON content type
        response.setContentType("application/json");
        // jsonStr.length is not reliable for unicode characters
        try
        {
            response.setContentLength(jsonStr.getBytes("UTF8").length);
        } catch (UnsupportedEncodingException e)
        {
            Debug.logError("Problems with Json encoding", "json");
        }
        // return the JSON String
        Writer out;
        try
        {
            out = response.getWriter();
            out.write(jsonStr);
            out.flush();
        } catch (IOException e)
        {
            Debug.logError("Unable to get response writer", "json");
        }
    }

    /**
     * list转换json字符串
     * 
     * @author yangkun
     * @param attrList
     */
    public static String toJsonObjectList(List attrList)
    {
        String jsonStr = "[";
        for (Object attrMap : attrList)
        {
            JSONObject json = JSONObject.fromObject(attrMap);
            jsonStr = jsonStr + json.toString() + ',';
        }
        jsonStr = ((jsonStr.length() > 1) ? jsonStr.substring(0, jsonStr.length() - 1) : jsonStr) + "]";
        return jsonStr;
    }

    /**
     * 
     * convertJsonDate(Map中日期类型转换为string)<br/>
     * 
     * @param inMap
     */
    public static void convertJsonDate(Map<Object, Object> inMap)
    {
        try
        {
            for (Map.Entry mapEntry : inMap.entrySet())
            {
                Object entryValue = mapEntry.getValue();
                if (entryValue != null)
                {
                    Class classType = entryValue.getClass();
                    if (classType.getName().equals("java.sql.Date") || classType.getName().equals("java.sql.Timestamp"))
                    {
                        if (entryValue != null)
                        {
                            try
                            {
                                inMap.put(mapEntry.getKey(), DateFormat.getDateInstance(DateFormat.LONG).format((java.util.Date) mapEntry.getValue()));
                            } catch (Exception e)
                            {
                                // Debug.logWarning("转换日期", null);
                            }
                        }
                    }
                }

            }
        } catch (Exception e)
        {
            Debug.logWarning("类型转换", null);
        }
    }

    /**
     * jsonFromGenericValueList 将GenericValue的List转换为HashMap的List<br/>
     * 将GenericValue中类型为时间的字段格式化为字符串以后,整体转为HashMap以便json化<br/>
     * 然后将这些对象放在新的List中返回.<br/>
     * 
     * @param list
     *            GenericValue List
     * @return 处理过的List
     */
    public static List<Map<String, Object>> jsonFromGenericValueList(List<GenericValue> list)
    {
        List<Map<String, Object>> resultList = FastList.newInstance();
        if (list != null && list.size() > 0)
        {
            Iterator<GenericValue> it = list.iterator();
            while (it.hasNext())
            {
                GenericValue gv = it.next();
                resultList.add(jsonFromGenericValue(gv));
            }
        }
        return resultList;
    }

    /**
     * jsonFromGenericValueList 将GenericValue的List转换为HashMap的List<br/>
     * 将GenericValue中类型为时间的字段格式化为字符串以后,整体转为HashMap以便json化<br/>
     * 然后将这些对象放在新的List中返回.<br/>
     * 
     * @param list
     *            GenericValue List
     * @return 处理过的List
     */
    public static List<Map<String, Object>> jsonFromGenericValueList(List<GenericValue> list, Map<Class<? extends Object>, SimpleDateFormat> config)
    {
        List<Map<String, Object>> resultList = FastList.newInstance();
        if (list != null && list.size() > 0)
        {
            Iterator<GenericValue> it = list.iterator();
            while (it.hasNext())
            {
                GenericValue gv = it.next();
                resultList.add(jsonFromGenericValue(gv, config));
            }
        }
        return resultList;
    }

    /**
     * jsonFromValueList 将Value的List转换为HashMap的List<br/>
     * 将Value中类型为时间的字段格式化为字符串以后,整体转为HashMap以便json化<br/>
     * 然后将这些对象放在新的List中返回.<br/>
     * 
     * @param list
     * @return 处理过的List
     */
    public static List jsonFromValueList(List list)
    {
        List resultList = FastList.newInstance();
        if (list != null && list.size() > 0)
        {
            Iterator it = list.iterator();
            while (it.hasNext())
            {
                Map<String, Object> obj = (Map<String, Object>) it.next();
                resultList.add(jsonFromMap(obj));
            }
        }
        return resultList;
    }

    /**
     * jsonFromValueList 将Value的List转换为HashMap的List<br/>
     * 将Value中类型为时间的字段格式化为字符串以后,整体转为HashMap以便json化<br/>
     * 然后将这些对象放在新的List中返回.<br/>
     * 
     * @param list
     * @return 处理过的List
     */
    public static List jsonFromValueList(List list, Map<Class<? extends Object>, SimpleDateFormat> config)
    {
        List resultList = FastList.newInstance();
        if (list != null && list.size() > 0)
        {
            Iterator it = list.iterator();
            while (it.hasNext())
            {
                Map<String, Object> obj = (Map<String, Object>) it.next();
                resultList.add(jsonFromMap(obj, config));
            }
        }
        return resultList;
    }

    /**
     * jsonFromGenericValue 将GenericValue转换为HashMap<br/>
     * 将GenericValue中类型为时间的字段格式化为字符串以后,整体转为HashMap以便json化<br/>
     * 
     * @param gv
     *            需要处理的GenericValue对象
     * @return 生成的Map
     */
    public static Map<String, Object> jsonFromGenericValue(GenericValue gv)
    {
        Map<String, Object> resultMap = FastMap.newInstance();

        if (gv != null)
        {
            for (Map.Entry<String, Object> mapEntry : gv.entrySet())
            {
                String feildName = mapEntry.getKey();
                Object entryValue = mapEntry.getValue();
                if (entryValue != null)
                {
                    Object value = formatObject(entryValue, config);
                    resultMap.put(feildName, value);
                }
            }
        }
        return resultMap;
    }

    /**
     * jsonFromGenericValue 将GenericValue转换为HashMap<br/>
     * 将GenericValue中类型为时间的字段格式化为字符串以后,整体转为HashMap以便json化<br/>
     * 
     * @param gv
     *            需要处理的GenericValue对象
     * @return 生成的Map
     */
    public static Map<String, Object> jsonFromGenericValue(GenericValue gv, Map<Class<? extends Object>, SimpleDateFormat> config)
    {
        Map<String, Object> resultMap = FastMap.newInstance();

        if (gv != null)
        {
            for (Map.Entry<String, Object> mapEntry : gv.entrySet())
            {
                String feildName = mapEntry.getKey();
                Object entryValue = mapEntry.getValue();
                if (entryValue != null)
                {
                    Object value = formatObject(entryValue, config);
                    resultMap.put(feildName, value);
                }
            }
        }
        return resultMap;
    }

    /**
     * jsonFromMap HashMap<br/>
     * 
     * @param gv
     *            需要处理的Map对象
     * @return 生成的Map
     */
    public static Map<String, Object> jsonFromMap(Map<String, Object> map)
    {
        Map<String, Object> resultMap = FastMap.newInstance();

        if (map != null)
        {
            for (Map.Entry<String, Object> mapEntry : map.entrySet())
            {
                String feildName = mapEntry.getKey();
                Object entryValue = mapEntry.getValue();
                if (entryValue != null)
                {
                    Object value = formatObject(entryValue, config);
                    resultMap.put(feildName, value);
                }
            }
        }
        return resultMap;
    }

    /**
     * jsonFromMap HashMap<br/>
     * 
     * @param gv
     *            需要处理的Map对象
     * @return 生成的Map
     */
    public static Map<String, Object> jsonFromMap(Map<String, Object> map, Map<Class<? extends Object>, SimpleDateFormat> config)
    {
        Map<String, Object> resultMap = FastMap.newInstance();

        if (map != null)
        {
            for (Map.Entry<String, Object> mapEntry : map.entrySet())
            {
                String feildName = mapEntry.getKey();
                Object entryValue = mapEntry.getValue();
                if (entryValue != null)
                {
                    Object value = formatObject(entryValue, config);
                    resultMap.put(feildName, value);
                }
            }
        }
        return resultMap;
    }

    /**
     * formatObject 对象转换<br/>
     * 将日期时间类型的直接转换为格式化字符串<br/>
     * 其它类型不变直接返回<br/>
     * 
     * @param object
     *            要转换的对象
     * @param config
     *            日期时间的转换配置
     * @return 返回转换后的新对象
     */
    public static Object formatObject(Object object, Map<Class<? extends Object>, SimpleDateFormat> config)
    {
        Class<? extends Object> clazz = object.getClass();
        if (config.containsKey(clazz))
        {
            return (config.get(clazz)).format(object);
        }
        return object;
    }

}
