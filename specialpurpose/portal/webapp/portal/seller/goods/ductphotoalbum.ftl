<link rel="stylesheet" type="text/css" href="../seller/css/seller.css">
<link rel="stylesheet" type="text/css" href="../seller/css/common20111215.css">
<script type="text/javascript" src="http://www.dhresource.com/seller/js/common.js"></script>
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="http://stats.g.doubleclick.net/dc.js"></script>
<script type="text/javascript" src="http://image.dhgate.com/dhs/mos/js/public/menu-common_20111226.js"></script>
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery.simplemodal2.js?ver=2012-09-27"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/basic.css" media="screen">
<style type="text/css">
	<!--
	#modalContainer{height:auto;width:auto;}
	-->	
	</style>
<!-- IE 6 hacks -->
<link rel="stylesheet" type="text/css" href="../seller/css/seller_button.css">
<link rel="stylesheet" type="text/css" href="../seller/css/general_popup_box.css">
<link rel="stylesheet" type="text/css" href="../seller/css/photo.css">
<script type="text/javascript" src="http://js.dhresource.com/seller/searchfilter/filter.js"></script>
<script type="text/javascript" src="js/albums.js"></script>
<script type="text/javascript" src="js/albumsupload.js"></script>
<link rel="stylesheet" type="text/css" href="../seller/css/uploadify.css?ver=$jsverion">
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/uploadjs/swfobject.js?ver=$jsverion"></script>
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/uploadjs/jquery.uploadify.v2.1.0.js?ver=$jsverion"></script>
<script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/matrix/jquery.dragsort.js"></script>
<style>
        p.uploadnotice {
            background: url("http://image.dhgate.com/2008/web20/seller/img/reg_image/reg_bottom_icon10.gif") no-repeat scroll 11px 10px #FEFAD5;
            border: 1px solid #E4DB92;
            color: #ff0000;
            height: 100%;
            line-height: 20px;
            margin-bottom: 8px; 
        }

    </style>
<div class="content">
  <div class="crumb"> <a href="http://seller.dhgate.com/mydhgate/index.do">我的DHgate</a><span>&gt;</span><a href="http://seller.dhgate.com/prodmanage/shelf/prodShelf.do?dhpath=10001,21001,0202">产品</a><span>&gt;</span><a href="http://seller.dhgate.com/album/albumsmanagerlist.do?act=pageload&amp;dhpath=10001,0211">产品相册</a><span>&gt;</span>相册管理 </div>
  <div class="layout clearfix">
    <div class="col-main">
      <div class="col-main-warp">
        <div id="right">
          <script type="text/javascript" src="http://image.dhgate.com/2008/web20/seller/js/syi/jquery.simplemodal2.js"></script>
          <div id="popcon"></div>
          <!--图片上传弹出窗口开始-->
          <!--图片上传弹出窗口开始-->
          <style type="text/css">
	#fileuploadUploader{
    	background:url(http://www.dhresource.com/dhs/mos/image/album/upload.gif) no-repeat 0 0;
    	/*background:url(http://image.dhgate.com/uploadjs/upload.gif) no-repeat 0 0;*/
    	background-position:center;  
    	border:0; 
    	margin:0; 
    	padding:0; 
    	vertical-align:top;
    	width: 125px;
    	height: 30px;
	}
</style>
          <div style="width: 550px; display: none;" id="uploadpicModalContent" class="tc_warp">
            <form id="AlbumsUploadManagerForm" method="post" name="AlbumsUploadManagerForm" action="albumsupload.do">
              <div id="DHPopBar" class="tc_title">
                <dl>
                  <dt>上传图片 </dt>
                  <dd><a onclick="delUploadInfo();return false;" href="javascript:void(0)"> <img alt="close" src="http://image.dhgate.com/2008/web20/seller/img/reg_image/new_tc_close.gif"></a> </dd>
                </dl>
              </div>
              <div class="tc_main">
                <div class="tc_content">
                  <div class="box2">
                    <div class="s-margin2">
                      <p> 选择图片 <span style="vertical-align: middle;">
                        <input style="visibility: hidden;" id="fileupload" name="fileupload" type="file">
                        </span> <a title="相册问题帮助" href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0320&amp;cate=我的相册&amp;artid=9528F7016B771102E0400A0AD40A55D5" target="_blank"> <img src="http://image.dhgate.com/dhs/mos/image/syi/syi-help1.png"> </a> </p>
                      <p class="color2"> 图片上传后，您可以用鼠标调整图片添加的先后顺序 </p>
                      <br>
                      <p style="padding: 8px 0px 8px 33px; color: red; display: none;" id="p_queuesizelimit" class="uploadnotice">
                      <p style="padding: 8px 0px 8px 33px; color: red; display: none;" id="p_allcomplete" class="uploadnotice"> </p>
                      <div id="fileQueue"> </div>
                      <style type="text/css">	
                        		#imguplist {width:450px; list-style-type:none; margin:0px;  padding:0px; }
                        		#imguplist li { float:left; padding:2px; width:100px; height:100px; }
                        		#imguplist div{ width:90px; height:90px; border:solid 1px black; background-color:#E0E0E0; text-align:center; padding-top:5px; }
                        		.placeHolder div { background-color:white !important; border:dashed 1px gray !important; }								
                        	</style>
                      <div class="clearfix">
                        <ul id="imguplist">
                          <li>
                            <div> <img id="imgshowurl_1" src="http://image.dhgate.com/nophoto.jpg" width="80" height="80">
                              <input id="imgurl_1" name="imgurl_1" value="" type="hidden">
                              <input id="imgmd5_1" name="imgmd5_1" value="" type="hidden">
                              <input id="localfilename_1" name="localfilename_1" value="" type="hidden">
                              <input id="imgsize_1" name="imgsize_1" value="" type="hidden">
                              <button style="display: none;" id="button_1" onmousedown="event.cancelBubble=true;" onclick="delhtml('1')" type="button"> <span style="color: rgb(255, 255, 255);"><span class="button2_ri">移除</span></span> </button>
                            </div>
                          </li>
                          <li>
                            <div> <img id="imgshowurl_2" src="http://image.dhgate.com/nophoto.jpg" width="80" height="80">
                              <input id="imgurl_2" name="imgurl_2" value="" type="hidden">
                              <input id="imgmd5_2" name="imgmd5_2" value="" type="hidden">
                              <input id="localfilename_2" name="localfilename_2" value="" type="hidden">
                              <input id="imgsize_2" name="imgsize_2" value="" type="hidden">
                              <button style="display: none;" id="button_2" onmousedown="event.cancelBubble=true;" onclick="delhtml('2')" type="button"> <span style="color: rgb(255, 255, 255);"><span class="button2_ri">移除</span></span> </button>
                            </div>
                          </li>
                          <li>
                            <div> <img id="imgshowurl_3" src="http://image.dhgate.com/nophoto.jpg" width="80" height="80">
                              <input id="imgurl_3" name="imgurl_3" value="" type="hidden">
                              <input id="imgmd5_3" name="imgmd5_3" value="" type="hidden">
                              <input id="localfilename_3" name="localfilename_3" value="" type="hidden">
                              <input id="imgsize_3" name="imgsize_3" value="" type="hidden">
                              <button style="display: none;" id="button_3" onmousedown="event.cancelBubble=true;" onclick="delhtml('3')" type="button"><span style="color: rgb(255, 255, 255);"><span class="button2_ri">移除</span></span></button>
                            </div>
                          </li>
                          <li>
                            <div> <img id="imgshowurl_4" src="http://image.dhgate.com/nophoto.jpg" width="80" height="80">
                              <input id="imgurl_4" name="imgurl_4" value="" type="hidden">
                              <input id="imgmd5_4" name="imgmd5_4" value="" type="hidden">
                              <input id="localfilename_4" name="localfilename_4" value="" type="hidden">
                              <input id="imgsize_4" name="imgsize_4" value="" type="hidden">
                              <button style="display: none;" id="button_4" onmousedown="event.cancelBubble=true;" onclick="delhtml('4')" type="button"> <span style="color: rgb(255, 255, 255);"><span class="button2_ri">移除</span></span> </button>
                            </div>
                          </li>
                        </ul>
                      </div>
                      <br>
                      <p>将图片保存至：&nbsp;
                        <select style="width: 180px;" id="selectalbumswindowid" name="selectalbumswindowid">
                          <option value="2cecab61-8ac7-4e42-8a5f-101e09ef3f88">默认相册</option>
                        </select>
                      </p>
                      <br>
                      <p>请使用jpg格式，图片尺寸需大于250*250，图片文件需小于200K。<br>
                        <span class="color2">图片上不能包含除敦煌网以外的任何联系方式。</span> </p>
                      <div id="div_saveUploadInfo" class="tc_content_button center"> <strong style="display: none;" id="localupdateimeErrTip" class="error-img-text">您尚未添加任何图片</strong><br>
                        <button onclick="javascript:saveUploadInfo();" type="button"> <span style="color: rgb(255, 255, 255);" class="button1_lt"><span class="button1_ri">保存</span></span> </button>
                          
                        <button onclick="javascript:delUploadInfo();" type="button"> <span style="color: rgb(255, 255, 255);" class="button2_lt"><span class="button2_ri">关闭</span></span> </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <input id="functionname" name="functionname" value="albu" type="hidden">
              <!--功能名   	不可以为空-->
              <input id="imagebannername" name="imagebannername" value="sunvsoft" type="hidden">
              <!--水印名  现在是用户名-->
              <input id="supplierid" name="supplierid" value="ff808081482fd3fd01485e24266e5056" type="hidden">
              <input id="token" name="token" value="-hwBEsUCl5XyIYsFzQ8sOb0lT30Yqz4pGvoKVf0taPBNi0fS9CxnD4MNhppTzCYZm15SvLgyphrdlcDEEKsw6lhfnPsOSZOSY_8yF9PgrTU" type="hidden">
              <input id="act_upload" name="act" value="" type="hidden">
            </form>
          </div>
          <!--图片上传弹出窗口结束-->
          <script type="text/javascript">
        function saveUploadInfo(){
        	var imgurl_1 =jQuery('#imgurl_1').val();
        	var imgurl_2 =jQuery('#imgurl_2').val();
        	var imgurl_3 =jQuery('#imgurl_3').val();
        	var imgurl_4 =jQuery('#imgurl_4').val();
        	if(imgurl_1!="" || imgurl_2 || imgurl_3 || imgurl_4){
        		document.getElementById("act_upload").value="saveuploadinfo";
        		//alert(document.getElementById("imgurl_1").value);
        		$("#AlbumsUploadManagerForm").submit();
        	}else{
        		alert("请选择要上传的图片！");
        	}
        }
    </script>
          <!--图片上传弹出窗口结束-->
          <form id="albumsManagerListForm" method="post" name="albumsManagerListForm" action="albumsmanagerlist.do">
            <div id="container-4">
              <div>
                <div class="photo_mes">
                  <div class="photo_mes2">
                    <div class="fl">您共有1个相册，20张图片。目前您已使用150 M中的16.38M，占总容量的10.92%</div>
                    <div class="fr">
                      <button onclick="showUploadWin('','','')" type="button"> <span style="color: rgb(255, 255, 255);" class="button1_lt"><span class="button1_ri">上传图片</span></span> </button>
                        
                      <script type="text/javascript">
				//打开上传图片弹出框, iPicIndex; >0 是修改产品  -1为新增图片   图片上传标志位第几个图片  addshow('popcon','6','$vo.tdalbumswindowid');
                function showUploadWin(){
					jQuery('#uploadpicModalContent').modal({close:false}); //打开弹出窗口，隐藏缺省的close button。
					initUploadify();
		        }
            </script>
                      <button onclick="addshow('popcon','1','');" type="button"> <span style="color: rgb(255, 255, 255);" class="button1_lt"><span class="button1_ri">创建相册</span></span> </button>
                    </div>
                  </div>
                </div>
              </div>
              <div class="buy_list mar_t5">
                <div class="photo_list">
                  <dl>
                    <dt> <a class="listimgs" href="albumsmanager.do?act=pageload&amp;tdalbumswindowid=2cecab61-8ac7-4e42-8a5f-101e09ef3f88"> <img class="listimgs" src="http://image.dhgate.com/2008/web20/seller/img/album/test1.gif"> </a> </dt>
                    <dd><span title="默认相册">默认相册(20 张) (不公开) </span><br>
                    </dd>
                  </dl>
                </div>
                <div id="page">
                  <script language="javascript">
	    function turnpage (pagenum,frm){
			if(frm==null || frm==''){
				frm=document.getElementById('albumsManagerListForm');
			}else{
				frm=document.getElementById(frm);
			}
			frm.page.value=pagenum;
			frm.submit ();
		}
		//按钮提交
		function subpage (pages,frm){
			if(frm==null || frm==''){
				frm=document.getElementById('albumsManagerListForm');
			}else{
				frm=document.getElementById(frm);
			}
			var pagenum = document.getElementById("pageid").value;
			//超过最大页 ， 取最大页
			if(eval(pagenum) > eval(pages)){
				pagenum = pages;
			}
			frm.page.value=pagenum;
			frm.submit ();
		}
		//判断输入框中的只能是数字，不是数字则置空
		function getPageNum(obj){
			var str = obj.value;
			if(!validateNum(str)){
				obj.value="";
			}
		}
		//判断数字//wuzhonghua
		//由数字组成 true  否则false
		function validateNum(str){
	    	var patn = /^[0-9-\/]+$/;  //正则表达式，不是数字
	    	if(patn.test(str)) return true;
	
			return false;
		}
	</script>
                  <div id="page">
                    <table border="0" cellSpacing="0" cellPadding="0" width="100%">
                      <tbody>
                        <tr>
                          <td class="le">共有记录1条，每页显示40条</td>
                          <td class="ri"><span><a href="javascript:turnpage(1,'albumsManagerListForm')"> <img alt="首页" src="http://image.dhgate.com/2008/web20/seller/img/img_10.gif"></a> </span> <span class="tt2"><a href="javascript:turnpage(1,'albumsManagerListForm')">上一页</a></span> <span><b>1</b></span> <span class="tt3"><a href="javascript:turnpage('1','albumsManagerListForm')">下一页</a></span> <span><a href="javascript:turnpage('1','albumsManagerListForm')"> <img alt="尾页" src="http://image.dhgate.com/2008/web20/seller/img/img_13.gif"></a> </span> <span>到
                            <input id="pageid" onkeyup="getPageNum(this)" name="page" value="" size="2" type="text">
                            页
                            <input id="button" onclick="javascript:subpage('1','albumsManagerListForm')" name="button3" value="GO" type="button">
                            </span> </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
              <div class="s_notice_1">
                <p><img class="seller-icon11" src="http://image.dhgate.com/2008/web20/seller/img/blank.gif" width="14" height="14">您目前拥有的相册空间大小为150 M。&nbsp;&nbsp; <a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0320&amp;cate=我的相册&amp;artid=952821D6164F6ADFE0400A0AD50A3C22" target="_blank">查看相册使用攻略</a>&nbsp;&nbsp; <a href="http://help.dhgate.com/dhgate/sellerhelpcn.php?catid=0320&amp;cate=我的相册&amp;artid=9528450F916C443BE0400A0AD20A6ED6" target="_blank">如何上传优质图片？</a></p>
              </div>
            </div>
            <input id="act" name="act" value="$act" type="hidden">
          </form>
        </div>
      </div>
    </div>
    
   <#-- left bar -->
  	${screens.render("component://portal/widget/SellerScreens.xml#goodsLeftbar")}
 

  </div>
</div>
