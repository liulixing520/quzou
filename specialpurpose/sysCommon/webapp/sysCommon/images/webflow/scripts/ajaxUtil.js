var XMLHttpReq;
function createXMLHttpRequest() {
	if (window.XMLHttpRequest) {
		XMLHttpReq = new XMLHttpRequest();
	} else {
		if (window.ActiveXObject) {
			XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
}
function submitdata(packageId, packageVersion, processId, processVersion,sourceReferenceId) {
	createXMLHttpRequest();
	var par = "packageId=" + packageId + "&packageVersion=" + packageVersion + "&processId=" + processId + "&processVersion=" + processVersion+ "&sourceReferenceId=" + sourceReferenceId;
	var url = "getActivityAndLineData?" + par;
	XMLHttpReq.open("post", url, false);
	XMLHttpReq.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	XMLHttpReq.onreadystatechange = processResponse;
	XMLHttpReq.send(null);
}
function disYewu(sourceReferenceId,idd,x,y) {
	createXMLHttpRequest();
	var url = "getYewu?sourceReferenceId=" + sourceReferenceId+"&activityId="+idd;
	XMLHttpReq.open("post", url, false);
	XMLHttpReq.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	XMLHttpReq.onreadystatechange = processResponse1;
	XMLHttpReq.send(null);
}
function processResponse() {
	if (XMLHttpReq.readyState == 4) {
		if (XMLHttpReq.status == 200) {
			parseXML(XMLHttpReq);
		}
	}
}
function parseXML(originalRequest) {
	var activities = new Array();		//保存所有活动对象。
	var connectors = new Array();		//保存所有连线对象。
	var xmlDom = originalRequest.responseXML;
	var rootNode = xmlDom.documentElement;
	var activityIds = "";
	var objectNames = "";
	var activityTypes = "";
	var activityDepicts = "";
	var transitionIds = "";
	var transitionNames = "";
	var fromActivityIds = "";
	var toActivityIds = "";
	if (rootNode == null) {
		return false;
	} else {
		var comments = rootNode.getElementsByTagName("comment");
		for (var i = 0; i < comments.length; i++) {
			var activityId = comments.item(i).getElementsByTagName("activityId").item(0).firstChild.nodeValue;
			activityIds += activityId + ",";
			var objectName = comments.item(i).getElementsByTagName("objectName").item(0).firstChild.nodeValue;
			objectNames += objectName + ",";
			var activityType = comments.item(i).getElementsByTagName("activityType").item(0).firstChild.nodeValue;
			activityTypes += activityType + ",";
			var activityDepict = comments.item(i).getElementsByTagName("activityDepict").item(0).firstChild.nodeValue;
			activityDepicts += activityDepict + ",";
		}
		var lines = rootNode.getElementsByTagName("line");
		for (var i = 0; i < lines.length; i++) {
			var transitionId = lines.item(i).getElementsByTagName("transitionId").item(0).firstChild.nodeValue;
			transitionIds += transitionId+",";
			var transitionName=lines.item(i).getElementsByTagName('transitionName').item(0).firstChild.nodeValue;
			transitionNames += transitionName+",";
			var fromActivityId=lines.item(i).getElementsByTagName('fromActivityId').item(0).firstChild.nodeValue;
			fromActivityIds += fromActivityId+",";
			var toActivityId=lines.item(i).getElementsByTagName('toActivityId').item(0).firstChild.nodeValue;
			toActivityIds += toActivityId+",";
		}
		window.document.getElementById("activityIds").value = activityIds.substring(0, activityIds.length - 1);
		window.document.getElementById("objectNames").value = objectNames.substring(0, objectNames.length - 1);
		window.document.getElementById("activityTypes").value = activityTypes.substring(0, activityTypes.length - 1);
		window.document.getElementById("activityDepicts").value = activityDepicts.substring(0, activityDepicts.length - 1);
		window.document.getElementById("transitionIds").value = transitionIds.substring(0, transitionIds.length - 1);
		window.document.getElementById("transitionNames").value = transitionNames.substring(0, transitionNames.length - 1);
		window.document.getElementById("fromActivityIds").value = fromActivityIds.substring(0, fromActivityIds.length - 1);
		window.document.getElementById("toActivityIds").value = toActivityIds.substring(0, toActivityIds.length - 1);
	}
}

