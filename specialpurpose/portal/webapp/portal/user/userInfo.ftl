<div class="content profile">
            <h2 class="title" style='font-size:20px'>个人信息</h2>
            <div class="profile_detail clearfix">
             <form action="user_updateInfo" name="MyForm" id="MyForm" method="post">
                <div class="left">
                    <span class="photo">
                   		 <#if partyInfo?has_content>
	                		<#assign persons=delegator.findByPrimaryKey("Person", {"partyId" :"${(partyInfo.partyId)!}"})?if_exists />
	                		<#if persons??&&persons.picUrl??>
	                			<img src="${(partyInfo.picUrl)!}" alt="" id="member_img_new">
	                		<#else>
	                			 <img src="/portal/images/green/member_logo.jpg" alt="" class="uploadeAvatar" id="member_img_new">
	                		</#if>
	                		<input type="hidden" id="picUrl" name="picUrl" value="${(partyInfo.picUrl)!}" />
	                	<#else>
	                		<input type="hidden" id="picUrl" name="picUrl" value=""/>
		                    <img src="/portal/images/green/member_logo.jpg" alt="" class="uploadeAvatar" id="member_img_new">
                		</#if>
                    </span>
                    <p class="upload_btn_line"><span class="upload_btn">上传头像<input class="uploadeAvatar" type="button"></span></p>
				</div>
				<div class="right">
		                    <ul class="profile_list">
					<li class="clearfix">
		                            <div class="li_left">昵称</div>
		                            <div class="li_right">
						            	<input type="hidden" name="partyId" id="partyId" value="${(partyInfo.partyId)!}"/>
		                                <input class="input_text" value="${partyInfo.nickname!}" name="nickname" id="nickname" type="text">
		                            </div>
					</li>
					<li class="clearfix">
		                            <div class="li_left">性别</div>
		                            <div class="li_right">
		                                <span class="radio_wrap"><i class="radio selectSex <#if "${(partyInfo.gender)!}"=="F" || !partyInfo?has_content >radio_cur</#if>" name="F"></i>女</span>
		                                <span class="radio_wrap"><i class="radio selectSex <#if "${(partyInfo.gender)!}"=="M">radio_cur</#if>" name="M"></i>男</span>
		                                <span class="radio_wrap"><i class="radio selectSex <#if "${(partyInfo.gender)!}"=="S">radio_cur</#if>" name="S"></i>保密</span>
		                                <input class="input_text" value="${partyInfo.gender?default('F')}" name="gender" id="gender" type="hidden"> 
		                            </div>
					</li>
					<li class="clearfix" style="position:relative;z-index:4;">
		                            <div class="li_left">生日</div>
		                            <div class="li_right">
		                            	 <#assign birthDate="">
										<#if partyInfo??&&partyInfo.birthDate??><#assign birthDate=partyInfo.birthDate></#if>
										<input id="birthDate" name='birthDate'  value='${birthDate!}'  type='text' class="input_text Wdate required" onfocus="WdatePicker({isShowWeek:true,dateFmt: 'yyyy-MM-dd'})" />
		                            </div>
					</li>
		                        <li class="clearfix">
		                            <div class="li_left">真实姓名</div>
		                            <div class="li_right">
		                                <input class="input_text" value="${partyInfo.firstName!}" name="firstName" id="firstName" type="text">
		                                <input class="input_text" value="${partyInfo.lastName!}" name="lastName" id="lastName" type="hidden">
		                            </div>
					</li>
					<li class="clearfix">
		                            <input value="" id="img_url_120" type="hidden">
		                            <a href="javascript:;" class="confirm_btn updateUserInfo">保存</a>
		<!--                            <a href="javascritp:;" class="gray_btn">取消</a>-->
					</li>
		                    </ul>
		                  </div>
		            </div>
	            </form>
    </div>
    <!--end-->
</div>
<!--上传图像-->
<div class="shade_box" style="display:none;"></div>
<div class="pop_up_profile clearfix avatar" style="margin-top:-178px;display:none;">
    <h3 class="title">上传头像</h3>
    <a href="javascript:;" class="cross"></a>
    <div class="pop_up_photo">
        <div class="left">
            <img src="/portal/images/green/member_logo.jpg" alt="" id="member_img" name="filename" height="200px" width="200px">
	</div>
	<div class="right">
            <form enctype="multipart/form-data" target="uploadImageframe" method="post" action="commonAjaxFileUpload?fileId=upfile" name="uploadFrom" id="uploadFrom">
            <p class="upload_btn_line" style="cursor: pointer;"><span class="border_btn upload_btn" style="cursor: pointer;">从您的电脑中上传照片<input id="uploadeImg" name="upfile" type="file"></span></p>
            </form>
            <div class="pop_up_photo_tips">
                <p>从电脑中选择你喜欢的照片</p>
		<p>你可以上传JPG、JPEG、GIF、PNG或BMP文件</p>
            </div>
            <div class="pop_up_photo_tips">
            	建议上传近距离的照片（比如大头照、特写），这样经过编辑后的头像会很清楚
            </div>
            <div class="pop_up_photo_tips">
                <input value="" id="member_img_new_save" type="hidden">
		<a href="javascript:;" class="confirm_btn" id="doUploadeImg">保存头像</a>
            </div>
	</div>
    </div>
    <iframe src="" style="display:none;" name="uploadImageframe" height="0" width="0"></iframe>
</div>
<div class="pop_up_profile clearfix" style="margin:-152px 0 0 -226px;width:200px; display: none;" id="mesg_tankuang">
    <a href="javascript:;" class="cross"></a>
    <p>操作成功</p>
</div>
