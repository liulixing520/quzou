<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>打印清单</title>
<style type="text/css">
*{margin:0;padding:0;font-size:12px;}
body{ padding:5px 10px;}
h2{margin:5px 0;}
.deli{background:#efefef; border:1px solid #dcdcdc; padding:0 15px 15px;}
.deli h3{padding:15px 0;margin:0}
.deli p{margin-bottom:5px;}
.tbcon{ border:1px solid #cacaca; background:#fff;padding:5px; }
table{}
table td,table th{ padding:8px 15px; border-right:1px solid #dcdcdc;}
table th{ background:#e3e8ec;  border-top:1px solid #fff;border-bottom:1px solid #d2d7db; text-align:right; font-weight:normal}
table td{ border-top:1px solid #fff;border-bottom:1px solid #dcdcdc; }
input,select{padding:2px; border:1px solid #909c9c}
.width_s{ width:88px}
.width_m{ width:150px}
.width_l{ width:420px}
.tag{ border:1px #ccc; border-style:solid groove groove solid; padding:15px;width:165px; margin:0 auto}
.tag p{ color:gray; border-bottom:1px solid #ccc; }
.btns{ text-align:center; padding:15px;}
.btns button{ border:2px solid; border-color:#dddddd #000105 #000105 #ddd; padding:5px 25px; background:#4d6b83; color:#f4feff; font-weight:bold;  margin-left:5px; font-size:12px}
</style>
<script language='javascript'>
function printWindow() {
        factory.printing.header = "This is MeadCo";
        factory.printing.footer = "Printing by ScriptX";
        factory.printing.portrait = false;
        factory.printing.leftMargin = 1.0;
        factory.printing.topMargin = 1.0;  
        factory.printing.rightMargin = 1.0;
        factory.printing.bottomMargin = 1.0;
        factory.printing.Print(false);
}
</script>
</head>
<#assign baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()/>
<body>
<object id="secmgr" viewastext style="display:none"
classid="clsid:5445be81-b796-11d2-b931-002018654e2e"
codebase="/images/redist/smsx.cab#Version=7,0,0,8">
<param name="GUID" value="{0ADB2135-6917-470B-B615-330DB4AE3701}">
<param name="Path" value="http://www.meadroid.com/scriptx/sxlic.mlf">
<param name="Revision" value="0">
</object>
<object id="factory" viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="${baseUrl}/images/redist/smsx.cab#Version=5,60,0,360">
</object>
<h2>快递单打印</h2>
<div class="deli">
	<h3>收货地址信息</h3>
	<div class="tbcon">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<th scope="row">姓名：</th>
		<td colspan="8"><label>
			<#if destinationPostalAddress?has_content>${destinationPostalAddress.toName?if_exists}</#if>
		</label></td>
		</tr>
	<tr>
		<th scope="row">省区：</th>
		<td>
		<!--
		<#if destinationPostalAddress?has_content>
  			  <#assign AddressGeoAllCn =Static["org.ofbiz.iteamgr.party.ContactMechTools"].
  			  getAddressGeoAllCn(delegator,destinationPostalAddress.stateProvinceGeoId,destinationPostalAddress.cityGeoId,destinationPostalAddress.countyGeoId)>
  			  ${AddressGeoAllCn!}
  			  </#if>  -->
		</td>
		<th>邮编：</th>
		<td><#if destinationPostalAddress?has_content>${destinationPostalAddress.postalCode?if_exists}"></#if></td>
		</tr>
	<tr>
		<th scope="row">地址：</th>
		<td colspan="3"><#if destinationPostalAddress?has_content>${destinationPostalAddress.address1?if_exists}</#if></td>
		</tr>
	<tr>
		<th scope="row">手机：</th>
		<td><#if destinationPostalAddress?has_content>${destinationPostalAddress.mobileExd?if_exists}</#if></td>
		<th>电话：</th>
		<td><#if destinationPostalAddress?has_content>${destinationPostalAddress.phoneAreaExd?if_exists}${destinationPostalAddress.phoneExd?if_exists}</#if></td>
		</tr>
	<tr>
		<th scope="row">备注：</th>
		<td colspan="3"></td>
		</tr>
</table>
</div>

	<h3>发货地址信息</h3>

	<div class="tbcon">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<th scope="row">姓名：</th>
			<td><span id="send_name"><#if originPostalAddress?has_content>${originPostalAddress.toName?if_exists}</#if> </span></td>
			<th>地区：</th>
			<td><span id="area"><#if originPostalAddress?has_content>
  			  <!--
  			  <#assign AddressGeoAllCn =Static["org.ofbiz.iteamgr.party.ContactMechTools"].
  			  getAddressGeoAllCn(delegator,originPostalAddress.stateProvinceGeoId,originPostalAddress.cityGeoId,originPostalAddress.countyGeoId)>
  			  ${AddressGeoAllCn!}
  			  </#if>
  			  -->
  			  </span></td>
			
		</tr>
		<tr>
			<th scope="row">邮编：</th>
			<td><span id="send_postalcode"><#if originPostalAddress?has_content>${originPostalAddress.postalCode?if_exists}</#if></span></td>
			<th>地址：</th>
			<td><span id="send_address"><#if originPostalAddress?has_content>${originPostalAddress.address1?if_exists}</#if></span></td>
		</tr>
		
		<tr>
			<th scope="row">手机：</th>
			<td><span id="send_mobile"><#if originPostalAddress?has_content>${originPostalAddress.mobileExd?if_exists}</#if></span></td>
			<th>电话：</th>
			<td><span id="send_telephone"><#if originPostalAddress?has_content>${originPostalAddress.phoneExd?if_exists}</#if></span></td>
		</tr>
	</table></div>
</div>

<div align='center'>
<form>
			<p>
				<input type="button" name="Print" value="打印" onclick="printWindow();">
			</p>
		</form>
		
</div>
</body>
</html>
<script src="/scripts/jquery.js"></script>
<script src="/back/js/www/common.js"></script>
<script src="/back/js/print/print_object.js"></script>
<script src="/back/js/print/print_see.js"></script>

<#if sendNodeList??>
	<#list sendNodeList as printNode>
		<script type="text/javascript" language="javascript">
		<!--
			var pn = new PrintNode();
			pn.id = ${printNode.id!};
	     	pn.refKey = "${printNode.refKey!}";
	     	pn.name = "${printNode.name!}";
	     	pn.sequence = ${printNode.sequence!};
	     	pn.comment = "${printNode.comment!}";
	     	pn.canEditComment = ${printNode.canEditComment!};
	     	pn.state = ${printNode.state!};
	     	pn.createTime = "${printNode.createTime!}";
	     	pn.createUserId = ${printNode.createUserId!};
	     	pn.editTime = "${printNode.editTime!}";
	     	pn.editUserId = "${printNode.editUserId!}";
	     	pn.category = ${printNode.category!};
			
			printNodeArray[${printNode.id!}] = pn;
		-->
		</script>
	</#list>
</#if>
<script defer>
// -------------------基本功能，可免费使用-----------------------
factory.printing.header = "";//页眉
factory.printing.footer = "";//页脚
factory.printing.SetMarginMeasure(1);//页边距单位，1为毫米，2为英寸

//边距设置，需要注意大部分打印机都不能进行零边距打印，即有一个边距的最小值，一般都是6毫米以上
//设置边距的时候时候如果设置为零，就会自动调整为它的最小边距
factory.printing.leftMargin = 7;//左边距
factory.printing.topMargin = 7;//上边距
factory.printing.rightMargin = 7;//右边距
factory.printing.bottomMargin = 7;//下边距
factory.printing.portrait = true;//是否纵向打印，横向打印为false

//--------------------高级功能---------------------------------------------
factory.printing.printer = "EPSON LQ-1600KIII";//指定使用的打印机
//factory.printing.printer = "\\\\cosa-data\\HPLaserJ";//如为网络打印机，则需要进行字符转义
factory.printing.paperSize = "A4";//指定使用的纸张
factory.printing.paperSource = "Manual feed";//进纸方式，这里是手动进纸
factory.printing.copies = 1;//打印份数
factory.printing.printBackground = false;//是否打印背景图片
factory.printing.SetPageRange(false, 1, 3); //打印1至3页

//---------------------常用函数--------------------------------
factory.printing.Print(false);//无确认打印，true时打印前需进行确认
//factory.printing.Print(false, pageFrame); pageFrame为Iframe或Frame框架名称，只打印框架内容
factory.printing.PrintSetup();//打印设置
factory.printing.Preview();//打印预览
factory.printing.WaitForSpoolingComplete();//等待上一个打印任务完全送入打印池，在连续无确认打印时非常有用
factory.printing.EnumPrinters(index);//枚举已安装的所有打印机，主要用于生成打印机选择功能
</script>



