/*
* 名称：EventInterface.js
* 功能：工作流管理系统可视化工具中事件处理接口对象的构造。
* 最后修改时间：
* 修改历史：
*/

 //============================================================
function EventInterface() {

	/**---------------------------事件[NewProcessEvent]定义开始：------------------
	* 事件名称：NewProcessEvent
	* 事件触发时机：当新生成一个流程拓扑图时，触发本事件。
	* 简要描述：默认会自动加裁一个开始活动和一个结束活动。
	* 事件参数：
	*		theStartNodeID:默认自动加裁的开始活动的ID号。
	*		theStartNodeName:默认自动加裁的开始活动的名称。
	*		theEndNodeID:默认自动加裁的结束活动的ID号。
	*		theEndNodeName:默认自动加裁的结束活动的名称。
	*/
	this.NewProcessEvent=function(theStartNodeID,theStartNodeName,theEndNodeID,theEndNodeName){
		//alert("theStartNodeID="+theStartNodeID+";theStartNodeName="+theStartNodeName+";theEndNodeID="+theEndNodeID+";theEndNodeName="+theEndNodeName);
		//请在以下添加事件处理程序代码：

	}
	//---------------------------事件[NewProcessEvent]定义结束。------------------
	
	/**---------------------------事件[AddActivityEvent]定义开始：------------------
	* 事件名称：AddActivityEvent
	* 事件触发时机：当用户在画板上增加一个活动时，触发本事件。
	* 简要描述：活到类型分为：	ManualActivity[人工活动]、
	*							AutoActivity[自动活动]、
	*							RouterActivity[路由活动]、
	*							SubActivity[子流程]、
	*							StartActivity[开始活动]以及
	*							EndActivity[结束响动]。
	* 事件参数：
	*		theActivityNodeType:新增加活动的类型。
	*		theActivityNodeID:新增加活动的ID号。
	*		theActivityNodeName:新增加活动的名称。
	*/
	this.AddActivityEvent=function(theActivityNodeType,theActivityNodeID,theActivityNodeName){
		//alert("theActivityNodeType="+theActivityNodeType+";theActivityNodeID="+theActivityNodeID+";theActivityNodeName="+theActivityNodeName);
		//请在以下添加事件处理程序代码：
		var submitURL = window.location.protocol+"//"+window.location.host + "/webflow/webflow_base/scripts/hiddensubmit.jsp";
		
		var requestData = "bizAction=";
		var oReq = null;
		try { oReq=new ActiveXObject('MSXML2.XMLHTTP'); } catch(e){}
		try {
			oReq.open("POST", submitURL, false);
			oReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			oReq.send(requestData);
		} 
		catch (e) {
			alert("隐含请求调用失败！");
			return true;
		}
		//alert("responseText="+oReq.responseText);

	}
	//---------------------------事件[AddActivityEvent]定义结束。------------------

	/**---------------------------事件[DelActivityEvent]定义开始：------------------
	* 事件名称：DelActivityEvent
	* 事件触发时机：当用户在画板上删除一个活动时，触发本事件。
	* 简要描述：活到类型分为：	ManualActivity[人工活动]、
	*							AutoActivity[自动活动]、
	*							RouterActivity[路由活动]、
	*							SubActivity[子流程]、
	*							StartActivity[开始活动]以及
	*							EndActivity[结束响动]。
	* 事件参数：
	*		theActivityNodeType:所删除活动的类型。
	*		theActivityNodeID:所删除活动的ID号。
	*		theActivityNodeName:所删除活动的名称。
	*/
	this.DelActivityEvent=function(theActivityNodeType,theActivityNodeID,theActivityNodeName){
		//alert("theActivityNodeType="+theActivityNodeType+";theActivityNodeID="+theActivityNodeID+";theActivityNodeName="+theActivityNodeName);
		//请在以下添加事件处理程序代码：		
		window.document.delActivityForm.activityId.value = theActivityNodeID;
		window.deleActivityInfo();
	}
	//---------------------------事件[DelActivityEvent]定义结束。------------------
	
	/**---------------------------事件[AddLineEvent]定义开始：------------------
	* 事件名称：AddLineEvent
	* 事件触发时机：当用户在画板上增加一条连线时，触发本事件。
	* 简要描述：
	* 事件参数：
	*		theLineNodeID: 新增加连线的ID号。
	*		theLineNodeName: 新增加连线的名称。
	*		theFromNodeID: 新增加连线的起始活动ID号。
	*		theFromNodeName: 新增加连线的起始活动名称。
	*		theToNodeID: 新增加连线的结束活动ID号。
	*		theToNodeName: 新增加连线的结束活动名称。
	*/
	this.AddLineEvent=function(theLineNodeID,theLineNodeName,theFromNodeID,theFromNodeName,theToNodeID,theToNodeName){
		//alert("theLineNodeID="+theLineNodeID+";theLineNodeName="+theLineNodeName+";theFromNodeID="+theFromNodeID+";theFromNodeName="+theFromNodeName+";theToNodeID="+theToNodeID+";theToNodeName="+theToNodeName);
		//请在以下添加事件处理程序代码：		
		window.document.getElementById("theFromNodeID").value = theFromNodeID;
		window.document.getElementById("theToNodeID").value = theToNodeID;
//		window.addLineInfo();
//		window.setLineProperty();

	}
	//---------------------------事件[AddLineEvent]定义结束。------------------
	
	/**---------------------------事件[DelLineEvent]定义开始：------------------
	* 事件名称：DelLineEvent
	* 事件触发时机：当用户在画板上删除一条连线时，触发本事件。
	* 简要描述：
	* 事件参数：
	*		theLineNodeID: 所删除连线的ID号。
	*		theLineNodeName: 所删除连线的名称。
	*		theFromNodeID: 所删除连线的起始活动ID号。
	*		theFromNodeName: 所删除连线的起始活动名称。
	*		theToNodeID: 所删除连线的结束活动ID号。
	*		theToNodeName: 所删除连线的结束活动名称。
	*/
	this.DelLineEvent=function(theLineNodeID,theLineNodeName,theFromNodeID,theFromNodeName,theToNodeID,theToNodeName){
		//alert("theLineNodeID="+theLineNodeID+";theLineNodeName="+theLineNodeName+";theFromNodeID="+theFromNodeID+";theFromNodeName="+theFromNodeName+";theToNodeID="+theToNodeID+";theToNodeName="+theToNodeName);
		//请在以下添加事件处理程序代码：
		window.document.delLineForm.lineInfoId.value = theLineNodeID;
		window.deleLineInfo();		

	}
	//---------------------------事件[DelLineEvent]定义结束。------------------


	//

}
//===================================================================================================