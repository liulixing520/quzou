/*
 * 按照传入的资源目的和主键值得到访问资源的URL并进行跳转
 * */

import javax.servlet.http.HttpServletResponse
import org.extErp.sysCommon.document.DocumentUtils


module = 'getDocUrlByPurpose'

sysDocPurposeId = parameters.sysDocPurposeId
relatedIdValue = parameters.relatedIdValue
url = DocumentUtils.getDocUrlByPurpose(request, sysDocPurposeId, relatedIdValue)

((HttpServletResponse)response).sendRedirect(url)

