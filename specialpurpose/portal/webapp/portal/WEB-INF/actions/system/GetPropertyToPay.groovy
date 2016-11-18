import net.sf.json.JSONObject;
import net.sf.json.JSONArray;
import java.io.Writer;

prcId=parameters.prcId?:null;

pros=null;
//num的作用是 第几个下拉框
num=parameters.num?:null;
if((prcId) && num=="2"){
	//城市
	pros = delegator.findByAnd("PropertyCity",[prcId:prcId,ptcType:"PROVINCE"], null, false);	
}

if((prcId) && num=="3"){
	//区县
	pros = delegator.findByAnd("PropertyCity", [parentPtcId : prcId,ptcType:"CITY"], null, false);	
}

if((prcId) && num=="4"){
    //小区
	pros = delegator.findByAnd("PropertyCity", [parentPtcId : prcId,ptcType:"COUNTY"], null, false);
}



if(pros){
	JSONArray jsonArray = JSONArray.fromObject(pros);
	response.setContentType("text/html");
	Writer out;
	out = response.getWriter();
	println jsonArray.toString()+"---------"
	out.write(jsonArray.toString());
	out.flush();
}
return "success";



	












