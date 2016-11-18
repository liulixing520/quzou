<#assign featureCategoryId = "">
<#list productFeatureCategoryApplList as featureCategory>
	<#assign featureCategoryGeneriv = featureCategory.getRelatedOne("ProductFeatureCategory")?if_exists>
	<#if featureCategoryId != featureCategoryGeneriv.productFeatureCategoryId>
		<br/>
		[${featureCategoryGeneriv.description?if_exists}]
	</#if>
	<#assign featureCategoryId = featureCategoryGeneriv.productFeatureCategoryId>
	<#assign productFeatures = featureCategoryGeneriv.getRelated("ProductFeature", Static["org.ofbiz.base.util.UtilMisc"].toList("defaultSequenceNum"))>
	<#list productFeatures as feature>
	${feature.description}<input type="checkbox" value="${feature.productFeatureId}" name="productFeatureIds" 
	<#if featureList?has_content><#if featureList.contains(feature.productFeatureId)>checked="checked"</#if></#if>>&nbsp;
	</#list>
</#list>