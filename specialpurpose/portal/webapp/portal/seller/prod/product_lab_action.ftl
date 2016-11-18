<script language="javascript"> 

    function submitForms(){
    	document.forms[0].action=document.forms[0].action+"?navTabId=FindProduct&callbackType=closeCurrent&ajax=1";
    	return validateCallback(document.forms[0], navTabAjaxDone);
    }
	//高度处理
    jQuery(function(){
    	try{
    		document.getElementById("pageContent").innerHTML=document.getElementById("pageContent").innerHTML.replace("div id=\"pageFormContent\"", "div id=\"pageFormContent\"  layoutH='56'");
    	}catch(error){alert(error);}
    }); 
  
</script>
<div class="formBar" >
		<ul>
		<li><a class="button" href="#" onclick='javascript:submitForms();'  ><span>
		<#if entity??>
		${uiLabelMap.CommonSave}
		
		<#else>
		${uiLabelMap.CommonCreate}
		</#if>
		</span></a></li>
			<li><div class="button"><div class="buttonContent"><button class="close" type="button">${uiLabelMap.CommonClose}</button></div></div></li>
		</ul>
	</div>  