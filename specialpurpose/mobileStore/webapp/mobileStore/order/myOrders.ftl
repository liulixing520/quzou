<link rel="apple-touch-icon-precomposed" href="/mobileStore/images/imgs/apple-touch-icon.png">
<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
			<a href="javascript:pageBack();" class="new-a-back"><span>返回</span></a>
			<h2>全部实物订单</h2>
			<a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
		</div>
		<div class="new-jd-tab" style="display:none" id="jdkey">
			<div class="new-tbl-type">
				<a href="http://m.jd.com/index.html?sid=e830beda275396f1cae8bd184e257a05" class="new-tbl-cell">
					<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
				</a>
				<a href="http://m.jd.com/category/all.html?sid=e830beda275396f1cae8bd184e257a05" class="new-tbl-cell">
					<span class="icon2">分类搜索</span>
					<p style="color:#6e6e6e;">分类搜索</p>
				</a>
				<a href="javascript:void(0)" id="html5_cart" class="new-tbl-cell">
					<span class="icon3">购物车</span>
					<p style="color:#6e6e6e;">购物车</p>
				</a>
				<a href="http://passport.m.jd.com/user/home.action?sid=e830beda275396f1cae8bd184e257a05" class="new-tbl-cell">
					<span class="icon4 on">用户中心</span>
					<p style="color:#6e6e6e;" class="on">用户中心</p>
				</a>
			</div>
		</div>
	</header>
	
	<div class="wrap">	
		<input type="hidden" id="page" value="1">
		<section class="order-con">
		<ul class="order-list" id="orders_list">
			<#if orderHeaderList??>
                <#list orderHeaderList as orderHeader>
                	<#assign status = orderHeader.getRelatedOne("StatusItem", true) />
                    <#assign orderItems = orderHeader.getRelated("OrderItem", null, ["orderItemSeqId"], false) />
                    <#assign product = orderItems[0].getRelatedOne("Product", true)?if_exists/>
                    <#assign productStore = delegator.findOne("ProductStore", {"productStoreId" : (product.primaryProductStoreId)!''}, true)?if_exists/>
		        	<#assign smallImageUrl = product.smallImageUrl?if_exists>
		        	<#if !smallImageUrl?string?has_content><#assign smallImageUrl = "/mobileStore/images/imgs/53cf721bN254a8804.jpg"></#if>
					<li>
						<div class="order-box">
							<a class="new-mu_l2a new-p-re" href="orderDetail?orderId=${orderHeader.orderId!}">
								<div class="order-msg">
									<img src="${smallImageUrl!}">
									<div class="order-msg">
										<p class="title">${(product.internalName)!(product.productNameZh)!(product.productNameRu)!}</p>
										<p class="price"><@ofbizCurrency amount=orderHeader.grandTotal isoCode=orderHeader.currencyUom /><span></span></p>
										<p class="order-data">${orderHeader.orderDate.toString()}</p>
									</div>
								</div>
							</a>
							<#if orderHeader.statusId == "ORDER_CREATED">
								<div class="pay-order"><a href="payOrder?orderId=${orderHeader.orderId!}">在线支付</a></div>&nbsp;
								<div class="pay-order"><a href="orderCancel?orderId=${orderHeader.orderId!}">取消订单</a></div>
							<#elseif orderHeader.statusId != "ORDER_CANCELLED" >
								<div class="pay-order"><a href="javascript:void(0);">订单跟踪</a></div>&nbsp;
								<div class="pay-order"><a href="javascript:void(0);">返修/退换货</a></div>
							<#else>
								<div class="pay-order"><a href="orderDetail?orderId=${orderHeader.orderId!}">查看订单</a></div>
							</#if>
						</div>
					</li>
				</#list>
			</#if>
			<#--
			<li>
			<div class="order-box">
			<a class="new-mu_l2a new-p-re" href="http://m.jd.com/user/oneorderdetail.action?orderId=8201122222&passKey=630dbe538019be774bcba147042bc88a&sid=e830beda275396f1cae8bd184e257a05">
			<div class="order-msg">
			<img src="/mobileStore/images/imgs/rBEhWFHeTncIAAAAAAFnJo4obkoAAA8lwGCBVAAAWc-811.jpg">
			<div class="order-msg">
			<p class="title"> 维达 卫生纸 超韧4层180g卷纸*10卷 </p>
			<p class="price">¥34.40<span></span></p>
			<p class="order-data">2015-01-18 11:44:37</p>
			</div>
			</div>
			</a>
			<div class="pay-order"><a href="https://pay.m.jd.com/pay/pay.action?orderId=8201122222&orderKind=0&sid=e830beda275396f1cae8bd184e257a05">在线支付</a></div>
			</div>
			</li>
			<li>
			<div class="order-box">
			<a class="new-mu_l2a new-p-re" href="http://m.jd.com/user/oneorderdetail.action?orderId=1708454030&passKey=b854a60b0927d8c684e2ebd05f8f7dfb&sid=e830beda275396f1cae8bd184e257a05">
			<div class="order-msg">
			<img src="/mobileStore/images/imgs/54349343Nfcc68358.jpg">
			<div class="order-msg">
			<p class="title"> 费列罗进口巧克力DIY心形礼盒27粒【顺丰包邮】【代写贺卡】送礼生日礼物创意礼品 </p>
			<p class="price">¥157.80<span></span></p>
			<p class="order-data">2014-07-31 11:41:30</p>
			</div>
			</div>
			</a>
			<div class="pay-order"><a href="http://m.jd.com/user/orderTracking.action?orderId=1708454030&passKey=b854a60b0927d8c684e2ebd05f8f7dfb&sid=e830beda275396f1cae8bd184e257a05">订单跟踪</a></div>&nbsp;
			<div class="pay-order"><a href="http://m.mrd.jd.com/afs/orders?orderId=1708454030&sid=e830beda275396f1cae8bd184e257a05">返修/退换货</a></div>
			</div>
			</li>
			<li>
			<div class="order-box">
			<a class="new-mu_l2a new-p-re" href="http://m.jd.com/user/oneorderdetail.action?orderId=1689173688&passKey=460676bcd37ce186fbfb98d429646186&sid=e830beda275396f1cae8bd184e257a05">
			<div class="order-msg">
			<img src="/mobileStore/images/imgs/5382afb4Nc9c38cff.jpg">
			<div class="order-msg">
			<p class="title"> 陶之念 景德镇陶瓷储物罐 咸鸭蛋 泡菜 泡椒 腌菜 泡菜坛子 密封罐 荷花 中号 </p>
			<p class="price">¥80.00<span></span></p>
			<p class="order-data">2014-07-26 09:16:35</p>
			</div>
			</div>
			</a>
			<div class="pay-order"><a href="http://m.jd.com/user/orderTracking.action?orderId=1689173688&passKey=460676bcd37ce186fbfb98d429646186&sid=e830beda275396f1cae8bd184e257a05">订单跟踪</a></div>&nbsp;
			<div class="pay-order"><a href="http://m.mrd.jd.com/afs/orders?orderId=1689173688&sid=e830beda275396f1cae8bd184e257a05">返修/退换货</a></div>
			</div>
			</li>
			<li>
			<div class="order-box">
			<a class="new-mu_l2a new-p-re" href="http://m.jd.com/user/oneorderdetail.action?orderId=1197200608&passKey=0dc17f850861ae5007fe22e0845ffb75&sid=e830beda275396f1cae8bd184e257a05">
			<div class="order-msg">
			<img src="/mobileStore/images/imgs/rBEbRlN9kY4IAAAAAAFMrsEqLD0AACQgwOW4ZYAAUzG875.jpg">
			<div class="order-msg">
			<p class="title"> 三星(Samsung)16G  Class10-48MB/S  TF(MicroSD) 存储卡 </p>
			<p class="price">¥130.90<span></span></p>
			<p class="order-data">2014-03-17 11:32:26</p>
			</div>
			</div>
			</a>
			<div class="pay-order"><a href="http://m.jd.com/user/orderTracking.action?orderId=1197200608&passKey=0dc17f850861ae5007fe22e0845ffb75&sid=e830beda275396f1cae8bd184e257a05">订单跟踪</a></div>&nbsp;
			<div class="pay-order"><a href="http://m.mrd.jd.com/afs/orders?orderId=1197200608&sid=e830beda275396f1cae8bd184e257a05">返修/退换货</a></div>
			</div>
			</li>
			-->
		</ul>
		<div id="spinner" class="new-spinner" style="margin-left: 420px;"></div>
		<div class="new-load-more" style="text-align:center;" id="con_more"><span style="font-size:12px;">加载更多</span></div>
		
		</section>
	</div>
	
	
	<script type="text/javascript">
	
	$(function(){
		var spinner = createSpinner();
		var screenWidth = parseInt(document.body.clientWidth);
		$("#spinner").css("margin-left",(screenWidth/2-50)+"px");
		$(window).resize(function() {
	       var screenWidth = parseInt(document.body.clientWidth);
		   $("#spinner").css("margin-left",(screenWidth/2-50)+"px");
	    });
	    //加载更多
	    $("#con_more").click(function(){
	        $(this).hide();
	        $("#spinner").show();
	        spinner.spin($("#spinner")[0]);
	        var nextPage = parseInt($('#page').val())+1;
	        $('#page').val(nextPage);
	        jQuery.post('/user/userAllOrderList.json?sid=e830beda275396f1cae8bd184e257a05',{page:nextPage},function(data){
	             spinner.stop();
	             $("#spinner").hide();
	             $("#con_more").show();
	            jQuery.each(data.orders,function(i,order){
					var chooseUrl ='http://m.jd.com/user/oneorderdetail.action?orderId={orderId}&passKey={passKey}&sid=e830beda275396f1cae8bd184e257a05';
					var toOrderTrackingUrl = 'http://m.jd.com/user/orderTracking.action?orderId={orderId}&passKey={passKey}&sid=e830beda275396f1cae8bd184e257a05';
				 	chooseUrl = chooseUrl.replace('{orderId}',order.orderId);
				 	toOrderTrackingUrl = toOrderTrackingUrl.replace('{orderId}',order.orderId);
				 	var passKey = data.passKeyList[i];	 
                 	var content ='<li>'+
						'<a class="new-mu_l2a new-p-re"    href="'+chooseUrl.replace('{passKey}',passKey)+'" >'+
						'<div class="order-box">'+
							'<div class="order-msg">'+
								'<img src="'+order.imgPath.replace("/n5/","/n7/")+'">'+
								'<div class="order-msg">'+
									'<p class="title">'+order.orderMsg.wareInfoList[0].wname+'</p>'+
									'<p class="price">&yen;'+order.price+'<span></span></p>'+
									'<p class="order-data">'+order.dataSubmit+'</p>'+
								'</div>'+
							'</div>'+
						'</a>';
					if(order.paymentType==4 && order.orderStatus=="等待付款" && order.orderType != 17){
						var toPayUrl = 'https://pay.m.jd.com/pay/pay.action?orderId={orderId}&orderKind=0&sid=e830beda275396f1cae8bd184e257a05'
						if((data.zc_payopen && order.sendPay.substring(9,10)=="4") || (data.pg_payopen && order.sendPay.substring(9,10)=="2")){
							content += '<div  class="pay-order"> '
								+'<a  href="'+toOrderTrackingUrl.replace('{passKey}',passKey)+'"> '
									+'订单跟踪'
								+'</a> '
                              +' </div>&nbsp;'
						}else{
							content += '<div  class="pay-order"> '+
								'<a  href="'+toPayUrl.replace('{orderId}',order.orderId)+'"> '+
									'在线支付'+
								'</a> '+
						   	' </div>';
						}
					}else if( order.paymentType==2 && order.orderStatus=="等待付款"){
						var toPostUrl = 'http://m.jd.com/user/postdetail.action?orderId={orderId}&sid=e830beda275396f1cae8bd184e257a05'
						if((data.zc_payopen && order.sendPay.substring(9,10)=="4") || (data.pg_payopen && order.sendPay.substring(9,10)=="2")){
							content += '<div  class="pay-order"> '
								+'<a  href="'+toOrderTrackingUrl.replace('{passKey}',passKey)+'"> '
									+'订单跟踪'
								+'</a> '
                          	+' </div>&nbsp;'
						}else{
							content +=  '<div  class="pay-order"> '+
								'<a  href="'+toPostUrl.replace('{orderId}',order.orderId)+'"> '+
									'邮局汇款确认'+
								'</a> '+
						 	' </div>';
						}
					}
					else{
						var repairUrl = 'http://m.mrd.jd.com/afs/repairProducts?orderId={orderId}&sid=e830beda275396f1cae8bd184e257a05';
						repairUrl = repairUrl.replace('{orderId}',order.orderId);
						
						var SurveyUrl = 'http://m.jd.com/user/getSurveyById.action?orderId={orderId}&orderType=0&sid=e830beda275396f1cae8bd184e257a05';
						SurveyUrl = SurveyUrl.replace('{orderId}',order.orderId);
						if(order.confirmGoods){
							content += '<div  class="pay-order"> '+
												'<a  href="'+toOrderTrackingUrl.replace('{passKey}',passKey)+'"> '+ 
													'订单跟踪'+
												'</a> '+
									  ' </div> &nbsp;'+
									  '<div  class="pay-order"> '+
												'<a  onclick="confirmGoods('+order.orderId+')" href="javascript:void(0);"> '+
													'确认收货'+
												'</a> '+
                                     ' </div>&bsp;';
						}
						else  if( order.orderStatus=="完成" )   {
							content += '<div  class="pay-order"> '
												+'<a  href="'+toOrderTrackingUrl.replace('{passKey}',passKey)+'"> '
													+'订单跟踪'
												+'</a> '
                                      +' </div>&nbsp;'
									  if(data.afsUse){
									  	 if(data.serviceopen && order.sendPay.substring(39,40)=="1"){
										 }else{
					                 		 content += '<div  class="pay-order"><a href="'+repairUrl+'">返修/退换货</a></div>'
										 }
									  }
						}else{
						    content += '<div  class="pay-order"> '
												+'<a  href="'+toOrderTrackingUrl.replace('{passKey}',passKey)+'"> '
													+'订单跟踪'
												+'</a> '
                                      +' </div>&nbsp;'		
						
						
						}
						
					}
				content += '</div>'+
        		'</li>';
				
				
				$('.order-list').append(content);
	            });
	        });
	    });
	});
	
	
	function confirmGoods(orderId){
		if(confirm("是否确认收货")){
			jQuery.get(
				'http://m.jd.com/user/confirmGoods.json?sid=e830beda275396f1cae8bd184e257a05',
				{"orderId":orderId},
				function(data){
	                alert(data.message);
					location.reload(true);
				},"json");
		}
		else{
			return false;
		}
	}
	
	$(".confirmGoods").click(function(){
		if(confirm("是否确认收货")){
			var can=$(".confirmGoods").index($(this));
			jQuery.get(
				'http://m.jd.com/user/confirmGoods.json?sid=e830beda275396f1cae8bd184e257a05',
				{"orderId":$(this).attr("val")},
				function(data){
	              	alert(data.message);
					location.reload(true);
				},"json");
		}
		else{
			return false;
		}
	});
	
	$(window).unload(function(){
	  $('#page').val("1");
	});
	
	</script>
	
	<footer>
		<div class="login-area" id="footer">
			<div class="login">
				<#if userLogin??>
					<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
				<#else>
					<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
				</#if>
				<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=e830beda275396f1cae8bd184e257a05">反馈</a><span class="lg-bar">|</span><a href="http://passport.m.jd.com/user/userAllOrderList.action?sid=e830beda275396f1cae8bd184e257a05#top">回到顶部</a></span>
			</div>
			<div class="version"><a href="http://m.jd.com/index.html?v=w&sid=e830beda275396f1cae8bd184e257a05">标准版</a><a href="javascript:void(0)" class="on">触屏版</a><a href="http://www.jd.com/" id="toPcHome">电脑版</a></div>
			<div class="copyright">© medref.cn</div>
		</div>
	</footer>
	<div style="display:none;">
		<img src="/mobileStore/images/imgs/ja.jsp">
	</div>
	
	<script type="text/javascript" src="/mobileStore/images/js/pingJS.1.0.js"></script>
	<script type="text/javascript">
		pingJS( {"pin":"242991761-26336401"} );
	</script>
	<script type="text/javascript">
		$("#unsupport").hide();
		if(!testLocalStorage()){ //not support html5
		    if(0!=0 && !$clearCart && !$teamId){
				$("#html5_cart_num").text(0>0>0);
			}
		}else{
			updateToolBar('');
		}
		
		$("#html5_cart").click(function(){
		//	syncCart('e830beda275396f1cae8bd184e257a05',true);
			location.href='http://m.jd.com/cart/cart.action';
		});
		
		function reSearch(){
		var depCity = window.sessionStorage.getItem("airline_depCityName");
			if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
		    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
		        +'<input type="hidden" name="sid"  value="e830beda275396f1cae8bd184e257a05"/>'
		        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
		        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
		        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
		        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
		        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
		        +'</form>';
		    	$("body").append(airStr);
		    	$("#reseach").submit();
			}else{
		    	window.location.href='http://m.jd.com/airline/index.action?sid=e830beda275396f1cae8bd184e257a05';
			}
		}
	 	//banner 关闭点击
	    $('.div_banner_close').click(function(){
	        $('#div_banner_header').unbind('click');
	        jQuery.post('/index/addClientCookieVal.json',function(d){
	              $('#div_banner_header').slideUp(500);
	        });
	    });
	    //banner 下载点击
	    $('.div_banner_download').click(function(){
	         var downloadUrl = $(this).attr('url');
	         jQuery.post('http://m.jd.com/index/addClientCookieVal.json',function(d){
	               window.location.href=downloadUrl;
	        });
	    });
	</script>
</body>