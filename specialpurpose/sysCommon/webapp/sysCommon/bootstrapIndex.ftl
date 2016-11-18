<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
<!--   <link rel="stylesheet/less" type="text/css" href="bootstrap/less/bootstrap.less">
  <script src="less.min.js" type="text/javascript"></script>
 -->
  <link rel="stylesheet" type="text/css" href="/sysCommon/images/charisma-master/css/bootstrap-cerulean.css">
<!--   <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-ie6.css">-->

  <!--[if lte IE 6]>
  <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap-ie6.css">
  <![endif]-->
  <!--[if lte IE 7]>
  <link rel="stylesheet" type="text/css" href="bootstrap/css/ie.css">
  <![endif]-->

</head>
<body>

<!-- fixed navbar -->
  <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="./index.html">Bootstrap</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active">
                <a href="./index.html">Home</a>
              </li>
              <li class="">
                <a href="./getting-started.html">Get started</a>
              </li>
              <li class="">
                <a href="./scaffolding.html">Scaffolding</a>
              </li>
              <li class="">
                <a href="./base-css.html">Base CSS</a>
              </li>
              <li class="">
                <a href="./components.html">Components</a>
              </li>
              <li class="">
                <a href="./javascript.html">JavaScript</a>
              </li>
              <li class="">
                <a href="./customize.html">Customize</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>

<br /><br /><br />

<!-- navbar -->
  <div class="navbar">
    <div class="navbar-inner">
      <div class="container">
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".navbar-responsive-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>
        <a class="brand" href="#">Title</a>
        <div class="nav-collapse collapse navbar-responsive-collapse">
          <ul class="nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" style="" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu" style="">
                <li><a href="#" style="">Action </a></li>
                <li><a href="#">Another action faw fwe  erwerf erw ewrew</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider" style=""></li>
                <li class="nav-header">Nav header</li>
                <li><a href="#" style="">Separated link</a></li>
                <li><a href="#">One more separated link</a></li>
              </ul>
            </li>
          </ul>
          <form class="navbar-search pull-left" action="">
            <input type="text" class="search-query span2" placeholder="Search">
          </form>
          <ul class="nav pull-right">
            <li><a href="#">Link</a></li>
            <li class="divider-vertical"></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </li>
          </ul>
        </div><!-- /.nav-collapse -->
      </div>
    </div><!-- /navbar-inner -->
  </div>

<!-- buttons -->
<div class="bs-docs-example">
<div class="btn-group" style="margin: 9px 0 5px;">
  <button class="btn">Left</button>
  <button class="btn">Middle</button>
  <button class="btn">Right</button>
</div>

<div class="btn-toolbar" style="margin: 0;">
  <div class="btn-group">
    <button class="btn">1</button>
    <button class="btn">2</button>
    <button class="btn">3</button>
    <button class="btn">4</button>
  </div>
  <div class="btn-group">
    <button class="btn">5</button>
    <button class="btn">6</button>
    <button class="btn">7</button>
  </div>
  <div class="btn-group">
    <button class="btn">8</button>
  </div>
</div>
<br />


<div class="btn-toolbar" style="margin: 0;">
  <div class="btn-group">
    <button class="btn dropdown-toggle" data-toggle="dropdown">Action <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">Action <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-danger dropdown-toggle" data-toggle="dropdown">Danger <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-warning dropdown-toggle" data-toggle="dropdown">Warning <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-success dropdown-toggle" data-toggle="dropdown">Success <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-info dropdown-toggle" data-toggle="dropdown">Info <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-inverse dropdown-toggle" data-toggle="dropdown">Inverse <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
</div>
<br />

<div class="btn-toolbar" style="margin: 0;">
  <div class="btn-group">
    <button class="btn btn-large dropdown-toggle" data-toggle="dropdown">Large button <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-small dropdown-toggle" data-toggle="dropdown">Small button <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">Mini button <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
</div>

<br />



<div class="btn-toolbar" style="margin: 0;">
  <div class="btn-group">
    <button class="btn">Action</button>
    <button class="btn dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-primary">Action</button>
    <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-danger">Danger</button>
    <button class="btn btn-danger dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-warning">Warning</button>
    <button class="btn btn-warning dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-success">Success</button>
    <button class="btn btn-success dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-info">Info</button>
    <button class="btn btn-info dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
  <div class="btn-group">
    <button class="btn btn-inverse">Inverse</button>
    <button class="btn btn-inverse dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li><a href="#">Action</a></li>
      <li><a href="#">Another action</a></li>
      <li><a href="#">Something else here</a></li>
      <li class="divider"></li>
      <li><a href="#">Separated link</a></li>
    </ul>
  </div><!-- /btn-group -->
</div>

<br />

<div class="btn-group btn-group-vertical" style="width:35px;">
  <button type="button" class="btn"><i class="icon-align-left"></i></button>
  <button type="button" class="btn"><i class="icon-align-center"></i></button>
  <button type="button" class="btn"><i class="icon-align-right"></i></button>
  <button type="button" class="btn"><i class="icon-align-justify"></i></button>
</div>
</div>


<div class="bs-docs-example">
  <div class="btn-toolbar">
    <div class="btn-group">
      <button class="btn btn-large">Large action</button>
      <button class="btn btn-large dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
      <ul class="dropdown-menu">
        <li><a href="#">Action</a></li>
        <li><a href="#">Another action</a></li>
        <li><a href="#">Something else here</a></li>
        <li class="divider"></li>
        <li><a href="#">Separated link</a></li>
      </ul>
    </div><!-- /btn-group -->
  </div><!-- /btn-toolbar -->
  <div class="btn-toolbar">
    <div class="btn-group">
      <button class="btn btn-small">Small action</button>
      <button class="btn btn-small dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
      <ul class="dropdown-menu">
        <li><a href="#">Action</a></li>
        <li><a href="#">Another action</a></li>
        <li><a href="#">Something else here</a></li>
        <li class="divider"></li>
        <li><a href="#">Separated link</a></li>
      </ul>
    </div><!-- /btn-group -->
  </div><!-- /btn-toolbar -->
  <div class="btn-toolbar">
    <div class="btn-group">
      <button class="btn btn-mini">Mini action</button>
      <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></button>
      <ul class="dropdown-menu">
        <li><a href="#">Action</a></li>
        <li><a href="#">Another action</a></li>
        <li><a href="#">Something else here</a></li>
        <li class="divider"></li>
        <li><a href="#">Separated link</a></li>
      </ul>
    </div><!-- /btn-group -->
  </div><!-- /btn-toolbar -->


  <button type="button" id="fat-btn" data-loading-text="loading..." class="btn btn-primary">
                Loading state
              </button>
</div>


<!-- dropdown -->
<div class="bs-docs-example clearfix" style="min-height: 180px;">

            <div class="pull-left1" style="float:left;">
              <p class="muted">Default</p>
              <div class="dropdown">
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display: block; position: static; margin-bottom: 5px; *width: 180px;">
                  <li class="active"><a tabindex="-1" href="#">Action fasdfas</a></li>
                  <li><a tabindex="-1" href="#">Another action Another action Another action </a></li>
                  <li class="disabled"><a tabindex="-1" href="#">Something else here</a></li>
                  <li class="divider"></li>
                  <li class="dropdown-submenu">
                    <a tabindex="-1" href="#">More options</a>
                    <ul class="dropdown-menu">
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>

            <div class="pull-left1" style="float:left;margin-left: 100px;">
              <p class="muted">Dropup</p>
              <div class="dropup">
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display: block; position: static; margin-bottom: 5px; *width: 180px;">
                  <li><a tabindex="-1" href="#">Action1</a></li>
                  <li><a tabindex="-1" href="#">Another action</a></li>
                  <li><a tabindex="-1" href="#">Something else here</a></li>
                  <li class="divider"></li>
                  <li class="dropdown-submenu">
                    <a tabindex="-1" href="#">More options</a>
                    <ul class="dropdown-menu">
                      <li><a tabindex="-1" href="#">1Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>

            <div class="pull-left1" style="float:left;margin-left: 100px;">
              <p class="muted">Left submenu</p>
              <div class="dropdown">
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display: block; position: static; margin-bottom: 5px; *width: 180px;">
                  <li><a tabindex="-1" href="#">Action</a></li>
                  <li><a tabindex="-1" href="#">Another action</a></li>
                  <li><a tabindex="-1" href="#">Something else here</a></li>
                  <li class="divider"></li>
                  <li class="dropdown-submenu pull-left">
                    <a tabindex="-1" href="#">More options</a>
                    <ul class="dropdown-menu">
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                      <li><a tabindex="-1" href="#">Second level link</a></li>
                    </ul>
                  </li>
                  <li><a tabindex="-1" href="#">Something else here</a></li>
                  <li><a tabindex="-1" href="#">Something else here</a></li>
                </ul>
              </div>
            </div>

          </div>

<br /><br /><br />

    <p style="height:1000px;"></p>

  <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
  <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
  <script type="text/javascript" src="js/bootstrap-ie.js"></script>
  <script type="text/javascript">

  </script>
</body>
</html>