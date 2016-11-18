
import org.ofbiz.order.shoppinglist.FavoriteListEvents;


shoppingListId = FavoriteListEvents.getFavoriteListId(request)

inputFields =[shoppingListId : shoppingListId];

context.inputFields = inputFields;

pfInput = [entityName:"ShoppingListItem",inputFields:inputFields];

pfResult = dispatcher.runSync("performFindList",pfInput);

//pfResult = delegator.findByAnd("ShoppingListItem", inputFields, null, false);

pfResultList = pfResult.list;
context.shoppingListItems = pfResultList;


