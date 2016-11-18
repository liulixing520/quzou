<div class="screenlet">
    <form action="<@ofbizUrl>user_refundsList</@ofbizUrl>" id="findRefundsList" method="post">
        <div class="screenlet-body">
            <table class="basic-table">
                <tr>
                    <td>
                        ${uiLabelMap.PortalUserOrderNumber}：
                    </td>
                    <td>
                        <input type="text" name="productName" value=''/>
                    </td>
                    <td>
                        <input class="btn btn-info" type="submit" value="查询">
                    </td>
                </tr>
            </table>
    </form>
</div>
<br/>
<div class="listheight" style="height:75%; width:100%; overflow-y: auto;">
    <table class="table-bordered" cellspacing="0" width="100%">
        <thead>
        <tr class='header-row-2'>
            <td width="50px"><input type="checkBox" class="checkboxCtrl" group="orderIndexs"></td>
            <td style="text-align:center;width:350px">${uiLabelMap.PortalUserOrderNumber}</td>
            <td style="text-align:center;">退款金额</td>
            <td style="text-align:center;">申请时间</td>
            <td style="text-align:center;">退款原因</td>
            <td style="text-align:center;">当前状态</td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><input type="checkbox" value="" name="orderIndexs"></td>
            <td style="text-align:center;">
                <a href=""></a>
            </td>
            <td style="text-align:center;"></td>
            <td style="text-align:center;"></td>
            <td></td>
            <td></td>
        </tr>
        </tbody>
    </table>
</div>

<#include "component://portal/webapp/portal/includes/productpagination.ftl"/>
<#--<@paginationSimple  listSize viewSize viewIndex  'user_findRefundsList' 'user_findRefundsList' parameters.sortField!/>-->

<script language="javascript">
</script>