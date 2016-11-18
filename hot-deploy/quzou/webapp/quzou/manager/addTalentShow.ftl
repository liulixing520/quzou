<link type="text/css" href="../images/js/kindedit/themes/default/default.css" rel="stylesheet" />
<div class="wrap">
  <div class="add_product0">
      <form action="<#if entity??>updateTalentShow<#else>createTalentShow</#if>" enctype="multipart/form-data" name="EditCompetition" id="EditCompetition" method="post">
      <input type="hidden" name="showId" value="${(entity.showId)!}">

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="100" height="47" align="right" class="productTdText ">达人秀标题：</td>
          <td height="47" >
          	<input type="text" value="${(entity.showTitle)!}" name="showTitle" id="showTitle" class="kingkong-input username" />
          </td>
          
          <td width="100" height="47" align="right" class="productTdText"></td>
          <td height="47">
      	  </td>
          <td width="385" rowspan="4" align="center" class="product_image">
            <span>
              <#assign cPic = "${(entity.showPic)!}">
              <#if !cPic?string?has_content>
                <#assign cPic = "/images/defaultImage.jpg">
              <#else>
                <#assign contentPathPrefix = "/quzou/upload/"/>
              </#if>
              <img style="width: 332px;height: 144px;" src="${(contentPathPrefix)!}${(cPic)!}"/>
            </span>
            	封面
            <br />
            <!--
              <input type="file" name="mediumFile" style="width:230px;"/>
            -->
          </td>
        </tr>
        <tr>
          <td height="47" align="right" class="productTdText">简要描述：</td>
          <td height="5" colspan="3"><input type="text" value="${(entity.description)!}" name="description" id="description" class="kingkong-input username" /></td>
        </tr>
        <tr>
          <td height="47" align="right" class="productTdText">发布日期：</td>
          <td height="5"><input type="text" value="${(entity.publishDate?string('yyyy-MM-dd'))!}" readonly name="publishDate" id="publishDate" class=" inp-text" /></td>
        </tr>
        <tr>
          <td height="47" align="right" class="productTdText">是否首页展示：</td>
          <td height="5">
            <label title="1" class="RadioIconImitate radio <#if entity?has_content><#if entity.isShow == '1'>cur</#if></#if>" >是</label>
            <label title="0" class="RadioIconImitate radio <#if entity?has_content><#if entity.isShow == '0'>cur</#if><#else>cur</#if>">否</label>
            <input class="stauts" name="isShow" id="isShow" type="hidden" value="<#if entity?has_content>${(entity.isShow)!}<#else>0</#if>"/>
          </td>
        </tr>
        <tr>
          <td height="52" align="right" valign="top" class="productTdText">描述：</td>
          <td height="52" colspan="4" style="padding-top:10px;"><textarea name="detailContent" id="detailContent" cols="45" rows="5">${(entity.detailContent)!}</textarea></td>
        </tr>
        <tr>
          <td height="52" colspan="3">
              <div class="account_btn ri com_btn_red" onclick="submitForm();" action="submit">
                <a href="javascript:void(0)">提交</a>
              </div>
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

      $('#publishDate').daterangepicker({
        startDate: '2014-01-01',
        timePicker: true,
        timePickerIncrement: 1,
        format: 'YYYY-MM-DD',
        singleDatePicker: true,
        showDropdowns:true
      });
      
  });
  
</script>
