import org.ofbiz.entity.GenericValue;
import org.ofbiz.webapp.website.WebSiteWorker;
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.*

import org.ofbiz.base.util.UtilValidate
import javolution.util.FastList;

//GenericValue webSite = WebSiteWorker.getWebSite(httpRequest);


pplookupMap = [webSiteId : webSiteId, webSiteContentTypeId : 'HOME_SLIDE_IMGS'];
webSiteContents = delegator.findList("WebSiteContent", EntityCondition.makeCondition(pplookupMap), null, ['-fromDate'], null, false);
webSiteContents = EntityUtil.filterByDate(webSiteContents);
webSiteContent = EntityUtil.getFirst(webSiteContents);
if (webSiteContent) {
    imgsContent = webSiteContent.getRelatedOne("Content", false);
    imgsContentId = imgsContent.contentId;
    context.imgsContent = imgsContent;
    context.imgsContentId = imgsContentId;

    // get all sub content for the publish point
	condList = [
		EntityCondition.makeCondition("contentId", imgsContentId),
		EntityUtil.getFilterByDateExpr(),
		EntityCondition.makeCondition("contentAssocTypeId", EntityOperator.EQUALS, "GRAPH_LINK")
	   ];
    cond = EntityCondition.makeCondition(condList);
    subContents = delegator.findList("ContentAssoc", cond, null, ['sequenceNum'], null, false);
    context.homeSlideContents = subContents;
}

Locale locale= org.ofbiz.base.util.UtilHttp.getLocale(session);  
context.Languages = locale.getLanguage();
println "---------------------------------------------------------------------------------------------------------------------locale.getLanguage()"+locale.getLanguage()

condList = FastList.newInstance();
condrightList = FastList.newInstance();
condList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS, "0"));
//condList.add(EntityUtil.getFilterByDateExpr());
condList.add(EntityCondition.makeCondition("gradingType", EntityOperator.EQUALS, "1"));
pagesetterCond = EntityCondition.makeCondition(condList, EntityOperator.AND);
PageSetterList = delegator.findList("PageSetting", pagesetterCond, null,null, null, false);
context.PageSetterList = PageSetterList;

condrightList.add(EntityCondition.makeCondition("status", EntityOperator.EQUALS, "0"));
//condList.add(EntityUtil.getFilterByDateExpr());
condrightList.add(EntityCondition.makeCondition("gradingType", EntityOperator.EQUALS, "2"));
pagesetterRightCond = EntityCondition.makeCondition(condrightList, EntityOperator.AND);
PageSetterRightList = delegator.findList("PageSetting", pagesetterRightCond, null,null, null, false);
context.PageSetterRightList = PageSetterRightList;
