<div class="screenlet">
    <form method="post" action="<@ofbizUrl>user_refunds</@ofbizUrl>" id="EditRefunds" name="EditRefunds">
        <div class="screenlet-title-bar">
            <h3>${uiLabelMap.PortalUserRefundsApplication}</h3>
        </div>
        <div class="screenlet-body">
            <table class="basic-table">
                <tbody>
                <tr>
                    <td class="label">${uiLabelMap.PortalUserOrderNumber}：</td>
                    <td>
                        <input id="js-shopName" name="storeName" value="" type="text" size="60">
                    </td>
                </tr>
                <tr>
                    <td class="label">${uiLabelMap.PortalUserRefundsReasons}：</td>
                    <td>
                        <textarea type="text" name="subtitle" id="subtitle" rows="2" cols="60"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <input value="${uiLabelMap.PortalUserRefundsSubmit}" class="btn btn-info" type="submit">
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div>
<script type="text/javascript">

</script>
