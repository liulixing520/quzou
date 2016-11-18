<div class="content profile checkout_box ">
            <h2 class="title" style='font-size:20px'>收货地址</h2>
            <div class="profile_detail clearfix checkout_box_inner">
            
            <div class="address_list" id="address_list_div">
				<div class="address_list_over" id="show_address_list">
					<ul class="clearfix">
					<#if contactMeches?has_content>
		                <#list contactMeches as contactMechMap>
		                    <#assign contactMech = contactMechMap.contactMech>
		                    <#if "POSTAL_ADDRESS" = contactMech.contactMechTypeId >
			                    <li class="clearfix  selected_addr " name="15313" id="address_15313">
				                    <#if contactMechMap.postalAddress?has_content>
				                    	<#assign postalAddress = contactMechMap.postalAddress>
									   	<#assign AddressGeoAllCn =Static["org.ofbiz.system.ContactMechTools"].
								                            getAddressGeoAllCn(delegator,postalAddress.stateProvinceGeoId,postalAddress.cityGeoId,postalAddress.countyGeoId)>
			          					<#if postalAddress?has_content>
							            <h4>${postalAddress.attnName!}&nbsp;</h4>
							            <p>${postalAddress.mobileExd!}&nbsp;</p>
							            <p>${AddressGeoAllCn?if_exists} ${(postalAddress.address1)?if_exists}&nbsp;</p>
							            <div class="btn_box address_but_box" id="address_btn_15313">
	                                    <a href="javascript:void(0)" onclick="delete_address('${contactMech.contactMechId}')" class="green_a fr">删除</a><span class="fr">|</span>
					                    <a href="javascript:void(0)" onclick="edit_address('${contactMech.contactMechId}')" class="green_a fr">编辑</a>
	                                    <#--<a href="<@ofbizUrl>user_deleteContactMech?partyId=${partyId}&amp;contactMechId=${contactMech.contactMechId}</@ofbizUrl>" onclick="delete_address(15313)" class="green_a fr">删除</a><span class="fr">|</span>
					                    <a href="<@ofbizUrl>user_EditAddress?partyId=${partyId}&amp;contactMechId=${contactMech.contactMechId}</@ofbizUrl>" onclick="edit_address(15313)" class="green_a fr">编辑</a>
					                    <b style="color:#2BBC69;font-weight:400;" class="success"><span></span>配送至此地址</b>-->     
					                    <input type="hidden" value="110102-001" name="get_address_delivery_id" id="selected_addr_delivery_id_15313">
            							<input type="hidden" value="${contactMech.contactMechId!}_${postalAddress.attnName!}_${postalAddress.stateProvinceGeoId!}_${postalAddress.cityGeoId!}_${postalAddress.countyGeoId!}_${(postalAddress.address1)?if_exists}_${postalAddress.mobileExd!}__${postalAddress.mobileExd!}" id="edit_address_${contactMech.contactMechId}">      
					                    </div>
							            </#if>
				                    </#if>
								</li>
		                    </#if>
		                </#list>
		            </#if>
		            <a href="javascript:void(0)" onclick="edit_address('')"><img class="addImg" src="<@ofbizUrl>../images/add.png</@ofbizUrl>"/> </a>
					</ul>
					<input type="hidden" value="15313" id="select_old_li">
					<input type="hidden" value="15827" id="sub_member_id">
					<input type="hidden" id="check_add_edit" value="0">
				</div>
			</div>
			
    </div>
</div>

	<!-- 弹窗 -->
    <div class="shade_box hide" style="display: none;"></div>
    
    <!--修改配送地址-->
    <div class="pop_box hide" id="pop_box_address_edit">
        <a href="javascript:;" class="close"></a>
        <h3 class="title">编辑配送地址<small>( <i class="required">*</i>为必填项)</small></h3>
       <form method="post" action="<@ofbizUrl>user_createPostalAddress</@ofbizUrl>" name="editcontactmechform"
              id="editcontactmechform" class="basic-form" >
              
        </form>
        <div class="edit_new_address">
            <ul>
                <li class="clearfix">
                    <div class="li_left"><i class="required">*</i>姓名</div>
                    <div class="li_right">
                        <input type="text" class="text" name="attnName" id="attnName_edit" onblur="checkVal(this)"><i class="tick"></i>
                        <input type="hidden" name="contactMechId" id="contactMechId" />
                        <span class="error_tips hide" style="display: none;"></span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="li_left"><i class="required">*</i>省市</div>
                    <div class="li_right">
                        <select name="stateProvinceGeoId" id="stateProvinceGeoId" class="select" onchange="getArea('stateProvinceGeoId', '', 'cityGeoId', 'countyGeoId','null')">
                        	<option></option>
		                	<#assign stateAssocs = Static["org.ofbiz.system.ContactMechTools"].getAssociatedStateList(delegator,'CHN')>
							<#list stateAssocs as stateAssoc>
								<option  value="${stateAssoc.geoId}">${stateAssoc.geoName?default(stateAssoc.geoId)}</option>
							</#list>
		                </select>
		                <select name="cityGeoId" id="cityGeoId" class="select" onchange="getArea('cityGeoId', '', 'countyGeoId', 'null','null')">
		                	<#if cityAssocs??>
								<#list cityAssocs as cityAssoc>
									<#assign city = delegator.findByPrimaryKey("Geo",{"geoId":cityAssoc.geoIdTo})/>
									<option  value="${city.geoId}">${city.geoName?default(city.geoId)}</option>
								</#list>
							</#if>
		            	</select>
		            	<select  name="countyGeoId" id="countyGeoId" class="select">
		                	<#if countyAssocs??>
								<#list countyAssocs as countyAssoc>
									<#assign county = delegator.findByPrimaryKey("Geo",{"geoId":countyAssoc.geoIdTo})/>
									<option  value="${county.geoId}">${county.geoName?default(county.geoId)}</option>
								</#list>
							</#if>
		            	</select>
                        <span class="error_tips hide dis_del_edit" style="display: none;"></span>
                    </div>
                </li>
                <li class="clearfix big_text">
                    <div class="li_left"><i class="required">*</i>地址</div>
                    <div class="li_right">
                        <input type="text" name="address" class="text" value="" id="address_edit" onblur="checkVal(this)" maxlength="60"><i class="tick"></i>
                        <span class="error_tips hide" style="display: none;"></span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="li_left"><i class="required">*</i>手机</div>
                    <div class="li_right">
                        <input type="text" name="phone" id="phone_edit" class="text" value="" onblur="checkVal(this)" maxlength="15" placeholder="请填写手机号码">
                        <i class="tick"></i>
                        <span class="error_tips hide" style="display: none;">手机号码输入错误！</span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="li_left">电话</div>
                    <div class="li_right">
                        <input type="text" name="mobile" id="mobile_edit" class="text" value="" onblur="checkVal(this)" placeholder="可选填备用联系方式">
                        <i class="tick"></i>
                        <span class="error_tips hide" style="display: none;">电话号码输入错误！</span>
                    </div>
                </li>
                <li class="clearfix">
                    <div class="li_left">&nbsp;</div>
                    <div class="li_right">
                         <input type="hidden" value="" id="address_id_edit">
                         <input type="hidden" name="contactMechPurposeTypeId" id="contactMechPurposeTypeId" value="SHIPPING_LOCATION">
			                   
                        <a href="javascript:void(0)" class="btn btn_green add_edit_address" id="addressBtn" name="edit">保存</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
