//added by dongyc 20120829 权限分类
import javolution.util.FastList;
import javolution.util.FastMap;
secGroupMap = FastMap.newInstance();
secGroupList = FastList.newInstance();
secGroupMap.put("SPRPRD", "商品管理");
secGroupMap.put("SPRORD", "订单管理");
secGroupMap.put("SPRMEM", "会员管理");
secGroupMap.put("SPRPMT", "促销管理");
secGroupMap.put("SPRCONTM", "内容管理");
secGroupMap.put("SPRFMENT", "财务管理");
secGroupMap.put("SPRMENT", "统计管理");
secGroupMap.put("SPRMANAGE", "权限管理");
secGroupMap.put("SPRSYSSET", "系统设置");

secGroupList.add("SPRPRD");
secGroupList.add("SPRORD");
secGroupList.add("SPRMEM");
secGroupList.add("SPRPMT");
secGroupList.add("SPRCONTM");
secGroupList.add("SPRFMENT");
secGroupList.add("SPRMENT");
secGroupList.add("SPRMANAGE");
secGroupList.add("SPRSYSSET");
context.secGroupMap = secGroupMap;
context.secGroupList = secGroupList;
