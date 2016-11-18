<script type="text/javascript">
function changeSelect(thisDom,targetElementId){
 		var url = "<@ofbizUrl>changeWebSite</@ofbizUrl>";
 		var websiteId = thisDom.value;
 		var param = {'websiteId':websiteId};
 		$.post(url,param,function(data){
 			if(data!='null'){
				$('#'+targetElementId).html(data);
			}
		},'html');
 	}
</script>