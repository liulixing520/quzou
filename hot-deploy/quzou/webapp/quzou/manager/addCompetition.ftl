<link type="text/css" href="../images/js/kindedit/themes/default/default.css" rel="stylesheet" />
<div class="wrap">
  <div class="add_product0">
      <form action="<#if entity??>updateCompetition<#else>createCompetition</#if>" enctype="multipart/form-data" name="EditCompetition" id="EditCompetition" method="post">
      <input type="hidden" name="cId" value="${(entity.cId)!}">

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100" height="47" align="right" class="productTdText ">赛事名称：</td>
          <td height="47" >
          	<input type="text" value="${(entity.cName)!}" name="cName" id="cName" class="product_input inp-text" style="width: 475px;" />
          </td>
          
          <td width="100" height="47" align="right" class="productTdText"></td>
          <td height="47">
      	  </td>
          <td width="385" rowspan="5" align="center" class="product_image">
            <span>
              <#assign cPic = "${(entity.cPic)!}">
              <#if !cPic?string?has_content>
                <#assign cPic = "/images/defaultImage.jpg">
              <#else>
                <#assign contentPathPrefix = "/quzou/upload/"/>
              </#if>
              <img style="width: 332px;height: 144px;" src="${(contentPathPrefix)!}${(cPic)!}"/>
            </span>
            <br />
            <!--
              <input type="file" name="mediumFile" style="width:230px;"/>
            -->
          </td>
        </tr>
        <tr>
          <td height="47" align="right" class="productTdText">开始时间：</td>
          <td height="5"><input type="text" value="${(entity.startDate?string('yyyy-MM-dd'))!}" readonly name="startDate" id="startDate" class="product_input inp-text" /></td>
          <td height="47" align="right" class="productTdText">结束时间：</td>
          <td height="5"><input type="text" value="${(entity.endDate?string('yyyy-MM-dd'))!}" readonly name="endDate" id="endDate" class="product_input inp-text" /></td>
        </tr>
        <tr>
          <td height="47" align="right" class="productTdText">最大步数：</td>
          <td height="5"><input type="text" value="${(entity.maxStep)!}" name="maxStep" id="maxStep" class="product_input inp-text" /></td>
          <td height="47" align="right" class="productTdText">最小步数：</td>
          <td height="47">
              <input type="text" name="minStep" id="minStep" value="${(entity.minStep)!}" class="product_input inp-text" />
          </td>
        </tr>
        <tr>
          <td height="47" align="right" class="productTdText">上传截止日期：</td>
          <td height="5"><input type="text" value="${(entity.uploadEndDate?string('yyyy-MM-dd'))!}" readonly name="uploadEndDate" id="uploadEndDate" class="product_input inp-text" /></td>
          <td height="47" align="right" class="productTdText">积分百步系数：</td>
          <td height="47">
              <input type="text" name="stepCoefficient" id="stepCoefficient" value="${(entity.stepCoefficient)!}" class="product_input inp-text" />
          </td>
        </tr>
        <tr>
          <td height="47" align="right" class="productTdText">简要描述：</td>
          <td height="5" colspan="3"><input type="text" value="${(entity.shortDescription)!}" name="shortDescription" id="shortDescription" class="kingkong-input username" /></td>
        </tr>
        <tr>
          <td height="52" align="right" valign="top" class="productTdText">赛事描述：</td>
          <td height="52" colspan="4" style="padding-top:10px;"><textarea name="description" id="description" cols="45" rows="5">${(entity.description)!}</textarea></td>
        </tr>
        <tr>
          <td height="52" colspan="3">
              <div class="account_btn ri com_btn_red" onclick="submitForm();" action="submit">
                <a href="javascript:void(0)">提交</a>
              </div>
              <#if entity??>
	              <div class="account_btn ri com_btn_red" onclick="uploadCustemer();" >
	                <a href="javascript:void(0)">导入人员</a>
	              </div>
              </#if>
          </td>
        </tr>
      </table>
      </form>
  </div>
</div>

<link rel="stylesheet" href="../images/js/photoUploader/css/ui.Button.css"/>
<link rel="stylesheet" href="../images/js/photoUploader/css/ui.Edit.css"/>
<link rel="stylesheet" href="../images/js/photoUploader/css/ui.Menu.css"/>
<link rel="stylesheet" href="../images/js/photoUploader/css/ui.Panel.css"/>
<link rel="stylesheet" href="../images/js/photoUploader/css/ui.Window.css"/>
<link rel="stylesheet" href="../images/js/photoUploader/css/ui.MessageBox.css"/>

<script src="../images/js/std.min.js"></script>
<script src="../images/js/photoUploader/ui.Label.js"></script>
<script src="../images/js/photoUploader/ui.Button.js"></script>
<script src="../images/js/photoUploader/ui.Edit.js"></script>
<script src="../images/js/photoUploader/ui.Menu.js"></script>
<script src="../images/js/photoUploader/ui.Panel.js"></script>
<script src="../images/js/photoUploader/ui.Window.js"></script>
<script src="../images/js/photoUploader/ui.MessageBox.js"></script>
<script src="../images/js/photoUploader/ui.ImageCutter.js"></script>
<script src="../images/js/photoUploader/ui.Uploader.js"></script>
<script type="text/javascript" src="../images/js/jquery.cm_dialog.js"></script>

<script>
  Std.main(function(){
    Std.ui.status.zIndex = 9999;

    var showUploadWindow = function(){
      var uploader   = Std.ui("UploadPhoto",{
        on:{
          submit:function(data,atrribute){
            if(data){
              window.submit_mediumFileName = this._fileName;
              window.submit_mediumFileSize = this._fileSize;
              window.submit_mediumFile = data.substr(data.indexOf("base64,") + 7);

              Std.dom(".product_image img").css({
                width:atrribute.width,
                height:atrribute.height
              }).attr("src",data);
            }
            uploadwindow.remove();
          }
        }
      });
      var uploadwindow = Std.ui("Window",{
        modal:true,
        width:800,
        height:600,
        title:"图片上传",
        minimizable:false,
        layout:{
          ui:"VBoxLayout",
          items:[uploader]
        }
      });
    };

    Std.dom(".product_image").css("cursor","pointer").on("click",function(){
      showUploadWindow();
    });
  })
</script>

<script>

  /*
   * ajax submit
   */
  $.fn.ajaxSubmitForm = function(addon,callback){
    var form = $(this);
    var data = {};

    $("[name]",form).each(function(){
      var that  = $(this);
      var name  = that.attr("name");

      data[name] = that.val();
    });

    Std.each(addon,function(name,value){
      if(value != null){
        data[name] = value;
      }
    });


    Std.ajax.post(form.attr("action"),data,function(){
      if($.isFunction(callback)){
        callback();
      }
      if(!isEmpty(this.http.responseURL)){
        window.location = this.http.responseURL;
      }
    });

    return form;
  };

  function disabledSubmitButton(){
    $(document.createElement("div")).css({
      top:0,
      left:0,
      width:$(document).width(),
      height:$(document).height(),
      position:"absolute",
      opacity:0.3,
      background:"white",
      zIndex:9999,
      cursor:"not-allowed"
    }).appendTo("body");

    $(document).on("keydown",function(e){
      if(e.keyCode === 8){
        return false;
      }
    });

    $("[action='submit']").addClass("disabled").mousedown(function(){
      return false;
    }).css({
      color:"white",
      background:"#7D7D7D",
      borderColor:"transparent"
    }).get(0).onclick = null;
  }

  function submitForm(){

    disabledSubmitButton();

    $("#EditCompetition").ajaxSubmitForm({
      mediumFileBase64:window.submit_mediumFile,
      _mediumFile_fileName:window.submit_mediumFileName,
      _mediumFile_fileSize:window.submit_mediumFileSize
    });
  }

</script>
<script type="text/javascript" src="../images/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript">
  $(function(){

      $('#startDate').daterangepicker({
        startDate: '2014-01-01',
        timePicker: true,
        timePickerIncrement: 1,
        format: 'YYYY-MM-DD',
        singleDatePicker: true,
        showDropdowns:true
      });
      $('#endDate').daterangepicker({
        startDate: '2014-01-01',
        timePicker: true,
        timePickerIncrement: 1,
        format: 'YYYY-MM-DD',
        singleDatePicker: true,
        showDropdowns:true
      });
      $('#uploadEndDate').daterangepicker({
        startDate: '2014-01-01',
        timePicker: true,
        timePickerIncrement: 1,
        format: 'YYYY-MM-DD H:mm:ss',
        singleDatePicker: true,
        showDropdowns:true
      });
      
  });
  
  	<#--上传数据-->
	function uploadCustemer(){
		 var option = {
	        url: "uploadDialog?inType=customerAndCompet&cId=${(entity.cId)!}",
	        width: '410px'
	      };
		$(this).cm_dialog(option);
	}
</script>
