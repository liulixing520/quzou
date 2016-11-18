package org.extErp.sysCommon.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilValidate;

/**
 * @Desc 日期时间工具
 * @Author YangKun
 * @DateTime 2012-3-20 下午02:16:42
 */
public class DateTimeUtils
{
    private static final String module = DateTimeUtils.class.getName();
    private static final DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    
    /**
     * 日期字符串转为日期格式
     * 
     * @param date
     *            The date String: YYYY-MM-DD
     * @return
     */
    public static java.util.Date toDate(String date)
    {
	if (!date.contains("/") && date != null && !date.equals(""))
	{
	    String year = date.split("-")[0];
	    String month = date.split("-")[1];
	    String day = date.split("-")[2];
	    return UtilDateTime.toSqlDate(month + "/" + day + "/" + year);
	}
	return UtilDateTime.toSqlDate(date);
    }

    /**
     * 字串转为日期
     * 
     * @param date
     * @param format
     * @return
     */
    public static java.sql.Date toSqlDate(String date, String format)
    {
	if (UtilValidate.isEmpty(format))
	{
	    format = "yyyy-MM-dd";
	}
	DateFormat dateFormat = new SimpleDateFormat(format);
	java.util.Date newDate = null;
	try
	{
	    newDate = dateFormat.parse(date);
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	if (newDate != null)
	{
	    return new java.sql.Date(newDate.getTime());
	} else
	{
	    return null;
	}
    }

    /**
     * 指定年、月、日，默认为当前的年月日,日为月最后一天
     * 
     * @param month
     * @param day
     * @param year
     * @return
     */
    public static java.util.Date toDate(String month, String day, String year)
    {
	if (month.equals(""))
	{
	    month = (Calendar.getInstance().get(Calendar.MONTH) + 1) + "";
	}
	if (day.equals(""))
	{
	    day = getMaxDayByMonth(month) + "";
	}
	if (year.equals(""))
	{
	    year = Calendar.getInstance().get(Calendar.YEAR) + "";
	}
	return UtilDateTime.toSqlDate(month + "/" + day + "/" + year);
    }

    /**
     * 根据格式输出当前时间
     * 
     * @param formart
     * @return
     */
    public static String nowDate(String formart)
    {
	return new SimpleDateFormat(formart).format(new Date());
    }

    /**
     * 指定输出的日期和日期格式
     * 
     * @param formart
     * @param date
     * @return
     */
    public static String nowDate(String formart, Date date)
    {
	if (formart.equals("") && date != null)
	{
	    return new SimpleDateFormat("yyyy-MM-dd").format(date);
	} else if (!formart.equals("") && date == null)
	{
	    return new SimpleDateFormat(formart).format(new Date());
	} else
	{
	    return new SimpleDateFormat(formart).format(date);
	}
    }

    /**
     * 指定输出的日期和日期格式
     * 
     * @param formart
     * @param date
     * @return
     */
    public static String nowDate(String formart, String dateStr)
    {
	return nowDate(formart, toDate(dateStr));
    }

    /**
     * 输出当前日期yyyy-MM-dd 不推荐使用，已更名为nowDateToString()
     * 
     * @return String
     */
    @Deprecated
    public static String nowDate()
    {
	return new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    }

    /**
     * 输出当前日期yyyy-MM-dd
     * 
     * @return String
     */
    public static String nowDateToString()
    {
	return new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    }

    /**
     * 输出当前日期yyyy-MM-dd
     * 
     * @return Date
     */
    public static Date nowDateToDate()
    {
	return UtilDateTime.toSqlDate(UtilDateTime.toDateString(UtilDateTime.nowDate()));
    }

    /**
     * 获取当前是几点
     * 
     * @return
     */
    public static int getHourFromNowDate()
    {
	return Integer.parseInt(nowDate("HH:mm:ss").split(":")[0]);
    }

    /**
     * 判断当前是上午,是还回true
     * 
     * @return
     */
    public static boolean isNowAM()
    {
	if (getHourFromNowDate() < 12)
	{
	    return true;
	}
	return false;
    }

    /**
     * 根据当前的时间获取路径 格式：yyyy/m/dd 如2012/2/16
     * 
     * @return
     */
    public static String getLastYMDPath()
    {
	String lastPath = Calendar.getInstance().get(Calendar.YEAR) + "/" + (Calendar.getInstance().get(Calendar.MONTH) + 1) + "/" + Calendar.getInstance().get(Calendar.DATE);
	return lastPath;
    }

    /**
     * 重新定义日期
     * 
     * <pre>
     * 用法:
     * 1.当前日期renewDefDate(0,0,0)
     * 2.去年今天renewDefDate(-1,-1,-1)
     * 3.明年今天renewDefDate(1,1,1)
     * 正数表示将来时；负数表示过去时
     * 可指定具体延后、提前日期的年、月、日
     * 以当时间为准，提前一周:renewDefDate(0,0,-7)
     * 以当时间为准，延后一周:renewDefDate(0,0,7)
     * 类似的以此类推
     * </pre>
     * 
     * @param yearUpOrDown
     * @param monthUpOrDown
     * @param dateUpOrDown
     * @return
     */
    public static String renewDefDate(Integer yearUpOrDown, Integer monthUpOrDown, Integer dateUpOrDown)
    {
	Calendar calendar = Calendar.getInstance();
	if (UtilValidate.isNotEmpty(yearUpOrDown))
	{
	    calendar.add(Calendar.YEAR, yearUpOrDown);
	}
	if (UtilValidate.isNotEmpty(monthUpOrDown))
	{
	    calendar.add(Calendar.MONTH, monthUpOrDown);
	}
	if (UtilValidate.isNotEmpty(dateUpOrDown))
	{
	    calendar.add(Calendar.DATE, dateUpOrDown);
	}
	return dateFormat.format(calendar.getTime());
    }

    /**
     * 获取月的最大天数
     * 
     * @return
     */
    public static int getMaxDayByMonth(String month)
    {
	switch (Integer.parseInt(month))
	{
	case 1:
	case 3:
	case 5:
	case 7:
	case 8:
	case 10:
	case 12:
	    return 31;
	case 4:
	case 6:
	case 9:
	case 11:
	    return 30;
	case 2:
	    return 29;
	default:
	    return 30;
	}
    }

    /**
     * 根据指定的提醒日期参数返回提醒日期
     * 
     * @param yearUpOrDown
     * @param monthUpOrDown
     * @param dateUpOrDown
     * @return
     */
    public static Date currRemindDate(Integer yearUpOrDown, Integer monthUpOrDown, Integer dateUpOrDown)
    {
	return toDate(renewDefDate(yearUpOrDown, monthUpOrDown, dateUpOrDown));
    }

    public static Date currRemindDate(Integer yearUpOrDown, Integer monthUpOrDown, String dateUpOrDown)
    {
	return toDate(renewDefDate(yearUpOrDown, monthUpOrDown, Integer.parseInt(dateUpOrDown)));
    }

    /**
     * 根据指定的周期日期参数返回提醒日期
     * 
     * @param checkCycleDate
     * @param timeUnitType
     *            输入单位 年：year 月：month 天：day
     * @return
     */
    public static Date currRemindDate(String checkCycleDate, String timeUnitType)
    {
	int checkCycleDate_int = Integer.parseInt(checkCycleDate);
	int yearUpOrDown = 0;
	int monthUpOrDown = 0;
	int dateUpOrDown = 0;
	if ("year".equals(timeUnitType))
	{
	    yearUpOrDown = checkCycleDate_int;
	} else if ("month".equals(timeUnitType))
	{
	    monthUpOrDown = checkCycleDate_int;
	} else if ("day".equals(timeUnitType))
	{
	    dateUpOrDown = checkCycleDate_int;
	}
	return toDate(renewDefDate(yearUpOrDown, monthUpOrDown, dateUpOrDown));
    }

    /**
     * 将 yyyy-MM-dd日期格式转化为 年月日字符串格式
     * 
     * @param dateTemp
     * @return
     */
    public static String dateToFormatString(Date dateTemp)
    {
	String stringTemp = "";
	if (UtilValidate.isNotEmpty(dateTemp))
	{
	    if (dateTemp.toString().contains("-"))
	    {
		String[] stringArr = dateTemp.toString().split("-");
		stringTemp = stringArr[0] + "年" + stringArr[1] + "月" + stringArr[2] + "日";
	    }
	}
	return stringTemp;
    }

    /**
     * 日期向前或向后 N年N月N日
     * 
     * @param tempDate
     * @param upYear
     * @param downYear
     * @param upMonth
     * @param downMonth
     * @param upDay
     * @param downDay
     * @return Date
     */
    public static Date upOrDownDate(Date tempDate, int upYear, int downYear, int upMonth, int downMonth, int upDay, int downDay)
    {
	Date myDate = null;
	if (UtilValidate.isNotEmpty(tempDate))
	{
	    if (tempDate.toString().contains("-"))
	    {
		String[] stringArr = tempDate.toString().split("-");
		if (UtilValidate.isNotEmpty(upYear))
		{
		    stringArr[0] = Integer.toString((Integer.valueOf(stringArr[0]) - upYear));
		}
		if (UtilValidate.isNotEmpty(downYear))
		{
		    stringArr[0] = Integer.toString((Integer.valueOf(stringArr[0]) + downYear));
		}
		if (UtilValidate.isNotEmpty(upMonth))
		{
		    stringArr[1] = Integer.toString((Integer.valueOf(stringArr[1]) - upMonth));
		}
		if (UtilValidate.isNotEmpty(downMonth))
		{
		    stringArr[1] = Integer.toString((Integer.valueOf(stringArr[1]) + downMonth));
		}
		if (UtilValidate.isNotEmpty(upDay))
		{
		    stringArr[2] = Integer.toString((Integer.valueOf(stringArr[2]) - upDay));
		}
		if (UtilValidate.isNotEmpty(downDay))
		{
		    stringArr[2] = Integer.toString((Integer.valueOf(stringArr[2]) + downDay));
		}
		String stringTemp = stringArr[0] + "-" + stringArr[1] + "-" + stringArr[2];
		myDate = toDate(stringTemp);
	    }
	}
	return myDate;
    }

    /**
     * date字符串转timestamp
     * 
     * @param date
     * @return
     */
    public static Timestamp toTimestamp(String date)
    {
	return toTimestamp(date, "23:59:59");
    }
    /**
     * 当前时间
     * 
     * @param date
     * @return
     */
    public static Timestamp toTimestamp()
    {
    	Timestamp  timestamp = new Timestamp(new Date().getTime());
    	return timestamp;
    }

    /**
     * date字符串转timestamp,time默认为23:59:59
     * 
     * @param date
     * @param time
     * @return
     */
    public static Timestamp toTimestamp(String date, String time)
    {
	if (date.equals(""))
	{
	    date = nowDateToString();
	}
	if (time.equals(""))
	{
	    time = "23:59:59";
	}
	return UtilDateTime.toTimestamp(date.split("-")[1] + "/" + date.split("-")[2] + "/" + date.split("-")[0], time);
    }

    /**
     * 本年度本月第一天
     * 
     * @return
     */
    public static String getFirstDay()
    {
	String month = (Calendar.getInstance().get(Calendar.MONTH) + 1) < 10 ? "0" + (Calendar.getInstance().get(Calendar.MONTH) + 1)
		: (Calendar.getInstance().get(Calendar.MONTH) + 1) + "";
	return Calendar.getInstance().get(Calendar.YEAR) + "-" + month + "-" + "0" + Calendar.getInstance().getActualMinimum(Calendar.DATE);
    }

    /**
     * 本年度本月最后一天
     * 
     * @return
     */
    public static String getLastDay()
    {
	String month = (Calendar.getInstance().get(Calendar.MONTH) + 1) < 10 ? "0" + (Calendar.getInstance().get(Calendar.MONTH) + 1)
		: (Calendar.getInstance().get(Calendar.MONTH) + 1) + "";
	return Calendar.getInstance().get(Calendar.YEAR) + "-" + month + "-" + Calendar.getInstance().getActualMaximum(Calendar.DATE);
    }
    /**
	 * 根据当前的时间加或减(-)年、月、日
	 * @param currentDateStr 当前的时间
	 * @param yearNum 年数
	 * @param monthNum 月数
	 * @param dayNum 日数
	 * @return
	 */
	public static String assignNewDate(String currentDateStr,int yearNum,int monthNum,int dayNum){
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date dt = sdf.parse(currentDateStr);
			Calendar rightNow = Calendar.getInstance();
			rightNow.setTime(dt);
			if(yearNum!=0){
				rightNow.add(Calendar.YEAR,yearNum);//日期加或减yearNum年
			}
			if(monthNum!=0){
				rightNow.add(Calendar.MONTH,monthNum);//日期加或减monthNum个月
			}
			if(dayNum!=0){
				rightNow.add(Calendar.DAY_OF_YEAR,dayNum);//日期加或减dayNum天
			}
			Date dt1=rightNow.getTime();
			return sdf.format(dt1);
		} catch (ParseException e) {
			e.printStackTrace();
			return "";
		}
	}
	/**
	 * 根据当前的时间加或减(-)年、月、日
	 * @param currentDateStr 当前的时间
	 * @param yearNum 年数
	 * @param monthNum 月数
	 * @param dayNum 日数
	 * @return
	 */
	public static Date assignNewDate(Date currentDateStr,int yearNum,int monthNum,int dayNum) throws ParseException{
		Date dt = currentDateStr;
		Calendar rightNow = Calendar.getInstance();
		rightNow.setTime(dt);
		if(yearNum!=0){
			rightNow.add(Calendar.YEAR,yearNum);//日期加或减yearNum年
		}
		if(monthNum!=0){
			rightNow.add(Calendar.MONTH,monthNum);//日期加或减monthNum个月
		}
		if(dayNum!=0){
			rightNow.add(Calendar.DAY_OF_YEAR,dayNum);//日期加或减dayNum天
		}
		Date dt1=rightNow.getTime();
		return dt1;
	}
	
     /**
	  * 显示时间，如果与当前时间差别小于一天，则自动用**秒(分，小时)前，如果大于一天则用format规定的格式显示
	  * 
	  * @author wxy
	  * @param ctime
	  *            时间
	  * @param format
	  *            格式 格式描述:例如:yyyy-MM-dd yyyy-MM-dd HH:mm:ss
	  * @return
	  */
	 public static String showTime(Date ctime, String format) {
	  String r = "";
	  if(ctime==null)return r;
	  if(format==null)format="yyyy-MM-dd";
	  
	  long nowtimelong = System.currentTimeMillis();
	  long ctimelong = ctime.getTime();
	  long result = Math.abs(nowtimelong - ctimelong);

	  if (result < 60000)// 一分钟内
	  {
	   long seconds = result / 1000;
	   r = seconds + "秒前";
	  } else if (result >= 60000 && result < 3600000)// 一小时内
	  {
	   long seconds = result / 60000;
	   r = seconds + "分前";
	  } else if (result >= 3600000 && result < 86400000)// 一天内
	  {
	   long seconds = result / 3600000;
	   r = seconds + "小时前";
	  } else// 日期格式
	  {
	   r = new SimpleDateFormat(format).format(ctime);
	  }
	  return r;
	 }
	 
	 /**
	  * 获取当前日期是星期几
	  * @param dt
	  * @return
	  */
	 public static String getWeekOfDate(Date dt) {
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        return weekDays[w];
    }
	 
	 /**  
     * 计算两个日期之间相差的天数  
     * @param smdate 较小的时间 
     * @param bdate  较大的时间 
     * @return 相差天数 
     * @throws ParseException  
     */    
    public static int daysBetween(Date smdate,Date bdate) throws ParseException    
    {    
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        smdate=sdf.parse(sdf.format(smdate));  
        bdate=sdf.parse(sdf.format(bdate));  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(smdate);    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(bdate);    
        long time2 = cal.getTimeInMillis();         
        long between_days=(time2-time1)/(1000*3600*24);  
            
       return Integer.parseInt(String.valueOf(between_days));           
    }    
      
	/** 
	*字符串的日期格式的计算 
	*/  
    public static int daysBetween(String smdate,String bdate) throws ParseException{  
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(sdf.parse(smdate));    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(sdf.parse(bdate));    
        long time2 = cal.getTimeInMillis();         
        long between_days=(time2-time1)/(1000*3600*24);  
            
       return Integer.parseInt(String.valueOf(between_days));     
    } 
    
    public static String SubStrDate(String date){
    	if(date!="" && date!=null){
    		String year = date.substring(0, 4);
    		String month = date.substring(5, 7);
    		String day = date.substring(8, 10);
    		String newDate = year+"-"+month+"-"+day;
    		if(date.split("时").length>0){
    			String hour = date.substring(date.indexOf("日")+1, date.indexOf("时")).trim();
    			String minute = date.substring(date.indexOf("时")+1, date.indexOf("分")).trim();
    			String second = date.substring(date.indexOf("分")+1, date.indexOf("秒")).trim();
    			newDate += " "+hour+":"+minute+":"+second;
    		}
    		return newDate;
    	}
    	return null;
    }
	
	public static void main(String[] args) {
		try {
//			System.out.println(daysBetween(new Date(), dateFormat.parse("2014-12-20")));
//			System.out.println(daysBetween(new Date(), dateFormat.parse("2015-01-10")));
//			System.out.println("=====================================================");
//			System.out.println(daysBetween("2014-12-30 18:04:28", "2014-12-20"));
//			System.out.println(daysBetween("2014-12-30 18:04:28", "2015-01-10"));
			
			System.out.println(assignNewDate(new Date(), 0, 0, 1));
			
//			System.out.println(nowDate("yyyy-MM-dd HH:mm:ss","2015-6-9 20:39:30"));
			
			System.out.println(toTimestamp("2015-6-19", "00:00:00"));
			
//			String date = "2015年06月09日 20时27分22秒";
//			System.out.println(SubStrDate(date));
//			System.out.println(date.substring(0, 4)+"-"+date.substring(5, 7)+"-"+date.substring(8, 10));
//			System.out.println(date.substring(date.indexOf("日")+1, date.indexOf("时")).trim()+":"+date.substring(date.indexOf("时")+1, date.indexOf("分")).trim()+":"+date.substring(date.indexOf("分")+1, date.indexOf("秒")).trim());
			
//			System.out.println(SubStrDate("2015年01月05日 19时56分11秒"));
//			java.sql.Date aa =new java.sql.Date(new Date().getTime());
//			System.out.println(new java.sql.Date(new Date().getTime()));
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
