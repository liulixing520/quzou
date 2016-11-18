package org.ofbiz.thirdparty.zjpay.util.domain;

public class PaymentNotification {

    private String txNo;
    
    private String txTime;
    
    private String txCode;
    
    private String institutionID;
    
    private String paymentNo;
    
    private long amount;
    
    private int status;
    
    private String bankNotificationTime;
    
    private int noticeType;

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }

    public String getBankNotificationTime() {
        return bankNotificationTime;
    }

    public void setBankNotificationTime(String bankNotificationTime) {
        this.bankNotificationTime = bankNotificationTime;
    }

    public String getInstitutionID() {
        return institutionID;
    }

    public void setInstitutionID(String institutionID) {
        this.institutionID = institutionID;
    }

    public int getNoticeType() {
        return noticeType;
    }

    public void setNoticeType(int noticeType) {
        this.noticeType = noticeType;
    }

    public String getPaymentNo() {
        return paymentNo;
    }

    public void setPaymentNo(String paymentNo) {
        this.paymentNo = paymentNo;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getTxCode() {
        return txCode;
    }

    public void setTxCode(String txCode) {
        this.txCode = txCode;
    }

    public String getTxNo() {
        return txNo;
    }

    public void setTxNo(String txNo) {
        this.txNo = txNo;
    }

    public String getTxTime() {
        return txTime;
    }

    public void setTxTime(String txTime) {
        this.txTime = txTime;
    }
    
}
