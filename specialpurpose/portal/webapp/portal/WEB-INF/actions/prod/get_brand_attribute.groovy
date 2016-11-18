import org.ofbiz.entity.*;
import javolution.util.FastMap;
import javolution.util.FastList;
import javolution.util.FastList.*;
import java.util.List;
productCategoryId = parameters.get("productCategoryId");
resultMap = [:];
cateAtrributeList=delegator.findByAnd("CategoryRefTypeAttribute", [productCategoryId : productCategoryId]);
//attribs = delegator.findByAnd("TypeAttribute", [productCategoryId : productCategoryId]);
if (cateAtrributeList.size() > 0) {
	attribList =  FastList.newInstance();
    for (cateAtrribute in cateAtrributeList) {
    	atrrib=delegator.findByPrimaryKey("TypeAttribute",[attributeId : cateAtrribute.attributeId]);
		atrribMap = FastMap.newInstance();
    	atrribMap.put("attributeGroupId",atrrib.getString("attributeGroupId"));
    	attributeName=atrrib.getString("attributeName")+((atrrib.getString("attributeNameZh")!=null)?"|"+atrrib.getString("attributeNameZh"):"")+((atrrib.getString("attributeNameRu")!=null)?"|"+atrrib.getString("attributeNameRu"):"");
    	atrribMap.put("attributeName",attributeName);
    	atrribMap.put("entryWay",atrrib.getString("entryWay"));
    	atrribMap.put("attributeId",atrrib.getString("attributeId"));
    	entryWay = atrrib.getString("entryWay");
    	if("SELECT".equals(entryWay)){
    		attribOptions = delegator.findByAnd("AttrOptionalValue", [attributeId : atrrib.getString("attributeId")]);
    		if (attribOptions.size() > 0) {
    			attribOptionList =  FastList.newInstance();
    			for (attribOption in attribOptions) {
	    			attribOptionsMap = FastMap.newInstance();
    				attribOptionsMap.put("optionalId",attribOption.getString("optionalId"));
    				optionalName=attribOption.getString("optionalName")+((attribOption.getString("optionalNameZh")!=null)?"|"+attribOption.getString("optionalNameZh"):"")+((attribOption.getString("optionalNameRu")!=null)?"|"+attribOption.getString("optionalNameRu"):"");
    				attribOptionsMap.put("optionalName",optionalName);
    				attribOptionList.add(attribOptionsMap);
    			}
    			atrribMap.put("inputValue",attribOptionList);
    		}
    	}
    	attribList.add(atrribMap);
    }

	request.setAttribute("attribs",attribList);
	resultMap.put("attribs",attribList);
}
brands = delegator.findByAnd("ProductCategoryAndBrand", [productCategoryId : productCategoryId]);
if (brands.size() > 0) {
	brandList =  FastList.newInstance();
    for (brand in brands) {
		brandGv = brand.getRelatedOne("ProductBrand");
		brandMap = FastMap.newInstance();
		brandMap.put("id",brandGv.getString("id"));
		brandMap.put("brandName",brandGv.getString("brandName"));
    	brandList.add(brandMap);
    }
	request.setAttribute("brands",brandList);
	resultMap.put("brands",brandList);
}
org.ofbiz.ebiz.product.JsonUtil.toJsonObject(resultMap,response);