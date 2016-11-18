

function modelClick(name){
	
	$('#css3menu a').removeClass('active');
	$("#model_"+name).addClass('active');
	if($('#layoutId').layout("panel","west").panel("options").collapsed){
		$('#layoutId').layout('expand','west');
	}
	
	//$('#layoutId').layout('collapse','west');
	var d = _menus[name];
	Clearnav();
	addNav(d);
	InitLeftMenu();
	_currentModel=name;
	
	
}
	function Clearnav() {
		
		var clearData=_menus[_currentModel];
			$.each(clearData, function(m, sm) {
					try{
						//var startTime=new Date().getTime();
						$('#wnav').accordion('remove', sm.menuname);
						//alert((new Date().getTime()-startTime)/1000);
					}catch(e){alert(e)}
			});
			
		/*  easyui的accordion获取panels此方法有问题-有n为未定义情况
		var pp = $('#wnav').accordion('panels');
		
		$.each(pp, function(i, n) {
			if (n) {
				var t = n.panel('options').title;
				$('#wnav').accordion('remove', t);
				$('#wnav').accordion('remove', t);
			}
		});
	   */
		var selectPanel = $('#wnav').accordion('getSelected');
		if (selectPanel) {
			var title = selectPanel.panel('options').title;
			$('#wnav').accordion('remove', title);
		}
	}
	
function addNav(data) {
	$.each(data, function(i, sm) {
		var menulist = "";
		menulist += '<ul>';
		$.each(sm.menus, function(j, o) {
			menulist += '<li><div><a onclick=clickMenu("'+o.url+'","'+o.menuname+'","'+o.isInnerTab+'") ref="' + o.menuid + '" href="#" rel="'
					+ o.url + '"   ><span class="icon ' + o.icon
					+ '" >&nbsp;</span><span class="nav">'+o.menuname
					+ '</span></a></div></li> ';
		});
		menulist += '</ul>';
		$('#wnav').accordion('add', {
			id:sm.menuid,
			title : sm.menuname,
			content : menulist,
			iconCls : 'icon ' + sm.icon
		});
	});
	try{
		var pp = $('#wnav').accordion('panels');
		var t = pp[0].panel('options').title;
		$('#wnav').accordion('select', t);
	}catch(e){
		//alert(e);
		}

}
function openTab(tabTitle,url){
	addTabFun({
						title : tabTitle,
						closable : true,
						content : '<iframe name="Frm_'+new Date().getTime()+'" src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>'
					});
}
	// 初始化左侧
function InitLeftMenu() {
	
	hoverMenuItem();
	
	$('#wnav li a').live('click', function() {
		/*
		var tabTitle = $.trim($(this).text());//过滤空格
		var url = $(this).attr("rel");
		var menuid = $(this).attr("ref");
		var icon = getIcon(menuid, icon);
		var isInner=false;
		for(var u=0;u<_innerTabUrl.length;u++){
			if(url.indexOf(_innerTabUrl[u])!=-1){
				isInner=true;
				break;
			}
		}
		if(isInner){
			layout_center_addTabFun({
				title : tabTitle,
				closable : true,
				cache:false,//点击innerTab是否刷新
				href:url});
			
		}else{
			addTabFun({
				title : tabTitle,
				closable : true,
				cache:true,
				href:url,
				content : '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>'
			});
		}
		*/
		$('#wnav li div').removeClass("selected");
		$(this).parent().addClass("selected");
	});
	
}
//点击菜单打开tab页	
function clickMenu(url,title,isInnerTab){
	var isInner=false;
	var tabTitle = $.trim(title);//过滤空格
	if(isInnerTab!=undefined&&isInnerTab!=null&&isInnerTab=='Y'){//右侧菜单点击触发innerTAB,如果存在此tab，则刷新
		var t = $('#layout_center_tabs');
		if (t.tabs('exists', tabTitle)) {
			t.tabs('select', tabTitle);
			layout_center_refreshTab(tabTitle);
		} else {
			layout_center_addTabFun({closable : true,title : tabTitle,href:url});
		}
		
	}else{
		addTabFun({
			title : tabTitle,
			closable : true,
			cache:false,
			href:url,
			content : '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>'
		});
	}
}
	/**
	 * 菜单项鼠标Hover
	 */
function hoverMenuItem() {
	$(".easyui-accordion").find('a').hover(function() {
		$(this).parent().addClass("hover");
	}, function() {
		$(this).parent().removeClass("hover");
	});
}

	
	// 获取左侧导航的图标
	function getIcon(menuid) {
		var icon = 'icon ';
		$.each(_menus, function(i, n) {
			$.each(n, function(j, o) {
				$.each(o.menus, function(k, m){
					if (m.menuid == menuid) {
						icon += m.icon;
						return false;
					}
				});
			});
		});
		return icon;
	}
	

	function layout_center_refreshTab(title) {
		$('#layout_center_tabs').tabs('getTab', title).panel('refresh');
		//$('#layout_center_tabs').tabs('refresh', title);
	}
	function layout_center_closeTab(title) {
		$('#layout_center_tabs').tabs('getTab', title).panel('close');
	}
	function closeFrameTab(cfg) {
		/**
		var refresh_tab = cfg.tabTitle?$('#layout_center_tabs').tabs('getTab',cfg.tabTitle):$('#layout_center_tabs').tabs('getSelected');  
	    if(refresh_tab && refresh_tab.find('iframe').length > 0){  
	    	var _refresh_ifram = refresh_tab.find('iframe')[0]; alert()
	    	_refresh_ifram.contentWindow.close();
	    }**/
	    var t = $('#layout_center_tabs').tabs('getTab', cfg.tabTitle);
					if (t.panel('options').closable) {
						$('#layout_center_tabs').tabs('close', cfg.tabTitle);
					}
					return;
	}
	//关闭当前打开tab页
	function closeCurrentTab(){
		 var index = $('#layout_center_tabs').tabs('getTabIndex', $('#layout_center_tabs').tabs('getSelected'));
		 $('#layout_center_tabs').tabs('close', index);
	}
	//刷新上一个tab页-通常情况是在列表页中，打开了新的编辑tab，保存默认后刷新的就是列表的tab
	function refreshPrevFrameTab(){
		var index = $('#layout_center_tabs').tabs('getTabIndex', $('#layout_center_tabs').tabs('getSelected'));
		var refresh_tab = $('#layout_center_tabs').tabs('getTab',parseInt(index)-1);  
	    if(refresh_tab && refresh_tab.find('iframe').length > 0){  
		    var _refresh_ifram = refresh_tab.find('iframe')[0]; 
		    var refresh_url =_refresh_ifram.src;  
		    _refresh_ifram.contentWindow.location.reload();
	    }else{//刷新innerTab
	    	layout_center_refreshTab(refresh_tab.panel('options').title);
	    }  
	}
	//刷新上一个tab页-通常情况是在列表页中，打开了新的编辑tab，保存默认后刷新的就是列表的tab
	function refreshPrevInnerTab(){
		var index = $('#layout_center_tabs').tabs('getTabIndex', $('#layout_center_tabs').tabs('getSelected'));
		var refresh_tab = $('#layout_center_tabs').tabs('getTab',parseInt(index)-1);  
	    layout_center_refreshTab(refresh_tab.panel('options').title);
	}
	/**     
	 * 刷新tab 
	 * @cfg  
	 *example: {tabTitle:'tabTitle',url:'refreshUrl'} 
	 *如果tabTitle为空，则默认刷新当前选中的tab 
	 *如果url为空，则默认以原来的url进行reload 
	 */  
	function refreshFrameTab(cfg){
	    var refresh_tab = cfg.tabTitle?$('#layout_center_tabs').tabs('getTab',cfg.tabTitle):$('#layout_center_tabs').tabs('getSelected');  
	    if(refresh_tab && refresh_tab.find('iframe').length > 0){
	    var _refresh_ifram = refresh_tab.find('iframe')[0]; 
	    var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;  
	    //_refresh_ifram.src = refresh_url;  
	    _refresh_ifram.contentWindow.location.href=refresh_url;  
	    //_refresh_ifram.contentWindow.location.reload();
	    }  
	} 
	
	//刷新当前innertab页
	function refreshCurrentTab(){  
		var index = $('#layout_center_tabs').tabs('getTabIndex', $('#layout_center_tabs').tabs('getSelected'));
		var refresh_tab = $('#layout_center_tabs').tabs('getTab',parseInt(index));  
	    layout_center_refreshTab(refresh_tab.panel('options').title);
	} 
	//刷新当前tab页
	function refreshCurrentFrameTab(){  
		var refresh_tab = $('#layout_center_tabs').tabs('getSelected');  
		if(refresh_tab && refresh_tab.find('iframe').length > 0){  
			var _refresh_ifram = refresh_tab.find('iframe')[0]; 
			_refresh_ifram.contentWindow.location.reload();
		}  
	} 
	/**
	*	iframe方式打开新tab
	*/
	function addTabFun(opts) {
		opts.iconCls='ext-icon-tabqt';
		var t = $('#layout_center_tabs');
		var maxNum=20;
		//tabs数量控制
		if(t.tabs('tabs').length!=maxNum){
			opts.cache=true;
			try{
				if (t.tabs('exists', opts.title)) {
					refreshFrameTab({tabTitle:opts.title,url:opts.href});  
					t.tabs('select', opts.title);
					//$('#layout_center_tabs').tabs('close',  opts.title);
					//t.tabs('add',{title:opts.title,closable:opts.closable,content:opts.content,cache:true});
				} else {
					t.tabs('add',{title:opts.title,closable:true,content:opts.content,cache:true});
				}
			}catch(e){alert(e);}
		}else{
			$.messager.alert('提示', '最多只能打开'+maxNum+'个tab页，请先关闭多余tab页！', 'warning');
		}
	}
	/**
	*	内部打开新tab
	*/
	function layout_center_addTabFun(opts) {
		var t = $('#layout_center_tabs');
		var maxNum=20;
		//tabs数量控制
		if(t.tabs('tabs').length!=maxNum){
			if (t.tabs('exists', opts.title)) {
				/* $('#layout_center_tabs').tabs('close',  opts.title);
				t.tabs('add', opts); */
				 
				var tab=$('#layout_center_tabs').tabs('getTab',  opts.title);
				if(tab.href!=opts.href){
					t.tabs('update' ,{tab: tab,options:{href:opts.href}});
					tab.panel('refresh');
				}
				t.tabs('select', opts.title);
			} else {
				t.tabs('add', opts);
			}
		}else{
			$.messager.alert('提示', '最多只能打开'+maxNum+'个tab页，请先关闭多余tab页！', 'warning');
		}
	}	