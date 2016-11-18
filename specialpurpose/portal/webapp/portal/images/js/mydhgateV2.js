//var fixedPosition=function(a){this.SetOptions(a);this.IE6=$.browser.version=='6.0'&&$.browser.msie;this.timer=null;this.Init()};fixedPosition.prototype={SetOptions:function(a){this.options={researchId:'researchEntrance',researchContent:null,targetElement:'colRight'};$.extend(this.options,a||{})},Init:function(){$('body').append('<div id="'+this.options.researchId+'" class="h-research">'+this.options.researchContent+'</div>');this.researchEntrance=$('#'+this.options.researchId);this.targetElement=$('#'+this.options.targetElement);this.SetLocation()},GetSize:function(){this.tScroll=$(window).scrollTop();this.lScroll=$(window).scrollLeft();this.tWidth=this.targetElement.width();this.tOffsetLeft=this.targetElement.offset().left;this.tOffsetTop=this.targetElement.offset().top},SetLocation:function(){if(this.timer){clearTimeout(this.timer)}var a=this,x_final,y_final;this.GetSize();x_final=this.tOffsetLeft+this.tWidth+5;if(!this.IE6){y_final=this.tOffsetTop}else{y_final=this.tOffsetTop+this.tScroll}this.researchEntrance.css({top:y_final,left:x_final});this.timer=setTimeout(function(){a.SetLocation()},50)}};
function getOrderInfo() {
	
	jQuery.ajax({
   		type: "POST",
   		url: "/mycenter/ajax.do?act=getOrderInfo&isblank=true",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	var apply = data.apply;
	    	var payout = data.payout;
	    	var waitdelivery = data.waitdelivery;
	    	var dispute = data.dispute;
	    	var nopay = data.nopay;
	    	var sellerstore = data.sellerstore;
	    	var b_account = data.b_account ;
	    	var thisDayNum = data.thisDayNum ;
	    	if (flag) {	
				if(sellerstore == "0"){
					$("#sellerstoreid").show();
				}
				//虚拟账户
				if(b_account == "1"){
					$("#b_accountid").show();
				}
     		} 
	    },
	    error: function (data, status, e) {
       	}
	    
	});
	
	jQuery.ajax({
   		type: "POST",
   		//url: "/mycenter/ajax.do?act=getOrderInfo&isblank=true",
   		url: "/sellerordmng/orderList/getSummaryOrderStat.do",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	var apply = data.apply;
	    	var payout = data.payout;
	    	var waitdelivery = data.waitdelivery;
	    	var dispute = data.dispute;
	    	var nopay = data.nopay;
	    	var sellerstore = data.sellerstore;
	    	var b_account = data.b_account ;
	    	var thisDayNum = data.thisDayNum ;
	    	if (flag) {
	    		if(thisDayNum > 0){
					$("#thisdayId").html("<a href='/sellerordmng/orderList/list.do?params.linkType=105' >今日新订单<span class='number-link'>("+thisDayNum+")</span></a>");
					$("#thisdayId").addClass("hold-data");
				}
	    		
				if(apply > 0){
					$("#applyid").html("<a href='/sellerordmng/orderList/list.do?params.linkType=106' >可请款<span class='number-link'>("+apply+")</span></a>");
					$("#applyid").addClass("hold-data");
				}
				
				if(payout > 0){
					$("#payoutid").html("<a href='/sellerordmng/orderList/list.do?params.linkType=108' >已入账<span class='number-link'>("+payout+")</span></a>");
					$("#payoutid").addClass("hold-data");
				}
				if(waitdelivery >0){
					$("#waitdeliveryid").html("<a href='/sellerordmng/orderList/list.do?params.linkType=102' >待发货<span class='number-link'>("+waitdelivery+")</span></a><img src='http://image.dhgate.com/2008/web20/seller/img/urgent.gif' style='cursor:hand' title='您有需紧急处理的订单'/>");
					$("#waitdeliveryid").addClass("hold-data");
				}
				if(dispute > 0){
					$("#disputeid").html("<a href='/sellerordmng/orderList/disputeOrderList.do?params.linkType=200' >纠纷中<span class='number-link'>("+dispute+")</span></a>");
					$("#disputeid").addClass("hold-data");
				}
				if(nopay > 0){
					$("#nopayid").html("<a href='/sellerordmng/orderList/list.do?params.linkType=101' >未付款<span class='number-link'>("+nopay+")</span></a>");
					$("#nopayid").addClass("hold-data");
				}
     		} 
	    },
	    error: function (data, status, e) {
       	}
	    
	});
	
	
}
function getMarketInfo() {
	jQuery.ajax({
   		type: "POST",
   		url: "/mycenter/ajax.do?act=getMarketInfo&isblank=true",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	if (flag) {	
	//    		var trafficbus = data.trafficbus;
	//    		var promo = data.promo;
	//    		var union = data.union;
				var gold = data.gold;
	//			if( trafficbus >0 ){
	//				$("#trafficbus").html("<a href='http://seller.dhgate.com/marketweb/trafficbus/pageload.do?dhpath=10004,33'>流量快车位剩余<span>(" + trafficbus + ")</span></a>");
//				}
	//			if(promo > 0){
	//				$("#promo").html("<a href='http://seller.dhgate.com/promoweb/platformacty/actylist.do?ptype=1&dhpath=10004,30,30'>可参加的促销活动<span>(" + promo + ")</span></a>");
	//			}
				if(gold){
					$("#gold").css('display','block'); 
				} else {
					$("#gold").css('display','none'); 
				}
     		}
	    },
	    error: function (data, status, e) {
       	}
	});
}
function getProductVaildday3R7() {
	jQuery.ajax({
   		type: "POST",
   		url: "/mycenter/ajax.do?act=getProductVaildday3R7&isblank=true",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	var productvailddaynum = data.productnum;
	    	if (flag) {
				if(productvailddaynum > 0){
					$("#productvailddaynumid").html("<a href='/prodmanage/shelf/prodShelf.do?prodShelfForm.vaildday=3' >3天内将过期<span class='number-link'>(" + productvailddaynum + ")</span></a>");
					$("#productvailddaynumid").addClass("hold-data");
				}
     		} 
	    },
	    error: function (data, status, e) {
       	}
	    
	});
}

function getProductVaildday30() {
	jQuery.ajax({
   		type: "POST",
   		url: "/mycenter/ajax.do?act=getProductVaildday30&isblank=true",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	var productvailddaynum1 = data.productnum;
	    	if (flag) {
				if(productvailddaynum1 > 0){
					$("#productvailddaynum1id").html("<a href='/prodmanage/downshelf/prodDownShelf.do?downShelfForm.withdrawaltype=2&downShelfForm.expiredDays=30' >30天内已过期<span class='number-link'>(" + productvailddaynum1 + ")</span></a>");
					$("#productvailddaynum1id").addClass("hold-data");
				}
     		} 
	    },
	    error: function (data, status, e) {
       	}
	    
	});
}

function getProductTS() {
	jQuery.ajax({
   		type: "POST",
   		url: "/mycenter/ajax.do?act=getProductTS&isblank=true",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	var productbrandcomplainnum = data.productnum;
	    	if (flag) {
				if(productbrandcomplainnum > 0){
					$("#productbrandcomplainnumid").html("<a href='/prodmanage/audit/prodBrandComplaint.do' >被品牌商投诉<span class='number-link'>(" + productbrandcomplainnum + ")</span></a>");
					$("#productbrandcomplainnumid").addClass("hold-data");
				}
     		} 
	    },
	    error: function (data, status, e) {
       	}
	    
	});
}

function getProductXJ() {
	jQuery.ajax({
   		type: "POST",
   		url: "/mycenter/ajax.do?act=getProductXJ&isblank=true",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	var productwithdrawaltypenum = data.productnum;
	    	if (flag) {
				if(productwithdrawaltypenum > 0){
					$("#productwithdrawaltypenumid").html("<a href='/prodmanage/downshelf/prodDownShelf.do?downShelfForm.withdrawaltype=3&downShelfForm.forceWithdrawalDay=30' >30天内有问题被下架<span class='number-link'>(" + productwithdrawaltypenum + ")</span></a>");
					$("#productwithdrawaltypenumid").addClass("hold-data");
				}
     		} 
	    },
	    error: function (data, status, e) {
       	}
	    
	});
}

function getProductBJ() {
	jQuery.ajax({
   		type: "POST",
   		url: "/mycenter/ajax.do?act=getProductBJ&isblank=true",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	var moveproductnum = data.productnum;
	    	if (flag) {
					var content = "";
				    if(moveproductnum > 0){
						content = "<li><a href='/prodmanage/shelf/prodSpider.do?prodSpiderForm.vaildday=3' >3天内将过期搬家<span class='number-link'>(" + moveproductnum + ")</span></a></li>";
					}else{
						content = "<li>3天内将过期搬家(0)</li>";
					}
					$("#productvailddaynumid").after(content);
     		} else {
     			$("#productvailddaynumid").after("<li>3天内将过期搬家(0)</li>");
	 		}
	    },
	    error: function (data, status, e) {
       	}
	    
	});
}
function getProductDefect() {
	jQuery.ajax({
   		type: "POST",
   		url: "/mycenter/ajax.do?act=getProdDefect&isblank=true",
   		dataType: "json",
   		async: false,
   		success: function(data, status) {
	    	var flag = data.flag;
	    	var moveproductnum = data.productnum;
	    	if (flag) {
				if(moveproductnum > 0){
					$("#productdefectnum").html("<a href='http://seller.dhgate.com/prodmanage/attrDefect/prodAttrDefect.do?dhpath=10001,70,7001' >属性缺失产品<span class='number-link'>(" + moveproductnum + ")</span></a>");
					$("#productdefectnum").addClass("hold-data");
				}
	 		}
	    },
	    error: function (data, status, e) {
       	}
	    
	});
}
function initSummary(){
	
	jQuery.ajax({
	   		type: "POST",
	   		url: "/usr/signin.do?act=ajaxgusermess&isblank=true",
	   		dataType: "json",
	   		async : true,
	   		timeout:30000,
		    success: function(data,status){
		    		/**信息提示区 start*/
		    		//银行验证,第一单(101006)
					var bankverifystatus = data.bankverifystatus;
//					var showflag = bankverifystatus.split("^")[0];
					var showmess = "请及时完成您的银行账户设置，以免影响款项下发 。 <a href=\"http://seller.dhgate.com/fundaccounting/ba/cnyAccInfo.do\" class=\"a1\" target=\"_blank\">银行账户设置</a>";
					if(bankverifystatus == 0){
						$("#bankverifyid").html('[DHgate验证] '+showmess);
						$("#bankverifyid").show();
					}
					
		    		var ad_residualgift = data.residualgift;
		     		var ad_endtime = data.endtime;
		     		if(ad_residualgift != null){
		     			//$("#adcenterid").html("您的广告费余额为"+ad_residualgift+"元，有效期至"+ad_endtime+"，请在有效期前使用。");
		     			
		     			$("#adcenterid").html("[广告相关] 在" + ad_endtime + "前，您有<a href='http://adcenter.dhgate.com/index.do?act=login' target='_blank'>" + ad_residualgift + "元广告赠点</a>将到期，请在有效期前使用！");
		     			
			     		$("#adcenterid").show();
		     		}
		     		
		     		var valprosize = data.valprosize;
		     		if(valprosize != null){
		     			$("#valprosizeid").html(valprosize);
		     		}
		     		
//		     		var sellerstore = data.sellerstore;
//					if(sellerstore == "0"){
//						$("#sellerstoreid").show();
//					}
//					
//					//虚拟账户
//					var b_account = data.b_account ;
//					if(b_account == "1"){
//						$("#b_accountid").show();
//					}
		     		
		    		/**信息提示区 end*/
		    		
		    		/**订单相关 start*/
//		    		var apply = data.apply;
//					if(apply > 0){
//						$("#applyid").html("<a href='/mydhgate/order/processactrfxsuppliercn.do?act=search&status=104&time=no' >可请款<span class='number-link'>("+apply+")</span></a>");
//						$("#applyid").addClass("hold-data");
//					}
//					
//					var payout = data.payout;
//					if(payout > 0){
//						$("#payoutid").html("<a href='/mydhgate/order/processactrfxsuppliercn.do?act=search&status=105&time=no' >7天入账<span class='number-link'>("+payout+")</span></a>");
//						$("#payoutid").addClass("hold-data");
//					}
//		    		
//		    		var waitdelivery = data.waitdelivery;
//					if(waitdelivery >0){
//						$("#waitdeliveryid").html("<a href='/mydhgate/order/processactrfxsuppliercn.do?act=search&status=103&time=no' >待发货<span class='number-link'>("+waitdelivery+")</span></a><img src='http://image.dhgate.com/2008/web20/seller/img/urgent.gif' style='cursor:hand' title='您有需紧急处理的订单'/>");
//						$("#waitdeliveryid").addClass("hold-data");
//					}
//					var dispute = data.dispute;
//					if(dispute > 0){
//						$("#disputeid").html("<a href='/mydhgate/order/processactrfxsuppliercn.do?act=search&status=106&time=no' >纠纷中<span class='number-link'>("+dispute+")</span></a>");
//						$("#disputeid").addClass("hold-data");
//					}
//					
//					var nopay = data.nopay;
//					if(nopay > 0){
//						$("#nopayid").html("<a href='/mydhgate/order/processactrfxsuppliercn.do?act=search&status=101&time=no' >未付款<span class='number-link'>("+nopay+")</span></a>");
//						$("#nopayid").addClass("hold-data");
//					}
//					
					var awaitingYourEvidenceCount = data.awaitingYourEvidenceCount;
					if(awaitingYourEvidenceCount > 0){
						$("#awaitingYourEvidenceCountid").html("<a href='/sellerordmng/orderList/disputeOrderList.do?params.linkType=202' >等待您提交证据<span class='number-link'>("+awaitingYourEvidenceCount+")</span></a>");
						$("#awaitingYourEvidenceCountid").addClass("hold-data");
					}
					
					var awaitYouSumbitedGetGoods = data.awaitYouSumbitedGetGoods;
					if(awaitYouSumbitedGetGoods > 0){
						$("#awaitYouSumbitedGetGoodsid").html("<a href='/sellerordmng/orderList/disputeOrderList.do?params.linkType=202' >等待您确认收货<span class='number-link'>("+awaitYouSumbitedGetGoods+")</span></a>");
						$("#awaitYouSumbitedGetGoodsid").addClass("hold-data");
					}
					
					var awaitYourTrackingAddress = data.awaitYourTrackingAddress;
					if(awaitYourTrackingAddress> 0){
						$("#awaitYourTrackingAddressid").html("<a href='/sellerordmng/orderList/disputeOrderList.do?params.linkType=202' >等待您填写退货地址<span class='number-link'>("+awaitYourTrackingAddress+")</span></a>");
						$("#awaitYourTrackingAddressid").addClass("hold-data");
					}
					
					var gatewayDisputeCount = data.gatewayDisputeCount;
					if(gatewayDisputeCount>0){
						$("#gatewayDisputeCountid").html("<a href='/mydhgate/order/gatewaydisputelist.do?act=pageload' >网关纠纷<span class='number-link'>("+gatewayDisputeCount+")</span></a>");
						$("#gatewayDisputeCountid").addClass("hold-data");
					}
		    		/**订单相关 end*/
		    		
		    		/***产品相关 start****/
		    		//var productwithdrawaltypenum = data.productwithdrawaltypenum;
					//if(productwithdrawaltypenum > 0){
					//	$("#productwithdrawaltypenumid").html("<a href='/prodmanage/downshelf/prodDownShelf.do?downShelfForm.withdrawaltype=3&downShelfForm.forceWithdrawalDay=30' >30天内有问题被下架<span class='number-link'>(" + productwithdrawaltypenum + ")</span></a>");
					//	$("#productwithdrawaltypenumid").addClass("hold-data");
					//}
					
					//var productvailddaynum = data.productvailddaynum;
					//if(productvailddaynum > 0){
					//	$("#productvailddaynumid").html("<a href='/prodmanage/shelf/prodShelf.do?prodShelfForm.vaildday=3' >3天内将过期<span class='number-link'>(" + productvailddaynum + ")</span></a>");
					//	$("#productvailddaynumid").addClass("hold-data");
					//}
					
					//var productvailddaynum1 = data.productvailddaynum1;
					//if(productvailddaynum1 > 0){
					//	$("#productvailddaynum1id").html("<a href='/prodmanage/downshelf/prodDownShelf.do?downShelfForm.withdrawaltype=2&downShelfForm.expiredDays=30' >30天内已过期<span class='number-link'>(" + productvailddaynum1 + ")</span></a>");
					//	$("#productvailddaynum1id").addClass("hold-data");
					//}
					
					//var productbrandcomplainnum = data.productbrandcomplainnum;
					//if(productbrandcomplainnum > 0){
					//	$("#productbrandcomplainnumid").html("<a href='/prodmanage/audit/prodBrandComplaint.do' >被品牌商投诉<span class='number-link'>(" + productbrandcomplainnum + ")</span></a>");
					//	$("#productbrandcomplainnumid").addClass("hold-data");
					//}
					var needinventory = data.needinventory;
					if(needinventory > 0){
						$("#needinventory").html("<a href='/prodmanage/inventory/doQueryInventory.do?type=2' >需补充备货<span class='number-link'>(" + needinventory + ")</span></a>");
						$("#needinventory").addClass("hold-data");
					}
					//var moveproductnum = data.moveproductnum;
					//if(moveproductnum != undefined){
					//	var content = "";
					//	if(moveproductnum == 0){
					//		content = "<li>3天内将过期搬家(" + moveproductnum + ")</li>";
					//	}else{
					//		content = "<li><a href='/prodmanage/shelf/prodSpider.do?prodSpiderForm.vaildday=3' >3天内将过期搬家<span class='number-link'>(" + moveproductnum + ")</span></a></li>";
					//	}
					//	$("#productvailddaynumid").after(content);
						//$("#moveproductnumid").html("<a href='/mydhgate/product/manageproductcnbatchcn.do?act=pageload&biztype=8&vaildday=3' >3天内将过期搬家<span class='number-link'>(" + moveproductnum + ")</span></a>");
						//$("#moveproductnumid").addClass("hold-data");
					//}
					
					var prodRepeatCount = data.prodRepeatCount;
					if(prodRepeatCount>0){
						$("#prodRepeatId").html("<a href='/prodrepeat/prodrepeatgroup/grouplist.do?dhpath=10001,21001,0219' >待处理重复产品<span class='number-link'>(" + prodRepeatCount + ")</span></a>");
						$("#prodRepeatId").addClass("hold-data");
					}	
					var crawlProdAuth = data.crawlProdAuth;
					if(crawlProdAuth=="1"){
						$("#notUserCrawlProdNumId").show();
						
						var notUserCrawlProdNum = data.notUserCrawlProdNum;
						if(notUserCrawlProdNum > 0){
							var vhtml = '<a href="/mydhgate/product/crawlstore.do?act=pageload&dhpath=10001,22001">未修改的一键达<span class="number-link">('+notUserCrawlProdNum+')</span></a>';
							if(jQuery.cookie('cl_rmd_b') != 'n'){
								vhtml += '<div class="totipposbox-service" style="display: block;" id="div_promptCrawlProdId">';
								vhtml += '<div class="eval-service">';
								vhtml += '<p>您的一键达产品需要修改信息后提交审核</p>';
								vhtml += '<a class="atipsclose" id="promptCrawlProdId" href="javascript:void(0)" onclick="notPromptCrawlProd();">不再提示</a>';
								vhtml += '<b></b>';
								
								vhtml += '</div>';
								vhtml += '<div class="eval-shadow"></div>';
								vhtml += '</div>';
							}
							$("#notUserCrawlProdNumId").html(vhtml);
							$("#notUserCrawlProdNumId").addClass("hold-data");
							$("#notUserCrawlProdNumId").addClass("totipposbox");
						}
					}
					
					
		    		/***产品相关 end****/
		    		
		    		//新服务提示
					var serviceid = data.serviceid;
					var servname = data.servname;
					var servtime = data.servtime;
					if(serviceid != null && serviceid != '' && servname != null && servname != ''){
						$("#serviceid").html("您的“"+servname+"”服务已成功开通 !");
						$("#servicetime").html("服务期为"+servtime+" , 现在就可以享受该服务带来的便利了!");
						$("#servnamebutton").click(function (){readservice(serviceid);jQuery.modal.close();});
						$("#div_servicenotice").modal({close:false});
					}
					
		    		/***showbox**/
		    		if(data.noticeTitle != "0") {
						if(data.noticeisupdate == "y" || jQuery.cookie('c_noticeshowV2') != "n") { //如果有更新
    						$("#noticetitle").html(replaceStr(data.noticeTitle));
    						$("#noticedetail").html(replaceStr(data.noticeDetail));
							showBoxV2();
						}
					} 
		    },
		    error: function (data, status, e){
	       }
		}); 
		
		
				//AJAX获取曝光系统的数据后台数据
				/***  去掉2012-11-21
	$.ajax({
       	url: "http://seller.dhgate.com/exp/user/expAccountShow?ver=" + new Date().getTime().toString(36),
       	data:{"isblank":true},
       	dataType: 'json',
       	//async:true ,
       	success: function(result) {
           	$(result).each(function(){
           	
           		if(this.isShow=="true" || this.isShow==true){
           			$("#expAccount").show();
           			$("#expAccount_balance").html(this.expBalace);
           			
           			if(this.chargeWarn=="true" || this.chargeWarn==true){
	           			$("#expAccount_payment").show();
	           		}
           		}
           		
           	});
       	},
       	error: function(xhr, status, error) {
        	$("#expAccount").hide();
        },            
        timeout: 5000,
         type: 'POST'
           
   	});***/
   	
   	$.ajax({
       	url: "http://seller.dhgate.com/usr/signin.do?act=ajaxSellerPunish",
       	data:{"isblank":true},
       	dataType: 'json',
       	//async:true ,
       	success: function(result) {
       		var reportList = result.punishReportList;
       		if(reportList.length>0){
       			$(reportList).each(function(){
       				$("#myPunishUl").append("<li><a href='javascript:void(0);' onclick=\"javascript:punishDetail('" + this.reportId + "',"+this.num+ ")\" >"+ this.reportName +"<span class='number-link'>("+ this.num +")</span></a></li>");
       			});
       			
       			$("#myPunish").show();
       		}
       	},
       	error: function(xhr, status, error) {
       	
        },            
        timeout: 5000,
         type: 'POST'
           
   	});
   	
   	//user服务竞争力
	$("#button_id").click(function(){
	   showUsrService("/usr/competition.do?act=pageload");
	});
	

}

function showUsrService(strUrl){
   $("#id_user_service").modal({close:false});
   $("#ifm_ser").attr('src',strUrl);
}
function initChart(){
	selectIndicator();
}

/**
 * 选择数据图的指标----异步刷新数据图DIV
 */
function selectIndicator() {
	//获取请求参数
	var statDate = "";
	var catePubId = "";
	var countryid = "";
	var categoryLevel = "";
	//要查询的指标
	var indicator = $('#indictor_select_id').val();
	//数据图的X轴的最小单位
	var measureUnit = '';
	//是否显示环比
	var q2q = '0';//默认不显示
	
	var chartXML = "";
	var chart = new FusionCharts(
			"/mydhgate/report/chartSwf/FCF_MSLine.swf", "ChartId",
			"520", "250");
	// 异步请求数据,局部刷新该局域
	$.ajax({
		url:'http://seller.dhgate.com/wisdom/shopanalysis/datamap.do?isblank=true',
		data : {
			'statDate' : statDate,
			'catePubId' : catePubId,
			'categoryLevel' : categoryLevel,
			'countryid' : countryid,
			'indicator' : indicator,
			'measureUnit' : measureUnit,
			'q2q' : q2q
		},
		error : function() {
			//alert("error occured!!!");
		},
		type : "POST",
		dataType : 'json',
		async : true,
		success : function(data) {
			chartXML = data.dataMapXML;
			if (chartXML != null) {
				//updateChartXML('ChartId', chartXML);
			    chart.setDataXML(chartXML);
				chart.setTransparent('transparent');
			    chart.render("chartdiv");				
			}
		}
	});
}

function initChart_(){
	
	jQuery.ajax({
	   		type: "POST",
	   		url: "/mydhgate/report/sellerchart.do?act=showPCLSumByCountry&isblank=true",
	   		dataType: "text",
	   		async : true,
		    beforeSend:function(XMLHttpRequest){
                 $("#pc_lsumCountry").html(imgUrl);
            },
			success: function(data,status){
				var chart1 = new FusionCharts("/mydhgate/report/chartSwf/FCF_Pie2D.swf", "chart2Id", "250", "200", "0", "1");		   			
				datas = data.split("</graph>");
				cdata = datas[0] + "</graph>"
				
				tips = datas[1].split(":");
				$("#csdate").html(tips[0]);
				var tip = tips[1];
				if(tip != ''){
					$("#tipcs").html(tip + " 的数据正在统计中...");
					$("#tipcs").css("display",""); 
				}
				chart1.setDataXML(cdata);
			    chart1.addParam("wmode","transparent");
			    chart1.render("pc_lsumCountry");
		    },
		    error: function (data, status, e){
	          $("#pc_lsumCountry").html("生成统计图错误，错误代码001");
	      }
	});
}
  	function showBoxV2(){
		
      	var messPop = $('#messagePop'); 
	  	var messageClose = $('#messageClose');
	  	messPop.slideDown(800);
	  	messageClose.click(function(){
  	   		 messPop.slideUp(800);
  	   		 jQuery.cookie('c_noticeshowV2','n');
  		})
  	}
  	
  	//关闭新手提示标签
	function closeNewBuyer(){
		var strURL ="/mydhgate/index.do?act=closenewbuyer"; 
		jQuery.ajax({
		   		type: "GET",
		   		url: strURL,
		   		dataType: "json",
		   		async : true,
			    success: function(data){
			  		
			    },
			    error: function (data, status, e)
		       {
		       }
			}); 
	}

	
	function replaceStr(str) {
	//str = decodeURIComponent(str);
		var regBlank=new RegExp("&nbsp;","g");
		var regQuotationMark=new RegExp("&quot;","g");
		var regLeft=new RegExp("&lt;","g");
		var regRight=new RegExp("&gt;","g");
		var regAnd= new RegExp("&amp;","g");
		
		str = str.replace(regLeft,"<");
		str = str.replace(regBlank," ");
		str = str.replace(regAnd,"&");
//		str = str.replace("&nbsp;"," ");
//		str = str.replace("&nbsp;"," ");
		str = str.replace(regRight,">");
		str = str.replace(regQuotationMark,"'");
//		str = str.replace("&lt;","<");
//		str = str.replace("&nbsp;"," ");
//		str = str.replace("&gt;",">");
//		str = str.replace("&quot;","'");
//		str = str.replace("&quot;","'");
//		str = str.replace("&quot;","'");
//		str = str.replace("&nbsp;"," ");
//		str = str.replace("&nbsp;"," ");
		return str;
	}
	
	function showDivFrozenDetail(){
	   $("#div_frozen_detail").modal({close:false});
	}
	
	function showDivFrozenApply(){
	   $("#div_frozen_apply").modal({close:false});
	}
	
	function notPromptCrawlProd(){
		$("#div_promptCrawlProdId").hide();
		$("#notUserCrawlProdNumId").removeClass("totipposbox");
		jQuery.cookie('cl_rmd_b','n');
	}
	
	function punishDetail(reportId,num){
		if("CAN_APPEAL"==reportId){
			location.href = "http://seller.dhgate.com/punish/punishManage/getPunishInfo.do?reportId=0&dhpath=10009,32";
		}else{
			location.href = "http://seller.dhgate.com/punish/punishManage/getPunishInfo.do?reportId="+reportId+"&dhpath=10009,32";
		}
	}
	
	function punishAppeal(punishId){
		$.ajax({
	       	url: "http://seller.dhgate.com/usr/signin.do?act=ajaxPunishAppeal",
	       	data:{"isblank":true,"punishId":punishId},
	       	dataType: 'json',
	       	//async:true ,
	       	success: function(date) {
	       		if(date.result=='1'){
	       			$("#opt_"+punishId).html("等待处理");
	       		}
	       	},
	       	error: function(xhr, status, error) {
	       	
	        },            
	        timeout: 5000,
	         type: 'POST'
	           
	   	});
	}
	
	
	