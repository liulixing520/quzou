import org.ofbiz.base.util.UtilValidate;
geoId = parameters.geoId;
int length = 0;
if(UtilValidate.isNotEmpty(geoId)){
	geoAssocs = delegator.findByAnd("GeoAssoc", [geoId:geoId,geoAssocTypeId:'GROUP_MEMBER']);
	if(geoAssocs.size()>0)
		request.setAttribute("status","no");
	else
	{
		request.setAttribute("status","ok");
	}
}
