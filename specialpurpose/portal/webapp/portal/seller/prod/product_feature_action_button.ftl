<script language="javascript"> 
	jQuery("#" + 'ProductFeatureCategoryAdd').attr("disabled", false);
    jQuery("#" + 'ProductFeatureCategoryAdd').bind('click', function() {
      	   var path = "EditProductsFeatureCategory";
	       url_to_post(path,"post");
    });
</script>
