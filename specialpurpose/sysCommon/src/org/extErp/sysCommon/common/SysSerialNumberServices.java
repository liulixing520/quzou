package org.extErp.sysCommon.common;

import java.util.Calendar;
import java.util.Map;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

/**
 * @Desc 编号生成管理
 */
public class SysSerialNumberServices
{
    private static final String module = SysSerialNumberServices.class.getName();
    /**
     * 实体名称
     */
    public static final String entityName = "SysSerialNumber";

    /**
     * 通用编号生成器
     * 
     * @param ctx
     * @param context
     * @return
     */
    public synchronized static Map<String, Object> createOrUpdateSN(DispatchContext dctx, Map<String, Object> context)
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	Delegator delegator = dctx.getDelegator();
	// snName表名唯一
	String snName = (String) context.get("snName");
	String defalutSN = (String) context.get("defalutSN");
	String dateStyle = (String) context.get("dateStyle");
	Integer defalutLengthSN = (Integer) context.get("defalutLengthSN");

	String prefix = (String) context.get("prefix");
	String dateFomatter = (String) context.get("dateFomatter");
	String separator = (String) context.get("separator");

	if (UtilValidate.isEmpty(defalutSN))
	{
	    defalutSN = yearMonthDaySN(defalutLengthSN.intValue());
	}
	try
	{
	    GenericValue sn = EntityUtil.getFirst(delegator.findByAnd(entityName, UtilMisc.toMap("snName", snName), null, false));
	    if (UtilValidate.isEmpty(sn))
	    {
		sn = delegator.makeValue(entityName);
		sn.set("sysSnId", delegator.getNextSeqId(entityName));
		sn.set("snName", snName);
		sn.set("snId", Long.valueOf(defalutSN));
		delegator.create(sn);
	    } else
	    {
		if (isNeedJumpNumber(sn.getLong("snId") + "", dateStyle))
		{
		    if (dateStyle.equals("yyyy"))
			sn.set("snId", Long.valueOf(yearSN(defalutLengthSN.intValue())));
		    if (dateStyle.equals("yyyyMM"))
			sn.set("snId", Long.valueOf(yearMonthSN(defalutLengthSN.intValue())));
		} else
		{
		    Long snId = newSnId(sn.getLong("snId"));
		    sn.set("snId", snId);
		}
		delegator.store(sn);
	    }
	    /*
	     * 将20130501xxxxx或者201305xxxxx字符串切割成201305 和 xxxxx
	     * 如果传入了日期formatter 则重新生成 格式日期如yyyy-MM-dd，否则使用切割出来的日期
	     * 将前缀prefix 如“RWD” 分隔符separator 如“-” 加入生成
	     * RWD-yyyy-MM-dd-xxxxx
	     * 如果formatter、prefix、separator均为空，则组合起来仍然是原字符串
	     */
	    String code = sn.get("snId") + "";

	    String codeMain = code.substring(0, code.length() - defalutLengthSN);
	    String codeSuffix = code.substring(code.length() - defalutLengthSN);
	    String codePrefix = UtilValidate.isNotEmpty(prefix) ? prefix : "";
	    String codeSeparator = UtilValidate.isNotEmpty(separator) ? separator : "";
	    if (UtilValidate.isNotEmpty(dateFomatter))
	    {
		codeMain = UtilDateTime.nowDateString(dateFomatter);
	    }
	    result.put("newSN", codePrefix + codeSeparator + codeMain + codeSeparator + codeSuffix);
	} catch (GenericEntityException e)
	{
	    Debug.logError(e, module);
	}
	return result;
    }

    /**
     * 生成样品证书编号
     * 
     * @param dctx
     * @param context
     * @return
     */
    public static Map<String, Object> createOrUpdateSampleCertSN(DispatchContext dctx, Map<String, Object> context)
    {
	Map<String, Object> result = ServiceUtil.returnSuccess();
	Delegator delegator = dctx.getDelegator();
	String snName = (String) context.get("snName");
	String deptId = (String) context.get("snDeptId");
	String defalutSN = (String) context.get("defalutSN");
	if (UtilValidate.isEmpty(defalutSN))
	{
	    defalutSN = yearMonthDaySN(4);
	}
	try
	{
	    GenericValue sn = EntityUtil.getFirst(delegator.findByAnd(entityName, UtilMisc.toMap("snName", snName, "snDeptId", deptId), null, false));
	    if (UtilValidate.isEmpty(sn))
	    {
		sn = delegator.makeValue(entityName);
		sn.set("sysSnId", delegator.getNextSeqId(entityName));
		sn.set("snName", snName);
		sn.set("snDeptId", deptId);
		sn.set("snId", Long.valueOf(defalutSN));
		delegator.create(sn);
	    } else
	    {
		if (isNeedJumpNumber(sn.getLong("snId") + "", "yyyyMM"))
		{
		    sn.set("snId", Long.valueOf(defalutSN()));
		} else
		{
		    Long snId = newSnId(sn.getLong("snId"));
		    sn.set("snId", snId);
		}
		delegator.store(sn);
	    }
	    result.put("newSN", sn.get("snId") + "");
	} catch (GenericEntityException e)
	{
	    Debug.logError(e, module);
	}
	return result;
    }

    /**
     * 默认步长加1
     * 
     * @param curSeqId
     * @return
     */
    private static synchronized Long newSnId(long curSeqId)
    {
	return newSnId(curSeqId, 1);
    }

    /**
     * 自定义当前的步长
     * 
     * @param curSeqId
     * @param staggerMax
     * @return
     */
    private static synchronized Long newSnId(long curSeqId, long staggerMax)
    {
	return curSeqId + staggerMax;
    }

    /**
     * 默认的编号 格式yyyyMM0001
     * 
     * @return
     */
    private static String defalutSN()
    {
	String monthStr = (Calendar.getInstance().get(Calendar.MONTH) + 1) + "";
	if (Integer.valueOf(monthStr) < 10)
	{
	    monthStr = "0" + monthStr;
	}
	return Calendar.getInstance().get(Calendar.YEAR) + monthStr + "0001";
    }

    /**
     * 年月日 格式yyyyMMdd0001
     * 
     * @return
     */
    private static String yearMonthDaySN(int defalutLengthSN)
    {
	String monthStr = (Calendar.getInstance().get(Calendar.MONTH) + 1) + "";
	if (Integer.valueOf(monthStr) < 10)
	{
	    monthStr = "0" + monthStr;
	}
	String dayStr = (Calendar.getInstance().get(Calendar.DATE)) + "";
	if (Integer.valueOf(dayStr) < 10)
	{
	    dayStr = "0" + dayStr;
	}
	String defaultSN = "";
	for (int i = 1; i < defalutLengthSN; i++)
	    defaultSN = defaultSN + "0";
	return Calendar.getInstance().get(Calendar.YEAR) + monthStr + dayStr + defaultSN + "1";
    }

    /**
     * 年 格式yyyy0001
     * 
     * @return
     */
    private static String yearSN(int defalutLengthSN)
    {
	String defaultSN = "";
	for (int i = 1; i < defalutLengthSN; i++)
	    defaultSN = defaultSN + "0";
	return Calendar.getInstance().get(Calendar.YEAR) + defaultSN + "1";
    }

    /**
     * 年月 格式yyyyMM0001
     * 
     * @return
     */
    private static String yearMonthSN(int defalutLengthSN)
    {
	String monthStr = (Calendar.getInstance().get(Calendar.MONTH) + 1) + "";
	if (Integer.valueOf(monthStr) < 10)
	{
	    monthStr = "0" + monthStr;
	}
	String defaultSN = "";
	for (int i = 1; i < defalutLengthSN; i++)
	    defaultSN = defaultSN + "0";
	return Calendar.getInstance().get(Calendar.YEAR) + monthStr + defaultSN + "1";
    }

    /**
     * 判断当前的编号是否需要跳号
     * 
     * @param currSN
     * @param jumpStyle
     *            yyyyMM:只判断某个月份里跳号；yyyyMMdd:只判断某日跳号
     * @return
     */
    private static boolean isNeedJumpNumber(String currSN, String jumpStyle)
    {
	String year = currSN.substring(0, 4);
	if (Integer.valueOf(year) < Calendar.getInstance().get(Calendar.YEAR))
	{
	    return true;
	}
	if (jumpStyle.equals("yyyyMM"))
	{
	    String month = currSN.substring(4, 6);
	    if (Integer.valueOf(month) < (Calendar.getInstance().get(Calendar.MONTH) + 1))
	    {
		return true;
	    }
	} else if (jumpStyle.equals("yyyyMMdd"))
	{
	    String month = currSN.substring(4, 6);
	    if (Integer.valueOf(month) < (Calendar.getInstance().get(Calendar.MONTH) + 1))
	    {
		return true;
	    }
	    String day = currSN.substring(6, 8);
	    if (Integer.valueOf(day) < (Calendar.getInstance().get(Calendar.DATE)))
	    {
		return true;
	    }
	}
	return false;
    }
}
