<script type="text/javascript">
    $(function () {
        $(".breadcrumb").append("<li class='active'>安全设置</li><li class='active'>邮箱修改</li>")
    });
</script>

<#assign actionUrlStr="seller_userupdatePartyEmailAddress">
<div class="screenlet">
<#--    <div class="screenlet-title-bar">
        <ul>
            <li class="h3">邮箱修改</li>
        </ul>
        <br class="clear">
    </div>-->
    <div id="screenlet_1_col" class="screenlet-body">

    <#list contactMeches as contactMechMap>
        <#assign contactMech = contactMechMap.contactMech>
        <div>
            <#if "EMAIL_ADDRESS" = contactMech.contactMechTypeId>
                <form method="post" action="<@ofbizUrl>${actionUrlStr}</@ofbizUrl>" name="editcontactmechform"
                      id="editcontactmechform" class="basic-form"
                      onsubmit="javascript:submitFormDisableSubmits(this)">
                    <input type="hidden" name="userLoginId" id="updateAddress_userLoginId">
                    <input type="hidden" name="contactMechPurposeTypeId" id="contactMechPurposeTypeId"
                           value="SHIPPING_LOCATION">
                    <#if userLogin.partyId?has_content>
                        <input name="partyIdFrom" value="${userLogin.partyId}" type="hidden"/>
                    </#if>
                    <input name="partyId" value="${partyId}" type="hidden"/>
                    <input name="contactMechId" value="${contactMech.contactMechId}" type="hidden"/>
                    <input name="contactMechTypeId" value="${contactMech.contactMechTypeId}" type="hidden"/>
                    <input name="my" value="My" type="hidden"/>
                    <input name="statusId" value="COM_PENDING" type="hidden"/>
                    <input name="communicationEventTypeId" value="EMAIL_COMMUNICATION" type="hidden"/>

                    <table cellspacing="0" class="basic-table">
                        <tbody>
                        <tr>
                            <td class="label">收件人</td>
                            <td>
                                <input type="text" size="60" maxlength="255" name="emailAddress"
                                       value="${contactMech.infoString?if_exists}"/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="button-bar">
                        <a href="javascript:document.editcontactmechform.submit()" class="smallSubmit">保存</a>
                    </div>
                </form>
            </#if>
        </div>
    </#list>
    </div>
</div>
 