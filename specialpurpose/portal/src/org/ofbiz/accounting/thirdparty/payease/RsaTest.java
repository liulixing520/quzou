package org.ofbiz.accounting.thirdparty.payease;

import com.capinfo.crypt.*;

public class RsaTest 
{
  public RsaTest(){
  }

  public static void main(String[] args){

    //首信公钥文件
    String publicKey = "d:/Public1024.key";
    //签名信息
    String SignString = "3e5671bc4f91c3d055b18c1e5e22dd9db157380c7ee8facf0b1117082fbf398d7113c2df7e3219fc28dd88dd26cb096cabe607f3e397dfc2dcdb3349351a5f025ea0761da6e39e2d2fd311294a6076e777fe2ab8911f22113c435b89d63ae4f2aff2f333f7ebd40cc89601d58fb37b16596b5c94eb8b64cd52e12b9679248e6a";
    //原信息
    String strSource = "abcde12345";
    

		try{
      //公钥验证
      RSA_MD5 rsaMD5 = new RSA_MD5();
			int k = rsaMD5.PublicVerifyMD5(publicKey,SignString,strSource);
      if(k==0)
        System.out.println("验证成功.");
      else
        System.out.println("验证失败.");
		}catch(Exception e){
      System.out.println("验证异常.\n"+e);
		}
  }
}