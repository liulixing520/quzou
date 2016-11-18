<script type="text/javascript">
<!--//
	var ifDouble = function(number){
		var pattern = /^(0|[1-9]\d{0,})(\.\d{1,2})?$/;
		if (!pattern.test(number)){
			return false;
		}
		return true;
	}
	var ifInt = function(number){
		var pattern = /^(0|[1-9]\d{0,})$/;
		if (!pattern.test(number)){
			return false;
		}
		return true;
	}
	
	//input:radio[name='loginIfAvaliable']:checked
	var setLoginReward = function(){
		var url = "<@ofbizUrl>SetCreditsReward</@ofbizUrl>";
		var ifAvaliable = $("input:radio[name='loginIfAvaliable']:checked").val();
		var hasLimit= $("input:radio[name='loginHasLimit']:checked").val();
		var rewardAmount = $("input[name=loginRewardAmount]").val();
		if(!ifInt(rewardAmount)){
				alert("单次赠送积分必须为整数!");
				return false;
			}
		var oneDayLimit = $("input[name=loginOneDayLimit]").val();
		//if(oneDayLimit==""||oneDayLimit=="undefined")oneDayLimit = "0";
		if(!ifInt(oneDayLimit)){
				alert("每日获取积分上限必须为整数!");
				return false;
			}
		var settingTypeId = "LOGIN_REWARD";
		var param = {'ifAvaliable':ifAvaliable,'hasLimit':hasLimit,'rewardAmount':rewardAmount,'oneDayLimit':oneDayLimit,'settingTypeId':settingTypeId};
		$.post(url,param,function(data){
			if(data.returnMSG){
				alert(data.returnMSG);
			}
		}, 'json');
	}
	
	var setRegisterReward = function(){
		var url = "<@ofbizUrl>SetCreditsReward</@ofbizUrl>";
		var ifAvaliable = $("input:radio[name='registerIfAvaliable']:checked").val();
		var hasLimit='N';
		var rewardAmount = $("input[name=registerRewardAmount]").val();
		if(!ifInt(rewardAmount)){
				alert("单次赠送积分必须为整数!");
				return false;
			}
		var oneDayLimit = '0';
		
		var settingTypeId = "REGISTER_REWARD";
		var param = {'ifAvaliable':ifAvaliable,'hasLimit':hasLimit,'rewardAmount':rewardAmount,'oneDayLimit':oneDayLimit,'settingTypeId':settingTypeId};
		$.post(url,param,function(data){
			if(data.returnMSG){
				alert(data.returnMSG);
			}
		}, 'json');
	}
	
	var setReviewReward = function(){
		var url = "<@ofbizUrl>SetCreditsReward</@ofbizUrl>";
		var ifAvaliable = $("input:radio[name='reviewIfAvaliable']:checked").val();
		var hasLimit='N';
		var rewardAmount = $("input[name=reviewRewardAmount]").val();
		//if(rewardAmount==""||rewardAmount=="undefined")rewardAmount = "0";
		if(!ifInt(rewardAmount)){
				alert("单次赠送积分必须为整数!");
				return false;
			}
		var oneDayLimit = '0';
		
		var settingTypeId = "REVIEW_REWARD";
		var param = {'ifAvaliable':ifAvaliable,'hasLimit':hasLimit,'rewardAmount':rewardAmount,'oneDayLimit':oneDayLimit,'settingTypeId':settingTypeId};
		$.post(url,param,function(data){
			if(data.returnMSG){
				alert(data.returnMSG);
			}
		}, 'json');
	}
	
	var setAuditReward = function(){
		var url = "<@ofbizUrl>SetCreditsReward</@ofbizUrl>";
		var ifAvaliable = $("input:radio[name='auditIfAvaliable']:checked").val();
		var hasLimit='N';
		var rewardAmount = $("input[name=auditRewardAmount]").val();
		//if(rewardAmount==""||rewardAmount=="undefined")rewardAmount = "0";
		if(!ifInt(rewardAmount)){
				alert("单次赠送积分必须为整数!");
				return false;
			}
		var oneDayLimit = '0';
		
		var settingTypeId = "AUDIT_REWARD";
		var param = {'ifAvaliable':ifAvaliable,'hasLimit':hasLimit,'rewardAmount':rewardAmount,'oneDayLimit':oneDayLimit,'settingTypeId':settingTypeId};
		$.post(url,param,function(data){
			if(data.returnMSG){
				alert(data.returnMSG);
			}
		}, 'json');
	}
	
	var setPartyClassificationRatio = function(){
		var url = "<@ofbizUrl>SetPartyClasRatio</@ofbizUrl>";
		var params = "";
		var entrys = $("input[name=partyClassificationItem]");
		var flag = 1;
		$.each(entrys,function(index,entry) {
			if(!ifDouble($(entry).val())){
				alert("请输入整数或者小数点后保留最多两位的小数!");
				flag = 0;
			}
			params+=""+$(entry).attr('settingTypeId')+":'"+$(entry).val()+"',";
		});
		if(flag==0){
			return false;
		}
		var ifAvaliablePCFG = $("input:radio[name='ifAvaliablePCFG']:checked").val();
		params+="ifAvaliable:'"+ifAvaliablePCFG+"'";
		params = "{"+params+"}";
		var paraObj =(new Function("","return "+params))();
		//var paraObj = eval("("+params+")");
		
		$.post(url,paraObj,function(data){
			if(data.returnMSG){
				alert(data.returnMSG);
			}
		}, 'json');
	}
	
	var setOrderRatio = function(){
		var url = "<@ofbizUrl>SetOrderRatio</@ofbizUrl>";
		var orderRatio = $("input[name=orderRatio]").val();
		var ifAvaliableOrder = $("input:radio[name='ifAvaliableOrder']:checked").val();
		if(!ifDouble(orderRatio)){
				alert("请输入整数或者小数点后保留最多两位的小数!");
				return false;
			}
		var param = {'orderRatio':orderRatio,'ifAvaliable':ifAvaliableOrder};
		$.post(url,param,function(data){
			if(data.returnMSG){
				alert(data.returnMSG);
			}
		}, 'json');
	}
//-->
</script>
<div id="pageContent" style="overflow:scroll" layouth='30'>
	<div style="width:800px;height:40px;margin-top:20px;font-size:20px;text-align:center;">积分赠送设置</div>
	<table width="800px" border="0" cellpadding="0" cellspacing="0" class="basic-table" style="border-color: #EEEEEE #EEEEEE #EEEEEE #EEEEEE;border-width: 2px 2px 2px 2px">
		<thead>
		    <tr style="height:30px;background-color:#BBBBBB;color:#FFFFFF;">
				<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;font-weight:bold;">事  件</th>
				<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;font-weight:bold;">是否启用</th>
				<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:20%;font-weight:bold;">单次赠送积分</th>
				<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:17%;font-weight:bold;">是否限制每日获取</th>				
				<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:18%;font-weight:bold;">每日获取积分上限</th>
				<th style="border-bottom: 2px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;font-weight:bold;">操  作</th>
		    </tr>
		</thead>
			<#assign productStoreId = Static["org.ofbiz.product.store.ProductStoreWorker"].getProductStoreId(request)/>
		    <!--登录送积分设置-->
		    <#assign logReward = delegator.findOne("ProductStoreCreditsSetting",{"productStoreId":productStoreId,"settingTypeId":"LOGIN_REWARD"},false)?if_exists />
		    <tr style="height:45px;">
		    	<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
				登录送积分
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
					是<input name="loginIfAvaliable" type="radio" value="Y" <#if logReward?? && logReward.ifAvaliable?? && logReward.ifAvaliable=='Y'>checked</#if> />
					否<input name="loginIfAvaliable" type="radio" <#if logReward?? && logReward.ifAvaliable?? && logReward.ifAvaliable=='Y' ><#else>checked</#if> value="N"/>
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:23%;">
					<input name="loginRewardAmount" style="height:18px;width:90px;" value="${(logReward.rewardAmount)!'0'}" />
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
					是<input name="loginHasLimit" type="radio" value="Y" <#if logReward?? && logReward.hasLimit?? && logReward.hasLimit=='Y'>checked</#if> />
					否<input name="loginHasLimit" type="radio" <#if logReward?? && logReward.hasLimit?? && logReward.hasLimit=='Y' ><#else>checked</#if> value="N" />
				</td>			
				<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:23%;">
					<input name="loginOneDayLimit" style="height:18px;width:90px;" value="${(logReward.oneDayLimit)!'0'}" />
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:8%;">
					<input  type="button" onclick="javascript:setLoginReward();" value="保存" />
				</td>
		    </tr>
		    <!--注册送积分设置-->
		    <#assign regReward = delegator.findOne("ProductStoreCreditsSetting",{"productStoreId":productStoreId,"settingTypeId":"REGISTER_REWARD"},false)?if_exists />
		    <tr style="height:45px;">
		    	<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
				注册送积分
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
					是<input name="registerIfAvaliable" type="radio" value="Y" <#if regReward?? && regReward.ifAvaliable?? && regReward.ifAvaliable=='Y'>checked</#if> />
					否<input name="registerIfAvaliable" type="radio" <#if regReward?? && regReward.ifAvaliable?? && regReward.ifAvaliable=='Y' ><#else>checked</#if> value="N"/>
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:23%;">
					<input name="registerRewardAmount" style="height:18px;width:90px;" value="${(regReward.rewardAmount)!'0'}" />
				</td>
				<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:38%;" colspan="2" >
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:8%;">
					<input  type="button" onclick="javascript:setRegisterReward();" value="保存" />
				</td>
		    </tr>
		    <!--评论商品送积分设置-->
		    <#assign reviewReward = delegator.findOne("ProductStoreCreditsSetting",{"productStoreId":productStoreId,"settingTypeId":"REVIEW_REWARD"},false)?if_exists />
		    <tr style="height:45px;">
		    	<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
				评论商品送积分
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
					是<input name="reviewIfAvaliable" type="radio" value="Y" <#if reviewReward?? && reviewReward.ifAvaliable?? && reviewReward.ifAvaliable=='Y'>checked</#if> />
					否<input name="reviewIfAvaliable" type="radio" <#if reviewReward?? && reviewReward.ifAvaliable?? && reviewReward.ifAvaliable=='Y' ><#else>checked</#if> value="N"/>
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:23%;">
					<input name="reviewRewardAmount" style="height:18px;width:90px;" value="${(reviewReward.rewardAmount)!'0'}" />
				</td>
				<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:38%;" colspan="2" >
				</td>
				<td style="border-bottom: 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:8%;">
					<input  type="button" onclick="javascript:setReviewReward();" value="保存" />
				</td>
		    </tr>
		    <!--审核通过评论送积分设置-->
		    <#assign auditReward = delegator.findOne("ProductStoreCreditsSetting",{"productStoreId":productStoreId,"settingTypeId":"AUDIT_REWARD"},false)?if_exists />
		    <tr style="height:45px;">
		    	<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
				审核通过评论
				</td>
				<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
					是<input name="auditIfAvaliable" type="radio" value="Y" <#if auditReward?? && auditReward.ifAvaliable?? && auditReward.ifAvaliable=='Y'>checked</#if> />
					否<input name="auditIfAvaliable" type="radio" <#if auditReward?? && auditReward.ifAvaliable?? && auditReward.ifAvaliable=='Y' ><#else>checked</#if> value="N"/>
				</td>
				<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:23%;">
					<input name="auditRewardAmount" style="height:18px;width:90px;" value="${(auditReward.rewardAmount)!'0'}" />
				</td>
				<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:38%;" colspan="2" >
				</td>
				<td style="padding: 3px 4px;text-align:center;width:8%;">
					<input  type="button" onclick="javascript:setAuditReward();" value="保存" />
				</td>
		    </tr>
	</table>

	<div style="width:800px;margin-top:30px;">
		<div style="width:49%;height:40px;float:left;">
			<div style="width:100%;height:40px;font-size:20px;text-align:center;">
				会员等级获取积分比例设置
			</div>
			<div style="width:100%;">
				<table border="0" cellpadding="0" cellspacing="0" class="basic-table" style="width:100%;border-color: #EEEEEE #EEEEEE #EEEEEE #EEEEEE;border-width: 2px 2px 2px 2px">
					<thead>
					    <tr style="height:30px;background-color:#BBBBBB;color:#FFFFFF;">
							<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:35%;font-weight:bold;">会员等级</th>
							<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:65%;font-weight:bold;">获取积分比 (实际获取积分=设置获取积分x获取积分比)</th>
						</tr>
					</thead>
					
					<#assign partyClassificationGroup = Static["org.ofbiz.iteamgr.system.SystemEvents"].getPartyClassificationGroup(delegator)?if_exists />
					<#if partyClassificationGroup?has_content>
						<#list partyClassificationGroup as partyClassification>
						<#assign plcs = delegator.findOne("ProductStoreCreditsSetting",{"productStoreId":productStoreId,"settingTypeId":"${partyClassification.partyClassificationGroupId!''}"},false)?if_exists />
							<tr style="height:45px;">
								<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:15%;">
									${partyClassification.description!'未知会员等级'}
								</td>
								<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:23%;">
									<input name="partyClassificationItem" settingTypeId="${partyClassification.partyClassificationGroupId!''}" style="height:18px;width:90px;" value="${(plcs.ratio)!'1.0'}" />
								</td>
							</tr>
						</#list>
						<tr style="height:35px;">
							<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;" colspan="2" align="center">
								<#assign pcfg = partyClassificationGroup?first />
								<#if pcfg??>
									<#assign flag = delegator.findOne("ProductStoreCreditsSetting",{"productStoreId":productStoreId,"settingTypeId":"${pcfg.partyClassificationGroupId!''}"},false)?if_exists />
								</#if>
								<div style="float:left">
									是否启用该设置？
									 是<input name="ifAvaliablePCFG" type="radio" value="Y" <#if flag?? && flag.ifAvaliable?? && flag.ifAvaliable=='Y'>checked</#if> />
									否<input name="ifAvaliablePCFG" type="radio" <#if flag?? && flag.ifAvaliable?? && flag.ifAvaliable=='Y' ><#else>checked</#if> value="N"/>
								</div>
								<div style="float:right;">
									<input  type="button" onclick="javascript:setPartyClassificationRatio();" value="保存" />
								</div>
							</td>
						</tr>
					<#else>
						<tr style="height:35px;">
							<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;" colspan="2" align="center">
								系统还没有会员等级相关信息
							</td>
						</tr>
					</#if>
				</table>
			</div>
		</div>
		<div style="width:49%;height:40px;font-size:20px;float:left;margin-left:3px;">
			<div style="width:100%;height:40px;font-size:20px;text-align:center;">
				订单金额换取积分比例设置
			</div>
			<#assign orderRatio = delegator.findOne("ProductStoreCreditsSetting",{"productStoreId":productStoreId,"settingTypeId":"ORDER_RATIO"},false)?if_exists />
			<div style="width:100%;">
				<table border="0" cellpadding="0" cellspacing="0" class="basic-table" style="width:100%;border-color: #EEEEEE #EEEEEE #EEEEEE #EEEEEE;border-width: 2px 2px 2px 2px;">
					<thead>
					    <tr style="height:30px;background-color:#BBBBBB;color:#FFFFFF;">
							<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:53%;font-weight:bold;">类型</th>
							<th style="border-bottom: 2px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;width:65%;font-weight:bold;">获取积分比(实际获取积分=订单金额x获取积分比)</th>
						</tr>
					</thead>
					<tr style="height:45px;">
						<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;">
							订单金额  / 获取积分
						</td>
						<td style="border-bottom: 1px solid #EEEEEE;border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;">
							<input name="orderRatio" style="height:18px;width:90px;" value="${(orderRatio.ratio)!'1.0'}" />
						</td>
					</tr>
					<tr style="height:35px;">
						<td style="border-right : 1px solid #EEEEEE;padding: 3px 4px;text-align:center;" colspan="2" align="center">
							<div style="float:left">
								是否启用该设置？
								 是<input name="ifAvaliableOrder" type="radio" value="Y" <#if orderRatio?? && orderRatio.ifAvaliable?? && orderRatio.ifAvaliable=='Y'>checked</#if> />
								否<input name="ifAvaliableOrder" type="radio" <#if orderRatio?? && orderRatio.ifAvaliable?? && orderRatio.ifAvaliable=='Y' ><#else>checked</#if> value="N"/>
							</div>
							<div style="float:right;">
								<input  type="button" onclick="javascript:setOrderRatio();" value="保存" />
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>