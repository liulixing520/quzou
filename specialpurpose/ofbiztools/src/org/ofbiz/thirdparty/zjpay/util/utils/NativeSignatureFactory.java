package org.ofbiz.thirdparty.zjpay.util.utils;

import java.util.HashMap;

import payment.tools.security.Signer;
import payment.tools.security.Verifier;

/**
 * 
 * <pre>
 * Modify Information:
 * Author       Date        Description
 * ============ =========== ============================
 * dqhe         2014-04-04  Create this file
 * 
 * </pre>
 * 
 * 签名服务
 * 
 */

public class NativeSignatureFactory {

    private static HashMap<String, Signer> signerMap = new HashMap<String, Signer>();
    private static HashMap<String, Verifier> verifierMap = new HashMap<String, Verifier>();

    private NativeSignatureFactory() {
    }

    public static void addSigner(String signerID, Signer signer) {
        signerMap.put(signerID, signer);
    }

    public static void addVerifier(String verifierID, Verifier verifier) {
        verifierMap.put(verifierID, verifier);
    }

    public static Signer getSigner(String signerID) {
        return signerMap.get(signerID);
    }

    public static Verifier getVerifier(String verifierID) {
        return verifierMap.get(verifierID);
    }

    public static void clearVerifier() {
        verifierMap.clear();
    }
}
