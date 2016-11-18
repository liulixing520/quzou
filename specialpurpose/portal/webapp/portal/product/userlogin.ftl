<style type="text/css">
html,body{height:100%;}
body,div,h2{margin:0;padding:0;}
body{font:12px/1.5 Tahoma;}
center{padding-top:10px;}
#overlay{z-index:999;position:absolute;top:0;left:0;width:100%;height:100%;background:#000;opacity:0.5;filter:alpha(opacity=50);display:none;}
#win{z-index:1000;position:absolute;top:50%;left:50%;width:400px;height:200px;background:#fff;border:4px solid #ccc;margin:-102px 0 0 -202px;display:none;}
#logintitle{font-size:12px;height:18px;text-align:right;background:#ddd;border-bottom:3px solid #ccc; line-height:18px; padding:5px;cursor:move;}
#close{color:#f90;cursor:pointer;background:#fff;border:1px solid #f90;padding:0 3px; line-height:15px;}
#logintitle {align:left;color:White;}
</style>
<script type="text/javascript">
var userlogindl;
var userloginclos;
function userlogin(){
userlogindl();
}
window.onload = function ()
{
 var oWin = document.getElementById("win");
 var oLay = document.getElementById("overlay"); 
 var oClose = document.getElementById("close");
 var oH2 = oWin.getElementsByTagName("h2")[0];
 var bDrag = false;
 var disX = disY = 0;
 userlogindl= function ()
 {
  oLay.style.height=document.body.scrollHeight+"px";
  oLay.style.display = "block";
  oWin.style.display = "block" ;
 };
 userloginclos = function ()
 {
  oLay.style.display = "none";
  oWin.style.display = "none"
 };
 oClose.onclick = function ()
 {
  oLay.style.display = "none";
  oWin.style.display = "none"
 };
 oClose.onmousedown = function (event)
 {
  (event || window.event).cancelBubble = true;
 };
 oH2.onmousedown = function (event)
 {  
  var event = event || window.event;
  bDrag = true;
  disX = event.clientX - oWin.offsetLeft;
  disY = event.clientY - oWin.offsetTop;  
  this.setCapture && this.setCapture();  
  return false
 };
 document.onmousemove = function (event)
 {
  if (!bDrag) return;
  var event = event || window.event;
  var iL = event.clientX - disX;
  var iT = event.clientY - disY;
  var maxL = document.documentElement.clientWidth - oWin.offsetWidth;
  var maxT = document.documentElement.clientHeight - oWin.offsetHeight;  
  iL = iL < 0 ? 0 : iL;
  iL = iL > maxL ? maxL : iL;   
  iT = iT < 0 ? 0 : iT;
  iT = iT > maxT ? maxT : iT;
  
  oWin.style.marginTop = oWin.style.marginLeft = 0;
  oWin.style.left = iL + "px";
  oWin.style.top = iT + "px";  
  return false
 };
 document.onmouseup = window.onblur = oH2.onlosecapture = function ()
 {
  bDrag = false;    
  oH2.releaseCapture && oH2.releaseCapture();
 };
};
 </script>
 <div id="overlay"></div>
<div id="win"><h2 id="logintitle"><span id="dltetle" style="float:left; font-size:13px; font-weight:bold; color:#555;">用户登录</span><span id="close" style="float:right;">×</span></h2>

<div class="" style="margin-top:20px;margin-bottom:-40px">
    <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" name="loginform">
        <input type="hidden" name="JavaScriptEnabled" value="Y"/>
        
        <div class="form-detail" style="padding-left:60px;">
            <table>
                <tr style="height:35px;">
                    <th>
                        ${uiLabelMap.CommonUsername}：
                    </th>
                    <td>
                        <input type="text" id="userName" style="border:1px solid #ccc; height:25px; width:195px; padding-left:5px;" name="USERNAME"
                               value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>"/>
                    </td>
                </tr>
            <#if autoUserLogin?has_content>
                <p>(${uiLabelMap.CommonNot} ${autoUserLogin.userLoginId}? <a
                        href="<@ofbizUrl>${autoLogoutUrl!}</@ofbizUrl>">${uiLabelMap.CommonClickHere}</a>)</p>
            </#if>
                <tr style="height:55px;">
                    <th>
                        ${uiLabelMap.CommonPassword}：
                    </th>
                    <td>
                        <input type="password" id="password" style="border:1px solid #ccc; height:25px; width:195px; padding-left:5px;" name="PASSWORD" value=""/>
                    </td>
                </tr>
            </table>
            <div class="submit-box" style="padding-left:48px;">
                <input id="submit-btn" class="ui-button ui-button-primary ui-button-large"
                       value=" ${uiLabelMap.CommonLogin} " tabindex="8"
                       type="submit">
                <input id="submit-btn" class="ui-button ui-button-primary ui-button-large"  style="background:#ccc; border:1px solid #bbb; padding:8px 24px;"
                       value="关闭 " tabindex="8"
                       type="Button" onclick="userloginclos()">
            </div>
        </div>
        <div style="clear:both;"></div>
    </form>
    <div style="clear:both;"></div>
</div>
<div class="endcolumns">&nbsp;</div>
<script language="JavaScript" type="text/javascript">
    <#if autoUserLogin?has_content>document.loginform.PASSWORD.focus();</#if>
    <#if !autoUserLogin?has_content>document.loginform.USERNAME.focus();</#if>
</script>

</div>
