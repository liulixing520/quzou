package org.ofbiz.jsoup;


import java.io.IOException;
import java.util.List;
import java.util.Map;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.ofbiz.base.util.UtilValidate;

public class GetXXXServices {

	
	/**
	 * 示例抽取
	 * @param pageHtml
	 * @throws IOException 
	 */
	public static Map<String,Object> getFisrtHtml(String url) throws IOException{
		Map<String,Object> map = FastMap.newInstance();
		Document doc = Jsoup.connect(url).get();
		
		if(doc==null){
			return null;
		}
		
		
		Elements news_con = doc.getElementsByClass("news_con");
		Element p2 = news_con.first();
		Elements h1 = p2.getElementsByTag("H1");
		Element title = h1.first();
		map.put("title", title.ownText());
		System.out.println("title="+title.ownText());
		
		Elements a_abstract = doc.getElementsByClass("a_abstract");
		Element a_abstract1 = a_abstract.first();
		Elements span =a_abstract1.getElementsByTag("span");
		Element span1 = span.first();
		map.put("shortTitle", span1.ownText());
		System.out.println("zhaiyao="+span1.ownText());
		
		Elements news_con_p = doc.getElementsByClass("news_con_p");
		Element news_con_p1 = news_con_p.first();
		map.put("content", news_con_p1.html());
		System.out.println("descption="+news_con_p1.html());
		
		return map;
		
		

  	  
	}
	
	 
	
	 
	 
	 public static void main(String[] args) {
		 
	    }
	
	public static List<Map<String,Object>> getList(int number){
		List<Map<String,Object>> list = FastList.newInstance();
		try{
			List<String>  urlList = getHtmlUrl(number);
			for(String url : urlList){
				Map<String,Object> map = getHtmlParser(url);
				if(UtilValidate.isNotEmpty(map)){
					list.add(map);
//					System.out.println(map);
				}
			}
        } catch (IOException e) {
			e.printStackTrace();
		}
		return list;
	}
	/**
	 * 抽取单独一个页面
	 */
	public static Map<String,Object> getHtmlParser(String url) throws IOException{
		Map<String,Object> map = FastMap.newInstance();
		Document doc = Jsoup.connect(url).get();
		
		if(doc==null){
			return null;
		}
		
		Elements news_con = doc.getElementsByClass("news_con");
		Element p2 = news_con.first();
		

		Elements h1 = p2.getElementsByTag("H1");
		Element title = h1.first();
		map.put("title", title.ownText());
//		System.out.println("title="+title.ownText());
		
		Elements a_abstract = doc.getElementsByClass("a_abstract");
		Element a_abstract1 = a_abstract.first();
		Elements span =a_abstract1.getElementsByTag("span");
		Element span1 = span.first();
		map.put("shortTitle", span1.ownText());
//		System.out.println("zhaiyao="+span1.ownText());
		
		Elements news_con_p = doc.getElementsByClass("news_con_p");
		Element news_con_p1 = news_con_p.first();
		map.put("content", news_con_p1.html());
//		System.out.println("descption="+news_con_p1.html());
		
		return map;
		
  	  
	}
	
	/**
	 * 示例
	 * 抽取
	 * @param pageHtml
	 * @throws IOException 
	 */
	public static List<String> getHtmlUrl(int number){
		List<String> list = FastList.newInstance();
		try {
			for(int i = 1;i<=number;i++){
				Document doc = Jsoup.connect("http://news.wangdaizhijia.com/news-1-"+i+".html").get();
				if(doc==null){
					continue;
				}
				
				Elements news_con = doc.getElementsByClass("news_con");
				
				for(int j =0;j<news_con.size();j++){
					Element p2 = news_con.get(j);
					Elements a = p2.getElementsByClass("news_til");
					Element news_til = a.first();
					list.add(news_til.attr("href"));
					System.out.println("href="+news_til.attr("href"));
				}
				
			}
			for(int i = 1;i<=number-11;i++){
				Document doc = Jsoup.connect("http://news.wangdaizhijia.com/news-2-"+i+".html").get();
				if(doc==null){
					continue;
				}
				
				Elements news_con = doc.getElementsByClass("news_con");
				
				for(int j =0;j<news_con.size();j++){
					Element p2 = news_con.get(j);
					Elements a = p2.getElementsByClass("news_til");
					Element news_til = a.first();
					list.add(news_til.attr("href"));
					System.out.println("href="+news_til.attr("href"));
				}
				
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return list;
		
		

  	  
	}
	    


}
