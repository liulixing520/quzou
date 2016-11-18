package org.ofbiz.accounting.thirdparty.payease;

//调用Md5.java的一个例子
import java.io.*;

class SampleMd5 {
    public static void main (String args[]) 
	throws IOException
    {
	Md5 md5 = new Md5 ( "" ) ;
	md5.hmac_Md5( "testtext" , "testkey" ) ;
	byte b[]= md5.getDigest();
	String digestString = md5.stringify(b) ;
	System.out.println (digestString) ;
    }
}

/*结果为：
3a64addc05447650c168a056ed141cdc
*/
