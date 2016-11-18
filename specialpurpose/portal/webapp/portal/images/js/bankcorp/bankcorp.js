/**
 * 银行合作js
 * 招行在线贷款
 */
if(!window.bankcorp){
	window.bankcorp = {};
}
bankcorp.cmb = {
	/**
	 * 显示在线贷款弹出层，实现在 http://www.dhresource.com/dhs/mos/js/summary/summaryPage.js
	 */
    showpopwin: function(){
    	var loanPop = new myDhgatePopUp({PopUpWrap: 'loanPopWrap'});
    	loanPop.PopShow();
    },
    /**
     * 获取当前卖家ID
     */
    getCurSupplierId: function(){
    	var supplierid = $("input[name='supplierId']").attr("value");
    	return supplierid;
    },
    /**
     * 是否显示弹出层
     */
    isPopWin: function(supplierid){
    	var result = false;
    	/**
    	 * ajax请求是否显示弹出层
    	 */
    	var url = "/bankcorp/cmb/ispopwin.do";
		$.ajax({
			type: "GET",
			url: url,
			dataType: "json",
			async: false,
			data: {supplierid:supplierid},
			success: function(data,textStatus){
				if(data['status'] == '1'){
					result = true;
				}
			},
			error: function(data,textStatus){
				//alert("加载页面失败请稍后重试");
			}
		});
    	return result;
    },
    /**
     * 获取弹出层数据显示数据
     * @param supplierid
     */
    showCmbLoanPopWin: function(){
    	var supplierid = this.getCurSupplierId();
    	var isPop = this.isPopWin(supplierid);
    	if(isPop){
    		this.showpopwin();
    		/**
        	 * ajax请求获取预售信金额、有效期数据
        	 */
    		var url = "/bankcorp/cmb/trustdata.do";
    		$.ajax({
    			type: "GET",
    			url: url,
    			dataType: "json",
    			data: {supplierid:supplierid},
    			success: function(data,textStatus){
    				if(data['status'] == '1'){
    					/**
    					 * 获取数据页面弹出层模块赋值
    					 */
    					var trustAmount = data['amount'];
    					var trustValidDate = data['validdate'];
    					$("#cmbPopWinTrustAmount").html(trustAmount);
    					$("#cmbPopWinTrustValidDate").html("有效期至："+trustValidDate);
    				}
    			},
    			error: function(data,textStatus){
    			//	alert("加载页面失败请稍后重试");
    			}
    		});
    	}
    },
    /**
     * 弹出层不在显示处理
     */
    noLongerPopWin: function(){
    	var supplierid = this.getCurSupplierId();
		var url = "/bankcorp/cmb/nolongerpopwin.do";
		var state = "0";   //默认没有选中
		var checked = $("#cmbNolongerPopWin").attr("checked");
		if(checked){
			state = "1";
		}
		$.ajax({
			type: "GET",
			url: url,
			dataType: "json",
			data: {supplierid:supplierid,state:state},
			success: function(data,textStatus){
				if(data['status'] == '1'){
				}
			},
			error: function(data,textStatus){
			//	alert("加载页面失败请稍后重试");
			}
		});
    }
}