var seller={
	menu:{}
};

var id_prefix="Menu_";
var quick_prefix="M_quick_";
var quick_li_prefix="M_quick_li_";

/** 全局对象 */
var g_menu_quickMenuIds= new Array();
var g_menu_quickMenuIds_init= new Array();
var g_menu_quickMenuDefault = new Array();

seller.menu = {
	createQuickMenuUI: function(menu_quick_id,menu_quick_name,menu_quick_url){
		$("#M_quickList_ul").append("<li id='"+quick_li_prefix+ menu_quick_id + "'><a href='"+menu_quick_url+"' id='M_quick_" + menu_quick_id + "' onclick="+'"'+"_gaq.push(['_trackEvent', 'Seller-mydh1', ' Left-快捷入口','"+menu_quick_name+"']);"+'"'+"  >"+menu_quick_name+"</a></li>");
	},
	quickMenuAdd : function(menuId){
		
		if(g_menu_quickMenuIds.length>=7){
			$("#M_quickMenu_selAll").hide();
			$("#M_quickMenu_selMax").show();
			return;
		}
		
		var mQuickBox$ = $("#m_quick_cbox_"+menuId);
		
		if(mQuickBox$.length==0){
			return;
		}
		
		if(mQuickBox$.attr("checked") == false){
			mQuickBox$.attr("checked", true);
		}
		
		if(!seller.menu.quickMenuIsExists(menuId)){
			g_menu_quickMenuIds.push(menuId);
			
			$("#M_hasSel_count").html(g_menu_quickMenuIds.length);
		}
		
		var menu_quick_id = quick_prefix +menuId;
		var menu_quick$ = $("#"+menu_quick_id);
		
		if(menu_quick$.length==0){
			var menu_name = $("#m_hid_name_"+menuId).text();
			var menu_url = $("#m_hid_url_"+menuId).val();
			seller.menu.createQuickMenuUI(menuId,menu_name,menu_url);
		}
		
		if(g_menu_quickMenuIds.length==7){
			$("#M_quickMenu_selAll").hide();
			$("#M_quickMenu_selMax").show();
			
			$("input[name='m_quickMenu_cbox']").each(function(){
				if($(this).attr("checked")==false){
					$(this).attr("disabled",true);
				}
				
			});
			return;
		}
		
		
	},
	quickMenuDel : function(menuId){
		for(var idx =0 ; idx<g_menu_quickMenuIds.length ; idx++){
			
			if(g_menu_quickMenuIds[idx] == menuId){
				g_menu_quickMenuIds.splice(idx,1);
			}
		}
		
		var menu_quick_id = quick_prefix +menuId;
		var menu_quick_li_id = quick_li_prefix +menuId;
		var menu_quick$ = $("#"+menu_quick_id);
		
		if(menu_quick$.length>0){
			$("#"+menu_quick_li_id).remove();
		}
		
		if(g_menu_quickMenuIds.length<7){
			
			$("#M_quickMenu_selAll").show();
			$("#M_quickMenu_selMax").hide();
			
			$("input[name='m_quickMenu_cbox']:disabled").each(function(){
					$(this).attr("disabled",false);
			});
		}
			
		$("#M_hasSel_count").html(g_menu_quickMenuIds.length);
	},
	quickMenuIsExists:function(menuId){
		var result = false;
		for(var tid in g_menu_quickMenuIds){
			if(g_menu_quickMenuIds[tid] == menuId){
				result = true;
				break;
			}
		}
		return result;
	},
	setQucikMenuSubmit:function(){
		var url = "http://seller.dhgate.com/mydhgate/menuv2.do?act=ajaxSetQuickMenu";
		var modelIds = g_menu_quickMenuIds.join(",");
		jQuery.ajax({
	       	url: url,
	       	data:{"modelIds":modelIds,"isblank":true},
	       	dataType: 'json',
	       	//async:true ,
	       	 //timeout: 3000,
	        type: 'POST',
	       	success: function(result) {
	       		if($(result)[0].result==true){
					
					$('#M_div_pop_setQuick').css({ display: 'none' });
					g_menu_quickMenuIds_init = new Array();
					for(var tid in g_menu_quickMenuIds){
			  			g_menu_quickMenuIds_init.push(g_menu_quickMenuIds[tid]);
			  			
					}
					
				}else{
					//alert('失败');
				}
	       	},
	       	error: function(xhr, status, error) {
               alert('An error occurred: ' + error);
           }            
   		});
	},
	closeSetQuick:function(){
		$('#M_div_pop_setQuick').css({ display: 'none' });
		
		var returnInit = false;
		if(g_menu_quickMenuIds_init.length != g_menu_quickMenuIds.length){
			returnInit = true;
		}else{
			for(var i=0;i<g_menu_quickMenuIds.length;i++){
				if(g_menu_quickMenuIds[i]!= g_menu_quickMenuIds_init[1]){
					returnInit = true;
					break; 
				}
			}
		}
		
		if(returnInit){
			seller.menu.quickMenuClear();
			for(var n=0 ;n<g_menu_quickMenuIds_init.length;n++){
       			seller.menu.quickMenuAdd(g_menu_quickMenuIds_init[n]);
       		}
		}
		
	},
	quickMenuClear:function(){
		$("input[name='m_quickMenu_cbox']:checked").each(function(){
			$(this).attr("checked",false);
		});
		
		$("input[name='m_quickMenu_cbox']:disabled").each(function(){
			$(this).attr("disabled",false);
		});
		
		$("#M_quickList_ul").empty();
		
		g_menu_quickMenuIds=new Array();
		$("#M_hasSel_count").html("0");
	},
	quickMenuRestore:function(){
   		seller.menu.quickMenuClear();
   		if(g_menu_quickMenuDefault.length<=0){
			var url = "http://seller.dhgate.com/mydhgate/menuv2.do?act=ajaxGetDefaultQuickMenu";
			jQuery.ajax({
		       	url: url,
		       	data:{"isblank":true},
		       	dataType: 'json',
		       	//async:true ,
		       	 //timeout: 3000,
		        type: 'POST',
		       	success: function(result) {
		       		if($(result).length == 1){
		       			$(result.defaultQuickMenus).each(function(){
		       				g_menu_quickMenuDefault.push(this.modelid);
		       				seller.menu.quickMenuAdd(this.modelid);
		       				
		       			});
		       		}
		       	},
		       	error: function(xhr, status, error) {
		              //alert('An error occurred: ' + error+xhr+status);
		          }            
		  		});
	  	}else{
	  		for(var tid in g_menu_quickMenuDefault){
	  			seller.menu.quickMenuAdd(g_menu_quickMenuDefault[tid]);
	  			
			}
	  	}
  	
	}
	
	
};

function initMenu(){
	initQuickMenu();

	$('#M_btn_setQuick_Cancel').click(function(){
	    seller.menu.closeSetQuick();
	});
	
	$('#M_btn_setQuick_Cancel2').click(function(){
	     seller.menu.closeSetQuick();
	});
	
	$('#M_btn_setQuick').click(function(){
	    $('#M_div_pop_setQuick').css({ display: 'block' });
	});
	
	$('#M_btn_setQuick_confirm').click(function(){
	    seller.menu.setQucikMenuSubmit();
	});
	
	$('#M_quickMenuClear_btn').click(function(){
	    seller.menu.quickMenuClear();
	});
	
	$('#M_quickMenuRestore_btn').click(function(){
	    seller.menu.quickMenuRestore();
	});
	
	$("#mapRemindClose").click(function(){
		$("#mapRemind").hide();
	});
	$("#iKnow").click(function(){
		SetCookie("n_menu_iknow", 1, 1, "", "", "");
		$("#mapRemind").hide();
	});
	
	/**
	$('#M_mydhgatev1_a').click(function(){
		var href = window.document.location.href;
		var reIdx = href.indexOf("#");
		if(reIdx>0){
			href = href.substr(0,reIdx);
		}
		if(href.indexOf("isMyDHgateV2=1")>=0){
			href = href.replace("isMyDHgateV2=1","isMyDHgateV2=0")
		}else if(href.indexOf("isMyDHgateV2=0")>=0){
			href=href;
		}else if(href.indexOf("?")<0){
			href = href+"?isMyDHgateV2=0";
		}else{
			href=href+"&isMyDHgateV2=0";
		}
		window.document.location.href=href;
		
		
	}); */
	
	
	var div_quickList$ = $('#M_div_quickList');
	$('#M_quickList_perdue').click(function(){
	    if( $(this).hasClass('perdue-show')){
			$(this).removeClass().addClass('perdue-hide');
			div_quickList$.css({ display: 'block'});
		}else{
			$(this).removeClass().addClass('perdue-show');
			div_quickList$.css({ display: 'none'});
		}
	});
	
	$("input[name='m_quickMenu_cbox']").click(function(){
		 var value = $(this).val();
		 if($(this).attr("checked")==true){
		 	seller.menu.quickMenuAdd(value);
		 }else{
		 	seller.menu.quickMenuDel(value);
		 }
		 
	});
	
	//initCurrentMenuPath("Menu_10001,21001,0209");
	/*var currentPath = $("#currentPath").val();
	if(currentPath == null || currentPath==""){
		currentPath="Menu_mydhgate";
	}*/
	//initCurrentMenuPath(currentPath);
}


$(document).ready(function(){
	initMenu();
	
	catalogControl();
	topTouchControl();
	navDirectory();
	setNavIframe();
	secondMenuControl();
	initIKnow();
	
	initMenu2Close();
});



function catalogControl() {
	var setUp = $('#setUp'), perdue = $('#perdue'), catalogPopClose = $('#catalogPopClose'), optionCancel = $('#optionCancel'),catalogList = $('#catalogList');
    setUp.click(function(){
	    $('.catalog-pop').css({ display: 'block' });
	});
	catalogPopClose.click(function(){
	    $('.catalog-pop').css({ display: 'none' });
	});
	optionCancel.click(function(){
	    $('.catalog-pop').css({ display: 'none' });
	});
	perdue.click(function(){
	    if( $(this).hasClass('perdue-show')){
			$(this).removeClass().addClass('perdue-hide');
			catalogList.css({ display: 'block'});
		}else{
			$(this).removeClass().addClass('perdue-show');
			catalogList.css({ display: 'none'});
		}
	});
}
function topTouchControl(){
    var combination = $('.combination');
	combination.mouseenter(function(){
	    $(this).addClass('m-hover');
	}).mouseleave(function(){
		$(this).removeClass('m-hover');
	});
}

function navDirectory(){
	var topNav = $('#topNav');
	var navLi = $('#topNav li');
	for(var i=0; i< navLi.length; i++){
		(function(){
			var index = i;
				$(navLi[index]).mouseenter(function(){
					var topNavoffsetleft = topNav.offset().left;
					var navLioffsetleft = $(navLi[index]).offset().left;
					var navLidirectorywidth = $(navLi[index]).children('.nav-directory').outerWidth(true);
					var needwidth = navLioffsetleft-topNavoffsetleft+navLidirectorywidth;
					
					if ( $(this).attr('index') == 0 && !$(this).hasClass('current') ) {
						$(this).css({ height: 31 });
						$(this).find('a').css({ height: 30 });
					}
					if(!$(this).hasClass('current')){
						$(this).addClass('mHover');
					}
					if(needwidth>950){
						$(this).children('.nav-directory').css({display:"block","left":"auto",right:-1});
					}else{
						$(this).children('.nav-directory').css({display:"block"});
					}
					setNavIframe(this);
				
				}).mouseleave(function(){
					$(this).removeClass('mHover');
					$(this).children('.nav-directory').css({display:'none'});
				});
			
		})()
	}
	$('.nav-directory a').mouseenter(function(){
	    $(this).css({ background : '#ddd'});	
	}).mouseleave(function(){
		$(this).css({ background : '#fff'});	
	});
}

var id_prefix="Menu_";
function initCurrentMenuPath(menuPath){
	if(menuPath==null || menuPath==""){
		return;
	}
	
	
	if(menuPath.indexOf(id_prefix)==0){
		menuPath = menuPath.substr(id_prefix.length);
	}
	var menuIds = menuPath.split(",");
	for(var idx=1;idx<=menuIds.length ;idx++){
		initCurrentMenu(menuIds[idx-1],idx);
	}
}

function initCurrentMenu(menuId,level){
	if(menuId==null || menuId==""){
		return;
	}
	
	var prefixMenuId = id_prefix + menuId;
	var menu$ = $("#"+prefixMenuId);
	if(level==1){
		menu$.addClass('current');
		$("#Menu_mydhgate").removeClass("current");
		return;
	}else if(level==2){
		
		if(menu$.length>0 && menu$[0].tagName == 'A' ) {
			menu$.addClass('current');
			return;
		}else{
			menu$.next().slideDown(300);
			menu$.children('b').addClass('menu-show');
		}
		
		/** 关闭其它的菜单
		var oDl = menu$.siblings('dl');
		for ( var i = 0; i < oDl.length; i++ ) {
			if ( $(oDl[i]).css('display') == 'block') {
			    $(oDl[i]).slideUp(300);
				$(oDl[i]).prev('div').children('b').removeClass('menu-show');
			}
		}*/
		
	}else if(level==3){
		menu$.children('a').addClass('current');
		return;
	}	
	
}

function setNavIframe(whichLi){
	var navDirectory =  $(whichLi).children('.nav-directory');
	var navDirectoryHeight = navDirectory.outerHeight(true);
	var navDirectoryWidth = navDirectory.outerWidth(true);
	var naviframe = navDirectory.children(".naviframe");
	naviframe.css({'width' : navDirectoryWidth , 'height' : navDirectoryHeight});
}

function secondMenuControl(){
	//$("#secondMenu dl").slideDown(300);
	//$("#secondMenu .h-title2 b").addClass('menu-show');
	$("#secondMenu .h-title2").mouseenter(function(){
		if(!$(this).hasClass('t-current')){
		$(this).addClass('t-mouseover');
		}
	})
	$("#secondMenu .h-title2").mouseleave(function(){
		$(this).removeClass('t-mouseover');
	})
	$("#secondMenu .h-title2").bind("click",function(){
		if(typeof($(this).next()[0]) =='undefined' ) {
			return;
		}
		if($(this).next()[0].nodeName == 'DIV'){
			return;
		}
		if($(this).find("b").attr("class") != "menu-show"){
			secMenuClose($(this).attr("id"),0);
			$(this).next().slideDown(300);
			$(this).children('b').addClass('menu-show');
		}else{
			secMenuClose($(this).attr("id"),1);
			$(this).find("b").removeClass("menu-show");
			$(this).next().slideUp(300);
		}
	})
}


var menu_2_close_list = new Array();
var menu2Closes_c_Name = "menu_2_closes";
function initMenu2Close(){
	
	var closes =GetCookie(menu2Closes_c_Name);
	if(closes!=null && typeof(closes)!='undefined' && closes.length>0 ){
		menu_2_close_list = closes.split(",");
	}
	if(typeof(menu_2_close_list) != "object"){
		menu_2_close_list = new Array();
	}
	
	var currentPath = $("#currentPath").val();
	
	if(currentPath!=null && currentPath.length>0){
		var menuIds = currentPath.split(",");
		if(menuIds!=null && menuIds.length>=2){
			secMenuClose(menuIds[1],0);
		}
	}
}

function secMenuClose(menuId,isClose){
	if(menuId!=null && typeof(menuId)!=undefined && menuId.length>=5){
		menuId = menuId.substr(5,menuId.length)
	}
	
	if(menuId==null ||typeof(menuId)==undefined ){
		return ;
	}
	if(isClose==1 && !closeMenuIsExists(menuId)){
		menu_2_close_list.push(menuId);
	}else if(menu_2_close_list.length >0){
		for(var tid in menu_2_close_list){
			if(menu_2_close_list[tid] == menuId){
				menu_2_close_list.splice(tid,1);
			}
		}
	}
	
	SetCookie(menu2Closes_c_Name.toString(), menu_2_close_list, 1, "/", "", "");
	
}

function closeMenuIsExists(menuId){
		var result = false;
		if(menu_2_close_list<=0){
			return result;
		}
		for(var tid in menu_2_close_list){
			if(menu_2_close_list[tid] == menuId){
				result = true;
				break;
			}
		}
		return result;
}

function initQuickMenu(){
	var url = "http://seller.dhgate.com/mydhgate/menuv2.do?act=ajaxGetQuickMenuList";
	jQuery.ajax({
       	url: url,
       	data:{"isblank":true},
       	dataType: 'json',
       	//async:true ,
       	 //timeout: 3000,
        type: 'POST',
       	success: function(result) {
       		if($(result).length == 1){
       			$(result.queryMenuList).each(function(){
       				seller.menu.quickMenuAdd(this.modelid);
       				g_menu_quickMenuIds_init.push(this.modelid);
       			});
       		}
       	},
       	error: function(xhr, status, error) {
              //alert('An error occurred: ' + error);
          }            
  		});
}


function initIKnow(){
	var iknow = GetCookie("n_menu_iknow");
	if(!iknow  && iknow!=1){
		$("#mapRemind").show();
	}
}


function GetCookie(name){
	var docCookie = document.cookie;
	var prefix = name + "=";
	var begin = docCookie.indexOf("; " + prefix);
	if(begin == -1){
		begin = docCookie.indexOf(prefix);		
		if(begin!=0)return null;
	}else{
		begin += 2
	}
	var end = document.cookie.indexOf(";",begin);
	if(end==-1)end = docCookie.length;

	return unescape(docCookie.substring(begin + prefix.length,end));
}

function SetCookie(name, value, expires, path, domain, secure){
	    
		var today = new Date();     
		//today.setTime( today.getTime() );     
		if ( expires ) {         
			expires = expires * 1000 * 60 * 60 * 24;     
		}     
		var expires_date = new Date( today.getTime() + (expires) );  
		document.cookie = name+'='+escape( value ) +         
		( ( expires ) ? ';expires='+expires_date.toGMTString() : '' ) + //expires.toGMTString()         
		( ( path ) ? ';path=' + path : '' ) +         
		( ( domain ) ? ';domain=' + domain : '' ) +         
		( ( secure ) ? ';secure' : '' ); 
}