package org.ofbiz.base.util;

import java.io.File;
import java.io.StringWriter;
import java.io.Writer;

import org.ofbiz.base.util.FileUtil;
import org.ofbiz.base.util.cache.UtilCache;
import org.ofbiz.base.util.collections.MapStack;
import org.ofbiz.entity.model.ModelReader;
import org.ofbiz.widget.cache.GenericWidgetOutput;
import org.ofbiz.widget.renderer.ScreenRenderer;


public class UtilStaticHtml{
	public static final String module = UtilStaticHtml.class.getName();
	
	private static final UtilCache<String, String> staticHtmls = UtilCache.createUtilCache("screens.staticHtml", 0, 0);
	
	/**
	 * 
	 * @param fullFilePath
	 * @param screens
	 * @param combinedName
	 * @param useCache
	 * @return
	 * use example: 
	 	<#assign catalogMenu=Static["org.ofbiz.base.util.UtilStaticHtml"].screensRenderAsText("component://images/webapp/images/static/catalogMenu.ftl",screens,"component://ecommerce/widget/CommonScreens.xml#catalogMenu",true)>
		${StringUtil.wrapString(catalogMenu!)}
		delete the file("component://images/webapp/images/static/catalogMenu.ftl") when update
	 * 
	 */
	public static String screensRenderAsText(String fullFilePath,ScreenRenderer screens,String combinedName,Boolean useCache){
		if(useCache){ 
			String staticHtml = staticHtmls.get(fullFilePath);
	        if (staticHtml == null) {
	        	staticHtml = screensRenderAsText(fullFilePath,screens,combinedName);
	        	staticHtmls.put(fullFilePath, staticHtml);
	        }
	        return staticHtml;
		}else{
			return screensRenderAsText(fullFilePath,screens,combinedName);
		}
	}
	
	/**
	 * 
	 * @param fullFilePath
	 * @param screens
	 * @param combinedName
	 * @return
	 */
	public static String screensRenderAsText(String fullFilePath,ScreenRenderer screens,String combinedName){
		String staticHtml = null;
		File staticFile = FileUtil.getFile(fullFilePath);
		try{
			if(staticFile.exists()){
				staticHtml = FileUtil.readString("UTF-8", staticFile);
			}else{
				MapStack<String> swContext = (MapStack<String>)screens.getContext();
				Writer sw = new StringWriter();
	            ScreenRenderer swScreens = new ScreenRenderer(sw,swContext, screens.getScreenStringRenderer());
	            swContext.put("screens", swScreens);
				swScreens.render(combinedName);
				GenericWidgetOutput gwo = new GenericWidgetOutput(sw.toString());    
				staticHtml = gwo.toString();
				FileUtil.writeString("UTF-8", staticHtml, staticFile);
			}
		}catch(Exception e){
			Debug.logError(e, "Error while screensRenderAsText: ", module);
		}
		return staticHtml;
	}
}