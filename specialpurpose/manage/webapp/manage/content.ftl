<div class="page-content">
    <div class="page-content-area">
        <div class="row">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-sm-5">
                        <div class="widget-box transparent">
                            <div class="widget-header widget-header-flat">
                                <h4 class="widget-title lighter">
                                    <i class="ace-icon fa fa-star orange"></i>
                                    需要关注
                                </h4>
                            </div>

                            <div class="widget-body">
                                <div class="widget-main no-padding">
                                    <table class="table table-bordered table-striped">
                                        <thead class="thin-border-bottom">
                                        <tr>
                                            <th>
                                                <i class="ace-icon fa fa-caret-right blue"></i>类型
                                            </th>
                                            <th>
                                                <i class="ace-icon fa fa-caret-right blue"></i>数量
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                     <tr>
                        <td>今日新订单</td>
                        <td>
                            <a href="<@ofbizUrl>mng_ShowOrder</@ofbizUrl>"><b class="green">${orderList1}</b></a>
                        </td>
                    </tr>
                    <tr>
                        <td>待付款</td>
                        <td>
                        	<a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_CREATED</@ofbizUrl>"><b class="green">${orderList3}</b></a>
                           
                        </td>
                    </tr>
                    <tr>
                        <td>待发货</td>
                        <td>
                        	<a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_APPROVED</@ofbizUrl>"><b class="green">${orderList2}</b></a>
                           
                        </td>
                    </tr>
                    <tr>
                        <td>在路上</td>
                        <td>
                        	<a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_SENT</@ofbizUrl>"><b class="green">${orderList5}</b></a>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>已完成</td>
                        <td>
                        	<a href="<@ofbizUrl>mng_ShowOrder?orderStatusId=ORDER_COMPLETED</@ofbizUrl>"><b class="green">${orderList4}</b></a>
                           
                        </td>
                    </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.widget-main -->
                            </div>
                            <!-- /.widget-body -->
                        </div>
                        <!-- /.widget-box -->
                    </div>
                    <!-- /.col -->

                    <div class="col-sm-7">
                        <div class="widget-box transparent" id="recent-box">
                            <div class="widget-header">
                                <h4 class="widget-title lighter smaller">
                                    <i class="ace-icon fa fa-rss orange"></i>新闻
                                </h4>

                                <div class="widget-toolbar no-border">
                                    <ul class="nav nav-tabs" id="recent-tab">
                                        <li class="active">
                                            <a data-toggle="tab" href="#task-tab">最新公告</a>
                                        </li>

                                        <li>
                                            <a data-toggle="tab" href="#member-tab">热门问题</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="widget-body">
                                <div class="widget-main padding-4">
                                    <div class="tab-content padding-8">
                                        <div id="task-tab" class="tab-pane active">
                                           <#assign tempindex = 1>
                                            <#if messageList?has_content>
                                                 <ul id="tasks" class="item-list">
                                                 <#list messageList as messageList>
                                                   <#if tempindex <= 5>
	                                                   <li class="item-default clearfix">
	                                                       <label class="inline">
	                                                        <a href="<@ofbizUrl>manage_findMessageByOne</@ofbizUrl>?messageId=${messageList.messageId}"><span class="lbl">${messageList.messageTitle}</span></a>
	                                                       </label>	
	                                                   </li>
                                                   </#if>
                                                   <#assign tempindex = tempindex + 1/>
                                                 </#list>
                                                 </ul>
                                            </#if>
                                            <div class="space-4"></div>
                                            <div class="center">
                                                <a href="<@ofbizUrl>manage_findMessageByAll</@ofbizUrl>" class="btn btn-sm btn-white btn-info">
                                                    更多 &nbsp;
                                                    <i class="ace-icon fa fa-arrow-right"></i>
                                                </a>
                                            </div>
                                            <div class="hr hr8"></div>
                                        </div>
                                        <div id="member-tab" class="tab-pane">
                                            <div class="clearfix">
                                                <div class="itemdiv memberdiv">
                                                    <div class="user">
                                                        <img alt="Phil Doe's avatar" src=""/>
                                                    </div>
                                                    <div class="body">
                                                        <div class="name">
                                                            <a href="#">Phil Doe</a>
                                                        </div>
                                                        <div class="time">
                                                            <i class="ace-icon fa fa-clock-o"></i>
                                                            <span class="green">2 days ago</span>
                                                        </div>
                                                        <div>
                                                            <span class="label label-info label-sm arrowed-in arrowed-in-right">online</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="itemdiv memberdiv">
                                                    <div class="user">
                                                        <img alt="Phil Doe's avatar" src=""/>
                                                    </div>

                                                    <div class="body">
                                                        <div class="name">
                                                            <a href="#">Phil Doe</a>
                                                        </div>
                                                        <div class="time">
                                                            <i class="ace-icon fa fa-clock-o"></i>
                                                            <span class="green">2 days ago</span>
                                                        </div>

                                                        <div>
                                                            <span class="label label-info label-sm arrowed-in arrowed-in-right">online</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="itemdiv memberdiv">
                                                    <div class="user">
                                                        <img alt="Alexa Doe's avatar" src=""/>
                                                    </div>

                                                    <div class="body">
                                                        <div class="name">
                                                            <a href="#">Alexa Doe</a>
                                                        </div>

                                                        <div class="time">
                                                            <i class="ace-icon fa fa-clock-o"></i>
                                                            <span class="green">3 days ago</span>
                                                        </div>

                                                        <div>
                                                            <span class="label label-success label-sm arrowed-in">approved</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="space-4"></div>
                                            <div class="center">
                                                <a href="#" class="btn btn-sm btn-white btn-info">
                                                    更多 &nbsp;
                                                    <i class="ace-icon fa fa-arrow-right"></i>
                                                </a>
                                            </div>
                                            <div class="hr hr8"></div>
                                        </div>
                                        <!-- /.#member-tab -->
                                    </div>
                                </div>
                                <!-- /.widget-main -->
                            </div>
                            <!-- /.widget-body -->
                        </div>
                        <!-- /.widget-box -->
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.page-content-area -->
</div><!-- /.page-content -->
