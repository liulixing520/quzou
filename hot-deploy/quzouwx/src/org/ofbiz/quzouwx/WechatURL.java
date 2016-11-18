package org.ofbiz.quzouwx;


/**
 *微信接口调用URL
 * 
 * @author 刘理星
 * @date 2015-04-20
 */
public class WechatURL {
	/**调用URL*/
	public static final String BASEURL = "https://api.weixin.qq.com/cgi-bin/";
	/** 获取TOKEN*/
	public static final String GetToken = "token";
	/** 上传永久素材*/
	public static final String AddMaterial = "material/add_material";
	/** 获取永久素材*/
	public static final String BatchgetMaterial = "material/batchget_material";
	/** 上传永久多图文素材*/
	public static final String AddNews = "material/add_news";
	/** 上传多图文素材*/
	public static final String UploadNews = "media/uploadnews";
	/** 创建分组*/
	public static final String CreatGroup = "groups/create";
	/** 查询分组*/
	public static final String GetGroup = "groups/get";
	/** 获取OpenID*/
	public static final String GetUsers = "user/get";
	/** 根据OpenID获取用户信息*/
	public static final String GetUserByOpendId = "user/info"; 
	/** 根据OpenID进行群发*/
	public static final String SendUsers = "message/mass/send"; 
	/** 根据group进行群发*/
	public static final String SendAll = "message/mass/sendall"; 
	/** 预览功能*/
	public static final String Preview = "message/mass/preview"; 
	

}
