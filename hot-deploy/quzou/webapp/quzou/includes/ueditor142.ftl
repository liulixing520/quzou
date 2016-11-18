<#--插件资源文件存放目录-->
<#if !plugin_url_ueditor?has_content>
    <#assign plugin_url_ueditor = "../images/js/ueditor142/"/>
</#if>

<#if !plugin_ueditor_id?has_content>
    <#assign plugin_ueditor_id = "plugin_ueditor_id"/>
</#if>
<#--插件资源文件引入-->
<link href="${StringUtil.wrapString(plugin_url_ueditor)}themes/default/css/ueditor.css" type="text/css" rel="stylesheet">

<script type="text/javascript" charset="utf-8" src="${StringUtil.wrapString(plugin_url_ueditor)}ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${StringUtil.wrapString(plugin_url_ueditor)}ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${StringUtil.wrapString(plugin_url_ueditor)}lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript">
    <#if plugin_ueditor_id?has_content && plugin_ueditor_id?is_collection>
        <#list plugin_ueditor_id as item>
    UE.getEditor('${item}', {
        initialFrameWidth: 768, 
        initialFrameHeight:200,
       	scaleEnabled:false,
       	autoHeightEnabled:false,
       	minFrameHeight:200,
    	imageActionName : "<@ofbizUrl>uploaderUe?Type=Image</@ofbizUrl>",
        serverUrl: '<@ofbizUrl>uploaderUe?Type=Image</@ofbizUrl>',
        imageFieldName: "upfileImage",
        imageAllowFiles: [".png", ".jpg", ".jpeg", ".gif", ".bmp"],
        imageUrlPrefix:"",
        
        fileActionName: "<@ofbizUrl>uploadfile111</@ofbizUrl>", /* controller里,执行上传视频的action名称 */ 
        fileMaxSize: 51200000,
        fileFieldName: "upfileFile",
        fileAllowFiles: [
        ".png", ".jpg", ".jpeg", ".gif", ".bmp",
        ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
        ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
        ".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
        ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"],
    	fileUrlPrefix: ""
    });
        </#list>
    <#else>
    UE.getEditor('${plugin_ueditor_id}', {
        initialFrameWidth: 768, 
        initialFrameHeight:200,
        scaleEnabled:false,
        autoHeightEnabled:false,
        minFrameHeight:200, 
    	imageActionName : "<@ofbizUrl>uploaderUe?Type=Image</@ofbizUrl>",
    	imageFieldName: "upfileImage",
        serverUrl: '<@ofbizUrl>uploaderUe?Type=Image</@ofbizUrl>',
        imageAllowFiles: [".png", ".jpg", ".jpeg", ".gif", ".bmp"],
        imageUrlPrefix:"",
        
        fileActionName: "<@ofbizUrl>uploaderUe?Type=File</@ofbizUrl>", /* controller里,执行上传视频的action名称 */ 
        fileMaxSize: 51200000,
        fileFieldName: "upfileFile",
        fileAllowFiles: [
        ".png", ".jpg", ".jpeg", ".gif", ".bmp",
        ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
        ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
        ".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
        ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml", ".jar"],
    	fileUrlPrefix: "" 
    });
    </#if>
    
</script>

    