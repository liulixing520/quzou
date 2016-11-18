$(function(){
/**
 * show birthday
 */
var nowdate=new Date(); //获取当前时间的年份
var nowYear= nowdate.getFullYear();//当前年份
var nowMonth= nowdate.getMonth()+1;//当前月份
//清空年份、月份的下拉框 进行重新添加选项
$("#birthdayYear").empty();
$("#birthdayMonth").empty();

//年
for(var startYear=nowYear;startYear>=1930;startYear--){
    var year;
    $("<li  name='year'><a href='javascript:;' class='changDate' lang='year' name='"+startYear+"'>"+startYear+"</a></li>").appendTo("#birthdayYear");
}
//月
for(var startMonth=1;startMonth<=12;startMonth++){
    $("<li  name='month'><a href='javascript:;' class='changDate' lang='month' name='"+startMonth+"'>"+startMonth+"</a></li>").appendTo("#birthdayMonth");
}
changeSelectBrithdayDay();
//根据所选择的年份、月份计算月最大天数,并重新填充生日下拉框中的日期项
function changeSelectBrithdayDay(){
    var maxNum;
    var month=$("#birth_month").html();
    var year=$("#birth_year").html();
    if(year==0){ //如果年份没有选择，则按照闰年计算日期(借用2004年为闰年)
        year=2004;
    }
    if( month==0){
        maxNum=31;
    }else if( month==2 ){
        if(year.toString().substring(2)=="后"){ //判断年份是否为模糊年份 如果是模糊年份则天数设为29
            maxNum=29;
        }else{
            if( year%400==0 || ( year%4==0 && year%100!=0)){ //判断闰年
                maxNum=29;
            }else{
                maxNum=28;
            }
        }
    }else if( month==4 || month==6 || month==9 || month==11){
        maxNum=30;
    }else{
        maxNum=31;
    }

    //清空日期的下拉框 进行重新添加选项
    $("#birthdayDay").empty();
    if(month == 0){
    } else {
	    for(var startDay=1;startDay<=maxNum;startDay++){
                $("<li  name='day'><a href='javascript:;' class='changDate' lang='day' name='"+startDay+"'>"+startDay+"</a></li>").appendTo("#birthdayDay");
	    }
            changeDate();
    }
}
$('.select_box_list').click(function(){
    $(".privilege_slide").hide();
    var brother = $(this).next('.privilege_slide');
    if($(this).next('.privilege_slide').attr("flag") == 1){
        brother.attr("flag",0);
        brother.hide();
    }else{
        if(brother.html().length > 100){
            brother.attr("flag",1);
            brother.show();
        }
        
    }
});
changeDate();
function changeDate(){
    //选择生日年份后触发
    $(".changDate").click( function (){
        var inputVal = $(this).attr("name");
        var aLang = $(this).attr("lang");
        if(aLang == "year"){
            $("#birth_year").html(inputVal);
        }else if(aLang =="month"){
            $("#birth_month").html(inputVal);
            changeSelectBrithdayDay();
        }else if(aLang =="day"){
            $("#birth_day").html(inputVal);
        }
        $(".privilege_slide").hide();
    });
}
//性别切换
$(".radio").unbind("click").bind("click", function () {
    $(".radio").removeClass("radio_cur");
    $(this).addClass("radio_cur");
    $("#gender").val($(this).attr("name"));
});
//保存信息
$(".updateUserInfo").unbind("click").bind("click", function () {
	 $("#MyForm").submit();
});
//上传头像
$(".uploadeAvatar").unbind("click").bind("click", function () {
    $(".avatar").show();
    $('.shade_box').show();
});
//关闭弹框
$('.cross').click(function(){
    $(this).parent().hide();
    $('.shade_box').hide();
});

$("#uploadeImg").unbind("change").bind("change", function () {
    $("#uploadFrom").submit();
});
//头像确认
$("#doUploadeImg").unbind("click").bind("click", function () {
	  $(".avatar").hide();
      $(".shade_box").hide();
});
});
//上传头像返回值
function fileImport_callBack(filePath,fileName,fileId){
	$("#member_img").attr("src",filePath);
	$("#member_img_new").attr("src",filePath);
	$("#picUrl").val(filePath);
}
function showAlert(msg){
    alert(msg);
}