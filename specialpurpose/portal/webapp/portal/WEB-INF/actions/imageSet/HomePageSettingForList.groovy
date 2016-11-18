import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;
import org.ofbiz.base.util.HttpRequestFileUpload
import org.ofbiz.base.util.UtilProperties
import org.ofbiz.base.util.UtilValidate
import org.ofbiz.base.util.string.FlexibleStringExpander
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtilProperties;
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;
import org.ofbiz.base.util.UtilMisc;

if (userLogin) {
    condList = FastList.newInstance();
    pageSettingList = delegator.findList("HomePageSetter", null, null, null, null, false);
	if(pageSettingList){
    	context.pageSettingList = pageSettingList[0];
    }
    println "---------------------------------context.pageSettingList  =  "+context.pageSettingList
    
}



