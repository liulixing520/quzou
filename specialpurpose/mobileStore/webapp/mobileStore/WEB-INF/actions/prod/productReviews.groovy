import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.util.EntityUtil;

def operUserName(delegator,userLoginId){
	userLogin = delegator.findOne("UserLogin",true,[userLoginId:userLoginId])
	if(userLogin){
		person = delegator.findOne("Person",true,[partyId:userLogin.partyId])
		if(person && person.firstName){
			userLoginId = person.firstName
		}
	}
	if(userLoginId.length>3){
		suffix = userLoginId.substring(userLoginId.length-1)
		preffix = userLoginId.substring(0,1)
		return preffix+"***"+suffix
	}else{
		return userLoginId
	}
}

allReviews = delegator.findList("ProductReview",EntityCondition.makeCondition([EntityCondition.makeCondition("parentProdReviewId",null),EntityCondition.makeCondition("productId",parameters.productId)]),null,["-postedDateTime"],null,false)
for(review in allReviews){
	userLoginId = review.userLoginId
	if(userLoginId){
		review.userLoginId = operUserName(delegator,userLoginId)
	}
}
highReviews = EntityUtil.filterByCondition(allReviews, EntityCondition.makeCondition("productRating", EntityOperator.GREATER_THAN_EQUAL_TO, 4))
middleReviews = EntityUtil.filterByCondition(allReviews, EntityCondition.makeCondition([EntityCondition.makeCondition("productRating", EntityOperator.GREATER_THAN_EQUAL_TO, 2),EntityCondition.makeCondition("productRating", EntityOperator.LESS_THAN, 4)]))
lowReviews = EntityUtil.filterByCondition(allReviews, EntityCondition.makeCondition("productRating", EntityOperator.LESS_THAN, 2))

allCount = allReviews.size()
highCount = highReviews.size()
middleCount = middleReviews.size()
lowCount = lowReviews.size()
context.allCount = allCount
context.highCount = highCount
context.middleCount = middleCount
context.lowCount = lowCount
if(allCount>0){
	context.highPercentage = (Math.round(((double)highCount/(double)allCount)*100))
	context.middlePercentage = (Math.round(((double)middleCount/(double)allCount)*100))
	context.lowPercentage = (Math.round(((double)lowCount/(double)allCount)*100))
}

//日期类型转换
simpleDateFormatMap = org.extErp.sysCommon.util.JsonUtil.configMark;
//simpleDateFormatMap = org.extErp.sysCommon.util.JsonUtil.configChinese;
//simpleDateFormatMap = org.extErp.sysCommon.util.JsonUtil.config;

highReviews = org.extErp.sysCommon.util.JsonUtil.jsonFromGenericValueList(highReviews,simpleDateFormatMap);
middleReviews = org.extErp.sysCommon.util.JsonUtil.jsonFromGenericValueList(middleReviews,simpleDateFormatMap);
lowReviews = org.extErp.sysCommon.util.JsonUtil.jsonFromGenericValueList(lowReviews,simpleDateFormatMap);

jsonMap = [highReviews:highReviews,middleReviews:middleReviews,lowReviews:lowReviews]
context.jsonStr = org.ofbiz.base.lang.JSON.from(jsonMap);