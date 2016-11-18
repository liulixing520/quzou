package org.ofbiz.ofc.tools;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.ofbiz.base.util.*;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.ServiceUtil;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.math.BigDecimal;
import java.nio.ByteBuffer;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * @author apple/mf1389004071 <br/>
 * 2014年11月17日 -|- 下午1:47:43
 */
public class CommonUtils {
    public static String module = CommonUtils.class.getName();
    public static final String resource = "YtCmUiLabels";

    private static final String OFBIZ_HOME = System.getProperty("ofbiz.home");

    /**
     * 返回 随机码, 6位
     * @return
     */
    public static String getRandomCode(){
        return getRandomCode(null, null);
    }

    /**
     * 返回 随机码
     * @param length
     * @param chars
     * @return
     */
    public static String getRandomCode(Integer length, String chars){
        if(UtilValidate.isEmpty(length)){
            length = UtilProperties.getPropertyAsInteger("captcha.properties", "captcha.code_length", 6);
        }
        if(UtilValidate.isEmpty(chars)){
            chars = UtilProperties.getPropertyValue("captcha.properties", "captcha.characters");
        }
        return RandomStringUtils.random(length, chars);
    }

    /**
     * 返回 关联的或下级列表
     * @param dctx
     * @param context
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public static Map<String, Object> findAssocOrNextList(DispatchContext dctx,
                                                          Map<String, ? extends Object> context){
        Locale locale = (Locale) context.get("locale");
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Delegator delegator = dctx.getDelegator();

        String entityName = (String) context.get("entityName");
        String findKey = (String) context.get("findKey");
        String findValue = (String) context.get("findValue");

        //useCache
        //orderBy

        boolean useCache = false;
        if(UtilValidate.isNotEmpty(context.get("useCache"))){
            String cached = ((String) context.get("useCache")).toLowerCase();
            if("y".equals(cached) || "yes".equals(cached) || "true".equals(cached))
                useCache = true;
        }
        List orderBy = null;
        if(UtilValidate.isNotEmpty(context.get("orderBy"))){
            orderBy = UtilMisc.toList((String)context.get("orderBy"));
        }

        List<GenericValue> list = FastList.newInstance();
        try {
            list = delegator.findByAnd(entityName, UtilMisc.toMap(findKey, findValue), orderBy, useCache);
        } catch (GenericEntityException e) {
            Debug.logError(e, e.getMessage(), module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                    "findItemListFromParentId.error", new Object[] { e.getMessage() }, locale));
        }
        result.put("list", list);
        return result;
    }

    /**
     * 检查 关键字在指定表是否存在
     * @param dctx
     * @param context
     * @return
     */
    public static Map<String, Object> checkKeywordExisted(DispatchContext dctx,
                                                          Map<String, ? extends Object> context){
        Locale locale = (Locale) context.get("locale");
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Delegator delegator = dctx.getDelegator();

        String entityName = (String) context.get("entityName");
        String findKey = (String) context.get("findKey");
        String findValue = (String) context.get("findValue");

        String existed = "N";
        try {
            List<GenericValue> list = delegator.findByAnd(entityName, UtilMisc.toMap(findKey, findValue), null, false);
            if(UtilValidate.isNotEmpty(list)){
                existed = "Y";
            }
        } catch (GenericEntityException e) {
            Debug.logError(e, e.getMessage(), module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                    "checkKeywordExisted.error", new Object[] { e.getMessage() }, locale));
        }
        result.put("existed", existed);
        return result;
    }

    /**
     * 检查 关键字在指定表是否存在
     * @param dctx
     * @param context
     * @return
     */
    public static Map<String, Object> getNextAssocGeoList(DispatchContext dctx,
                                                          Map<String, ? extends Object> context){
        Locale locale = (Locale) context.get("locale");
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Delegator delegator = dctx.getDelegator();

        String geoIdFrom = (String) context.get("geoIdFrom");
        String geoAssocTypeId = (String) context.get("geoAssocTypeId");

        List<GenericValue> list = FastList.newInstance();
        try {
            list = delegator.findByAnd("GeoAssocAndGeoTo",
                    UtilMisc.toMap("geoIdFrom",geoIdFrom, "geoAssocTypeId",geoAssocTypeId), UtilMisc.toList("geoId"), false);
        } catch (GenericEntityException e) {
            Debug.logError(e, e.getMessage(), module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resource,
                    "getNextAssocGeoList.error", new Object[] { e.getMessage() }, locale));
        }
        result.put("list", list);
        return result;
    }
    
    /**
     * 返回 文件显示路径
     * @param imagePath
     * @return
     */
    public static String getFileShowPath(String imagePath){
    	return getFileShowPath(imagePath, "");
    }

    /**
     * 返回 文件显示路径
     * @param imagePath
     * @param prefixPath
     * @return
     */
    public static String getFileShowPath(String imagePath, String prefixPath){
        if(UtilValidate.isEmpty(prefixPath)) prefixPath = "/ofcupload/images/upload/";
        if(UtilValidate.isEmpty(imagePath)) return "/ofcupload/images/static/images/no_pic.jpg";
        return prefixPath + imagePath;
    }

    /**
     * 创建文件
     * @param prefixPath
     * @param filePath
     * @param imageDataBytes
     * @param newImageFolder
     * @throws IOException
     */
    public static void createFile(String prefixPath, String filePath, ByteBuffer imageDataBytes,String newImageFolder) throws IOException {
        byte[] imageBytes = imageDataBytes.array();
        String imageFolder="";
        if(UtilValidate.isNotEmpty(newImageFolder)){
            imageFolder=newImageFolder;
        }else{
            imageFolder="/hot-deploy/ofcupload/webapp/ofcupload/images/upload/";
        }
        String fullFilePath = OFBIZ_HOME+imageFolder+prefixPath;
        File saveFilePath = new File(fullFilePath);
        if (!saveFilePath.exists()) {
            boolean m =saveFilePath.mkdirs();
        }
        String path = fullFilePath+"/"+filePath;
        FileOutputStream fos = new FileOutputStream(path);
        fos.write(imageBytes);
        fos.close();
    }

    /**
     * 上传
     * @param dctx
     * @param context
     * @return
     */
    public static Map<String, Object> uploadedFile(DispatchContext dctx, Map<String, ? extends Object> context) {
        Map<String, Object> result = ServiceUtil.returnSuccess();
        Locale locale = (Locale) context.get("locale");

        String dependId = (String) context.get("dependId");
        String imageFolder = (String) context.get("imageFolder");
        try {
            ByteBuffer imageDataBytes = (ByteBuffer) context.get("uploadedFile");
            String _uploadedFile_fileName = (String) context.get("_uploadedFile_fileName");
            if(UtilValidate.isNotEmpty(imageDataBytes)&&UtilValidate.isNotEmpty(_uploadedFile_fileName)){

                String extendName = _uploadedFile_fileName.substring(_uploadedFile_fileName.lastIndexOf("."));
                String uuid =UtilUUID.uuidTomini();
                String imagePath = uuid + extendName.toLowerCase();
                String prefixPath = dependId.substring(0, dependId.length()-3);

                createFile(prefixPath,imagePath,imageDataBytes,imageFolder);
                result.put("imagePath",prefixPath+"/"+imagePath);
                result.put("imageName",imagePath);
            }
        }catch (IOException e) {
            Debug.logError(e, e.getMessage(), module);
            return ServiceUtil.returnError(UtilProperties.getMessage(resource,"upload.image.error", new Object[] { e.getMessage() }, locale));
        }
        return result;
    }
    
    
    public static String getOneYearsLaterTime () {
   	 String oneYearsAgoTime = "";
        Calendar cal = Calendar.getInstance();         
        cal.set(Calendar.YEAR, cal.get(Calendar.YEAR)+1);
        oneYearsAgoTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                .format(cal.getTime());
        return oneYearsAgoTime;
   }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public static List splitStringToList(String inputString) {
		List result = FastList.newInstance();
		if(UtilValidate.isEmpty(inputString)){
			return result;
		}
		String[] array =inputString.split(";");
		for(int i=0;i<array.length;i++){
			if(UtilValidate.isNotEmpty(array[i])){
				result.add(array[i]);
			}
		}
        return result;
    }
	
	/**
	 * 分割字符串 自定义的分隔符
	 * @param inputString
	 * @param splitChar
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List splitStringToList(String inputString,String splitChar) {
		List result = FastList.newInstance();
		if(UtilValidate.isEmpty(inputString)){
			return result;
		}
		String[] array =inputString.split(splitChar);
		for(int i=0;i<array.length;i++){
			if(UtilValidate.isNotEmpty(array[i])){
				result.add(array[i]);
			}
		}
        return result;
    }
	
	
	 public static Object wrapString(Object theString) {
		 
        return private_wrapString(theString);
    } 
	 private static Object private_wrapString(Object theString) {
		 if (theString instanceof String) {
			    String s = (String) theString;
			    return StringUtil.wrapString(s);
			}
        return theString;
    }


    /**
     * 将数字转换为中文金额描述[最大到千亿,两位小数]
     * @param db double类数字
     * @return
     */
    public static String changeToBig(double db) {
        if(db==0){
            return "";
        }
        char[] hunit = { '拾', '佰', '仟' }; // 段内位置表示
        char[] vunit = { '万', '亿' }; // 段名表示
        char[] digit = { '零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖' }; // 数字表示
        BigDecimal midVal = new BigDecimal(Math.round(db * 100)); // 转化成整形,替换上句
        String valStr = String.valueOf(midVal); // 转化成字符串
        if(valStr.length()==1){
        	valStr = "0"+valStr;
        }
        String head = valStr.substring(0, valStr.length() - 2); // 取整数部分
        String rail = valStr.substring(valStr.length() - 2); // 取小数部分

        String prefix = ""; // 整数部分转化的结果
        String suffix = ""; // 小数部分转化的结果
        // 处理小数点后面的数
        if (rail.equals("00")) { // 如果小数部分为0
            suffix = "整";
        } else {
            suffix = digit[rail.charAt(0) - '0'] + "角"
                    + digit[rail.charAt(1) - '0'] + "分"; // 否则把角分转化出来
        }
        // 处理小数点前面的数
        char[] chDig = head.toCharArray(); // 把整数部分转化成字符数组
        boolean preZero = false; // 标志当前位的上一位是否为有效0位（如万位的0对千位无效）
        byte zeroSerNum = 0; // 连续出现0的次数
        for (int i = 0; i < chDig.length; i++) { // 循环处理每个数字
            int idx = (chDig.length - i - 1) % 4; // 取段内位置
            int vidx = (chDig.length - i - 1) / 4; // 取段位置
            if (chDig[i] == '0') { // 如果当前字符是0
                preZero = true;
                zeroSerNum++; // 连续0次数递增
                if (idx == 0 && vidx > 0 && zeroSerNum < 4) {
                    prefix += vunit[vidx - 1];
                    preZero = false; // 不管上一位是否为0，置为无效0位
                }
            } else {
                zeroSerNum = 0; // 连续0次数清零
                if (preZero) { // 上一位为有效0位
                    prefix += digit[0]; // 只有在这地方用到'零'
                    preZero = false;
                }
                prefix += digit[chDig[i] - '0']; // 转化该数字表示
                if (idx > 0)
                    prefix += hunit[idx - 1];
                if (idx == 0 && vidx > 0) {
                    prefix += vunit[vidx - 1]; // 段结束位置应该加上段名如万,亿
                }
            }
        }
        if (prefix.length() > 0)
            prefix += '圆'; // 如果整数部分存在,则有圆的字样
        return prefix + suffix; // 返回正确表示
    }

    /**
     * 返回 指定数据的值
     * @param delegator
     * @param entityName
     * @param pkKey
     * @param pkValue
     * @param descKey
     * @param locale
     * @return
     */
    public static String getDescription(Delegator delegator,
                String entityName, String pkKey, String pkValue, String descKey, Locale locale){
        String result = "";
        if(UtilValidate.isEmpty(entityName) || UtilValidate.isEmpty(pkKey) || UtilValidate.isEmpty(pkValue) || UtilValidate.isEmpty(descKey)) return result;
        try {
            GenericValue ent = delegator.findOne(entityName, UtilMisc.toMap(pkKey, pkValue),true);
            if(UtilValidate.isNotEmpty(ent) && UtilValidate.isNotEmpty(ent.get(descKey))){
                if(UtilValidate.isNotEmpty(locale)){
                    ent.get(descKey,locale);
                }else{
                    result = String.valueOf(ent.get(descKey));
                }
            }
        } catch (GenericEntityException e) {
            Debug.logError(e, e.getMessage(), module);
        }
        return result;
    }

    /**
     * 收货地址 串
     * @param delegator
     * @param contactMechId
     * @param locale
     * @param hasPhone
     * @return
     */
    public static Map<String, Object> getPostalAddressString(Delegator delegator, String contactMechId, Locale locale, boolean hasPhone){
    	if(UtilValidate.isEmpty(contactMechId)) return null;
    	GenericValue addr = null;
    	try {
			addr = delegator.findOne("PostalAddress",UtilMisc.toMap("contactMechId",contactMechId), false);
		} catch (GenericEntityException e) {
			Debug.logError(e, e.getMessage(), module);
		}
    	return getPostalAddressString(delegator,addr,locale,hasPhone);
    }

    /**
     * 收货地址 串
     * @param delegator
     * @param addr
     * @param locale
     * @param hasPhone
     * @return
     */
    public static Map<String, Object> getPostalAddressString(Delegator delegator, GenericValue addr, Locale locale, boolean hasPhone){
    	Map<String, Object> result = FastMap.newInstance();
    	if(UtilValidate.isEmpty(addr))return result;
    	result = addr.getAllFields();
    	
    	String country = getDescription(delegator,"Geo","geoId",addr.getString("countryGeoId"),"geoName",locale);
        result.put("country", country);
        
        String province = getDescription(delegator,"Geo","geoId",addr.getString("stateProvinceGeoId"),"geoName",null);
        result.put("province", province);
        
        String city = getDescription(delegator,"Geo","geoId",addr.getString("cityGeoId"),"geoName",null);
        result.put("city", city);
        
        String county = getDescription(delegator, "Geo", "geoId", addr.getString("countyGeoId"), "geoName", null);
        result.put("county", county);
        
        String address1 = UtilValidate.isNotEmpty(addr.get("address1"))?addr.getString("address1"):"";
        result.put("address1", address1);

        String address = province +" "+ city  +" "+ county +" "+ address1;
        if(UtilValidate.isNotEmpty(country)) address = country +" "+ address;
        if(UtilValidate.isNotEmpty(addr.get("address2"))) address += " "+ addr.getString("address2");
        if(UtilValidate.isNotEmpty(addr.get("postalCode"))) address += " ["+ addr.getString("postalCode") +"]";
        
        if(hasPhone){
            String phoneNumber = UtilValidate.isNotEmpty(addr.get("phoneNumber"))?addr.getString("phoneNumber"):"";
            String mobilePhone = UtilValidate.isNotEmpty(addr.get("mobilePhone"))?addr.getString("mobilePhone"):"";

            if(UtilValidate.isNotEmpty(addr.get("phoneNumber")) && UtilValidate.isNotEmpty(addr.get("mobilePhone"))){
                address += " ["+ phoneNumber +"/"+ mobilePhone +"]";
            }
            else if (UtilValidate.isNotEmpty(addr.get("phoneNumber"))){
                address += " ["+ phoneNumber +"]";
            }
            else if (UtilValidate.isNotEmpty(addr.get("mobilePhone"))){
                address += " ["+ mobilePhone +"]";
            }
        }
        result.put("fullAddress", address);
        return result;
    }

    /**
     * 两个数 商 的百分比
     * @param dividend
     * @param divider
     * @return
     */
    public static String getPercent(double dividend, double divider){
        double quotient = dividend / divider;
        NUMBER_FORMAT.setMinimumFractionDigits( 2 );
        return  NUMBER_FORMAT.format(quotient);
    }

    public static NumberFormat NUMBER_FORMAT = NumberFormat.getPercentInstance();
    public static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static DecimalFormat AMOUNT_FORMAT = new DecimalFormat("0.00");


    public static StringBuffer docHtmlBegin = new StringBuffer();
    public static StringBuffer docHtmlEnd = new StringBuffer();
    static {
        docHtmlBegin.append("<html xmlns:v=\"urn:schemas-microsoft-com:vml\"");
            docHtmlBegin.append(" xmlns:o=\"urn:schemas-microsoft-com:office:office\"");
            docHtmlBegin.append(" xmlns:w=\"urn:schemas-microsoft-com:office:word\"");
            docHtmlBegin.append(" xmlns:m=\"http://schemas.microsoft.com/office/2004/12/omml\"");
            docHtmlBegin.append(" xmlns=\"http://www.w3.org/TR/REC-html40\"");
            docHtmlBegin.append(">");
            docHtmlBegin.append("<head>");
                docHtmlBegin.append("<meta http-equiv=Content-Type content=\"text/html; charset=gb2312\">");
                docHtmlBegin.append("<meta name=ProgId content=Word.Document><meta name=Generator content=\"Microsoft Word 11\">");
                docHtmlBegin.append("<meta name=Originator content=\"Microsoft Word 11\">");
            docHtmlBegin.append("</head>");
            docHtmlBegin.append("<body lang=ZH-CN>");

            docHtmlEnd.append("</body>");
        docHtmlEnd.append("</html>");
    }

    /**
     * 数据导出-Doc
     * @param request
     * @param response
     * @param content 数据正文
     * @param fileName 导出文件名
     * @return
     */
    @SuppressWarnings("deprecation")
    public static String exportDataToDoc(HttpServletRequest request, HttpServletResponse response,
                                         String content, String fileName) throws IOException {
        if(UtilValidate.isEmpty(content)){
            try {
                response.setContentType("text/html;charset=GBK");
                response.getWriter().print("指定数据导出文件失败, 请稍后重试！");
            } catch (IOException e) {
                Debug.logError(e, e.getMessage(), module);
            }
            return "error";
        }

        String contentData = docHtmlBegin.toString() + content + docHtmlEnd.toString();

        POIFSFileSystem poifs = new POIFSFileSystem();
        DirectoryEntry dirEntry = poifs.getRoot();

        ByteArrayInputStream bais = new ByteArrayInputStream(contentData.getBytes("GBK"));
        dirEntry.createDocument("WordDocument", bais);

        //设置文件输出属性
        setDownloadFileHearder(request,response,fileName);
        //写流文件到客户端
        ServletOutputStream out = response.getOutputStream();
        poifs.writeFilesystem(out);
        out.flush();
        out.close();
        bais.close();

        return "success";
    }

    /**
     * 数据导出-Xls
     * @param request
     * @param response
     * @return
     */
    @SuppressWarnings("deprecation")
    public static String exportOrderListForXls(HttpServletRequest request, HttpServletResponse response) {
        Locale locale = UtilHttp.getLocale(request);
        Delegator delegator = (Delegator) request.getAttribute("delegator");

        String orderIds = request.getParameter("orderIds"); //id1;id2
        if(orderIds.endsWith(";")) orderIds = orderIds.substring(0, orderIds.length()-1);

        try {
            //表格对象
            HSSFWorkbook wb = new HSSFWorkbook();
            HSSFSheet sheet = wb.createSheet();

            //订单头
            HSSFRow header = sheet.createRow(0);
            header.createCell(0).setCellValue("订单标识");
            header.createCell(1).setCellValue("订单名称");
            header.createCell(2).setCellValue("订单总计");
            header.createCell(3).setCellValue("订单状态");
            header.createCell(4).setCellValue("下单日期");
            header.createCell(5).setCellValue("会员标识");

            //订单内容处理
            String[] idArr = orderIds.split(";");
            for (int i = 0; i < idArr.length; i++) {
                String orderId = idArr[i];
                GenericValue order = delegator.findByPrimaryKey("OrderHeader", UtilMisc.toMap("orderId", orderId));

                HSSFRow row = sheet.createRow(i+1);
                row.createCell(0).setCellValue(orderId);
                row.createCell(1).setCellValue(order.getString("orderName"));
                row.createCell(2).setCellValue(order.getString("grandTotal"));

                GenericValue staus = delegator.findByPrimaryKeyCache("StatusItem", UtilMisc.toMap("statusId", order.getString("statusId")));
                row.createCell(3).setCellValue(String.valueOf(staus.get("description", locale)));

                row.createCell(4).setCellValue(order.getString("orderDate"));

                String placingStr = "";
                row.createCell(5).setCellValue(placingStr);
            }

            if(idArr.length<1){
                response.setContentType("text/html;charset=GBK");
                response.getWriter().print("指定订单列表导出文件失败, 请稍后重试！");
                return "error";
            }

            //设置文件输出属性
            String fileName = "订单列表["+UtilDateTime.nowDateString()+"].xls";
            setDownloadFileHearder(request,response,fileName);

            //写流文件到客户端
            ServletOutputStream out = response.getOutputStream();
            wb.write(out);
            out.close();
        } catch (Exception e) {
            Debug.logError(e, e.getMessage(), module);
        }
        return "success";
    }

    //=================================================================================================

    /**
     * 设置下载操作响应头配置
     * <br/><br/>兼容各浏览器的文件下载时中文名称乱码的解决方案
     * @param request
     * @param response
     * @param fileName 文件全名
     */
    public static void setDownloadFileHearder(HttpServletRequest request, HttpServletResponse response, String fileName){
        String userAgent = request.getHeader("User-Agent");
        byte[] bytes = fileName.getBytes(); //默认以 IE 浏览器配置获取文件名称
        if(!userAgent.contains("MSIE")){
            try { //name.getBytes("UTF-8") 处理safari的乱码问题
                bytes = fileName.getBytes("UTF-8");
            } catch (UnsupportedEncodingException e) {
                Debug.logError(e, e.getMessage(), module);
            }
        }
        try { // 各浏览器基本都支持ISO编码
            fileName = new String(bytes, "ISO-8859-1");
        } catch (UnsupportedEncodingException e) {
            Debug.logError(e, e.getMessage(), module);
        }
        response.setContentType("application/OCTET-STREAM;charset=UTF-8");
        // 文件名外的双引号处理firefox的空格截断问题
        response.setHeader("Content-disposition", String.format("attachment; filename=\"%s\"", fileName));
    }
    
    
    //删除产品
    @SuppressWarnings("deprecation")
	public static Map<String, Object> removeAllProduct(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = dctx.getDelegator();
		String productId = (String) context.get("productId");
		
		try {
			delegator.removeByAnd("WorkEffortGoodStandard", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("VendorProduct", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("SupplierProduct", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("Subscription", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ShoppingListItem", UtilMisc.toMap("productId", productId));
			
			//删除库存
			List<GenericValue> itemList = delegator.findByAnd("InventoryItem", UtilMisc.toMap("productId", productId));
			for(GenericValue item : itemList){
				delegator.removeByAnd("AcctgTrans", UtilMisc.toMap("inventoryItemId", item.getString("inventoryItemId")));

				delegator.removeByAnd("InventoryItemDetail", UtilMisc.toMap("inventoryItemId", item.getString("inventoryItemId")));
			}
			delegator.removeByAnd("InventoryItem", UtilMisc.toMap("productId", productId));

			
			delegator.removeByAnd("ShipmentReceipt", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ShipmentPackageContent", UtilMisc.toMap("subProductId", productId));
			delegator.removeByAnd("ShipmentItem", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("SalesForecastDetail", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ReturnItem", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("Requirement", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ReorderGuideline", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("QuoteItem", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductSubscriptionResource", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductStoreSurveyAppl", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductRole", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductReview", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductPromoProduct", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductPrice", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductPaymentMethodType", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductOrderItem", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductMeter", UtilMisc.toMap("productId", productId));
			
			delegator.removeByAnd("ProductManufacturingRule", UtilMisc.toMap("productIdInSubst", productId));
			delegator.removeByAnd("ProductManufacturingRule", UtilMisc.toMap("productIdIn", productId));
			delegator.removeByAnd("ProductManufacturingRule", UtilMisc.toMap("productIdFor", productId));
			delegator.removeByAnd("ProductManufacturingRule", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductMaint", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductKeyword", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductGroupOrder", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductGlAccount", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductGeo", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductFeatureApplAttr", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductFeatureAppl", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductFacilityLocation", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductFacility", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductCostComponentCalc", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductContent", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductConfigStats", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductConfigProduct", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductConfig", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductCategoryMember", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductCalculatedInfo", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductAverageCost", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductAttribute", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("ProductAssoc", UtilMisc.toMap("productIdTo", productId));
			delegator.removeByAnd("ProductAssoc", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("PartyNeed", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("OrderSummaryEntry", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("OrderItem", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("OldProductKeyword", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("MrpEvent", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("InvoiceItem", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("InventoryItemTempRes", UtilMisc.toMap("productId", productId));
			
			
			
			delegator.removeByAnd("GoodIdentification", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("FixedAssetProduct", UtilMisc.toMap("instanceOfProductId", productId));
			delegator.removeByAnd("CustRequestItem", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("CostComponent", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("CommunicationEventProduct", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("CartAbandonedLine", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("AgreementProductAppl", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("Agreement", UtilMisc.toMap("productId", productId));
			delegator.removeByAnd("Product", UtilMisc.toMap("productId", productId));
		} catch (GenericEntityException e) {
			Debug.logError(e, module);
			e.getStackTrace();
		}
		
		return result;
    }
    
    
    //删除客户
    
    //删除订单
    
}

