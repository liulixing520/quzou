import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;

productStoreShipmentMeth = delegator.findOne("ProductStoreShipmentMeth",false,[productStoreShipMethId:parameters.productStoreShipMethId])
productStoreShipConfig = delegator.findByAnd("ProductStoreShipConfig",[productStoreShipMethId:parameters.productStoreShipMethId])
chnProvinceList = []
foreignCountryList = []
if(productStoreShipConfig && productStoreShipConfig.size()>0){
	chnProvinceList = EntityUtil.getFieldListFromEntityList(productStoreShipConfig, "shippingProvince", true)
	foreignCountryList = EntityUtil.getFieldListFromEntityList(productStoreShipConfig, "shippingCountry", true)
	context.chnProvinceList = chnProvinceList
	context.foreignCountryList = foreignCountryList
}else{
	context.chnProvinceList = []
	context.foreignCountryList = []
}
allChnProvinceList = org.extErp.sysCommon.party.CommonWorkers.getAssociatedStateList(delegator,"CHN")
allForeignCountryList = delegator.findByAnd("Geo",[geoTypeId:"COUNTRY"])
allForeignCountryList.removeAll(EntityUtil.filterByCondition(allForeignCountryList,EntityCondition.makeCondition("geoId",EntityOperator.IN,foreignCountryList)))
allChnProvinceList.removeAll(EntityUtil.filterByCondition(allChnProvinceList,EntityCondition.makeCondition("geoId",EntityOperator.IN,chnProvinceList)))

context.allForeignCountryList = allForeignCountryList
context.allChnProvinceList = allChnProvinceList
context.productStoreShipConfig = productStoreShipConfig