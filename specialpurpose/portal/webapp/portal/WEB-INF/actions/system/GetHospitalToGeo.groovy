import net.sf.json.JSONObject;
import net.sf.json.JSONArray;
import java.io.Writer;

geoId=parameters.geoId?:null;

geos=null;
//num的作用是 第几个下拉框
num=parameters.num?:null;
if((geoId) && num=="2"){
	//省市
	geos = delegator.findByAnd("HospitalGeo",[parentGeoId:geoId], null, false);	
}

if((geoId) && num=="3"){
	//区县
	geos = delegator.findByAnd("HospitalGeo", [parentGeoId : geoId], null, false);	
}

if((geoId) && num=="4"){
    //医院的信息
	geos = delegator.findByAnd("Hospital", [geoId : geoId], null, false);
}

if((geoId) && num=="5"){
    //科室的信息
	geos = delegator.findByAnd("Departments", [depId : geoId], null, false);
}

if((geoId) && num=="6"){
   //就诊时间
	geos = delegator.findByAnd("Treatmenttime", [treId : geoId], null, false);
}


if(geos){
	JSONArray jsonArray = JSONArray.fromObject(geos);
	response.setContentType("text/html");
	Writer out;
	out = response.getWriter();
	println jsonArray.toString()+"---------"
	out.write(jsonArray.toString());
	out.flush();
}
return "success";



	












