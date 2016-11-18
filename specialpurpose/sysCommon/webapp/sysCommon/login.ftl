
<!DOCTYPE html>
<html class=""><!--<![endif]--><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
  
    <link href="/sysCommon/images/bootstrap/bootstrap.css?osf_v3.7.5" rel="stylesheet">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/common.css?osf_v3.7.5">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/bootstrap-extends.css?osf_v3.7.5">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/web.css?osf_v3.7.5">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/web-osf.css?osf_v3.7.5">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/style.css?osf_v3.7.5">
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/osf.css?osf_v3.7.5">
    <link rel="stylesheet" href="/sysCommon/images/bootstrap/jquery-ui-1.8.21.custom.css" type="text/css"/>
    <link rel="stylesheet" href="/sysCommon/images/jquery.jqGrid-4.4.3/css/ui.jqgrid.css" type="text/css"/>
    <link rel="stylesheet" href="/sysCommon/images/bootstrap/jqGrid.overrides.css" type="text/css"/>
    <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/member.css?osf_v3.7.5">
    <link charset="utf-8" rel="stylesheet" href="/sysCommon/images/bootstrap/dialog.css">
    
    
	
    <!--[if lt IE 8]>
      <link href="/sysCommon/images/bootstrap/oldie.css?osf_v3.7.5" rel="stylesheet">
    <![endif]-->
  
  <link rel="stylesheet" media="screen" href="/sysCommon/images/bootstrap/group.css?osf_v3.7.5">
  <!--[if lt IE 9]>
    <script src="/sysCommon/images/bootstrap/html5shiv.js?osf_v3.7.5"></script>
  <![endif]-->

  <!--[if IE 8]>
    <script src="/sysCommon/images/bootstrap/respond.min.js?osf_v3.7.5"></script>
  <![endif]-->
  
 </head>  
   <body >


 <nav class="navbar navbar-inverse site-navbar " role="navigation" id="site-navbar"  data-counter-url="/user_remind_counter">
      <div class="container"> 
        <div class="row">
          <div class="col-lg-3 col-md-3 col-sm-8 col-xs-8">
                <div class="navbar-header ptm">
                                        <a class="navbar-brand-logo" href="/"><img  class="img-responsive" src="/sysCommon/images/logo.png"></a>
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
              </li>
				  	</ul>

                  <ul class="nav navbar-nav navbar-right">
                    <li><a href="/search"><span class="glyphicon glyphicon-search"></span> </a></li>
                                         
                      <li><a href="message/" class="badge-container message-badge-container">
						<span class="glyphicon glyphicon-envelope hidden-lt-ie8"></span>
						<span class="visible-lt-ie8">私信</span>
						</a></li>
                     
                     	<li><a href="/register">注册</a></li>
                                      </ul>

                </div> 
          </div>
        </div>
      </div>     
  </nav> 
    
      
      <!-- container -->
  <div id="content-container" class="container ptz">
            <div class="row row-6">
  <div class="col-md-6 col-md-offset-3">

    <div class="panel panel-default panel-page">
      <div class="panel-heading"><h2>登录</h2></div>

      <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" name="loginform">

          
        <div class="form-group">
          <label class="control-label" for="login_username">帐号</label>
          <div class="controls">
            <input class="form-control" id="login_username" type="text" name="USERNAME" style="width:450px" value="" required />
            <div class="help-block">请输入Email地址 / 用户昵称</div>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label" for="login_password">密码</label>
          <div class="controls">
            <input class="form-control" id="login_password" type="password" name="PASSWORD" style="width:450px" required />
          </div>
        </div>

        <div class="form-group">
          <div class="controls">
            <span class="checkbox mtm pull-right">
              <label> <input type="checkbox" name="_remember_me" checked="checked"> 记住密码 </label>
            </span>
                        <button type="submit" class="btn btn-fat btn-primary btn-large">登录</button>
          </div>
        </div>
                  <input type="hidden" name="_target_path" value="http://www.osforce.cn/register">
                <input type="hidden" name="_csrf_token" value="9a7dddf3884da5138e88f5d88412ae2bab17a707">
      </form>

      <div class="ptl">
          <a href="/password/reset">找回密码</a>
          <span class="text-muted mhs">|</span>
          <span class="text-muted">还没有注册帐号？</span>
          <a href="/register">立即注册</a>
      </div>

      
	

  </div>
</div>
  </div><!--/container -->
      
  </div>
        <div class="footer-autumn-primary">
          <div class="container">
            <div>
              <ul class="list-unstyled">
                <li>
                 <div>
                  <ul class="site-footer-links">
		  		  <li><a href="/page/online" >联系我们</a></li>
				  		  <li><a href="http://www.osforce.cn/page/FAQ" target="_blank">常见问题</a></li>
				  		  		  <li><a href="http://www.osforce.cn/page/year2013" target="_blank">CCME</a></li>
				  		  <li><a href="/page/activity" >公司动态</a></li>
				  		  <li><a href="/page/invest" >投资人</a></li>
				  		  <li><a href="http://www.osforce.cn/page/partners" >合作伙伴</a></li>
				  		  <li><a href="/page/talent" >加入我们</a></li>
				  		  <li><a href="http://www.osforce.cn/photoview/" >精彩瞬间</a></li>
				  		  		  		  		  		  		  		  		  		  		  		  		  		  		  	</ul>

                     <a href="http://www.miibeian.gov.cn/" target="_blank">京ICP备08023068号-2</a> 
                  </div>


                  <span class="mlr20">Powered by 
                    ©2014 
                    <a href="http://www.howzhi.com/" target="_blank"> 北京医麦思健康科技有限公司</a></span>

                </li>
              </ul>
            </div>
          </div>
        </div>
  
  <div id="login-modal" class="modal" data-url="/login/ajax"></div>
 <!-- <div id="modal" class="modal"></div>  -->
  

</body>
</html>