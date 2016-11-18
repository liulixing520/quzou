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
package org.ofbiz.entityext.eca;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilXml;
import org.ofbiz.entity.GenericEntity;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.service.DispatchContext;
import org.w3c.dom.Element;

/**
 * Entity event-condition-action rule.
 */
@SuppressWarnings("serial")
public final class EntityEcaRule implements java.io.Serializable {

    public static final String module = EntityEcaRule.class.getName();

    private final String entityName;
    private final String operationName;
    private final String eventName;
    private final boolean runOnError;
    private final List<EntityEcaCondition> conditions;
    private final List<Object> actionsAndSets;
    private boolean enabled = true;

    public EntityEcaRule(Element eca) {
        this.entityName = eca.getAttribute("entity");
        this.operationName = eca.getAttribute("operation");
        this.eventName = eca.getAttribute("event");
        this.runOnError = "true".equals(eca.getAttribute("run-on-error"));
        ArrayList<EntityEcaCondition> conditions = new ArrayList<EntityEcaCondition>();
        ArrayList<Object> actionsAndSets = new ArrayList<Object>();
        for (Element element: UtilXml.childElementList(eca)) {
            if ("condition".equals(element.getNodeName())) {
                conditions.add(new EntityEcaCondition(element, true));
            } else if ("condition-field".equals(element.getNodeName())) {
                conditions.add(new EntityEcaCondition(element, false));
            } else if ("action".equals(element.getNodeName())) {
                actionsAndSets.add(new EntityEcaAction(element));
            } else if ("set".equals(element.getNodeName())) {
                actionsAndSets.add(new EntityEcaSetField(element));
            } else {
                Debug.logWarning("Invalid eca child element " + element.getNodeName(), module);
            }
        }
        conditions.trimToSize();
        this.conditions = Collections.unmodifiableList(conditions);
        actionsAndSets.trimToSize();
        this.actionsAndSets = Collections.unmodifiableList(actionsAndSets);
        if (Debug.verboseOn()) {
            Debug.logVerbose("Conditions: " + conditions, module);
            Debug.logVerbose("actions and sets (intermixed): " + actionsAndSets, module);
        }
    }

    public String getEntityName() {
        return this.entityName;
    }

    public String getOperationName() {
        return this.operationName;
    }

    public String getEventName() {
        return this.eventName;
    }

    public boolean getRunOnError() {
        return this.runOnError;
    }

    public List<Object> getActionsAndSets() {
        return this.actionsAndSets;
    }

    public List<EntityEcaCondition> getConditions() {
        return this.conditions;
    }

    public void eval(String currentOperation, DispatchContext dctx, GenericEntity value, boolean isError, Set<String> actionsRun) throws GenericEntityException {
        if (!enabled) {
            Debug.logInfo("Entity ECA [" + this.entityName + "] on [" + this.eventName + "] is disabled; not running.", module);
            return;
        }

        //Debug.logInfo("eval eeca rule: operation=" + currentOperation + ", in event=" + this.eventName + ", on entity=" + this.entityName + ", for value=" + value, module);
        if (isError && !this.runOnError) {
            return;
        }

        if (!"any".equals(this.operationName) && this.operationName.indexOf(currentOperation) == -1) {
            return;
        }

        Map<String, Object> context = new HashMap<String, Object>();
        context.putAll(value);

        boolean allCondTrue = true;
        for (EntityEcaCondition ec: conditions) {
            if (!ec.eval(dctx, value)) {
                allCondTrue = false;
                break;
            }
        }

        if (allCondTrue) {
            for (Object actionOrSet: actionsAndSets) {
                if (actionOrSet instanceof EntityEcaAction) {
                    EntityEcaAction ea = (EntityEcaAction) actionOrSet;
                    // in order to enable OR logic without multiple calls to the given service,
                    //only execute a given service name once per service call phase
                    if (actionsRun.add(ea.getServiceName())) {
                        if (Debug.infoOn()) {
                            Debug.logInfo("Running Entity ECA Service: " + ea.getServiceName() + ", triggered by rule on Entity: " + value.getEntityName(), module);
                        }
                        ea.runAction(dctx, context, value);
                    }
                } else {
                    EntityEcaSetField sf = (EntityEcaSetField) actionOrSet;
                    sf.eval(context);
                }
            }
        }
    }

    /**
     * @deprecated Not thread-safe, no replacement.
     * @param enabled
     */
    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public boolean isEnabled() {
        return this.enabled;
    }
}
