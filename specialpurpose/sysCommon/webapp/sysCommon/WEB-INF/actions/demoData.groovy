import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
import org.ofbiz.entity.*;
import org.ofbiz.entity.condition.*;


		

	
	List list=new ArrayList();
	for(int i=0;i<10;i++){
		Map map=new HashMap();
		map.put("id",i);
		map.put("code",i+"codesss");
		map.put("name","name"+i);
		map.put("addr","addr"+i);
		map.put("col4","col4"+i);
		list.add(map);
	}
	request.setAttribute("total","239");
	request.setAttribute("rows",list);

