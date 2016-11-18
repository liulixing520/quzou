<script language="javascript"> 
	jQuery("#" + 'EditProduct').attr("disabled", false);
    jQuery("#" + 'EditProduct').bind('click', function() {
      	    var path = "EditProduct";
	       url_to_post(path,"post");
    });
</script>
