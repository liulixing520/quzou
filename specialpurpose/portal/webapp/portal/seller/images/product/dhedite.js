;$(function($){	   
	(function(exports){
		var render = $(UEDITOR_CONFIG['holder']);		
        var _edite = new UE.ui.Editor();
		 
		$.extend(UE.commands,{
			albums : {
			    execCommand : function(){
			        $.pub('albums.edite',_edite);
			    }
			},
			upload : {
			    execCommand : function(){
			        $.pub('upload.edite',_edite);
			    }
			},
			relatedproduct : {
				execCommand : function(){
					$.pub('relatedproduct.edite',_edite);
				}
			},
			preview : {
				execCommand : function(){

					var home_url = 'http://www.dhresource.com/dhs/mos/js/syi/' + $conf['version'] + '/ueditor/';
					var options  = this.options,browser = UE.browser,ie = browser.ie,utils = UE.utils;
					var useBodyAsViewport = ie && browser.version < 9,
                    html = ( ie && browser.version < 9 ? '' : '<!DOCTYPE html>') +
                                '<html xmlns=\'http://www.w3.org/1999/xhtml\'' + (!useBodyAsViewport ? ' class=\'view\'' : '') + '><head>' +
                                ( options.iframeCssUrl ? '<link rel=\'stylesheet\' type=\'text/css\' href=\'' + utils.unhtml( options.iframeCssUrl ) + '\'/>' : '' ) +
                                '<style type=\'text/css\'>' +
                            //设置四周的留边
                                '.view{padding:0;word-wrap:break-word;cursor:text;height:100%;}\n' +
                            //设置默认字体和字号
                            //font-family不能呢随便改，在safari下fillchar会有解析问题
                                'body{margin:8px;font-family:sans-serif;font-size:16px;}' +
                            //设置段落间距
                                'p{margin:5px 0;}'
                                + ( options.initialStyle || '' ) +
                                '</style>\
								<script src="'+home_url+'uparse.js"></script><script>' +
					            "setTimeout(function(){uParse('div',{" +
					            "    'highlightJsUrl':'" + home_url + "third-party/SyntaxHighlighter/shCore.js'," +
					                "    'highlightCssUrl':'" + home_url + "third-party/SyntaxHighlighter/shCoreDefault.css'" +
					                "})},500)" +
					            '</script>\
								</head><body' + (useBodyAsViewport ? ' class=\'view\'' : '') + '>';
					
					 
			        var w = window.open('', '_blank', ''),d = w.document,me = this;
			        d.open();
			        d.write(html + '<div class="t-notice">\
								<p><strong>温馨提示: </strong>请不要粘贴敦煌网以外的图片或链接，有可能会在产品详情页无法正常显示。</p>\
							</div>\
							<div class="ctab-warp">\
								<div class="detailed-description clearfix con-info">' + me.getContent( null, null, false) + '\
								</div>\
							</div>\
							</body>\
						</html>');
			        d.close();
			    },
			    notNeedUndo : 1
			}
		});	
		 
		_edite.addListener('aftersetcontent',function(){
			var body = this.body,childs = body.childNodes ;
			for(var i = 0 ,len = childs.length;i< len;i++){
				var node = childs[i];
				if(node && node.nodeType == 8){
					UE.dom.domUtils.remove(node)		
				}
			}
		});
		
        _edite.render(render[0]);
		
        _edite.ready(function(){
			$('#edui1_elementpath').html('请勿输入非英文字符和符号'); 
        	$.sub('execCommand.edite',function(evt,type,args){
				switch(type){
					
					case 'insertImages':
					case 'insertImage':
					if(!$.isArray(args)){
						args = [args];
					}
					for(var i = 0;i< args.length;i++){
						var  obj = args[i];
						if(obj && obj.src && !obj.data_ue_src){
							obj.data_ue_src = obj.src;
						}  
						_edite.execCommand('insertImage',obj);
					}	 
					break;
					default:
					_edite.execCommand(type,args);
					break;	
				}
				
			}); 
			$.sub('setContent.edite',function(evt,text){
				_edite.setContent(text);
			});
			$.pub('ready.edite',_edite);
			
			$.sub('sync.edite',function(){
				_edite.sync();
			});
			
			$(_edite.container).closest('form').bind('submit.edite',function(){
				_edite.sync();
			});
			
			var last,itv;		
			_edite.addListener("blur contentChange",function(){
				var text = _edite.getContentTxt();
				if(last == text){
					return;
				}
				last = text;
				clearTimeout(itv);
				itv  = setTimeout(function(){
					if(/([\u4e00-\u9fa5]+)/.test(text)){
						$.pub('checkcharset.edite',[RegExp.$1]);
					}else{
						$.pub('checkcharset.edite',['']);
					}	
				},100);  
				
			});
			var isFullScreen = false,select = $('select'),hidden = false; 
			
			_edite.addListener('fullScreenChanged sourceModeChanged',function(type,mode){
				if(type == 'sourcemodechanged' && $.browser.msie && mode == false){ 
					setTimeout(function(){					
							$(_edite.window ).scrollTop(0);
						},
						50
					); 	
				}
				if(type == 'fullscreenchanged'){
					isFullScreen = mode ;
				}
				if(!mode){
					setTimeout(function(){
						_edite.fireEvent('unsetFloating'); 
					},20);
				} 
				if($.browser.msie && $.browser.version == 6){
					if(isFullScreen){
						if(!hidden){
							hidden = true;
							select.css('visibility','hidden');	
						}						
					}else{
						if(hidden){
							hidden = false;
							select.css('visibility','visible');	
						}						
					}
				}
			});
			$('.edui-editor-wordcount').html(_edite.queryCommandValue("wordcount"));
			var layer = $('#edui_fixedlayer');
			$('#postMain').bind('scroll resize',function(){
				layer.children('div:visible').hide();
			});

			// 给关联产品模板图片添加click事件
			$(this.body).delegate('.j-relatedproduct', 'click', function(){
			 	window.open('/prodmanage/relModel/preview.do?relModelId=' + $(this).attr('data-relateproduct'))
			});
        });		
		exports.dhedite = _edite;
    })(window);
});




