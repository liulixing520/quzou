//打开编辑维度页面并传模板组id
function edataDimension(templateGroupId) {
	var url = 'edataDimension?templateGroupId=' + templateGroupId;
	operEditDialog(url);
	
}

//打开编辑度量页面并传模板组id
function edataMeasure(templateGroupId){
	var url = 'edataMeasure?templateGroupId=' + templateGroupId;
	operEditDialog(url);
	
}

//打开编辑维度值页面并传维度id
function edataDimensionPart(dimensionId){
    var url ='edataDimensionPart?dimensionId=' + dimensionId;
    operEditDialog(url);
} 
