package org.ofbiz.solr;

import javolution.util.FastList;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.GenericDelegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.service.DispatchContext;

import java.util.List;

/**
 * Created by Administrator on 2014/12/22.
 */
public class GeoUtil {
    public static final String module = CategoryUtil.class.getName();

    // 获取区域的上级下关系
    public static List<String> getGeoTrail(String geoId, DispatchContext dctx) {
        GenericDelegator delegator = (GenericDelegator) dctx.getDelegator();
        List<String> trailElements = FastList.newInstance();
        try {
            GenericValue parentGeoInfo = delegator.findOne("ChinaGeo", UtilMisc.toMap("geoId", geoId), true);
            if(UtilValidate.isNotEmpty(parentGeoInfo)){
                String parentGeoId = parentGeoInfo.getString("parentGeoId");
                trailElements.add(parentGeoId);
                while (UtilValidate.isNotEmpty(parentGeoId)) {
                        GenericValue parentGeo = delegator.findOne("ChinaGeo", UtilMisc.toMap("geoId", parentGeoId), true);
                        if (UtilValidate.isNotEmpty(parentGeo) && UtilValidate.isNotEmpty(parentGeo.getString("parentGeoId"))) {
                            parentGeoId = parentGeo.getString("parentGeoId");
                            trailElements.add(parentGeoId);
                        } else {
                            parentGeoId = null;
                        }
                }

            }
        } catch (GenericEntityException e) {
            Debug.logError(e, "Cannot generate trail from geo", module);
        }
        return trailElements;
    }
}