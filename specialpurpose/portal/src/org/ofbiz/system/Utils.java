package org.ofbiz.iteamgr.system;
import org.ofbiz.base.util.UtilProperties;

public class Utils{
	

	private static final String imagesCdnUrl = UtilProperties.getPropertyValue("outStaticUrl.properties", "images.cdn.url");
	private static final String jsCdnUrl = UtilProperties.getPropertyValue("outStaticUrl.properties", "js.cdn.url");
	private static final String cssCdnUrl = UtilProperties.getPropertyValue("outStaticUrl.properties", "css.cdn.url");
	
	public static String getImagesUrl(){
		return imagesCdnUrl;
	}
	
	public static String getJsUrl(){
		return jsCdnUrl;
	}
	
	public static String getCssUrl(){
		return cssCdnUrl;
	}

}