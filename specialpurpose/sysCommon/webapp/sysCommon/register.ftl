 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Free HTML5 Bootstrap Admin Template</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
	<meta name="author" content="Muhammad Usman">

	<!-- The styles -->
	<link id="bs-css" href="/sysCommon/images/charisma-master/css/bootstrap-cerulean.css" rel="stylesheet">
	<style type="text/css">
	  body {
		padding-bottom: 40px;
	  }
	  .sidebar-nav {
		padding: 9px 0;
	  }
	</style>
	<link rel="stylesheet" href="/sysCommon/images/jquery.jqGrid-4.4.3/css/ui.jqgrid.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/zTree-zTree_v3-master/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/jqGrid.overrides.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/bootstrap-responsive.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/charisma-app.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/jquery-ui-1.8.21.custom.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/fullcalendar.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/fullcalendar.print.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/chosen.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/uniform.default.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/colorbox.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/jquery.cleditor.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/jquery.noty.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/noty_theme_default.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/elfinder.min.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/elfinder.theme.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/jquery.iphone.toggle.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/opa-icons.css" type="text/css"/>
<link rel="stylesheet" href="/sysCommon/images/charisma-master/css/uploadify.css" type="text/css"/>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery.jqGrid-4.4.3/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery.jqGrid-4.4.3/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/jquery.jqGrid-4.4.3/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/validate/jquery.validate.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/validate/lib/jquery.form.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/validate/localization/messages_cn.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon-0.9.7.js" type="text/javascript"></script>
<script language="javascript" src="/images/jquery/plugins/datetimepicker/localization/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" href="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon-0.9.6.css" type="text/css"/>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery-ui-1.8.21.custom.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-transition.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-alert.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-modal.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-dropdown.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-scrollspy.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-tab.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-tooltip.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-popover.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-button.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-collapse.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-carousel.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-typeahead.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/bootstrap-tour.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.cookie.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/fullcalendar.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/excanvas.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.flot.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.flot.pie.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.flot.stack.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.flot.resize.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.chosen.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.uniform.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.colorbox.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.cleditor.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.noty.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.elfinder.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js//jquery.raty.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.iphone.toggle.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.autogrow-textarea.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.uploadify-3.1.min.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/jquery.history.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/charisma-master/js/charisma.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/zTree-zTree_v3-master/zTree_v3/js/jquery.ztree.core-3.5.js" type="text/javascript"></script>
<script language="javascript" src="/images/selectall.js" type="text/javascript"></script>
<script language="javascript" src="/images/fieldlookup.js" type="text/javascript"></script>
<script language="javascript" src="/images/common.js" type="text/javascript"></script>
<script language="javascript" src="/sysCommon/images/js/html_entity.js" type="text/javascript"></script>


	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	

	<!-- The fav icon -->
	<link rel="shortcut icon" href="img/favicon.ico">
		
		
	
</head>
<body>
		<!-- topbar starts -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".top-nav.nav-collapse,.sidebar-nav.nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a class="brand" href="index.html"> <img alt="Charisma Logo" src="img/logo20.png" /> <span>Charisma</span></a>
				
				<!-- theme selector starts -->
				<div class="btn-group pull-right theme-container" >
					<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
						<i class="icon-tint"></i><span class="hidden-phone"> Change Theme / Skin</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" id="themes">
						<li><a data-value="classic" href="#"><i class="icon-blank"></i> Classic</a></li>
						<li><a data-value="cerulean" href="#"><i class="icon-blank"></i> Cerulean</a></li>
						<li><a data-value="cyborg" href="#"><i class="icon-blank"></i> Cyborg</a></li>
						<li><a data-value="redy" href="#"><i class="icon-blank"></i> Redy</a></li>
						<li><a data-value="journal" href="#"><i class="icon-blank"></i> Journal</a></li>
						<li><a data-value="simplex" href="#"><i class="icon-blank"></i> Simplex</a></li>
						<li><a data-value="slate" href="#"><i class="icon-blank"></i> Slate</a></li>
						<li><a data-value="spacelab" href="#"><i class="icon-blank"></i> Spacelab</a></li>
						<li><a data-value="united" href="#"><i class="icon-blank"></i> United</a></li>
					</ul>
				</div>
				<!-- theme selector ends -->
				
				<!-- user dropdown starts -->
				<div class="btn-group pull-right" >
					<a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
						<i class="icon-user"></i><span class="hidden-phone"> admin</span>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="#">Profile</a></li>
						<li class="divider"></li>
						<li><a href="login.html">Logout</a></li>
					</ul>
				</div>
				<!-- user dropdown ends -->
				
				<div class="top-nav nav-collapse">
					<ul class="nav">
						<li><a href="#">Visit Site</a></li>
						<li>
							<form class="navbar-search pull-left">
								<input placeholder="Search" class="search-query span2" name="query" type="text">
							</form>
						</li>
					</ul>
				</div><!--/.nav-collapse -->
			</div>
		</div>
	</div>
	<!-- topbar ends -->
		<div class="container-fluid">
		<div class="row-fluid">
				
			<!-- left menu starts -->
			<div class="span2 main-menu-span">
				<div class="well nav-collapse sidebar-nav">
					<ul class="nav nav-tabs nav-stacked main-menu">
						<li class="nav-header hidden-tablet">Main</li>
						<li><a class="ajax-link" href="index.html"><i class="icon-home"></i><span class="hidden-tablet"> Dashboard</span></a></li>
						<li><a class="ajax-link" href="ui.html"><i class="icon-eye-open"></i><span class="hidden-tablet"> UI Features</span></a></li>
						<li><a class="ajax-link" href="form.html"><i class="icon-edit"></i><span class="hidden-tablet"> Forms</span></a></li>
						<li><a class="ajax-link" href="chart.html"><i class="icon-list-alt"></i><span class="hidden-tablet"> Charts</span></a></li>
						<li><a class="ajax-link" href="typography.html"><i class="icon-font"></i><span class="hidden-tablet"> Typography</span></a></li>
						<li><a class="ajax-link" href="gallery.html"><i class="icon-picture"></i><span class="hidden-tablet"> Gallery</span></a></li>
						<li class="nav-header hidden-tablet">Sample Section</li>
						<li><a class="ajax-link" href="table.html"><i class="icon-align-justify"></i><span class="hidden-tablet"> Tables</span></a></li>
						<li><a class="ajax-link" href="calendar.html"><i class="icon-calendar"></i><span class="hidden-tablet"> Calendar</span></a></li>
						<li><a class="ajax-link" href="grid.html"><i class="icon-th"></i><span class="hidden-tablet"> Grid</span></a></li>
						<li><a class="ajax-link" href="file-manager.html"><i class="icon-folder-open"></i><span class="hidden-tablet"> File Manager</span></a></li>
						<li><a href="tour.html"><i class="icon-globe"></i><span class="hidden-tablet"> Tour</span></a></li>
						<li><a class="ajax-link" href="icon.html"><i class="icon-star"></i><span class="hidden-tablet"> Icons</span></a></li>
						<li><a href="error.html"><i class="icon-ban-circle"></i><span class="hidden-tablet"> Error Page</span></a></li>
						<li><a href="login.html"><i class="icon-lock"></i><span class="hidden-tablet"> Login Page</span></a></li>
					</ul>
					<label id="for-is-ajax" class="hidden-tablet" for="is-ajax"><input id="is-ajax" type="checkbox"> Ajax on menu</label>
				</div><!--/.well -->
			</div><!--/span-->
			<!-- left menu ends -->
			
			<noscript>
				<div class="alert alert-block span10">
					<h4 class="alert-heading">Warning!</h4>
					<p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> enabled to use this site.</p>
				</div>
			</noscript>
			
			<div id="content" class="span10">
			<!-- content starts -->
				<div class="btn-toolbar" style="margin-bottom: 9px">
					<p>
						<a class="btn" href="#"><i class="icon-glass"></i>挂号</a>
						<a class="btn" href="#"><i class="icon-shopping-cart"></i>每日结算</a>
						<a class="btn" href="#"><i class="icon-trash"></i>日结算报表打印</a>
						<a class="btn" href="#"><i class="icon-book"></i>按科室统计</a>
						<a class="btn" href="#"><i class="icon-trash"></i>患者来源统计</a>
					  </p>
				  </div>
				<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-edit"></i>患者挂号</h2>
						<div class="box-icon">
							<a href="#" class="btn btn-setting btn-round"><i class="icon-cog"></i></a>
							<a href="#" class="btn btn-minimize btn-round"><i class="icon-chevron-up"></i></a>
							<a href="#" class="btn btn-close btn-round"><i class="icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<div class="alert alert-info">
							实付:<input type='text' style='width:50px'>  应付:<input type='text' style='width:50px'>  找零:<input type='text' style='width:50px'>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button class="bttn-oper">挂号</button>
							<button class="bttn-oper">保存</button>
							<button class="bttn-oper">退号</button>
							<button class="bttn-oper">作废</button>
						</div>
						<div class="row-fluid">
							<div class="span8">
								<ul class="nav nav-tabs" id="myTab">
									<li class="active"><a href="#guhao">挂号信息</a></li>
									<li><a href="#huozhe">患者信息</a></li>
									<li><a href="#lianxi">联系方式</a></li>
									<li><a href="#qit">联系人及其他信息</a></li>
								</ul> 
								<div id="myTabContent" class="tab-content">
									<div class="tab-pane active" id="guhao">
										<div class="box-content" style='height:200px'>
											<form name="EditHisProduct" method="post" class="form-horizontal" id="EditHisProduct">
											<table  cellspacing="0" class='basic-table'>
												<tr>
													<td class="label"><span>挂号编号:</span></td>
													<td >
														100000001
													</td>
													<td class="label"><span>卡码:</span></td>
													<td >
														<input name="productName" class="required" type="text"  />
													</td>
													<td colspan='3'>
														读取会员卡信息。。。
													</td>
												</tr>
												<tr>
													<td class="label"><span>患者姓名:</span></td>
													<td >
														<#assign diseaseId="">
														<@htmlTemplate.lookupField value='' formName="EditHisProduct"  name="diseaseId"  fieldFormName="LookupDisease"/>
											
													</td>
													<td class="label"><span>性别</span></td>
													<td >
														<select id="selectError" style='width:100px' data-rel="chosen">
																<option>男</option>
																<option>女</option>
															  </select>
													</td>
													<td class="label"><span>年龄</span></td>
													<td >
														<input name="productName" class="required" type="text"  />
													</td>
													<td class="label">挂号类型<span></span></td>
													<td >
														<select><option>asss</option></select>
													</td>
												</tr>
												<tr>
													<td class="label"><span>挂号科别:</span></td>
													<td >
														<select  id="selectError2" data-rel="chosen">
															 <option>外科1</option>
															  <option>外科2</option>
										  				</select>
													</td>
													<td class="label"><span>性别</span></td>
													<td >
														<input name="productName" class="required" type="text"  />
													</td>
													<td class="label"><span>出诊医师</span></td>
													<td >
														<input name="productName" class="required" type="text"  />
													</td>
													<td class="label"><span>患者类型</span></td>
													<td >
														<select><option>asss</option></select>
													</td>
												</tr>
											</table>
											</form>		
										</div>
									</div>
									<div class="tab-pane" id="huozhe">
										<div class="box-content">
										
										</div>
									</div>
									<div class="tab-pane" id="lianxi">
										<div class="box-content">
											<form class="form-horizontal">
											<table  cellspacing="0" class='basic-table'>
												<tr>
													<td class="label"><span>手机:</span></td>
													<td >
														<input name="productName" class="required" type="text"  />
													</td>
													<td class="label"><span>电话:</span></td>
													<td >
														<input name="productName" class="required" type="text"  />
													</td>
												</tr>
												<tr>
													<td class="label"><span>地址:</span></td>
													<td >
														<input name="productName" class="required" type="text"  />
													</td>
													<td class="label"><span>邮编:</span></td>
													<td >
														<input name="productName" class="required" type="text"  />
													</td>
												</tr>
											</table>
											</form>	
										</div>
									</div>
									<div class="tab-pane" id="qit">
										<div class="box-content">
										
										</div>
									</div>
								</div>		
							</div>
							<div class="span4">  	
								<lable>出诊医师:</lable>
								<button class="bttn-oper">调整打印格式</button>
								<button class="bttn-oper">打印</button>&nbsp;
										<table id="riskTable"></table>
										<div id="pager1"></div>
							</div>
					</div>		
				</div><!--/span-->
				</div>
				<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header well" data-original-title>
						<h2><i class="icon-edit"></i>挂号查询</h2>
						<div class="box-icon">
							<a href="#" class="btn btn-setting btn-round"><i class="icon-cog"></i></a>
							<a href="#" class="btn btn-minimize btn-round"><i class="icon-chevron-up"></i></a>
							<a href="#" class="btn btn-close btn-round"><i class="icon-remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<lable>挂号时间:</lable><input type="text" id="datetime" name="datetime" value="" />至
						<input type="text" id="datetime" name="datetime" value="" />
						<button class="bttn-oper">查询</button>
						<button class="bttn-oper">打印</button>&nbsp;
						<table id="regTable"></table>
						<div id="regPager"></div>
					</div>
				</div>	
			</div><!--/row-->
			
		  
       
			<!-- content ends -->
			</div><!--/#content.span10-->
				</div><!--/fluid-row-->
				
		<hr>

		<div class="modal hide fade" id="myModal">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">×</button>
				<h3>Settings</h3>
			</div>
			<div class="modal-body">
				<p>Here settings can be configured...</p>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">Close</a>
				<a href="#" class="btn btn-primary">Save changes</a>
			</div>
		</div>

		<footer>
			<p class="pull-left">&copy; <a href="http://usman.it" target="_blank">Muhammad Usman</a> 2012</p>
			<p class="pull-right">Powered by: <a href="http://usman.it/free-responsive-admin-template">Charisma</a></p>
		</footer>
		
	</div><!--/.fluid-container-->
	
	<!-- external javascript
	================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->

</body>
<script language='javascript'>
$(function(){
	//$("#datetime").datetime(); // 日期+时分秒
	jQuery("#riskTable").jqGrid({
	   	url:'commonFindDataTable?entityName=Risk',
		datatype: "json",
	   	multiselect: true,
	   	colNames:[' ','医生姓名','类型','挂号费','诊室','最大号源','医生编号'],
	   	colModel:[
	   		
	   		{name:'riskId',hidden:true,checkbox:true, width:55},
	   		{name:'riskName', width:135, editable:false},
	   		{name:'weightFactor', width:90, editable:false},
	   		{name:'111',  editable:false},
	   		{name:'222',  editable:false},
	   		{name:'333',  editable:false},
	   		{name:'description'},
	   	],
	   	rowNum:10,
	   	//autowidth:true,
	   	width: 330,
	   	//height: 330,
	   	//rowList:[10,20,30],
	   	pager: '#pager1',
	    viewrecords: true,
	    pginput:false, 
	    //sortorder: "desc",
	    //caption:"关键风险",
	    editurl: "createRisk",
	    onSelectRow: function(id,riskName){
	    
	    },
	    jsonReader : {  
          repeatitems : false,
		  id: "0"
        }
	});
	jQuery("#riskTable").jqGrid('navGrid','#pager1',{edit:true,add:true,del:true});
	
	jQuery("#riskTable").jqGrid('navButtonAdd','#pager1',{
    caption: " ",
    title: "Reorder Columns",
    onClickButton : function (){
        jQuery("#riskTable").jqGrid('columnChooser');
    }
	});
	jQuery("#regTable").jqGrid({
	   	url:'commonFindDataTable?entityName=Risk',
		datatype: "json",
	   	multiselect: true,
	   	colNames:[' ','挂号编号','患者','医生姓名','类型','挂号费','诊室','最大号源','医生编号'],
	   	colModel:[
	   		
	   		{name:'riskId',hidden:true,checkbox:true, width:55},
	   		{name:'riskName', width:135, editable:false},
	   		{name:'riskName1', width:135, editable:false},
	   		{name:'riskName2', width:135, editable:false},
	   		{name:'weightFactor', width:90, editable:false},
	   		{name:'111',  editable:false},
	   		{name:'222',  editable:false},
	   		{name:'333',  editable:false},
	   		{name:'description'},
	   	],
	   	rowNum:10,
	   	//autowidth:true,
	   	width: 1030,
	   	//height: 330,
	   	//rowList:[10,20,30],
	   	pager: '#regPager',
	    viewrecords: true,
	    pginput:false, 
	    //sortorder: "desc",
	    //caption:"关键风险",
	    editurl: "createRisk",
	    onSelectRow: function(id,riskName){
	    
	    },
	    jsonReader : {  
          repeatitems : false,
		  id: "0"
        }
	});
	jQuery("#regTable").jqGrid('navGrid','#regPager',{edit:true,add:true,del:true});
	//jQuery("#regTable").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false});
});	
</script>
</html>
 