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
package org.ofbiz.humanres;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javolution.util.FastMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityQuery;

public class HumanResEvents {
    public static final String module = HumanResEvents.class.getName();
    public static final String resourceError = "ProductErrorUiLabels";
    
    // Please note : the structure of map in this function is according to the JSON data map of the jsTree
    @SuppressWarnings("unchecked")
    public static String getChildHRCategoryTree(HttpServletRequest request, HttpServletResponse response){
        Delegator delegator = (Delegator) request.getAttribute("delegator");
        String partyId = request.getParameter("partyId");
        String onclickFunction = request.getParameter("onclickFunction");
        String additionParam = request.getParameter("additionParam");
        String hrefString = request.getParameter("hrefString");
        String hrefString2 = request.getParameter("hrefString2");
        
        List categoryList = new ArrayList();
        List<GenericValue> childOfComs;
        //check employee position
        try {
            long emplPosCount = EntityQuery.use(delegator).from("EmplPosition")
                    .where("emplPositionId", partyId).queryCount();
            if (emplPosCount > 0) {
                String emplId = partyId;
                List<GenericValue> emlpfillCtxs = EntityQuery.use(delegator).from("EmplPositionFulfillment")
                        .where("emplPositionId", emplId)
                        .filterByDate().queryList();
                if (UtilValidate.isNotEmpty(emlpfillCtxs)) {
                    for (GenericValue emlpfillCtx : emlpfillCtxs ) {
                        String memberId = emlpfillCtx.getString("partyId");
                        GenericValue memCtx = EntityQuery.use(delegator).from("Person").where("partyId", partyId).queryOne();
                        String title = null;
                        if (memCtx != null) {
                            String firstname = memCtx.getString("firstName");
                            String lastname = memCtx.getString("lastName");
                            if (UtilValidate.isEmpty(lastname)) {
                                lastname = "";
                            }
                            if (UtilValidate.isEmpty(firstname)) {
                                firstname = "";
                            }
                            title = firstname +" "+ lastname;
                        }
                        GenericValue memGroupCtx = EntityQuery.use(delegator).from("PartyGroup").where("partyId", partyId).queryOne();
                        if (memGroupCtx != null) {
                            title = memGroupCtx.getString("groupName");
                        }
                        
                        Map josonMap = FastMap.newInstance();
                        Map dataMap = FastMap.newInstance();
                        Map dataAttrMap = FastMap.newInstance();
                        Map attrMap = FastMap.newInstance();
                        
                        dataAttrMap.put("onClick", onclickFunction + "('" + memberId + additionParam + "')");
                        
                        String hrefStr = hrefString + memberId;
                        if (UtilValidate.isNotEmpty(hrefString2)) {
                            hrefStr = hrefStr + hrefString2;
                        }
                        dataAttrMap.put("href", hrefStr);
                        attrMap.put("rel", "P");
                        dataMap.put("attr", dataAttrMap);
                        attrMap.put("id", memberId);
                        josonMap.put("attr",attrMap);
                        dataMap.put("title", title);
                        josonMap.put("data", dataMap);
                        
                        categoryList.add(josonMap);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
        
        try {
            GenericValue partyGroup = EntityQuery.use(delegator).from("PartyGroup").where("partyId", partyId).queryOne();
            if (UtilValidate.isNotEmpty(partyGroup)) {
                childOfComs = EntityQuery.use(delegator).from("PartyRelationship")
                        .where("partyIdFrom", partyGroup.get("partyId"), 
                                "partyRelationshipTypeId", "GROUP_ROLLUP")
                        .filterByDate().queryList();
                if (UtilValidate.isNotEmpty(childOfComs)) {
                    
                    for (GenericValue childOfCom : childOfComs ) {
                        Object catId = null;
                        String catNameField = null;
                        String title = null;
                        
                        Map josonMap = FastMap.newInstance();
                        Map dataMap = FastMap.newInstance();
                        Map dataAttrMap = FastMap.newInstance();
                        Map attrMap = FastMap.newInstance();
                        
                        catId = childOfCom.get("partyIdTo");
                        
                        //Department or Sub department
                        GenericValue childContext = EntityQuery.use(delegator).from("PartyGroup").where("partyId", catId).queryOne();
                        if (UtilValidate.isNotEmpty(childContext)) {
                            catNameField = (String) childContext.get("groupName");
                            title = catNameField;
                            josonMap.put("title",title);
                            
                        }
                        //Check child existing
                        List<GenericValue> childOfSubComs = EntityQuery.use(delegator).from("PartyRelationship")
                                .where("partyIdFrom", catId, 
                                        "partyRelationshipTypeId", "GROUP_ROLLUP")
                                .filterByDate().queryList();
                        //check employee position
                        List<GenericValue> isPosition = EntityQuery.use(delegator).from("EmplPosition").where("partyId", catId).queryList();
                        if (UtilValidate.isNotEmpty(childOfSubComs) || UtilValidate.isNotEmpty(isPosition)) {
                            josonMap.put("state", "closed");
                        }
                        
                        //Employee
                        GenericValue emContext = EntityQuery.use(delegator).from("Person").where("partyId", catId).queryOne();
                        if (UtilValidate.isNotEmpty(emContext)) {
                            String firstname = (String) emContext.get("firstName");
                            String lastname = (String) emContext.get("lastName");
                            if (UtilValidate.isEmpty(lastname)) {
                                lastname = "";
                            }
                            if (UtilValidate.isEmpty(firstname)) {
                                firstname = "";
                            }
                            title = firstname +" "+ lastname;
                        }
                        
                        dataAttrMap.put("onClick", onclickFunction + "('" + catId + additionParam + "')");
                        
                        String hrefStr = hrefString + catId;
                        if (UtilValidate.isNotEmpty(hrefString2)) {
                            hrefStr = hrefStr + hrefString2;
                        }
                        dataAttrMap.put("href", hrefStr);
                        
                        dataMap.put("attr", dataAttrMap);
                        
                        attrMap.put("rel", "Y");
                        attrMap.put("id", catId);
                        josonMap.put("attr",attrMap);
                        dataMap.put("title", title);
                        josonMap.put("data", dataMap);
                        
                        categoryList.add(josonMap);
                }
                    
                }

                List<GenericValue> isEmpls = null;
                try {
                    isEmpls = EntityQuery.use(delegator).from("EmplPosition")
                            .where(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, partyId),
                                    EntityCondition.makeCondition("statusId", EntityOperator.NOT_EQUAL, "EMPL_POS_INACTIVE"))
                            .filterByDate("actualFromDate", "actualThruDate")
                            .queryList();
                } catch (GenericEntityException e) {
                    Debug.logError(e, module);
                }

                if (UtilValidate.isNotEmpty(isEmpls)) {
                    for (GenericValue childOfEmpl : isEmpls ) {
                        Map emplMap = FastMap.newInstance();
                        Map emplAttrMap = FastMap.newInstance();
                        Map empldataMap = FastMap.newInstance();
                        Map emplDataAttrMap = FastMap.newInstance();
                        
                        String emplId = (String) childOfEmpl.get("emplPositionId");
                        String typeId = (String) childOfEmpl.get("emplPositionTypeId");
                        //check child
                        List<GenericValue> emlpfCtxs = EntityQuery.use(delegator).from("EmplPositionFulfillment")
                                .where("emplPositionId", emplId)
                                .filterByDate().queryList();
                        if (UtilValidate.isNotEmpty(emlpfCtxs)) {
                            emplMap.put("state", "closed");
                        }
                        
                        GenericValue emplContext = EntityQuery.use(delegator).from("EmplPositionType").where("emplPositionTypeId", typeId).queryOne();
                        String title = null;
                        if (UtilValidate.isNotEmpty(emplContext)) {
                            title = (String) emplContext.get("description") + " " +"["+ emplId +"]";
                        }
                        String hrefStr = "emplPositionView?emplPositionId=" + emplId;
                        empldataMap.put("title", title);
                        emplAttrMap.put("href", hrefStr);
                        emplAttrMap.put("onClick", "callEmplDocument" + "('" + emplId + "')");
                        empldataMap.put("attr", emplAttrMap);
                        emplMap.put("data", empldataMap);
                        emplDataAttrMap.put("id", emplId);
                        emplDataAttrMap.put("rel", "N");
                        emplMap.put("attr",emplDataAttrMap);
                        emplMap.put("title",title);
                        categoryList.add(emplMap);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
        request.setAttribute("hrTree", categoryList);
        return "success";
    }
}
