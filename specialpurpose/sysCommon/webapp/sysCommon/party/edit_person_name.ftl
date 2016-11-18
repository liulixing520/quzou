<div class="pageContent" id="pageContent">
    <div id="EditPersonName" class="screenlet-body" layoutH="138">
        <form action="<@ofbizUrl>updatePersonName</@ofbizUrl>" method="post" id="editPersonName"  class="single_table">
            <div class="editDiv">
                <input type="hidden" name="partyId" value="${partyId!}" />
                <table width="100%" border="0" cellpadding="1" class='ext_table'>
                    <tbody>
                    <tr>
                        <td width="110px" class="textColumn">  姓名：</td>
                        <td>
                            <input type="text" value="${personName!}" class="editDiv_table_td_input required" style="width:60px;" id="personName" name="personName">
                        </td>
                    </tr>
                </tbody>
                </table>
            </div>          
        </form>
    </div>     
</div>