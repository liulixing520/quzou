/*
* 名称：show2d.js
* 功能：工作流管理系统可视化工具中基本元素的构造。
* 备注：
* 最后修改时间：
*	增加了以下方法：
*	(1)function ActObject(theId,theDisplayName,theType,theTips)
*	(2)function ConObject(theId,theDisplayName,theFrom,theTo)
*	修订原因：为了支持新需求，即：根据JaWE生成的流程定义数据，由图形库自动生成默认的工作流拓扑图。
*	在生成连线时，增加了连线ID的判断
*	修订原因：在由jawe生成默认的拓扑图时，程序中没有使用传过来的连线ID。
*/

//为全局变量，定义当前流程的可视化编辑器中所用到的图标的相对路径：
var IconsPath = "/sysCommon/images/webflow/images/flow/"; 

//为全局变量，包括画板上所有的图元对象:
var AllIconsArray = new Array();

//为全局变量，包括画板上所有的连线对象:
var AllLinesArray = new Array();	

//为全局变量，定义当前被鼠标点击的连线对象:
var ClickedLineObject = null;		

//为全局变量，定义当前被鼠标点击的图标对象:
var ClickedIconObject = null;

//为全局变量，定义工作流是否处于监控状态[true/false]:
//var MonitorProcess = false;

//为全局变量，定义当前工作流定义中处于正在处理状态[running]的活动集合：
//var AllWorkingActivities=new Array();

//为全局变量，定义图标大小的二分之一值:
var HarfSizeOfIcon = 20;

//为全局变量，定义开始拖动图元时的x坐标:
var XofBeginDrag = 0;

//为全局变量，定义开始拖动图元时的y坐标:
var YofBeginDrag = 0;

/**--------------showMenu()定义开始：-----------------------
* 名称：showMenu
* 功能：根据传入的id显示右键菜单。
* 参数：
*     1. id:右键菜单的类型(lineMenu或者iconMenu)。
* 传回：无。
* 备注：
*/
function showMenu(id)
{
    //alert("ClickedLineObject="+ClickedLineObject.lineID);
	if('lineMenu' == id)
    {
        popMenu(linediv,120,"111111111111111");
        
    }
     if('iconMenu' == id)
    {
        popMenu(icondiv,120,"11");
    }
    event.returnValue=false;	//设置事件的返回值。
    event.cancelBubble=true;	//设置当前事件是否要在事件句柄中向上冒泡。
    return false;
}
//--------------showMenu()定义结束。-----------------------

/**--------------popMenu()定义开始：-----------------------
* 名称：popMenu
* 功能：显示弹出菜单。
* 参数：
*     1. menuDiv:右键菜单的内容。
*     2. width:行显示的宽度。
*     3. rowControlString:行控制字符串，0表示不显示，1表示显示，如“101”，则表示第1、3行显示，第2行不显示。
* 传回：
* 备注：
*/
function popMenu(menuDiv,width,rowControlString)
{
    //创建弹出菜单
    var pop=window.createPopup();
    //设置弹出菜单的内容
    pop.document.body.innerHTML=menuDiv.innerHTML;
	//alert(menuDiv.innerHTML);
    var rowObjs=pop.document.body.all[0].rows;
	
    //获得弹出菜单的行数
    var rowCount=rowObjs.length;
    //循环设置每行的属性
    for(var i=0;i<rowObjs.length;i++)
    {
        //如果设置该行不显示，则行数减一
        var hide=rowControlString.charAt(i)!='1';
        if(hide){
            rowCount--;
        }
        //设置是否显示该行
        rowObjs[i].style.display=(hide)?"none":"";
        //设置鼠标滑入该行时的效果
        rowObjs[i].cells[0].onmouseover=function()
        {
			this.style.background="58a89d";
            this.style.color="white";
        }

        //设置鼠标滑出该行时的效果
        rowObjs[i].cells[0].onmouseout=function(){
			this.style.background="#cecece";
            this.style.color="black";
        }
        
    }
    //屏蔽菜单的菜单
    pop.document.oncontextmenu=function()
    {
            return false;
    }
    //选择右键菜单的一项后，菜单隐藏
    pop.document.onclick=function()
    {
            pop.hide();
    }
    //显示菜单
    pop.show(event.clientX-1,event.clientY,width,rowCount*25,document.body);
    return true;
}
//--------------popMenu()定义结束。-----------------------

/**
 * 图元对象
 */
//===================图元对象的定义开始：=========================================
function IconObject()
{
	this.type;			// 类型
	this.id;			// id编号
	this.displayName;	//显示名称
	this.tips="活动的提示信息。";	//当光标移动到该活动上时，所显示的提示信息
	this.activity;		// 工作流currentTopologyObject中的state的xml节点对象
	this.states;		//用于存放流程模板对应的states节点
	
	// 图元的图片对象
	//this.img = document.createElement("<img style='position:absolute;'>");
	this.img = document.createElement("img");
	this.img.style.position="absolute";
	
	// 图元中的文字对象
	//this.text = document.createElement("<input type='text' readonly='true'  style='position:absolute;background:transparent;border:0;font-size:9pt;text-align:center'>");
	this.text = document.createElement("input");
	this.text.type="text";
	this.text.readonly="true";
	
	this.text.style.position = "absolute";
	this.text.style.background = "transparent";
	this.text.style.border = "0";
	this.text.style.fontSize = "9pt";
	this.text.style.textAlign = "center";
	this.text.style.position = "absolute";
	
	this.text.style.display = "none";
	this.text.icon = this;
	//在右键单击图元时，将当时所有图元数组对象传给该变量，用于在图元的属性对话框中处理图元的ID：
	this.tempAllIconsArray=null;	

	this.init = initIcon;			// 初始化图元方法
	this.createLine = _createLine;	// 创建连线方法
	this.redrawLine = _redrawLine;	// 重新画与图元连接的连线方法
	this.moveText = _moveText;		// 托拽图元后移动文字对象方法
	this.setDisplayName =  _setIconDisplayName; // 设置显示名称

	this.beginLine = new Array();	// 以图元开始的连线
	this.endLine = new Array();		// 以图元结束的连线

	this.img.ondblclick = function () //
	{ 
		//
		//alert("ClickedIconObject.id="+ClickedIconObject.id);
		//ClickedIconObject.modify("activity.2","测试的活动","这是测试活动的提示信息。");
	}
	
	/**--------------modify()定义开始：-----------------------
	* 名称：modify
	* 功能：设置图标的部分属性。
	* 参数：
	*     1. newID:图标新的标识号。
	*     2. newDisplayName:图标新的显示名称。
	*     3. newTipsInfo:图标新的提示信息。
	* 传回：无。
	* 备注：
	*/
	this.modify=function(newID,newDisplayName,newTipsInfo){
		if(newID==null){
			alert("图标新的ID没有设置。");
			return;
		}
		if(newDisplayName==null){
			alert("图标新的显示名称没有设置。");
			return;
		}
		if(newTipsInfo==null){
			alert("图标新的提示信息没有设置。");
			return;
		}
		
		//先要修改与该活动关联的连线的有关属性：
		for(var i=0;i<ClickedIconObject.beginLine.legnth;i++){
			ClickedIconObject.beginLine[i].connector.selectSingleNode("from").text=newID;
			ClickedIconObject.beginLine[i].iconBegin.id=newID;
		}
		for(var i=0;i<ClickedIconObject.endLine.legnth;i++){
			ClickedIconObject.endLine[i].connector.selectSingleNode("to").text=newID;
			ClickedIconObject.endLine[i].iconEnd.id=newID;
		}
		//再修改当前活动的新属性：
		//alert("before:ClickedIconObject.id="+ClickedIconObject.id+";ClickedIconObject.displayName="+ClickedIconObject.displayName);
		this.id=newID;
		this.setDisplayName(newDisplayName);
		this.tips=newTipsInfo;
		this.img.alt=this.tips;	//活动的提示信息。
		this.moveText();		
		//alert("after:ClickedIconObject.id="+ClickedIconObject.id+";ClickedIconObject.displayName="+ClickedIconObject.displayName);
	}
	//--------------modify()定义结束。-----------------------
	
	/**--------------initIcon()定义开始：-----------------------
	* 名称：initIcon
	* 功能：初始化图元对象(对应工作流设计器中的活动)。
	* 参数：
	*     1. type:图元类型。
	*     2. x:图元的横坐标。
	*     3. y:图元的纵坐标。
	*     4. activityName:图元的显示名称。
	*     5. working:图元对应的工作流活动当前是否处于running状态。
	* 传回：无。
	* 备注：
	*/
	function initIcon(type, x, y, activityName,working)
	{
		//alert("working="+working);
		this.type = type;
		
		switch (type) {
			case "ManualActivity":
				//设置图片路径
				if (working==true)
					this.img.src = IconsPath + "manual_working.gif";
				else
					this.img.src = IconsPath + "manual.gif";
				//设置图标缺省文字
				this.displayName = "人工活动";
				break;
			case "AutoActivity":
				if (working==true)
					this.img.src = IconsPath + "auto_working.gif";
				else
					this.img.src = IconsPath + "auto.gif";
				this.displayName = "自动活动";
				break;
			case "RouterActivity":
				if (working==true)
					this.img.src = IconsPath + "router_working.gif";
				else
					this.img.src = IconsPath + "router.gif";
				this.displayName = "路由活动";
				break;
			case "SubActivity":
				if (working==true)
					this.img.src = IconsPath + "subflow_working.gif";
				else
					this.img.src = IconsPath + "subflow.gif";
				this.displayName = "子流程";
				break;
			case "StartActivity":
				if (working==true)
					this.img.src = IconsPath + "start_working.gif";
				else
					this.img.src = IconsPath + "start.gif";
				//-----------------------
				this.displayName = "开始";
				break;
			case "EndActivity":
				if (working==true)
					this.img.src = IconsPath + "end_working.gif";
				else
					this.img.src = IconsPath + "end.gif";
				this.displayName = "结束";
				break;
			default:
				if (working==true)
					this.img.src = IconsPath + "manual_working.gif";
				else
					this.img.src = IconsPath + "manual.gif";
				this.displayName = "人工活动";
				break;
		}
		
		this.img.alt=this.tips;	//活动的提示信息。
		document.body.appendChild(this.img);
		if (activityName != null) this.displayName = activityName;
		this.img.style.left = x+"px";
		this.img.style.top = y+"px";
		
		this.img.icon = this;

		// 定义图片对象的开始托拽事件
		this.img.ondragstart = function(){
			//当非监控状态时，才处理图元的拖拽事件:
			if(MonitorProcess == false){
				this.setCapture();
				XofBeginDrag=event.x-this.offsetLeft;
				YofBeginDrag=event.y-this.offsetTop;
			}
		}
		// 定义图片对象的托拽事件
		this.img.ondrag = function(){
			//不能从结束结点开始画线：
			if (drawLineStatus && this.icon.type == "EndActivity")
				return;
			//当非监控状态,同时亦非画线状态时，才处理图元的拖拽事件:
			if (!drawLineStatus && MonitorProcess == false) {	
				this.style.left=event.x-XofBeginDrag;
				this.style.top=event.y-YofBeginDrag;
				this.icon.redrawLine();
			}
		}
		
		// 定义图片对象的托拽结束
		this.img.ondragend = function(){
			this.releaseCapture();
			//不能从结束结点开始画线：
			if (drawLineStatus && this.icon.type == "EndActivity")
				return;
			if (drawLineStatus){
				//当在图元上方释放鼠标的时候，在两个节点之间画线
				//alert('drag end');
				this.icon.createLine(this, event.x, event.y);
				newVersion = true;
			}
			//可以拖动时，拖动图标后和图标连接的线需要重新绘制
			else  {
				//当非监控状态,同时亦非画线状态时，才处理图元的拖拽事件:
				if(MonitorProcess == false){
					this.icon.redrawLine();
				}
			}
		}
		
		// 定义图片对象的右键菜单，并且将此图元对应的一些相关信息传给右键菜单对应的方法
		this.img.oncontextmenu = function() {
			ClickedIconObject = this.icon;
			showMenu('iconMenu');
			return false;
		}

		//定义图元图标的单击事件：
		this.img.onclick=function(){
				ClickedIconObject = this.icon;
//				ClickedIconObject = window;
		}

		//显示环节名称：
		document.body.appendChild(this.text);
		this.text.style.display = "block";
		this.text.value = this.displayName;
		/*
		//onchage事件
		this.text.onchange = function() {
			
			this.icon.displayName = this.value;
			this.icon.activity.selectSingleNode("propertyList/property[@name='activityName']/value").text=this.value;
		}
		*/		
		this.moveText();
	}
	//--------------initIcon()定义结束。-----------------------

	/**--------------_createLine()定义开始：-----------------------
	* 名称：_createLine
	* 功能：定义图元的画线方法。
	* 参数：
	*     1. x:画线结束点的横坐标。
	*     2. y:画线结束点的纵坐标。
	* 传回：
	* 备注：
	*/
	function _createLine(obj, x, y) {
		//查找线结束的图元
		var iconEnd = locateIcon(x, y);
		if (iconEnd != null && iconEnd != this) {
			var linelength = AllLinesArray.length;
			AllLinesArray[linelength] = new LineObject();
			//显示连线上的文字：
			AllLinesArray[linelength].text.value = AllLinesArray[linelength].displayName;
			//AllLinesArray[linelength].text.value = "测试";
			//初始化连线：
			AllLinesArray[linelength].init(this, iconEnd);
			//在currentTopologyObject中添加connector节点
			currentTopologyObject.create_connector(AllLinesArray[linelength]);
		}
	}
	//--------------_createLine()定义结束。-----------------------
	
	/**--------------_redrawLine()定义开始：-----------------------
	* 名称：_redrawLine
	* 功能：定义图元的重新画线方法。
	* 参数：
	* 传回：
	* 备注：
	*/
	function _redrawLine() {
		var i=0;
		for (i=0; i< this.beginLine.length;i++)
			this.beginLine[i].redraw();
		for (i=0; i< this.endLine.length; i++)
			this.endLine[i].redraw();
		this.moveText();
	}
	//--------------_redrawLine()定义结束。-----------------------
	
	/**--------------_moveText()定义开始：-----------------------
	* 名称：_moveText
	* 功能：设置图元显示名称的位置。
	* 参数：
	* 传回：
	* 备注：
	*/
	function _moveText() {
		this.text.style.left = this.img.offsetLeft + (HarfSizeOfIcon - LengthOfChar(this.displayName) * 5)+"px";
		this.text.style.top = this.img.offsetTop + HarfSizeOfIcon * 2 + 2+"px";
		this.text.style.width = LengthOfChar(this.displayName) * 10+"px";
	}
	//--------------_moveText()定义结束。-----------------------
	
	/**--------------_setIconDisplayName()定义开始：-----------------------
	* 名称：_setIconDisplayName
	* 功能：设置图元的显示名称。
	* 参数：value:图元的显示名称。
	* 传回：
	* 备注：
	*/
	function  _setIconDisplayName(value) {
		this.displayName = value;
		this.text.value = value;
	}
	//--------------_setIconDisplayName()定义结束。-----------------------
}
//===================图元对象的定义结束=========================================

/**--------------Point()定义开始：-----------------------
* 名称：Point
* 功能：定义点对象。
* 参数：
*     1. XofCoordinate:X坐标。
*	  2. YofCoordinate:Y坐标。
* 传回：无。
* 备注：
*/
function Point(XofCoordinate, YofCoordinate)
{
	this.x = XofCoordinate;
	this.y = YofCoordinate;
}
//--------------Point()定义结束。-----------------------

/**
 * 连线对象
 */
 //===================连线对象的定义开始：=========================================
function LineObject() 
{
	this.lineID="0";			// 连线的标识号
	this.displayName="连线";	// 连线上的显示名称

	this.color="black";			// 连线颜色
	this.points = new Array();	// 连线中的转折点对象

	this.begin;			// 连线开始坐标（开始图元的中心点）
	this.end;			// 连线结束坐标（结束图元的中心点）

	this.iconBegin;		// 连线开始图元对象
	this.iconEnd;		// 连线结束图元对象
	
	// 连线图形对象
	this.lineImg = document.createElement("DIV");
	this.lineImg.style.display = "none";
	this.lineImg.line = this;
	document.body.appendChild(this.lineImg);
	
	// 连线中的文字对象
	//this.text = document.createElement("<input type='text' readonly='true'  style='position:absolute;background:transparent;border:0;font-size:9pt;text-align:center'>");
	this.text = document.createElement("input");
	this.text.type="text";
	this.text.style.position = "absolute";
	this.text.style.background = "transparent";
	this.text.style.border = "0";
	this.text.style.fontSize = "9pt";
	this.text.style.textAlign = "center";
	this.text.style.display = "none";
	this.text.line = this;
	this.text.onchange = function() {
		this.line.displayName = this.value;
	}
	document.body.appendChild(this.text);

	this.connector=null;		// 连线对应的工作流的currentTopologyObject中的connector节点

	//在右键单击连线时，将当时所有连线数组对象传给该变量，用于在连线的属性对话框中处理连线的ID：
	this.tempAllLinesArray=null;
	this.states;		//对应整个流程定义上的图元节点
	
	this.init = _initLine;				// 连线初始化方法
	this.show = _showLine;				// 连线显示方法
	this.hiddenLine = _hiddenLine;		// 连线隐藏方法
	
	this.draw = _draw;					// 绘制连线方法
	this.drawLine = _drawLine;			// 画线方法
	this.drawText = _drawText;			// 绘制连线文字
	this.redraw = _redraw;				// 重新绘制连线方法
	this.setDisplayName = _setLineDisplayName; //设置连线的显示名称
	this.startDrag = false;				// 连线是否被托拽

	this.lineImg.ondblclick = function () //设置连线的双击事件
	{ 
		//
	}
	
	/**--------------modify()定义开始：-----------------------
	* 名称：modify
	* 功能：设置连线的部分属性。
	* 参数：
	*     1. newID:连线新的标识号。
	*     2. newDisplayName:连线新的显示名称。
	* 传回：无。
	* 备注：
	*/
	this.modify=function(newID,newDisplayName){
		if(newID==null){
			alert("连线新的ID没有设置。");
			return;
		}
		if(newDisplayName==null){
			alert("连线新的显示名称没有设置。");
			return;
		}
		//alert("before:ClickedLineObject.lineID="+ClickedLineObject.lineID+";ClickedLineObject.DisplayName="+ClickedLineObject.displayName);
		this.lineID=newID;
		this.setDisplayName(newDisplayName);
		//alert("after set:ClickedLineObject.lineID="+ClickedLineObject.lineID+";ClickedLineObject.DisplayName="+ClickedLineObject.displayName);	
	}
	//--------------modify()定义结束。-----------------------

	/**--------------_initLine()定义开始：-----------------------
	* 名称：_initLine
	* 功能：初始化连线。
	* 参数：
	*     1. iconBegin:连线的开始图元对象。
	*     2. iconEnd:连线的结束图元对象。
	*     3. lineId:连线的标识。
	*     4. color:连线的颜色。
	* 传回：
	* 备注：
	*/
	function _initLine(iconBegin, iconEnd,lineId,color) {
		if (lineId != null)
			this.lineID = lineId;
		else
		    this.lineID=generateNewLineId();	//产生新的可用的连线ID。

		this.iconBegin = iconBegin;
		this.iconEnd = iconEnd;
		this.begin = new Point(this.iconBegin.img.offsetLeft + HarfSizeOfIcon, this.iconBegin.img.offsetTop + HarfSizeOfIcon);
		this.end = new Point(this.iconEnd.img.offsetLeft + HarfSizeOfIcon, this.iconEnd.img.offsetTop + HarfSizeOfIcon);
		if (color != null)
			this.color = color;
		else
			//alert("this.color="+this.color);
		this.iconBegin.beginLine.push(this);
		this.iconEnd.endLine.push(this);
		this.draw();
		this.drawText();	//
		this.show();
		//触发事件:
		if (LoadProcessFlag==false)		//全局变量,从数据库装入流程定义时，为true;新建流程时，为false。
		{
			var LineNodeID=this.lineID;
			var LineNodeName=this.displayName;
			var FromNodeID=this.iconBegin.id;
			var FromNodeName=this.iconBegin.displayName;
			var ToNodeID=this.iconEnd.id;
			var ToNodeName=this.iconEnd.displayName;
			currentTopologyObject.eventInterfaceObject.AddLineEvent(LineNodeID,LineNodeName,FromNodeID,FromNodeName,ToNodeID,ToNodeName);
		}
		//
	}
	//--------------_initLine()定义结束。-----------------------

	/**--------------_draw()定义开始：-----------------------
	* 名称：_draw
	* 功能：画连线。
	* 参数：
	* 传回：
	* 备注：主要完成具体画线之前的准备工作。
	*/
	function _draw() {
		var linePath = "";
		if (this.points.length <= 0) {
			if(this.begin.x==this.end.x && this.begin.y==this.end.y){
				//linePath = calSelfToSelf(this,this.begin);
			}
			else{
				var b = adjustBeginPoint(this.begin, this.end);
				var e = adjustEndPoint(this.begin, this.end);
				linePath=b.x+","+b.y+" "+e.x+","+e.y;
			}
			this.drawLine(linePath,this.color);
		} else {
			var b = adjustBeginPoint(this.begin, this.points[0]);
			//this.drawLine(b.x, b.y, this.points[0].x, this.points[0].y);
			linePath = b.x+","+b.y+" ";
			for (var i=0; i < this.points.length; i++) {
				var p = this.points[i];
				linePath = linePath+" "+this.points[i].x+","+ this.points[i].y;
				if ((i+1) == this.points.length) {
					var e = adjustEndPoint(p, this.end);
					linePath = linePath+" "+e.x+","+ e.y;
					
					this.drawLine(linePath,this.color);
					break;
				} 
			}
		}
		this.drawText();
	}
	//--------------_draw()定义结束。-----------------------
	
	/**--------------_drawLine()定义开始：-----------------------
	* 名称：_drawLine
	* 功能：使用VML完成具体画线功能。
	* 参数：
	*     1. p_linePath:组成连线的转折点集合。
	*     2. p_color:连线的颜色。
	* 传回：
	* 备注：
	*/
	function _drawLine(p_linePath,p_color) {

	  //var   lineStr="<v:PolyLine filled='false' Points='"+p_linePath+"' style='position:absolute;' ></v:PolyLine>";
	  var   lineStr="<v:PolyLine  StrokeColor='"+p_color+"' filled='false' Points='"+p_linePath+"' style='position:absolute;' ></v:PolyLine>";
	  //var   line=document.createElement(lineStr);
	  var line=document.createElement("v:PolyLine");
	  line.StrokeColor=p_color;
	  line.filled='false';
	  line.Points=p_linePath;
	  line.style.position='absolute';
	  //var	stroke = document.createElement("<v:stroke  EndArrow='Classic' dashstyle='Solid' LineStyle='ThinThin'/>");
	  var stroke=document.createElement("v:stroke");
	  stroke.EndArrow='Classic';
	  stroke.dashstyle='Solid';
	  stroke.LineStyle='ThinThin';
		line.insertBefore(stroke);
		line.line = this;

		line.oncontextmenu = function() {
			ClickedLineObject = this.line;
			showMenu('lineMenu');
			return false;
		}
		line.onclick=function(){
			ClickedLineObject = this.line;
		}
		
		this.lineImg.appendChild(line);
	} 
	//--------------_drawLine()定义结束。-----------------------

	/**--------------_drawText()定义开始：-----------------------
	* 名称：_drawText
	* 功能：设置连线上的文字。
	* 参数：
	* 传回：
	* 备注：
	*/
	function _drawText() {
		var sumX = 0;
		var sumY = 0;
		var computedTextPosition = false;
		var curBegin = new Point(this.begin.x, this.begin.y);
		var curEnd = new Point(this.end.x, this.end.y);
		if (this.points.length == 0) {
			curBegin = adjustBeginPoint(curBegin, curEnd);
			curEnd = adjustEndPoint(curBegin, curEnd);
			sumX = parseInt((curBegin.x + curEnd.x) / 2);
			sumY = parseInt((curBegin.y + curEnd.y) / 2);
		} else {
			if ((this.points.length % 2) == 0) {
				var p = parseInt(this.points.length/2)-1;
				sumX = parseInt((this.points[p].x + this.points[p+1].x) / 2);
				sumY = parseInt((this.points[p].y + this.points[p+1].y) / 2);
			} else {
				var p = parseInt(this.points.length/2);
				sumX = this.points[p].x;
				sumY = this.points[p].y;
			}
		}
		this.text.style.left = sumX - LengthOfChar(this.displayName) * 5+"px";
		this.text.style.top = sumY+"px";
		this.text.style.width = LengthOfChar(this.displayName) * 10+"px"; 
	}
	//--------------_drawText()定义结束。-----------------------
	
	/**--------------_redraw()定义开始：-----------------------
	* 名称：_redraw
	* 功能：重新画线。
	* 参数：
	* 传回：
	* 备注：
	*/
	function _redraw() {
		removeLineImg(this.lineImg);
		this.lineImg = document.createElement("DIV");
		this.lineImg.style.display = "none";
		this.lineImg.line = this;
		document.body.appendChild(this.lineImg);
		this.begin = new Point(this.iconBegin.img.offsetLeft + HarfSizeOfIcon, this.iconBegin.img.offsetTop + HarfSizeOfIcon);
		this.end = new Point(this.iconEnd.img.offsetLeft + HarfSizeOfIcon, this.iconEnd.img.offsetTop + HarfSizeOfIcon);
		this.draw();
		this.show();
	}
	//--------------_redraw()定义结束。-----------------------

	/**--------------_showLine()定义开始：-----------------------
	* 名称：_showLine
	* 功能：显示连线。
	* 参数：
	* 传回：
	* 备注：
	*/
	function _showLine() {
		this.lineImg.style.display = "block";
		this.text.style.display = "block";
	}
	//--------------_showLine()定义结束。-----------------------
	
	/**--------------_hiddenLine()定义开始：-----------------------
	* 名称：_hiddenLine
	* 功能：隐藏连线。
	* 参数：
	* 传回：
	* 备注：
	*/
	function _hiddenLine() {
		this.lineImg.style.display = "none";
		this.text.style.display = "none";
	}
	//--------------_hiddenLine()定义结束。-----------------------
	
	/**--------------_setLineDisplayName()定义开始：-----------------------
	* 名称：_setLineDisplayName
	* 功能：设置连线上的文字。
	* 参数：
	* 传回：
	* 备注：
	*/
	function _setLineDisplayName(value) {
		this.displayName = value;
		this.text.value = value;
	}
	//--------------_setLineDisplayName()定义结束。-----------------------
}
//===================连线对象的定义结束=========================================

/**--------------adjustBeginPoint()定义开始：-----------------------
* 名称：adjustBeginPoint
* 功能：调整连线开始点的位置。
* 参数：
*     1. beginPoint:开始点对象。
*     2. endPoint:结束点对象。
* 传回：Point:调整后的开始点对象。
* 备注：因为连线开始点的坐标在图标中，而连线开始位置不能画在图标中间，故需要重新调整。
*/
function adjustBeginPoint(beginPoint, endPoint)
{
	var dispersionX = endPoint.x - beginPoint.x;	//X坐标的差值
	var dispersionY = endPoint.y - beginPoint.y;	//Y坐标的差值
	if (dispersionX == 0 && dispersionY == 0)		//开始点和结束点重合				
		return beginPoint;
	if (dispersionX == 0)	//开始点和结束点在垂直线上
		if (dispersionY < 0)	//开始点位于结束点的正下方
			return new Point(beginPoint.x, beginPoint.y - HarfSizeOfIcon);
		else					//开始点位于结束点的正上方
			return new Point(beginPoint.x, beginPoint.y + HarfSizeOfIcon);
	if (dispersionY == 0)	//开始点和结束点在水平线上
		if (dispersionX < 0)	//开始点位于结束点的正右方
			return new Point(beginPoint.x - HarfSizeOfIcon, beginPoint.y);
		else					//开始点位于结束点的正左方
			return new Point(beginPoint.x + HarfSizeOfIcon, beginPoint.y);
	//
	dispersionXabs = Math.abs(dispersionX);	//取绝对值
	dispersionYabs = Math.abs(dispersionY);	//取绝对值
	//计算开始点和结束点之间的直线距离：
	var decline = parseInt(Math.sqrt(Math.pow(dispersionXabs, 2) + Math.pow(dispersionYabs, 2)));
	//按比例计算开始点应增加或减少的水平距离和垂直距离：
	var offsetX = parseInt((HarfSizeOfIcon * dispersionXabs) / decline);
	var offsetY = parseInt((HarfSizeOfIcon * dispersionYabs) / decline);
	if (dispersionX < 0 && dispersionY < 0)	//开始点位于结束点的右下方
		return new Point(beginPoint.x - offsetX, beginPoint.y - offsetY);
	if (dispersionX < 0)					//开始点位于结束点的右上方
		return new Point(beginPoint.x - offsetX, beginPoint.y + offsetY);
	if (dispersionY < 0)					//开始点位于结束点的左下方
		return new Point(beginPoint.x + offsetX, beginPoint.y - offsetY);
	else									//开始点位于结束点的左上方
		return new Point(beginPoint.x + offsetX, beginPoint.y + offsetY); 
}
//--------------adjustBeginPoint()定义结束。----------------------------------------------

/**--------------adjustEndPoint()定义开始：-----------------------
* 名称：adjustEndPoint
* 功能：调整连线结束点的位置。
* 参数：
*     1. beginPoint:开始点对象。
*     2. endPoint:结束点对象。
* 传回：Point:调整后的结束点对象。
* 备注：因为连线结束点的坐标在图标中，而连线结束位置不能画在图标中间，故需要重新调整。
*/
function adjustEndPoint(beginPoint, endPoint)
{	
	
	var dispersionX = endPoint.x - beginPoint.x;		//X坐标的差值
	var dispersionY = endPoint.y - beginPoint.y;		//Y坐标的差值
	if (dispersionX == 0 && dispersionY == 0)			//开始点和结束点重合
		return endPoint;
	if (dispersionX == 0)	//开始点和结束点在垂直线上
		if (dispersionY < 0)	//开始点位于结束点的正下方
			return new Point(endPoint.x, endPoint.y + HarfSizeOfIcon);
		else					//开始点位于结束点的正上方
			return new Point(endPoint.x, endPoint.y - HarfSizeOfIcon);
	if (dispersionY == 0)	//开始点和结束点在水平线上
		if (dispersionX < 0)	//开始点位于结束点的正右方
			return new Point(endPoint.x + HarfSizeOfIcon, endPoint.y);
		else					//开始点位于结束点的正左方
			return new Point(endPoint.x - HarfSizeOfIcon, endPoint.y);
	dispersionXabs = Math.abs(dispersionX);	//取绝对值
	dispersionYabs = Math.abs(dispersionY);	//取绝对值
	//计算开始点和结束点之间的直线距离：
	var decline = parseInt(Math.sqrt(Math.pow(dispersionXabs, 2) + Math.pow(dispersionYabs, 2)));
	//按比例计算开始点应增加或减少的水平距离和垂直距离：
	var offsetX = parseInt((HarfSizeOfIcon * dispersionXabs) / decline);
	var offsetY = parseInt((HarfSizeOfIcon * dispersionYabs) / decline);
	if (dispersionX < 0 && dispersionY < 0)	//开始点位于结束点的右下方
		return new Point(endPoint.x + offsetX, endPoint.y + offsetY);
	if (dispersionX < 0)					//开始点位于结束点的右上方
		return new Point(endPoint.x + offsetX, endPoint.y - offsetY);
	if (dispersionY < 0)					//开始点位于结束点的左下方
		return new Point(endPoint.x - offsetX, endPoint.y + offsetY);
	else									//开始点位于结束点的左上方
		return new Point(endPoint.x - offsetX, endPoint.y - offsetY);
}
//--------------adjustEndPoint()定义结束。----------------------------------------------

/**--------------deleteAllChild()定义开始：-----------------------
* 名称：deleteAllChild
* 功能：将指定的XML数据对象的所有下级对象删除掉。
* 参数：
*     1. theXmlObject:指定的XML数据对象。
* 传回：无。
* 备注：
*/
function deleteAllChild(theXmlObject) {
	for (var m=theXmlObject.childNodes.length-1; m>=0; m--) 
		theXmlObject.removeChild(theXmlObject.childNodes[m]);
}
//--------------deleteAllChild()定义结束。-----------------------

/**--------------removeLineImg()定义开始：-----------------------
* 名称：removeLineImg
* 功能：删除指定的连线图形对象。
* 参数：
*     1. theLineImg:连线的图形对象(为DIV元素)。
* 传回：无。
* 备注：
*/
function removeLineImg(theLineImg) {
	theLineImg.line = null;
	theLineImg.onclick = null;
	theLineImg.ondblclick = null;
	theLineImg.oncontextmenu = null;
	document.body.removeChild(theLineImg);
}
//--------------removeLineImg()定义结束。-----------------------

/**--------------removeTextElement()定义开始：-----------------------
* 名称：removeTextElement
* 功能：删除指定的连线文本对象。
* 参数：
*     1. theTextElement:连线中的文字对象(为<input type='text'>元素)。
* 传回：无。
* 备注：
*/
function removeTextElement(theTextElement) {
	theTextElement.line = null;
	theTextElement.icon = null;
	theTextElement.onchange = null;
	document.body.removeChild(theTextElement);
}
//--------------removeTextElement()定义结束。-----------------------

/**--------------deleteClickedLine()定义开始：-----------------------
* 名称：deleteClickedLine
* 功能：删除当前用鼠标选中的连线。
* 参数：
* 传回：
* 备注：
*/
function deleteClickedLine() {
	if (ClickedLineObject != null) {
		//alert("ClickedLineObject != null.");
		deleteLine(ClickedLineObject);
	}
}
//--------------deleteClickedLine()定义结束。-----------------------

/**--------------deleteLine()定义开始：-----------------------
* 名称：deleteLine
* 功能：删除当前指定的连线。
* 参数：
*     1. theLine:将被删除的连线。
* 传回：
* 备注：
*/
function deleteLine(theLine) {
	//-----------获取触发事件所需要的参数：------------------
	var LineNodeID=theLine.lineID;
	var LineNodeName=theLine.displayName;
	var FromNodeID=theLine.iconBegin.id;
	var FromNodeName=theLine.iconBegin.displayName;
	var ToNodeID=theLine.iconEnd.id;
	var ToNodeName=theLine.iconEnd.displayName;
	//alert("ToNodeName="+ToNodeName);
	//-------------------------------------------------------
	//从该连线开始图标对象中删掉关联项：
	theLine.iconBegin.beginLine.remove(theLine);
	//从该连线结束图标对象中删掉关联项：
	theLine.iconEnd.endLine.remove(theLine);
	//删掉该连线的图形元素(为DIV元素):
	removeLineImg(theLine.lineImg);
	//删掉该连线的文字元素(为<input type='text'>元素):
	removeTextElement(theLine.text);
	newVersion = true;
	//从连线数组中删掉当前连线：
	//alert("before:AllLinesArray.length="+AllLinesArray.length);
	AllLinesArray.remove(theLine);
	//alert("after:AllLinesArray.length="+AllLinesArray.length);
	//删除xml节点的引用:
	if (currentTopologyObject && currentTopologyObject != null) {
		//alert("theLine.connector.xml="+theLine.connector.xml);
		//
		currentTopologyObject.connectors.removeChild(theLine.connector);
		//alert("theLine.expconnector.xml="+theLine.expconnector.xml);
	}
	//触发事件:------------------------------------------
		currentTopologyObject.eventInterfaceObject.DelLineEvent(LineNodeID,LineNodeName,FromNodeID,FromNodeName,ToNodeID,ToNodeName);
	//------------------------------------------------------
}
//--------------deleteLine()定义结束。-----------------------

/**--------------getIconFromId()定义开始：-----------------------
* 名称：getIconFromId
* 功能：根据指定的图标ID号，从包含所有图标的数组中找出该图标。
* 参数：
*     1. theIconId:指定的图标ID号。
* 传回：AllIconsArray[i]:找到的图标对象。
* 备注：
*/
function getIconFromId(theIconId) {
	for (var i=0; i < AllIconsArray.length; i++) {
		if (AllIconsArray[i].id == theIconId)
			return AllIconsArray[i];
	}
	return null;
}
//--------------getIconFromId()定义结束。-----------------------

/**--------------locateIcon()定义开始：-----------------------
* 名称：locateIcon
* 功能：根据x、y坐标，确定当前坐标是否在某个图元上。
* 参数：
*     1. x:X坐标。
*     2. y:Y坐标。
* 传回：无。
* 备注：
*/
function locateIcon(x, y) {
	for (var i=0; i<AllIconsArray.length; i++) {
		if (x > AllIconsArray[i].img.offsetLeft && x < (AllIconsArray[i].img.offsetLeft+40) && y > AllIconsArray[i].img.offsetTop && y <(AllIconsArray[i].img.offsetTop + 40))
			return AllIconsArray[i];
	}
	return null;
}
//--------------locateIcon()定义结束。-----------------------

/**--------------deleteClickedIcon()定义开始：-----------------------
* 名称：deleteClickedIcon
* 功能：删除当前用鼠标选中的图标。
* 参数：
* 传回：
* 备注：
*/
function deleteClickedIcon() {
	if(confirm("删除后将不能恢复，您确认执行删除操作么？")){
		if (ClickedIconObject != null) {
			deleteIcon(ClickedIconObject);
		}
	}else{
		return;
	}
}
//--------------deleteClickedIcon()定义结束。-----------------------

/**--------------deleteIcon()定义开始：-----------------------
* 名称：deleteIcon
* 功能：删除当前指定的图标。
* 参数：
*     1. theIcon:将被删除的图标。
* 传回：
* 备注：
*/
function deleteIcon(theIcon) {
	//-----------获取触发事件所需要的参数：------------------
	var ActivityNodeType=theIcon.type;	
	var ActivityNodeID=theIcon.id;
	var ActivityNodeName=theIcon.displayName;

	// 不能删除开始和结束活动
	if (theIcon.type == "StartActivity" || theIcon.type == "EndActivity")
		return;
	//删除所有从当前指定图标开始的连线：
	for (var i=(theIcon.beginLine.length-1); i>=0; i--) {
		deleteLine(theIcon.beginLine[i]);
	}
	//删除所有结束于当前指定图标的连线：
	for (var i=(theIcon.endLine.length-1); i>=0; i--) {
		deleteLine(theIcon.endLine[i]);
	}
	//从画板上删除当前指定图标：
	document.body.removeChild(theIcon.img);
	document.body.removeChild(theIcon.text);
	newVersion = true;
	//从图标数组中删掉当前图标：
	AllIconsArray.remove(theIcon);
	//
	if (currentTopologyObject && currentTopologyObject != null) {
		currentTopologyObject.states.removeChild(theIcon.activity);
	}
	//触发事件:------------------------------------------
		currentTopologyObject.eventInterfaceObject.DelActivityEvent(ActivityNodeType,ActivityNodeID,ActivityNodeName);
	//------------------------------------------------------	
}
//--------------deleteIcon()定义结束。-----------------------

/**--------------LengthOfChar()定义开始：-----------------------
* 名称：LengthOfChar
* 功能：计算指定字符串的字节长度。
* 参数：
*     1. theString:指定的字符串。
* 传回：theLength:指定字符串的字节长度。
* 备注：如果是双字节的汉字，则字节长度=2.如"中国China"为7个字符,其字节长度=9。
*/
function LengthOfChar(theString) {
    if( theString == null || theString ==  "" ) return 0;
    var theLength = 0;
    for (i = 0; i< theString.length; i++) {		//theString.length表示字符的长度，如"中国China"为7个字符。
        if (theString.charCodeAt(i) > 127)		//如果是双字节的汉字，则字节长度=2.
            theLength += 2;
        else
            theLength++ ;
    }
    return theLength;
}
//--------------LengthOfChar()定义结束。-----------------------

/**--------------Array.prototype.remove()定义开始：-----------------------
* 名称：Array.prototype.remove
* 功能：给JavaScript的内置Array对象增加一个remove方法，便于直接删除数组中指定的对象。
* 参数：
*     1. deleteObject:数组中指定的删除对象。
* 传回：无。
* 备注：
*/
Array.prototype.remove = function(deleteObject) {
	//数组中所包含的被删除对象的个数：
	var countOfSameObject = 0;
	//OldSuffix=数组的原下标,NewSuffix=数组的新下标:
	for(var OldSuffix=0,NewSuffix=0; OldSuffix<this.length; OldSuffix++)
	{
		if (this[OldSuffix] != deleteObject) {
			//将不被删除的数组元素往前移：
			this[NewSuffix++] = this[OldSuffix];
		} else {
			countOfSameObject++;
		}
	}
	//重置数组长度：
	this.length -= countOfSameObject;
}
//--------------Array.prototype.remove()定义结束。-----------------------

/**--------------ifLineIdUsedExceptSelf()定义开始：-----------------------
* 名称：ifLineIdUsedExceptSelf
* 功能：判断指定连线的ID是否已经被其它连线占用。
* 参数：
*     1. theLineID:指定连线的标识号。
* 传回：
*     1. true:已经被其它连线占用。
*     2. false:未被其它连线占用。
*     3. -1:参数为空或者为空格。
* 备注：该ID可能被当前选中的连线占用。
*/
function ifLineIdUsedExceptSelf(theLineID) {
	if(theLineID==null || theLineID=="")
		return -1;
	//
	//alert("AllLinesArray.length="+window.dialogArguments.tempAllLinesArray.length);
	for(var i=0;i<window.dialogArguments.tempAllLinesArray.length;i++){
		if (window.dialogArguments.tempAllLinesArray[i].lineID==window.dialogArguments.lineID){
			continue;
		}
		else{
			if(window.dialogArguments.tempAllLinesArray[i].lineID==theLineID)
			return true;
		}
	}
	return false;
}
//--------------ifLineIdUsedExceptSelf()定义结束。-----------------------

/**--------------ifNewLineIdValid()定义开始：-----------------------
* 名称：ifNewLineIdValid
* 功能：判断新的连线ID是否有效（即未被其它连线占用）。
* 参数：
*     1. theLineID:新连线的标识号。
* 传回：
*     1. true:有效。
*     2. false:无效。
*     3. -1:参数为空或者为空格。
* 备注：
*/
function ifNewLineIdValid(theLineID) {
	if(theLineID==null || theLineID=="")
		return -1;
	//
	for(var i=0;i<AllLinesArray.length;i++){
		if(AllLinesArray[i].lineID==theLineID)
			return false;
	}
	return true;
}
//--------------ifNewLineIdValid()定义结束。-----------------------

/**--------------generateNewLineId()定义开始：-----------------------
* 名称：generateNewLineId
* 功能：产生新的可用的连线ID。
* 参数：
* 传回：newLineId:新的可用的连线ID。
* 备注：
*/
function generateNewLineId() {
	var newLineId=null;
	for(i=1;i>0;i++){
		newLineId="trans"+i+".";
		if(ifNewLineIdValid(newLineId)==true)
			return newLineId;
		else
			continue;
	}
	//
}
//--------------generateNewLineId()定义结束。-----------------------

/**--------------ifNewIconIdValid()定义开始：-----------------------
* 名称：ifNewIconIdValid
* 功能：判断新的图标ID是否有效（即未被其它图标占用）。
* 参数：
*     1. theIconID:新图标的标识号。
* 传回：
*     1. true:有效。
*     2. false:无效。
*     3. -1:参数为空或者为空格。
* 备注：
*/
function ifNewIconIdValid(theIconID) {
	if(theIconID==null || theIconID=="")
		return -1;
	//
	for(var i=0;i<AllIconsArray.length;i++){
		if(AllIconsArray[i].id==theIconID)
			return false;
	}
	return true;
}
//--------------ifNewIconIdValid()定义结束。-----------------------

/**--------------generateNewIconId()定义开始：-----------------------
* 名称：generateNewIconId
* 功能：产生新的可用的图标ID。
* 参数：
* 传回：newIconId:新的可用的图标ID。
* 备注：
*/
function generateNewIconId() {
	var newIconId=null;
	for(i=4;i>0;i++){
		newIconId="activity."+i;
		if(ifNewIconIdValid(newIconId)==true)
			return newIconId;
		else
			continue;
	}
	//
}
//--------------generateNewIconId()定义结束。-----------------------

/**--------------ifIconIdUsedExceptSelf()定义开始：-----------------------
* 名称：ifIconIdUsedExceptSelf
* 功能：判断指定图标的ID是否已经被其它图标占用。
* 参数：
*     1. theIconID:指定图标的标识号。
* 传回：
*     1. true:已经被其它图标占用。
*     2. false:未被其它图标占用。
*     3. -1:参数为空或者为空格。
* 备注：该ID可能被当前选中的图标占用。
*/
function ifIconIdUsedExceptSelf(theIconID) {
	if(theIconID==null || theIconID=="")
		return -1;
	//
	//alert("AllLinesArray.length="+window.dialogArguments.tempAllLinesArray.length);
	for(var i=0;i<window.dialogArguments.tempAllIconsArray.length;i++){
		if (window.dialogArguments.tempAllIconsArray[i].id==window.dialogArguments.id){
			continue;
		}
		else{
			if(window.dialogArguments.tempAllIconsArray[i].id==theIconID)
			return true;
		}
	}
	return false;
}
//--------------ifIconIdUsedExceptSelf()定义结束。-----------------------

/**--------------ifActivityWorking()定义开始：-----------------------
* 名称：ifActivityWorking
* 功能：判断指定ID的活动当前是否正处于running状态。
* 参数：
*     1. theActivityId:指定活动的标识号。
* 传回：
*     1. true:该活动正处于running状态。
*     2. false:该活动未处于running状态。
*     3. -1:参数为空或者为空格。
* 备注：
*/
function ifActivityWorking(theActivityId) {
	if(theActivityId==null || theActivityId=="")
		return -1;
	//
	for(var i=0;i<AllWorkingActivities.length;i++){
		if(AllWorkingActivities[i]==theActivityId)
			return true;
		else
			continue;
	}
	//
	return false;
}
//--------------ifActivityWorking()定义结束。-----------------------

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
*/
function ActObject(theId,theDisplayName,theType,theTips)
{
	this.id =theId;
	this.name = theDisplayName;
	this.type=theType;
	this.tips = theTips;
}
//--------------ActObject()定义结束。-----------------------

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
*/
function ConObject(theId,theDisplayName,theFrom,theTo)
{
	this.id =theId;
	this.name = theDisplayName;
	this.from = theFrom;
	this.to = theTo;
	this.flag=false; //标志位
}