package org.ofbiz.product.store;

import java.sql.Timestamp;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilDateTime;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericValue;

public class StoreEvents {

	private static final String module = StoreEvents.class.getName();

	public static String saveEnterpriseQual(HttpServletRequest request, HttpServletResponse response) {
		Delegator delegator = (Delegator) request.getAttribute("delegator");
		String partyId = request.getParameter("partyId");
		String imagePath = request.getParameter("imagePath");
		String fromDateStr = request.getParameter("fromDate");
		String partyQualTypeId = request.getParameter("partyQualTypeId");
		String title = request.getParameter("title");
		String qualificationDesc = request.getParameter("qualificationDesc");
		try {
			if (partyId == null || partyQualTypeId == null || partyId.equals("") || partyQualTypeId.equals("")) {
				throw new RuntimeException("请刷新页面重试！");
			}
			Timestamp fromDate = null;
			if (fromDateStr != null && !fromDateStr.equals("")) {
				fromDate = UtilDateTime.stringToTimeStamp(fromDateStr, "yyyy-MM-dd HH:mm:ss", TimeZone.getDefault(), Locale.getDefault());
			} else {
				fromDate = UtilDateTime.nowTimestamp();
			}
			GenericValue gv = delegator.findOne("EnterpriseQual", false, UtilMisc.toMap("partyId", partyId, "partyQualTypeId", partyQualTypeId, "fromDate", fromDate));
			if (gv != null) {
				gv.set("imagePath", imagePath);
				gv.set("title", title);
				gv.set("qualificationDesc", qualificationDesc);
				gv.store();
			} else {
				gv = delegator.makeValue("EnterpriseQual", UtilMisc.toMap("partyId", partyId, "partyQualTypeId", partyQualTypeId, "fromDate", fromDate));
				gv.set("imagePath", imagePath);
				gv.set("title", title);
				gv.set("qualificationDesc", qualificationDesc);
				gv.set("verifStatusId", "IM_PENDING");// IM_APPEAL:申诉中;IM_APPROVED:已审核;IM_PENDING:待审核;IM_REJECTED:已拒绝;
				gv.create();
			}
		} catch (Exception e) {
			request.setAttribute("info", e.getMessage());
			Debug.logError(e, module);
		}
		return "success";
	}
}
