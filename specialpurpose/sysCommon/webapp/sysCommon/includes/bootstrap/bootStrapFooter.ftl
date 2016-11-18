       <!-- <div class="footer" style="overflow: visible;">
		    <ul class="foot navbar-fixed-bottom">
                <li class="<#if showType?has_content&&showType=='1'>active</#if> col-xs-4 col-sm-4 col-md-4"><a href="ejiaPlan" class="menu_1">一家帮</a></li>
                <li class="<#if showType?has_content&&showType=='2'>active</#if> col-xs-4 col-sm-4 col-md-4 dropdown">
                    <a href="#" class="dropdown-toggle menu_2" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-comments-o"></i> 交流区<span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="ejiaWeChat">一家论坛</a></li>
                        <li><a href="myShowInfo">公示大厅</a></li>
                        <li><a href="webMsgList">站内消息</a></li>
                    </ul>
                </li>
                <li class="<#if showType?has_content&&showType=='3'>active</#if> col-xs-4 col-sm-4 col-md-4"><a href="ejiaMy" class="menu_3h">我的</a></li>
            </ul>
		</div>Footer End-->
		
<div class="nav4">
	<nav>
		<div id="nav4_ul" class="nav_4">
			<ul class="box">
				<li>
					<a href="ejiaPlan" class=""><img class="menu_1" src="../images/footer_icon1.png" /><span>一家帮</span></a>
				</li>
				<li>
					<a href="javascript:void(0)" class=""><img class="menu_2" src="../images/footer_icon2.png" /><span>交流区</span></a>
					<dl>
						<!--<dd><a href="ejiaWeChat"><span>一家论坛</span></a></dd>-->
						<dd><a href="myShowInfo"><span>公示大厅</span></a></dd>
						<dd><a href="webMsgList"><span>站内消息</span></a></dd>
					</dl>
				</li>
				<li>
					<a href="ejiaMy"><img class="menu_3" src="../images/footer_icon3.png" /><span>我的</span></a>
				</li>
			</ul>
		</div>
	</nav>
	<div id="nav4_masklayer" class="masklayer_div on">&nbsp;</div>
</div>
<script type="text/javascript">
nav4.bindClick(document.getElementById("nav4_ul").querySelectorAll("li>a"), document.getElementById("nav4_masklayer"));
</script>
