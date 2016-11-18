;(function(define,window){


var win = window;

win.NODEB || (function(win){
	win = win || window;
	var that = win.NODEB = require;
	
	var log = win.console || {
	    log: function(){},
	    error: function(){}
	};
	
	var contentObj = {},cache = {},Undefined;
	
	/**
	 * @param string mName
	 * @param function object body
	 * 	function(require,module){}
	 */
	function define (id, dependence, factory){
		if(cache[id]!== Undefined|| contentObj[id] !== Undefined){
			return;
		}
		
	    // \u5224\u65ad\u53c2\u6570\u4e2a\u6570\uff0c\u81f3\u5c11\u4e24\u4e2a\uff0cid\uff0c\u4e09\u4e2a\u7684\u5219\u662f\u7528\u6700\u540e\u4e00\u4e2a
	    var argsLength = arguments.length;
	    if (argsLength < 2) {
	        log.error(arguments + "\u53c2\u6570\u4e0d\u591f\u554a");
	        return;
	    }
	    var facBody = argsLength == 2 ? dependence : factory;
		cache[id] = facBody;
		execDefins(id);
	};
	var _alias_ = {};
	function require(id){
	    if (!id) {
	        return null;
	    }
		if(_alias_[id]){
			id = _alias_[id];
		}
		if(cache[id]){
			execDefins(id);
		}
	    var modules = id.split("/");
	    var start = contentObj;
		
	    for (var i = 0; i < modules.length; i++) {
	        if (start) {
	            start = start[modules[i]];
	        }
	        else {
	            return null;
	        }
	    }
	    return start;
	};
	
	function execDefins(id){
		var obj = contentObj,
			facBody = cache[id];
			
		if(facBody === Undefined){
			return false;
		}
		delete cache[id];
		
	    var moduleArr = id.split("/");
	    for (var i = 0; i < moduleArr.length; i++) {
	        var m = moduleArr[i];
	        if (i == moduleArr.length - 1) {
	            // \u5df2\u7ecf\u6ce8\u518c
	            if (obj[m]) {
	                return;
	            }
	            try {
					if(typeof facBody == "string" || typeof facBody == "number" || typeof facBody == "object"){
						obj[m] = facBody;
					}else if(facBody){
						var exports = {},  module= {exports:exports};
	                    var result = facBody.call(win, require,exports,module);
						
						if((module.exports && (typeof module.exports != "object"  || Object.keys(module.exports).length)) || module.exports != exports){
							obj[m] = module.exports ;
						}else{
							obj[m] = result=== Undefined?null:result;
						}
					}else{
						obj[m] = null;
					}
	            } catch (e) {
	                log.error(id,e);
	            }
	            break;
	        }
	        if (!obj[m]) {
	            obj[m] = {};
	        }
	        obj = obj[m];
	    }
	}
	var slice = Array.prototype.slice;
	function extend(target){
		slice.call(arguments, 1).forEach(function(source) {
	        for (var key in source)
	            target[key] = source[key];
	    });
		return target;
	}
	define.amd = true;
	that.alias = function(alias){
		for(var i in alias){
			_alias_[i] = alias[i];
		}
	}
	
	that.require = require;
	that.define = define;
	that.getDefine = require;
	that.extend = extend;
	that.plugin = function(name,obj){
		contentObj[name] = obj;
	};
	that.plugin("core",that);
})(window);
define = define || win.NODEB.define;
window.define = define;
define("NodeB",{})



define("core/base/Class",function(require,exports,module){
/**
 * 
 */
function Class(){	
}

Class.extend = function(prop){
	var _super = this.prototype;
	
	var prototype = Object.create(_super);
	
	var desc = { writable: true, enumerable: false, configurable: true };
	for(var name in prop){
		if(typeof prop[name] == "function" &&  typeof _super[name] == "function"){
			desc.value = (function(name, fn){
				return function(){
					var temp = this._super;
					this._super = _super[name];
					var ret = fn.apply(this,arguments);
					this._super = temp;
					return ret;
				}
			})(name, prop[name]);
			Object.defineProperty(prototype, name, desc);
		}else if(typeof prop[name] == "function"){
			desc.value = prop[name];
            Object.defineProperty(prototype, name, desc);
		}else{
            prototype[name] = prop[name];
        }
	}
	
	function Clas(){
		var args = Array.prototype.slice.call(arguments,0);
		this._init_ && this._init_.apply(this,args);
	}
	Clas.prototype = prototype;
	desc.value = Clas;
	Object.defineProperty(Clas.prototype, 'constructor', desc);
	Clas.extend = Class.extend;
	//add implementation method
    Clas.implement = function (prop) {
        for (var name in prop) {
            prototype[name] = prop[name];
        }
    };
	return Clas;
}

module.exports = Class;
})
define("core/base/Model",function(require,exports,module){
/**
 * \u57fa\u672c\u5bf9\u8c61
 * 
 * \u5b9e\u73b0\u5bf9\u8c61\u81ea\u5b9a\u4e49\u4e8b\u4ef6
 * 
 * \u6dfb\u52a0\u4e8b\u4ef6
 * \u89e6\u53d1\u4e8b\u4ef6
 */
var Class = require("core/base/Class")
var _slice = Array.prototype.slice;

var Model = Class.extend({
	_init_:function(){
		var _this = this;
		_this._evtList = {};
		
	},
	on:function(type,fn){
		var _this = this;
		var list = _this._evtList[type];
		if(!list){
			list = _this._evtList[type] = [];
		}
		list.push(fn);
	},
	trigger:function(type,data){
		var _this = this;
		var list = _this._evtList[type];
		if(list){
			var args = _slice.call(arguments,1);
			list.forEach(function(a,i){
				try{
					a.apply(_this,args);
				}catch(e){}
			})
		}
	},
	once:function(type,fn){
		var _this = this;
		
		var deleteFn = function(){
			var args = _slice.call(arguments,0);
			fn.apply(_this,args);
			_this.off(type,deleteFn);
		}
		_this.on(type,deleteFn);
	},
	off:function(type,fn){
		var _this = this;
		var list = _this._evtList[type];
		if(list){
			if(fn){
				for(var i = 0 ; i < list.length;i++){
					if(list[i] == fun){
						return list.splice(i,1);
					}
				}
			}else{
				_this._evtList[type] = null;
			}
		}
	},
	destroy:function(){
		_this._evtList = null;
	}
})

Model.create = function(){
	return new Model();
}
module.exports = Model;

})

define("core/util/utils",function(require,exports,module){
/**
 * 
 * \u5de5\u5177\u7c7b
 * 
 * 1.\u5b57\u7b26\u4e32\u5904\u7406
 * 
 * 2.\u5e38\u7528\u5224\u65ad
 * 
 */
function util (query){
}
var _ = util;

_.empty = function(){};

// browser check

_.IE =  /msie/i.test(navigator.userAgent);

//underscore.js 

var ArrayProto = Array.prototype,ObjProto = Object.prototype;
var
    nativeForEach      = ArrayProto.forEach,
	nativeKeys         = Object.keys,
	hasOwnProperty   =   ObjProto.hasOwnProperty,
	slice            = ArrayProto.slice;
	
var breaker = {};
_.has = function(obj, key) {
   return hasOwnProperty.call(obj, key);
};
  
 _.keys = function(obj) {
	if (!_.isObject(obj)) return [];
	if (nativeKeys) return nativeKeys(obj);
	var keys = [];
	for (var key in obj) if (_.has(obj, key)) keys.push(key);
	return keys;
};

_.isObject = function(obj) {
	return obj === Object(obj);
};
_.isNode = function(obj){
	return obj != undefined && Boolean(obj.nodeName) && Boolean(obj.nodeType)
}
var each = _.each = _.forEach = function(obj, iterator, context) {
	if (obj == null) return obj;
	if (nativeForEach && obj.forEach === nativeForEach) {
	  obj.forEach(iterator, context);
	} else if (obj.length === +obj.length) {
	  for (var i = 0, length = obj.length; i < length; i++) {
	    if (iterator.call(context, obj[i], i, obj) === breaker) return;
	  }
	} else {
	  var keys = _.keys(obj);
	  for (var i = 0, length = keys.length; i < length; i++) {
	    if (iterator.call(context, obj[keys[i]], keys[i], obj) === breaker) return;
	  }
	}
	return obj;
};
_.extend = function(obj){
	each(slice.call(arguments, 1), function(source) {
      if (source) {
        for (var prop in source) {
          obj[prop] = source[prop];
        }
      }
    });
    return obj;
}
_.queryToJson = function(str){
	if(!str){
		return "";
	}
	var result = {};
	var query = str.split("&");
	query.forEach(function(a){
		var kv = a.split("=");
		result[kv[0]] = kv[1];
	})
	return result;
}
_.jsonToQuery = function(obj,encode){
	if(obj){
		return "";
	}
	var res = [];
	for(var i in obj){
		res.push(i+"="+(encode?encodeURIComponent(obj[i]):obj[i]))
	}
	return res.join("&");
}
_.joinURL = function(url,query){
	if(_.isObject(query)){
		query = _.jsonToQuery(query);
	}
	if(url.indexOf("?") >=0){
		url = url+"?"
	}
	if(url.indexOf("&") >=0){
		query = "&"+query;
	}
	return url+query;
}

var rAF = win.requestAnimationFrame	||
		win.webkitRequestAnimationFrame	||
		win.mozRequestAnimationFrame		||
		win.oRequestAnimationFrame		||
		win.msRequestAnimationFrame		||
		function (callback) { win.setTimeout(callback, 1000 / 60); };
		
util.requestAnimationFrame = function(fun){
	rAF(fun);
}
util.parseURL =  function(a) {
    var b = /^(?:([A-Za-z]+):(\/{0,3}))?([0-9.\-A-Za-z]+\.[0-9A-Za-z]+)?(?::(\d+))?(?:\/([^?#]*))?(?:\?([^#]*))?(?:#(.*))?$/, c = ["url", "scheme", "slash", "host", "port", "path", "query", "hash"], d = b.exec(a), e = {};
    for (var f = 0, g = c.length; f < g; f += 1)
        e[c[f]] = d[f] || "";
    return e
}

// \u524d\u7aef\u6a21\u677f\u5f15\u64ce \u652f\u6301\u4e0b\u591a\u7ebf\u7a0b
// https://github.com/ushelp/EasyTemplate/blob/master/easy.template.js
_.template = (function(){
	// EasyTemplate
//
// Version 1.0.0
//
// Copy By RAY
// inthinkcolor@gmail.com
// 2014
//
// https://github.com/ushelp/EasyTemplate
//
var noMatch = /(.)^/, 
	escaper = /\\|'|\r|\n|\t|\u2028|\u2029/g, 
	escapes = {
		"'" : "'",
		'\\' : '\\',
		'\r' : 'r',
		'\n' : 'n',
		'\t' : 't',
		'\u2028' : 'u2028',
		'\u2029' : 'u2029'
	}, 
	entityMap = {
		escape : {
			'&' : '&amp;',
			'<' : '&lt;',
			'>' : '&gt;',
			'"' : '&quot;',
			"'" : '&#x27;'
		},
		unescape : {
			'&amp;' : '&',
			'&lt;' : '<',
			'&gt;' : '>',
			'&quot;' : '"',
			'&#x27;' : "'"
		}
	},
	has = function(obj, key) {
		return hasOwnProperty.call(obj, key);
	},
	keys = Object.keys || function(obj) {
		if (obj !== Object(obj))
			throw new TypeError('Invalid object');
		var keys = [];
		for ( var key in obj)
			if (has(obj, key))
				keys.push(key);
		return keys;
	},
	// Regexes containing the keys and values listed immediately above.
	entityRegexes = {
		escape : new RegExp('[' + keys(entityMap.escape).join('') + ']', 'g'),
		unescape : new RegExp('(' + keys(entityMap.unescape).join('|') + ')',
				'g')
	}, 
	slice = Array.prototype.slice, defaults = function(obj) {
		Et.each(slice.call(arguments, 1), function(source) {
			if (source) {
				for ( var prop in source) {
					if (obj[prop] === void 0)
						obj[prop] = source[prop];
				}
			}
		});
		return obj;
	}
	;
	var Et = {
			// \u8bed\u53e5\u8868\u8fbe\u5f0f
		tmplSettings : {
			out : /\{([\s\S]+?)\}/g,  //\u8f93\u51fa\u8868\u8fbe\u5f0f{name}
			script : /\<%([\s\S]+?)%\>/g, //\u811a\u672c\u8868\u8fbe\u5f0f%<%%>
			escapeOut : /\{-([\s\S]+?)\}/g //\u8f6c\u4e49\u8f93\u51fa\u8868\u8fbe\u5f0f{-name}
		},
		// Functions for escaping and unescaping strings to/from HTML
		// interpolation.
		escape : function(string) {
			if (string == null)
				return '';
			return ('' + string).replace(entityRegexes['escape'], function(
					match) {
				return entityMap['escape'][match];
			});
		},
		unescape : function(string) {
			if (string == null)
				return '';
			return ('' + string).replace(entityRegexes['unescape'], function(
					match) {
				return entityMap['unescape'][match];
			});
		},
		each : function(obj, iterator, context) {
			if (obj == null)
				return;
			if (Array.prototype.forEach && obj.forEach === Array.prototype.forEach) {
				obj.forEach(iterator, context);
			} else if (obj.length === +obj.length) {
				for ( var i = 0, length = obj.length; i < length; i++) {
					if (iterator.call(context, obj[i], i, obj) === breaker)
						return;
				}
			} else {
				var keys = keys(obj);
				for ( var i = 0, length = keys.length; i < length; i++) {
					if (iterator.call(context, obj[keys[i]], keys[i], obj) === breaker)
						return;
				}
			}
		},
		template : function(text, data, settings) {
			text=Et.unescape(text);
			var render;
			settings = defaults({}, settings, Et.tmplSettings);
	
			// Combine delimiters into one regular expression via alternation.
			var matcher = new RegExp([ (settings.escapeOut || noMatch).source,
					(settings.out || noMatch).source,
					(settings.script || noMatch).source ].join('|')
					+ '|$', 'g');
			// Compile the template source, escaping string literals
			// appropriately.
			var index = 0;
			var source = "__p+='";
			text.replace(matcher, function(match, escapeOut, out,
					script, offset) {
				source += text.slice(index, offset).replace(escaper,
						function(match) {
							return '\\' + escapes[match];
						});
	
				if (escapeOut) {
					source += "'+\n((__t=(" + escapeOut
							+ "))==null?'':Et.escape(__t))+\n'";
				}
				if (out) {
					source += "'+\n((__t=(" + out
							+ "))==null?'':__t)+\n'";
				}
				if (script) {
					source += "';\n" + script + "\n__p+='";
				}
				index = offset + match.length;
				return match;
			});
			source += "';\n";
	
			// If a variable is not specified, place data values in local scope.
			if (!settings.variable)
				source = 'with(obj||{}){\n' + source + '}\n';
	
			source = "var __t,__p='',__j=Array.prototype.join,"
					+ "out=function(){__p+=__j.call(arguments,'');};\n"
					+ source + "return __p;\n";
	
			try {
				render = new Function(settings.variable || 'obj', 'Et', source);
			} catch (e) {
				e.source = source;
				console.info(e);
				console.info(source);
				
				throw e;
			}
	
			if (data)
				return render(data, Et);
			var template = function(data) {
				return render.call(this, data, Et);
			};
	
			// Provide the compiled function source as a convenience for
			// precompilation.
			template.source = 'function(' + (settings.variable || 'obj')
					+ '){\n' + source + '}';
	
			return template;
		}
	};

	return Et;
})();
_.formatDate = function(timestmo,format){
	var date = new Date(parseInt(timestmo));
    var o = {
        "M+": date.getMonth() + 1, //month 
        "d+": date.getDate(), //day 
        "h+": date.getHours(), //hour 
        "m+": date.getMinutes(), //minute 
        "s+": date.getSeconds(), //second 
        "q+": Math.floor((date.getMonth() + 3) / 3), //quarter 
        "S": date.getMilliseconds() //millisecond 
    }
    
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}

// \u5468
var _week = ["\u65e5","\u4e00","\u4e8c","\u4e09","\u56db","\u4e94","\u516d"];
_.weekDay = function(day){
	return _week[day];
}
_.weekDayByDate = function(date){
	var date = new Date(parseInt(date));
	return _.weekDay(date.getDay());
}
module.exports = util;

})
define("core/dom/ready",function(require,exports,module){


var isLoaded = false,
	loadedFuns =[];

function loaded(){
	if(isLoaded){
		return;
	}
	isLoaded = true;
	loadedFuns.forEach(function(a,i){
		a();
	})
	loadedFuns.length = 0;
};

window.addEventListener("load",loaded)
window.addEventListener("DOMContentLoad",loaded)
if(document.readyState == "complete"){
	loaded();
}
module.exports = function (fun){
	if(isLoaded){
		fun();
	}else{
		loadedFuns.push(fun);
	}
}

})
define("core/app/app",function(require,exports,module){
/**
 * \u5f02\u6b65\u52a0\u8f7dapp
 * \u63d0\u4f9b\u5f02\u6b65\u52a0\u8f7d\u6a21\u5757\uff0c
 * 
 * 1.\u8981\u53bb\u6307\u5b9a\u5730\u5740\u52a0\u8f7d\u6a21\u5757
 * 2.\u53ef\u4ee5\u914d\u7f6e\u6307\u5b9a\u6a21\u5757\u7684\u7248\u672c\u53f7
 * 3.\u6a21\u5757\u53ef\u7f13\u5b58\u3002
 * 
 */
var _ = require("core/util/utils"),
	ready = require("core/dom/ready");



var DIRNAME_RE = /[^?#]*\//
function dirname(path) {
  return path.match(DIRNAME_RE)[0]
}
var doc = document;

function getCurrentScript(){
	var curr = doc.currentScript,
		scripts = doc.scripts,
		nodescript = curr || scripts[scripts.length-1];
	
	return nodescript;
}
function getScriptAbsoluteSrc(script){
	return script.hasAttribute?script.src:
	// see http://msdn.microsoft.com/en-us/library/ms536429(VS.85).aspx
		script.getAttribute("src",4);
}
var nodebNode = getCurrentScript();
var loaderDir = dirname(getScriptAbsoluteSrc(nodebNode) || dirname(doc.URL));

var initJsModel = nodebNode.getAttribute("data-init");

function loadScript(url,option){
	if(!url){
		throw new Error("url cannot be undefined");
	}
	var opt = {
		onComplete:_.empty,
		onTimeout:_.empty,
		
		charset:"utf-8",
		timeout:30 * 1000
	}
	opt = _.extend(opt,option);
	
	function getHead(){
		var head = document.getElementsByTagName("head");
		if(head && head[0]){
			return head[0];
		}
		return null;
	}
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.charset = opt.charset;
	script.src = url;
	
	var timeout = setTimeout(function(){
		opt.onTimeout();
	},opt.timeout);
	
	if(opt.onComplete){
		_.IE?script.onreadystatechange = function(){
			if (script.readyState.toLowerCase() == "loaded" || script.readyState.toLowerCase() == "complete") {
                try {
                    clearTimeout(timeout);
                    getHead().removeChild(script);
                    script.onreadystatechange = null
                } catch (a) {
                }
                opt.onComplete()
            }
		}:script.onload = function(){
			try {
                clearTimeout(timeout);
                getHead().removeChild(script);
            } catch (b) {
            }
            opt.onComplete()
		}
	}
	getHead().appendChild(script);
}

var appConfig = {
	base:loaderDir
}
var _versions = {};

// \u83b7\u5f97js \u52a0\u8f7d\u5730\u5740,\u7248\u672c\u53f7\u662f\u540e\u7f00v\u7684\u65b9\u5f0f
var getJsDownPath = function(path){
	// 
	if(~path.indexOf("http")){
		return path;
	}
	
	var vSuff = _versions[path];
	path =  appConfig.base+path;
	path = !~path.indexOf(".js")?path+".js":path;
	if(vSuff){
		path = path+"?_v="+vSuff;
	}
	return path;
}


// 1.\u5148\u7b80\u5355\u70b9: app("id",function(){})

var app = function(){
	var args = arguments;
	if(!args.length){
		return;
	}
	ready(function(){
		var id = args[0];
		loadScript(getJsDownPath(id),{
			onComplete:args[1]
		});
	})
};

app.cfg = app.config = function(cfg){
	appConfig = _.extend(appConfig,cfg)
};
app.version = function(v){
	_versions = _.extend(_versions,v);
}
initJsModel && ready(function(){
	app(initJsModel)
})
module.exports = app;

})
define("core/dom/cssText",function(require,exports,module){
/**
 * dom\u7684\u6837\u5f0f\u6279\u91cf\u5904\u7406
 * 
 * @author dongyajie
 */
var css3proper = ["transform", 
		"transform-origin", 
		"transform-style", 
		"transition", 
		"transition-delay", 
		"transition-duration", 
		"transition-property", 
		"transition-timing-function",
		"animation", "animation-delay", 
		"animation-direction", "animation-duration",
		"animation-iteration-count", "animation-name", "animation-play-state",
		"animation-timing-function"
	]

// css3 \u524d\u7f00
var _elementStyle = document.createElement('div').style;
var _vendor = (function () {
	var vendors = ['t', 'webkitT', 'MozT', 'msT', 'OT'],
		transform,
		i = 0,
		l = vendors.length;

	for ( ; i < l; i++ ) {
		transform = vendors[i] + 'ransform';
		if ( transform in _elementStyle ) 
			return vendors[i].substr(0, vendors[i].length-1);
	}
	
	return false;
})();
var prefixCss = function(style){
	if ( _vendor === false ) return false;
	if ( _vendor === '' ) return style;
	return "-"+_vendor+"-" + style;
}
var cssText = function(el){
	var style = {};
	var text = el.style.cssText;
	var styleArr = text.split(";");
	styleArr.forEach(function(a,i){
		if(a){
			var values = a.split(":");
			values[0].trim() && (style[values[0].trim()] = values[1]);
		}
	});
	
	var obj = {};
	obj.css = function(sty){
		var temp = "";
		if(sty){
			for(var i in sty){
				temp = i;
				if(css3proper.indexOf(i) >=0){
					temp = prefixCss(i);		
				}
				style[temp] = sty[i];
			}
		}
	};
	obj.getText = function(){
		var result = [];
		for(var i in style){
			result.push(i+":"+style[i]);
		}
		return result.join(";")
	};
	obj.remove = function(name){
		if(css3proper.indexOf(name) >=0){
			delete style[prefixCss(name)];
		}
		delete style[name];
	}
	obj.setCss = function(sty){
		obj.css(sty);
		el.style.cssText = obj.getText();
	};
	obj.removeCss = function(name){
		obj.remove(name);
		el.style.cssText = obj.getText();
	}
	return obj;
};
module.exports = cssText;
})

define("core/dom/domSize",function(require,exports,module){
/**
 * 
 */
var win = window,
	doc = document;
var size = {
	getWinSize:function(){
		return{
			width:win.innerWidth||doc.documentElement.clientWidth,
			height:win.innerHeight||doc.documentElement.clientHeight
		}
	},
	getPageSize:function(b){
		var c;
	    b ? c = b.document : c = document;
	    var d = c.compatMode == "CSS1Compat" ? c.documentElement : c.body, e, f, g, h;
	    if (win.innerHeight && win.scrollMaxY) {
	        e = d.scrollWidth;
	        f = win.innerHeight + win.scrollMaxY
	    } else if (d.scrollHeight > d.offsetHeight) {
	        e = d.scrollWidth;
	        f = d.scrollHeight
	    } else {
	        e = d.offsetWidth;
	        f = d.offsetHeight
	    }
	    var i = size.getWinSize();
	    f < i.height ? g = i.height : g = f;
	    e < i.width ? h = i.width : h = e;
	    return {page: {width: h,height: g},win: {width: i.width,height: i.height}}
	},
	getSize:function(dom){
		return {
			width: dom.offsetWidth,height: dom.offsetHeight
		}
	}
}

module.exports = size;
})

define("core/evt/event",function(require,exports,module){
var anmiationEnds = ["animationend","webkitAnimationEnd","msAnimationEnd","mozAnimationEnd"],
	transitionEnd = ["transitionend","webkitTransitionEnd"];

var css3Event = {
	"animationend":"animationEnd",
	"transitionend":"transitionEnd"
}

var _elementStyle = document.createElement('div').style;
var _vendor = (function () {
	var vendors = ['t', 'webkitT', 'MozT', 'msT', 'OT'],
		transform,
		i = 0,
		l = vendors.length;

	for ( ; i < l; i++ ) {
		transform = vendors[i] + 'ransform';
		if ( transform in _elementStyle ) 
			return vendors[i].substr(0, vendors[i].length-1);
	}
	
	return false;
})();
function _prefixStyle (style) {
	if ( _vendor === false ) return false;
	if ( _vendor === '' ) return style;
	return _vendor + style.charAt(0).toUpperCase() + style.substr(1);
}

/**
 * \u4e8b\u4ef6\u5904\u7406
 */

function fixedType(type){
	if(_vendor && css3Event[type]){
		type = _prefixStyle(css3Event[type]);
	}
	return type;
}

var addEvent = window.addEventListener?
	function(dom,type,fn,capture){
		if(dom){
			dom.addEventListener(fixedType(type),fn,!!capture);
		}
	}:window.attachEvent?function(dom,type,fn){
		if(dom){
			dom.attachEvent('on'+type,fn);
		}
	}:function(dom,type,fn){
		dom["on"+type] = fn;
	};
var removeEvent = window.removeEventListener?
	function(dom,type,fn,capture){
		if(dom){
			dom.removeEventListener(fixedType(type),fn,!!capture);
		}
	}:window.detachEvent?function(dom,type,fn){
		if(dom){
			dom.detachEvent('on'+type,fn);
		}
	}:function(dom,type,fn){
		dom["on"+type] = null;
	};

var fireEvent = window.addEventListener?function(dom,type){
	var e = document.createEvent("HTMLEvents");
    e.initEvent(type, !0, !0);
    dom.dispatchEvent(e);
}:function(dom,type){
	 dom.fireEvent("on" + type);
}
var event = {
	addEvent:addEvent,
	removeEvent:removeEvent,
	stopEvent:function(e){
		e.preventDefault();
        e.stopPropagation()
	},
	fireEvent:fireEvent,
	getEvent:function(){
	}
}
module.exports =  event;

})
define("core/evt/touch",function(require,exports,module){
/**
 *  tap\u4e8b\u4ef6
 *  
 */
var ready = require("core/dom/ready"),
	evt = require("core/evt/event");
	
(function($){
	if(!("ontouchstart" in window)){
		// click
		ready(function(){
			evt.addEvent(document.body,"click", function (e) {
	           var target  = e.target || e.srcElement;
			   evt.fireEvent(target,"tap");
	        });
		})
		
		return;
	}
	
    var touch = {}, longTapTimeout, longTapDelay = 750;
 	
	var deviceIsIOS = /iP(ad|hone|od)/.test(navigator.userAgent);
	var deviceIsIOSWithBadTarget = deviceIsIOS && (/OS ([6-9]|\d{2})_\d/).test(navigator.userAgent);
	
    function parentIfText(node) {
        return node.tagName == Node.TEXT_NODE ? node.parentNode: node ;
    }
 
    function longTap() {
        longTapTimeout = null;
        if (touch.last) {
			evt.fireEvent(touch.target,"longtap");
            touch = {};
        }
    }
 
    function cancelLongTap() {
        if (longTapTimeout) {
            clearTimeout(longTapTimeout);
        }
        longTapTimeout = null;
    }
 
    function cancelAll() {
        if (longTapTimeout) {
            clearTimeout(longTapTimeout);
        }
        longTapTimeout = null;
        touch = {};
    }
 	
	var touchEvent = ["touchstart","touchmove","touchend","touchcancel"];
	if(navigator.msPointerEnabled){
		touchEvent = ["MSPointerDown","MSPointerMove","MSPointerUp","MSPointerCancel"];
	}
	
	ready(function(){
		var body = document.body;
		
		evt.addEvent(body,touchEvent[0], function (e) {
            touch = {};
            var now = Date.now();
			var te = e.targetTouches ? e.targetTouches[0] : e;
			
			touch.target = parentIfText(te.target);
			if(deviceIsIOSWithBadTarget){
				touch.target = document.elementFromPoint(te.pageX - window.pageXOffset, te.pageY - window.pageYOffset) || touch.target ;
			}
			
            touch.x1 = te.pageX;
            touch.y1 = te.pageY;
            touch.last = now;
            longTapTimeout = setTimeout(longTap, longTapDelay);
			
			
        });
		evt.addEvent(body,touchEvent[1], function (e) {
            cancelLongTap();
			e =  e.targetTouches ? e.targetTouches[0] : e;
			
            touch.x2 = e.touches[0].pageX;
            touch.y2 = e.touches[0].pageY;
        });
		
		evt.addEvent(body,touchEvent[2], function (e) {
            cancelLongTap();
            if ((touch.x2 > 0 || touch.y2 > 0) &&
                    (Math.abs(touch.x1 - touch.x2) > 30 || Math.abs(touch.y1 - touch.y2) > 30)) {
                // Swipe Event
                touch = {};
            } else if (touch.last) {
                // Tap Event
				evt.fireEvent(touch.target,"tap");
            }
            touch = {};
        });
		evt.addEvent(body,touchEvent[3], function (e) {
			cancelAll();
        });
	})
 	
})();
})


define("core/evt/delegate",function(require,exports,module){
/**
 * \u4e8b\u4ef6\u4ee3\u7406
 * 
 * @author dongyajie
 * 
 */
// tap \u4e8b\u4ef6
require("core/evt/touch");

var _ = require("core/util/utils"),
	evt = require("core/evt/event");

function delegate(dom){
	if(!_.isNode(dom)){
		throw "delegate need a Element as parameter";
	}
	
	var that = {};
	
	var _evtList = {};
	
	function domEventDelegate(e){
		var target = e.srcElement || e.target,
			type = e.type;
		dealEvent(target,type,e);
		
		evt.stopEvent(e);
	}
	// act-type  act-data;
	
	function dealEvent(target,type,e){
		if(!_evtList[type]){
			return;
		}
		var typelist = _evtList[type];
		
		function fireElement(target){
			var actName = target && target.getAttribute("act");
			return typelist[actName] && typelist[actName].call(target,{
				data:_.queryToJson(target.getAttribute("act-data")),
				evt:e
			});
		}
		
		while(target && target != dom){
			if(fireElement(target) === false){
				break;
			}
			target = target.parentNode;
		}
	}
	// \u7981\u6b62tap\u4e8b\u4ef6 \u7528 click \u4ee3\u66ff
	that.hasTap = !navigator.msPointerEnabled;
	
	that.add = function(name,type,fn){
		if(type == "tap" && !that.hasTap){
			type = "click"
		}
		if(!_evtList[type]){
			_evtList[type] = {};
			evt.addEvent(dom,type,domEventDelegate);
		}
		var h = _evtList[type];
		h[name] = fn;
	};
	
	that.remove = function(name,type){
		if(type == "tap" && !that.hasTap){
			type = "click"
		}
		if(_evtList[type]){
			delete _evtList[type][name];
			
			if(_.keys(_evtList[type]).length ==0){
				evt.removeEvent(dom,type,domEventDelegate);
			}
		}
	};
	
	that.destroy = function(){
		for(var i in _evtList){
			evt.removeEvent(dom,i,domEventDelegate);
		}
		_evtList = null;
	}
	return that;
}

module.exports = delegate;

})


define("core/evt/winevent",function(require,exports,module){
/**
 * \u9875\u9762\u4e8b\u4ef6\u6ce8\u518c
 * 
 */
var event = require("core/evt/event"),
	Model = require("core/base/Model")
	win = window;

var cust = Model.create();
/**
 * \u9875\u9762\u53d8\u5316\uff0c\u9700\u8981\u91cd\u65b0\u5e03\u5c40
 * @param {Object} e
 */
function resize(e){
	cust.trigger("resize");
}


event.addEvent(win,"resize",resize);
event.addEvent(win,"orientationchange",resize);
event.addEvent(win,"pageshow",function(){
	cust.trigger("pageshow");
});

module.exports = cust;
})


define("horse",function(require,exports,module){
/**
 * 
 * \u5fc5\u987b\u5f15\u5165jquery \u6216\u8005zepto 
 * \u6216\u8005\u81ea\u5df1\u5b9e\u73b0\u4e00\u4efd\uff0c\u89c9\u5f97\u6ca1\u5fc5\u8981.
 * 
 */
var NodeB = require("core/NodeB"),
	Model = require("core/base/Model")

/**
 * jquery \u63d2\u4ef6
 * 
 */
if(window.jQuery){
	require.plugin("$",window.jQuery);
}

var _nodeb = require;
var obj = {
	//object
	"Model":require("core/base/Model"),
	// app
	"app":require("core/app/app"),
	
	//	dom
	"cssText":require("core/dom/cssText"),
	"ready":require("core/dom/ready"),
	"domSize":require("core/dom/domSize"),
	
	// event
	"delegate":require("core/evt/delegate"),
	"winevent":require("core/evt/winevent"),
	"event":require("core/evt/event"),
	
	// util
	"util":require("core/util/utils")
}

for(var i in obj){
	require[i] = obj[i];
}
})
})((window.NODEB && window.NODEB.define) || window.define , window);