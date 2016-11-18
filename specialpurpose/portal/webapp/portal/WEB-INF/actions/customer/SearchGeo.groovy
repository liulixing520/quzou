/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
 import net.sf.json.JSONObject;
 import net.sf.json.JSONArray;
 import java.io.Writer;

geoId=parameters.geoId?:null;
geos=null;
if(geoId){
	geos = delegator.findByAnd("ChinaGeo", [parentGeoId : geoId], null, false);	
}
if(geos){
	JSONArray jsonArray = JSONArray.fromObject(geos);
	//context.geos=geos;
	response.setContentType("text/html");
	//response.setContentLength(jsonObject.getBytes("UTF8").length);
	Writer out;
	out = response.getWriter();
	out.write(jsonArray.toString());
	out.flush();
}
/*JSONObject jsonObject = new JSONObject();
jsonObject.put("name", "kevin");     
jsonObject.put("Max.score", new Integer(100));     
jsonObject.put("Min.score", new Integer(50));     
jsonObject.put("nickname", "picglet");*/     
//request.setAttribute("geos", geos);
return "success";

