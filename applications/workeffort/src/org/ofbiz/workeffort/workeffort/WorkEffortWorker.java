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

package org.ofbiz.workeffort.workeffort;

import java.util.List;
import java.util.Set;

import javolution.util.FastList;
import javolution.util.FastSet;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.util.EntityQuery;


/** WorkEffortWorker - Work Effort worker class. */
public class WorkEffortWorker {

    public static final String module = WorkEffortWorker.class.getName();

    public static List<GenericValue> getLowestLevelWorkEfforts(Delegator delegator, String workEffortId, String workEffortAssocTypeId) {
        return getLowestLevelWorkEfforts(delegator, workEffortId, workEffortAssocTypeId, "workEffortIdFrom", "workEffortIdTo");
    }

    public static List<GenericValue> getLowestLevelWorkEfforts(Delegator delegator, String workEffortId, String workEffortAssocTypeId, String left, String right) {
        if (left == null) {
            left = "workEffortIdFrom";
        }
        if (right == null) {
            right = "workEffortIdTo";
        }

        List<GenericValue> workEfforts = FastList.newInstance();
        try {
            List<GenericValue> childWEAssocsLevelFirst = EntityQuery.use(delegator).from("WorkEffortAssoc").where(left, workEffortId, "workEffortAssocTypeId", workEffortAssocTypeId).cache(true).queryList();
            for (GenericValue childWEAssocLevelFirst : childWEAssocsLevelFirst) {
                List<GenericValue> childWEAssocsLevelNext = EntityQuery.use(delegator).from("WorkEffortAssoc").where(left, childWEAssocLevelFirst.get(right), "workEffortAssocTypeId", workEffortAssocTypeId).cache(true).queryList();
                while (UtilValidate.isNotEmpty(childWEAssocsLevelNext)) {
                    List<GenericValue> tempWorkEffortList = FastList.newInstance();
                    for (GenericValue childWEAssocLevelNext : childWEAssocsLevelNext) {
                        List<GenericValue> childWEAssocsLevelNth = EntityQuery.use(delegator).from("WorkEffortAssoc").where(left, childWEAssocLevelNext.get(right), "workEffortAssocTypeId", workEffortAssocTypeId).cache(true).queryList();
                        if (UtilValidate.isNotEmpty(childWEAssocsLevelNth)) {
                            tempWorkEffortList.addAll(childWEAssocsLevelNth);
                        }
                        workEfforts.add(childWEAssocLevelNext);
                    }
                    childWEAssocsLevelNext = tempWorkEffortList;
                }
                workEfforts.add(childWEAssocLevelFirst);
            }
        } catch (GenericEntityException e) {
            Debug.logWarning(e, module);
        }
        return workEfforts;
    }

    public static List<GenericValue> removeDuplicateWorkEfforts(List<GenericValue> workEfforts) {
        Set<String> keys = FastSet.newInstance();
        Set<GenericValue> exclusions = FastSet.newInstance();
        for (GenericValue workEffort : workEfforts) {
            String workEffortId = workEffort.getString("workEffortId");
            if (keys.contains(workEffortId)) {
                exclusions.add(workEffort);
            } else {
                keys.add(workEffortId);
            }
        }
        workEfforts.removeAll(exclusions);
        return workEfforts;
    }
}
