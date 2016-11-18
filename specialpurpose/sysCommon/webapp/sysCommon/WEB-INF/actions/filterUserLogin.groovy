/*
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
 */

import org.ofbiz.entity.*
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.model.DynamicViewEntity
import org.ofbiz.entity.model.ModelKeyMap
import org.ofbiz.entity.transaction.*
import org.ofbiz.entity.util.EntityFindOptions
import org.ofbiz.entity.util.EntityListIterator


groupId = parameters.groupId;



permissionUserLoginView = new DynamicViewEntity();
permissionUserLoginView.addMemberEntity("UG", "UserLoginSecurityGroup");
permissionUserLoginView.addAliasAll("UG", null);


EntityListIterator permissionUserLoginEli = null;
beganTransaction = false;
List inventoryItems = null;
if (andCondition.size() > 1) {
    try {
        // get the indexes for the partial list
        lowIndex = ((viewIndex * viewSize) + 1);
        highIndex = (viewIndex - 1) * viewSize;

        findOpts = new EntityFindOptions(true, EntityFindOptions.TYPE_SCROLL_INSENSITIVE, EntityFindOptions.CONCUR_READ_ONLY, true);
        findOpts.setMaxRows(highIndex);
        beganTransaction = TransactionUtil.begin();
        permissionUserLoginEli = delegator.findListIteratorByCondition(inventoryItemAndLabelsView, EntityCondition.makeCondition(andCondition, EntityOperator.AND), null, null, null, findOpts);

        inventoryItemsSize = permissionUserLoginEli.getResultsSizeAfterPartialList();
        context.inventoryItemsSize = inventoryItemsSize;
        if (highIndex > inventoryItemsSize) {
            highIndex = inventoryItemsSize;
        }

        // get the partial list for this page
        permissionUserLoginEli.beforeFirst();
        if (inventoryItemsSize > 0) {
            inventoryItems = permissionUserLoginEli.getPartialList(lowIndex, viewSize);
        } else {
            inventoryItems = [] as ArrayList;
        }

        // close the list iterator
        inventoryItemsEli.close();
    } catch (GenericEntityException e) {
        errMsg = "Failure in operation, rolling back transaction";
        Debug.logError(e, errMsg, "findInventoryItemsByLabels");
        try {
            // only rollback the transaction if we started one...
            TransactionUtil.rollback(beganTransaction, errMsg, e);
        } catch (GenericEntityException e2) {
            Debug.logError(e2, "Could not rollback transaction: " + e2.toString(), "findInventoryItemsByLabels");
        }
        // after rolling back, rethrow the exception
        throw e;
    } finally {
        // only commit the transaction if we started one... this will throw an exception if it fails
        TransactionUtil.commit(beganTransaction);
    }
}
context.inventoryItems = inventoryItems;
