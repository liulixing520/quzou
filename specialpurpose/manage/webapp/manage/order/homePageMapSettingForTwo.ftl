<html>
<head>
<title>Table对象的方法</title>
<script language="JavaScript">
var intRowIndex = 0;
function insertRow(tbIndex){
   var objRow = myTable.insertRow(tbIndex);
   var objCel = objRow.insertCell(0);
   objCel.innerText = document.myForm.myCell1.value;
   var objCel = objRow.insertCell(1);
   objCel.innerText = document.myForm.myCell2.value;
   objRow.attachEvent("onclick", getIndex);
   objRow.style.background = "pink";
}
function deleteRow(tbIndex){
   myTable.deleteRow(tbIndex);
}
function getIndex(){
   intRowIndex = event.srcElement.parentElement.rowIndex;
   pos.innerText = intRowIndex;
}
</script>
</head>
<body onload="pos.innerText=intRowIndex;">
<h2>Table对象的方法</h2>
<hr>
当前位置 : <span id="pos"></span>
<table id="myTable" border=1>
<tr onclick="getIndex()">
   <td>HTML</td>
   <td>CSS</td>
</tr>
<tr onclick="getIndex()">
   <td>JavaScript</td>
   <td>VBScript</td>
</tr>
</table>
<form name="myForm">
第一栏 : <input type="text" name="myCell1" value="CGI"><br>
第二栏 : <input type="text" name="myCell2" value="ASP"><br>
<input type="button" onclick="insertRow(intRowIndex)" value="插入行">
<input type="button" onclick="deleteRow(intRowIndex)" value="删除行">
<input type="button" onclick="insertRow(myTable.rows.length);" value="添加行">
</form>
</body>
</html>