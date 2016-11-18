<div class="mod hot-new-area" id="hotNew">
<div class="mod-hd">
    <h3>${uiLabelMap.PortalHotNew}</h3>
</div>
<div class="mod-box">
<div class="industry-type" id="tabbedIndustryMenus">
    <ul class="util-clearfix">
    	 <li data-industryid="100"   class="on-click" isrequest="true" >
            <div class="industry-t3">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewWomen}</a>
                <span class="line"></span>
            </div>
        </li>
        <li data-industryid="102">
            <div class="industry-t1">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewMobilePhone}</a>
                <span class="line"></span>
            </div>
        </li>
        <li data-industryid="101">
            <div class="industry-t2">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewComputer}</a>
                <span class="line"></span>
            </div>
        </li>
       
        <li data-industryid="111">
            <div class="industry-t4">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewWomenShoes}</a>
                <span class="line"></span>
            </div>
        </li>
        <li data-industryid="104">
            <div class="industry-t5">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewFemalePackage}</a>
                <span class="line"></span>
            </div>
        </li>
        <li data-industryid="105">
            <div class="industry-t6">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewJewelry}</a>
                <span class="line"></span>
            </div>
        </li>
        <li data-industryid="106">
            <div class="industry-t7">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewHairdressing}</a>
                <span class="line"></span>
            </div>
        </li>
        <li data-industryid="107">
            <div class="industry-t8">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewKids}</a>
                <span class="line"></span>
            </div>
        </li>
        <li data-industryid="112">
            <div class="industry-t9">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewHousehold}</a>
                <span class="line"></span>
            </div>
        </li>
        <li data-industryid="109">
            <div class="industry-t10">
                <a href="javascript:void(0)">${uiLabelMap.PortalHotNewOutdoor}</a>
                <span class="line"></span>
            </div>
        </li>
    </ul>
</div>
<!--skylight-wholesale/newhome/industry_navigation.html -end -->
<div class="tabbed-pane-panel">
<!--TMS:1088006-->
<div class="industry-main"  style="z-index: 6; opacity: 1;">
      <#-- 
    <div class="industry-active-main">
      
        <a href="<@ofbizCatalogAltUrl productCategoryId='C002001' previousCategoryId='C002' />">
            <img src="../images/TB1z5wDGXXXXXc_XXXXZ1Mu2pXX-190-385.jpg" width="190" height="385">
            	<div class="txt-mask-layer"><span><font class="OUTFOX_JTR_TRANS_NODE">最新的可穿戴技术</font></span></div>
        	</a>
    	</div> 
     
            ${setRequestAttribute("optProductId", productId)}
            ${setRequestAttribute("listIndex", productId_index)}
            ${setRequestAttribute("productIndex", productId_index+1)}
              ${setRequestAttribute("categoryText", "最新的可穿戴技术")}
            -->
          
        <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C001003' previousCategoryId='C001' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/women2.png" width="190" height="385" />
     	<#--  
        <div class="txt-mask-layer">
         <span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        </div>
        --> 
      		</a> 
		</div> 
         ${setRequestAttribute("productCategoryId", "C002001")}
         ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")}
     </div> 
     <!--TMS:1088584--> 
     <div class="industry-main"> 
     <!--
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C001003' previousCategoryId='C001'/>"> 
       	<img src="../images/shouji2.jpg" width="190" height="385" alt="Smart Phones, A Smarter You" /> 
        <div class="txt-mask-layer"> 
         <span> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-669" rel="669"> 智能手机、聪明的你 </font> </span> 
        </div> </a> 
      </div>
      	${setRequestAttribute("categoryText", "智能手机 聪明的你")}
      -->
        <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C001001' previousCategoryId='C001' />" class="industry-active-pic"> 
     		<img src="../images/computerliujisong.png" width="190" height="385" />
     	<#--  
        <div class="txt-mask-layer">
         <span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        </div>
        --> 
      		</a> 
		</div>
       ${setRequestAttribute("productCategoryId", "C001001")}
            ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")}
         <!--
      <div class="keywords-area"> 
       <span class="title"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-670" rel="670"> 热门搜索: </font> </span> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-671" rel="671"> MTK6592 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-672" rel="672"> MTK6589T </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-673" rel="673"> 四核手机 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-674" rel="674"> 三星Galaxy S3 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-675" rel="675"> 安卓手机 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-676" rel="676"> 华为手机 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-677" rel="677"> 联想手机 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-678" rel="678"> 例iPhone 5 s </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-679" rel="679"> 例星系S4 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-680" rel="680"> 例iPhone 5 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-681" rel="681"> 持有者&amp;站 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-682" rel="682"> 防水手机套 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-683" rel="683"> 手机保护套的权力 </font> </a> 
      </div> 
      <div class="activity-area"> 
       <ul class="util-clearfix"> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://img.alibaba.com/images/cms/upload/promotion/anqi/update/t100s.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="MTK6592 Octa Cores Phones" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-684" rel="684"> MTK6592八面体核心的手机 </font> </span> </a> </li> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms04.alicdn.com/tps/i4/TB13fUYFVXXXXbKXXXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="MTK6582 Quad Cores Phones" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-685" rel="685"> MTK6582四核手机 </font> </span> </a> </li> 
       </ul> 
      </div>
      --> 
     </div> 
     <!--TMS:1088903--> 
     <div class="industry-main"> 
    <!--
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C001001' previousCategoryId='C001'/>" class="industry-active-pic"> 
       	<img src="../images/bijiben2.jpg" width="190" height="385" /> 
        <div class="txt-mask-layer">
         <span><font class="OUTFOX_JTR_TRANS_NODE">新同方笔记本电脑</font></span>
        </div> </a> 
      </div> 
      <div class="recommend-goods"> 
       <ul class="g-items-list util-clearfix"> 
        <li class="item-cell"> <a href=""> 
          <div class="g-pic">
           <img src="../images/05.jpg" />
          </div> <span class="g-title"><font class="OUTFOX_JTR_TRANS_NODE">随身碟</font></span> </a> </li> 
        <li class="item-cell"> <a href=""> 
          <div class="g-pic">
           <img src="../images/06.jpg" />
          </div> <span class="g-title"><font class="OUTFOX_JTR_TRANS_NODE">随身碟</font></span> </a> </li> 
        <li class="item-cell"> <a href=""> 
          <div class="g-pic">
           <img src="../images/07.jpg" />
          </div> <span class="g-title"><font class="OUTFOX_JTR_TRANS_NODE">随身碟</font></span> </a> </li> 
        <li class="item-cell"> <a href=""> 
          <div class="g-pic">
           <img src="../images/08.jpg" />
          </div> <span class="g-title"><font class="OUTFOX_JTR_TRANS_NODE">随身碟</font></span> </a> </li> 
        <li class="item-cell"> <a href=""> 
          <div class="g-pic">
           <img src="../images/05.jpg" />
          </div> <span class="g-title"><font class="OUTFOX_JTR_TRANS_NODE">随身碟</font></span> </a> </li> 
        <li class="item-cell"> <a href=""> 
          <div class="g-pic">
           <img src="../images/06.jpg" />
          </div> <span class="g-title"><font class="OUTFOX_JTR_TRANS_NODE">随身碟</font></span> </a> </li> 
        <li class="item-cell"> <a href=""> 
          <div class="g-pic">
           <img src="../images/07.jpg" />
          </div> <span class="g-title"><font class="OUTFOX_JTR_TRANS_NODE">随身碟</font></span> </a> </li> 
        <li class="item-cell"> <a href=""> 
          <div class="g-pic">
           <img src="../images/08.jpg" />
          </div> <span class="g-title"><font class="OUTFOX_JTR_TRANS_NODE">随身碟</font></span> </a> </li> 
       </ul> 
      </div> 
         ${setRequestAttribute("categoryText", "新同方笔记本电脑")}
      -->
        <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C001002' previousCategoryId='C001' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/mobil.png" width="190" height="385" />
     		<#--  
        	<div class="txt-mask-layer">
         	<span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        	</div>
        	--> 
      		</a> 
		</div>
        ${setRequestAttribute("productCategoryId", "C001002")}
        ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")}
     </div> 
     <!--TMS:1088904--> 
     <div class="industry-main">
      <!-- 
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C009002' previousCategoryId='C009'/>"> 
       	<img src="../images/yundongxie2.jpg" width="190" height="385" alt="Up to 60% off Skiing &amp; Snowboarding Products" /> 
        <div class="txt-mask-layer"> 
         <span> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-707" rel="707"> 滑雪和滑板滑雪产品高达60% </font> </span> 
        </div> </a> 
      </div>
     
      <div class="recommend-goods"> 
      </div> 
      <div class="keywords-area"> 
       <span class="title"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-708" rel="708"> 热门搜索: </font> </span> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-709" rel="709"> 骑自行车的衣服 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-710" rel="710"> 徒步旅行夹克 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-711" rel="711"> 睡袋 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-712" rel="712"> 耐克 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-713" rel="713"> 篮球鞋 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-714" rel="714"> 足球鞋 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-715" rel="715"> 鱼饵 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-716" rel="716"> 阿迪达斯 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-717" rel="717"> 跑步鞋 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-718" rel="718"> paracord </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-719" rel="719"> 自行车的光 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-720" rel="720"> 瑜伽 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-721" rel="721"> 网球齿轮 </font> </a> 
      </div> 
      <div class="activity-area"> 
       <ul class="util-clearfix"> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms04.alicdn.com/tps/i4/TB1ht3_GpXXXXa8XpXXwu0bFXXX.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Enjoy The &lt;br /&gt; Active Lifestyle" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-722" rel="722"> 享受 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-723" rel="723"> 积极的生活方式 </font> </span> </a> </li> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms03.alicdn.com/tps/i3/TB1GfYgFVXXXXX3XXXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Loving Outdoor &lt;br /&gt; Up to 50% off" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-724" rel="724"> 爱户外 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-725" rel="725"> 高达50% </font> </span> </a> </li> 
       </ul> 
      </div>
       ${setRequestAttribute("categoryText", "滑雪和滑板滑雪产品高达60%")}
      -->
       <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C003002004' previousCategoryId='C003002' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/women.png" width="190" height="385" />
     		<#--  
        	<div class="txt-mask-layer">
         	<span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        	</div>
        	--> 
      		</a> 
		</div>
        ${setRequestAttribute("productCategoryId", "C003002004")}
        ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")}
     </div> 
     <!--TMS:1088908--> 
     <div class="industry-main">
      <!-- 
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C007003' previousCategoryId='C007'/>"> 
       	<img src="../images/huanzhuang2.jpg" width="190" height="385" alt="The latest in hair" /> 
        <div class="txt-mask-layer"> 
         <span> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-726" rel="726"> 最新的头发 </font> </span> 
        </div> </a> 
      </div>
      
      <div class="recommend-goods"> 
      </div> 
      <div class="keywords-area"> 
       <span class="title"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-727" rel="727"> 热门搜索: </font> </span> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-728" rel="728"> 头发编织 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-729" rel="729"> 丝绸基地关闭 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-730" rel="730"> 巴西体波 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-731" rel="731"> 秘鲁的头发 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-732" rel="732"> 全蕾丝假发 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-733" rel="733"> 夹在头发 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-734" rel="734"> 动漫假发 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-735" rel="735"> 颜色深浅渐进的头发 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-736" rel="736"> 品牌的头发 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-737" rel="737"> 古怪的花 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-738" rel="738"> 头发辊 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-739" rel="739"> 头发修剪机 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-740" rel="740"> 头发拉直器 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-741" rel="741"> 指甲凝胶 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-742" rel="742"> 面对护理 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-743" rel="743"> 眼影 </font> </a> 
      </div> 
      <div class="activity-area"> 
       <ul class="util-clearfix"> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://img.alibaba.com/images/cms/upload/aliexpress/xuechenlu/120x120png/1532361768.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Brand Human Hair" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-744" rel="744"> 品牌的人类头发 </font> </span> </a> </li> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms04.alicdn.com/tps/i4/TB1YlYsGXXXXXcgXpXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Ombre Hair Extensions" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-745" rel="745"> 颜色深浅渐进的头发 </font> </span> </a> </li> 
       </ul> 
      </div>
        ${setRequestAttribute("categoryText", "最新的头发")}
      --> 
        <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C003001001' previousCategoryId='C003001' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/womenbag.png" width="190" height="385" />
     		<#--  
        	<div class="txt-mask-layer">
         	<span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        	</div>
        	--> 
      		</a> 
		</div>
       ${setRequestAttribute("productCategoryId", "C003001001")}
        ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")}
     </div> 
     <!--TMS:1088912--> 
     <div class="industry-main">
     <!--  
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C002002' previousCategoryId='C002'/>" class="industry-active-pic"> 
       	<img src="../images/nanzhuang2.jpg" width="190" height="385" alt="Men’s Fall &amp; Winter Jackets" /> 
        <div class="txt-mask-layer"> 
         <span> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-746" rel="746"> 男人的秋季和冬季夹克 </font> </span> 
        </div> </a> 
      </div>
      <!-- 
      <div class="recommend-goods"> 
      </div> 
      <div class="keywords-area"> 
       <span class="title"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-747" rel="747"> 热门搜索: </font> </span> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-748" rel="748"> 马球 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-749" rel="749"> 衬衫 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-750" rel="750"> 拳击手 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-751" rel="751"> 夹克 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-752" rel="752"> 牛仔裤 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-753" rel="753"> 宽松的裤子 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-754" rel="754"> 在户外 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-755" rel="755"> 瘦身的 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-756" rel="756"> 男人的袜子 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-757" rel="757"> 上衣 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-758" rel="758"> 西装 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-759" rel="759"> 随意的男人 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-760" rel="760"> 背心 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-761" rel="761"> 外套 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-762" rel="762"> 海滩 </font> </a> 
      </div> 
      <div class="activity-area"> 
       <ul class="util-clearfix"> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms02.alicdn.com/tps/i2/TB1WtQmFVXXXXawaXXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Down &amp; Parkas &lt;br /&gt;Up to 60% off" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-763" rel="763"> 下来和大衣 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-764" rel="764"> 高达60% </font> </span> </a> </li> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms04.alicdn.com/tps/i4/TB1e7kNFVXXXXaMXFXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Fleece Hoodies&lt;br /&gt;Up to 50% off" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-765" rel="765"> 羊毛帽衫 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-766" rel="766"> 高达50% </font> </span> </a> </li> 
       </ul> 
      </div>
       ${setRequestAttribute("categoryText", "男人的秋季和冬季夹克")}
      -->
        <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C008001' previousCategoryId='C008' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/shoushi.png" width="190" height="385" />
     		<#--  
        	<div class="txt-mask-layer">
         	<span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        	</div>
        	--> 
      		</a> 
		</div>
        ${setRequestAttribute("productCategoryId", "C008001")}
        ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")} 
     </div> 
     <!--TMS:1088913--> 
     <div class="industry-main">
    <!--  
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C002001' previousCategoryId='C002'/>" class="industry-active-pic"> 
       <img src="../images/nvzhuang2.jpg" width="190" height="385" alt="Fashion Channel" /> 
        <div class="txt-mask-layer"> 
         <span> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-767" rel="767"> 时尚频道 </font> </span> 
        </div> </a> 
      </div>
      
      <div class="recommend-goods"> 
      </div> 
      <div class="keywords-area"> 
       <span class="title"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-768" rel="768"> 热门搜索: </font> </span> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-769" rel="769"> 随意的衣服 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-770" rel="770"> 印花拖地长裙 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-771" rel="771"> 花边 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-772" rel="772"> 马克西礼服 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-773" rel="773"> 新奇的服装 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-774" rel="774"> 同学会服装 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-775" rel="775"> 刺绣 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-776" rel="776"> 高街 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-777" rel="777"> 模式 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-778" rel="778"> 雪纺 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-779" rel="779"> 婚纱礼服 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-780" rel="780"> 方 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-781" rel="781"> 红地毯 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-782" rel="782"> 复古连衣裙 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-783" rel="783"> 再加上大小 </font> </a> 
      </div> 
      <div class="activity-area"> 
       <ul class="util-clearfix"> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms01.alicdn.com/tps/i1/TB1zM..FFXXXXaLXXXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Back to School &lt;br /&gt;Prom Dresses" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-784" rel="784"> 回到学校 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-785" rel="785"> 毕业舞会服装 </font> </span> </a> </li> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms02.alicdn.com/tps/i2/TB1hak8FFXXXXahXVXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Variety Fashion&lt;br /&gt;Up to 30% off" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-786" rel="786"> 各种时尚 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-787" rel="787"> 高达30% </font> </span> </a> </li> 
       </ul> 
      </div>
        ${setRequestAttribute("categoryText", "时尚频道")}
      -->
       <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C009001' previousCategoryId='C009' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/hairs.png" width="190" height="385" />
     		<#--  
        	<div class="txt-mask-layer">
         	<span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        	</div>
        	--> 
      		</a> 
		</div>
        ${setRequestAttribute("productCategoryId", "C009001")}
        ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")} 
     </div> 
     <!--TMS:1088914--> 
     <div class="industry-main">
     <!--  
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C008002' previousCategoryId='C008'/>"> 
       <img src="../images/wanju2.jpg" width="190" height="385" alt="Up To 50% Off Kids Clothing &amp; Toys" /> 
        <div class="txt-mask-layer"> 
         <span> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-788" rel="788"> 多达50%的孩子衣服和玩具 </font> </span> 
        </div> </a> 
      </div>
      
      <div class="recommend-goods"> 
      </div> 
      <div class="keywords-area"> 
       <span class="title"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-789" rel="789"> 热门搜索: </font> </span> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-790" rel="790"> 服装集 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-791" rel="791"> 女孩衣服 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-792" rel="792"> 婴儿连裤童装 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-793" rel="793"> 孩子的外套 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-794" rel="794"> 凯蒂猫 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-795" rel="795"> 睡衣套 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-796" rel="796"> 儿童夹克 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-797" rel="797"> 儿童连帽衫 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-798" rel="798"> 女孩紧身裤 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-799" rel="799"> RC直升机 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-800" rel="800"> 粉红猪 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-801" rel="801"> 玩具的数据 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-802" rel="802"> 婴儿尿布袋 </font> </a> 
      </div> 
      <div class="activity-area"> 
       <ul class="util-clearfix"> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms01.alicdn.com/tps/i1/TB1ebcFGXXXXXa4XpXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Winter Outwear&lt;br /&gt;Up to 50% off" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-803" rel="803"> 冬天穿破 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-804" rel="804"> 高达50% </font> </span> </a> </li> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms02.alicdn.com/tps/i2/TB1K5QFGXXXXXaLXpXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Wooden Blocks&lt;br /&gt;Up to 60% off" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-805" rel="805"> 木积木 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-806" rel="806"> 高达60% </font> </span> </a> </li> 
       </ul> 
      </div>
      ${setRequestAttribute("categoryText", "多达50%的孩子衣服和玩具")}
      -->
        <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C005001' previousCategoryId='C005' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/children.png" width="190" height="385" />
     		<#--  
        	<div class="txt-mask-layer">
         	<span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        	</div>
        	--> 
      		</a> 
		</div>
       	${setRequestAttribute("productCategoryId", "C005001")}
        ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")} 
     </div> 
     <!--TMS:1088918--> 
     <div class="industry-main">
     <!-- 
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C003002' previousCategoryId='C003'/>"> 
       <img src="../images/deng2.jpg" width="190" height="385" alt="Latest Bedroom Decorating Styles" /> 
        <div class="txt-mask-layer"> 
         <span> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-807" rel="807"> 最新的卧室装修风格 </font> </span> 
        </div> </a> 
      </div>
     
      <div class="recommend-goods"> 
      </div> 
      <div class="keywords-area"> 
       <span class="title"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-808" rel="808"> 热门搜索: </font> </span> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-809" rel="809"> 墙Sticke </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-810" rel="810"> 床上用品 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-811" rel="811"> 活动和派对用品 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-812" rel="812"> 狗 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-813" rel="813"> 蛋糕工具 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-814" rel="814"> 金属工艺品 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-815" rel="815"> 窗帘 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-816" rel="816"> 存储箱和垃圾箱 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-817" rel="817"> 水果和蔬菜的工具 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-818" rel="818"> 厨房刀具 </font> </a> 
      </div> 
      <div class="activity-area"> 
       <ul class="util-clearfix"> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms01.alicdn.com/tps/i1/TB1t4fWGpXXXXbtXpXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Festive &amp; Party Supplies&lt;br /&gt;Up to 55% off" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-819" rel="819"> 节日和派对用品 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-820" rel="820"> 高达55% </font> </span> </a> </li> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms02.alicdn.com/tps/i2/TB1p1YGGpXXXXXSXVXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Pet Products&lt;br /&gt;Up to 40% off" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-821" rel="821"> 宠物用品 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-822" rel="822"> 高达40% </font> </span> </a> </li> 
       </ul> 
      </div>
    
        ${setRequestAttribute("categoryText", "最新的卧室装修风格")}
          -->
        <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C004001002' previousCategoryId='C004001' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/home.png" width="190" height="385" />
     		<#--  
        	<div class="txt-mask-layer">
         	<span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        	</div>
        	--> 
      		</a> 
		</div>
        ${setRequestAttribute("productCategoryId", "C004001002")}
        ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")} 
     </div> 
     <!--TMS:1088919--> 
     <div class="industry-main">
      <!-- 
      <div class="industry-active-main"> 
       <a href="<@ofbizCatalogAltUrl productCategoryId='C005001' previousCategoryId='C005'/>"> 
       	<img src="../images/zhubao2.jpg" width="190" height="385" alt="Jewelry &amp; Watch" /> 
        <div class="txt-mask-layer"> 
         <span> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-823" rel="823"> 珠宝与手表 </font> </span> 
        </div> </a> 
      </div>
     
      <div class="recommend-goods"> 
      </div> 
      <div class="keywords-area"> 
       <span class="title"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-824" rel="824"> 热门搜索: </font> </span> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-825" rel="825"> 钻戒 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-826" rel="826"> 手镯珠宝 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-827" rel="827"> 衣领项链 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-828" rel="828"> 下降的耳环 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-829" rel="829"> 首饰集 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-830" rel="830"> 珠子 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-831" rel="831"> 袖扣 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-832" rel="832"> 户外手表 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-833" rel="833"> 不锈钢的手表 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-834" rel="834"> 品牌手表 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-835" rel="835"> 衣服看 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-836" rel="836"> 民族耳环 </font> </a> 
       <a href=""> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-837" rel="837"> 手镯 </font> </a> 
      </div> 
      <div class="activity-area"> 
       <ul class="util-clearfix"> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms01.alicdn.com/tps/i1/TB1IsbDFVXXXXbNXVXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="August Charm &lt;br /&gt; Choker Necklace" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-838" rel="838"> 8月的魅力 </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-839" rel="839"> 项链项链 </font> </span> </a> </li> 
        <li> <a href=""> 
          <div class="activity-pic"> 
           <img img-src="http://gtms04.alicdn.com/tps/i4/TB1lIJiFVXXXXXVapXXrywt4VXX-120-120.png" src="http://i03.i.aliimg.com/images/cms/upload/wholesale/icons/opacity0.png" width="120" height="120" alt="Up to 70% off &lt;br /&gt;Trendy Jewelry" /> 
          </div> <span class="activity-name"> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-840" rel="840"> 高达70% </font> <br /> <font class="OUTFOX_JTR_TRANS_NODE" id="OUTFOX_JTR_TRANS_NODE-841" rel="841"> 时尚珠宝 </font> </span> </a> </li> 
       </ul> 
      </div> -->
     
         <div class="industry-active-main"> 
     		<a href="<@ofbizCatalogAltUrl productCategoryId='C007001' previousCategoryId='C007' />" class="industry-active-pic"> 
     		<img src="../images/newproduct/outdoor.png" width="190" height="385" />
     		<#--  
        	<div class="txt-mask-layer">
         	<span><font class="OUTFOX_JTR_TRANS_NODE">${productCategory.description?if_exists}</font></span>
        	</div>
        	--> 
      		</a> 
		</div>
        ${setRequestAttribute("productCategoryId", "C007001")}
        ${screens.render("component://portal/widget/CommonScreens.xml#keywordsearch")} 
     </div> 
    </div> 
   </div> 
  </div>