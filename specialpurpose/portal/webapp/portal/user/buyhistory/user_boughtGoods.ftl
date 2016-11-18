
<script type="text/javascript">
function submitFormDisableSubmits(form) {
    for (var i=0;i<form.length;i++) {
        var formel = form.elements[i];
        if (formel.type == "submit") {
            submitFormDisableButton(formel);
            var formName = form.name;
            var formelName = formel.name;
            var timeoutString = "submitFormEnableButtonByName('" + formName + "', '" + formelName + "')";
            var t = setTimeout(timeoutString, 1500);
        }
    }
}
</script>
<div class="page-content">
    <div class="page-content-area">
        <div class="page-header">
            <h1>
                最近购买过的物品
            </h1>
        </div>
        <div class="row">
            <div class="col-xs-12">

                <form class="form-horizontal" role="form" method="post" action="<@ofbizUrl>brandmanage</@ofbizUrl>">
                    <div class="col-xs-12 col-sm-6">
                        <label class="col-sm-2 control-label no-padding-right">商品名称</label>

                        <div class="input-group">
                        <input class="form-control search-query" type="text" placeholder="">
                             <span class="input-group-btn">
								<button class="btn btn-purple btn-sm" type="button">
									搜索
									<i class="ace-icon fa fa-search icon-on-right bigger-110"></i>
								</button>
							</span>
                        </div>
                    </div>

                </form>


                <!-- <div class="table-responsive"> -->
                <!-- <div class="dataTables_borderWrap"> -->
                <div class="col-xs-12">
                <h3 class="header smaller lighter blue">
                </h3>
                    <div id="sample-table-2_wrapper" class="dataTables_wrapper form-inline no-footer">
                        <table id="sample-table-2"
                               class="table-bordered"
                               role="grid" aria-describedby="sample-table-2_info">
                            <thead>
                            <tr role="row">
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="">
                                   商品
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="">
                                    单价(元)
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    数量
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    商品操作
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
          实付款
                                </th>
                                <th class="hidden-480" rowspan="1" colspan="1" aria-label="">
                                    交易状态
                                </th>
                                                                <th class="hidden-480" rowspan="1" colspan="1" aria-label="">
                                    交易操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr class="odd">
                            <td colspan="7">
                            <input type="checkbox" />&nbsp;全选&nbsp;&nbsp;
                            <a href="">删除</a>
                            </td>
                            </tr>
                            <tr class="odd">
                            <td colspan="7">
                            <input type="checkbox" />&nbsp;&nbsp;
                            <span>2014-11-11</span> &nbsp;&nbsp;
                            <span>订单号:857613774419920</span>&nbsp;&nbsp;
                            <span>卖家名称</span>
                            
                            </td>
                            
                            
                            </tr>

                            <tr class="odd">
                                <td>zzz</td>
                                <td>4.80</td>
                                <td>1</td>
                                <td>退款/退货<br/>投诉卖家</td>
                                <td rowspan="3">14.40</td>
                                 <td rowspan="3">订单详情<br/>查看物流</td>
                                 <td rowspan="3">
                                 <div class="hidden-sm hidden-xs action-buttons"> 
                                 <a class="blue" href="#"> <i class="ace-icon fa fa-search-plus bigger-130"></i> </a> 
                                 <a class="red" href=""> <i class="ace-icon fa fa-trash-o bigger-130"></i> </a> 
                                 </div>
        					 	</td>
                            </tr>
                             <tr class="odd">
                                <td>zzz</td>
                                <td>4.80</td>
                                <td>1</td>
                                <td>退款/退货<br/>投诉卖家</td>
                            </tr>
                            <tr class="odd">
                                <td>zzz</td>
                                <td>4.80</td>
                                <td>1</td>
                                <td>退款/退货<br/>投诉卖家</td>
                            </tr>
                            <tr class="even">
                            <td colspan="7">
                            <input type="checkbox" />&nbsp;&nbsp;
                            <span>2014-11-11</span> &nbsp;&nbsp;
                            <span>订单号:857613774419920</span>&nbsp;&nbsp;
                            <span>卖家名称</span>
                            
                            </td>
                            
                            
                            </tr>

                            <tr class="odd">
                                <td>zzz</td>
                                <td>4.80</td>
                                <td>1</td>
                                <td>退款/退货<br/>投诉卖家</td>
                                <td rowspan="3">14.40</td>
                                 <td rowspan="3">订单详情<br/>查看物流</td>
                                 <td rowspan="3">
                                 <div class="hidden-sm hidden-xs action-buttons"> 
                                 <a class="blue" href="#"> <i class="ace-icon fa fa-search-plus bigger-130"></i> </a> 
                                 <a class="red" href=""> <i class="ace-icon fa fa-trash-o bigger-130"></i> </a> 
                                 </div>
        					 	</td>
                            </tr>
                             <tr class="odd">
                                <td>zzz</td>
                                <td>4.80</td>
                                <td>1</td>
                                <td>退款/退货<br/>投诉卖家</td>
                            </tr>
                            <tr class="odd">
                                <td>zzz</td>
                                <td>4.80</td>
                                <td>1</td>
                                <td>退款/退货<br/>投诉卖家</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                
            </div>
        </div>
    </div>
    <!-- /.page-content-area -->
</div>