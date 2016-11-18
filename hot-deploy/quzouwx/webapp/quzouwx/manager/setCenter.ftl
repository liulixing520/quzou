<!--表单验证框架-->
<body style="background-color: #fff"> 
	<div class="sz_box">
	    <div class="sz_wechat">
            <img src="../quzouwx/images/bgsz_top.png" />    	    
        </div>
        <div class="sz_topwz">
            <div class="grzx"><img src="${(userInfo.headimgurl)!}" /></div>
            <p>${(userInfo.nickname)!}</p>
        </div>        
        <form action="updateSetCustomer" name="MyForm" id="MyForm" method="post">
        <div style="background-image:url(../quzouwx/images/jybg.png);min-height:580px;">
            <dl class="sz_list" >
                <dd style="height: 30px">
                    <div>
                        <img style="width: 75%;" src="../quzouwx/images/geren.png"  />
                    </div>
                    <p style="font-size:21px;color:#666;line-height:30px;">个人信息</p>
                </dd>
                <dd style="width:35%;height:4px; border-bottom:2px solid #6ec7ff;margin-top:-15px;margin-left:10px;"></dd>
    	        <dd style="border-top:1px solid #6ec7ff;">
                    <div style="width:50%;"><p>用户名</p></div>
                    <div style="width:50%;text-align:left;"><p>${(customer.userLoginId)!}</p></div>
                    <input type="hidden" name="userLoginId" value="${(customer.userLoginId)!}" />
                    <input type="hidden" name="partyId" value="${(customer.partyId)!}" />
                </dd>
                <dd>
                    <div style="width:50%;"><p>性别</p></div>
                    <div style="width:50%;">
	                    <input type="radio" class="sz_inputr"  name="gender" <#if "${(customer.gender)!}"=="M">checked="checked"</#if>  value="M" /><div style="margin-top:5px;margin-left:5px;">男</div>  
	                    <input type="radio" class="sz_inputr"  name="gender" <#if "${(customer.gender)!}"=="F"||!customer?has_content>checked="checked"</#if> value="F" /> <div style="margin-top:5px;margin-left:5px;">女</div>  
                    </div>
                </dd>
                <dd>
                     <div style="width:50%;"><p>生日</p></div>
                     <div style="width:50%;"><input type="text" class="sz_input"  style="width: 75%;" name="birthDate" placeHolder="请输入" value="${(customer.birthDate?string("yyyy-MM-dd"))!}" onchange="$('#constellation').val(autoParseConstellation(this.value))" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></div>
                </dd>
                <dd>
                    <div style="width:50%;"> <p>体重</p></div>
                    <div style="width:50%;">
                    	<input type="text" class="sz_inputdw" style="width: 15%;" name="weight"  value="${(customer.weight)!}"/>
                    	<div style="margin-top:5px;">kg</div>                    
                    </div>
                </dd>
                <dd>
                    <div style="width:50%;"><p>身高</p></div>
                    <div style="width:50%;">
	                    <input type="text" class="sz_inputdw" style="width: 20%;" name="height"  style="width: 10%;"value="${(customer.height)!}"/>
	                    <div style="margin-top:5px;">cm</div> 
                    </div>
                </dd>
                <dd style="width:100%;height:1px; border-bottom:1px solid #6ec7ff;margin-top:0px;margin-left:10px;"></dd>
                <dd>                    
                     <div style="width:50%;"><p>手机号</p></div>
                     <div style="width:50%;"><input type="tel" class="sz_input" style="width: 85%;" placeHolder="请输入" name="telephone" value="${(customer.telephone)!}"/></div> 
                </dd>
                <dd>
                    <div style="width:50%;"><p>邮箱</p></div>
                    <div style="width:50%;"> <input type="text" class="sz_input" style="width: 85%;" placeHolder="请输入" name="email" value="${(customer.email)!}"/> </div>
                </dd>
                <dd>
                    <div style="width:50%;"><p>单位</p></div>
                    <div style="width:50%;"><p>${(customer.companyName)!}</p></div>
                </dd>
            </dl>
            <div class="sz_baocun">
                <div>
                    <img src="../quzouwx/images/baocun.png" />
                </div>            
            </div>
        </div>
        </div>
    </div>
</body>
<script>
	$(".sz_baocun").click(function(){
	     checkAndSubmit();
	});
	
function checkAndSubmit(){
	document.MyForm.submit();
}
</script>
