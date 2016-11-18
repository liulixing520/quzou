<div class="nav_wrap">
    <div class="nav">
        <div class="wrap">
            <ul class="nav_ul fl ">
                <li <#if "${curNav}"=="jzrz" > class="cur"</#if> ><a href="customerLogList">健走日志</a></li>
                <li <#if "${curNav}"=="hygl"> class="cur"</#if> ><a href="customerList">会员管理</a></li>
                <li <#if "${curNav}"=="tdgl"> class="cur"</#if> ><a href="companyAndDeptList">团队管理</a></li>
                <li <#if "${curNav}"=="jcss"> class="cur"</#if> ><a href="competitionList">精彩赛事</a></li>
                <li <#if "${curNav}"=="drx"> class="cur"</#if> ><a href="talentShowList">达人秀</a></li>
                <li <#if "${curNav}"=="qxz"> class="cur"</#if> ><a href="securityGroup">权限组</a></li>
            </ul>
             <#if "${curNav}"=="jcss"><div class="nav_r ri tr"><a href="addCompetition">+新建赛事</a></div></#if>
             <#if "${curNav}"=="hygl"><div class="nav_r ri tr"><a href="addCustomer">+新建会员</a></div></#if>
             <#if "${curNav}"=="drx"><div class="nav_r ri tr"><a href="addTalentShow">+新建达人秀</a></div></#if>
             <#if "${curNav}"=="tdgl"><div class="nav_r ri tr"><a href="addDept">+新建团队</a></div></#if>
             <#if "${curNav}"=="qxz"><div class="nav_r ri tr"><a href="addSecurityGroup">+分配权限</a></div></#if>
        </div>
    </div>
</div>