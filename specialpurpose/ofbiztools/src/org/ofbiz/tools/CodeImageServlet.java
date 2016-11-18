package org.ofbiz.tools;

import java.awt.Color;
import java.util.Map;
import java.util.Random;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ofbiz.base.util.UtilValidate;

/**
 * @author qiming
 */
public class CodeImageServlet extends HttpServlet {
	private static final long serialVersionUID = -3009566067057500724L;
	public static final String module = CodeImageServlet.class.getName();
	
	/** 验证码图片的宽度 */
	public static final int W = 105; //118

	/** 验证码图片的高度 */
	public static final int H = 40; //25
	
	private static final String[] codes = {"a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "m", "n", "p", "q", 
			"r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", 
			"E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
	
	private static final String[] numberCodes = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};

	private static Random random = new Random();
	

	/** 获取随机颜色 */
	private Color getRandomColor(int min, int max) {
		if (min > 255)
			min = 255;
		if (max > 255)
			max = 255;
		int r = min + random.nextInt(max - min);
		int g = min + random.nextInt(max - min);
		int b = min + random.nextInt(max - min);
		return new Color(r, g, b);
	}
	
	/***
	 * 生成一个随机字符串,随机字符串中至少要含有一个字符或者字母
	 * @param length 随机字符串长度
	 */
	public static String randomGenerateCode( int length ){
		
		StringBuilder code = new StringBuilder();
			//生成8个字母加数字的随机数
		for(int i = 0; i < length ; i++){
			//如果随机数是偶数,则添加一个随机字母
			if( ( random.nextInt(1000) % 2 ) == 0 ){
				code.append(codes[random.nextInt(codes.length)]);
			}
			else {
			//如果随机数是奇数,则添加一个随机数字
				code.append(numberCodes[random.nextInt(numberCodes.length)]);
			}
		}
			//如果全是数字,则随机替换一个为字母
		if( Pattern.matches("\\d{8}", code.toString()) ){
			code.setCharAt( random.nextInt(code.length()), codes[random.nextInt(codes.length)].charAt(0));
		}
		else if( Pattern.matches("[a-zA-Z]{8}", code.toString()) ){
			//如果全是字母，则随机替换一个为数字
			code.setCharAt( random.nextInt(code.length()), numberCodes[random.nextInt(numberCodes.length)].charAt(0));
		}
		return code.toString();
	}
	
	
	/**
     * 校验随机验证码图片
     * @param request
     * @param response
     * @return
     */
    public static String checkVerifyCode(HttpServletRequest request, HttpServletResponse response){
    	String userVCode = request.getParameter("randomCode");
    	//<session-to-field field="imageCaptchaCode" session-name="_CAPTCHA_CODE_" />
    	//String sysVCode = (String) request.getSession().getAttribute("randomCode");
    	Map imageCaptchaCode = (Map) request.getSession().getAttribute("_CAPTCHA_CODE_");
    	String sysVCode = (String)imageCaptchaCode.get("captchaImage");
    	if(userVCode.equalsIgnoreCase(sysVCode)){
    		//request.getSession().removeAttribute("randomCode");
			return "success";
    	}
    	return "error";
    }
    
    public static String checkVerifyCode2(HttpServletRequest request, HttpServletResponse response){
    	String userVCode = request.getParameter("randomCode");
    	//<session-to-field field="imageCaptchaCode" session-name="_CAPTCHA_CODE_" />
    	//String sysVCode = (String) request.getSession().getAttribute("randomCode");
    	String sysVCode = (String)request.getSession().getAttribute("_CAPTCHA_CODE_");
    	//String sysVCode = (String)imageCaptchaCode.get("captchaImage");
    	if(userVCode.equalsIgnoreCase(sysVCode)){
    		//request.getSession().removeAttribute("randomCode");
			return "success";
    	}
    	return "error";
    }
    
    
    /**
     * 通过指定key, 获取随机码; 返回并放入 session 中
     * @param request
     * @param key
     * @return
     */
    public static String getUUIDVerifyCode(HttpServletRequest request, String key){
    	String uuid = UtilUUID.uuidTomini();
    	
		String sessionCode = (String) request.getSession().getAttribute(key);
		if(UtilValidate.isNotEmpty(sessionCode)){
			request.getSession().removeAttribute(key);
		}
		
    	request.getSession().setAttribute(key, uuid);
    	return uuid;
    }

	/**
	 * 校验防重复提交验证码 [submit_notrepeat]
	 * @param request
	 * @param response
	 * @return
	 */
	public static String checkNoRepeatSubmit(HttpServletRequest request, HttpServletResponse response){
		String requestCode = request.getParameter("submit_notrepeat");
		String sessionCode = (String) request.getSession().getAttribute("submit_notrepeat");
		if(requestCode.equals(sessionCode)){
			request.getSession().removeAttribute("submit_notrepeat");
			return "success";
		}
		return "error";
	}
}
