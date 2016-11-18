
<!DOCTYPE html>
<html class="">
	  <head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	  <meta http-equiv="X-UA-Compatible" content="IE=edge">
	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
	  <title>医学参考</title>
	  <meta name="keywords" content="小组">
	  <meta name="description" content="小组首页">
	  <meta content="dd9d995cecf4c56439bc46046274f51756b00f83" name="csrf-token">
  
  	<script language="javascript" src="/images/jquery/jquery-1.7.min.js" type="text/javascript"></script>
    <script language="javascript" src="/sysCommon/images/jquery.jqGrid-4.4.3/js/jquery.jqGrid.src.js" type="text/javascript"></script>
	<script language="javascript" src="/sysCommon/images/jquery.jqGrid-4.4.3/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
	<script language="javascript" src="/sysCommon/images/bootstrap/bootstrap.js" type="text/javascript"></script>
	<script language="javascript" src="/sysCommon/images/bootstrap/bootstrap-modal-hack2.js" type="text/javascript"></script>
  
    <link href="/sysCommon/images/bootstrap/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/common.css">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/bootstrap-extends.css">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/web.css">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/web-osf.css">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/style.css">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/osf.css">
    <link rel="stylesheet" href="/sysCommon/images/bootstrap/jquery-ui-1.8.21.custom.css" type="text/css"/>
    <link rel="stylesheet" href="/sysCommon/images/jquery.jqGrid-4.4.3/css/ui.jqgrid.css" type="text/css"/>
    <link rel="stylesheet" href="/sysCommon/images/bootstrap/jqGrid.overrides.css" type="text/css"/>
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/member.css">
    <link charset="utf-8" rel="stylesheet" href="/sysCommon/images/bootstrap/dialog.css">
    
    
	
    <!--[if lt IE 8]>
      <link href="/sysCommon/images/bootstrap/oldie.css" rel="stylesheet">
    <![endif]-->
  
  <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/group.css">
  <!--[if lt IE 9]>
    <script src="/sysCommon/images/bootstrap/html5shiv.js"></script>
  <![endif]-->

  <!--[if IE 8]>
    <script src="/sysCommon/images/bootstrap/respond.min.js"></script>
  <![endif]-->
  

</head>




<body >


  

  <nav class="navbar navbar-inverse site-navbar " role="navigation" id="site-navbar"  data-counter-url="/user_remind_counter">
      <div class="container"> 
        <div class="row">
          <div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
                <div class="navbar-header ptm">
                                        <a class="navbar-brand-logo" href="/"><img  class="img-responsive" src="/files/system/logo_1412733008.png?osf_v3.7.5"></a>
                                  </div>
          </div>
          
          <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
               <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
               </button>
          </div>

          <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9 ">      

                <div class="navbar-right navbar-collapse collapse">

                  <ul class="nav navbar-nav">
		      		  <li class="">
        <a href="/" class=""  >首页 </a>
              </li>
				      		  <li class="">
        <a href="/page/agenda" class=""  >近期课表 </a>
              </li>
				  		      		  <li class="">
        <a href="/openclass/explore" class=""  >公开课 </a>
              </li>
				  		      		  <li class="dropdown ">
        <a href="javascript:;" class="dropdown-toggle " target="_blank"  data-toggle="dropdown">学课程 <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                          <li><a href="/course/explore?sort=recommendedSeq"  target="_blank">全部课程</a></li>
                          <li><a href="/tag/%E4%BB%8A%E6%97%A5%E9%99%90%E5%85%8D"  target="_blank">今日限免</a></li>
                          <li><a href="/page/bigdatavvip"  target="_blank">大数据系列课程VIP</a></li>
                          <li><a href="/page/couldcomputing"  target="_blank">云计算系列课程VIP</a></li>
                          <li><a href="/page/intvvip"  target="_blank">移动互联网（android）系列课程VIP</a></li>
                      </ul>
              </li>
				  		  		  		      		  <li class="">
        <a href="/page/nite" class=""  >认证 </a>
              </li>
				  		  		      		  <li class="">
        <a href="/teacher" class=""  >讲师 </a>
              </li>
				      		  <li class="">
        <a href="/group" class=""  >小组 </a>
              </li>
				  	</ul>

                  <ul class="nav navbar-nav navbar-right">
                    <li><a href="/search"><span class="glyphicon glyphicon-search"></span> </a></li>
                                         
                      <li><a href="/notification" class="badge-container notification-badge-container">
                        <span class="glyphicon glyphicon-bullhorn hidden-lt-ie8"></span>
                        <span class="visible-lt-ie8">通知</span>
                        </a></li>
                      <li>
                        <a href="/message/" class="badge-container message-badge-container">
                        <span class="glyphicon glyphicon-envelope hidden-lt-ie8"></span>
                        <span class="visible-lt-ie8">私信</span>
                                                </a>
                        </li>
                      <li class="visible-lt-ie8"><a href="/settings/">云岗</a></li>
                      <li class="dropdown hidden-lt-ie8">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">云岗 <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                          <li><a href="/my"> <i class="glyphicon glyphicon-book"></i> 我的课堂 </a></li>
                          <li><a href="/user/19505"><i class="glyphicon glyphicon-home"></i> 我的主页</a></li>
                          <li><a href="/settings/"><i class="glyphicon glyphicon-cog"></i> 帐号设置</a></li>
                          <li class="divider"></li>
                          <li><a href="/mysale"><i class="glyphicon glyphicon-leaf"></i> 推广佣金</a></li>
                          <li class="divider"></li>
                                                        <li><a href="/logout"><i class="glyphicon glyphicon-off"></i> 退出</a></li>
                        </ul>
                        </li>
                                      </ul>

                </div> 
          </div>
        </div>
      </div>     
  </nav> 

  <!--div class="slide-osf"></div-->
 
  <!-- container -->
  <div id="content-container" class="container ptz">
            


<div class="row row-3-9">
  <div class="col-md-3">

    <div class="panel panel-default">
      <div class="panel-body">
        <div class="list-group-block">

          
          <div class="list-group-panel">
            <div class="list-group-heading">我的学习</div>
            <ul class="list-group">
               <a class="list-group-item
               " 
               href="/my/courses/learning">我的课程</a>
                              <a class="list-group-item
                active " 
               href="/my/livecourses/learing">我的直播课表</a>
                              <a class="list-group-item
               " 
              href="/my/questions">我的问答</a>
               <a class="list-group-item
               " 
              href="/my/discussions">我的话题</a>
               <a class="list-group-item
               " 
                href="/my/notebooks">我的笔记</a>
               <a class="list-group-item
               " 
                href="/my/quiz">我的考试</a>
               <a class="list-group-item
               " 
               href="/my/group">我的小组</a>
            </ul>
          </div>

          <div class="list-group-panel">
            <div class="list-group-heading">订单</div>
            <ul class="list-group">
              <a class="list-group-item 
                " 
               href="/my/orders">我的订单</a>
            </ul>
          </div>
          
        </div>
      </div>
    </div>

  </div>
  <div class="col-md-9">
  <div class="panel panel-default panel-col">
      <div class="panel-heading">我的直播课表</span></div>
      <div class="panel-body">
      	<div class="row-fluid sortable">	
			<div class="box span12">
				<div class="box-content" >
						<form name="EditLimsStudent" method="post" action="<#if entity??>updateLimsStudent<#else>createLimsStudent</#if>" 
							 id="EditLimsStudent" class="form-horizontal"    >
								<input type="hidden" name="studentId" value="${studentId?if_exists}" />
								<table class="basic-table" cellspacing="0">
									<tbody>
									<tr>
										<td class="label"><span>学生姓名</span></td>
										<td >
										<input name="studentName" class="form-control required" type="text" value="<#if entity??>${entity.studentName!}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
										</td>
									
										<td class="label"><span>邮箱地址</span></td>
										<td >
										<input name="studentEmail" class="form-control required email" type="text" value="<#if entity??>${entity.studentEmail?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
										</td>
									</tr>
									<tr>
										<td class="label"><span>座位号</span></td>
										<td >
										<input name="seatNo" class="number" type="text" value="<#if entity??>${entity.seatNo?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
										</td>
									
										<td class="label"><span>出生年月</span></td>
										<td >
										<#assign birthDate="">
										<#if entity??&&entity.birthDate??><#assign birthDate=entity.birthDate></#if>
										<@htmlTemplate.renderDateField name="birthDate"  title="Format: yyyy-MM-dd" value="${birthDate!}" event="onchange" action="alertDialog(this.value)" className="required" readonly="true"/>
										</td>
										</td>
									</tr>
									<tr>
										<#assign enums = delegator.findByAndCache("Enumeration", {"enumTypeId" :"DOCUMENT_TYPE" })?if_exists>
										<td class="label"><span>性别</span></td>
										<td >
										<select name="gender" ><option></option>
							            	<#if enums?has_content>
							            		<#list enums as enum> 
							            			<option <#if entity??&&entity.gender??&&entity.gender==enum.enumId>selected </#if>  value='${enum.enumId!}'>${enum.description!}</option>
							            		</#list>
							            	</#if>
										  </select>
										</td>
									
										<td class="label"><span>星座</span></td>
										<td >
										<input name="sign" class="" type="text" value="<#if entity??>${entity.sign?if_exists}</#if>" <#if oper?? && oper.equals('view')>disabled</#if> />
										</td>
									</tr>
									<tr>
										<td class="label"><span> 班级名称</span></td>
										<td >
										<select name="classId">
							            	<option value=""></option>
							            		<#list LimsClassList as relEntity>
							            			<option <#if relEntity??&&entity??&&entity.classId??&&relEntity.classId==entity.classId>selected </#if>  
							            			value='${relEntity.classId}'>
							            			${relEntity.className}</option>
							            		</#list>
							            </select>
							            </td>
									
										<td class="label"><span>女朋友</span></td>
										<td >
										<@htmlTemplate.lookupField value='' formName="EditLimsStudent" showDescription="true" name="girlPartyId"  fieldFormName="LookupPerson"/>
										</td>
									</tr>
									<tr>
										<td class="label"><span>多/单选人员</span></td>
										<td >
											<input type='text' name='gggName'  id='gggName' >
											<input type='hidden' name='gggPartyId'  id='gggPartyId' >
											<a href='#' onclick="javascript:selectCheckallPerson('gggPartyId','gggName','N','10007')">选择</a>
										</td>
										<td class="label"><span>多/单选部门</span></td>
										<td >
											<input type='text' name='ggpName'  id='ggpName' >
											<input type='hidden' name='ggpPartyId'  id='ggpPartyId' >
											<a href='#' onclick="javascript:selectCheckallPartyGroup('ggpPartyId','ggpName','N')">选择</a>
										</td>
									</tr>		
									<tr>
										<td class="label"><span>多/单选人员-复杂查询</span></td>
										<td >
											<input type='text' name='gName'  id='gName' >
											<input type='hidden' name='gPartyId'  id='gPartyId' >
											<a href='#' onclick="javascript:selectCheckallPersonMutil('gPartyId','gName','N')">选择</a>
										</td>
										<td class="label"><span>多/单选本部门人员</span></td>
										<td >
											<input type='text' name='gppName'  id='gppName' >
											<input type='hidden' name='gppPartyId'  id='gppPartyId' >
											<a href='#' onclick="javascript:selectMyDepartmentPerson('gppPartyId','gppName','N')">选择</a>
										</td>
									</tr>		
									<tr>
										<td class="label"><span>多选班级</span></td>
										<td >
											<input type='text' name='mutilClassName'  id='mutilClassName' >
											<input type='hidden' name='mutilClassId'  id='mutilClassId' >
											<a href='#' onclick="javascript:selectMutilCommon('SelectMutilClass','mutilClassId','mutilClassName');">选择</a>
										</td>
										<td class="label"></td>
										
									</tr>		
								</tbody></table>
								
							</form>
		
					
		
				</div>
				
			</div><!--/span-->
		</div><!--/row-->
      			<!--
                  <div class="empty">没有等待开始的直播课</div>
                  -->
            </div>
  </div>

</div>
</div>

  </div><!--/container -->

  
        <div class="footer-autumn-primary">
          <div class="container">
            <div>
              <ul class="list-unstyled">
                <li>
                 <div>
                  <ul class="site-footer-links">
		  		  <li><a href="/page/online" >联系我们</a></li>
				  		  <li><a href="http://www.osforce.cn/page/FAQ" target="_blank">常见问题</a></li>
				  		  		  <li><a href="http://www.osforce.cn/page/year2013" target="_blank">开源力量2013</a></li>
				  		  		  		  		  <li><a href="http://www.opensourceforce.org/ouros/" >我们的开源项目</a></li>
				  		  <li><a href="/page/activity" >公司动态</a></li>
				  		  <li><a href="/page/invest" >投资人</a></li>
				  		  <li><a href="http://www.osforce.cn/page/partners" >合作伙伴</a></li>
				  		  <li><a href="/page/talent" >加入我们</a></li>
				  		  <li><a href="http://www.osforce.cn/photoview/" >精彩瞬间</a></li>
				  		  <li><a href="/page/nite" >NITE认证</a></li>
				  		  <li><a href="http://www.osforce.org" >外院</a></li>
				  		  		  		  		  		  		  		  		  		  		  		  		  		  		  	</ul>

                     <a href="http://www.miibeian.gov.cn/" target="_blank">沪ICP备08023068号-2</a> 
                  </div>


                  <span class="mlr20">Powered by 
                    <a href="http://www.edusoho.com/" target="_blank"> Edusoho v3.7.7</a>
                    ©2013 
                    <a href="http://www.edusoho.com" target="_blank">edusoho.com</a> & <a href="http://www.howzhi.com/" target="_blank"> 好知网</a></span>

                </li>
              </ul>
            </div>
          </div>
        </div>
  
  <div id="login-modal" class="modal" data-url="/login/ajax"></div>
 <!-- <div id="modal" class="modal"></div>  -->
  


</body>
</html>