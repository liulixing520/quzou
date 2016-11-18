<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
<link rel="stylesheet" type="text/css" media="all" href="/images/jquery/plugins/jsTree/themes/default/style.css">
<script src="/images/jquery/plugins/jsTree/jquery.jstree.js" type="text/javascript"></script>
<script src="/portal/images/js/jquery/jquery.cookie.js" type="text/javascript"></script>
<script type="text/javascript">
<#-- some labels are not unescaped in the JSON object so we have to do this manualy -->
function unescapeHtmlText(text) {
    return jQuery('<div />').html(text).text()
}
jQuery(window).load(createTree());

<#-- creating the JSON Data -->
var rawdata = [
        <#if (completedTree?has_content)>
            <@fillTree rootCat = completedTree/>
        </#if>
        
        <#macro fillTree rootCat>
            <#if (rootCat?has_content)>
                <#list rootCat as root>
                    {
                    "data": {"title" : unescapeHtmlText("<#if root.categoryName?exists>${root.categoryName?js_string} [${root.productCategoryId}]<#else>${root.productCategoryId?js_string}</#if>"), "attr": {"onClick" : "window.location.href='#<#--<@ofbizUrl>/EditProdCatalog?prodCatalogId=${root.productCategoryId}</@ofbizUrl>-->'; return false;"}},
                    "attr": {"id" : "${root.productCategoryId}", "rel" : "root", "isCatalog" : "${root.isCatalog?string}" ,"isCategoryType" : "${root.isCategoryType?string}"}
                    <#if root.child?exists>
                    ,"state" : "closed"
                    </#if>
                    <#if root_has_next>
                        },
                    <#else>
                        }
                    </#if>
                </#list>
            </#if>
        </#macro>
     ];

 <#-- create Tree-->
  function createTree() {
    jQuery(function () {
        <#if stillInCatalogManager>
            $.cookie('jstree_select', null);
            $.cookie('jstree_open', null);
        <#else>
            $.cookie('jstree_select', "<#if productCategoryId?exists>${productCategoryId}<#elseif showProductCategoryId?exists>${showProductCategoryId}</#if>");
        </#if>
        jQuery("#tree").bind("loaded.jstree", function (e, data) {
                    data.inst.open_all(-1); // -1 打开所有节点
                }).jstree({
        "plugins" : [ "themes", "json_data","ui" ,"contextmenu", "types"],
            "json_data" : {
                "data" : rawdata,
                          "ajax" : { "url" : "<@ofbizUrl>getChild</@ofbizUrl>", "type" : "POST",
                          "data" : function (n) {
                            return { 
                                "isCategoryType" :  n.attr ? n.attr("isCatalog").replace("node_","") : 1 ,
                                "isCatalog" :  n.attr ? n.attr("isCatalog").replace("node_","") : 1 ,
                                "productCategoryId" : n.attr ? n.attr("id").replace("node_","") : 1
                        }; 
                    }
                }
            },
            'contextmenu': {
                'items': {
                    'ccp' : false,
                    'create' : false,
                    'rename' : false,
                    'remove' : false,
                    /*
                    'create1' : {
                        'label' : "新增",
                        'action' : function(obj) {
                            if(obj.attr("isCatalog")=="false"){callCreateDocument(obj.attr('id'),"category");}
                            else{callCreateDocument(obj.attr('id'),"catalog");}
                        }
                    },
                    'create2' : {
                        'label' : "编辑",
                        'action' : function(obj) {
                        	if(obj.attr("isCatalog")=="false"){callEditDocument(obj.attr('id'));}
                        }
                    },
                    */
                    'create3' : {
                        'label' : "设置属性",
                        'action' : function(obj) {
                           //window.location.href="setCategoryAttribute?productCategoryId="+obj.attr('id');
                           window.location.href="setCategoryRefTypeAttribute?productCategoryId="+obj.attr('id');
                        }
                    },
                    'create4' : {
                        'label' : "设置规格",
                        'action' : function(obj) {
                           window.location.href="setCategoryFeature?productCategoryId="+obj.attr('id');
                        }
                    },
                }
            },
            "types" : {
            "valid_children" : [ "root" ],
            "types" : {
                 "CATEGORY" : {
                     "icon" : { 
                         "image" : "/images/jquery/plugins/jsTree/themes/apple/d.png",
                         "position" : "10px40px"
                     }
                 }
             }
         }
        });
    });
  }
  <#-------------------------------------------------------------------------------------define Requests-->
  	var editCategoryUrl = '<@ofbizUrl>/EditCategory</@ofbizUrl>';
  	var newCategoryUrl = '<@ofbizUrl>/EditCategory</@ofbizUrl>';
  	var strs="";
  <#-------------------------------------------------------------------------------------callDeleteItem function-->
    function callCreateDocument(parentProductCategoryId,type) {
        if(type == "catalog"){
           datestr = {prodCatalogId : parentProductCategoryId};
           strs+="prodCatalogId="+parentProductCategoryId;
        }
        else if(type == "category"){
           datestr = {parentProductCategoryId : parentProductCategoryId};
            strs+="parentProductCategoryId="+parentProductCategoryId;
        }
        window.location.href=newCategoryUrl+"?"+strs;
        /*
        jQuery.ajax({
            url: newCategoryUrl,
            type: 'POST',
            data: datestr,
            error: function(msg) {
                showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
            },
            success: function(msg) {
                jQuery('#miniproductlist').html(msg);
            }
        });
        */
    }
    <#-------------------------------------------------------------------------------------callEditItem function-->
    function callEditDocument(productCategoryId) {
    	/*
        jQuery.ajax({
            url: editCategoryUrl,
            type: 'POST',
            data: {productCategoryId : productCategoryId},
            error: function(msg) {
                showErrorAlert("${uiLabelMap.CommonErrorMessage2}","${uiLabelMap.ErrorLoadingContent} : " + msg);
            },
            success: function(msg) {
                jQuery('#miniproductlist').html(msg);

            }
        });
        */
        window.location.href=editCategoryUrl+"?productCategoryId="+productCategoryId;
    }
</script>
<div class="screenlet">
	<div class="screenlet-title-bar">
        <h3>分类树</h3>
    </div>
	<div id="tree"></div>
</div>
<div id="miniproductlist"></div>