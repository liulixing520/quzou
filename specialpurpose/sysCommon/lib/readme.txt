一.jacob说明
1.只能在window下使用.
2.导入jacob.jar到build path里面,这样就可以直接使用jacob的功能了.
3.例子
	
	
	
	打印例子
	ComThread.InitSTA();
	ActiveXComponent word = new ActiveXComponent("Word.Application");
	Dispatch doc = null;
	try
	{
		// 不打开文档
		Dispatch.put(word, "Visible", new Variant(true)); // 相当于wordObject.Visible = true
		Dispatch docs = word.getProperty("Documents").toDispatch();
		// 打开文档
		doc = Dispatch.call(docs, "Open", "e://wsz/1.docx").toDispatch();
		// 开始打印
		Dispatch.call(doc, "PrintOut"); // 打印
	} catch (Exception e)
	{
		e.printStackTrace();
		System.out.println("打印错误");
	} finally
	{
		try
		{
		    if (doc != null)
			Dispatch.call(doc, "Close", new Variant(0));
		    // word.invoke("Quit", new Variant[0]);
		} catch (Exception e)
		{
		    e.printStackTrace();
		}
		// 始终释放资源
		ComThread.Release();
	}
	
	
	
	
	发传真例子
	import com.jacob.activeX.ActiveXComponent;
	import com.jacob.com.ComThread;
	import com.jacob.com.Dispatch;
	import com.jacob.com.DispatchEvents;
	import com.jacob.com.Variant;
	
	public class faxtest {
	
	 public void sendFax(String filename，Sring faxnumber) {
	  ActiveXComponent objFax = new ActiveXComponent("FaxServer.FaxServer.1");//这个名字一般要与注册表里fax服务名匹配对了
	
	
	  Dispatch faxObject = objFax.getObject();
	
	  Dispatch.call(faxObject, "Connect", "");
	  Dispatch doc = Dispatch.call(faxObject, "CreateDocument", filename)
	    .toDispatch();
	  Dispatch.put(doc, "RecipientName", "someone");
	  Dispatch.put(doc, "FaxNumber", faxnumber); //注意电话号码的格式
	  Dispatch.put(doc, "DisplayName", "zhupan");
	  Dispatch.call(doc, "Send");
	  Dispatch.call(faxObject, "DisConnect");
	 }
	
	 public static void main(String[] args) {
	
	  try {
	   faxtest faxDocumentProperties = new faxtest();
	   faxDocumentProperties.sendFax(" http://www.bt285.cn /WW.doc","028886666");
	   System.out.print("ok fax transfer successfully  !");
	  } catch (Exception e) {
	   System.out.println(e);
	  }
	 }
	
	}
	
1.把jacob.dll文件，复制到 windows\system32 目录下。（注：我用的时候这个方法不能运行）

2. 把jacob.dll放入 Java\jdk1.5.0_06\jre\bin目录下.把jacob.jar放入 Java\jdk1.5.0_0\jre\lib\ext  

    目录下.可以正常运行。

3.把jacob.dll放入 \glc\src目录下.把jacob.jar放入WEB-INF\lib目录下，也是可以正常运行。	
4.传真的格式：010-88598988 正确：	0188598988  (01088598988格式调试未通过)；需要传真modem联合起来使用

二fast-el说明
fel.jar例子
普通计算
FelContext ctx = fel.getContext();
ctx.set("V", 5.11);
ctx.set("V空", 10);
ctx.set("运费", 7);
String v = "V*V空*运费";
Object result1 = fel.eval(v);
System.out.println(result1);
大数值计算
FelEngine fel = FelBuilder.bigNumberEngine();
String input = "111111111111111111111111111111+22222222222222222222222222222222";
Object value = fel.eval(input);
Object compileValue = fel.compile(input, fel.getContext()).eval(fel.getContext());
System.out.println("大数值计算（解释执行）:" + value);
System.out.println("大数值计算（编译执行）:" + compileValue);
	