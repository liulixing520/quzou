package com.mobileStore.common;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javolution.util.FastList;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.ofbiz.base.crypto.HashCrypt;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilGenerics;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.common.login.LoginServices;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityUtilProperties;
import org.ofbiz.service.LocalDispatcher;

import com.mobileStore.sms.CCPRestSmsSDK;

public class CommonEvents {
	public static final String module = CommonEvents.class.getName();

	public static String getCaptcha(HttpServletRequest request, HttpServletResponse response) {
		try {
			Delegator delegator = (Delegator) request.getAttribute("delegator");
			final String captchaSizeConfigName = StringUtils.defaultIfEmpty(request.getParameter("captchaSize"), "default");
			final String captchaSizeConfig = EntityUtilProperties.getPropertyValue("captcha.properties", "captcha." + captchaSizeConfigName, delegator);
			final String[] captchaSizeConfigs = captchaSizeConfig.split("\\|");
			final String captchaCodeId = StringUtils.defaultIfEmpty(request.getParameter("captchaCodeId"), "");

			final int fontSize = Integer.parseInt(captchaSizeConfigs[0]);
			final int height = Integer.parseInt(captchaSizeConfigs[1]);
			final int width = Integer.parseInt(captchaSizeConfigs[2]);
			final int charsToPrint = UtilProperties.getPropertyAsInteger("captcha.properties", "captcha.code_length", 4);
			final char[] availableChars = EntityUtilProperties.getPropertyValue("captcha.properties", "captcha.characters", delegator).toCharArray();

			// It is possible to pass the font size, image width and height with
			// the request as well
			Color backgroundColor = Color.white;
			Color borderColor = Color.white;
			Color textColor = Color.red;
			Color circleColor = new Color(160, 160, 160);
			Font textFont = new Font("Arial", Font.PLAIN, fontSize);
			int circlesToDraw = 4;
			float horizMargin = 20.0f;
			double rotationRange = 0.7; // in radians
			BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

			Graphics2D g = (Graphics2D) bufferedImage.getGraphics();

			g.setColor(backgroundColor);
			g.fillRect(0, 0, width, height);

			// Generating some circles for background noise
			g.setColor(circleColor);
			for (int i = 0; i < circlesToDraw; i++) {
				int circleRadius = (int) (Math.random() * height / 2.0);
				int circleX = (int) (Math.random() * width - circleRadius);
				int circleY = (int) (Math.random() * height - circleRadius);
				g.drawOval(circleX, circleY, circleRadius * 2, circleRadius * 2);
			}
			g.setColor(textColor);
			g.setFont(textFont);

			FontMetrics fontMetrics = g.getFontMetrics();
			int maxAdvance = fontMetrics.getMaxAdvance();
			int fontHeight = fontMetrics.getHeight();

			String captchaCode = RandomStringUtils.random(4, availableChars);

			float spaceForLetters = -horizMargin * 2 + width;
			float spacePerChar = spaceForLetters / (charsToPrint - 1.0f);

			for (int i = 0; i < captchaCode.length(); i++) {

				int charWidth = fontMetrics.charWidth(captchaCode.charAt(i));
				int charDim = Math.max(maxAdvance, fontHeight);
				int halfCharDim = (charDim / 2);

				BufferedImage charImage = new BufferedImage(charDim, charDim, BufferedImage.TYPE_INT_ARGB);
				Graphics2D charGraphics = charImage.createGraphics();
				charGraphics.translate(halfCharDim, halfCharDim);
				double angle = (Math.random() - 0.5) * rotationRange;
				charGraphics.transform(AffineTransform.getRotateInstance(angle));
				charGraphics.translate(-halfCharDim, -halfCharDim);
				charGraphics.setColor(textColor);
				charGraphics.setFont(textFont);

				int charX = (int) (0.5 * charDim - 0.5 * charWidth);
				charGraphics.drawString("" + captchaCode.charAt(i), charX, ((charDim - fontMetrics.getAscent()) / 2 + fontMetrics.getAscent()));

				float x = horizMargin + spacePerChar * (i) - charDim / 2.0f;
				int y = ((height - charDim) / 2);

				g.drawImage(charImage, (int) x, y, charDim, charDim, null, null);

				charGraphics.dispose();
			}
			// Drawing the image border
			g.setColor(borderColor);
			g.drawRect(0, 0, width - 1, height - 1);
			g.dispose();
			response.setContentType("image/jpeg");
			ImageIO.write(bufferedImage, "jpg", response.getOutputStream());
			HttpSession session = request.getSession();
			Map<String, String> captchaCodeMap = UtilGenerics.checkMap(session.getAttribute("_CAPTCHA_CODE_"));
			if (captchaCodeMap == null) {
				captchaCodeMap = new HashMap<String, String>();
				session.setAttribute("_CAPTCHA_CODE_", captchaCodeMap);
			}
			captchaCodeMap.put(captchaCodeId, captchaCode);
		} catch (Exception ioe) {
			Debug.logError(ioe.getMessage(), module);
		}
		return "success";
	}

	public static String registerValid(HttpServletRequest request, HttpServletResponse response) {
		String mobile = request.getParameter("mobile");
		if (mobile == null || mobile.trim().equals("")) {
			request.setAttribute("_ERROR_MESSAHE_", "手机号码不能为空！");
			request.setAttribute("flag", "1");
			return "error";
		}
		HttpSession session = request.getSession();
		String validateCode = request.getParameter("validateCode");
		String codeKey = request.getParameter("codeKey");
		if (validateCode == null || codeKey == null) {
			request.setAttribute("_ERROR_MESSAHE_", "验证码出错了！");
			request.setAttribute("flag", "3");
			return "error";
		}
		Map<String, String> captchaCodeMap = (Map<String, String>) session.getAttribute("_CAPTCHA_CODE_");
		if (captchaCodeMap == null) {
			request.setAttribute("_ERROR_MESSAHE_", "验证码错误！");
			request.setAttribute("flag", "4");
			return "error";
		}
		String captchaCode = captchaCodeMap.get(codeKey);
		if (captchaCode == null || !captchaCode.equalsIgnoreCase(validateCode)) {
			request.setAttribute("_ERROR_MESSAHE_", "验证码错误！");
			request.setAttribute("flag", "4");
			return "error";
		}
		captchaCodeMap.put("registerMobile", mobile);
		session.setAttribute("_CAPTCHA_CODE_", captchaCodeMap);
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		try {
			GenericValue gv = delegator.findOne("UserLogin", false, UtilMisc.toMap("bindMobile", mobile));
			List<GenericValue> gvs = delegator.findByAnd("UserLogin", UtilMisc.toMap("bindMobile", mobile), null, false);
			if (gv != null || gvs.size() > 0) {
				request.setAttribute("_ERROR_MESSAHE_", "手机号码已被注册！");
				request.setAttribute("flag", "2");
				return "error";
			}
		} catch (Exception e) {
			Debug.logError(e, module);
		}
		request.setAttribute("success", "Y");
		return "success";
	}

	public static String sendSmsCode(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String mobileNum = request.getParameter("mobile");
		String smsCode = RandomStringUtils.random(6, "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		String[] data = new String[] { smsCode };
		HashMap<String, Object> returnMap = CCPRestSmsSDK.sendTemplateSMS(mobileNum, "5006", data);
		/*
		 * hashMap.put("statusCode", code); hashMap.put("statusMsg", msg);
		 */
		Object statusCode = returnMap.get("statusCode");
		if (statusCode.equals("172001") || statusCode.equals("172002") || statusCode.equals("172003")) {
			Debug.logError((String) returnMap.get("statusMsg"), module);
			request.setAttribute("info", "短信发送失败");
		} else {
			request.setAttribute("info", "验证码已发送到" + mobileNum);
			request.setAttribute("flag", "Y");
			Map<String, String> captchaCodeMap = ((Map<String, String>) session.getAttribute("_CAPTCHA_CODE_"));
			captchaCodeMap.put("smsCode", smsCode);
			session.setAttribute("_CAPTCHA_CODE_", captchaCodeMap);
		}

		return "success";
	}

	public static String validSmsCode(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String mobileNum = request.getParameter("mobile");
		String smsCode = request.getParameter("smscode");
		String pwd = request.getParameter("pwd");

		if (UtilValidate.isEmpty(pwd)) {
			request.setAttribute("info", "登录密码不能为空！");
			return "error";
		}
		if (UtilValidate.isEmpty(mobileNum) || UtilValidate.isEmpty(smsCode)) {
			request.setAttribute("info", "系统错误，请联系客服！");// 传值错误
			return "error";
		}
		Map<String, String> captchaCodeMap = ((Map<String, String>) session.getAttribute("_CAPTCHA_CODE_"));
		if (captchaCodeMap == null) {
			request.setAttribute("info", "系统错误，请联系客服！");// session数据丢失
			return "error";
		}
		Object _mobileNum = captchaCodeMap.get("registerMobile");
		Object _smsCode = captchaCodeMap.get("smsCode");
		if (UtilValidate.isEmpty(_mobileNum) || UtilValidate.isEmpty(_smsCode)) {
			request.setAttribute("info", "系统错误，请联系客服！");// session数据丢失
			return "error";
		}
		if (mobileNum.equals(_mobileNum) && smsCode.equalsIgnoreCase((String) _smsCode)) {
			return "success";
		} else {
			request.setAttribute("info", "短信验证码错误！");
			return "error";
		}
	}

	public static String createcustomer(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
		HttpSession session = request.getSession();
		String mobileNum = request.getParameter("mobile");
		String pwd = request.getParameter("pwd");
		String unbindMobile = request.getParameter("unbindMobile");
		boolean beganTransaction = false;
		try {
			beganTransaction = TransactionUtil.begin();
			if (unbindMobile != null && unbindMobile.endsWith("Y")) {
				delegator.storeByCondition("UserLogin", UtilMisc.toMap("bindMobile", null), EntityCondition.makeCondition("bindMobile", mobileNum));
			}
			GenericValue sysUl = delegator.findOne("UserLogin", false, UtilMisc.toMap("userLoginId", "system"));

			Properties properties = UtilProperties.getProperties("security");
			String username_lowercase = properties.getProperty("username.lowercase");
			String password_lowercase = properties.getProperty("username.lowercase");
			if (username_lowercase.equals("true")) {
				// mobileNum = mobileNum.toLowerCase();
			}
			if (password_lowercase.equals("true")) {
				pwd = pwd.toLowerCase();
			}
			Timestamp nowStamp = UtilDateTime.nowTimestamp();
			String userLoginId = delegator.getNextSeqId("UserLogin");

			String partyId = delegator.getNextSeqId("Party");
			String statusId = "PARTY_ENABLED";
			Map<String, Object> newPartyMap = UtilMisc.toMap("partyId", partyId, "partyTypeId", "PERSON", "createdDate", nowStamp, "lastModifiedDate", nowStamp, "statusId", statusId);
			List<GenericValue> toBeStored = FastList.newInstance();

			GenericValue party = delegator.makeValue("Party", newPartyMap);
			toBeStored.add(party);
			GenericValue statusRec = delegator.makeValue("PartyStatus", UtilMisc.toMap("partyId", partyId, "statusId", statusId, "statusDate", nowStamp));
			toBeStored.add(statusRec);
			GenericValue person = delegator.makeValue("Person", UtilMisc.toMap("partyId", partyId));
			person.set("firstName", mobileNum);
			toBeStored.add(person);
			delegator.storeAll(toBeStored);

			boolean useEncryption = "true".equals(EntityUtilProperties.getPropertyValue("security.properties", "password.encrypt", delegator));
			GenericValue userLoginToCreate = delegator.makeValue("UserLogin", UtilMisc.toMap("userLoginId", userLoginId));
			userLoginToCreate.set("currentPassword", useEncryption ? HashCrypt.cryptUTF8(LoginServices.getHashType(), null, pwd) : pwd);
			userLoginToCreate.set("partyId", partyId);
			userLoginToCreate.set("bindMobile", mobileNum);
			userLoginToCreate.create();
			LoginServices.createUserLoginPasswordHistory(delegator, userLoginId, pwd);
			// create the PartyDataSource entry to track where this info came
			// from...
			GenericValue partyDataSource = delegator.makeValue("PartyDataSource");
			partyDataSource.set("dataSourceId", "ECOMMERCE_SITE");
			partyDataSource.set("fromDate", nowStamp);
			partyDataSource.set("isCreate", "Y");
			GenericValue visit = (GenericValue) session.getAttribute("visit");
			partyDataSource.set("visitId", visit.get("visitId"));
			partyDataSource.set("partyId", partyId);
			partyDataSource.create();

			delegator.create("PartyRole", UtilMisc.toMap("partyId", partyId, "roleTypeId", "CUSTOMER"));
			delegator.create("PartyRole", UtilMisc.toMap("partyId", partyId, "roleTypeId", "OWNER"));
			delegator.create("PartyRole", UtilMisc.toMap("partyId", partyId, "roleTypeId", "BILL_FROM_VENDOR"));
			delegator.create("PartyRole", UtilMisc.toMap("partyId", partyId, "roleTypeId", "BILL_TO_CUSTOMER"));
			delegator.create("PartyRole", UtilMisc.toMap("partyId", partyId, "roleTypeId", "PLACING_CUSTOMER"));

			Map<String, Object> securityParams = UtilMisc.toMap("userLoginId", userLoginId, "groupId", "ECOMMERCE_CUSTOMER", "userLogin", sysUl);
			dispatcher.runSync("addUserLoginToSecurityGroup", securityParams);
			TransactionUtil.commit(beganTransaction);
		} catch (Exception e) {
			Debug.logError(e, module);
			request.setAttribute("info", e.getMessage());
			try {
				TransactionUtil.rollback(beganTransaction, e.getMessage(), e);
			} catch (GenericTransactionException e1) {
				e1.printStackTrace();
			}
		}
		return "success";
	}

	public static String loginCheck(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		Object isChecked = request.getAttribute("isChecked");
		if (isChecked != null && isChecked.equals("Y")) {
			return "error";
		}
		request.setAttribute("isChecked", "Y");
		String userName = request.getParameter("USERNAME");
		String password = request.getParameter("PASSWORD");

		try {
			if (userName != null) {
				List<GenericValue> uls = delegator.findByAnd("UserLogin", UtilMisc.toMap("bindMobile", userName), null, false);
				if (uls.size() == 1) {
					request.setAttribute("USERNAME", uls.get(0).getString("userLoginId"));
					request.setAttribute("PASSWORD", password);
				} else {
					throw new RuntimeException("密码错误并且无法确定绑定账户！");
				}
			} else {
				throw new RuntimeException("用户名不能为空!");
			}
		} catch (GenericEntityException e) {
			Debug.logError(e.getMessage(), module);
			return "error";
		}

		return "success";
	}
}
