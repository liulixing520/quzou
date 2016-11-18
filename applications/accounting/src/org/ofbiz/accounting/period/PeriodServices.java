/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *******************************************************************************/

package org.ofbiz.accounting.period;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityQuery;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

public class PeriodServices {
    
    public static String module = PeriodServices.class.getName();
    public static final String resource = "AccountingUiLabels";

    /* find the date of the last closed CustomTimePeriod, or, if none available, the earliest date available of any
     * CustomTimePeriod
     */
    public static Map<String, Object> findLastClosedDate(DispatchContext dctx, Map<String, ?> context) {
        Delegator delegator = dctx.getDelegator();
        String organizationPartyId = (String) context.get("organizationPartyId"); // input parameters
        String periodTypeId = (String) context.get("periodTypeId");
        Date findDate = (Date) context.get("findDate");
        Locale locale = (Locale) context.get("locale");

        // default findDate to now
        if (findDate == null) {
            findDate = new Date(UtilDateTime.nowTimestamp().getTime());
        }

        Timestamp lastClosedDate = null;          // return parameters
        GenericValue lastClosedTimePeriod = null;
        Map<String, Object> result = ServiceUtil.returnSuccess();

        try {
            // try to get the ending date of the most recent accounting time period before findDate which has been closed
            List<EntityCondition> findClosedConditions = UtilMisc.toList(EntityCondition.makeConditionMap("organizationPartyId", organizationPartyId),
                    EntityCondition.makeCondition("thruDate", EntityOperator.LESS_THAN_EQUAL_TO, findDate),
                    EntityCondition.makeConditionMap("isClosed", "Y"));
            if (UtilValidate.isNotEmpty(periodTypeId)) {
                // if a periodTypeId was supplied, use it
                findClosedConditions.add(EntityCondition.makeConditionMap("periodTypeId", periodTypeId));
            }
            GenericValue closedTimePeriod = EntityQuery.use(delegator).from("CustomTimePeriod").select("customTimePeriodId", "periodTypeId", "isClosed", "fromDate", "thruDate")
                    .where(findClosedConditions).orderBy("thruDate DESC").queryFirst();

            if (closedTimePeriod != null && closedTimePeriod.get("thruDate") != null) {
                lastClosedTimePeriod = closedTimePeriod;
                lastClosedDate = UtilDateTime.toTimestamp(lastClosedTimePeriod.getDate("thruDate"));
            } else {
                // uh oh, no time periods have been closed?  in that case, just find the earliest beginning of a time period for this organization
                // and optionally, for this period type
                Map<String, String> findParams = UtilMisc.toMap("organizationPartyId", organizationPartyId);
                if (UtilValidate.isNotEmpty(periodTypeId)) {
                    findParams.put("periodTypeId", periodTypeId);
                }
                GenericValue timePeriod = EntityQuery.use(delegator).from("CustomTimePeriod").where(findParams).orderBy("fromDate ASC").queryFirst();
                if (timePeriod != null && timePeriod.get("fromDate") != null) {
                    lastClosedDate = UtilDateTime.toTimestamp(timePeriod.getDate("fromDate"));
                } else {
                    return ServiceUtil.returnError(UtilProperties.getMessage(resource, "AccountingPeriodCannotGet", locale));
                }
            }

            result.put("lastClosedTimePeriod", lastClosedTimePeriod);  // ok if this is null - no time periods have been closed
            result.put("lastClosedDate", lastClosedDate);  // should have a value - not null
            return result;
        } catch (GenericEntityException ex) {
            return(ServiceUtil.returnError(ex.getMessage()));
        }
    }
}
