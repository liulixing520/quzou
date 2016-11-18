// JavaScript Document
$(function(){
	$(".login_row i").click(function(){
		$(this).hide().siblings("input").focus();
	});
	$(".login_row input").focus(function(){
		$(this).siblings("i").hide();
	});
	$(".login_row input").blur(function(){
		var val  =$(this).val();
		if(val==""){
			$(this).siblings("i").show();
		}
	});
})