

inputFields =[partyId : userLogin.partyId,shoppingListTypeId:"SLT_WISH_LIST_PS",listName:"MyFavoriteListPs"];

/*context.inputFields = inputFields;

pfInput = [entityName:"ShoppingList",inputFields:inputFields];

pfResult = dispatcher.runSync("performFindList",pfInput);

pfResultList = pfResult.list;
context.shoppingLists = pfResultList;*/


prssList = delegator.findByAnd("ShoppingListView", inputFields, null, false);
if(prssList){
	context.prssList=prssList;
}
println "===========777=7==========="+context.prssList;



