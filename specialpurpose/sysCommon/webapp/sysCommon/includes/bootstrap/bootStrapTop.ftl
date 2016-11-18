<nav class="navbar navbar-inverse site-navbar " role="navigation" id="site-navbar"  data-counter-url="/user_remind_counter">
  	<div class="container"> 
        <div class="row">
          	<div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
        		<div class="navbar-header ptm">
					<#if webSiteId?? && webSiteId=='ykd'>
	                	<a class="navbar-brand-logo" href="/" style="font-size:25px;color:#fff;font-weight:bolder;text-decoration:none;letter-spacing:3px;">国医随诊系统</a>
					<#elseif webSiteId?? && webSiteId=='disease'>
	                	<a class="navbar-brand-logo" href="<@ofbizUrl>FindMeasure?1=1<#if diseaseTypeId??>&diseaseTypeId=${diseaseTypeId?if_exists}</#if><#if diseaseId??>&diseaseId=${diseaseId?if_exists}</#if></@ofbizUrl>"><img  class="img-responsive" src="/${webSiteId}/images/logo2.png"></a>
					<#else>
	                	<a class="navbar-brand-logo" href="#"><img  class="img-responsive" src="/${webSiteId}/images/logo.png"></a>
					</#if>
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

              <!--
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
              -->

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
                  	<#if webSiteId?? && webSiteId=='disease'>
                  		<#if userLogin??>
	                  	  <#assign Party = delegator.findOne("Party",{"partyId",userLogin.partyId},false)>
	                  	  <#assign UserLoginSecurityGroup = Static["org.ofbiz.entity.util.EntityUtil"].getFirst(delegator.findByAnd("UserLoginSecurityGroup",Static["org.ofbiz.base.util.UtilMisc"].toMap("userLoginId",userLogin.userLoginId,"thruDate",null)))?if_exists>
                  	 	  <#if UserLoginSecurityGroup.groupId?has_content&&UserLoginSecurityGroup.groupId=="dis_sg_10000">
		                      <li class="dropdown hidden-lt-ie8">
		                        	<a href="FindMeasure1">框架定义 </a>
		                      </li>
		                  <#elseif userLogin.userLoginId=="admin">
		                  	<li class="dropdown hidden-lt-ie8">
		                        	<a href="FindMeasure1">框架定义 </a>
		                      </li>
                  	 	  </#if>
                  	  </#if>
                      <li class="dropdown hidden-lt-ie8">
                        	<a href="#" class="dropdown-toggle" data-toggle="dropdown">新建 <b class="caret"></b></a>
	                        <ul class="dropdown-menu">
	                          <li><a href="#" onclick="javascript:createNewContent();"> <i class="glyphicon glyphicon-book"></i> 干预措施</a></li>
	                          <li><a href="#" onclick="javascript:RiskTip_create();"><i class="glyphicon glyphicon-book"></i>  风险提示</a></li>
	                          <li><a  href="#" onclick="javascript:MeasureGroup_create();"> <i class="glyphicon glyphicon-book"></i> 管理方案</a></li>
	                          <li><a  href="customerIndexTest" > <i class="glyphicon glyphicon-book"></i> 模拟录入</a></li>
	                        </ul>
                      </li>
                      <li class="dropdown hidden-lt-ie8">
                        	<a href="#" class="dropdown-toggle" data-toggle="dropdown"><#if Party??>${Party.partyName!}</#if> <b class="caret"></b></a>
	                        <ul class="dropdown-menu">
	                          <!--<li><a href="<@ofbizUrl>/PersonInformation?partyId=${userLogin.partyId!}</@ofbizUrl>"> <i class="glyphicon glyphicon-book"></i> 个人中心</a></li>-->
	                          <li><a href="<@ofbizUrl>/personalCenter?partyId=${userLogin.partyId!}</@ofbizUrl>" target="_blank"> <i class="glyphicon glyphicon-book"></i> 个人中心</a></li>
	                          <!-- <li><a href="changePassword"> <i class="glyphicon glyphicon-book"></i> 修改密码</a></li> -->
	                          <li><a href="changePassword"> <i class="glyphicon glyphicon-book"></i>设置</a></li>
	                        </ul>
                      </li>
                      <li><a href="logout"><i class="glyphicon glyphicon-off"></i> 退出</a></li>
                  	<#else>
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
                          <li><a href="changePassword"> <i class="glyphicon glyphicon-book"></i> 修改密码</a></li>
                        </ul>
                        </li>
                      <li><a href="logout"><i class="glyphicon glyphicon-off"></i> 退出</a></li>
                    </#if>
                                      </ul>

                </div> 
          </div>
        </div>
      </div>     
  </nav> 
   <script language='javascript'>
 	function createNewContent(){
		var diseaseId = jQuery("#diseaseId").val();
		var diseaseTypeId = jQuery("#diseaseTypeId").val();
		var url="EditMeasureContent?1=1";
		if(diseaseId!=null&&diseaseId.length>0){
			url+="&diseaseId="+diseaseId;
		}
		if(diseaseTypeId!=null&&diseaseTypeId.length>0){
			url+="&diseaseTypeId="+diseaseTypeId;
		}
		window.location.href=url;
	}
	function RiskTip_create(){
		var diseaseId = jQuery("#diseaseId").val();
		var diseaseTypeId = jQuery("#diseaseTypeId").val();
		var url="EditRiskEducation?1=1";
		if(diseaseId!=null&&diseaseId.length>0){
			url+="&diseaseId="+diseaseId;
		}
		if(diseaseTypeId!=null&&diseaseTypeId.length>0){
			url+="&diseaseTypeId="+diseaseTypeId;
		}
		window.location.href=url;
	}
	function MeasureGroup_create(){
		var diseaseId = jQuery("#diseaseId").val();
		var diseaseTypeId = jQuery("#diseaseTypeId").val();
		var url="EditMeasureGroup?1=1";
		if(diseaseId!=null&&diseaseId.length>0){
			url+="&diseaseId="+diseaseId;
		}
		if(diseaseTypeId!=null&&diseaseTypeId.length>0){
			url+="&diseaseTypeId="+diseaseTypeId;
		}
		window.location.href=url;
	}
 </script> 