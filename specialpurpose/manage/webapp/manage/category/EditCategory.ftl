<script language="JavaScript" type="text/javascript">
    function insertImageName(type, nameValue) {
        eval('document.productCategoryForm.' + type + 'ImageUrl.value=nameValue;');
    }
    ;
</script>
<#--<#if fileType?has_content>
<div class="screenlet">
    <div class="screenlet-title-bar">
        <h3>${uiLabelMap.ProductResultOfImageUpload}</h3>
    </div>
    <div class="screenlet-body">
        <#if !(clientFileName?has_content)>
            <div>${uiLabelMap.ProductNoFileSpecifiedForUpload}.</div>
        <#else>
            <div>${uiLabelMap.ProductTheFileOnYourComputer}: <b>${clientFileName?if_exists}</b></div>
            <div>${uiLabelMap.ProductServerFileName}: <b>${fileNameToUse?if_exists}</b></div>
            <div>${uiLabelMap.ProductServerDirectory}: <b>${imageServerPath?if_exists}</b></div>
            <div>${uiLabelMap.ProductTheUrlOfYourUploadedFile}: <b><a
                    href="<@ofbizContentUrl>${imageUrl?if_exists}</@ofbizContentUrl>">${imageUrl?if_exists}</a></b>
            </div>
        </#if>
    </div>
</div>
</#if>-->
<div class="screenlet">
<#if ! productCategory?has_content>
    <#if productCategoryId?has_content>
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">${uiLabelMap.ProductCouldNotFindProductCategoryWithId} "${productCategoryId}".</li>
            </ul>
            <br class="clear"/>
        </div>
    <div class="screenlet-body">
    <form action="<@ofbizUrl>createProductCategory</@ofbizUrl>" method="post" style="margin: 0;"
          name="productCategoryForm">
    <table cellspacing="0" class="basic-table">
        <tr>
            <td class="label">${uiLabelMap.ProductProductCategoryId}</td>
            <td>&nbsp;</td>
            <td>
                <input type="text" name="productCategoryId" size="20" maxlength="40" value="${productCategoryId}"/>
            </td>
        </tr>
    <#else>
        <div class="screenlet-title-bar">
            <ul>
                <li class="h3">${uiLabelMap.PageTitleCreateProductCategory}</li>
            </ul>
            <br class="clear"/>
        </div>
    <div class="screenlet-body">
    <form action="<@ofbizUrl>createProductCategory</@ofbizUrl>" style="margin: 0;" name="productCategoryForm">
    <table cellspacing="0" class="basic-table">
        <tr>
            <td class="label">${uiLabelMap.ProductProductCategoryId}</td>
            <td>&nbsp;</td>
            <td>
                <input type="text" name="productCategoryId" size="20" maxlength="40" value=""/>
            </td>
        </tr>
    </#if>
<#else>
    <div class="screenlet-title-bar">
        <h3>${uiLabelMap.PageTitleEditProductCategories}</h3>
    </div>
<div class="screenlet-body">
<form action="<@ofbizUrl>mng_UpdateProductCategory</@ofbizUrl>" method="post" style="margin: 0;"
      name="productCategoryForm">
    <input type="hidden" name="productCategoryId" value="${productCategoryId}"/>
<table cellspacing="0" class="basic-table">
</#if>
    <input type="hidden" name="productCategoryTypeId" value="CATALOG_CATEGORY"/>
    <input type="hidden" name="upload_file_type_bogus" value="CATALOG_CATEGORY"/>
    <tr>
        <td class="label">${uiLabelMap.ProductProductCategoryName}</td>
        <td>&nbsp;</td>
        <td><input type="text" value="${(productCategory.categoryName)?if_exists}" name="categoryName" size="60"
                   maxlength="60"/></td>
    </tr>
    <tr>
        <td class="label">${uiLabelMap.ProductProductCategoryDescription}</td>
        <td>&nbsp;</td>
        <td><textarea name="description" cols="60"
                      rows="2"><#if productCategory?has_content>${(productCategory.description)?if_exists}</#if></textarea>
        </td>
    </tr>
    <tr>
        <td class="label">在首页显示</td>
        <td>&nbsp;</td>
        <td>
            <select name="showInHome">
                <option value="">&nbsp;</option>
                <option value="Y" <#if (productCategory.showInHome)?if_exists == 'Y'> selected="selected"</#if>>${uiLabelMap.CommonYes}</option>
                <option value="N" <#if (productCategory.showInHome)?if_exists == 'N'> selected="selected"</#if>>${uiLabelMap.CommonNo}</option>
            </select>
        </td>
    </tr>
    <tr>
        <td width="20%" valign="top" class="label">
        ${uiLabelMap.ProductCategoryImageUrl}
        </td>
        <td>&nbsp;</td>
        <td width="80%" colspan="4" valign="top">
            <input type="text" name="categoryImageUrl" value="${(productCategory.categoryImageUrl)?default('')}"
                   size="60" maxlength="255"/>
        <#if (productCategory.categoryImageUrl)?exists>
            <br>
            <a href="<@ofbizContentUrl>${(productCategory.categoryImageUrl)?if_exists}</@ofbizContentUrl>"
               target="_blank"><img alt="Category Image" width="200px" height="200px"
                                    src="<@ofbizContentUrl>${(productCategory.categoryImageUrl)?if_exists}</@ofbizContentUrl>"
                                    class="cssImgSmall"/></a>
        </#if>
        <#if productCategory?has_content>
            <div>
            ${uiLabelMap.ProductInsertDefaultImageUrl}:
                <a href="javascript:insertImageName('category','${imageNameCategory}.jpg');" class="buttontext">.jpg</a>
                <a href="javascript:insertImageName('category','${imageNameCategory}.gif');" class="buttontext">.gif</a>
                <a href="javascript:insertImageName('category','');" class="buttontext">${uiLabelMap.CommonClear}</a>
            </div>
        </#if>
        </td>
    </tr>
    <tr>
        <td class="label">${uiLabelMap.ProductPrimaryParentCategory}</td>
        <td>&nbsp;</td>
        <td>
        <@htmlTemplate.lookupField value="${(productCategory.primaryParentCategoryId)?default('')}" formName="productCategoryForm" name="primaryParentCategoryId" id="primaryParentCategoryId" fieldFormName="LookupProductCategory"/>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
        <td><input type="submit" name="Update" value="${uiLabelMap.CommonUpdate}"/></td>
    </tr>
</table>
</form>
</div>
</div>
<#if productCategoryId?has_content>
    <div class="screenlet">
        <div class="screenlet-title-bar">
            <h3>${uiLabelMap.ProductCategoryUploadImage}</h3>
        </div>
        <div class="screenlet-body">
            <form method="post" enctype="multipart/form-data"
                  action="<@ofbizUrl>mng_UploadCategoryImage?productCategoryId=${productCategoryId?if_exists}&amp;upload_file_type=category</@ofbizUrl>"
                  name="imageUploadForm">
                <input type="file" size="50" name="fname" style="float:left"/>
                <input type="submit" class="smallSubmit" value="${uiLabelMap.ProductUploadImage}" style="float:left"/>

            </form>
        </div>
    </div>
</#if>
