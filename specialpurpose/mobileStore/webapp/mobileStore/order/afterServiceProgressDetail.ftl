<body>
	<style type="text/css">
		/* Common */
		.new-header-append{font-size:16px;line-height:1.25em;min-width:320px;font-size:1em;font-family:'microsoft yahei',Verdana,Arial,Helvetica,sans-serif;color:#000;-webkit-text-size-adjust:none}
		.new-header-append,p,h1,h2,h3,h4,h5,h6,ul,ol,li,dl,dt,dd,table,th,td,form,fieldset,legend,input,textarea,button,select{margin:0;padding:0}
		.new-tbl-type{display:table;width:100%}
		.new-tbl-cell{display:table-cell}
	    /* header */
	    .new-jd-logo{position:relative;padding:0 10px}
	    .new-hlogo-btn{position:absolute;top:0;right:10px}
	    .new-m-myjd,.new-m-cart{display:inline-block;width:30px;height:39px}
	    .new-m-myjd span,.new-m-cart span{display:inline-block;width:26px;height:21px;margin-top:13px;background:url(/mobileStore/images/imgs/icon2b.png?v=jd2015010820) 4px 0 no-repeat;background-size:180px 180px;text-indent:-9999px}
	    .new-m-cart span{width:24px;height:21px;background-position:-24px 0}
	    .new-header{position:relative;z-index:8888;height:44px;background:#e4393c}
	    .new-header-v1{background:#edecec}
	    .new-header h2{height:44px;line-height:44px;font-weight:normal;font-size:16px;color:#fff;text-align:center}
	    .new-header-v1 h2{color:#000}
	    .new-a-home{position:absolute;top:6px;left:6px;width:56px;height:32px;background:url(/mobileStore/images/imgs/icon.png?v=jd2015010820) 0 0 no-repeat;font-size:14px;line-height:32px;color:#6e6e6e;text-indent:18px}
	    .new-a-out{position:absolute;top:6px;right:12px;width:32px;height:30px;background:url(/mobileStore/images/imgs/icon.png?v=jd2015010820) -23px -1474px;text-indent:-9999px}
	    .new-a-out .new-logo{display:inline-block;width:52px;height:29px;background:url(/mobileStore/images/imgs/icon.png?v=jd2015010820) 1px -546px no-repeat}
	    .new-a-back{position:absolute;top:6px;left:6px;width:30px;height:32px}
	    .new-a-back span{display:inline-block;width:10px;height:18px;margin-top:6px;background:url(/mobileStore/images/imgs/icon2b.png?v=jd2015010820) -60px 0 no-repeat;background-size:180px 180px;text-indent:-9999px}
	    .new-a-back2{background:url(/mobileStore/images/imgs/icon.png?v=jd2015010820) no-repeat scroll 3px -1431px;height: 32px;left: 6px;position: absolute;text-indent: -9999px;top: 6px;width: 30px}
	    .new-a-back-v1{background-position:3px -1431px}
	    .new-a-edit{position:absolute;top:6px;right:12px;width:37px;height:30px;background:url(/mobileStore/images/imgs/icon.png?v=jd2015010820) 7px -669px no-repeat;font-size:14px;line-height:32px;color:#6e6e6e;text-align:center;text-indent:-9999px}
	    .new-a-jd{position:absolute;top:6px;right:7px;width:37px;height:30px}
	    .new-a-jd span{display:inline-block;width:21px;height:21px;margin:5px 0 0 8px;background:url(/mobileStore/images/imgs/icon2b.png?v=jd2015010820) -125px -24px no-repeat;background-size:180px 180px;text-indent:-9999px}
	    .new-a-edit{background-position:16px -605px}
	    .new-header .new-srch-box{width:auto;margin:0 70px 0 12px;padding-right:90px;background-color:#fff}
	    .new-header .new-srch-box-v1{width:84%;margin-left:40px;padding-right:0}
	    .new-header .new-srch-box-v2{padding-right:30px}
	    .new-header .new-srch-box-v3{width:62%;margin-left:40px;padding-right:30px}
	    .new-header .new-srch-box-v1 .new-srch-input{margin-right:0}
	    .new-header .new-srch-lst{position:absolute;top:31px;left:-1px;z-index:100;width:100%}
	    .new-a-cancel{position:absolute;top:0;left:0;width:40px;height:44px;line-height:44px;font-size:14px;color:#fff;text-align:center}
	    .new-header .new-s-close{right:3px}
	    .new-header .new-s-close-v1{right:55px}
	    .new-a-search{position:absolute;top:6px;right:16px;width:37px;height:30px;line-height:30px;font-size:16px;font-weight:bold;color:#fff}
		/* tab */
	    .new-jd-tab{border-bottom:1px solid #d0cece;background-color:#fff}
	    .new-jd-tab .new-tbl-cell{width:25%;padding:9px 0;font-size:12px;color:#fff;text-align:center}
	    .new-jd-tab .new-tbl-cell span{vertical-align:text-top}
	    .new-jd-tab .new-tbl-cell .icon,.new-jd-tab .new-tbl-cell .icon2,.new-jd-tab .new-tbl-cell .icon3,.new-jd-tab .new-tbl-cell .icon4{display:inline-block;width:22px;height:22px;background:url(/mobileStore/images/imgs/icon2b.png?v=jd2015010820) -60px -25px no-repeat;background-size:180px 180px;text-indent:-9999px}
	    .new-jd-tab .new-tbl-cell .icon2{width:26px;background-position:0 -25px}
	    .new-jd-tab .new-tbl-cell .icon3{width:25px;background-position:-29px -25px}
	    .new-jd-tab .new-tbl-cell .icon4{width:22px;background-position:-85px -25px}
	    .new-jd-tab .new-tbl-cell .icon.on{background-position:-157px 0}
	    .new-jd-tab .new-tbl-cell .icon2.on{background-position:-154px -24px}
	    .new-jd-tab .new-tbl-cell .icon3.on{background-position:-154px -49px}
	    .new-jd-tab .new-tbl-cell .icon4.on{background-position:-155px -74px}
	    .new-jd-tab .new-tbl-cell .txt{display:block}
	</style>
	<div class="new-header new-header-append">
		<a href="javascript:_pageBack();" class="new-a-back"><span>返回</span></a>
			<h2>进度查询</h2>
	    <a href="javascript:void(0)" id="btnJdkey" onclick="_toggleJdKey()" class="new-a-jd"><span>京东键</span></a>
	</div>
	<div class="new-jd-tab new-header-append" style="display:none" id="jdkey">
		<div class="new-tbl-type">
	        <a href="http://m.jd.com/index.html?sid=046753ecacf07bb42a3ec5377f31bb2a" class="new-tbl-cell">
	        	<span class="icon">首页</span>
				<p style="color:#6e6e6e;">首页</p>
	        </a>
	        <a href="http://m.jd.com/category/all.html?sid=046753ecacf07bb42a3ec5377f31bb2a" class="new-tbl-cell">
	        	<span class="icon2">分类搜索</span>
				<p style="color:#6e6e6e;">分类搜索</p>
	        </a>
	        <a href="http://m.jd.com/cart/cart.action?sid=046753ecacf07bb42a3ec5377f31bb2a" id="html5_cart" class="new-tbl-cell">
	        	<span class="icon3">购物车</span>
				<p style="color:#6e6e6e;">购物车</p>
	        </a>
	        <a href="http://m.jd.com/user/home.action?sid=046753ecacf07bb42a3ec5377f31bb2a" class="new-tbl-cell">
	        	<span class="icon4">用户中心</span>
				<p style="color:#6e6e6e;">用户中心</p>
	        </a>
	    </div>
	</div>
	    <!--<div class="m-wrapper">-->
		<h2 class="title-bar probDesc" style="">问题描述</h2>
		<input id="afsServiceProcessFlag" name="afsServiceProcessFlag" value="true" type="hidden">
	    <input id="questionDescribe" name="questionDescribe" value="测试功能，请勿处理" type="hidden">
		<ul class="m-list detai-list" id="wentiComp">
			<li class="probDesc" style="">
				<div class="tbl-cell full">
					<span id="yuyuemsg" style="word-break:break-all;">测试功能，请勿处理</span>
					<input name="questionDesc" id="questionDesc" style="display:none;width:80%" type="text">
				</div>
				<div class="tbl-cell canUpdateDesc" style="">
					<span class="add-name"><a href="javascript:;" id="updateDescBtn" act="update" class="c-btn">更新</a></span>
				</div>
			</li>
	
			<li class="probDate" style="display: none">
	            <div class="tbl-cell full">
	                预约取件时间
	            </div>
	            <div class="tbl-cell canUpdate" style="display:none">
	                <span class="add-name"><a href="javascript:;" act="updateDate" class="c-btn">改约</a></span>
	                <input id="reserveDateStr" name="reserveDateStr" value="" type="hidden">
	                <input id="reserveDateBegin" name="reserveDateBegin" type="hidden">
	                <input id="reserveDateEnd" name="reserveDateEnd" type="hidden">
	            </div>
	
	
	
				<div id="showDateChange">
	                                <div>
	                    <div class="tbl-cell full smallDate">
	                        <span class="c-data" act="selectDate" bindform="reserveDateStr"></span>
	                    </div>
	                    <div class="tbl-cell"><span class="add-name"></span></div>
	                </div>
			</div></li>
	
		</ul>
	
	<!-- 2014-11-14 新增 s -->
	<style type="text/css">
	    .detai-list	.btns{padding-right:.625em;margin:20px 0;}
	    .detai-list	.btn-c2{display: block;background-color:#ebebeb;}
	    .detai-list	.btn-h2{height:25px;line-height:25px;padding-left:9px;padding-right:9px;font-size:12px;text-align:center;border-radius:3px;}
	    .detai-list	#shenhemsg{display:inline-block;line-height:1.5em;height:4.5em;overflow:hidden;}
	</style>
	
	<h2 class="title-bar probDesc2" style="display:none">审核留言</h2>
	<ul class="m-list detai-list" id="wentiComp">
	    <li class="probDesc2" style="display:none">
	        <div class="tbl-cell full" id="shenheId">
	            <span id="shenhemsg"><!--误下单，买了两盒一样的颜色，特申请将其中一盒调换为蓝色盒调换为蓝色盒调换为蓝色盒调换为蓝色盒调换为蓝色下单，买了两盒一样的颜色，特申请将其中一盒调换为蓝色下单，买了两盒一样的颜色，特申请将其中一盒调换为蓝色下单，买了两盒一样的颜色，特申请将其中一盒调换为蓝色--></span>
	        </div>
	        <div class="btns" id="message-btn">
	            <a href="#" class="btn-h2 btn-c2">显示全部</a>
	        </div>
	    </li>
	</ul>
	
	<script type="text/javascript">
	    $('#message-btn').click(function(){
	        $('.detai-list	#shenhemsg').css({"overflow":"visible","height":"auto"});
	        $('#message-btn').hide();
	    })
	</script>
	
	<!-- 2014-11-14 新增 e -->
	
		<div class="deal-list">
			<ul>
	                        			<li class="cur">
					<p>2015-01-21 14:22:57</p>
					<p>您的服务单已申请成功，待售后审核中</p>
					<p>经办：系统</p>
					<span class="pointer"></span>
				</li>
	                        		</ul>
			<span class="line"></span>
		</div>
	<!--</div>-->
	<div style="display:none;">
	    </div>
	
	
	<script type="text/template" id="dateCalendarTemplate">
	    <div class="cust-data-layer" >
	        <%if(resultCode==1){%>
	        <div class="edge"></div>
		<article>
			<header class="hea">
				<ul>
					<li>时间段</li>
					<%for(var i = 0 ; i <  calendarDayList[0].timeList.length;i++){%>
					<li><span class="time-stamp"></span>{calendarDayList[0].timeList[i].startTime}-{calendarDayList[0].timeList[i].endTime}</li>
					<%}%>
				</ul>
			</header>
			<div style="overflow:hidden" class="calendar-content">
			<section>
				<%for(var i = 0 ; i < calendarDayList.length;i++){%>
				<ul c_time="{calendarDayList[i].day}">
					<li>{NODEB.util.formatDate(calendarDayList[i].day,'M-d')} <%if(calendarDayList[i].today){%>今天<%}else{%>周{NODEB.util.weekDayByDate(calendarDayList[i].day)}<%}%>
					</li>
					<%for(var j = 0 ; j <  calendarDayList[i].timeList.length;j++){%>
						<li c_index="{i}" act-data="date={calendarDayList[i].day}&start={calendarDayList[i].timeList[j].startTime}&end={calendarDayList[i].timeList[j].endTime}" {calendarDayList[i].timeList[j].enable?'act="select"':'class="dis"'}>可选</li>
					<%}%>
				</ul>
				<%}%>
			</section>
			</div>
		</article>
	<%}else{%>
	接口请求错误，请刷新页面重试
	<%}%>
	</div>
	</script>
	
	<script type="text/javascript" src="/mobileStore/images/js/horse.js"></script>
	<script type="text/javascript">
	var sid = "046753ecacf07bb42a3ec5377f31bb2a",
		pin = '242991761-26336401',
		skuId='1005276307',
		orderId = '1708454030',
		afsServiceId="147310286";
	var isPopOpen = 'true',
	    approveResult ='10';
	console.log('isPopOpen==='+isPopOpen);
	console.log('approveResult'+approveResult);
	// 地址 省 市..
	var address = ['22','1954','1956','0'];
	
	NODEB.app("p/yuyue",function(){
		var wentiComp = document.getElementById("wentiComp");
		var delg = NODEB.delegate(wentiComp);
	
		function init(){
			if($("#questionDescribe").val()){
				$(".probDesc").show();
			}
	
			if($("#afsServiceProcessFlag").val() == "true"){
				$(".canUpdateDesc").show();
			}
	
			delg.add("updateDesc","tap",function(){
				var value = $('#questionDescribe').val() +"split"+ $('#questionDesc').val();
				if(!$('#questionDesc').val()){
					NODEB.alert("描述不能为空哦",false);
					return;
				}
				jQuery.post('/afs/submitQuestionDescribe.json',{
						"sid":sid,
						"serviceId":afsServiceId,
						"questionDesc":value
					},
					function(data){
	                        if(data && data.submitResult){
	                            NODEB.alert("更新成功~",true)
	                            $("#yuyuemsg").html(data.submitDesc);
	                            $('#questionDescribe').val(data.submitDesc);
	                            $("#questionDesc").val("");
	                            $("#yuyuemsg").show();
	                            $("#questionDesc").hide();
	                            $("#updateDescBtn").attr("act","update");
	                            $("#updateDescBtn").html("更新");
	                        }else{
	                            NODEB.alert("更新失败,请重新提交数据!",false)
	                        }
			 		},
				"json");
			})
	
			delg.add("update","tap",function(){
				$("#yuyuemsg").hide();
				$("#questionDesc").show();
	            $("#questionDesc").focus();
				$("#updateDescBtn").attr("act","updateDesc");
				$("#updateDescBtn").html("提交");
			})
		}
	
		function initDate(){
	
			var smallDate = $(".smallDate");
			// 小件预约时间
			if(smallDate.length){
				var smallDateLayer = NODEB.dateLayer(smallDate,{
					api:"/promise/smallGoodsCalendar",
					setDefalt:false
				});
				smallDateLayer.setParam({
					sid:sid,
					provinceId:address[0]||'',
					cityId:address[1]||'',
					countyId:address[2]||'',
					townId:address[3]||'',
					pin:pin,
					orderId:orderId
				})
	
				smallDateLayer.on("setValue",function(data){
					var day = NODEB.util.formatDate(data.date,"yyyy-MM-dd");
					$("#reserveDateStr").val(day);
					$("#reserveDateBegin").val(day+" "+data.start);
					$("#reserveDateEnd").val(day+" "+data.end);
				})
	
			}else{
				// 大件时间
				var deteSelect = $(".data-select");
				var bigDateSelect = new  NODEB.CSelect(deteSelect);
				var param = {
					sid:sid,
					provinceId:address[0]||'',
					cityId:address[1]||'',
					countyId:address[2]||'',
					townId:address[3]||'0',
					pin:pin,
					skuId:skuId
				}
	
				$.get("/promise/largeAppliancesCalendar",param,function(data) {
					if(data && data.resultCode == "1"){
						var res=[];
						data.reservingDateList.forEach(function(a){
							res.push({
								text:a,
								value:a.substring(0,a.indexOf("["))
							})
						})
						bigDateSelect.setData(res);
						bigDateSelect.selectByVal(currentTime);
					}
	
				},"json").error(function(){
					//
					NODEB.alert("获取时间列表出错!,刷新试试",false);
				});
			}
	
	
			delg.add("updateDate","tap",function(){
				if(!confirm("确定用当前预约时间改约？")){
					return;
				}
				var param = {
					"sid":sid,
					"afsServiceId":afsServiceId
				}
				if(smallDate.length){
	                var splitData = currentTime.split(" ");
	                var stend = splitData[2].split("-");
	                var reserveDateStr = splitData[0];
	                var reserveDateBegin = splitData[0]+" "+stend[0];
	                var reserveDateEnd = splitData[0]+" "+stend[1];
					param.reserveDateBegin =$("#reserveDateBegin").val();
					param.reserveDateEnd =$("#reserveDateEnd").val();
	                if(reserveDateBegin==$("#reserveDateBegin").val() && reserveDateEnd==$("#reserveDateEnd").val()){
	                    NODEB.alert("请修改预约取件时间后再提交",false);
	                    return false;
	                }
				}else{
	
	                if(param.reserveDateBegin == currentTime ){
	                    NODEB.alert("请修改预约取件时间后再提交",false);
	                    return false;
	                }
					param.reserveDateBegin =bigDateSelect.getVal()+" 00:00";
					param.reserveDateEnd =bigDateSelect.getVal()+" 00:00";
				}
				jQuery.post('/afs/updateAppointPickwareTime',param,
					function(data){
				   		if(data && data.resultCode == "1"){
							NODEB.alert("更新成功~",true)
	                        $(".canUpdate").hide();
						}else{
							NODEB.alert("预约取件时间只能修改一次!",false)
						}
			 		},
				"json");
			})
	
	
			$(".canUpdate").show();
		}
	
		function checkCanUpdateTime(){
			// 是否可用修改预约时间
			$.get("/afs/checkIfCanChangeAppointmentPickware",{
				sid:sid,
				afsServiceId:afsServiceId
			},function(data) {
				if(data && data.resultCode == "1" && data.data){
					initDate();
				}else{
					$("#showDateChange").html(currentTime);
	                $(".canUpdate").hide();
					//probDesc
				}
			},"json");
		}
	
		var currentTime = "";
	
	
	    // 判断是否为pop商家和订单状态是否为取消和审核未通过状态，不需要查询预约时间
	    if(approveResult =='60' || approveResult =='20' || isPopOpen =='true'){
	        console.log("apporve is 60 20 true");
	    }else{
	        // 展示预约时间
	        $(".probDate").show();
	        // 查询预约时间
	        $.get("/afs/getAppointPickwareTime",{
	            sid:sid,
	            afsServiceId:afsServiceId
	        },function(data) {
	            if(data && data.resultCode == "1" && data.data){
	                console.log("return time is :"+data.data);
	                if($(".c-data").length){
	                    $(".c-data").html( data.data);
	                    var splitData = data.data.split(" ")
	                    var stend = splitData[2].split("-")
	                    $("#reserveDateStr").val(splitData[0]);
	                    $("#reserveDateBegin").val(splitData[0]+" "+stend[0]);
	                    $("#reserveDateEnd").val(splitData[0]+" "+stend[1]);
	                    currentTime=data.data;
	                }else{
	                    console.log("enter into getAppointPicker else branch");
	                    currentTime = data.data.split(" ")[0];
	                }
	                checkCanUpdateTime();
	            }else{
	                $(".probDate").hide();
	            }
	        },"json");
	    }
	
	
	    // 查询审核留言
	    $.get("/afs/queryAfsServiceInfo",{
	        sid:sid,
	        serviceId:afsServiceId
	    },function(data) {
	        if(data && data.resultCode == "1" && data.data && data.data.approveNotes){
	            var approveNotes = $.trim(data.data.approveNotes);
	            console.log("审核留言："+approveNotes);
	            $('#shenhemsg').text(approveNotes);
	            $('.probDesc2').show();
	            dealDispaly();
	        }
	    },"json");
	
	    function dealDispaly(){
	        console.log("enter into the dealdiplayshenhemsg function");
	        var $element = $('.detai-list #shenhemsg');
	        var $c = $element
	                .clone()
	                .css({display: 'inline', width:'auto', visibility: 'hidden'})
	                .appendTo('#shenheId');
	        console.log("height"+$c.height());
	        console.log("height"+$element.height());
	
	        if( $c.height() <= $element.height() ) {
	            console.log('shenhe message is too long ');
	            $('#message-btn').hide();
	        }
	        $c.remove();
	    }
	
	    //$(window).resize(dealDispaly());
	
		init();
	})
	</script>
	
	<script>
	    function showHead(sid,title,link){
	        var param = new Object();
	        if(sid!=null && sid.length>0){
	            param.sid = sid;
	        }
	        if(title!=null && title.length>0){
	            param.title = title;
	        }
	        if(link!=null && link.length>0){
	            param.link = link;
	        }
	        jQuery.ajax({
	            'url':'http://m.jd.com/app/header.action?rand='+Math.random(),
	            'data':param,
	            'type':'post',
	            'success':function(data){
	                $('body').prepend(data);
	            }
	        });
	    }
	    function showFoot(sid,title,link){
	        var param = new Object();
	        if(sid!=null && sid.length>0){
	            param.sid = sid;
	        }
	        if(title!=null && title.length>0){
	            param.title = title;
	        }
	        if(link!=null && link.length>0){
	            param.link = link;
	        }
	        jQuery.ajax({
	            'url':'http://m.jd.com/app/footer.action?rand='+Math.random(),
	            'data':param,
	            'type':'post',
	            'success':function(data){
	                $('body').append(data);
	            }
	        });
	    }
	    showHead('046753ecacf07bb42a3ec5377f31bb2a','进度查询','');
	    showFoot('046753ecacf07bb42a3ec5377f31bb2a','进度查询','');
	</script>
	
	
	<style type="text/css">
	.new-footer{margin-top:10px;background-color:#f3f2f2;font-size:14px;color:#6e6e6e;text-align:center}
	.new-footer .new-f-login{position:relative;padding:0 12px;background-color:#a8a8a8;line-height:27px;color:#fff;text-align:left;heigth:27px}
	.new-footer .new-f-login .new-back-top{position:absolute;right:12px}
	.new-footer .new-f-login .new-bar2{margin:0 5px}
	.new-footer .new-f-login a{color:#fff}
	.new-footer .new-f-section a{margin-left:20px;color:#6e6e6e}
	.new-footer .new-f-section .on{color:#c30202}
	.new-footer .new-f-section a:first-child{margin-left:0}
	.new-bl{padding:0 15px}
	.new-footer .new-f-section,.new-footer .new-f-section2{padding:10px 0}
	.new-footer .new-f-section2{padding-top:0;font-size:12px;color:#6e6e6e}
	.new-f-banner{background-color:#fff}
	.new-banner-img,.new-banner-img2{width:320px;height:61px;margin:0 auto;background:url(/mobileStore/images/imgs/banner_footer.gif?v=jd2015010820);background-color:#fff}
	.new-banner-img2{background:url(/mobileStore/images/imgs/banner_footer.gif?v=jd2015010820)}
	.new-banner-img3{width:320px;height:61px;margin:0 auto;background:url(/mobileStore/images/imgs/banner_footer.gif?v=jd2015010820) 0 0 no-repeat;background-color:#fff}
	.new-download-app{display:block;width:320px;height:61px;margin:0 auto;border-bottom:1px solid #dad4cf;border-top:1px solid #fcfaf9;background-color:#fff;font-size:.875em;line-height:44px;text-align:center}
	</style>
	<footer>
		<div class="new-footer">
	    	<div class="new-f-login">
				<#if userLogin??>
					<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
				<#else>
					<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
				</#if>
				<span class="new-back-top"><a href="http://m.jd.com/showvote.html?sid=046753ecacf07bb42a3ec5377f31bb2a">反馈</a><span class="new-bar2">|</span><a href="#top">回到顶部</a></span>
	        </div>
	    	<div class="new-f-section"><a href="http://wap.jd.com/index.html?v=w&amp;sid=046753ecacf07bb42a3ec5377f31bb2a">标准版</a><a href="javascript:void(0)" class="on">触屏版</a><a onclick="skip();" href="javascript:void(0);">电脑版</a></div>
	    			<div id="clientArea">
		        	<a href="http://m.jd.com/download/downApp.html?sid=046753ecacf07bb42a3ec5377f31bb2a" id="toClient" class="openJD" style="color:#6e6e6e">客户端</a>
	        </div>
			        <div class="new-f-section2">Copyright © 2012-2015  京东JD.com 版权所有</div>
	    </div>
	</footer>
	
	
	<iframe style="display: none; width: 0px; height: 0px;"></iframe></body></html>