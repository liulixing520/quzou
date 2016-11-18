package org.extErp.sysCommon.util.barcode;

import java.awt.Color;
import java.awt.Font;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.StringTokenizer;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class BarCodeUtil
{

    public static BarCode barcode;

    public BarCodeUtil()
    {}

    public static void main(String[] aeges)
    {
	new BarCodeUtil().barCode("HT10220120899988", "d://123.jpeg");
    }

    public static void barCode(String codeString, String imgfilePath)
    {
	File imgfile = new File(imgfilePath);
	FileOutputStream fos;
	try
	{
	    BarCode barcode1 = getChart(codeString);

	    barcode1.setSize(barcode1.width, barcode1.height);
	    if (barcode1.autoSize)
	    {
		BufferedImage bufferedimage = new BufferedImage(barcode1.getSize().width, barcode1.getSize().height, 13);
		java.awt.Graphics2D graphics2d = bufferedimage.createGraphics();
		barcode1.paint(graphics2d);
		barcode1.invalidate();
		graphics2d.dispose();
	    }
	    BufferedImage bufferedimage1 = new BufferedImage(barcode1.getSize().width, barcode1.getSize().height, 1);
	    java.awt.Graphics2D graphics2d1 = bufferedimage1.createGraphics();
	    barcode1.paint(graphics2d1);

	    fos = new FileOutputStream(imgfile);
	    BufferedOutputStream bos = new BufferedOutputStream(fos);
	    JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(bos);

	    encoder.encode(bufferedimage1);
	    bos.close();

	} catch (Exception exception)
	{
	    exception.printStackTrace();
	}
    }

    private static BarCode getChart(String codeString)
    {
	if (barcode == null)
	    barcode = new BarCode();
	try
	{
	    // barType(默认为CODE128):条码类型.支持18钟类型,分别是
	    // CODE39,CODE39EXT,INTERLEAVED25,CODE11,CODABAR,MSI,UPCA,IND25,MAT25,CODE93,EAN13,EAN8,UPCE,CODE128,CODE93EXT,POSTNET,PLANET,UCC128
	    // .
	    setParameter("barType", "CODE128");
	    // width(默认为自适应,一般不用自行设置): 图片宽度.width,height要同时都设置才有效.
	    setParameter("width", "1");
	    // height(默认为自适应,一般不用自行设置): 图片高度.width,height要同时都设置才有效.
	    setParameter("height", "1");
	    // 默认大小
	    setParameter("autoSize", "y");
	    // code: 要打印的条码内容.
	    setParameter("code", codeString);
	    // st(默认为y显示): 是否显示条码内容(show
	    // text).默认会在条码图片下方显示条码内容,有效值为y和n.
	    setParameter("st", "y");
	    // textFont(默认为Arial|PLAIN|11): 条码文本的字体,字体有效格式为<font
	    // name>|<style>|<size>.Style可以是PLAIN,ITALIC或BOLD.
	    setParameter("textFont", "Arial|PLAIN|11");
	    // fontColor(默认为黑色):
	    // 条码文本的颜色,有效值为RED,BLUE,GREEN,BLACK,GRAY,LIGHTGRAY,WHITE,DARKGRAY,YELLOW,ORANGE,CYAN和MAGENTA.
	    setParameter("fontColor", "BLACK");
	    // barColor(默认为黑色): 条码的颜色.
	    setParameter("barColor", "BLACK");
	    // backColor(默认为白色): 图片背景颜色.
	    setParameter("backColor", "WHITE");
	    // rotate(默认为0):
	    // 设置条码旋转角度.有效值为0(不旋转),90(旋转90度),180(旋转180度),270(旋转270度).
	    setParameter("rotate", "0");
	    // barHeightCM(默认为1厘米): 条码的高度.
	    setParameter("barHeightCM", "0.8");
	    // x(默认为0.03厘米,一般不用自行调整):
	    // 条码符号中窄单元的标称尺寸,最小可设置为0.001即1象素,通常以0.03递增.
	    setParameter("x", "0.03");
	    // n(默认为2倍):
	    // 宽窄比,平均宽条的条宽与平均宽空的空宽之和(条码字符间隔不计在内)除以两倍窄单元尺寸.它是宽度调节编码法中的技术参数.
	    setParameter("n", "2");
	    // leftMarginCM(默认为0.3厘米): 条码与图片左右边的距离.
	    setParameter("leftMarginCM", "0.3");
	    // topMarginCM(默认为0.2厘米): 条码与图片上下边的距离.
	    setParameter("topMarginCM", "0.1");
	    // checkCharacter(默认为y,一般不用自行设置): 是否自动计算check
	    // character,有效值为y和n.
	    setParameter("checkCharacter", "y");
	    // checkCharacterInText(默认为y,一般不用自行设置): 条码内容是否自动计算check
	    // character,有效值为y和n.
	    setParameter("checkCharacterInText", "y");
	    // Code128Set(默认为0自动选择,一般不用设置):
	    // 设置CODE128中使用的字符集.有效值为0,A,B,C.
	    setParameter("Code128Set", "0");
	    // UPCESytem(默认为0,一般不用自行设置): UPCE中使用的编码系统.有效值为0和1.
	    setParameter("UPCESytem", "0");
	} catch (Exception exception)
	{
	    exception.printStackTrace();
	    barcode.code = "Parameter Error";
	}
	return barcode;
    }

    public static void setParameter(String s, String s1)
    {
	if (s1 != null)
	    if (s.equals("code"))
		barcode.code = s1;
	    else if (s.equals("width"))
		barcode.width = (new Integer(s1)).intValue();
	    else if (s.equals("height"))
		barcode.height = (new Integer(s1)).intValue();
	    else if (s.equals("autoSize"))
		barcode.autoSize = s1.equalsIgnoreCase("y");
	    else if (s.equals("st"))
		barcode.showText = s1.equalsIgnoreCase("y");
	    else if (s.equals("textFont"))
		barcode.textFont = convertFont(s1);
	    else if (s.equals("fontColor"))
		barcode.fontColor = convertColor(s1);
	    else if (s.equals("barColor"))
		barcode.barColor = convertColor(s1);
	    else if (s.equals("backColor"))
		barcode.backColor = convertColor(s1);
	    else if (s.equals("rotate"))
		barcode.rotate = (new Integer(s1)).intValue();
	    else if (s.equals("barHeightCM"))
		barcode.barHeightCM = (new Double(s1)).doubleValue();
	    else if (s.equals("x"))
		barcode.X = (new Double(s1)).doubleValue();
	    else if (s.equals("n"))
		barcode.N = (new Double(s1)).doubleValue();
	    else if (s.equals("leftMarginCM"))
		barcode.leftMarginCM = (new Double(s1)).doubleValue();
	    else if (s.equals("topMarginCM"))
		barcode.topMarginCM = (new Double(s1)).doubleValue();
	    else if (s.equals("checkCharacter"))
		barcode.checkCharacter = s1.equalsIgnoreCase("y");
	    else if (s.equals("checkCharacterInText"))
		barcode.checkCharacterInText = s1.equalsIgnoreCase("y");
	    else if (s.equals("Code128Set"))
		barcode.Code128Set = s1.charAt(0);
	    else if (s.equals("UPCESytem"))
		barcode.UPCESytem = s1.charAt(0);
	    else if (s.equals("barType"))
		if (s1.equalsIgnoreCase("CODE39"))
		    barcode.barType = 0;
		else if (s1.equalsIgnoreCase("CODE39EXT"))
		    barcode.barType = 1;
		else if (s1.equalsIgnoreCase("INTERLEAVED25"))
		    barcode.barType = 2;
		else if (s1.equalsIgnoreCase("CODE11"))
		    barcode.barType = 3;
		else if (s1.equalsIgnoreCase("CODABAR"))
		    barcode.barType = 4;
		else if (s1.equalsIgnoreCase("MSI"))
		    barcode.barType = 5;
		else if (s1.equalsIgnoreCase("UPCA"))
		    barcode.barType = 6;
		else if (s1.equalsIgnoreCase("IND25"))
		    barcode.barType = 7;
		else if (s1.equalsIgnoreCase("MAT25"))
		    barcode.barType = 8;
		else if (s1.equalsIgnoreCase("CODE93"))
		    barcode.barType = 9;
		else if (s1.equalsIgnoreCase("EAN13"))
		    barcode.barType = 10;
		else if (s1.equalsIgnoreCase("EAN8"))
		    barcode.barType = 11;
		else if (s1.equalsIgnoreCase("UPCE"))
		    barcode.barType = 12;
		else if (s1.equalsIgnoreCase("CODE128"))
		    barcode.barType = 13;
		else if (s1.equalsIgnoreCase("CODE93EXT"))
		    barcode.barType = 14;
		else if (s1.equalsIgnoreCase("POSTNET"))
		    barcode.barType = 15;
		else if (s1.equalsIgnoreCase("PLANET"))
		    barcode.barType = 16;
		else if (s1.equalsIgnoreCase("UCC128"))
		    barcode.barType = 17;
    }

    private static Font convertFont(String s)
    {
	StringTokenizer stringtokenizer = new StringTokenizer(s, "|");
	String s1 = stringtokenizer.nextToken();
	String s2 = stringtokenizer.nextToken();
	String s3 = stringtokenizer.nextToken();
	byte byte0 = -1;
	if (s2.trim().toUpperCase().equals("PLAIN"))
	    byte0 = 0;
	else if (s2.trim().toUpperCase().equals("BOLD"))
	    byte0 = 1;
	else if (s2.trim().toUpperCase().equals("ITALIC"))
	    byte0 = 2;
	return new Font(s1, byte0, (new Integer(s3)).intValue());
    }

    private static Color convertColor(String s)
    {
	Color color = null;
	if (s.trim().toUpperCase().equals("RED"))
	    color = Color.red;
	else if (s.trim().toUpperCase().equals("BLACK"))
	    color = Color.black;
	else if (s.trim().toUpperCase().equals("BLUE"))
	    color = Color.blue;
	else if (s.trim().toUpperCase().equals("CYAN"))
	    color = Color.cyan;
	else if (s.trim().toUpperCase().equals("DARKGRAY"))
	    color = Color.darkGray;
	else if (s.trim().toUpperCase().equals("GRAY"))
	    color = Color.gray;
	else if (s.trim().toUpperCase().equals("GREEN"))
	    color = Color.green;
	else if (s.trim().toUpperCase().equals("LIGHTGRAY"))
	    color = Color.lightGray;
	else if (s.trim().toUpperCase().equals("MAGENTA"))
	    color = Color.magenta;
	else if (s.trim().toUpperCase().equals("ORANGE"))
	    color = Color.orange;
	else if (s.trim().toUpperCase().equals("PINK"))
	    color = Color.pink;
	else if (s.trim().toUpperCase().equals("WHITE"))
	    color = Color.white;
	else if (s.trim().toUpperCase().equals("YELLOW"))
	    color = Color.yellow;
	return color;
    }
}
