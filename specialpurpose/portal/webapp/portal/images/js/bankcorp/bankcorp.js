/**
 * ���к���js
 * �������ߴ���
 */
if(!window.bankcorp){
	window.bankcorp = {};
}
bankcorp.cmb = {
	/**
	 * ��ʾ���ߴ�����㣬ʵ���� http://www.dhresource.com/dhs/mos/js/summary/summaryPage.js
	 */
    showpopwin: function(){
    	var loanPop = new myDhgatePopUp({PopUpWrap: 'loanPopWrap'});
    	loanPop.PopShow();
    },
    /**
     * ��ȡ��ǰ����ID
     */
    getCurSupplierId: function(){
    	var supplierid = $("input[name='supplierId']").attr("value");
    	return supplierid;
    },
    /**
     * �Ƿ���ʾ������
     */
    isPopWin: function(supplierid){
    	var result = false;
    	/**
    	 * ajax�����Ƿ���ʾ������
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
				//alert("����ҳ��ʧ�����Ժ�����");
			}
		});
    	return result;
    },
    /**
     * ��ȡ������������ʾ����
     * @param supplierid
     */
    showCmbLoanPopWin: function(){
    	var supplierid = this.getCurSupplierId();
    	var isPop = this.isPopWin(supplierid);
    	if(isPop){
    		this.showpopwin();
    		/**
        	 * ajax�����ȡԤ���Ž���Ч������
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
    					 * ��ȡ����ҳ�浯����ģ�鸳ֵ
    					 */
    					var trustAmount = data['amount'];
    					var trustValidDate = data['validdate'];
    					$("#cmbPopWinTrustAmount").html(trustAmount);
    					$("#cmbPopWinTrustValidDate").html("��Ч������"+trustValidDate);
    				}
    			},
    			error: function(data,textStatus){
    			//	alert("����ҳ��ʧ�����Ժ�����");
    			}
    		});
    	}
    },
    /**
     * �����㲻����ʾ����
     */
    noLongerPopWin: function(){
    	var supplierid = this.getCurSupplierId();
		var url = "/bankcorp/cmb/nolongerpopwin.do";
		var state = "0";   //Ĭ��û��ѡ��
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
			//	alert("����ҳ��ʧ�����Ժ�����");
			}
		});
    }
}