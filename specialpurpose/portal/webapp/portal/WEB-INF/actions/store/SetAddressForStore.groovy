import org.ofbiz.entity.condition.*
import javolution.util.FastList
import org.ofbiz.product.catalog.*;
import org.ofbiz.product.category.*;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.base.util.UtilMisc;

if(userLogin){
	firstGeos=parameters.firstGeos?:null;
	if(firstGeos){
		if(firstGeos.toString().indexOf(",")==-1){
			firstGeos2=FastList.newInstance();
			firstGeos2.add(firstGeos);
			firstGeos=firstGeos2;
		}
	}
	secondGeos=parameters.secondGeos?:null;
	if(secondGeos){
		if(secondGeos.toString().indexOf(",")==-1){
			secondGeos2=FastList.newInstance();
			secondGeos2.add(secondGeos);
			secondGeos=secondGeos2;
		}
	}
	thirdGeos=parameters.thirdGeos?:null;
	if(thirdGeos){
		if(thirdGeos.toString().indexOf(",")==-1){
			thirdGeos2=FastList.newInstance();
			thirdGeos2.add(thirdGeos);
			thirdGeos=thirdGeos2;
		}
	}
    condList = FastList.newInstance();
    condList.add(EntityCondition.makeCondition("partyId", EntityOperator.EQUALS, userLogin.partyId));
    condList.add(EntityCondition.makeCondition("roleTypeId", EntityOperator.EQUALS, "OWNER"));
    rolesCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
    productStoreRoleList = delegator.findList("ProductStoreRole", rolesCond, null, ["-sequenceNum"], null, false);
    productStoreRoleList = EntityUtil.filterByDate(productStoreRoleList);
	if(firstGeos || secondGeos || thirdGeos || UtilValidate.isNotEmpty(productStoreRoleList)){
		productStoreRole = EntityUtil.getFirst(productStoreRoleList);
		productStoreId=productStoreRole.productStoreId;
		int num=delegator.removeByAnd("ProductStoreGeo",UtilMisc.toMap("productStoreId",productStoreId));
		if(!firstGeos && !secondGeos){
			if(thirdGeos){
				thirdGeos.each{it ->
    				storeGeoId=delegator.getNextSeqId("ProductStoreGeo");
    				map=UtilMisc.toMap("geoId",it,"productStoreId",productStoreId,"storeGeoId",storeGeoId);
    				newGeo = delegator.makeValue("ProductStoreGeo", map);
    				newObj=delegator.create(newGeo);
				}
			}
		}else if(!secondGeos && !thirdGeos){
			if(firstGeos){
				firstGeos.each{it ->
    				storeGeoId=delegator.getNextSeqId("ProductStoreGeo");
    				map=UtilMisc.toMap("geoId",it,"productStoreId",productStoreId,"storeGeoId",storeGeoId);
    				newGeo = delegator.makeValue("ProductStoreGeo", map);
    				newObj=delegator.create(newGeo);
				}
			}
		}else if(!firstGeos && !thirdGeos){
			if(secondGeos){
				secondGeos.each{it ->
    				storeGeoId=delegator.getNextSeqId("ProductStoreGeo");
    				map=UtilMisc.toMap("geoId",it,"productStoreId",productStoreId,"storeGeoId",storeGeoId);
    				newGeo = delegator.makeValue("ProductStoreGeo", map);
    				newObj=delegator.create(newGeo);
				}
			}
		}else{
			if(thirdGeos){
				if(firstGeos){
					
						thirdGeos.each{thirdV ->
							firstGeos.each{firstV ->
								if(firstGeos && thirdV.indexOf(firstV)==0){
									//a.add(firstV);
									firstGeos=firstGeos-[firstV];
								}
							}
						}

				}
				if(secondGeos){

						thirdGeos.each{thirdV ->
							secondGeos.each{secondV ->
								if(secondGeos && thirdV.indexOf(secondV)==0){
									//b.add(secondV);
									secondGeos=secondGeos-[secondV];
								}
							}
						}

				}
			}
			if(secondGeos){
				if(firstGeos){
					secondGeos.each{secondV2 ->
						firstGeos.each{firstV2 ->
							if(firstGeos && secondV2.indexOf(firstV2)==0){
								//a.add(firstV2);
								firstGeos=firstGeos-[firstV2];
							}
						}
					}
				}
			}
			if(firstGeos){
				firstGeos.each{it ->
    				storeGeoId=delegator.getNextSeqId("ProductStoreGeo");
    				map=UtilMisc.toMap("geoId",it,"productStoreId",productStoreId,"storeGeoId",storeGeoId);
    				newGeo = delegator.makeValue("ProductStoreGeo", map);
    				newObj=delegator.create(newGeo);
				}
			}
			if(secondGeos){
				secondGeos.each{it ->
    				storeGeoId=delegator.getNextSeqId("ProductStoreGeo");
    				map=UtilMisc.toMap("geoId",it,"productStoreId",productStoreId,"storeGeoId",storeGeoId);
    				newGeo = delegator.makeValue("ProductStoreGeo", map);
    				newObj=delegator.create(newGeo);
				}
			}
			if(thirdGeos){
				thirdGeos.each{it ->
    				storeGeoId=delegator.getNextSeqId("ProductStoreGeo");
    				map=UtilMisc.toMap("geoId",it,"productStoreId",productStoreId,"storeGeoId",storeGeoId);
    				newGeo = delegator.makeValue("ProductStoreGeo", map);
    				newObj=delegator.create(newGeo);
				}
			}			
		}
	}
    return "success";
}
