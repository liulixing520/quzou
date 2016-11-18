window.onload=function(){
$(".uinfo_bg1").height($(".uinfo").height());
$(".uinfo_bg2").height($(".uinfo_totils").height());
$(".uinfo_bg3").height($(".uinfo_kefu").height());

var mtop=$(".uinfo").height()+$(".line").height()+"px";
var mtop2=$(".uinfo").height()+$(".line").height()+$(".uinfo_totils").height()+$(".line").height()+"px";

$(".uinfo_bg2").css("top",mtop);
$(".uinfo_bg3").css("top",mtop2);

}