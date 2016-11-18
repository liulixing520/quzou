<link rel="apple-touch-icon-precomposed" href="http://m.jd.com/images/apple-touch-icon.png">
</head>

<body id="body">
	<a name="top"></a>
	<header>
		<div class="new-header">
        	<a href="javascript:pageBack();" class="new-a-back"><span>返回</span></a>
				<h2>用户中心</h2>
            <a href="javascript:void(0)" id="btnJdkey" class="new-a-jd"><span>京东键</span></a>
    	</div>
		<div class="new-jd-tab" style="display:none" id="jdkey">
        	<div class="new-tbl-type">
                <a href="main" class="new-tbl-cell">
                	<span class="icon">首页</span>
					<p style="color:#6e6e6e;">首页</p>
                </a>
                <a href="category" class="new-tbl-cell">
                	<span class="icon2">分类搜索</span>
					<p style="color:#6e6e6e;">分类搜索</p>
                </a>
                <a href="shoppingCart" id="html5_cart" class="new-tbl-cell">
                	<span class="icon3">购物车</span>
					<p style="color:#6e6e6e;">购物车</p>
                </a>
                <a href="javascript:void(0)" class="new-tbl-cell">
                	<span class="icon4 on">用户中心</span>
					<p class="on" style="color:#6e6e6e;">用户中心</p>
                </a>
            </div>
        </div>
	</header>

	<div class="common-wrapper">
		<div class="head-img">
			<span class="my-img" style="background-image:url('/mobileStore/images/imgs/defaul.png')"></span>
			<p>${userLogin.userLoginId!}</p>
			<p>用户等级</p>
		</div>
	
		<ul class="padding-list">
			<li>
				<a href="myOrders?statusId=ORDER_CREATED">
					<p id="waite4PaymentSum">${orderList3!'0'}</p>
					<p>待付款</p>
				</a>
			</li>
			<li>
				<a href="myOrders?statusId=ORDER_APPROVED">
					<p id="waitDeliveryOrderListSum">${orderList2!'0'}</p>
					<p>待收货</p>
				</a>
			</li>
			<li>
				<a href="javascript:void(0);">
					<p>
						<span id="infoCount">0</span>
						<span id="unread-msg-point"></span>
				    </p>
					<p>我的消息</p>
				</a>
			</li>
		</ul>

    	<ul class="menu-list">
			<li>
    			<a href="myOrders">
					<img src="/mobileStore/images/imgs/547bc6b5Ncc52a3b8.png" alt="">
    				<p>全部订单</p>
    			</a>
    		</li>
    		<li>
    			<a href="/portal/control/userMain">
					<img src="/mobileStore/images/imgs/547bc742N95a14876.png" alt="">
    				<p>账户管理</p>
    			</a>
    		</li>
			<li>
    			<a href="javascript:void(0);">
					<img src="/mobileStore/images/imgs/547bc6eaN6c97383c.png" alt="">
    				<p>我的关注</p>
    			</a>
    		</li>
			<li>
    			<a href="javascript:void(0);">
					<img src="/mobileStore/images/imgs/547bc70aNf7e3462a.png" alt="">
    				<p>浏览记录</p>
    			</a>
    		</li>
			<#--
			<li>
    			<a href="http://passport.m.jd.com/user/services.action?functionId=fuwuguanjia&amp;sid=eb93dd665f8a2b18e78b8032693d3bba">
					<img src="/mobileStore/images/imgs/547bc727Nde7da59c.png" alt="">
    				<p>服务管家</p>
    			</a>
    		</li>
    		<li>
    			<a href="http://passport.m.jd.com/wallet/wallet.action?functionId=wodeqianbao&amp;sid=eb93dd665f8a2b18e78b8032693d3bba">
					<img src="/mobileStore/images/imgs/547bc6dbN3dabf32a.png" alt="">
    				<p>我的钱包</p>
    			</a>
    		</li>
			<li>
    			<a href="http://passport.m.jd.com/user/preSells.action?functionId=wodeyuyue&amp;sid=eb93dd665f8a2b18e78b8032693d3bba">
					<img src="/mobileStore/images/imgs/547bc75fNc5c6209c.png" alt="">
    				<p>我的预约</p>
    			</a>
    		</li>
			<li>
    			<a href="http://m.jd.com/download/downApp.html?functionId=yingyongtuijian&amp;sid=eb93dd665f8a2b18e78b8032693d3bba">
					<img src="/mobileStore/images/imgs/547bc772Nbdf299f1.png" alt="">
    				<p>应用推荐</p>
    			</a>
    		</li>-->
    	</ul>
    	<h2 class="list-title">猜你喜欢</h2>
    	<div id="guessing" class="jd-slider-wrapper">
            <div class="jd-slider-container" style="width: 1272px; height: 486px;">
            	<ul class="tj-list">
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1054910543','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1054910543$index=0$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=1b867c31988f807aa4a605b099cabb3e392e502e');">
    						<img src="/mobileStore/images/imgs/5466e759Nb0c52bed.jpg">
            				<p>艾斯凯电子称 健康秤 精准体重秤夜光秤人体秤电子秤体重计 白色</p>
            				<p class="price">
								￥39.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('854263','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=854263$index=1$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=f10f1ae320e19d0bc6e42b8ee747dd7d5f22f536');">
    						<img src="/mobileStore/images/imgs/rBEQWFF2U64IAAAAAAJSPsL05DkAAEyYACAeDwAAlJW413.jpg">
            				<p>维达 抽纸 倍韧2层150抽面巾纸*3包</p>
            				<p class="price">
								￥13.9
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('730617','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=730617$index=2$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=9ce2647cf80055d8d75aa9601450de8781c8a0');">
    						<img src="/mobileStore/images/imgs/5412b259N21730fe2.jpg">
            				<p>意大利进口 Ferrero Collection费列罗臻品巧克力礼盒24粒装259.2g </p>
            				<p class="price">
								￥105.2
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1085104382','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1085104382$index=3$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=223f72a53d5ffe98242d406575a4750d01fac7b3');">
    						<img src="/mobileStore/images/imgs/54ae7814Nca3bdc6b.jpg">
            				<p>美锋 创意透明硬壳手机壳保护套 适用于苹果iphone5s/iphone5/ip5s 蝙蝠侠</p>
            				<p class="price">
								￥38.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1024019865','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1024019865$index=4$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=15140367ce6ebb0fd9c5c84fb3ada37a0ba43408');">
    						<img src="/mobileStore/images/imgs/549845d6N42bc7dca.jpg">
            				<p>意大利进口 费列罗巧克力心形礼盒 金莎/朗慕 一生一世DIY礼盒27颗装 节日礼物</p>
            				<p class="price">
								￥99.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1033419537','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1033419537$index=5$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=f46d03d56fb0a9fa07b341217ef57323642a99de');">
    						<img src="/mobileStore/images/imgs/543b9e03Nc6320ee9.jpg">
            				<p>迪士尼运动袜 迪士尼米奇儿童袜子纯棉小孩卡通宝宝全棉 男款六双款式搭配发  M号6-8岁/18-20cm</p>
            				<p class="price">
								￥39.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1133516131','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1133516131$index=6$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=7d8b80652d526c69eb4b721a700696ee244dffc1');">
    						<img src="/mobileStore/images/imgs/5482bebfN64d0651e.jpg">
            				<p>浪莎langsha童装女童内裤彩色圆点纯棉印花可爱三角裤 舒适内裤七条装  NK008组合色七条装 S建议身高85-95cm</p>
            				<p class="price">
								￥49.9
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('971035','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=971035$index=7$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=c8fdcc599293ca4fcad5c9f9f67629922772a3d9');">
    						<img src="/mobileStore/images/imgs/rBEhVFJVDOIIAAAAAACtOX2qfBEAAD7zAKPmLwAAK1R858.jpg">
            				<p>360官方出品 360随身WiFi 2 （设置超简单，超便捷的无线路由器）  白色</p>
            				<p class="price">
								￥19.9
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1086585735','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1086585735$index=8$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=41a1fbddc500b01418c9ba238cf616658a417704');">
    						<img src="/mobileStore/images/imgs/538f20c7Ne812006b.jpg">
            				<p>浪莎(langsha)童装新款女童打底裤儿童裤时尚连裤袜多色可选 lw011 人偶白色LW011 L(115-135)</p>
            				<p class="price">
								￥15.9
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1019996616','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1019996616$index=9$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=1359cccffbc9d638734f2e823a3ee2ad68e45eb7');">
    						<img src="/mobileStore/images/imgs/538437dbN215d9b10.jpg">
            				<p>礼无忧 趴趴熊音乐枕头抱枕大号毛绒男送女友老婆 生日礼物 创意礼品 女生实用情人节小礼物</p>
            				<p class="price">
								￥99.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1162812','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1162812$index=10$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=2a6ef57cbdf1190eed942de3f5cb912add4dd74e');">
    						<img src="/mobileStore/images/imgs/549cfd52N23388a5d.jpg">
            				<p>香山（CAMRY）EB8504H 电子称 人体称 称重健康秤 圆形</p>
            				<p class="price">
								￥88.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1082269','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1082269$index=11$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=5c9a4fa7c93a35cad6e0faaa7c3ab5ad2ee61d8');">
    						<img src="/mobileStore/images/imgs/rBEhVFMipvIIAAAAAAE7DBit1sgAAKGUwL3lRwAATsk209.jpg">
            				<p>清风（APP） 抽取式面巾纸 超质感 2层150抽4包</p>
            				<p class="price">
								￥14.9
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1013756796','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1013756796$index=12$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=8590d198ce8d28851e4f706a1cad7c569f4b6311');">
    						<img src="/mobileStore/images/imgs/rBEhVlJg1hUIAAAAAAY6mRP1rpYAAEVhAK7-Q0ABjqx358.jpg">
            				<p>顺丰快递德芙DOVE丝滑巧克力礼盒心语心印装抽屉盒送公仔一对 情人节生日新年礼物 送女友 </p>
            				<p class="price">
								￥99.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1301638669','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1301638669$index=13$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=c59dd251521f9dad50c1af0a247e29bc354b5b60');">
    						<img src="/mobileStore/images/imgs/5414f5e3Nff309103.jpg">
            				<p>摩森 升级版防滑皮纹彩绘手机壳保护套外壳配件卡通 适用于苹果iPhone5s/5 炫小酷(两件减10元)</p>
            				<p class="price">
								￥29.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1030434355','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1030434355$index=14$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=9c21da424b63c10d24357ff64cfde110d4dc8cb9');">
    						<img src="/mobileStore/images/imgs/5434a471N13fa9af5.jpg">
            				<p>费列罗进口巧克力DIY心形礼盒18粒【顺丰配送】【代写贺卡】情人节生日送礼温情礼物</p>
            				<p class="price">
								￥88.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1014713076','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1014713076$index=15$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=36c1e62b3e14822d733dcfee3b4cd9794ee3ad87');">
    						<img src="/mobileStore/images/imgs/rBEGF1DpHtcIAAAAAAPkvaEWycEAABOngH_O5MAA-TV329.jpg">
            				<p>樱桃小丸子儿童袜子棉袜童袜男童运动袜（16-24适合2-12岁（6双体验装）颜色、款式随机 18-20(4-6岁)</p>
            				<p class="price">
								￥41.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1082263','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1082263$index=16$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=9b725a7777c212ba8bffaf8d5ae736167dcc54fd');">
    						<img src="/mobileStore/images/imgs/5420e71eN05b7c53c.jpg">
            				<p>维达抽纸 超韧3层150抽面巾纸*24包（中规格） 整箱销售</p>
            				<p class="price">
								￥78.9
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1082266','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1082266$index=17$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=4c4e0e91fbc1060aa917f28c55bf99a53c3d8329');">
    						<img src="/mobileStore/images/imgs/5420e730Nca69f80e.jpg">
            				<p>维达卫生纸 蓝色经典3层200g卷纸*27卷（整箱销售）</p>
            				<p class="price">
								￥79.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1003054','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1003054$index=18$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=dd54e09156963ee51c6e7fe5d3a14216689e77e0');">
    						<img src="/mobileStore/images/imgs/rBEhWlJzZR8IAAAAAAEVzEU-jWUAAE3kwPR0tEAARXk217.jpg">
            				<p>清风（APP） 卷筒卫生纸 原木纯品 3层260段</p>
            				<p class="price">
								￥23.9
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1006595372','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1006595372$index=19$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=34d2f053d7d657cd636fb71d909b2e87e9ab6611');">
    						<img src="/mobileStore/images/imgs/54a0f6d6Nb268c03f.jpg">
            				<p>礼意久久 情人节礼物趴趴熊音乐抱枕【大号】跨年礼品 创意礼品 生日女实用小礼物 毛绒公</p>
            				<p class="price">
								￥99.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('546456','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=546456$index=20$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=c2cf031127f38f0e1b224dd5480c6931efffeb72');">
    						<img src="/mobileStore/images/imgs/rBEbSFNp_gIIAAAAAAQ0H6t0IGIAAAGyQL14WAABDQ3467.jpg">
            				<p>香山 （CAMRY）EB875J 健康美体称 体重秤 粉色</p>
            				<p class="price">
								￥69.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1031135','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1031135$index=21$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=d82d782ddd3a7239cdcd844cf6c40edfad499e4d');">
    						<img src="/mobileStore/images/imgs/rBEhWlLCZ1oIAAAAAAFNEb_ifRsAAHccgECZpkAAU0p375.jpg">
            				<p>维达 厨房湿巾 40片装</p>
            				<p class="price">
								￥17.9
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1425974625','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1425974625$index=22$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=c94e9b99fce3773775765d6bdd5406a74df96eb2');">
    						<img src="/mobileStore/images/imgs/5493f3f0N79f2f0d4.jpg">
            				<p>美锋 创意透明手机壳保护套 适用于苹果5/iphone5/5S 励志男</p>
            				<p class="price">
								￥38.0
            				</p>
            			</a>
        			</li>
        			<li style="width: 106px;" class="jd-slider-item">
    					<a href="javascript:void(0);" onclick="showProductDetail('1311002074','eb93dd665f8a2b18e78b8032693d3bba','http://mercury.jd.com/log.gif?t=rec.320000&amp;v=src=rec$action=1$reqsig=7d84b6330002c9e84ab5fcb178c1a44ddef60454$enb=1$sku=0$csku=1311002074$index=23$expid=0&amp;rid=2993970716315838280&amp;ver=1&amp;sig=7813f1892f76952d3f96e4e7378d438d90e91a9c');">
    						<img src="/mobileStore/images/imgs/541cdfd8N1a1e6b1f.jpg">
            				<p>渔夫之宝 柑桔西柚味特强润喉糖 25g 英国进口</p>
            				<p class="price">
								￥12.0
            				</p>
            			</a>
        			</li>
            	</ul>
    		</div>
    	</div>
	</div>
	<link rel="stylesheet" type="text/css" href="/mobileStore/images/css/guessing.css" charset="utf-8">
	
	<script type="text/javascript" src="/mobileStore/images/js/jdslider.js"></script>
	<script type="text/javascript" src="/mobileStore/images/js/jquery.js"></script>
	<script type="text/javascript" src="/mobileStore/images/js/news1.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			showHeadInfo();
		
		    $('#guessing').jdSlider({
		        lineNum:2,
		        fitToScreen:true
		    });
		});
		//显示头信息
		var showHeadInfo = function(){
			var t = (new Date()).valueOf();
			jQuery.get('/myJd/showHeadInfo.json?t=' + t,
				{},
		        function(data){
					if(data){
		    			var waite4PaymentSum = data.waite4PaymentSum;
		    			var waitDeliveryOrderListSum = data.waitDeliveryOrderListSum;
		    			var infoCount = data.infoCount;
						
						$('#waite4PaymentSum').html(waite4PaymentSum);
						$('#waitDeliveryOrderListSum').html(waitDeliveryOrderListSum);
						$('#infoCount').html(infoCount);
						
						/*
						if(infoCount > 0){
							$('#unread-msg-point').addClass('unread-msg');
						}else{
							$('#unread-msg-point').removeClass('unread-msg');
						}
						*/
					}
			 },'json');
		}
		
		//显示商品详情
		var showProductDetail = function(wareId,sid,clk){
			//埋点 猜猜你喜欢
			jQuery.get('/myJd/loveProductDetail.json',
				{ 'wareId': wareId , 'sid' : sid, 'clk' : clk},
		        function(data){
		     		var url = 'http://m.jd.com/product/' + wareId + '.html?resourceType=recommend_productDetail&resourceValue=&sid=' + sid;
					window.location.href = url;
			 });
		}
	
	</script>

    <footer>
		<div class="login-area" id="footer">
        	<div class="login">
            	<#if userLogin??>
					<a rel="nofollow" href="memberCenter">${(userLogin.userLoginId)!'---'}</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="logout">退出</a>
				<#else>
					<a rel="nofollow" href="login">登录</a><span class="layout-lg-bar">|</span><a rel="nofollow" href="register">注册</a>
				</#if>
				<span class="new-fr"><a href="http://m.jd.com/showvote.html?sid=eb93dd665f8a2b18e78b8032693d3bba">反馈</a><span class="lg-bar">|</span><a href="#top">回到顶部</a></span>
            </div>
        	<div class="version"><a href="http://m.jd.com/index.html?v=w&amp;sid=eb93dd665f8a2b18e78b8032693d3bba">标准版</a><a href="javascript:void(0)" class="on">触屏版</a><a href="http://www.jd.com/" id="toPcHome">电脑版</a></div>
            <div class="copyright">© medref.cn </div>
        </div>
    </footer>
    <div style="display:none;">
    	<img src="/mobileStore/images/imgs/ja.gif">
    </div>
	<script type="text/javascript" src="/mobileStore/images/js/pingJS.js"></script>
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
		//	syncCart('eb93dd665f8a2b18e78b8032693d3bba',true);
			location.href='http://m.jd.com/cart/cart.action';
		});
		
		function reSearch(){
		var depCity = window.sessionStorage.getItem("airline_depCityName");
			if(testSessionStorage() && isNotBlank(depCity) && !/^\s*$/.test(depCity) && depCity!=""){
		    	var airStr = '<form action="/airline/list.action" method="post" id="reseach">'
		        +'<input type="hidden" name="sid"  value="eb93dd665f8a2b18e78b8032693d3bba"/>'
		        +'<input type="hidden" name="depCity" value="'+ window.sessionStorage.getItem("airline_depCityName") +'"/>'
		        +'<input type="hidden" name="arrCity" value="'+ window.sessionStorage.getItem("airline_arrCityName") +'"/>'
		        +'<input type="hidden" name="depDate" value="'+ window.sessionStorage.getItem("airline_depDate") +'"/>'
		        +'<input type="hidden" name="depTime" value="'+ window.sessionStorage.getItem("airline_depTime") +'"/>'
		        +'<input type="hidden" name="classNo" value="'+ window.sessionStorage.getItem("airline_classNo") +'"/>'
		        +'</form>';
		    	$("body").append(airStr);
		    	$("#reseach").submit();
			}else{
		    	window.location.href='http://m.jd.com/airline/index.action?sid=eb93dd665f8a2b18e78b8032693d3bba';
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