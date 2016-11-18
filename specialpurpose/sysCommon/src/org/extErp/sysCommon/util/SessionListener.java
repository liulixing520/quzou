package org.extErp.sysCommon.util;

import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * 
 * 
 * @project price_v2.0
 * @author Lux
 * @version v1.0.0 2013-06-14 
 */
public class SessionListener implements HttpSessionListener {

	private static HashMap<String,HttpSession> hUserName = new HashMap<String,HttpSession>();// 保存sessionID和username的映射

	/** 以下是实现HttpSessionListener中的方法 **/

	public void sessionCreated(HttpSessionEvent httpSessionEvent) {
	}

	public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
	}

	/*
	 * 
	 * isAlreadyEnter-用于判断用户是否已经登录以及相应的处理方法
	 * 
	 * @param sUserName String-登录的用户名称
	 * 
	 * @return boolean-该用户是否已经登录过的标志
	 */

	public static boolean isAlreadyEnter(HttpSession session, String sUserName) {

		boolean flag = false;

		if (hUserName.containsKey(sUserName)) {// 如果该用户已经登录过，则使上次登录的用户掉线(依据使用户名是否在hUserName中)

			flag = true;
			HttpSession session1 = hUserName.get(sUserName);
			session1.invalidate();
			// 遍历原来的hUserName，删除原用户名对应的sessionID(即删除原来的sessionID和username)
			System.out.println("hUserName = " + hUserName);

		}

		else {// 如果该用户没登录过，直接添加现在的sessionID和username

			flag = false;
		}
		hUserName.put(sUserName, session);

		return flag;

	}

	/*
	 * 
	 * isOnline-用于判断用户是否在线
	 * 
	 * @param session HttpSession-登录的用户名称
	 * 
	 * @return boolean-该用户是否在线的标志
	 */

	public static boolean isOnline(HttpSession session) {

		boolean flag = true;

		if (hUserName.containsValue(session)) {
			flag = true;
		}

		else {

			flag = false;

		}

		return flag;

	}
	
}
