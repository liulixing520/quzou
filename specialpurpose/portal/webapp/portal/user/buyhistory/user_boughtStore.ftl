
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
                最近购买过的店铺
            </h1>
        </div>
        <div class="row">
            <div class="col-xs-12">

                <form class="form-horizontal" role="form" method="post" action="<@ofbizUrl>brandmanage</@ofbizUrl>">
                    <div class="col-xs-12 col-sm-6">
                        <label class="col-sm-2 control-label no-padding-right">店铺名称 </label>

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
                            <tr role="row" >
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="2"
                                    aria-label="">
                                   店铺信息
                                </th>
                                <th class="" tabindex="0" aria-controls="sample-table-2" rowspan="1" colspan="1"
                                    aria-label="">
                                    宝贝信息
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    收藏人气
                                </th>
                                <th class="hidden-480" tabindex="0" aria-controls="sample-table-2" rowspan="1"
                                    colspan="1" aria-label="">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>

                            <tr class="odd">
                                <td><img src="" alt="图片" title="图片"/></td>
                                <td>xxxxx旗舰店</td>
                                <td>购买过的(2) 新上宝贝(1)</td>
                                <td>6814</td>
                                 <td rowspan="">
                                 <div class="hidden-sm hidden-xs action-buttons"> 
                                 <a>加入收藏</a><br>
                                 <a>删除</a> 
                                 </div>
        					 	</td>
                            </tr>
                            <tr class="odd">
                                <td><img src="" alt="图片" title="图片"/></td>
                                <td>xxxxx旗舰店</td>
                                <td>购买过的(2) 新上宝贝(1)</td>
                                <td>6814</td>
                                 <td rowspan="">
                                 <div class="hidden-sm hidden-xs action-buttons"> 
                                 <a>加入收藏</a><br>
                                 <a>删除</a> 
                                 </div>
        					 	</td>
                            </tr>
                            <tr class="odd">
                                <td><img src="" alt="图片" title="图片"/></td>
                                <td>xxxxx旗舰店</td>
                                <td>购买过的(2) 新上宝贝(1)</td>
                                <td>6814</td>
                                 <td rowspan="">
                                 <div class="hidden-sm hidden-xs action-buttons"> 
                                 <a>加入收藏</a><br>
                                 <a>删除</a> 
                                 </div>
        					 	</td>
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