<nav class="navbar navbar-inverse site-navbar " role="navigation" id="site-navbar"  data-counter-url="/user_remind_counter">
      <div class="container"> 
        <div class="row">
          <div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
                <div class="navbar-header ptm">
                   <a class="navbar-brand-logo" href="<@ofbizUrl>main?diseaseId=${diseaseId!}</@ofbizUrl>"><img  class="img-responsive"  src="/manage/images/logo_2.png"></a>
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
				
              	
				
                  <ul class="nav navbar-nav navbar-right">
                  <!--
                    <li><a href="search"><span class="glyphicon glyphicon-search"></span> </a></li>
                                         
                      <li><a href="notification" class="badge-container notification-badge-container">
                        <span class="glyphicon glyphicon-bullhorn hidden-lt-ie8"></span>
                        <span class="visible-lt-ie8">通知</span>
                        </a></li>
                      <li>
                        <a href="message/" class="badge-container message-badge-container">
                        <span class="glyphicon glyphicon-envelope hidden-lt-ie8"></span>
                        <span class="visible-lt-ie8">私信</span>
                                                </a>
                        </li>
                      <li class="visible-lt-ie8"><a href="/settings/">云岗</a></li>
                      
                      <li class="dropdown hidden-lt-ie8">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><#if userLogin??>${userLogin.userLoginId}</#if> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                          <li><a href="/my"> <i class="glyphicon glyphicon-book"></i> 我的课堂 </a></li>
                          <li><a href="/user/19505"><i class="glyphicon glyphicon-home"></i> 我的主页</a></li>
                          <li><a href="/settings/"><i class="glyphicon glyphicon-cog"></i> 帐号设置</a></li>
                          <li class="divider"></li>
                          <li><a href="/mysale"><i class="glyphicon glyphicon-leaf"></i> 推广佣金</a></li>
                          <li class="divider"></li>
                                                        <li><a href="logout"><i class="glyphicon glyphicon-off"></i> 退出</a></li>
                        </ul>
                        </li>
                  -->
                  	  <#if userLogin??>
	                  	  <#assign Party = delegator.findOne("Party",{"partyId",userLogin.partyId},false)>
	                  	  <#if Party??&&Party.parentId?has_content>
	                  	  	<#assign Party = delegator.findOne("Party",{"partyId",Party.parentId},false)>
	                  	  </#if>
	                  	  <#if Party??&&Party.channelId??>
		                  	  <#assign Channel = delegator.findOne("Channel",{"channelId",Party.channelId},false)>
	                  	  </#if>
	                  	  <#if Channel??&&Channel.channelName??>
                  	 	  <li class="hidden-lt-ie8"><a href="#">${Channel.channelName!}</a></li>
	                  	  </#if>
                  	  </#if>
                      <li class="dropdown hidden-lt-ie8">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><#if userLogin??>${userLogin.userLoginId}</#if> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                          <!--<li><a href="<@ofbizUrl>/PersonInformation?partyId=${userLogin.partyId!}</@ofbizUrl>"> <i class="glyphicon glyphicon-book"></i> 个人中心</a></li>-->
                          <li><a href="<@ofbizUrl>/personalHomepage?partyId=${userLogin.partyId!}</@ofbizUrl>"> <i class="glyphicon glyphicon-book"></i> 个人主页</a></li>
                          <li><a href="changePassword"> <i class="glyphicon glyphicon-book"></i> 修改密码</a></li>
                        </ul>
                        </li>
                      <li><a href="logout"><i class="glyphicon glyphicon-off"></i> 退出</a></li>
                                      </ul>

                </div> 
          </div>
        </div>
      </div>     
  </nav> 