package org.extErp.sysCommon.util;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.Map;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilValidate;

import com.greenpineyu.fel.FelEngine;
import com.greenpineyu.fel.FelEngineImpl;
import com.greenpineyu.fel.common.FelBuilder;
import com.greenpineyu.fel.context.FelContext;

public class FelUtil
{
    public static String calculateBigNumberFormula(Map<String, Object> inputVariables, String formula, int setScale)
    {
	String resultStr = null;
	try
	{
	    FelEngine fel = FelBuilder.bigNumberEngine();
	    resultStr = calculateFormula(fel, inputVariables, formula, setScale);
	} catch (Exception e)
	{
	    Debug.logWarning("公式计算失败", null);
	}
	return resultStr;
    }

    public static String calculateNumberFormula(Map<String, Object> inputVariables, String formula, int setScale)
    {
	String resultStr = null;
	try
	{
	    FelEngine fel = new FelEngineImpl();
	    resultStr = calculateFormula(fel, inputVariables, formula, setScale);
	} catch (Exception e)
	{
	    Debug.logWarning("公式计算失败", null);
	}
	return resultStr;
    }

    public static String calculateFormula(FelEngine fel, Map<String, Object> inputVariables, String formula, int setScale)
    {
	String resultStr = null;
	try
	{
	    if (fel == null)
		fel = new FelEngineImpl();
	    FelContext ctx = fel.getContext();
	    Iterator ii = inputVariables.keySet().iterator();
	    while (ii.hasNext())
	    {
		String variableKey = ii.next().toString();
		BigDecimal variableValue = BigDecimal.ZERO;
		try
		{
		    variableValue = new BigDecimal(inputVariables.get(variableKey).toString());
		} catch (Exception e)
		{}
		if (UtilValidate.isNotEmpty(variableValue))
		{
		    ctx.set(variableKey, variableValue);
		}
		BigDecimal result = BigDecimal.ZERO;
		try
		{
		    result = new BigDecimal(fel.eval(formula).toString());
		} catch (Exception e)
		{}
		if (UtilValidate.isEmpty(setScale))
		{
		    setScale = 2;
		}
		resultStr = result.setScale(setScale, BigDecimal.ROUND_HALF_UP).toString();
	    }
	} catch (Exception e)
	{
	    Debug.logWarning("公式计算失败", null);
	}
	return resultStr;
    }

    public static void main(String[] args)
    {
	Map<String, Object> varMap = FastMap.newInstance();
	varMap.put("M", "1111111111111111111111111111111111111111111111");
	varMap.put("V", "2222222222222222222222222222222222222222222222");
	// varMap.put("P", 1000000000.55);
	System.out.println("大数值计算:" + calculateBigNumberFormula(varMap, "M+V", 3));
	System.out.println("正常数值计算:" + calculateNumberFormula(varMap, "M+V", 3));
    }
}
