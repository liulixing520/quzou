package org.ofbiz.ebiz.util;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityListIterator;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;


public class FindPortalUtil {
	/**
	 *  分页工具类  Map<String, Object> context
	 *  @param entityName 查询的实体名,String
	 *  @param viewSize 每页显示的记录个数,Integer
	 *  @param viewIndex 当前页码，Integer
	 *  @param orderBy 排序条件，List<String>
	 *  @param fieldsToSelect 需要查询的后显示的字段，Set<String>
	 *  @param mainCond 查询条件，EntityCondition
	 *  @return Map<String, Object> result
	 *  @return list 返回的记录，List<Generic>
	 *  @return listSize 以当前条件查询的记录总数,int
	 * @throws GenericEntityException 
	 *  
	 */
	public static Map<String, Object> findList(DispatchContext dctx,Map<String, Object> context) throws GenericEntityException{
		String entityName = (String) context.get("entityName");//查询的表对应的实体
		System.out.println(entityName.toString());
		Integer viewSize = (Integer) context.get("viewSize");
		if (UtilValidate.isEmpty(viewSize)) viewSize = Integer.valueOf(20); // default 每页显示记录个数
        Integer viewIndex = (Integer) context.get("viewIndex");
        if (UtilValidate.isEmpty(viewIndex))  viewIndex = Integer.valueOf(0);  // default 页数（从0开始）
        List<String> orderBy = UtilGenerics.<String>checkList(context.get("orderBy"));//排序
        if (UtilValidate.isEmpty(orderBy)) orderBy =null;
		Delegator delegator = dctx.getDelegator();
		//Map<String, ?> inputFields = checkMap(context.get("inputFields"), String.class, Object.class); // Input 
		Set<String> fieldsToSelect =  UtilGenerics.<String>checkSet(context.get("fieldsToSelect"));//查询的字段
		if (UtilValidate.isEmpty(fieldsToSelect)) fieldsToSelect =null;
        //List<EntityCondition> andExprs = FastList.newInstance();
        EntityCondition mainCond = (EntityCondition) context.get("mainCond");
        if (UtilValidate.isEmpty(mainCond)) mainCond =null;
        //if (andExprs.size() > 0) mainCond = EntityCondition.makeCondition(andExprs, EntityOperator.AND);
        int lowIndex = viewIndex * viewSize + 1;//当前页的第一条记录
        int highIndex = lowIndex+viewSize-1;//当前页的最后一条记录
        // set distinct on so we only get one row per order--除去表中的重复记录
        EntityFindOptions findOpts = new EntityFindOptions(true, EntityFindOptions.TYPE_SCROLL_INSENSITIVE, EntityFindOptions.CONCUR_READ_ONLY, -1, highIndex, true);
        /*
         * java.lang.String entityName, 
         * EntityCondition whereEntityCondition, 
         * EntityCondition havingEntityCondition, 
         * java.util.Set<java.lang.String> fieldsToSelect, 
         * java.util.List<java.lang.String> orderBy, 
         * EntityFindOptions findOptions
         */
        // using list iterator
        EntityListIterator pli = null;
        Map<String, Object> result =ServiceUtil.returnSuccess();//重点,返回的参数必须是map,必须由ServiceUtil生成
		try {
			pli = delegator.find(entityName, mainCond, null, fieldsToSelect, orderBy, findOpts);
	        // get the partial list for this page
	        List<GenericValue> portalList = pli.getPartialList(lowIndex, highIndex);
	        // attempt to get the full size
	        int portalListSize = pli.getResultsSizeAfterPartialList();
	        if (highIndex > portalListSize) {
	            highIndex = portalListSize;
	        }
	        result.put("list", portalList);//返回当前页的记录
	        result.put("listSize", portalListSize);//总的记录个数

		} catch (GenericEntityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
		    // close the list iterator
	        pli.close();
		}
 
		return result;
	}

}
