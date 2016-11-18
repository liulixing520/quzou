// JavaScript Document
$(function(){
	$.ajaxSetup({ cache: false });
	var navC = ".";
	
	var nav = navC;
	$("#gotopInclude").load(nav+"/layout/gotop/gotop.html"); //返回顶部
	$("#rightbarInclude").load(nav+"/layout/rightbar/bar.html"); //右侧菜单
	$("#topInclude").load(nav+"/layout/header/top.html"); //顶部LOGO及一些信息
	$("#filterInclude").load(nav+"/layout/filter/filter.html"); //筛选选菜单，产品
	$("#filterPdtInclude").load(nav+"/layout/filter/filter-pdt.html"); //筛选选菜单，产品信息
	$("#filterInfoInclude").load(nav+"/layout/filter/filter-info.html"); //筛选菜单 产品独立
	$("#filterFormInclude").load(nav+"/layout/filter/filter-form.html"); //筛选表单
	$("#filterMergeInclude").load(nav+"/layout/filter/filter-merge.html"); //筛选菜单、筛选表单合并
	
	$("#pagetoInclude").load(nav+"/layout/pageto/pageto.html"); //分页
	$("#pagetoInclude2").load(nav+"/layout/pageto/pageto.html"); //分页
	
	$("#navIndexInclude").load(nav+"/layout/header/nav/nav-index.html"); //首页
	$("#navSalaryInclude").load(nav+"/layout/header/nav/nav-salary.html"); //薪酬设置
	$("#navBaseInclude").load(nav+"/layout/header/nav/nav-base.html"); //产品
	$("#navAccountInclude").load(nav+"/layout/header/nav/nav-account.html"); //会员中心
	$("#navStatisticsInclude").load(nav+"/layout/header/nav/nav-statistics.html"); //营业统计
	$("#navStockInclude").load(nav+"/layout/header/nav/nav-stock.html"); //库存
	$("#navRegisterInclude").load(nav+"/layout/header/nav/nav-register.html"); //注册
	$("#navEmployeeInclude").load(nav+"/layout/header/nav/nav-employee.html"); //员工信息
	$("#navPersonDataInclude").load(nav+"/layout/header/nav/nav-personalData.html"); //个人资料
	$("#navRemindInclude").load(nav+"/layout/header/nav/nav-remind.html"); //提醒
	$("#navBeatyInclude").load(nav+"/layout/header/nav/nav-beatyKit.html"); //美丽锦囊
});
