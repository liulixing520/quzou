

<script language="javascript">
<!-- list类型的form中 radio单选按钮控制js  -->
	function setRadio(baseId){
        var radioByName="baseId";
        var rBaseId =  baseId
		var radios = document.getElementsByName(radioByName);
		for(var i=0;i<radios.length;i++){
		  radios[i].checked=false;
	      if (radios[i].value==rBaseId){ radios[i].checked=true;}
	    }
	}
	function getRadioValue(){ 
        var radioByName="baseId";
		var radios = document.getElementsByName(radioByName);
		for(var i=0;i<radios.length;i++){
	      if (radios[i].checked==true ){ return radios[i].value;}
	    }
	    alert("请选择一条数据.");return;
	}
</script>	
	
	
<script language="javascript">
<!-- list类型的form中 checkbox多选按钮控制js  -->
	<!--全选按钮事件 -->
    var ofo_selectAll_flag= false;
    function selectAll() {
		ofo_selectAll_flag = !ofo_selectAll_flag;
		var tmpIdList = "";  
		var allsel=document.getElementsByName("baseId");
		
		if (ofo_selectAll_flag == true) {
	   		for (var i=0;i<allsel.length;i++) {
				allsel[i].checked = true;
				 tmpIdList +=allsel[i].value+";";
			}
			if(tmpIdList!=""){controlButtonStatus("Y");}
			
	   	} else {
	   		for (var i=0;i<allsel.length;i++) {
				allsel[i].checked = false;
			}
			controlButtonStatus("N");
	   	}
	}
	<!--单个checkbox按钮事件 -->
function setCheckBoxOld(){
        var checkboxByName="baseId";
        var allCheckBoxId="allCheckBoxId"
		var allsel=document.getElementsByName(checkboxByName);
		var allCheckBox = document.getElementById("allCheckBoxId");
		var allCheckBoxIsChecked =allCheckBox.checked;
		var isNotAll= isNotAllChecked(allsel);
		if (isNotAll&&allCheckBoxIsChecked){
		    allCheckBox.checked=false;
		    ofo_selectAll_flag = !ofo_selectAll_flag;
		}
	}
	function setCheckBox(){
       
	}
	function isNotAllChecked(allsel){
		for(var i=0;i<allsel.length;i++){
	      if (allsel[i].checked==false){return true;}
	    }
	    return false;
	}
    function getCheckBoxSingleValue(){
        var result="";
        var num=0;
        var checkboxByName="baseId";
		var checkboxs = document.getElementsByName(checkboxByName);
		for(var i=0;i<checkboxs.length;i++){
	      if (checkboxs[i].checked==true ){
	             num++; 
	             result=checkboxs[i].value;
	             }
	    }
	    if(num==1)return result;
	    if(num>1){alert("只能选择一条数据");return;}
	    if(num==0){alert("请选择一条数据.");return;}
	    
	}
	function getCheckBoxMultiValue(){ 
	    var result = "";var num=0;
        var checkboxByName="baseId";
		var checkboxs = document.getElementsByName(checkboxByName);
		for(var i=0;i<checkboxs.length;i++){
	      if (checkboxs[i].checked){ num++; result +=checkboxs[i].value+";";}
	    }
	    
	    if(num>0)return result;
	    if(num==0){alert("请选择一条数据.");return;}
	}
    
	
	
	 var select_flag= false;
    function newSelectAll(id) {
		select_flag = !select_flag;
		var idList = "";  
		var newAllsel=document.getElementsByName(id);
		
		if (select_flag == true) {
	   		for (var i=0;i<newAllsel.length;i++) {
				newAllsel[i].checked = true;
				 idList +=newAllsel[i].value+";";
			}
	   	} else {
	   		for (var i=0;i<newAllsel.length;i++) {
				newAllsel[i].checked = false;
			}
	   	}
	}
	
	function getNewCheckBoxMultiValue(id){ 
	    var result = "";var num=0;
        var checkboxByName=id;
		var checkboxs = document.getElementsByName(checkboxByName);
		for(var i=0;i<checkboxs.length;i++){
	      if (checkboxs[i].checked){ num++; result +=checkboxs[i].value+";";}
	    }
	    
	    if(num>0)return result;
	    if(num==0){alert("请选择一条数据.");return;}
	}
	
	function controlButtonStatus(value){
	
	}
</script>