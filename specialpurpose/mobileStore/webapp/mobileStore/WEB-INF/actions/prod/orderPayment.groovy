orderIdList = session.getAttribute("orderIdList");
orderIdStr = ''
def orderList=[];
if(orderIdList && orderIdList.size()>0){
	orderIdList.each{orderId ->
		orderIdStr += (orderId+" ")
		c=delegator.findOne("OrderHeader", [orderId : orderId], false);
		orderList.add(c);
	}
}else{
	orderId = session.getAttribute("orderId");
	if(orderId){
		orderIdStr += (orderId+" ")
		c=delegator.findOne("OrderHeader", [orderId : orderId], false);
		orderList.add(c);
	}
}
context.orderList = orderList
context.orderIdStr = orderIdStr