import org.ofbiz.base.util.UtilValidate
import org.ofbiz.entity.condition.*
import org.ofbiz.entity.util.EntityUtil;
import javolution.util.FastList;

    println "===============================----------------------------------paramTemp   "+paramTemp
    
   if(paramTemp=="10001"||paramTemp.equals("10001")){
	    helpclassone = delegator.findByAnd("HelpClassification", [classificationName : "关于我们"],null, false)
	    aboutus = delegator.findByAnd("HelpInformation", [helpClassId : helpclassone[0].helpClassId],null, false)
	    context.pagesetter = aboutus[0];
   }else if(paramTemp=="10002"||paramTemp.equals("10002")){
	    helpclasstwo = delegator.findByAnd("HelpClassification", [classificationName : "新手上路"],null, false)
	    newbieroad = delegator.findByAnd("HelpInformation", [helpClassId : helpclasstwo[0].helpClassId],null, false)
	    context.pagesetter = newbieroad[0];
   }else if(paramTemp=="10003"||paramTemp.equals("10003")){
	    helpclassthree = delegator.findByAnd("HelpClassification", [classificationName : "买家保护"],null, false)
	    buyerprotection = delegator.findByAnd("HelpInformation", [helpClassId : helpclassthree[0].helpClassId],null, false)
	    context.pagesetter = buyerprotection[0];
   }else if(paramTemp=="10004"||paramTemp.equals("10004")){
	    helpclassseven = delegator.findByAnd("HelpClassification", [classificationName : "帮助"],null, false)
	    helps = delegator.findByAnd("HelpInformation", [helpClassId : helpclassseven[0].helpClassId],null, false)
	    context.pagesetter = helps[0];
   }else if(paramTemp=="10005"||paramTemp.equals("10005")){
	    helpclasseight = delegator.findByAnd("HelpClassification", [classificationName : "客服"],null, false)
	    customerservice = delegator.findByAnd("HelpInformation", [helpClassId : helpclasseight[0].helpClassId],null, false)
	    context.pagesetter = customerservice[0];
   }else if(paramTemp=="10006"||paramTemp.equals("10006")){
	    helpclassnine = delegator.findByAnd("HelpClassification", [classificationName : "关于网站"],null, false)
	    onwebsite = delegator.findByAnd("HelpInformation", [helpClassId : helpclassnine[0].helpClassId],null, false)
	    context.pagesetter = onwebsite[0];
   }else if(paramTemp=="10007"||paramTemp.equals("10007")){
	    helpclassten = delegator.findByAnd("HelpClassification", [classificationName : "隐私条款"],null, false)
	    privacypolicy = delegator.findByAnd("HelpInformation", [helpClassId : helpclassten[0].helpClassId],null, false)
	    context.pagesetter = privacypolicy[0];
   }else if(paramTemp=="10008"||paramTemp.equals("10008")){
	    helpclasseleven = delegator.findByAnd("HelpClassification", [classificationName : "使用条款"],null, false)
	    termsuse = delegator.findByAnd("HelpInformation", [helpClassId : helpclasseleven[0].helpClassId],null, false)
	    context.pagesetter = termsuse[0];
   }else if(paramTemp=="10009"||paramTemp.equals("10009")){
	    helpclasstwelve = delegator.findByAnd("HelpClassification", [classificationName : "卖家平台"],null, false)
	    sellerplatform = delegator.findByAnd("HelpInformation", [helpClassId : helpclasstwelve[0].helpClassId],null, false)
	    context.pagesetter = sellerplatform[0];
   } 
    
    context.paramTemp = paramTemp;
    
    

   

    








    
    
    
    
    
    
    /*      helpclassone = delegator.findByAnd("HelpClassification", [classificationName : "关于我们"],null, false)
    aboutus = delegator.findByAnd("HelpInformation", [helpClassId : helpclassone[0].helpClassId],null, false)
    context.aboutus = aboutus[0];
    
    helpclasstwo = delegator.findByAnd("HelpClassification", [classificationName : "新手上路"],null, false)
    newbieroad = delegator.findByAnd("HelpInformation", [helpClassId : helpclasstwo[0].helpClassId],null, false)
    context.newbieroad = newbieroad[0];
    
    helpclassthree = delegator.findByAnd("HelpClassification", [classificationName : "买家保护"],null, false)
    buyerprotection = delegator.findByAnd("HelpInformation", [helpClassId : helpclassthree[0].helpClassId],null, false)
    context.buyerprotection = buyerprotection[0];
   
    helpclassfour = delegator.findByAnd("HelpClassification", [classificationName : "所有商品"],null, false)
    allgoods = delegator.findByAnd("HelpInformation", [helpClassId : helpclassfour[0].helpClassId],null, false)
    context.allgoods = allgoods[0];
   
    helpclassfive = delegator.findByAnd("HelpClassification", [classificationName : "所有促销商品"],null, false)
    allpromotionalitems = delegator.findByAnd("HelpInformation", [helpClassId : helpclassfive[0].helpClassId],null, false)
    context.allpromotionalitems = allpromotionalitems[0];

    helpclasssix = delegator.findByAnd("HelpClassification", [classificationName : "所有热搜关键词"],null, false)
    allhotsearchkeywords = delegator.findByAnd("HelpInformation", [helpClassId : helpclasssix[0].helpClassId],null, false)
    context.allhotsearchkeywords = allhotsearchkeywords[0];
    
    helpclassseven = delegator.findByAnd("HelpClassification", [classificationName : "帮助"],null, false)
    helps = delegator.findByAnd("HelpInformation", [helpClassId : helpclassseven[0].helpClassId],null, false)
    context.helps = helps[0];
    
    helpclasseight = delegator.findByAnd("HelpClassification", [classificationName : "客服"],null, false)
    customerservice = delegator.findByAnd("HelpInformation", [helpClassId : helpclasseight[0].helpClassId],null, false)
    context.customerservice = customerservice[0];

    helpclassnine = delegator.findByAnd("HelpClassification", [classificationName : "关于网站"],null, false)
    onwebsite = delegator.findByAnd("HelpInformation", [helpClassId : helpclassnine[0].helpClassId],null, false)
    context.onwebsite = onwebsite[0];

    helpclassten = delegator.findByAnd("HelpClassification", [classificationName : "隐私条款"],null, false)
    privacypolicy = delegator.findByAnd("HelpInformation", [helpClassId : helpclassten[0].helpClassId],null, false)
    context.privacypolicy = privacypolicy[0];

    helpclasseleven = delegator.findByAnd("HelpClassification", [classificationName : "使用条款"],null, false)
    termsuse = delegator.findByAnd("HelpInformation", [helpClassId : helpclasseleven[0].helpClassId],null, false)
    context.termsuse = termsuse[0];

    helpclasstwelve = delegator.findByAnd("HelpClassification", [classificationName : "卖家平台"],null, false)
    sellerplatform = delegator.findByAnd("HelpInformation", [helpClassId : helpclasstwelve[0].helpClassId],null, false)
    context.sellerplatform = sellerplatform[0];*/
    
    
