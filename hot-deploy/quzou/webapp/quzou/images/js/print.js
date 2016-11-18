window.addListener = function(element,eventName,callback){
    if(window.addEventListener){
        element.addEventListener(eventName,callback,false);
    }else{
        element.attachEvent(eventName,callback);
    }
};

//global.print方法用于打印另一个url地址
/*
 * 参数
 * url:    要打印的url地址
 * width:  宽度(px数字)
 * height: 高度(px数字)
*/
var global = {
    clearPrint:function(){
        try{
            var HKEY_Root = "HKEY_CURRENT_USER";
            var HKEY_Path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
            var regWsh    = new ActiveXObject("WScript.Shell")
            //写入注册表,打印时候header为空字符串
            regWsh.RegWrite(HKEY_Root + HKEY_Path + "header","");
            //写入注册表,打印时候footer为空字符串
            regWsh.RegWrite(HKEY_Root + HKEY_Path + "footer","");
        }catch(e){}
    },
    createIframe:function(){


        //将这个iframe元素添加到body里面
        document.body.appendChild(global.iframe = document.createElement("iframe"));
    },
    print:function(url){
        //清空页眉页角
        global.clearPrint();

        if(!global.iframe){
            global.createIframe();
        }
        //设置iframe元素的src地址,这个地址就是打印的地址
        global.iframe.src = url;
        //添加onload
        if(global.iframe.attachEvent){
            global.iframe.attachEvent("onload",function(){
                global.iframe.contentWindow.focus();
                global.iframe.contentWindow.print();
            });
        }else{
            global.iframe.onload = function(){
                global.iframe.contentWindow.print();
            };
        }
        //设置border 0
        global.iframe.style.border  = 0;
        //设置iframe的宽度等于,width 参数加上px字符串,这个参数必须为数字
        global.iframe.style.width   = "0px";
        //设置iframe的高度等于,height 参数加上px字符串,这个参数必须为数字
        global.iframe.style.height  = "0px";
    }
};
/*
 * printContent.html 页面里面的body中onload之后执行window.print() 打印
*/