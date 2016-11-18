    <#-- 用户头像，个人信息,修改，退出等-->
    <div class="avatar trs-right">
		<#if "${(person.gender)!}"=="M">
    		<img src="../images/images/img/boyHeader_s.png" class="b_m_title" />
    	<#else>
    		<img src="../images/images/img/girlHeader_s.png" class="b_m_title" />
		</#if>
        <ul class="avatar_ul">
            <#-- <li><a href="#">个人资料</a></li>
            <li><a href="#">修改密码</a></li>-->
            <li><a href="logout">退出登录</a></li>

        </ul>
    </div>

    
