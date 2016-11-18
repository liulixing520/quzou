<#assign actionUrlStr="createProductStore">
<#if productStore?has_content>
    <#assign actionUrlStr="updateProductStore">
</#if>

<div class="main-wrap">
<div id="node-contacts" class="node">
                    <div class="node-inner">
                        <div class="box block clear-block">
                            <div class="hd"><h3>${uiLabelMap.sellerCommodity}</h3></div>
                            <div class="bd">
                                <table cellspacing="0" cellpadding="0" border="0" class="tablefixed">
                                    <tbody>
                                    <tr>
                                        <th width="10%"></th>
                                        <td>
                                            <div class="c-info">
                                                <div class="c-info-r">
                                                   <table class="basic-table">
										                <tbody>
										                <tr>
										                    <td class="label">${uiLabelMap.sellerstorename}：</td>
										                    <td>${(productStore.storeName)!}</td>
										                </tr>
										                <tr>
										                    <td class="label">${uiLabelMap.sellermainbusiness}：</td>
										                    <td>${(productStore.subtitle)!}</td>
										                </tr>
										                <tr>
										                    <td class="label">${uiLabelMap.sellerofbusiness}：</td>
										                    <td> ${(productStore.businessType)!}
										                    </td>
										                </tr>
										            </table>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    
                                    
                 <#if contactMeches?has_content>
                <#list contactMeches as contactMechMap>
                    <#assign contactMech = contactMechMap.contactMech>
                    <#list contactMechMap.partyContactMechPurposes as partyContactMechPurpose>
                        <#assign contactMechPurposeType = partyContactMechPurpose.getRelatedOne("ContactMechPurposeType", true)>
                    </#list>
                    <#if "POSTAL_ADDRESS" = contactMech.contactMechTypeId && "Purchase Return Address" = contactMechPurposeType.get("description")>
                        <#if contactMechMap.postalAddress?has_content>
                          <#assign postalAddress = contactMechMap.postalAddress>
                           <tr class="divide-line">
                                        <th></th>
                                        <td></td>
                           </tr>
                                 ${setContextField("postalAddress", postalAddress)}
                                 <#--${screens.render("component://party/widget/partymgr/PartyScreens.xml#postalAddressHtmlFormatter")}-->
                                  ${screens.render("component://portal/widget/SellerHomeScreens.xml#returnaddress")}
                                </#if>
                    </#if>
                </#list>
            </#if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
 
</div>

<script type="text/javascript">
    $(function () {
        $(".breadcrumb").append(
                "<li class='active'>商铺管理</li><li class='active'>商铺信息</li>")
    });
    $('.date-picker').datepicker({
        autoclose: true,
        todayHighlight: true
    })
</script>
