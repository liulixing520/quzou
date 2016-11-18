package org.extErp.sysCommon.email;

public class EmailUtils {

	public static boolean sendEmail(String toAddress,String title,String context){
		MailSenderInfo mailInfo = new MailSenderInfo();   
		mailInfo.setMailServerHost("smtp.qq.com");   
		mailInfo.setMailServerPort("25");   
		mailInfo.setValidate(true);   
		mailInfo.setUserName("ccme@medref.cn");   
		mailInfo.setPassword("ofbiz11");//您的邮箱密码   
		mailInfo.setFromAddress("ccme@medref.cn");   
		mailInfo.setToAddress(toAddress);   
		mailInfo.setSubject(title);   
		mailInfo.setContent(context);   
		//这个类主要来发送邮件  
		SimpleMailSender sms = new SimpleMailSender();  
		return sms.sendTextMail(mailInfo);//发送文体格式   
		//sms.sendHtmlMail(mailInfo);//发送html格式 
	}
	      
}
