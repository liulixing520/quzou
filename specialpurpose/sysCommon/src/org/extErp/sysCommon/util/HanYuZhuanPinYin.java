package org.extErp.sysCommon.util;
import net.sourceforge.pinyin4j.*;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;
public class HanYuZhuanPinYin {
	 private static HanyuPinyinOutputFormat format = null;
     private static String[] pinyin;
	//转换单个字符
    public static String getCharacterPinYin(char c){
    	format = new HanyuPinyinOutputFormat();
        format.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        pinyin = null;
      try
      {
           pinyin = PinyinHelper.toHanyuPinyinStringArray(c, format);
      }
      catch(BadHanyuPinyinOutputFormatCombination e)
      {
           e.printStackTrace();
      }
      // 如果c不是汉字，toHanyuPinyinStringArray会返回null
      if(pinyin == null) return null;
      // 只取一个发音，如果是多音字，仅取第一个发音
      return pinyin[0];   
    }
    //转换一个字符串
    public static String getStringPinYin(String str){
      StringBuilder sb = new StringBuilder();
      String tempPinyin = null;
      for(int i = 0; i < str.length(); ++i)
      {
           tempPinyin =getCharacterPinYin(str.charAt(i));
           if(tempPinyin == null)
           {
                // 如果str.charAt(i)非汉字，则保持原样
                sb.append(str.charAt(i));
           }else{
                sb.append(tempPinyin);
           }
      }
      return sb.toString();
    }
    
	/**
	 * 普通的拼音转换
	 */
	public static void test1() {
		String[] pinyinArray =PinyinHelper.toHanyuPinyinStringArray('单');
		for(int i = 0; i < pinyinArray.length; ++i)
		{
	         System.out.println(pinyinArray[i]);
		}
	}
	/**
	 * 格式化拼音
	 */
	public static void test2() {
		HanyuPinyinOutputFormat Myformat= new HanyuPinyinOutputFormat();
		Myformat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);//声调的显示
		Myformat.setVCharType(HanyuPinyinVCharType.WITH_V);//u的显示ü/v/u
		Myformat.setCaseType(HanyuPinyinCaseType.UPPERCASE);//大小写

		String[] pinyinArray = null;
		try
		{
	         pinyinArray = PinyinHelper.toHanyuPinyinStringArray('率', Myformat);
		}
		catch(BadHanyuPinyinOutputFormatCombination e)
		{
		         e.printStackTrace();
		}
		for(int i = 0; i < pinyinArray.length; ++i)
		{
	         System.out.println(pinyinArray[i]);
		}
	}
	public static void test3() {
        // 中英文混合的一段文字
        String str = "荆溪白石出，Hello 天寒红叶稀。Android 山路元无雨，What's up?   空翠湿人衣。";
        String strPinyin = getStringPinYin(str);
        System.out.println(strPinyin);
	}
	public static void main(String[] args) {
		test1();
		test2();
		test3();
	}
	
}
