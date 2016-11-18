<script src="/images/jquery/plugins/validate/jquery.validate.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/jeditable/jquery.jeditable.js" type="text/javascript"></script>
<script src="/images/jquery/ui/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
<script src="/images/jquery/plugins/datetimepicker/jquery-ui-timepicker-addon.min-1.4.3.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/javascript.css">
<style type="text/css">
.nav-tabs li{list-style:none;}
.nav-tabs li.current a{background:#b3d9ff; color:#000; font-weight:bold;}
.window{ 
      width:500px;
      height:200px; 
      background-color:#d0def0; 
      position:absolute; 
      padding:0px; 
      margin:05px; 
      } 

</style>
  <script type="text/javascript">
  	 $(function(){ 
		$(".breadcrumb").append("<li class='active'>店铺信息</li><li class='active'>设置服务区域</li>")		
	}); 
	function changeShow(obj){
		$("#"+obj).css("display","block");
	}
	function changeHidden(obj){
		$(obj).parent().css("display","none");
	}
	
	//打开弹出框
	
	function openDeliage(obj){
		$("#"+obj).css("display","block");
		<#-- 
		$("#"+obj).dialog({
            close: function(event, ui) { 
            alert(ui);
            $( this ).reset(); },
            autoOpen: false,
            width:320,
            height:360,
            buttons: { "确定": function() { alert('OK');},
                       "取消": function() { $( this ).dialog( "close" ) }
                	 },
		});	
		 $("#"+obj).dialog("open");
		 -->
	}
	function closeDeliage(obj){
		$("#"+obj).css("display","none");
	}
	
  </script>
<div  style="padding-bottom:5px;">
       <h1 style="padding-top:15px; font-size:18px;">设置店铺服务区域:</h1>
</div>
<form action="<@ofbizUrl>store_addressSets2</@ofbizUrl>" name="geoForm" method="post">
<div class="page-content" style="border:1px solid #ccc; margin:15px; margin-top:5px;">
<div class="page-content-area">
 <div class="row">
  <div class="col-xs-12">
  	<#--控制页面底层的显示横线 -->
    <div class="table-header"> </div>
<#if geoListSum?has_content>
   <#list geoListSum as geoM> 
    <div class="screenlet-title-bar" style="font-size:14px; color:#555; font-weight:bold;">
    	<input type="checkbox" name="firstGeos" value="${geoM.proGeo.geoId!}">${geoM.proGeo.geoName!}</input>
    	<a onclick="changeShow('${geoM.proGeo.geoId}')"><img src="../images/xiajiantou.jpg" width="20" height="20"/></a>
    	<br class="clear">
    </div>
    <div id="${geoM.proGeo.geoId!}"  style="display:none">
    	<#if geoM.secondGeo?has_content>
    		<#assign num =0 />  
        	<#list geoM.secondGeo as geo2>
        		<#assign num =num+1 />
        		<#if num==5>
        			<#assign num =0 />
        			<input type="checkbox" name="secondGeos" value="${geo2.sed.geoId!}">${geo2.sed.geoName!}</input>
        			<a onclick="openDeliage('${geo2.sed.geoId!}')"><img src="../images/operwindow.jpg" width="20" height="20"/></a>
        			<br/>
        		<#else>
        			<input type="checkbox" name="secondGeos" value="${geo2.sed.geoId!}">${geo2.sed.geoName!}</input>
        			<a onclick="openDeliage('${geo2.sed.geoId!}')"><img src="../images/operwindow.jpg" width="20" height="20"/></a>
        		</#if>
            	<div id="${geo2.sed.geoId!}" class="window" style="display:none;border:1px solid #000">
            		<#if geo2.thirdGeo?has_content>
            			<#list geo2.thirdGeo as geo3>
            				<input type="checkbox" name="thirdGeos" value="${geo3.geoId!}">${geo3.geoName!}</input>
            			</#list>
            			<a onclick="closeDeliage('${geo2.sed.geoId!}')"><img src="../images/yincang.jpg" width="20" height="20"/></a>
            		</#if>	
            	</div>
            </#list>
            <a onclick="changeHidden(this)"><img src="../images/yincang.jpg" width="20" height="20"/></a>
  		</#if>
  	</div>
   </#list>
   <br/>
</#if>
    </div>
  </div>
</div>
  </div>
  <div class="autpost-con02 clearfix" style="margin-bottom:50px; margin-left:366px;"> 
     <span><input type="submit" class="smallSubmit" value="保存服务区域" /></span>
  </div> 
 </form>