<html   xmlns:v="http://www.work.com/"> 
<title>工作流查看</title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link rel="stylesheet" href="/sysCommon/images/webflow/styles/style.css" type="text/css" />
<link rel="stylesheet" href="/sysCommon/images/webflow/styles/tab.css" type="text/css" />
<SCRIPT language="JavaScript" src="/sysCommon/images/webflow/scripts/show2d.js" type="text/javascript"></SCRIPT>
<SCRIPT language="JavaScript" src="/sysCommon/images/webflow/scripts/TopologyObject.js" type="text/javascript"></SCRIPT>
<SCRIPT language="JavaScript" src="/sysCommon/images/webflow/scripts/EventInterface.js" type="text/javascript"></SCRIPT>
<SCRIPT language="JavaScript" src="/sysCommon/images/webflow/scripts/ajaxUtil.js" type="text/javascript"></SCRIPT>

<style   type="text/css">   
  	v\:* {behavior:url(#default#VML);}
</style> 

<script>
function imgdragstart(){return false;}
for(i in document.images)document.images[i].ondragstart=imgdragstart;

	//为全局变量，定义工作流是否处于监控状态[true/false]:--------------------------------
	var MonitorProcess = false;
	var drawLineStatus = false;			//全局变量
	//为全局变量，定义当前工作流定义中处于正在处理状态[running]的活动集合：
	var AllWorkingActivities=new Array();
	var currentTopologyObject=null;		//全局变量,当前流程的拓扑对象。
	var LoadProcessFlag=false;			//全局变量,从数据库装入流程定义时，为true;新建流程时，为false。
	//定义画板上工具栏各项目：
	//move-line-manual-auto-route-subprocess
	var ActionType="move";
	/*
	是否创建新版本标记，当newVersion为false时不创建新版本，当为true时创建新版本
	*/
	var newVersion = false;
	//---------------------------------------------------------------------------------

    
</script>


<BODY  ondblclick="doubleClickProcess()" style="margin-left:0px;margin-right:0px;margin-top:0px;margin-bottom:0px;">

<#assign workflowUiDesign=requestAttributes.workflowUiDesign?if_exists>
<form name="frm">
		<!--用于保存从数据中查出来的模板定义文件-->
		<TEXTAREA ID=FlowXmlObject STYLE="display:none">定义工作流</TEXTAREA>
		<input type="Hidden" name="ext_xmlversion" value ="">
		
		<input type="hidden" name="activityIds" id="activityIds" value="" />
		
		<input type="hidden" name="activityStates" id="activityStates" value="" />
		
		<input type="hidden" name="objectNames" id="objectNames" value="" />
		<input type="hidden" name="activityTypes" id="activityTypes" value="" />
		<input type="hidden" name="activityDepicts" id="activityDepicts" value="" />
		
		<input type="hidden" name="transitionIds" id="transitionIds" value="" />
		<input type="hidden" name="transitionNames" id="transitionNames" value="" />
		<input type="hidden" name="fromActivityIds" id="fromActivityIds" value="" />
		<input type="hidden" name="toActivityIds" id="toActivityIds" value="" />
		<input type="hidden" name="theFromNodeID" value=""/>
		<input type="hidden" name="theToNodeID" value=""/>
		
		<div id="disYewuDiv" align="center"  style="position:absolute; display:none; height:100; width:150; background-color:#C4D3F0; visibility:show; left:235px; top:50px; z-index:2; border-top-width:3pt; border-right-width:2pt; border-style:solid;"></div>
	</form>
	
</BODY>
</html>

<script language="JavaScript" type="text/javascript">
	//document.body.style.cursor='hand';
	//每个版本对应一个processDefID
	var processDefID = "${haveData!}";
	currentTopologyObject=new TopologyObject(); 
	//alert(document.getElementById("FlowXmlObject").value);
		//全局变量,当前流程的拓扑对象。
	//通过是否存在工作流定义模板的主键，来决定是新增还是修改，如果主键不为空，那么就是修改，否则为新增
		currentTopologyObject.loadFromDB(document.getElementById("FlowXmlObject").value);
	//---------------------------------------------------------------------------------------------

	/**--------------generateActivityIcon()定义开始：-----------------------
	* 名称：generateActivityIcon
	* 功能：在工作流设计器中产生活动图元。
	* 参数：
	*     1. type:活动图元的类型。
	*     2. x:活动图元的横坐标位置。
	*     3. y:活动图元的纵坐标位置。
	*     4. activityName:活动图元的显示名称。
	* 传回：
	* 备注：
	*/
	function generateActivityIcon(type, x, y,activityName)
	{
		var len = AllIconsArray.length;
		//创建新的图元
		AllIconsArray[len] = new IconObject();
		//当拖动图元的时候需要产生新版本
		newVersion=true;
		//初始化图元
		AllIconsArray[len].init(type, x-20, y-20,activityName);
		//在schema中添加state节点
		currentTopologyObject.create_state(AllIconsArray[len]);
	}
	//--------------generateActivityIcon()定义结束。-----------------------

	/**--------------openDefaultWF()定义开始：-----------------------
	* 名称：openDefaultWF  
	* 功能：自动生成工作流的拓扑定义文件，并在设计器中呈现。
	* 完成修改日期：2009-01-14， 修改人：
	* 修订原因：为了支持新需求，即：根据JaWE生成的流程定义数据，由图形库自动生成默认的工作流拓扑图。
	* 参数：
	* 传回：
	* 备注：
	*/
	function openDefaultWF() {
		LoadProcessFlag=true;	//全局变量,从数据库装入流程定义时，为true;新建流程时，为false。
		var activities=new Array();		//保存所有活动对象。
		var connectors=new Array();		//保存所有连线对象。
		//给所有活动对象赋值：
		/**--------------ActObject()定义开始：-----------------------
		* 名称：ActObject
		* 功能：定义活动对象。
		* 参数：
		*     1. theId:活动对象的标识号。
		*	  2. theDisplayName:活动对象的显示名称。
		*	  3. theType:活动对象的类型。
		*	  4. theTips:活动对象的提示信息。
		* 传回：无。
		* 备注：
		* function ActObject(theId,theDisplayName,theType,theTips){} */
		//--------------ActObject()定义结束。----------------------------
		activities.push(new ActObject("activity.2","开始","StartActivity","这是流程的开始活动。"));
		activities.push(new ActObject("activity.3","结束","EndActivity","这是流程的结束活动。"));
		activities.push(new ActObject("activity.4","人工活动","ManualActivity","活动的提示信息。"));
		activities.push(new ActObject("activity.5","自动活动","AutoActivity","活动的提示信息。"));
		activities.push(new ActObject("activity.6","路由活动","RouterActivity","活动的提示信息。"));
		//给所有连线对象赋值：
		/**--------------ConObject()定义开始：-----------------------
		* 名称：ConObject
		* 功能：定义连接对象。
		* 参数：
		*     1. theId:连接对象的标识号。
		*	  2. theDisplayName:连接对象的显示名称。
		*	  3. theFrom:连接对象的起始活动标识号。
		*	  4. theTo:连接对象的终止活动标识号。
		* 传回：无。
		* 备注：
		* function ConObject(theId,theDisplayName,theFrom,theTo){}*/
		//--------------ConObject()定义结束。-----------------------
		connectors.push(new ConObject("trans.1","连线","activity.2","activity.4"));
		connectors.push(new ConObject("trans.2","连线","activity.4","activity.6"));
		connectors.push(new ConObject("trans.3","连线","activity.6","activity.3"));
		connectors.push(new ConObject("trans.4","连线","activity.2","activity.5"));
		connectors.push(new ConObject("trans.5","连线","activity.5","activity.6"));
		connectors.push(new ConObject("trans.6","连线","activity.6","activity.4"));
		//调用方法，用于生成默认的拓扑图：
		currentTopologyObject=null;		//全局变量,当前流程的拓扑对象。
		currentTopologyObject=new TopologyObject(); 	//全局变量,当前流程的拓扑对象。
		currentTopologyObject.generateDefaultSchema(activities,connectors);
		LoadProcessFlag=false;
	}
	//--------------openDefaultWF()定义结束。-----------------------

	/**--------------openDefaultWF2()定义开始：-----------------------
	* 名称：openDefaultWF2
	* 功能：自动生成工作流的拓扑定义文件，并在设计器中呈现。
	* 完成修改日期：2009-01-14， 修改人：
	* 修订原因：为了支持新需求，即：根据JaWE生成的流程定义数据，由图形库自动生成默认的工作流拓扑图。
	* 参数：
	* 传回：
	* 备注：
	*/
	function openDefaultWF2() {
		LoadProcessFlag=true;	//全局变量,从数据库装入流程定义时，为true;新建流程时，为false。
		var packageId = "${packageId!}";
		var packageVersion = "${packageVersion!}";
		var processId = "${processId!}";
		var processVersion = "${processVersion!}";
		//add by 
		var	yewuId="${yewuId!}";
		submitdata(packageId,packageVersion,processId,processVersion,yewuId);
		var activities=new Array();		
		var connectors=new Array();		
		var activityIds = frm.activityIds.value;
		
		var activityStates=frm.activityStates.value;
	   
		var objectNames = frm.objectNames.value;
		var activityTypes = frm.activityTypes.value;
		var activityDepicts = frm.activityDepicts.value;
		
		var activityIdArray = null;
		
		var activityStateArray = null;
		
		var objectNameArray = null;
		var activityTypeArray = null;
		var activityDepictArray = null;
		if(activityIds.length!=0&&activityStates.length!=0&&objectNames.length!=0&&activityTypes.length!=0&&activityDepicts.length){
			activityIdArray = activityIds.split(",");
			
			activityStateArray= activityStates.split(",");
			
			objectNameArray = objectNames.split(",");
			activityTypeArray = activityTypes.split(",");
			activityDepictArray = activityDepicts.split(",");
			for(var i=0; i<=activityIdArray.length-1; i++){
			//给所有活动对象赋值：
			/**--------------ActObject()定义开始：-----------------------
			* 名称：ActObject
			* 功能：定义活动对象。
			* 参数：
			*     1. theId:活动对象的标识号。
			*	  2. theDisplayName:活动对象的显示名称。
			*	  3. theType:活动对象的类型。
			*	  4. theTips:活动对象的提示信息。
			* 传回：无。
			* 备注：
			* function ActObject(theId,theDisplayName,theType,theTips){} */
			//--------------ActObject()定义结束。----------------------------
			
				activities.push(new ActObjectView(activityIdArray[i],activityStateArray[i],objectNameArray[i],activityTypeArray[i],activityDepictArray[i]));
			}
		}
		
		var transitionIds = frm.transitionIds.value;
		var transitionNames = frm.transitionNames.value;
		var fromActivityIds = frm.fromActivityIds.value;
		var toActivityIds = frm.toActivityIds.value;
		var transitionIdArray = null;
		var transitionNameArray = null;
		var fromActivityIdArray = null;
		var toActivityIdArray = null;
		if(transitionIds.length!=0&&transitionNames.length!=0&&fromActivityIds.length!=0&&toActivityIds.length!=0){			
			transitionIdArray = transitionIds.split(",");
			transitionNameArray = transitionNames.split(",");
			fromActivityIdArray = fromActivityIds.split(",");
			toActivityIdArray = toActivityIds.split(",");
			for(var i=0; i<=transitionIdArray.length-1; i++){
				//给所有连线对象赋值：
				/**--------------ConObject()定义开始：-----------------------
				* 名称：ConObject
				* 功能：定义连接对象。
				* 参数：
				*     1. theId:连接对象的标识号。
				*	  2. theDisplayName:连接对象的显示名称。
				*	  3. theFrom:连接对象的起始活动标识号。
				*	  4. theTo:连接对象的终止活动标识号。
				* 传回：无。
				* 备注：
				* function ConObject(theId,theDisplayName,theFrom,theTo){}*/
				//--------------ConObject()定义结束。-----------------------
				connectors.push(new ConObject(transitionIdArray[i],transitionNameArray[i],fromActivityIdArray[i],toActivityIdArray[i]));
			}				
		}
		//调用方法，用于生成默认的拓扑图：
		currentTopologyObject=null;		//全局变量,当前流程的拓扑对象。
		currentTopologyObject=new TopologyObject(); 	//全局变量,当前流程的拓扑对象。
		currentTopologyObject.generateDefaultSchema(activities,connectors);
		LoadProcessFlag=false;
	
	}
	//--------------openDefaultWF2()定义结束。-----------------------

	/**--------------openWF()定义开始：-----------------------
	* 名称：openWF
	* 功能：从文件中打开工作流的拓扑定义文件，并在设计器中呈现。
	* 参数：
	* 传回：
	* 备注：
	*/
	function openWF() {
		LoadProcessFlag=true;	//全局变量,从数据库装入流程定义时，为true;新建流程时，为false。
		currentTopologyObject.load("D:\\testflow.xml");
		LoadProcessFlag=false;
	}
	//--------------openWF()定义结束。-----------------------
	
	/**--------------transformToSymbol()定义开始：-----------------------
	* 名称：transformToSymbol
	* 功能：替换指定字符串中的部分字符[即：将&lt;转换为<,将&gt;转换为>,将&quot转换为']。
	* 参数：str:所指定的字符串。
	* 传回：ret:替换之后的字符串。
	* 备注：
	*/
	function transformToSymbol(str){
		var ret = str.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,"'");
		return ret;
	}
	//--------------transformToSymbol()定义结束。-----------------------
	
	/**--------------newWF()定义开始：-----------------------
	* 名称：newWF
	* 功能：重置画板[相当于新建一个流程]。
	* 参数：
	* 传回：
	* 备注：
	*/
	function newWF() {
		currentTopologyObject.newSchema();
	}
	//--------------newWF()定义结束。-----------------------
	
	/**--------------saveWFtoFile()定义开始：-----------------------
	* 名称：saveWFtoFile
	* 功能：将流程定义写到本地文件。
	* 参数：
	* 传回：
	* 备注：
	*/
	function saveWFtoFile(){	
		currentTopologyObject.writeToString();
	}
	//--------------saveWFtoFile()定义结束。-----------------------

	/**--------------saveWF()定义开始：-----------------------
	* 名称：saveWF
	* 功能：向数据库中发布流程定义。
	* 参数：
	* 传回：
	* 备注：
	*/
	function saveWF(){
		/**-------getTopologyString()定义:--------------------
		* 名称：getTopologyString
		* 功能：获得当前工作流的拓扑信息。
		* 参数：
		* 传回：字符串形式的拓扑信息。
		* 备注：
		*/
		//请在以下填写后续程序代码：
		document.getElementById("xmlString").value = currentTopologyObject.getTopologyString();
		form1.submit();
	}
	//--------------saveWF()定义结束。-----------------------
	
	/**--------------updateWF()定义开始：-----------------------
	* 名称：updateWF
	* 功能：更新工作流定义到数据库。
	* 参数：
	* 传回：
	* 备注：
	*/
	function updateWF(){
		//
	}
	//--------------updateWF()定义结束。-----------------------
	
	/**--------------setIconProperty()定义开始：-----------------------
	* 名称：setIconProperty
	* 功能：产生设置工作流活动属性的对话框窗口。
	* 参数：
	* 传回：
	* 备注：
	*/
	function setIconProperty(){
		var activityInfo = ClickedIconObject.id;
		var URL = "/deploy/wf/setActivityProperty?packageId="+'${packageId!}'+"&packageVersion="+'${packageVersion!}'+"&processId="+'${processId!}'+"&processVersion="
		+'${processVersion!}'+"&activityInfo="+ClickedIconObject.id+"&";		
		//在右键单击活动时，将当时所有活动数组对象传给该变量，用于在活动的属性对话框中处理活动的ID：
		ClickedIconObject.tempAllIconsArray=null;
		ClickedIconObject.tempAllIconsArray=AllIconsArray;
		ClickedIconObject.getXmlString = this.getXmlString;
		window.showModalDialog(	URL,ClickedIconObject,"dialogWidth:540px;dialogHeight:500px;directories:yes;help:no;status:no;resizable:no;scrollbars:yes;");	
	}
	//--------------setIconProperty()定义结束。-----------------------


	/**--------------setProcessProperty()定义开始：-----------------------
	* 名称：setProcessProperty
	* 功能：产生设置流程属性的对话框窗口。
	* 参数：
	* 传回：
	* 备注：
	*/
	function setProcessProperty(){
		var URL = "webwf_process.do?processDefName="+processDefName;
		window.showModalDialog(	URL,currentTopologyObject,"dialogWidth:506px;dialogHeight:390px;directories:yes;help:no;status:no;resizable:no;scrollbars:yes;");	
	}
	//--------------setProcessProperty()定义结束。-----------------------

	/**--------------setLineProperty()定义开始：-----------------------
	* 名称：setLineProperty
	* 功能：产生设置连线属性的对话框窗口。
	* 参数：
	* 传回：
	* 备注：
	*/
	function setLineProperty(){
		//在右键单击连线时，将当时所有连线数组对象传给该变量，用于在连线的属性对话框中处理连线的ID：
		var theFromNodeID = window.document.getElementById("theFromNodeID").value;
		var theToNodeID = window.document.getElementById("theToNodeID").value;
		var URL = "/deploy/wf/setLineProperty?packageId="+'${packageId!}'+"&packageVersion="+'${packageVersion!}'+"&processId="
		+'${processId!}'+"&processVersion="+'${processVersion!}'+"&lineInfoId="+ClickedLineObject.lineID+"&theFromNodeID="+theFromNodeID+"&theToNodeID="+theToNodeID;		
		ClickedLineObject.tempAllLinesArray=null;
		ClickedLineObject.tempAllLinesArray=AllLinesArray;
		ClickedLineObject.getXmlString = this.getXmlString;
		window.showModalDialog(URL,ClickedLineObject,"dialogWidth:520px;dialogHeight:360px;directories:yes;help:no;status:no;resizable:no;scrollbars:yes;");
	}
	//--------------setLineProperty()定义结束。-----------------------
	//删除连接属性
	function deleLineInfo(){
		delLineForm.xmlString.value = getXmlString();
		delLineForm.submit();
	
	}
	//新增连接属性
	function addLineInfo(){
		addLineForm.xmlString.value = getXmlString();
		addLineForm.submit();
	}	
	
	/**--------------openwindow()定义开始：-----------------------
	* 名称：openwindow
	* 功能：在屏幕中间打开一个窗口。
	* 参数：
	*     1. url:转向网页的地址。
	*     2. name:网页名称，可为空。
	*     3. iWidth:弹出窗口的宽度。
	*     4. iHeight:弹出窗口的高度。
	* 传回：无。
	* 备注：
	*/
	function openwindow(url,name,iWidth,iHeight)
 	{
  		var url;           //转向网页的地址;
  		var name;          //网页名称，可为空;
  		var iWidth;        //弹出窗口的宽度;
  		var iHeight;       //弹出窗口的高度;
  		var iTop = (window.screen.availHeight-30-iHeight)/2;    //获得窗口的垂直位置;
  		var iLeft = (window.screen.availWidth-10-iWidth)/2;     //获得窗口的水平位置;
  		window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
	 }
	 //--------------openwindow()定义结束。-----------------------

	/**--------------actionProcess()定义开始：-----------------------
	* 名称：actionProcess
	* 功能：处理用户单击画板工具栏中的按钮事件。
	* 参数：theClickedImg:用户所单击的画板工具栏中的按钮。
	* 传回：ActionType：设置用户所单击的画板工具栏中的按钮类型。
	* 备注：
	*/
	function actionProcess(theClickedImg){
		//----------------------- switch start: -----------------------------
		//alert("theClickedImg.id="+theClickedImg.id);
		switch (theClickedImg.id) {
			case "move":
				//
				ActionType="move";		//设置用户所单击的画板工具栏中的按钮类型。
				theClickedImg.src="./webflow_base/images/flow/arrow_working.gif"	//改变按钮图标。
				drawLineStatus=false;	//改变画线状态全局变量的值。
				document.body.style.cursor='hand';	//改变光标样式。
				//改变工具栏其它按钮的图标：
				document.getElementsByName("line")[0].src="./webflow_base/images/flow/connection.gif";
				document.getElementsByName("manual")[0].src="./webflow_base/images/flow/manual.gif";
				document.getElementsByName("auto")[0].src="./webflow_base/images/flow/auto.gif";
				document.getElementsByName("route")[0].src="./webflow_base/images/flow/router.gif";
				document.getElementsByName("subprocess")[0].src="./webflow_base/images/flow/subflow.gif";
				break;	//退出switch语句。
			case "line":
				ActionType="line";		//设置用户所单击的画板工具栏中的按钮类型。
				theClickedImg.src="./webflow_base/images/flow/connection_working.gif"	//改变按钮图标。
				drawLineStatus=true;	//改变画线状态全局变量的值。
				document.body.style.cursor='default';	//改变光标样式。
				//改变工具栏其它按钮的图标：
				document.getElementsByName("move")[0].src="./webflow_base/images/flow/arrow.gif";
				document.getElementsByName("manual")[0].src="./webflow_base/images/flow/manual.gif";
				document.getElementsByName("auto")[0].src="./webflow_base/images/flow/auto.gif";
				document.getElementsByName("route")[0].src="./webflow_base/images/flow/router.gif";
				document.getElementsByName("subprocess")[0].src="./webflow_base/images/flow/subflow.gif";
				break;	//退出switch语句。
			case "manual":
				ActionType="manual";	//设置用户所单击的画板工具栏中的按钮类型。
				theClickedImg.src="./webflow_base/images/flow/manual_working.gif"	//改变按钮图标。
				drawLineStatus=false;	//改变画线状态全局变量的值。
				document.body.style.cursor='default';	//改变光标样式。
				//改变工具栏其它按钮的图标：
				document.getElementsByName("move")[0].src="./webflow_base/images/flow/arrow.gif";
				document.getElementsByName("line")[0].src="./webflow_base/images/flow/connection.gif";
				document.getElementsByName("auto")[0].src="./webflow_base/images/flow/auto.gif";
				document.getElementsByName("route")[0].src="./webflow_base/images/flow/router.gif";
				document.getElementsByName("subprocess")[0].src="./webflow_base/images/flow/subflow.gif";
				break;	//退出switch语句。
			case "auto":		
				ActionType="auto";		//设置用户所单击的画板工具栏中的按钮类型。
				theClickedImg.src="./webflow_base/images/flow/auto_working.gif"		//改变按钮图标。
				drawLineStatus=false;	//改变画线状态全局变量的值。
				document.body.style.cursor='default';	//改变光标样式。
				//改变工具栏其它按钮的图标：
				document.getElementsByName("move")[0].src="./webflow_base/images/flow/arrow.gif";
				document.getElementsByName("line")[0].src="./webflow_base/images/flow/connection.gif";
				document.getElementsByName("manual")[0].src="./webflow_base/images/flow/manual.gif";
				document.getElementsByName("route")[0].src="./webflow_base/images/flow/router.gif";
				document.getElementsByName("subprocess")[0].src="./webflow_base/images/flow/subflow.gif";
				break;	//退出switch语句。
			case "route":		
				ActionType="route";		//设置用户所单击的画板工具栏中的按钮类型。
				theClickedImg.src="./webflow_base/images/flow/router_working.gif"	//改变按钮图标。
				drawLineStatus=false;	//改变画线状态全局变量的值。
				document.body.style.cursor='default';	//改变光标样式。
				//改变工具栏其它按钮的图标：
				document.getElementsByName("move")[0].src="./webflow_base/images/flow/arrow.gif";
				document.getElementsByName("line")[0].src="./webflow_base/images/flow/connection.gif";
				document.getElementsByName("manual")[0].src="./webflow_base/images/flow/manual.gif";
				document.getElementsByName("auto")[0].src="./webflow_base/images/flow/auto.gif";
				document.getElementsByName("subprocess")[0].src="./webflow_base/images/flow/subflow.gif";
				break;	//退出switch语句。
			case "subprocess":		
				ActionType="subprocess";	//设置用户所单击的画板工具栏中的按钮类型。
				theClickedImg.src="./webflow_base/images/flow/subflow_working.gif"	//改变按钮图标。
				drawLineStatus=false;	//改变画线状态全局变量的值。
				document.body.style.cursor='default';	//改变光标样式。
				//改变工具栏其它按钮的图标：
				document.getElementsByName("move")[0].src="./webflow_base/images/flow/arrow.gif";
				document.getElementsByName("line")[0].src="./webflow_base/images/flow/connection.gif";
				document.getElementsByName("manual")[0].src="./webflow_base/images/flow/manual.gif";
				document.getElementsByName("auto")[0].src="./webflow_base/images/flow/auto.gif";
				document.getElementsByName("route")[0].src="./webflow_base/images/flow/router.gif";
				break;	//退出switch语句。
			default:
				ActionType="move";		//设置用户所单击的画板工具栏中的按钮类型。
				theClickedImg.src="./webflow_base/images/flow/arrow_working.gif"	//改变按钮图标。
				drawLineStatus=false;	//改变画线状态全局变量的值。
				document.body.style.cursor='hand';	//改变光标样式。
				//改变工具栏其它按钮的图标：
				document.getElementsByName("move")[0].src="./webflow_base/images/flow/arrow.gif";
				document.getElementsByName("line")[0].src="./webflow_base/images/flow/connection.gif";
				document.getElementsByName("manual")[0].src="./webflow_base/images/flow/manual.gif";
				document.getElementsByName("auto")[0].src="./webflow_base/images/flow/auto.gif";
				document.getElementsByName("route")[0].src="./webflow_base/images/flow/router.gif";
				document.getElementsByName("subprocess")[0].src="./webflow_base/images/flow/subflow.gif";
				break;	//退出switch语句。
		}
		//----------------------- switch end. -----------------------------
	 }
	 //--------------actionProcess()定义结束。-----------------------

	/**--------------doubleClickProcess()定义开始：-----------------------
	* 名称：doubleClickProcess
	* 功能：处理工作流设计器画板中的双击事件。
	* 参数：ActionType:工作流活动的类型[为页面中的全局变量]。
	* 传回：
	* 备注：用于在画板中产生工作流活动图标。
	*/
	function doubleClickProcess(){
		//----------------------- switch start: -----------------------------
		//alert("theClickedImg.id="+theClickedImg.id);
		switch (ActionType) {
			case "move":	//用户单击了画板工具栏中的[移动]按钮。
				//
				break;
			case "line":	//用户单击了画板工具栏中的[连线]按钮。
				//
				break;
			case "manual":	//用户单击了画板工具栏中的[人工活动]按钮。
				//
				generateActivityIcon('ManualActivity', event.x, event.y,'人工活动');
				break;
			case "auto":	//用户单击了画板工具栏中的[自动活动]按钮。
				//
				generateActivityIcon('AutoActivity', event.x, event.y,'自动活动');
				break;
			case "route":	//用户单击了画板工具栏中的[路由活动]按钮。
				//
				generateActivityIcon('RouterActivity', event.x, event.y,'路由活动');
				break;
			case "subprocess":	//用户单击了画板工具栏中的[子流程]按钮。
				//
				generateActivityIcon('SubActivity', event.x, event.y,'子流程');
				break;
			default:
				//
				generateActivityIcon('ManualActivity', event.x, event.y,'人工活动');
				break;
		}
		//----------------------- switch end. -----------------------------
	 }
	//--------------doubleClickProcess()定义结束。-----------------------

	function getXmlString(){
		var xmlString = currentTopologyObject.getTopologyString();
		return xmlString;
	}
	
	function deleActivityInfo(){
		delActivityForm.xmlString.value = getXmlString();
		delActivityForm.submit();
	}
	
</script>