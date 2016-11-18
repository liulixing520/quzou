package org.extErp.sysCommon.raw;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.extErp.sysCommon.util.ExcelUitl;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;

public class RawServices
{
    /**
	 * 保存数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> createRawIndex(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String indexId = delegator.getNextSeqId("RawIndex");
	    GenericValue gv = delegator.makeValue("RawIndex", UtilMisc.toMap("indexId", indexId));
	    gv.setNonPKFields(context);
	    gv.create();
	    result.put("indexId", indexId);
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;
    }

    /**
	 * 更新数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> updateRawIndex(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String indexId = (String) context.get("indexId");
	GenericValue gv = delegator.findOne("RawIndex", false, UtilMisc.toMap("indexId", indexId));
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.setNonPKFields(context);
	    gv.store();
	}
	return result;
    }

    /**
	 * 删除数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> deleteRawIndex(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String indexId = (String) context.get("indexId");
	GenericValue gv = delegator.findOne("RawIndex", false, UtilMisc.toMap("indexId", indexId));
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.remove();
	}

	return result;
    }

    /**
	 * 保存数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> createRawTheme(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    LocalDispatcher dispatcher = dctx.getDispatcher();
	    GenericValue userLogin = (GenericValue) context.get("userLogin");
	    String themeId = delegator.getNextSeqId("RawTheme");
	    GenericValue gv = delegator.makeValue("RawTheme", UtilMisc.toMap("themeId", themeId));
	    gv.setNonPKFields(context);
	    gv.create();
	    result.put("themeId", themeId);

			// 同时保存交叉表和一维动态表指标配置表
	    Map<String, String> cellMap = UtilGenerics.checkMap(context.get("cellMap"));
	    Map<String, String> rowMap = UtilGenerics.checkMap(context.get("rowMap"));
	    Map<String, String> excelMap = UtilGenerics.checkMap(context.get("excelMap"));

	    if (cellMap != null)
	    {
		for (String cellKey : cellMap.keySet())
		{
		    String cellIndex = cellMap.get(cellKey);
		    cellKey = cellKey.split("_")[1];
		    String rowIndex = rowMap.get("row_" + cellKey + "_add");
		    String excelGrid = excelMap.get("excel_" + cellKey + "_add");
		    Map<String, Object> crossMap = UtilMisc.<String, Object> toMap("themeId", themeId, "rowIndexId", rowIndex, "cellIndexId", cellIndex, "excelGrid", excelGrid);
		    if (UtilValidate.isNotEmpty(cellIndex))
		    {
			// dispatcher.runAsync("createRawCrosstab",
			// crossMap);
			GenericValue rgv = delegator.makeValue("RawCrosstab", crossMap);
			rgv.create();
		    }
		}
	    }

	    Map<String, String> cellDynMap = UtilGenerics.checkMap(context.get("cellDynMap"));
	    Map<String, String> cellNumDynMap = UtilGenerics.checkMap(context.get("cellNumDynMap"));
	    if (cellDynMap != null)
	    {
		for (String cellKey : cellDynMap.keySet())
		{
		    String cellIndex = cellDynMap.get(cellKey);
		    cellKey = cellKey.split("_")[1];
		    String cellNumDyn = cellNumDynMap.get("cellNumDyn_" + cellKey + "_add");
		    Map<String, Object> oneDynMap = UtilMisc.<String, Object> toMap("themeId", themeId, "cellNum", cellNumDyn, "cellIndexId", cellIndex);
		    if (UtilValidate.isNotEmpty(cellIndex))
		    {
			// dispatcher.runAsync("createRawCrosstab",
			// crossMap);
			GenericValue rgv = delegator.makeValue("RawOneDynamic", oneDynMap);
			rgv.create();
		    }
		}
	    }
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;
    }

    /**
	 * 更新数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> updateRawTheme(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String themeId = (String) context.get("themeId");
	GenericValue gv = delegator.findOne("RawTheme", false, UtilMisc.toMap("themeId", themeId));
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.setNonPKFields(context);
	    gv.store();

			// 同时保存交叉表和一维动态表指标配置表
	    Map<String, String> cellMap = UtilGenerics.checkMap(context.get("cellMap"));
	    Map<String, String> rowMap = UtilGenerics.checkMap(context.get("rowMap"));
	    Map<String, String> excelMap = UtilGenerics.checkMap(context.get("excelMap"));

	    if (cellMap != null)
	    {
		for (String cellKey : cellMap.keySet())
		{
		    String cellIndex = cellMap.get(cellKey);
		    cellKey = cellKey.split("_")[1];
		    String rowIndex = rowMap.get("row_" + cellKey + "_add");
		    String excelGrid = excelMap.get("excel_" + cellKey + "_add");
		    Map<String, Object> crossMap = UtilMisc.<String, Object> toMap("themeId", themeId, "rowIndexId", rowIndex, "cellIndexId", cellIndex, "excelGrid", excelGrid);
		    if (UtilValidate.isNotEmpty(cellIndex))
		    {
			// dispatcher.runAsync("createRawCrosstab",
			// crossMap);
			GenericValue rgv = delegator.makeValue("RawCrosstab", crossMap);
			rgv.create();
		    }
		}
	    }

	    Map<String, String> cellDynMap = UtilGenerics.checkMap(context.get("cellDynMap"));
	    Map<String, String> cellNumDynMap = UtilGenerics.checkMap(context.get("cellNumDynMap"));
	    if (cellDynMap != null)
	    {
		for (String cellKey : cellDynMap.keySet())
		{
		    String cellIndex = cellDynMap.get(cellKey);
		    cellKey = cellKey.split("_")[1];
		    String cellNumDyn = cellNumDynMap.get("cellNumDyn_" + cellKey + "_add");
		    Map<String, Object> oneDynMap = UtilMisc.<String, Object> toMap("themeId", themeId, "cellNum", cellNumDyn, "cellIndexId", cellIndex);
		    if (UtilValidate.isNotEmpty(cellIndex))
		    {
			// dispatcher.runAsync("createRawCrosstab",
			// crossMap);
			GenericValue rgv = delegator.makeValue("RawOneDynamic", oneDynMap);
			rgv.create();
		    }
		}
	    }
	}
	return result;
    }

    /**
	 * 删除数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> deleteRawTheme(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String themeId = (String) context.get("themeId");
	GenericValue gv = delegator.findOne("RawTheme", false, UtilMisc.toMap("themeId", themeId));
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.remove();
	}

	return result;
    }

    /**
	 * 保存交叉表数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> createRawCrosstab(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    GenericValue gv = delegator.makeValue("RawCrosstab",
		    UtilMisc.toMap("themeId", context.get("themeId"), "rowIndexId", context.get("rowIndexId"), "cellIndexId", context.get("cellIndexId")));
	    gv.create();
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;
    }

    /**
	 * 删除交叉表数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> deleteRawCrosstab(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String themeId = (String) context.get("themeId");
	try
	{
            int num = delegator.removeByAnd("RawCrosstab", UtilMisc.toMap("themeId", themeId), false);
	} catch (Exception e)
	{
	    e.printStackTrace();
	}

	return result;
    }

    /**
	 * 保存一维动态表数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> createRawOneDynamic(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    GenericValue gv = delegator.makeValue("RawOneDynamic",
		    UtilMisc.toMap("themeId", context.get("themeId"), "cellNum", context.get("cellNum"), "cellIndexId", context.get("cellIndexId")));
	    gv.setNonPKFields(context);
	    gv.create();
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;
    }

    /**
	 * 删除一维动态表数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> deleteRawOneDynamic(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String themeId = (String) context.get("themeId");
	try
	{
            int num = delegator.removeByAnd("RawOneDynamic", UtilMisc.toMap("themeId", themeId), false);
	} catch (Exception e)
	{
	    e.printStackTrace();
	}

	return result;
    }

    /**
	 * 交叉表数据保存
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> createRawCrosstabData(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    GenericValue gv = delegator.makeValue("RawCrosstabDatas",
		    UtilMisc.toMap("themeId", context.get("themeId"), "excelGrid", context.get("excelGrid"), "excelData", context.get("excelData")));
	    gv.setNonPKFields(context);
	    gv.create();
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;
    }

    /**
	 * 一维表数据保存
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> createOneDynamicData(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    GenericValue gv = delegator.makeValue("RawOneDynamicData",
		    UtilMisc.toMap("themeId", context.get("themeId"), "excelGrid", context.get("excelGrid"), "excelData", context.get("excelData")));
	    gv.setNonPKFields(context);
	    gv.create();
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;
    }

	// ///////////////////////采集系统//////////////////////////////////////////////////
    /**
	 * 多维模板保存
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> createRawTemplate(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    LocalDispatcher dispatcher = dctx.getDispatcher();
	    GenericValue userLogin = (GenericValue) context.get("userLogin");
	    String templateId = delegator.getNextSeqId("RawTemplate");
	    GenericValue gv = delegator.makeValue("RawTemplate", UtilMisc.toMap("templateId", templateId));
	    gv.setNonPKFields(context);
	    gv.create();

	    List<String> dimList = UtilGenerics.checkList(context.get("dimensionId"));
			// 保存模板与维度关联表
	    for (int i = 0; i < dimList.size(); i++)
	    {
		GenericValue rfGv = delegator.makeValue("RawTemplateRefdim",
			UtilMisc.<String, Object> toMap("templateId", templateId, "dimensionId", dimList.get(i), "dimNum", new Long(i + 1)));
		rfGv.create();
	    }
			// 保存模板与度量关联表
	    List<String> measureList = UtilGenerics.checkList(context.get("measureId"));
	    for (int i = 0; i < measureList.size(); i++)
	    {
		GenericValue rfGv = delegator.makeValue("RawTemplateRefmeasure",
			UtilMisc.<String, Object> toMap("templateId", templateId, "measureId", measureList.get(i), "measureNum", new Long(i + 1)));
		rfGv.create();
	    }
	    result.put("templateId", templateId);

			// 同时保存交叉表

	    Map<String, String> dimMap = UtilGenerics.checkMap(context.get("dimMap"));
	    Map<String, String> dimPartMap = UtilGenerics.checkMap(context.get("dimPartMap"));
	    Map<String, String> cellMap = UtilGenerics.checkMap(context.get("cellMap"));
	    Map<String, String> rowMap = UtilGenerics.checkMap(context.get("excelMap"));

	    if (rowMap != null)
	    {
		for (String rowKey : rowMap.keySet())
		{
		    String rowIndex = rowMap.get(rowKey);
		    String crossId = delegator.getNextSeqId("RawCrossConfig");
		    if (UtilValidate.isNotEmpty(rowIndex))
		    {
			for (int i = 0; i < measureList.size(); i++)
			{
			    Map<String, Object> crossMap = UtilMisc.<String, Object> toMap("templateId", templateId, "measureId", measureList.get(i), "excelGrid",
				    ExcelUitl.excelArray[Integer.valueOf(context.get("startCellNum").toString()) - 1 + i] + rowIndex, "cellNum",
				    new Long(Integer.valueOf(context.get("startCellNum").toString()) + i), "rowNum", new Long(rowIndex), "crossId",
				    crossId);
			    GenericValue rgv = delegator.makeValue("RawCrossConfig", crossMap);
			    rgv.create();
			}
						// 同时保存交叉表与维度关联表
			for (int i = 0; i < dimList.size(); i++)
			{
			    if (dimMap.get((i + 1) + "_" + rowKey.split("_")[0] + "_add") != null)
			    {
				GenericValue refGv = delegator.makeValue("RawCrossRefdimPart", UtilMisc.<String, Object> toMap("crossId", crossId, "dimensionPartId",
					dimMap.get((i + 1) + "_" + rowKey.split("_")[0] + "_add"), "dimPartNum", new Long(i + 1), "dimPartSort", new Long(rowIndex)));
				refGv.create();
			    }
			}

		    }
		}
	    }

	} catch (Exception e)
	{
	    e.printStackTrace();
			result.put("message", "创建失败");
	}
	return result;
    }

    /**
	 * 3维保存数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */

    public static Map<String, Object> createRawTemplate3(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    LocalDispatcher dispatcher = dctx.getDispatcher();
	    GenericValue userLogin = (GenericValue) context.get("userLogin");
	    String templateId = delegator.getNextSeqId("RawTemplate");
	    GenericValue gv = delegator.makeValue("RawTemplate", UtilMisc.toMap("templateId", templateId));
	    gv.setNonPKFields(context);
	    gv.create();

	    List<String> dimList = UtilGenerics.checkList(context.get("dimensionId"));
			// 保存模板与维度关联表
	    for (int i = 0; i < dimList.size(); i++)
	    {
		GenericValue rfGv = delegator.makeValue("RawTemplateRefdim",
			UtilMisc.<String, Object> toMap("templateId", templateId, "dimensionId", dimList.get(i), "dimNum", new Long(i + 1)));
		rfGv.create();
	    }
	    result.put("templateId", templateId);

			// 同时保存交叉表
	    Map<String, String> dim1Map = UtilGenerics.checkMap(context.get("dim1Map"));
	    Map<String, String> dim2Map = UtilGenerics.checkMap(context.get("dim2Map"));
	    Map<String, String> dim3Map = UtilGenerics.checkMap(context.get("dim3Map"));
	    Map<String, String> cellMap = UtilGenerics.checkMap(context.get("cellMap"));
	    Map<String, String> excelMap = UtilGenerics.checkMap(context.get("excelMap"));

	    if (cellMap != null)
	    {
		for (String cellKey : cellMap.keySet())
		{
		    String cellIndex = cellMap.get(cellKey);
		    cellKey = cellKey.split("_")[0];
		    String dim1 = dim1Map.get(cellKey + "_add");
		    String dim2 = dim2Map.get(cellKey + "_add");
		    String dim3 = dim3Map.get(cellKey + "_add");
		    String excelGrid = excelMap.get(cellKey + "_add");
		    String crossId = delegator.getNextSeqId("RawCrossConfig");
		    Map<String, Object> crossMap = UtilMisc.<String, Object> toMap("templateId", templateId, "dimensionPart1Id", dim1, "dimensionPart2Id", dim2,
			    "dimensionPart3Id", dim3, "measureId", cellIndex, "excelGrid", excelGrid);
		    if (UtilValidate.isNotEmpty(cellIndex))
		    {
			crossMap.put("crossId", crossId);
			GenericValue rgv = delegator.makeValue("RawCrossConfig", crossMap);
			rgv.create();
						// 同时保存交叉表与维度关联表
			GenericValue refGv = delegator.makeValue("RawCrossRefdimPart",
				UtilMisc.<String, Object> toMap("crossId", crossId, "dimensionPartId", dim1, "dimPartNum", new Long(1)));
			refGv.create();
			if (UtilValidate.isNotEmpty(dim2))
			{
			    GenericValue rf2Gv = delegator.makeValue("RawCrossRefdimPart",
				    UtilMisc.<String, Object> toMap("crossId", crossId, "dimensionPartId", dim2, "dimPartNum", new Long(2)));
			    rf2Gv.create();
			}
		    }
		}
	    }

	} catch (Exception e)
	{
	    e.printStackTrace();
			result.put("message", "创建失败");
	}
	return result;
    }

    /**
	 * 更新数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> updateRawTemplate(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String templateId = (String) context.get("templateId");
	GenericValue gv = delegator.findOne("RawTemplate", false, UtilMisc.toMap("templateId", templateId));
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.setNonPKFields(context);
	    gv.store();

			// 同时保存交叉表和一维动态表指标配置表
	    Map<String, String> cellMap = UtilGenerics.checkMap(context.get("cellMap"));
	    Map<String, String> rowMap = UtilGenerics.checkMap(context.get("rowMap"));
	    Map<String, String> excelMap = UtilGenerics.checkMap(context.get("excelMap"));

	    if (cellMap != null)
	    {
		for (String cellKey : cellMap.keySet())
		{
		    String cellIndex = cellMap.get(cellKey);
		    cellKey = cellKey.split("_")[1];
		    String rowIndex = rowMap.get("row_" + cellKey + "_add");
		    String excelGrid = excelMap.get("excel_" + cellKey + "_add");
		    Map<String, Object> crossMap = UtilMisc.<String, Object> toMap("templateId", templateId, "rowIndexId", rowIndex, "cellIndexId", cellIndex, "excelGrid",
			    excelGrid);
		    if (UtilValidate.isNotEmpty(cellIndex))
		    {
			// dispatcher.runAsync("createRawCrosstab",
			// crossMap);
			GenericValue rgv = delegator.makeValue("RawCrosstab", crossMap);
			rgv.create();
		    }
		}
	    }

	    Map<String, String> cellDynMap = UtilGenerics.checkMap(context.get("cellDynMap"));
	    Map<String, String> cellNumDynMap = UtilGenerics.checkMap(context.get("cellNumDynMap"));
	    if (cellDynMap != null)
	    {
		for (String cellKey : cellDynMap.keySet())
		{
		    String cellIndex = cellDynMap.get(cellKey);
		    cellKey = cellKey.split("_")[1];
		    String cellNumDyn = cellNumDynMap.get("cellNumDyn_" + cellKey + "_add");
		    Map<String, Object> oneDynMap = UtilMisc.<String, Object> toMap("templateId", templateId, "cellNum", cellNumDyn, "cellIndexId", cellIndex);
		    if (UtilValidate.isNotEmpty(cellIndex))
		    {
			// dispatcher.runAsync("createRawCrosstab",
			// crossMap);
			GenericValue rgv = delegator.makeValue("RawOneDynamic", oneDynMap);
			rgv.create();
		    }
		}
	    }
	}
	return result;
    }

    /**
	 * 保存数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> createRawTemplateGroup(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	try
	{
	    Delegator delegator = dctx.getDelegator();
	    String templateGroupId = delegator.getNextSeqId("RawTemplateGroup");
	    GenericValue gv = delegator.makeValue("RawTemplateGroup", UtilMisc.toMap("templateGroupId", templateGroupId));
	    gv.setNonPKFields(context);
	    gv.create();
	    result.put("templateGroupId", templateGroupId);
	} catch (Exception e)
	{
	    e.printStackTrace();
	}
	return result;
    }

    /**
	 * 更新数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> updateRawTemplateGroup(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String templateGroupId = (String) context.get("templateGroupId");
	GenericValue gv = delegator.findOne("RawTemplateGroup", false, UtilMisc.toMap("templateGroupId", templateGroupId));
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.setNonPKFields(context);
	    gv.store();
	}
	return result;
    }

    /**
	 * 删除数据
	 * 
	 * @param dctx
	 * @param context
	 * @return
	 * @throws GenericEntityException
	 */
    public static Map<String, Object> deleteRawTemplateGroup(DispatchContext dctx, Map<String, ? extends Object> context) throws GenericEntityException
    {
	Map result = new HashMap();
	Delegator delegator = dctx.getDelegator();
	String templateGroupId = (String) context.get("templateGroupId");
	GenericValue gv = delegator.findOne("RawTemplateGroup", false, UtilMisc.toMap("templateGroupId", templateGroupId));
	if (UtilValidate.isNotEmpty(gv))
	{
	    gv.remove();
	}

	return result;
    }

    /**
	 * 迭代器 循环当前维度，获取下一维度
	 * 
	 * @param dimPartMap
	 * @param start
	 * @param measureList
	 * @return
	 */

    public static List genericCross(List crossList, Map<String, Object> dimPartMap, int start, List measureList)
    {

	String str = "";
	str += "<td>" + start + "</td>";
	boolean hasNextDim = false;

	if (hasNextDim)
	{
	    genericCross(crossList, dimPartMap, 1, measureList);
	}
	for (String key : dimPartMap.keySet())
	{

	}
	return crossList;

    }
}
