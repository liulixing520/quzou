<style>
	.tingyong td{
		background:#D3D3D3;
	}
</style>
<div class="main">
	<div class="com_sea_bigbox">
	    <form name="customerForm" id="searchCustomer" action="<@ofbizUrl>customerList</@ofbizUrl>">
	    
	    <div class="filter_stock">
			<div class="filter_info">
			    <div class="fl">
			    	<label class="ff_label ml30">计步器号：</label>
			    	<input type="hidden" name="cardId_op"  value="contains" />
			    	<input type="text" class="inp-text ff_calendar" name="cardId" id="cardId" value="${parameters.cardId!}" />
			    	<label class="ff_label" style="margin-left:36px;">姓名：</label>
			    	<input type="hidden" name="userLoginId_op"  value="contains" />
			    	<input type="text" class="inp-text" name="userLoginId" id="userLoginId" value="${parameters.userLoginId!}" />
			    	<label class="ff_label" style="margin-left:36px;">电话：</label>
			    	<input type="hidden" name="telephone_op"  value="contains" />
			    	<input type="text" class="inp-text" name="telephone" id="telephone" value="${parameters.telephone!}" />
			    </div>
			    <div class="fi_search_btn"><a href="javascript:document.customerForm.submit();" class="btn mm btn-confirm membetSetMarT" style="margin-right:20px;">查询</a>
			    <a href="javascript:void(0);" class="btn mm btn-confirm membetSetMarT" onclick="uploadCustemer()">导入</a></div>
			    
			</div>
		</div>
	   </form>
	</div>

	<div class="clear"></div>
	<div class="wrap2 member_table table pb20">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="nursing">
	        <tr>
	            <th width="3%" class="td_checked"><input type="checkbox" class="checkAll" data-name="1"/></th>
	            <th width="26%">姓名</th>
	            <th width="16%">电话</th>
	            <th width="8%">性别</th>
	            <th width="26%">单位</th>
	            <th width="16%">部门</th>
	            <th width="16%">计步器号</th>
	            <th width="6%">积分</th>
	            <th width="26%">所属活动</th>
	            <th width="8%">状态</th>
	            <th width="16%">操作</th>
	        </tr>
	<#if listIt?has_content>
		<#list listIt as customer>
			<tr>
				<td><input type="checkbox" name="partyId" value="${customer.partyId!}" class="checkItem"  data-name="1"/></td>
				<td>
	            	<div class="photo">
	            		<#if customer.openId?has_content>
		        			<img id="logo_${(customer.partyId)!}_${(customer.partyId)!}" src="../images/images/img/boyHeader_b.png">
		        		<#else>
		        			<img id="logo_${(customer.partyId)!}_${(customer.partyId)!}" src="../images/images/img/<#if "${(customer.gender)!}"=="F">girlHeader_b.png<#else>boyHeader_b.png</#if>">
		        		</#if>
		        		<#if "${(customer.gender)!}"=="M">
	        				<em class="sex"><img src="../images/images/common/man.png"></em>
	        			<#else>
	        				<em class="sex"><img src="../images/images/common/lady.png"></em>
	        			</#if>
	
	                </div>
	            	<a class="name" href="javascript:void(0);" <#if "${(customer.enabled)!}"=="Y">onclick="location.href='addCustomer?customerId=${(customer.partyId)!}'"</#if> >${(customer.userLoginId)!}</a>
	            </td>
				<td>${customer.telephone!}</td>
				<td>
					<#if "${(customer.gender)!}"=="M">男</#if>
		            <#if "${(customer.gender)!}"=="F">女</#if>
				</td>
				<td>${customer.companyName!}</td>
				<#assign deptAndCustomerViewList = delegator.findByAnd("QzDeptAndCustomerView", Static["org.ofbiz.base.util.UtilMisc"].toMap("customerId", customer.partyId), null, false)>
				<td>
					<#if deptAndCustomerViewList?has_content>
						${deptAndCustomerViewList[0].deptName!}
					</#if>
				</td>
				<td>${customer.cardId!}</td>
				<#assign statisticsTotalList = delegator.findByAnd("QzStatisticsTotal", Static["org.ofbiz.base.util.UtilMisc"].toMap("customerId", customer.partyId), null, false)>
				<td>
					<#if statisticsTotalList?has_content>
						${statisticsTotalList[0].integral!}
					</#if>
				</td>
				<#assign compeitionLIst = delegator.findByAnd("QzCompetiAndCustomerView", Static["org.ofbiz.base.util.UtilMisc"].toMap("customerId", customer.partyId,"status","1"), null, false)>
				<td>
					<#if compeitionLIst?has_content>
						<#list compeitionLIst as item>
							<span data-url="getDeptList?cId=${(item.cId)!}" >${item.cName!}</span></br>
						</#list>
					</#if>
				</td>
				<td>
					<#if "${(customer.enabled)!}"=="Y">启用</#if>
		            <#if "${(customer.enabled)!}"=="N">停用</#if>
				</td>
				<td><a href="javascript:void(0);" <#if "${(customer.enabled)!}"=="Y">onclick="location.href='addCustomer?customerId=${(customer.partyId)!}'"</#if>>编辑</a></td>
			</tr>
		</#list>
	</#if>
	    </table>
	    <div class="table_control">
	        <div class="t_c_inp">
	            <input type="checkbox" class="checkAll" id="checkAll" data-name="1">
	            <label for="checkAll">全选</label>
	        </div>
	        
	        <div class="t_c_btn">
	        	<a id="qiyongBtn" href="javascript:" onclick="setEnabledMember('PARTY_ENABLED')" class="btn mm btn-default">启用</a>
	        </div>
	         <div class="t_c_btn">
	        	<a id="zantingBtn" href="javascript:" onclick="setEnabledMember('PARTY_DISABLED')" class="btn mm btn-default">停用</a>
	        </div>
	    </div>


	<#assign url="customerList?1=1"/>
	<#if parameters.userLoginId?has_content>
		<#assign url=url+"&userLoginId=${(parameters.userLoginId)!}"/>
	</#if>
	<#if parameters.telephone?has_content>
		<#assign url=url+"&telephone=${(parameters.telephone)!}"/>
	</#if>
	<#if parameters.cardId?has_content>
		<#assign url=url+"&cardId=${(parameters.cardId)!}"/>
	</#if>
	<#assign url=url?replace("customerList","")/>
	<#import "component://quzou/webapp/quzou/includes/htmlFtlMacroLibrary.ftl" as p>
			  <@p.showPage requestUrl1="customerList"
			  requestUrl2=url
			  listSize=listSize viewSize=viewSize viewIndex=viewIndex isAuth=true/>
	</div>
</div>
<script type="text/javascript" src="../images/js/jquery.cm_dialog.js"></script>

<script type="text/javascript">
	$(function(){
		$('#birthDate').daterangepicker({
			timePicker: false,
			timePickerIncrement: 1,
			format: 'YYYY-MM-DD',
			singleDatePicker: true,
			showDropdowns:true
		});

	});
	function setEnabledMember(a){
		var c ="";
		if(a=='PARTY_ENABLED'){
			c="确定启用选中的会员？"
		}else{
			c="确定停用选中的会员？"
		}
		if(confirm(c)) {
			var ids=$("input[name='partyId']:checked").map(function() { return this.value; }).get().join();
			$.ajax({
			  type: 'POST',
			  url: 'setPartysStatus',
			  data: {partyIds:ids,partyStatusId:a},
			  success: function(data) {
			   location.reload();
			  }
			});
		}
	}
	<#--上传数据-->
	function uploadCustemer(){
		 var option = {
	        url: "uploadDialog?inType=customer",
	        width: '410px'
	      };
		$(this).cm_dialog(option);
	}

	var zhuandianAjax = function(){
		var b = $(".alert-window .zd-zhuanr-select option:selected").val();
		var a = $("#zd-name").attr("v");
		$.ajax({
		  type: 'POST',
		  url: 'setPartyProductStore',
		  data: {partyId:a,productStoreId:b},
		  success: function(data) {
		  	 alert("转店成功！");
		  	 location.reload();
		  },
		  error: function(e) {
			alert(e);
		  }
		});
		return false;
	}
</script>
<style>
    .mouse_popup{
        padding: 5px;
        background: #FFF;
        box-shadow:0 0 10px #ccc;
       /* border: 1px solid #EDC27C;*/
    }
</style>
<script>
    /*
     * 使用方法1:
     * 在金额标签上增加 data-html 属性，内容为html字符串,当鼠标移动到金额时候，popup内容就为这个字符串
     *
     * 使用方法2:
     * 在金额标签上增加 data-url 属性,内容为url地址,popup会自动读取url地址中的html，然后作为popup的内容
     *
     * 使用方法3:
     * 在金额标签上增加 data-selector,例如 .abc ,popup会自动查询这个选择器，并且将查询到的元素克隆到 popup 里面作为内容
    */
    $(function(){
        var initPopup = function(element){
            var popupElement = $(document.createElement("div")).addClass("mouse_popup").appendTo("body").css({
                position:"absolute",
                zIndex:9999,
                opacity:0
            }).animate({
                opacity:1
            },200);

            var update  = function(){
                return popupElement.css({
                    top:element.offset().top + element.outerHeight(),
                    left:element.offset().left
                });
            };

            var ajaxGet = function(url){
                $.ajax({
                    url:url,
                    cache:false,
                    success:function(responseText){
                        update().html(responseText);
                    }
                })
            };
            if(element.data("url")){
                ajaxGet(element.data("url"));
            }else if(element.data("selector")){
                popupElement.html($(element.data("selector").clone()));
            }else if(element.data("html")){
                popupElement.html(element.data("html"));
            }

            element.on("mouseleave",function(){
                popupElement.remove();
            });
            update();
        };

        $("body").on("mouseenter",".member_table tr td span",function(){
            initPopup($(this));
        });
    });
</script>
