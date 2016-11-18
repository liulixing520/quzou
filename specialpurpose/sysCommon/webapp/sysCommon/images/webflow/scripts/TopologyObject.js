/*
* 名称：TopologyObject.js
* 功能：工作流管理系统可视化工具中拓扑图的构造。
* 备注：
*	(1)给TopologyObject对象增加方法this.generateDefaultSchema = function(ActivitiesArray,ConnectsArray)
*	(2)在TopologyObject对象的方法this.newSchema = function(name,versionSign,processName)中增加了以下对象的初始化
*	    defaultSchema =null;
*		defaultSchema = new ActiveXObject("MSXML2.DOMDocument");
*		defaultSchema.async = false;
*		defaultSchema.loadXML(DefaultTopo);
*		defaultProcess = defaultSchema.selectSingleNode("root/state[@typeName='Process']");
*		defaultStartActivity = defaultSchema.selectSingleNode("root/state[@typeName='StartActivity']");
*		defaultEndActivity = defaultSchema.selectSingleNode("root/state[@typeName='EndActivity']");
*		defaultManualActivity = defaultSchema.selectSingleNode("root/state[@typeName='ManualActivity']");
*		defaultAutoActivity = defaultSchema.selectSingleNode("root/state[@typeName='AutoActivity']");
*		defaultRouterActivity = defaultSchema.selectSingleNode("root/state[@typeName='RouterActivity']");
*		defaultSubActivity = defaultSchema.selectSingleNode("root/state[@typeName='SubActivity']");
*		defaultConnector = defaultSchema.selectSingleNode("root/connector");
*	修订原因：为了支持新需求，即：根据JaWE生成的流程定义数据，由图形库自动生成默认的工作流拓扑图。
*	在生成连线时，增加了连线ID的判断
*	修订原因：在由jawe生成默认的拓扑图时，程序中没有使用传过来的连线ID。
*/

//定义默认的拓扑对象：
var DefaultTopo = "<?xml version='1.0' encoding='utf-8' standalone='no'?>\n"
+ "<root>\n"
+ " <state color=''	id='1' typeName='Process' height='48' width='48' x='10'	y='10'>\n"
+ "		<name>Process</name>\n"
+ "		<propertyList>\n"
+ "			<property name='processId' type='0'>\n"
+ "				<value>wfFile1</value>\n"
+ "			</property>\n"
+ "			<property name='processName' type='0'>\n"
+ "				<value>wfFile</value>\n"
+ "			</property>\n"
+ "			<property name='description' type='0'>\n"
+ "				<value></value>\n"
+ "			</property>\n"
+ "			<property name='version' type='0'>\n"
+ "				<value></value>\n"
+ "			</property>\n"
+ "			<property name='productVersion'	type='0'>\n"
+ "				<value>2.0</value>\n"
+ "			</property>\n"
+ "		</propertyList>\n"
+ "		<description/>\n"
+ "	</state>\n"
+ "	<state color=''	id='activity.2' typeName='StartActivity' height='48'	width='48' x='200' y='200'>\n"
+ "		<name>StartActivity</name>\n"
+ "		<propertyList>\n"
+ "			<property name='activityName' type='0'>\n"
+ "				<value>开始</value>\n"
+ "			</property>\n"
+ "			<property name='tips' type='0'>\n"
+ "				<value/>\n"
+ "			</property>\n"
+ "		</propertyList>\n"
+ "		<description/>\n"
+ "	</state>\n"
+ "	<state color='' id='activity.3' typeName='EndActivity' height='48' width='48' x='580' y='200' >\n"
+ "		<name>EndActivity</name>\n"
+ "		<propertyList>\n"
+ "			<property name='activityName' type='0'>\n"
+ "				<value>结束</value>\n"
+ "			</property>\n"
+ "			<property name='tips' type='0'>\n"
+ "				<value/>\n"
+ "			</property>\n"
+ "		</propertyList>\n"
+ "		<description/>\n"
+ "	</state>\n"
+ "	<state color='' id='4' typeName='ManualActivity' height='48' width='48' x='177' y='124' >\n"
+ "		<name>ManualActivity</name>\n"
+ "		<propertyList>\n"
+ "			<property name='activityName' type='0'>\n"            //
+ "				<value>人工活动</value>\n"
+ "			</property>\n"
+ "			<property name='tips' type='0'>\n"
+ "				<value/>\n"
+ "			</property>\n"
+ "		</propertyList>\n"
+ "		<description/>\n"
+ "	</state>\n"
+ "	<state color='' id='5' typeName='AutoActivity' height='48' width='48' x='313' y='124' >\n"
+ "		<name>AutoActivity</name>\n"
+ "		<propertyList>\n"
+ "			<property name='activityName' type='0'>\n"
+ "				<value>自动活动</value>\n"
+ "			</property>\n"
+ "			<property name='tips' type='0'>\n"
+ "				<value/>\n"
+ "			</property>\n"
+ "		</propertyList>\n"
+ "		<description/>\n"
+ "	</state>\n"
+ "	<state color='' id='6' typeName='RouterActivity' height='48' width='48' x='428' y='224' >\n"
+ "		<name>RouterActivity</name>\n"
+ "		<propertyList>\n"
+ "			<property name='activityName' type='0'>\n"
+ "				<value>路由活动</value>\n"
+ "			</property>\n"
+ "			<property name='tips' type='0'>\n"
+ "				<value/>\n"
+ "			</property>\n"
+ "		</propertyList>\n"
+ "		<description/>\n"
+ "	</state>\n"
+ "	<state color='' id='7' typeName='SubActivity' height='48' width='48' x='314' y='224'>\n"
+ "		<name>SubActivity</name>\n"
+ "		<propertyList>\n"
+ "			<property name='activityName' type='0'>\n"
+ "				<value>子流程</value>\n"
+ "			</property>\n"
+ "			<property name='tips' type='0'>\n"
+ "				<value/>\n"
+ "			</property>\n"
+ "			<property name='subProcess' type='0'>\n"
+ "				<value></value>\n"
+ "			</property>\n"
+ "		</propertyList>\n"
+ "		<description/>\n"
+ "	</state>\n"
+ "	<connector color='' description='' id='-2' type='connection'>\n"
+ "		<from></from>\n"
+ "		<to></to>\n"
+ "		<propertyList>\n"
+ "			<property name='displayName' type='0'>\n"
+ "				<value/>\n"
+ "			</property>\n"
+ "		</propertyList>\n"
+ "		<bendpoints/>\n"
+ "	</connector>\n"
+ "</root>";

//用于存放工作流定义中缺省的部分
var defaultSchema = new ActiveXObject("MSXML2.DOMDocument");
defaultSchema.async = false;
defaultSchema.loadXML(DefaultTopo);

//用于存放从currentTopologyObject中转化出来的xml
var xmltostring_shema = "";

//定义默认的工作流活动的对象：
var defaultProcess = defaultSchema.selectSingleNode("root/state[@typeName='Process']");
//alert("defaultProcess.xml="+defaultProcess.xml);
var defaultStartActivity = defaultSchema.selectSingleNode("root/state[@typeName='StartActivity']");
var defaultEndActivity = defaultSchema.selectSingleNode("root/state[@typeName='EndActivity']");
var defaultManualActivity = defaultSchema.selectSingleNode("root/state[@typeName='ManualActivity']");
var defaultAutoActivity = defaultSchema.selectSingleNode("root/state[@typeName='AutoActivity']");
var defaultRouterActivity = defaultSchema.selectSingleNode("root/state[@typeName='RouterActivity']");
var defaultSubActivity = defaultSchema.selectSingleNode("root/state[@typeName='SubActivity']");
var defaultConnector = defaultSchema.selectSingleNode("root/connector");

/**
 * 定义工作流拓扑TopologyObject对象:
 */
function TopologyObject()
{
	
	this.schema;				// 存放工作流定义的XML document对象
	this.states = null;			// 图元节点集合（xml node）
	this.connectors = null;		// 连线节点集合（xml node）
	this.name;					//名称
	
	//初始化事件处理接口对象[该定义在文件<EventInterface.js>中]：
	this.eventInterfaceObject=new EventInterface();
	//-----------------------------------------------------------
	var Point1X=0;	//新插入的第1个点的X坐标。
	var Point1Y=0;	//新插入的第1个点的Y坐标。
	var Point2X=0;	//新插入的第2个点的X坐标。
	var Point2Y=0;	//新插入的第2个点的Y坐标。
	
	/**--------------delPreInsertedPoints()定义开始：-----------------------
	* 功能：删除连线上已经插入的点。
	*/
	this.delPreInsertedPoints=function(){
		if(ClickedLineObject!=null){
			//alert("删除之前，points.length="+ClickedLineObject.points.length);
			var totalPoints=ClickedLineObject.points.length;
			for (var i=0; i<totalPoints; i++) {
				//删除一个点之后，points[]数组会自动收缩，故每次只需删除第一个即可。
				ClickedLineObject.points.remove(ClickedLineObject.points[0]);	
			}
			//alert("删除之后，points.length="+ClickedLineObject.points.length);
			return false;
		}
	}
	//--------------delPreInsertedPoints()定义结束。-----------------------

	/**--------------setLineShape_TopTriangle()定义开始：-----------------------
	* 功能：产生∧形状折线。
	*/
	this.setLineShape_TopTriangle=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			Point1X=(ClickedLineObject.begin.x+ClickedLineObject.end.x)/2;
			Point1Y=(ClickedLineObject.begin.y+ClickedLineObject.end.y)/2-30;
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.points.push(new Point(Point1X, Point1Y));
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_TopTriangle()定义结束。-----------------------

	/**--------------setLineShape_DownTriangle()定义开始：-----------------------
	* 功能：产生∨形状折线。
	*/
	this.setLineShape_DownTriangle=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			Point1X=(ClickedLineObject.begin.x+ClickedLineObject.end.x)/2;
			Point1Y=(ClickedLineObject.begin.y+ClickedLineObject.end.y)/2+30;
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.points.push(new Point(Point1X, Point1Y));
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_DownTriangle()定义结束。-----------------------

	/**--------------setLineShape_LeftTriangle()定义开始：-----------------------
	* 功能：产生＜形状折线。
	*/
	this.setLineShape_LeftTriangle=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			Point1X=(ClickedLineObject.begin.x+ClickedLineObject.end.x)/2-30;
			Point1Y=(ClickedLineObject.begin.y+ClickedLineObject.end.y)/2;
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.points.push(new Point(Point1X, Point1Y));
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_LeftTriangle()定义结束。-----------------------

	/**--------------setLineShape_RightTriangle()定义开始：-----------------------
	* 功能：产生＞形状折线。
	*/
	this.setLineShape_RightTriangle=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			Point1X=(ClickedLineObject.begin.x+ClickedLineObject.end.x)/2+30;
			Point1Y=(ClickedLineObject.begin.y+ClickedLineObject.end.y)/2;
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.points.push(new Point(Point1X, Point1Y));
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_RightTriangle()定义结束。-----------------------
	
	/**--------------setLineShape_TopRectangle()定义开始：-----------------------
	* 功能：产生︻形状折线。
	*/
	this.setLineShape_TopRectangle=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			if(ClickedLineObject.begin.y<=ClickedLineObject.end.y){
				Point1X=ClickedLineObject.begin.x;
				Point1Y=ClickedLineObject.begin.y-40;
				Point2X=ClickedLineObject.end.x;
				Point2Y=ClickedLineObject.begin.y-40;
			}
			else{
				Point1X=ClickedLineObject.begin.x;
				Point1Y=ClickedLineObject.end.y-40;
				Point2X=ClickedLineObject.end.x;
				Point2Y=ClickedLineObject.end.y-40;
			}
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.points.push(new Point(Point1X, Point1Y));
			ClickedLineObject.points.push(new Point(Point2X, Point2Y));
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_TopRectangle()定义结束。-----------------------
	
	/**--------------setLineShape_DownRectangle()定义开始：-----------------------
	* 功能：产生︼形状折线。
	*/
	this.setLineShape_DownRectangle=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			if(ClickedLineObject.begin.y>=ClickedLineObject.end.y){
				Point1X=ClickedLineObject.begin.x;
				Point1Y=ClickedLineObject.begin.y+40;
				Point2X=ClickedLineObject.end.x;
				Point2Y=ClickedLineObject.begin.y+40;
			}
			else{
				Point1X=ClickedLineObject.begin.x;
				Point1Y=ClickedLineObject.end.y+40;
				Point2X=ClickedLineObject.end.x;
				Point2Y=ClickedLineObject.end.y+40;
			}
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.points.push(new Point(Point1X, Point1Y));
			ClickedLineObject.points.push(new Point(Point2X, Point2Y));
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_DownRectangle()定义结束。-----------------------
	
	/**--------------setLineShape_LeftRectangle()定义开始：-----------------------
	* 功能：产生【形状折线。
	*/
	this.setLineShape_LeftRectangle=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			if(ClickedLineObject.begin.x<=ClickedLineObject.end.x){
				Point1X=ClickedLineObject.begin.x-40;
				Point1Y=ClickedLineObject.begin.y;
				Point2X=ClickedLineObject.begin.x-40;
				Point2Y=ClickedLineObject.end.y;
			}
			else{
				Point1X=ClickedLineObject.end.x-40;
				Point1Y=ClickedLineObject.begin.y;
				Point2X=ClickedLineObject.end.x-40;
				Point2Y=ClickedLineObject.end.y;
			}
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.points.push(new Point(Point1X, Point1Y));
			ClickedLineObject.points.push(new Point(Point2X, Point2Y));
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_LeftRectangle()定义结束。-----------------------
	
	/**--------------setLineShape_RightRectangle()定义开始：-----------------------
	* 功能：产生】形状折线。
	*/
	this.setLineShape_RightRectangle=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			if(ClickedLineObject.begin.x>=ClickedLineObject.end.x){
				Point1X=ClickedLineObject.begin.x+40;
				Point1Y=ClickedLineObject.begin.y;
				Point2X=ClickedLineObject.begin.x+40;
				Point2Y=ClickedLineObject.end.y;
			}
			else{
				Point1X=ClickedLineObject.end.x+40;
				Point1Y=ClickedLineObject.begin.y;
				Point2X=ClickedLineObject.end.x+40;
				Point2Y=ClickedLineObject.end.y;
			}
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.points.push(new Point(Point1X, Point1Y));
			ClickedLineObject.points.push(new Point(Point2X, Point2Y));
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_RightRectangle()定义结束。-----------------------
	
	/**--------------setLineOffset_Top()定义开始：-----------------------
	* 功能：将连线向上移动。
	*/
	this.setLineOffset_Top=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			var tempPoints=new  Array();
			var totalPoints=ClickedLineObject.points.length;
			for (var i=0; i<totalPoints; i++) {
				tempPoints.push(new Point(ClickedLineObject.points[i].x, ClickedLineObject.points[i].y-5));
			}
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			//alert("totalPoints="+totalPoints);
			//alert("tempPoints.length="+tempPoints.length);
			for (var j=0; j<totalPoints; j++) {
				ClickedLineObject.points.push(new Point(tempPoints[j].x,tempPoints[j].y));
			}
			ClickedLineObject.redraw();
			tempPoints=null;
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineOffset_Top()定义结束。-----------------------

	/**--------------setLineOffset_Down()定义开始：-----------------------
	* 功能：将连线向下移动。
	*/
	this.setLineOffset_Down=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			var tempPoints=new  Array();
			var totalPoints=ClickedLineObject.points.length;
			for (var i=0; i<totalPoints; i++) {
				tempPoints.push(new Point(ClickedLineObject.points[i].x, ClickedLineObject.points[i].y+5));
			}
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			//alert("totalPoints="+totalPoints);
			//alert("tempPoints.length="+tempPoints.length);
			for (var j=0; j<totalPoints; j++) {
				ClickedLineObject.points.push(new Point(tempPoints[j].x,tempPoints[j].y));
			}
			ClickedLineObject.redraw();
			tempPoints=null;
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineOffset_Down()定义结束。-----------------------

	/**--------------setLineOffset_Left()定义开始：-----------------------
	* 功能：将连线向左移动。
	*/
	this.setLineOffset_Left=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			var tempPoints=new  Array();
			var totalPoints=ClickedLineObject.points.length;
			for (var i=0; i<totalPoints; i++) {
				tempPoints.push(new Point(ClickedLineObject.points[i].x-5, ClickedLineObject.points[i].y));
			}
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			//alert("totalPoints="+totalPoints);
			//alert("tempPoints.length="+tempPoints.length);
			for (var j=0; j<totalPoints; j++) {
				ClickedLineObject.points.push(new Point(tempPoints[j].x,tempPoints[j].y));
			}
			ClickedLineObject.redraw();
			tempPoints=null;
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineOffset_Left()定义结束。-----------------------

	/**--------------setLineOffset_Right()定义开始：-----------------------
	* 功能：将连线向右移动。
	*/
	this.setLineOffset_Right=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			var tempPoints=new  Array();
			var totalPoints=ClickedLineObject.points.length;
			for (var i=0; i<totalPoints; i++) {
				tempPoints.push(new Point(ClickedLineObject.points[i].x+5, ClickedLineObject.points[i].y));
			}
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			//alert("totalPoints="+totalPoints);
			//alert("tempPoints.length="+tempPoints.length);
			for (var j=0; j<totalPoints; j++) {
				ClickedLineObject.points.push(new Point(tempPoints[j].x,tempPoints[j].y));
			}
			ClickedLineObject.redraw();
			tempPoints=null;
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineOffset_Right()定义结束。-----------------------


	/**--------------setLineShape_Beeline()定义开始：-----------------------
	* 功能：产生直线。
	*/
	this.setLineShape_Beeline=function(){
		//alert("ClickedLineObject.points.length="+ClickedLineObject.points.length);
		if(ClickedLineObject!=null){
			this.delPreInsertedPoints();	//删除连线上已经插入的点。
			ClickedLineObject.redraw();
			ClickedLineObject=null;
			return false;
		}
	}
	//--------------setLineShape_Beeline()定义结束。-----------------------

	/**--------------clear()定义开始：-----------------------
	* 名称：clear
	* 功能：删除工作流拓扑定义对象。
	* 参数：
	* 传回：
	* 备注：
	*/
	this.clear = function() {
		//将xml Document对象置空：
		this.schema = null;
		
		//显示当前图标总数和连线总数
		//alert("AllIconsArray="+AllIconsArray.length+"; AllLinesArray="+AllLinesArray.length);
		
		for (var i=0; i<AllIconsArray.length; i++) {
			document.body.removeChild(AllIconsArray[i].img);
			document.body.removeChild(AllIconsArray[i].text);
		}
		for (var i=0; i<AllLinesArray.length; i++) {
			document.body.removeChild(AllLinesArray[i].lineImg);
			document.body.removeChild(AllLinesArray[i].text);
		}
		AllIconsArray = new Array();	//
		AllLinesArray = new Array();	//
	}
	//--------------clear()定义结束。-----------------------
	
	/**--------------newSchema()定义开始：-----------------------
	* 名称：newSchema
	* 功能：新创建一个流程拓扑定义模板，并初始化开始活动和结束活动。
	* 参数：
	*     1. name:流程拓扑定义模板的名称。
	*     2. versionSign:流程拓扑定义模板的版本号。
	*     3. processName:流程的名称。
	* 传回：
	* 备注：通常情况下，不需要传入这三个参数，调用方式为newSchema()。
	*/
	this.newSchema = function(name,versionSign,processName) {
		//用于存放工作流定义中缺省的部分
		defaultSchema =null;
		defaultSchema = new ActiveXObject("MSXML2.DOMDocument");
		defaultSchema.async = false;
		defaultSchema.loadXML(DefaultTopo);
		//初始化相关对象：
		defaultProcess = defaultSchema.selectSingleNode("root/state[@typeName='Process']");
		defaultStartActivity = defaultSchema.selectSingleNode("root/state[@typeName='StartActivity']");
		defaultEndActivity = defaultSchema.selectSingleNode("root/state[@typeName='EndActivity']");
		defaultManualActivity = defaultSchema.selectSingleNode("root/state[@typeName='ManualActivity']");
		defaultAutoActivity = defaultSchema.selectSingleNode("root/state[@typeName='AutoActivity']");
		defaultRouterActivity = defaultSchema.selectSingleNode("root/state[@typeName='RouterActivity']");
		defaultSubActivity = defaultSchema.selectSingleNode("root/state[@typeName='SubActivity']");
		defaultConnector = defaultSchema.selectSingleNode("root/connector");
		//
		this.clear();
		
		if (name == null)
			this.name = "webFlow1";
		else
			this.name = name;
		
		//初始化流程模板
		this.schema = new ActiveXObject("MSXML2.DOMDocument");
		this.schema.async = false;
		this.schema.loadXML("<?xml version='1.0' encoding='utf-8' standalone='no'?>\n<TopoInfo>\n<Vector2D name='"+name+"' type='TopoInfo' router='0'>\n<states>\n</states>\n<connectors>\n</connectors>\n<groups>\n</groups>\n</Vector2D>\n</TopoInfo>");
		//
		this.states = this.schema.selectSingleNode("TopoInfo/Vector2D/states");
		this.connectors = this.schema.selectSingleNode("TopoInfo/Vector2D/connectors");
		
		//取得流程定义节点
		this.states.appendChild(defaultProcess.cloneNode(true));
		
		//this.states.selectSingleNode("state[@typeName='Process']/propertyList/property[@name='processId']/value").text = name;
		//this.states.selectSingleNode("state[@typeName='Process']/propertyList/property[@name='processName']/value").text=processName;
		//this.states.selectSingleNode("state[@typeName='Process']/propertyList/property[@name='version']/value").text=versionSign;
		//设置活动的提示信息：
		//alert("defaultStartActivity.xml="+defaultStartActivity.xml);
		defaultStartActivity.selectSingleNode("propertyList/property[@name='tips']/value").text="这是流程的开始活动。";
		defaultEndActivity.selectSingleNode("propertyList/property[@name='tips']/value").text="这是流程的结束活动。";
		//在非监控状态时，默认添加一个开始活动和一个结束活动：
		if(MonitorProcess == false){		
			//取得开始节点
			this.states.appendChild(defaultStartActivity.cloneNode(true));
			//取得结束节点
			this.states.appendChild(defaultEndActivity.cloneNode(true));
		}		
		// 根据currentTopologyObject绘制流程图
		this.draw();
		//alert("defaultStartActivity.xml="+defaultStartActivity.xml);
		var startNodeID=defaultStartActivity.getAttribute("id");
		//alert("startNodeID="+startNodeID);
		var startNodeName=defaultStartActivity.selectSingleNode("propertyList/property[@name='activityName']/value").text;
		//alert("startNodeName="+startNodeName);
		var endNodeID=defaultEndActivity.getAttribute("id");
		//alert("endNodeID="+endNodeID);
		var endNodeName=defaultEndActivity.selectSingleNode("propertyList/property[@name='activityName']/value").text;

		//在非监控状态时，需要触发新建工作流事件：
		if(MonitorProcess == false){		
			this.eventInterfaceObject.NewProcessEvent(startNodeID,startNodeName,endNodeID,endNodeName);
		}		
	}
	//--------------newSchema()定义结束。-----------------------
	
	/**--------------generateDefaultSchema()定义开始：-----------------------
	* 名称：generateDefaultSchema
	* 功能：根据传入的活动对象集合和连线对象集合，新创建一个流程拓扑定义模板。
	*       目的在于：根据JaWE生成的工作流定义自动生成默认的工作流拓扑图。
	* 参数：
	*     1. ActivitiesArray:传入的活动对象[ActObject]集合。
	*     2. ConnectsArray:传入的连线对象[ConObject]集合。
	* 传回：
	* 备注：活动对象[ActObject]和连线对象[ConObject]在文件"web2d.js"中定义。
	*/
	this.generateDefaultSchema = function(ActivitiesArray,ConnectsArray) {
		//用于存放工作流定义中缺省的部分
		defaultSchema =null;
		defaultSchema = new ActiveXObject("MSXML2.DOMDocument");
		defaultSchema.async = false;
		defaultSchema.loadXML(DefaultTopo);
		//初始化相关对象：
		defaultProcess = defaultSchema.selectSingleNode("root/state[@typeName='Process']");
		defaultStartActivity = defaultSchema.selectSingleNode("root/state[@typeName='StartActivity']");
		defaultEndActivity = defaultSchema.selectSingleNode("root/state[@typeName='EndActivity']");
		defaultManualActivity = defaultSchema.selectSingleNode("root/state[@typeName='ManualActivity']");
		defaultAutoActivity = defaultSchema.selectSingleNode("root/state[@typeName='AutoActivity']");
		defaultRouterActivity = defaultSchema.selectSingleNode("root/state[@typeName='RouterActivity']");
		defaultSubActivity = defaultSchema.selectSingleNode("root/state[@typeName='SubActivity']");
		defaultConnector = defaultSchema.selectSingleNode("root/connector");
		//先对连线对象进行预处理，检查是否存在双向连线：
		for(var i=0;i<ConnectsArray.length;i++){
			for(var j=i+1;j<ConnectsArray.length;j++){
				if(ConnectsArray[j].from==ConnectsArray[i].to && ConnectsArray[j].to==ConnectsArray[i].from)
					ConnectsArray[j].flag=true;
			}
			//
		}
		//----------------------------------------------
		this.clear();
		
		this.name = "webFlow1";
		
		//初始化流程模板
		this.schema=null;
		this.schema = new ActiveXObject("MSXML2.DOMDocument");
		this.schema.async = false;
		this.schema.loadXML("<?xml version='1.0' encoding='utf-8' standalone='no'?>\n<TopoInfo>\n<Vector2D name='"+name+"' type='TopoInfo' router='0'>\n<states>\n</states>\n<connectors>\n</connectors>\n<groups>\n</groups>\n</Vector2D>\n</TopoInfo>");
		//
		this.states =null;
		this.states = this.schema.selectSingleNode("TopoInfo/Vector2D/states");
		this.connectors =null;
		this.connectors = this.schema.selectSingleNode("TopoInfo/Vector2D/connectors");
		
		//取得流程定义节点
		this.states.appendChild(defaultProcess.cloneNode(true));
		
		//在非监控状态时：
		if(MonitorProcess == false){	
			//处理各个活动对象：
			for(var i=0;i<ActivitiesArray.length;i++){
				var theActivity = defaultManualActivity;
				var theX=(i+1)*50+90;
				var theY=90;
				if(i%2==0) 
					theY=(i+2)*30+70;
				else 
					theY=(i+2)*30+10;
				switch (ActivitiesArray[i].type) {
					case "ManualActivity":
						theActivity = defaultManualActivity;
						theActivity.setAttribute("x",theX);
						theActivity.setAttribute("y",theY);
						break;
						
					case "AutoActivity":
						theActivity = defaultAutoActivity;
						theActivity.setAttribute("x",theX);
						theActivity.setAttribute("y",theY);
						break;
						
					case "RouterActivity":
						theActivity = defaultRouterActivity;
						theActivity.setAttribute("x",theX);
						theActivity.setAttribute("y",theY);
						break;
						
					case "SubActivity":
						theActivity = defaultSubActivity;
						theActivity.setAttribute("x",theX);
						theActivity.setAttribute("y",theY);
						break;
						
					case "StartActivity":
						theActivity = defaultStartActivity;
						theActivity.setAttribute("x","90");
						theActivity.setAttribute("y","90");
						break;
						
					case "EndActivity":
						theActivity = defaultEndActivity;
						if(ActivitiesArray.length>10){
							theActivity.setAttribute("x","920");
							theActivity.setAttribute("y","520");
						}else{
							theActivity.setAttribute("x","620");
							theActivity.setAttribute("y","320");
						}
						break;
						
					default:
						theActivity = defaultManualActivity;
						theActivity.setAttribute("x",theX);
						theActivity.setAttribute("y",theY);
						break;
				}
				//
				theActivity.setAttribute("id",ActivitiesArray[i].id);
				theActivity.setAttribute("typeName",ActivitiesArray[i].type);
				theActivity.selectSingleNode("propertyList/property[@name='activityName']/value").text=ActivitiesArray[i].name;
				theActivity.selectSingleNode("propertyList/property[@name='tips']/value").text=ActivitiesArray[i].tips;
				this.states.appendChild(theActivity.cloneNode(true));
				//由于在数据库中已经存在工作流定义，所以不要触发增加活动和增加连线的事件。
			}
			//处理各个连线对象：
			for(var i=0;i<ConnectsArray.length;i++){
				var theConnector=defaultConnector;
				theConnector.setAttribute("id",ConnectsArray[i].id);
				theConnector.selectSingleNode("propertyList/property[@name='displayName']/value").text=ConnectsArray[i].name;
				theConnector.selectSingleNode("from").text=ConnectsArray[i].from;
				theConnector.selectSingleNode("to").text=ConnectsArray[i].to;
				if(ConnectsArray[i].flag==true){
					//产生折线：
					var bendpoints = theConnector.selectSingleNode("bendpoints");
					var bendpoint = this.schema.createNode("element", "bendpoint", "");
					var w1 =-50;
					var h1 =0;
					var w2 =30;
					var h2 =0;
					bendpoint.setAttribute("w1", w1);
					bendpoint.setAttribute("h1", h1);
					bendpoint.setAttribute("w2", w2);
					bendpoint.setAttribute("h2", h2);
					bendpoints.appendChild(bendpoint);
				}
				this.connectors.appendChild(theConnector.cloneNode(true));
				//由于在数据库中已经存在工作流定义，所以不要触发增加活动和增加连线的事件。
			}
		}		
		// 根据currentTopologyObject绘制流程图
		this.draw();
	}
	//--------------generateDefaultSchema()定义结束。-----------------------

	/**--------------load()定义开始：-----------------------
	* 名称：load
	* 功能：从一个文件装载流程拓扑定义文件，并在设计器中呈现。
	* 参数：
	*     1. fileName:流程拓扑定义文件的名称(包括文件路径)。
	* 传回：无。
	* 备注：
	*/
	this.load = function(fileName) {
		this.clear();
		var fso, f, ts;
		fso = new ActiveXObject("Scripting.FileSystemObject");
		f = fso.GetFile(fileName);
		ts = f.OpenAsTextStream(1, -2);
		this.schema = new ActiveXObject("MSXML2.DOMDocument");
		this.schema.async=false;
		this.schema.loadXML(ts.ReadAll());
		ts.Close();
		this.states = this.schema.selectSingleNode("TopoInfo/Vector2D/states");
		this.connectors = this.schema.selectSingleNode("TopoInfo/Vector2D/connectors");
		this.name = this.schema.selectSingleNode("TopoInfo/Vector2D/states/state[@typeName='Process']/propertyList/property[@name='processId']/value").text;
		this.draw();
		
	}
	//--------------load()定义结束。-----------------------
	
	/**--------------loadFromDB()定义开始：-----------------------
	* 名称：loadFromDB
	* 功能：从数据库中查出流程拓扑定义的字符串，并在设计器中呈现。
	* 参数：
	*     1. xmlFromDB:数据库中存放的流程拓扑定义字符串。
	* 传回：无。
	* 备注：
	*/
	this.loadFromDB=function(xmlFromDB){
	
		this.schema = new ActiveXObject("MSXML2.DOMDocument");
		this.schema.async=false;
		this.schema.loadXML(xmlFromDB);
		this.states = this.schema.selectSingleNode("TopoInfo/Vector2D/states");
		
		this.connectors = this.schema.selectSingleNode("TopoInfo/Vector2D/connectors");
		this.name = this.schema.selectSingleNode("TopoInfo/Vector2D/states/state[@typeName='Process']/propertyList/property[@name='processId']/value").text;
		this.draw();
	}
	//--------------loadFromDB()定义结束。-----------------------

	/**--------------draw()定义开始：-----------------------
	* 名称：draw
	* 功能：在设计器中绘制工作流拓扑图。
	* 参数：
	* 传回：
	* 备注：
	*/
	this.draw = function() {
	
		var acts = this.states.selectNodes("state");
		
		for (var i=0; i < acts.length; i++) {
			var icon = new IconObject();
			var type = acts[i].getAttribute("typeName");
			var x = acts[i].getAttribute("x");
			var y = acts[i].getAttribute("y");
			var id= acts[i].getAttribute("id");
			if (type == "Process")
				continue;
			var activityName = acts[i].selectSingleNode("propertyList/property[@name='activityName']/value").text;
			//活动的提示信息：
			var tipsInfo=acts[i].selectSingleNode("propertyList/property[@name='tips']/value").text;
			icon.tips=tipsInfo;

			//图元初始化:
			if(MonitorProcess == true){		//需要绘制当前工作流的监控图
				//
				if(ifActivityWorking(id)==true)	//判断指定ID的活动当前是否正处于running状态
					icon.init(type, x, y, activityName,true);
				else
					icon.init(type, x, y, activityName,false);
			}
			else{							//需要绘制当前工作流的交互图
				icon.init(type, x, y, activityName,false);

			}
			icon.activity = acts[i];
			icon.states=this.states;
			icon.id = id;
			AllIconsArray.push(icon);
		}
		var conns = this.connectors.selectNodes("connector");
		for (var i=0; i < conns.length; i++) {
			var from = conns[i].selectSingleNode("from").text;
			var to = conns[i].selectSingleNode("to").text;
			//根据Iconid获取图元
			var beginIcon = getIconFromId(from);
			var endIcon = getIconFromId(to);
			var l = new LineObject();
			l.lineID=conns[i].getAttribute("id")
			//bendpoint是图形中是否包含折线
			var pts = conns[i].selectNodes("bendpoints/bendpoint");
			if (pts != null) {
				for (var j=0; j < pts.length; j++) {
					var w1 = pts[j].getAttribute("w1");
					var h1 = pts[j].getAttribute("h1");
					l.points.push(new Point(beginIcon.img.offsetLeft + HarfSizeOfIcon + parseInt(w1), beginIcon.img.offsetTop + HarfSizeOfIcon + parseInt(h1) ));
				}
			}
			var displayName = conns[i].selectSingleNode("propertyList/property[@name='displayName']/value").text;
			l.setDisplayName(displayName);
			
			l.init(beginIcon, endIcon,l.lineID);

			l.connector = conns[i];
			AllLinesArray.push(l);
		}
	}
	//--------------draw()定义结束。-----------------------

	/**--------------create_state()定义开始：-----------------------
	* 名称：create_state
	* 功能：根据图元对象生成工作流活动的XML定义。
	* 参数：
	*     1. icon:指定的图元对象。
	* 传回：
	* 备注：
	*/
	this.create_state = function(icon) {
		var state = defaultManualActivity;
		switch (icon.type) {
			case "ManualActivity":
				state = defaultManualActivity;
				break;
				
			case "AutoActivity":
				state = defaultAutoActivity;
				break;
				
			case "RouterActivity":
				state = defaultRouterActivity;
				break;
				
			case "SubActivity":
				state = defaultSubActivity;
				break;
				
			case "StartActivity":
				state = defaultStartActivity;
				break;
				
			case "EndActivity":
				state = defaultEndActivity;
				break;
				
			default:
				state = defaultManualActivity;
				break;
		}
		
		var newState = state.cloneNode(true);
		newState.setAttribute("x", icon.img.offsetLeft);
		newState.setAttribute("y", icon.img.offsetTop);
		newState.setAttribute("id", generateNewIconId());	//产生新活动的标识号
		icon.id =generateNewIconId();
		//设置活动的提示信息：
		icon.img.alt=icon.tips;

		//设置子流程的定义id
		if(icon.type == "SubActivity"){
			newState.selectSingleNode("propertyList/property[@name='subProcess']/value").text=icon.id;
		}

		//设置activityName
		newState.selectSingleNode("propertyList/property[@name='activityName']/value").text=icon.displayName;
		icon.activity = newState;	//保存该活动的XML串。
		icon.setDisplayName(icon.displayName);
		icon.states = this.states; //将当前所有环节节点的引用设置给icon
		//将此节点加入currentTopologyObject中
		this.states.appendChild(newState);
		//触发事件：
		var ActivityNodeType=icon.type;
		var ActivityNodeID=icon.id;
		var ActivityNodeName=icon.displayName;
		this.eventInterfaceObject.AddActivityEvent(ActivityNodeType,ActivityNodeID,ActivityNodeName);
		//
	}
	//--------------create_state()定义结束。-----------------------

	/**--------------create_connector()定义开始：-----------------------
	* 名称：create_connector
	* 功能：根据连线对象生成工作流拓扑连线的XML定义。
	* 参数：line:指定的连线对象。
	* 传回：
	* 备注：
	*/
	this.create_connector = function(line) {
		var conn = defaultConnector.cloneNode(true);
		var from = conn.selectSingleNode("from");
		var to   = conn.selectSingleNode("to");
		from.text = line.iconBegin.id;
		to.text   = line.iconEnd.id;
		line.connector = conn;
		this.connectors.appendChild(conn);
	}
	//--------------create_connector()定义结束。-----------------------
	
	/**--------------writeToFile()定义开始：-----------------------
	* 名称：writeToFile
	* 功能：将当前工作流的拓扑定义保存到指定的文件中。
	* 参数：fileName:指定的文件名称(包括路径名称)。
	* 传回：
	* 备注：
	*/
	this.writeToFile = function(fileName) {
		var fso, f, ts;
		
		fso = new ActiveXObject("Scripting.FileSystemObject");
		f = fso.OpenTextFile(fileName, 2, true);
		
		this.setWFSchemaFromGraphic();
		f.Write(this.schema.xml.replace("<?xml version=\"1.0\"","<?xml version=\"1.0\" encoding=\"utf-8\""));
		f.Close();
		alert("write sucess!");
	}
	//--------------writeToFile()定义结束。-----------------------
	
	/**--------------getTopologyString()定义开始：-----------------------
	* 名称：getTopologyString
	* 功能：获得当前工作流的拓扑信息。
	* 参数：
	* 传回：TopologyString:字符串形式的拓扑信息。
	* 备注：
	*/
	this.getTopologyString=function(){
		this.setWFSchemaFromGraphic();
		var TopologyString = this.schema.xml.replace("<?xml version=\"1.0\"", "<?xml version=\"1.0\" encoding=\"utf-8\"");
		return TopologyString;
	}
	//--------------getTopologyString()定义结束。-----------------------

	/**--------------writeToString()定义开始：-----------------------
	* 名称：writeToString
	* 功能：将当前工作流的拓扑定义信息转化为字符串，并将该字符串保存为本地文件。
	* 参数：
	* 传回：TopologyString:字符串形式的拓扑信息。
	* 备注：
	*/
	this.writeToString = function() {
		this.setWFSchemaFromGraphic();
		xmltostring_shema = this.schema.xml.replace("<?xml version=\"1.0\"", "<?xml version=\"1.0\" encoding=\"utf-8\"");
		//alert("xmltostring_shema="+xmltostring_shema);
		var a_fso, a_f, a_ts, a_s;
		var ForReading = 1, ForWriting = 2, ForAppending = 8;
		var TristateUseDefault = -2, TristateTrue = -1, TristateFalse = 0;
		a_fso = new ActiveXObject("Scripting.FileSystemObject");
		a_fso.CreateTextFile( "D:\\testflow.xml",true); 
		a_f = a_fso.GetFile("D:\\testflow.xml");
		a_ts= a_f.OpenAsTextStream(ForWriting, TristateUseDefault);
		a_ts.Write(xmltostring_shema);
		a_ts.Close( );
		//
	}
	//--------------writeToString()定义结束。-----------------------
	
	/**--------------setWFSchemaFromGraphic()定义开始：-----------------------
	* 名称：setWFSchemaFromGraphic
	* 功能：将当前工作流的拓扑定义信息保存为XML格式。
	* 参数：
	* 传回：
	* 备注：根据流程设计器中的图元和连线元素设置工作流拓扑定义(currentTopologyObject的xml数据)。
	*/
	this.setWFSchemaFromGraphic = function() {
		var n = this.schema.selectSingleNode("TopoInfo/Vector2D");
		n.setAttribute("name", this.name);
		var i;
		for (i=0; i<AllIconsArray.length; i++) {
			var icon = AllIconsArray[i];
			var state = icon.activity;
			var actName = state.selectSingleNode("propertyList/property[@name='activityName']/value");
			state.setAttribute("x", icon.img.offsetLeft);
			state.setAttribute("y", icon.img.offsetTop);
			actName.text = icon.displayName;
			//保存活动的id:
			state.setAttribute("id",icon.id);
			//保存活动的提示信息：
			var tipsInfo=state.selectSingleNode("propertyList/property[@name='tips']/value");
			tipsInfo.text=icon.tips;
		}
		for (i=0; i<AllLinesArray.length; i++) {
			var line = AllLinesArray[i];
			var conn = line.connector;
			var from = conn.selectSingleNode("from");
			var to   = conn.selectSingleNode("to");
			from.text =line.iconBegin.id;
			to.text   =line.iconEnd.id;
			conn.setAttribute("id", line.lineID);
			var dispName = conn.selectSingleNode("propertyList/property[@name='displayName']/value");
			dispName.text = line.displayName;
			var bendpoints = conn.selectSingleNode("bendpoints");
			deleteAllChild(bendpoints);
			for (var j=0; j<line.points.length; j++) {
				var bendpoint = this.schema.createNode("element", "bendpoint", "");
				var p = line.points[j];
				var w1 = p.x - line.begin.x;
				var h1 = p.y - line.begin.y;
				var w2 = p.x - line.end.x;
				var h2 = p.y - line.end.y;
				bendpoint.setAttribute("w1", w1);
				bendpoint.setAttribute("h1", h1);
				bendpoint.setAttribute("w2", w2);
				bendpoint.setAttribute("h2", h2);
				bendpoints.appendChild(bendpoint);
			}
		}
	}
	//--------------setWFSchemaFromGraphic()定义结束。-----------------------

}
