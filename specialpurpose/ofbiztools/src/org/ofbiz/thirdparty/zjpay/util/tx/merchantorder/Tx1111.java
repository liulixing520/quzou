/**
 * <pre>
 * Copyright Notice:
 *    Copyright (c) 2005-2009 China Financial Certification Authority(CFCA)
 *    A-1 You An Men Nei Xin An Nan Li, Xuanwu District, Beijing ,100054, China
 *    All rights reserved.
 * 
 *    This software is the confidential and proprietary information of
 *    China Financial Certification Authority (&quot;Confidential Information&quot;).
 *    You shall not disclose such Confidential Information and shall use 
 *    it only in accordance with the terms of the license agreement you 
 *    entered into with CFCA.
 * </pre>
 */

package org.ofbiz.thirdparty.zjpay.util.tx.merchantorder;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import payment.api.system.PaymentEnvironment;
import payment.api.tx.merchantorder.Tx1111Request;


public class Tx1111 extends HttpServlet {

    private static final long serialVersionUID = 6697471785410663172L;

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1.取得参数
            String institutionID = request.getParameter("InstitutionID");
            String paymentNo = request.getParameter("PaymentNo");
            long amount = Long.parseLong(request.getParameter("Amount"));
            long fee = Long.parseLong(request.getParameter("Fee"));
            String payerID = !request.getParameter("PayerID").equals("")?request.getParameter("PayerID").trim():null;
            String payerName = !request.getParameter("PayerName").equals("")?request.getParameter("PayerName").trim():null;
            String settlementFlag = !request.getParameter("SettlementFlag").equals("")?request.getParameter("SettlementFlag").trim():null;
            String usage = !request.getParameter("Usage").equals("")?request.getParameter("Usage").trim():null;
            String remark = !request.getParameter("Remark").equals("")?request.getParameter("Remark").trim():null;
            String notificationURL = !request.getParameter("NotificationURL").equals("")?request.getParameter("NotificationURL").trim():null;
            String bankID = request.getParameter("BankID");
            int accountType = Integer.parseInt(request.getParameter("AccountType"));

            // 2.创建交易请求对象
            Tx1111Request tx1111Request = new Tx1111Request();
            tx1111Request.setInstitutionID(institutionID);
            tx1111Request.setPaymentNo(paymentNo);
            tx1111Request.setAmount(amount);
            tx1111Request.setFee(fee);
            tx1111Request.setPayerID(payerID);
            tx1111Request.setPayerName(payerName);
            tx1111Request.setSettlementFlag(settlementFlag);
            tx1111Request.setUsage(usage);
            tx1111Request.setRemark(remark);
            tx1111Request.setNotificationURL(notificationURL);
            tx1111Request.setBankID(bankID);
            tx1111Request.setAccountType(accountType);

            // 3.执行报文处理
            tx1111Request.process();

            // 4.将参数放置到request对象
            request.setAttribute("plainText", tx1111Request.getRequestPlainText());
            request.setAttribute("message", tx1111Request.getRequestMessage());
            request.setAttribute("signature", tx1111Request.getRequestSignature());
            request.setAttribute("txCode", "1111");
            request.setAttribute("txName", "商户订单支付（直通车）");
            request.setAttribute("action", PaymentEnvironment.paymentURL);

            // 5.转向Request.jsp页面
            request.getRequestDispatcher("/Request.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            processException(request, response, e.getMessage());
        }
    }

    private void processException(HttpServletRequest request, HttpServletResponse response, String errorMessage) {
        try {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("/ErrorPage.jsp").forward(request, response);
        } catch (Exception e) {
        }
    }

}
