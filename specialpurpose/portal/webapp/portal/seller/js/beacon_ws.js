if(!dmtrack){var dmtrack={}}dmtrack.send_head=document.location.protocol+"//";dmtrack.ver=40;dmtrack.err_url=dmtrack.send_head+"stat.china.alibaba.com/dw/error.html";dmtrack.tracelog_url=dmtrack.send_head+"tracelog.www.alibaba.com/null.gif";dmtrack.feedback_url=dmtrack.send_head+"page.china.alibaba.com/shtml/static/forfeedbacklog.html";dmtrack.beacon_url=dmtrack.send_head+"dmtracking2.alibaba.com/b.jpg";dmtrack.beacon2_url=dmtrack.send_head+"dmtracking2.alibaba.com/c.jpg";dmtrack.acookieSupport=dmtrack.send_head!=="https://"?true:false;dmtrack.getCookieFromAcookie=false;dmtrack.isCheckLogin=false;dmtrack.isChangePid=true;(function(h,b){if(h.nameStorage!==b){return}var k={},a=false;function g(){var m=h.name;if(m!==""){var l=m.match(/^nameStorage:\{(.*)\}$/);if(l===null){return}else{l[1].replace(/([^:]+):([^,]+)(?:,|$)/g,function(o,n,p){n=decodeURIComponent(n);p=decodeURIComponent(p);k[n]=p})}}a=true}function f(l,m){if(a===true){k[l]=m.toString();c()}}function j(l){if(a===true){var m=k[l];return m!==b?m:null}}function i(l){if(a===true){delete k[l];c()}}function e(){if(a===true){k={};c()}}function c(){var l=[],n;for(var m in k){n=k[m];l.push(encodeURIComponent(m)+":"+encodeURIComponent(n))}h.name="nameStorage:{"+l.join(",")+"}"}g();h.nameStorage={supported:a,getItem:j,setItem:f,removeItem:i,clear:e}})(window);if(location.protocol==="https:"){nameStorage.setItem("referer",location.href)}(function(){var a=[],b="cachedBeaconImg";dmtrack.cacheStatImg=function(c){if(nameStorage.supported===true){a.push(encodeURIComponent(c));nameStorage.setItem(b,a.join(","))}else{dmtrack.sendImg(c)}};dmtrack.sendCachedStatImgs=function(){var g=nameStorage.getItem(b);nameStorage.removeItem(b);if(g){var e=g.split(","),j;for(var f=0,h=e.length;f<h;f++){j=decodeURIComponent(e[f]);dmtrack.sendImg(j)}}}})();dmtrack.SendMessage=function(f,b,e,a,r,q){function h(y){var s="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";var u,w,k;var x,v,t;k=y.length;w=0;u="";while(w<k){x=y.charCodeAt(w++)&255;if(w==k){u+=s.charAt(x>>2);u+=s.charAt((x&3)<<4);u+="==";break}v=y.charCodeAt(w++);if(w==k){u+=s.charAt(x>>2);u+=s.charAt(((x&3)<<4)|((v&240)>>4));u+=s.charAt((v&15)<<2);u+="=";break}t=y.charCodeAt(w++);u+=s.charAt(x>>2);u+=s.charAt(((x&3)<<4)|((v&240)>>4));u+=s.charAt(((v&15)<<2)|((t&192)>>6));u+=s.charAt(t&63)}return u}var m="";var n="";var o=new Date();var p=f.length;try{if(b){for(var j in b){m+=j.toString()+"="+b[j].toString()+"&"}m=m.substring(0,m.length-1)}m=h(m);if(e){for(var j in e){n+=j.toString()+"="+e[j].toString()+"&"}n=n.substring(0,n.length-1)}if(f.indexOf("?")==-1){if(!m&&n){f+="?"+n+"&ver="+dmtrack.ver+"&time="+o.getTime()}else{if(!n&&m){f+="?"+m+"&ver="+dmtrack.ver+"&time="+o.getTime()}else{if(n&&m){f+="?"+m+"&"+n+"&ver="+dmtrack.ver+"&time="+o.getTime()}}}}else{var l=f.split("?");if(!m&&n){if(!l[1]){f=""+l[0]+"?"+l[1]+n+"&ver="+dmtrack.ver+"&time="+o.getTime()}else{f=""+l[0]+"?"+l[1]+"&"+n+"&ver="+dmtrack.ver+"&time="+o.getTime()}}else{if(!n&&m){if(!l[1]){f=""+l[0]+"?"+m+l[1]+"&ver="+dmtrack.ver+"&time="+o.getTime()}else{f=""+l[0]+"?"+m+"&"+l[1]+"&ver="+dmtrack.ver+"&time="+o.getTime()}}else{if(n&&m){if(!l[1]){f=""+l[0]+"?"+m+l[1]+"&"+n+"&ver="+dmtrack.ver+"&time="+o.getTime()}else{f=""+l[0]+"?"+m+"&"+l[1]+"&"+n+"&ver="+dmtrack.ver+"&time="+o.getTime()}}}}}if(f.length==p){if(f.indexOf("?")==-1){f+="?ver="+dmtrack.ver+"&time="+o.getTime()}else{if(f.indexOf("?")==f.length-1){f+="ver="+dmtrack.ver+"&time="+o.getTime()}else{f+="&ver="+dmtrack.ver+"&time="+o.getTime()}}}if(a=="docwrite"){document.write("<img style='display:none' src = "+f+">")}else{if(a=="newimg"||!a){if(dmtrack.send_head.indexOf("http")!=-1&&dmtrack.send_url!=""){if(r===true){dmtrack.cacheStatImg(f)}else{dmtrack.sendImg(f,q)}}}}}catch(i){var c=dmtrack.getErrInfo(i);var g=dmtrack.err_url+"?type=send&exception="+encodeURIComponent(c.toString());if(a=="docwrite"){document.write("<img style='display:none' src = "+g+">")}else{if(a=="newimg"||!a){dmtrack.sendImg(g)}}}};dmtrack.sendImg=function(a,c){var b=new Image();b.onload=function(){b=null;if(c){c()}};b.src=a};dmtrack.getRand=function(){var k;try{k=dmtrack_pageid}catch(g){k=""}if(!k){k="001"}else{var f=k.substring(0,16),j=k.substring(16,26);var a=/^[\-+]?[0-9]+$/.test(j)?parseInt(j,10):j;k=f+a.toString(16)}var h=(new Date()).getTime();var b=[k,h.toString(16)].join("");for(var c=1;c<10;c++){var l=parseInt(Math.round(Math.random()*10000000000),10).toString(16);b+=l}b=b.substr(0,42);return b};String.prototype.Trim=function(){return this.replace(/(^\s*)|(\s*$)/g,"")};dmtrack.get_cookie=function(c){var b="(?:; )?"+c+"=([^;]*);?";var a=new RegExp(b);if(a.test(document.cookie)){var e=decodeURIComponent(RegExp["$1"]);if(e.Trim().length>0){return e}else{return"-"}}else{return"-"}};dmtrack.set_cookie=function(g,h,b,c,a,f){var e=g+"="+encodeURIComponent(h);if(b){e+="; expires="+b.toGMTString()}if(c){e+="; path="+c}if(a){e+="; domain="+a}if(f){e+="; secure"}document.cookie=e};dmtrack.del_cookie=function(f,a){var e=document.domain,b=e.split("."),g="";dmtrack.set_cookie(f,"",new Date(0),a);for(var c=b.length-1;c>0;c--){g="."+b[c]+g;dmtrack.set_cookie(f,"",new Date(0),a,g)}g="."+b[c]+g;dmtrack.set_cookie(f,"",new Date(0),a,g)};dmtrack.getDomainCookie=function(c,f){c=c.replace(/\"/g,"");var e=dmtrack.get_cookie(f),b=c.split("|");if(b[0]&&b[0]=="-"){b=[]}b.push(f+"="+e);var a=b.join("|");return a};dmtrack.tracking=function(p,r){dmtrack.sendCachedStatImgs();try{var o=document.referrer;if(location.protocol==="http:"&&o===""){o=nameStorage.getItem("referer")||""}try{o=""==o?opener.location:o;o=""==o?"-":o}catch(s){o="-"}o=encodeURI(o);var c="GET";var a=document.URL.indexOf("://");var h=document.URL.substr(a+2);h=encodeURI(h);var u=dmtrack.get_cookie("ali_apache_track");if(dmtrack.getCookieFromAcookie){u=dmtrack.getDomainCookie(u,"cna")}if(dmtrack.isgetApacheId){u=dmtrack.getDomainCookie(u,"ali_apache_id")}var k=dmtrack.beacon_url;try{if(!dmtrack_c){dmtrack_c="{-}"}}catch(s){dmtrack_c="{-}"}if(dmtrack.isCheckLogin){dmtrack._checkLogin()}dmtrack_c=dmtrack.addCookieC();dmtrack.redirect_c();if(dmtrack.isChangePid){dmtrack.change_pid()}var q=dmtrack.uaMonitor(),g=q.extraBrowser,v=g.name+g.ver.toFixed(1),b=q.system.name,n=window.screen.width+"*"+window.screen.height,l=window.navigator.language||window.navigator.browserLanguage,t=v+"|"+b+"|"+n+"|"+l;var j={pageid:dmtrack_pageid,sys:t};if(p){j.ali_beacon_id=p;j.inc=r}dmtrack.SendMessage(k,{p:"{"+dmtrack.profile_site+"}",u:"{"+h+"}",m:"{"+c+"}",s:"{200}",r:"{"+o+"}",a:"{"+u+"}",b:"{-}",c:dmtrack_c},j)}catch(i){var m=dmtrack.getErrInfo(i);var f=dmtrack.err_url+"?type=dmtrack&exception="+encodeURIComponent(m.toString());dmtrack.SendMessage(f)}dmtrack.isDmTracked=true};dmtrack.redirect_c=function(){var b="aliBeacon_bcookie";var a=dmtrack.get_cookie(b);a=a.replace(/ali_resin_trace=/,"");if("{-}"==dmtrack_c){dmtrack_c="{"+a+"}"}else{dmtrack_c=dmtrack_c.split("}");if("-"==a){dmtrack_c[1]="}"}else{dmtrack_c[1]="|";dmtrack_c.push(a);dmtrack_c.push("}")}dmtrack_c=dmtrack_c.join("")}dmtrack.del_cookie(b,"/")};dmtrack.change_pid=function(){var a=document.domain;if(-1!=a.indexOf("alibado.com")){dmtrack.profile_site=4}if(window.dmconf){if(window.dmconf.pid){dmtrack.profile_site=window.dmconf.pid}}};dmtrack.beacon_click=function(j,p,g){try{var q=p;if(q=="-"||!q){q=encodeURI(document.URL)}d=new Date();var n=j.indexOf("://");var e=j.substr(n+2);var a="GET";var f=dmtrack.get_cookie("ali_apache_track");var m=dmtrack.beacon2_url;var o=[];if(g){for(var l in g){o.push(l+"="+g[l])}}if(o.length==0){o.push("-")}dmtrack.SendMessage(m,{p:"{"+dmtrack.profile_site+"}",u:"{"+e+"}",m:"{"+a+"}",s:"{200}",r:"{"+q+"}",a:"{"+f+"}",b:"{-}",c:"{"+o.join("|")+"}"})}catch(k){var b=dmtrack.getErrInfo(k);var h=dmtrack.err_url+"?type=beaconclick&exception="+encodeURIComponent(b.toString());dmtrack.SendMessage(h)}};dmtrack.tracelog=function(c){var b=dmtrack.tracelog_url;var a={tracelog:c};dmtrack.clickstat(b,a)};dmtrack.dotstat=function(b,e,k){var i=dmtrack.dotstat_url;if(i){try{if(!window.dmtrack_pageid){window.dmtrack_pageid=""}var g=typeof e;if(g==="undefined"){e={}}else{if(g==="string"){var j={};e.replace(/(\w+)\s*=\s*([^&]*)(&|$)/g,function(m,l,n){j[l]=n});e=j}}e.id=b;e.st_page_id=window.dmtrack_pageid;var h=dmtrack.get_cookie("ali_beacon_id");if(h!=""&&h!="-"){e.ali_beacon_id=h;e.inc=0}dmtrack.SendMessage(i,{},e,"",k)}catch(f){var a=dmtrack.getErrInfo(f);var c=dmtrack.err_url+"?type=clickstat&exception="+encodeURIComponent(a.toString());dmtrack.SendMessage(c)}}};dmtrack.clickstat=function(e,g,o){try{if(!window.dmtrack_pageid){window.dmtrack_pageid=""}var l=dmtrack.get_cookie("ali_beacon_id");var c={};if(typeof(g)=="string"){if("?"==e.substring(e.length-1,e.length)){e=e.replace("?","")}if("?"==g.substring(0,1)){g=g.replace("?","")}var p=g.split("&");for(var j=0;j<p.length;j++){var k=p[j].split("=");var n=k[0];var m=k[1];c[n]=m}c.st_page_id=window.dmtrack_pageid;if(l!=""&&l!="-"){c.ali_beacon_id=l;c.inc=0}dmtrack.SendMessage(e,{},c,"",o)}else{if(typeof(g)=="object"){for(var b in g){c[b]=g[b]}c.st_page_id=window.dmtrack_pageid;if(l!=""&&l!="-"){c.ali_beacon_id=l;c.inc=0}dmtrack.SendMessage(e,{},c,"",o)}}}catch(h){var a=dmtrack.getErrInfo(h);var f=dmtrack.err_url+"?type=clickstat&exception="+encodeURIComponent(a.toString());dmtrack.SendMessage(f)}};dmtrack.flash_dmtracking=function(c,k){try{dmtrack_pageid=dmtrack.getRand();var a="GET";var f=dmtrack.get_cookie("ali_apache_track");var i=dmtrack.beacon_url;try{if(!dmtrack_c){dmtrack_c="{-}"}}catch(j){dmtrack_c="{-}"}dmtrack.SendMessage(i,{p:"{"+dmtrack.profile_site+"}",u:"{"+c+"}",m:"{"+a+"}",s:"{200}",r:"{"+k+"}",a:"{"+f+"}",b:"{-}",c:dmtrack_c},{pageid:dmtrack_pageid,dmtrack_type:"xuanwangpu"})}catch(h){var b=dmtrack.getErrInfo(h);var g=dmtrack.err_url+"?type=flash&exception="+encodeURIComponent(b.toString());dmtrack.SendMessage(g)}dmtrack.isDmTracked=true};dmtrack.feedback=function(c){var f=dmtrack.feedback_url;if(c.indexOf("?")>-1){f=f+c}else{f=f+"?"+c}var a="";try{a=document.cookie.match(/track_cookie[^;]*cosite=(\w+)/)[1]}catch(b){}if(a.length>0){f=f+"&fromsite="+a}dmtrack.beacon_click(f,"-");dmtrack.SendMessage(f,{},{});return true};dmtrack.feedbackTraceLog=function(b,a){return true};dmtrack.acookie=function(){function c(g){return Math.floor(Math.random()*g)+1}var f=escape(document.referrer);var e=dmtrack.cmap_url;var a=dmtrack.cnamap_url;var b=dmtrack.get_cookie("cna");if(e&&b!==""&&b!=="-"){dmtrack.sendImg(e+"?cna="+encodeURIComponent(b))}dmtrack.SendMessage(dmtrack.acookie_url,{},{cache:c(9999),pre:f},"",false,function(){var g=dmtrack.get_cookie("cna");if(e&&g!==""&&g!=="-"){dmtrack.sendImg(e+"?cna="+encodeURIComponent(g))}if(a&&g!==b){var h=dmtrack.get_cookie("ali_beacon_id");dmtrack.sendImg(a+"?cna="+encodeURIComponent(g)+"&pageid="+encodeURIComponent(dmtrack_pageid)+"&ali_beacon_id="+encodeURIComponent(h))}})};function sk_dmtracking_core(){if(dmtrack.isDmTracked){return}dmtrack_pageid=dmtrack.getRand();try{if(dmtrack.acookieSupport){dmtrack.acookie()}}catch(b){var h=dmtrack.getErrInfo(b);var c=dmtrack.err_url+"?type=acookie&exception="+encodeURIComponent(h.toString());dmtrack.SendMessage(c)}dmtrack.deleteUselessCookie();var a=dmtrack.uaMonitor().extraBrowser;var i=a.name.toLowerCase();if((i=="safari"||i=="firefox")&&window.postMessage){dmtrack.getBeaconCookieId(dmtrack.tracking)}else{dmtrack.tracking()}}function sk_dmtracking(){if(document.webkitVisibilityState=="prerender"){document.addEventListener("webkitvisibilitychange",function(){sk_dmtracking_core()},false)}else{sk_dmtracking_core()}}dmtrack.getErrInfo=function(b){var c="";for(var a in b){c+=a+"="+b[a]+";"}return c};dmtrack.getBigDomain=function(){var b=document.domain.toLowerCase();var a="";if(b.indexOf("aliexpress.com")!==-1){a=".aliexpress.com"}else{if(b.indexOf("alibaba.com")!==-1){a=".alibaba.com"}}return a};dmtrack.deleteUselessCookie=function(){dmtrack.del_cookie("ali_apache_sid","/")};dmtrack.getBeaconCookieId=function(h){var g="ali_beacon_id";var a=dmtrack.get_cookie(g);var j=dmtrack.getBigDomain();var b=0;if(j==""){h();return}if(a==""||a=="-"){window.addEventListener("message",function(m){var l=m.data;if(l.type!="get_beacon_cookie"){return}a=l.val;if(a==""||a=="-"){a=dmtrack.get_cookie(g);if(a==""||a=="-"){a=dmtrack.generateCookieId();b=1}}var k=new Date();k.setTime(k.getTime()+315360000000);dmtrack.set_cookie(g,a,k,"/",j);h(a,b)},false);var e=document.createElement("iframe");var i="";var c=document.domain;var f=/alibaba\.com$/i.test(c);i=(dmtrack.send_head==="https://"?"stylessl":"style")+"."+(f?"aliexpress":"alibaba")+".com/js/beacon-cookie.html";e.src=dmtrack.send_head+i;e.style.width="1px";e.style.height="1px";e.style.position="absolute";e.style.top="-10000px";e.style.left="-10000px";e.style.visibility="hidden";document.body.appendChild(e)}else{h(a,b)}};dmtrack.generateCookieId=function(){var a="ali_apache_id";var b=dmtrack.get_cookie(a);return b};dmtrack.getGMTUTCTime=function(){var b=new Date(),a=b.getTime();return a};dmtrack.isSupportCookie=function(){var c="testIsSupportCookie";var b=document.domain;var a="";dmtrack.set_cookie(c,"true","","/",b);a=dmtrack.get_cookie(c);if(a=="true"){dmtrack.del_cookie(c,"/");return true}return false};dmtrack._checkLogin=function(){if(!window.beaconData){window.beaconData={}}function a(){if(typeof window._last_loginid_info!="undefined"){return window._last_loginid_info}var b=function(c){var f="";try{f=document.cookie.match("(?:^|;)\\s*"+c+"=([^;]*)")}catch(g){}finally{return f?unescape(f[1]):""}};window._last_loginid_info=b("__cn_logon__")&&b("__cn_logon__")==="true"?b("__last_loginid__"):false;return window._last_loginid_info}if(a()!=false){window.beaconData.c_signed=1}else{window.beaconData.c_signed=0}};dmtrack.addCookieC=function(){var tmp=dmtrack_c.substring(1,dmtrack_c.length-1),result=[];if(tmp!="-"){result=tmp.split("|")}for(var i in window.beaconData){result.push(i+"="+window.beaconData[i])}try{var intl_unc_f=dmtrack.get_cookie("uns_unc_f");var match=intl_unc_f.match(/(?:^|&)trfc_i=(.*?)(&|$)/);if(match!==null){result.push("trfc_i="+match[1])}}catch(e){}try{var xman_us_f=dmtrack.get_cookie("xman_us_f");if(xman_us_f!=""||xman_us_f!="-"){var zeroIndex=0;var endIndex=xman_us_f.length-1;var quoFirstIndex=xman_us_f.indexOf('"');var quoEndIndex=xman_us_f.lastIndexOf('"');if(endIndex==quoEndIndex){xman_us_f=xman_us_f.substring(0,endIndex)}if(zeroIndex==quoFirstIndex){xman_us_f=xman_us_f.substring(1)}var alicanceCookieKey="x_as_i";var alicanceCookieValue="";var cookieArrs=xman_us_f.split("&"),cookieArr=[];if(cookieArrs.length>0){for(var i=0;i<cookieArrs.length;i++){cookieArr=cookieArrs[i].split("=");if(cookieArr[0]==alicanceCookieKey){alicanceCookieValue=cookieArr[1];break}}}if(alicanceCookieValue!=""){alicanceCookieValue=decodeURIComponent(alicanceCookieValue);var alicanceDataObject=eval("("+alicanceCookieValue+")");var alicanceSrcKey="src";var allicanceAfKey="af";var allicanceCvKey="cv";var allicanceTpKey="tp1";var alicanceCptKey="cpt";var alicanceVdKey="vd";var alicanceAffiliateKey="affiliateKey";var allicanceSrcValue=alicanceDataObject[alicanceSrcKey];var allicanceAfValue=alicanceDataObject[allicanceAfKey];var allicanceCvValue=alicanceDataObject[allicanceCvKey];var allicanceTpValue=alicanceDataObject[allicanceTpKey];var alicanceCptValue=alicanceDataObject[alicanceCptKey];var alicanceVdValue=alicanceDataObject[alicanceVdKey];var alicanceAffiliateValue=alicanceDataObject[alicanceAffiliateKey];if(allicanceSrcValue&&allicanceSrcValue!=""){result.push(alicanceSrcKey+"="+allicanceSrcValue);result.push(allicanceAfKey+"="+allicanceAfValue);result.push(allicanceCvKey+"="+allicanceCvValue);result.push(allicanceTpKey+"="+allicanceTpValue);result.push(alicanceCptKey+"="+alicanceCptValue);result.push(alicanceVdKey+"="+alicanceVdValue);result.push(alicanceAffiliateKey+"="+alicanceAffiliateValue)}}}}catch(e){}try{var aep_usuc_f=dmtrack.get_cookie("aep_usuc_f");if(aep_usuc_f!=""||aep_usuc_f!="-"){var aepCookieValue=encodeURIComponent(aep_usuc_f);result.push("aep_usuc_f="+aepCookieValue)}}catch(e){}result=result.length==0?"-":result.join("|");return"{"+result+"}"};dmtrack.uaMonitor=function(){var m={trident:0,webkit:0,gecko:0,presto:0,khtml:0,name:"other",ver:null},g={ie:0,firefox:0,chrome:0,safari:0,opera:0,konq:0,name:"other",ver:null},i={name:"",ver:null},a={win:false,mac:false,x11:false,name:"other"},c="other",b=navigator.userAgent,e=navigator.platform,h,j,f=function(n){var o=0;return parseFloat(n.replace(/\./g,function(){return(o++===0)?".":""}))};if(window.opera){m.ver=g.ver=f(window.opera.version());m.presto=g.opera=parseFloat(m.ver);m.name="presto";g.name="opera"}else{if(/AppleWebKit\/(\S+)/.test(b)){m.ver=f(RegExp["$1"]);m.webkit=m.ver;m.name="webkit";if(/Chrome\/(\S+)/.test(b)){g.ver=f(RegExp["$1"]);g.chrome=g.ver;g.name="chrome"}else{if(/Version\/(\S+)/.test(b)){g.ver=f(RegExp["$1"]);g.safari=g.ver;g.name="safari"}else{var l=1;if(m.webkit<100){l=1}else{if(m.webkit<312){l=1.2}else{if(m.webkit<412){l=1.3}else{l=2}}}g.safari=g.ver=l;g.name="safari"}}}else{if(/KHTML\/(\S+)/.test(b)||/Konqueror\/([^;]+)/.test(b)){m.ver=g.ver=f(RegExp["$1"]);m.khtml=g.konq=m.ver;m.name="khtml";g.name="konq"}else{if(/rv:([^\)]+)\) Gecko\/\d{8}/.test(b)){m.ver=f(RegExp["$1"]);m.gecko=m.ver;m.name="gecko";if(/Firefox\/(\S+)/.test(b)){g.ver=f(RegExp["$1"]);g.firefox=g.ver;g.name="firefox"}}else{if(/MSIE ([^;]+)/.test(b)){m.ver=g.ver=f(RegExp["$1"]);m.trident=g.ie=m.ver;m.name="trident";g.name="ie"}else{if(/trident.+rv:\s*(\d+(\.\d+)?)\) like gecko/i.test(b)){m.ver=g.ver=f(RegExp["$1"]);m.trident=g.ie=m.ver;m.name="trident";g.name="ie"}}}}}}i.name=g.name;i.ver=g.ver;if(h=b.match(/360SE/)){i.name="se360";i.ver=3}else{if((h=b.match(/Maxthon/))&&(j=window.external)){i.name="maxthon";try{i.ver=f(j.max_version)}catch(k){i.ver=0.1}}else{if(h=b.match(/TencentTraveler\s([\d.]*)/)){i.name="tt";i.ver=f(h[1])||0.1}else{if(h=b.match(/TheWorld/)){i.name="theworld";i.ver=3}else{if(h=b.match(/SE\s([\d.]*)/)){i.name="sougou";i.ver=f(h[1])||0.1}}}}}a.win=e.indexOf("Win")==0;a.mac=e.indexOf("Mac")==0;a.x11=(e=="X11")||(e.indexOf("Linux")==0);if(a.win){if(/Win(?:dows )?([^do]{2})\s?(\d+\.\d+)?/.test(b)){if(RegExp["$1"]=="NT"){switch(RegExp["$2"]){case"5.1":a.win="XP";break;case"6.1":a.win="7";break;case"5.0":a.win="2000";break;case"6.0":a.win="Vista";break;default:a.win="NT";break}}else{if(RegExp["$1"]=="9x"){a.win="ME"}else{a.win=RegExp["$1"]}}}a.name="windows"+a.win}if(a.mac){a.name="mac"}if(a.x11){a.name="x11"}if(a.win=="CE"){c="windows mobile"}else{if(/ Mobile\//.test(b)){c="apple"}else{if((h=b.match(/NokiaN[^\/]*|Android \d\.\d|webOS\/\d\.\d/))){c=h[0].toLowerCase()}}}return{engine:m,browser:g,extraBrowser:i,system:a,mobile:c}};
;
dmtrack.profile_site=5;dmtrack.acookie_url=dmtrack.send_head+"acookie.aliexpress.com/1.gif";dmtrack.isgetApacheId=true;dmtrack.cmap_url="http://cmap.alibaba.com/landing_ae.gif";
;
(function(){var aa=window,E=document,j=location,aB=true,i=false;var ag=j.href;var v="https:"==j.protocol;var aC=(v?"https://":"http://")+"stat.alibaba.com/";var h=i;var ax,aw,M;var y={};var ap;var p;var r="0.0";var ab=false;var R="::-plain-::";var ac;var X=!!E.attachEvent;var Y="attachEvent";var m="addEventListener";var aj=X?Y:m;var l;var n;var q=i;var Q={};var av=i;var T;var ad="data-spm";var ao="data-spm-protocol";var aq;var W="data-spm-wangpu-module-id";var A="data-spm-anchor-id";function ak(aE){var aD,aH;try{aD=[].slice.call(aE);return aD}catch(aG){aD=[];aH=aE.length;for(var aF=0;aF<aH;aF++){aD.push(aE[aF])}return aD}}function D(aD,aE){return aD&&aD.getAttribute?(aD.getAttribute(aE)||""):""}function x(aD,aG,aE){if(aD&&aD.setAttribute){try{aD.setAttribute(aG,aE)}catch(aF){}}}function P(aD,aF){if(aD&&aD.removeAttribute){try{aD.removeAttribute(aF)}catch(aE){x(aD,aF,"")}}}function V(aE,aD){return aE.indexOf(aD)==0}function ay(aD){return typeof aD=="string"}function K(aD){return typeof aD=="number"}function d(aD){return Object.prototype.toString.call(aD)==="[object Array]"}function az(aE,aD){return aE.indexOf(aD)>=0}function ar(aE,aD){return aE.indexOf(aD)>-1}function z(aG,aD){for(var aF=0,aE=aD.length;aF<aE;aF++){if(ar(aG,aD[aF])){return aB}}return i}function at(aD){return ay(aD)?aD.replace(/^\s+|\s+$/g,""):""}function w(aD){return typeof aD=="undefined"}function e(){l=l||E.getElementsByTagName("head")[0];return n||(l?(n=l.getElementsByTagName("meta")):[])}function an(){var aH=e(),aF,aE,aG,aD;for(aF=0,aE=aH.length;aF<aE;aF++){aG=aH[aF];aD=D(aG,"name");if(aD==ad){T=D(aG,ao)}}}function F(aI){var aK=e(),aH,aF,aE,aJ,aD,aG;if(aK){for(aH=0,aF=aK.length;aH<aF;aH++){aJ=aK[aH];aD=D(aJ,"name");if(aD==aI){ap=D(aJ,"content");if(ap.indexOf(":")>=0){aE=ap.split(":");T=aE[0]=="u"?"u":"i";ap=aE[1]}aG=D(aJ,ao);if(aG){T=(aG=="u"?"u":"i")}p=V(ap,"110");M=(p?r:ap);return aB}}}return i}function af(){return Math.floor(Math.random()*268435456).toString(16)}function t(aG){var aD=[],aF,aE;for(aF in aG){if(aG.hasOwnProperty(aF)){aE=""+aG[aF];aD.push(V(aF,R)?aE:(aF+"="+encodeURIComponent(aE)))}}return aD.join("&")}function ae(aE){var aF=[],aH,aG,aI,aD=aE.length;for(aI=0;aI<aD;aI++){aH=aE[aI][0];aG=aE[aI][1];aF.push(V(aH,R)?aG:(aH+"="+encodeURIComponent(aG)))}return aF.join("&")}function U(aE){var aD;try{aD=at(aE.getAttribute("href",2))}catch(aF){}return aD||""}function L(aE,aF,aD){aE[aj]((X?"on":"")+aF,function(aH){aH=aH||aa.event;var aG=aH.target||aH.srcElement;aD(aH,aG)},i)}function o(aD){var aE=aa.KISSY;if(aE){aE.ready(aD)}else{if(aa.jQuery){jQuery(E).ready(aD)}else{if(E.readyState==="complete"){aD()}else{L(aa,"load",aD)}}}}function H(aF,aH){var aE=new Image(),aJ="_img_"+Math.random(),aG=aF.indexOf("?")==-1?"?":"&",aI,aD=aH?(d(aH)?ae(aH):t(aH)):"";aa[aJ]=aE;aE.onload=aE.onerror=function(){aa[aJ]=null};aE.src=aI=aD?(aF+aG+aD):aF;aE=null;return aI}function au(){if(!w(M)){return M}if(aa._SPM_a&&aa._SPM_b){ax=aa._SPM_a.replace(/^{(\w+)}$/g,"$1");aw=aa._SPM_b.replace(/^{(\w+)}$/g,"$1");q=aB;M=ax+"."+aw;an();return M}F(ad)||F("spm-id");if(!M){ab=true;M=r;return r}var aD=E.getElementsByTagName("body");var aF;var aE;aD=aD&&aD.length?aD[0]:null;if(aD){aF=D(aD,ad);if(aF){aE=M.split(".");M=aE[0]+"."+aF}}if(!ar(M,".")){ab=true;M=r}return M}function am(aH){var aJ=E.getElementsByTagName("*"),aE,aG,aF,aK,aI,aD;for(aE=[];aH&&aH.nodeType==1;aH=aH.parentNode){if(aH.hasAttribute("id")){aD=aH.getAttribute("id");aK=0;for(aG=0;aG<aJ.length;aG++){aI=aJ[aG];if(aI.hasAttribute("id")&&aI.id==aD){aK++;break}}if(aK==1){aE.unshift('id("'+aD+'")');return aE.join("/")}else{aE.unshift(aH.localName.toLowerCase()+'[@id="'+aD+'"]')}}else{for(aG=1,aF=aH.previousSibling;aF;aF=aF.previousSibling){if(aF.localName==aH.localName){aG++}}aE.unshift(aH.localName.toLowerCase()+"["+aG+"]")}}return aE.length?"/"+aE.join("/"):null}function b(aD){var aE=Q[am(aD)];return aE?aE.spmc:""}function al(aE){var aL,aJ,aH,aD,aK,aI=[],aM,aG,aF;aL=ak(aE.getElementsByTagName("a"));aJ=ak(aE.getElementsByTagName("area"));aD=aL.concat(aJ);for(aG=0,aF=aD.length;aG<aF;aG++){aM=false;aK=aH=aD[aG];while(aK=aK.parentNode){if(aK==aE){break}if(D(aK,ad)){aM=true;break}}if(!aM){aI.push(aH)}}return aI}function C(aE,aF,aG){var aM,aI,aO,aD,aL,aR,aK,aJ,aH,aQ,aP,aT,aN,aU,aS;if(D(aE,"data-spm-delay")){aE.setAttribute("data-spm-delay","");return}aF=aF||aE.getAttribute(ad)||"";if(!aF){return}aM=al(aE);aO=aF.split(".");aT=(V(aF,"110")&&aO.length==3);if(aT){aN=aO[2];aU=aN.split("-");aO[2]="w"+((aU.length>1)?aU[1]:"0");aF=aO.join(".")}if(ay(aJ=au())&&aJ.match(/^[\w\-\*]+(\.[\w\-\*]+)?$/)){if(!az(aF,".")){if(!az(aJ,".")){aJ+=".0"}aF=aJ+"."+aF}else{if(!V(aF,aJ)){aD=aJ.split(".");aO=aF.split(".");for(aQ=0,aH=aD.length;aQ<aH;aQ++){aO[aQ]=aD[aQ]}aF=aO.join(".")}}}if(!aF.match||!aF.match(/^[\w\-\*]+\.[\w\-\*]+\.[\w\-\*]+$/)){return}aS=parseInt(D(aE,"data-spm-max-idx"))||0;for(aP=0,aL=aS,aH=aM.length;aP<aH;aP++){aI=aM[aP];aR=U(aI);if(!aR){continue}if(aT){aI.setAttribute(W,aN)}if(aK=aI.getAttribute(A)){s(aI,aK,aG);continue}aL++;aK=aF+"."+(aA(aI)||aL);s(aI,aK,aG)}aE.setAttribute("data-spm-max-idx",aL)}function a(aF){var aE=["mclick.simba.taobao.com","click.simba.taobao.com","click.tanx.com","click.mz.simba.taobao.com","click.tz.simba.taobao.com","redirect.simba.taobao.com","rdstat.tanx.com","stat.simba.taobao.com","s.click.taobao.com"],aG,aD=aE.length;for(aG=0;aG<aD;aG++){if(aF.indexOf(aE[aG])!=-1){return true}}return false}function ai(aD){return aD?(!!aD.match(/^[^\?]*\balipay\.(?:com|net)\b/i)):i}function g(aD){return aD?(!!aD.match(/^[^\?]*\balipay\.(?:com|net)\/.*\?.*\bsign=.*/i)):i}function I(aE){var aD;while((aE=aE.parentNode)&&aE.tagName!="BODY"){aD=D(aE,ao);if(aD){return aD}}return""}function O(aF,aL){if(aF&&/&?\bspm=[^&#]*/.test(aF)){aF=aF.replace(/&?\bspm=[^&#]*/g,"").replace(/&{2,}/g,"&").replace(/\?&/,"?").replace(/\?$/,"")}if(!aL){return aF}var aM,aI,aK,aJ="&",aG,aE,aD,aH;if(aF.indexOf("#")!=-1){aK=aF.split("#");aF=aK.shift();aI=aK.join("#")}aG=aF.split("?");aE=aG.length-1;aK=aG[0].split("//");aK=aK[aK.length-1].split("/");aD=aK.length>1?aK.pop():"";if(aE>0){aM=aG.pop();aF=aG.join("?")}if(aM&&aE>1&&aM.indexOf("&")==-1&&aM.indexOf("%")!=-1){aJ="%26"}aF=aF+"?spm="+aL+(aM?(aJ+aM):"")+(aI?("#"+aI):"");aH=ar(aD,".")?aD.split(".").pop().toLowerCase():"";if(aH){if(({png:1,jpg:1,jpeg:1,gif:1,bmp:1,swf:1}).hasOwnProperty(aH)){return 0}if(!aM&&aE<=1){if(!aI&&!({htm:1,html:1,php:1}).hasOwnProperty(aH)){aF+="&file="+aD}}}return aF}function k(aD){return aD&&(ag.split("#")[0]==aD.split("#")[0])}function s(aF,aH,aG){aF.setAttribute(A,aH);if(aG){return}ac=aa.g_aplus_pv_id;if(ac){aH+="."+ac}if(!ac&&(!M||M==r)){return}var aE=U(aF);var aI=(D(aF,ao)||I(aF)||T)=="i";var aD=aC+"spm.html?spm=";if(!aE||a(aE)){return}if(!aI&&(V(aE,"#")||k(aE)||V(aE.toLowerCase(),"javascript:")||ai(aE)||g(aE))){return}if(aI){aD+=aH+"&refer_url="+encodeURIComponent(ag)+"&url="+encodeURIComponent(aE)+"&cache="+af();if(aq==aF){H(aD)}}else{if(!aG){(aE=O(aE,aH))&&B(aF,aE)}}}function B(aG,aF){var aD,aE=aG.innerHTML;if(aE&&aE.indexOf("<")==-1){aD=E.createElement("b");aD.style.display="none";aG.appendChild(aD)}aG.href=aF;if(aD){aG.removeChild(aD)}}function aA(aE){var aG,aD,aF;if(ab){aG="0"}else{if(q){aD=am(aE);aF=Q[aD];if(aF){aG=aF.spmd}}else{aG=D(aE,ad);if(!aG||!aG.match(/^d\w+$/)){aG=""}}}return aG}function c(aF){var aG,aE,aD=aF;while(aF&&aF.tagName!="HTML"&&aF.tagName!="BODY"&&aF.getAttribute){if(!q){aE=aF.getAttribute(ad)}else{aE=b(aF)}if(aE){aG=aE;aD=aF;break}if(!(aF=aF.parentNode)){break}}return{spm_c:aG,el:aD}}function N(aE){var aD;return(aE&&(aD=aE.match(/&?\bspm=([^&#]*)/)))?aD[1]:""}function f(aG){var aF=E.getElementsByTagName("a"),aD=aF.length,aE;for(aE=0;aE<aD;aE++){if(aF[aE]==aG){return aE+1}}return 0}function J(aI,aF){var aD=U(aI),aH=N(aD),aG=aH?aH.split("."):null,aK,aJ,aE=M&&(aK=M.split(".")).length==2;if(aG&&aG.length>=4&&aG[3]){if(aG[0]=="1003"||aG[0]=="2006"){}else{if(aE){aG[0]=aK[0];aG[1]=aK[1];if(ab){aG[2]="0"}aJ=aA(aI);if(aJ){aG[3]=aJ}}}s(aI,aG.slice(0,4).join("."),aF);return}else{if(aE){aG=[M,0,aA(aI)||f(aI)];s(aI,aG.join("."),aF);return}}if(aD&&aH){aI.href=" "+aD.replace(/&?\bspm=[^&#]*/g,"").replace(/&{2,}/g,"&").replace(/\?&/,"?").replace(/\?$/,"").replace(/\?#/,"#")}}function G(aF,aD){aq=aF;var aE=D(aF,A),aG,aH;if(!aE){aG=c(aF.parentNode);aH=aG.spm_c;if(!aH){J(aF,aD);return}if(ab){aH="0"}C(aG.el,aH,aD)}else{s(aF,aE,aD)}}function S(aH){if(!aH||aH.nodeType!=1){return}P(aH,"data-spm-max-idx");var aE=ak(aH.getElementsByTagName("a")),aG=ak(aH.getElementsByTagName("area")),aI=aE.concat(aG),aF,aD=aI.length;for(aF=0;aF<aD;aF++){P(aI[aF],A)}}function Z(aD){var aI=aD.parentNode;if(!aI){return""}var aG=aD.getAttribute(ad);var aE=c(aI);var aH=aE.spm_c||0;if(aH&&aH.indexOf(".")!=-1){aH=aH.split(".");aH=aH[aH.length-1]}var aF=M+"."+aH;aG=aG||y[aF]||0;if(K(aG)){aG++;y[aF]=aG}return aF+".i"+aG}function u(aE){var aF=aE.tagName;var aD;ac=aa.g_aplus_pv_id;if(aF!="A"&&aF!="AREA"){aD=Z(aE)}else{G(aE,aB);aD=D(aE,A)}aD=(aD||"0.0.0.0").split(".");return{a:aD[0],b:aD[1],c:aD[2],d:aD[3],e:ac}}function ah(){if(av){return}if(!aa.spmData){if(!h){setTimeout(arguments.callee,100)}return}av=aB;var aG=aa.spmData["data"],aF,aD,aH,aE;if(!aG||!d(aG)){return}for(aF=0,aD=aG.length;aF<aD;aF++){aH=aG[aF];aE=aH.xpath;Q[aE]={spmc:aH.spmc,spmd:aH.spmd}}}if(z(ag,["xiaobai.com","admin.taobao.org"])){return}o(function(){h=aB});au();ah();L(E,"mousedown",function(aE,aD){var aF;while(aD&&(aF=aD.tagName)){if(aF=="A"||aF=="AREA"){G(aD,i);break}else{if(aF=="BODY"||aF=="HTML"){break}}aD=aD.parentNode}});aa.g_SPM={resetModule:S,anchorBeacon:G,getParam:u}})();
;

;
