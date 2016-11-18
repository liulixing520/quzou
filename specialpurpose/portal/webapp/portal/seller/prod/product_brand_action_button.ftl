<script language="javascript"> 
	jQuery("#" + 'ProductBrandAdd').attr("disabled", false);
    jQuery("#" + 'ProductBrandAdd').bind('click', function() {
      	   var path = "EditProductBrand";
	       url_to_post(path,"post");
    });
</script>
