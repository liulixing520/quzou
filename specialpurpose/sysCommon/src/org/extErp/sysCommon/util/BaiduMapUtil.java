package org.extErp.sysCommon.util;

/**
 * 百度地图帮助类
 */
public class BaiduMapUtil {
	static double DEF_PI = 3.14159265359; // PI
    static double DEF_2PI= 6.28318530712; // 2*PI
    static double DEF_PI180= 0.01745329252; // PI/180.0
    static double DEF_R =6370693.5; // radius of earth
            //适用于近距离
    public static double GetShortDistance(double lon1, double lat1, double lon2, double lat2)
    {
        double ew1, ns1, ew2, ns2;
        double dx, dy, dew;
        double distance;
        // 角度转换为弧度
        ew1 = lon1 * DEF_PI180;
        ns1 = lat1 * DEF_PI180;
        ew2 = lon2 * DEF_PI180;
        ns2 = lat2 * DEF_PI180;
        // 经度差
        dew = ew1 - ew2;
        // 若跨东经和西经180 度，进行调整
        if (dew > DEF_PI)
        dew = DEF_2PI - dew;
        else if (dew < -DEF_PI)
        dew = DEF_2PI + dew;
        dx = DEF_R * Math.cos(ns1) * dew; // 东西方向长度(在纬度圈上的投影长度)
        dy = DEF_R * (ns1 - ns2); // 南北方向长度(在经度圈上的投影长度)
        // 勾股定理求斜边长
        distance = Math.sqrt(dx * dx + dy * dy);
        return distance;
    }
            //适用于远距离
    public static double GetLongDistance(double lon1, double lat1, double lon2, double lat2)
    {
        double ew1, ns1, ew2, ns2;
        double distance;
        // 角度转换为弧度
        ew1 = lon1 * DEF_PI180;
        ns1 = lat1 * DEF_PI180;
        ew2 = lon2 * DEF_PI180;
        ns2 = lat2 * DEF_PI180;
        // 求大圆劣弧与球心所夹的角(弧度)
        distance = Math.sin(ns1) * Math.sin(ns2) + Math.cos(ns1) * Math.cos(ns2) * Math.cos(ew1 - ew2);
        // 调整到[-1..1]范围内，避免溢出
        if (distance > 1.0)
             distance = 1.0;
        else if (distance < -1.0)
              distance = -1.0;
        // 求大圆劣弧长度
        distance = DEF_R * Math.acos(distance);
        return distance;
    }
    
    
    
    /** 
     * 计算两点之间距离 
     * @param start 
     * @param end 
     * @return 米 
    public double getDistance(LatLng start,LatLng end){  
        double lat1 = (Math.PI/180)*start.latitude;  
        double lat2 = (Math.PI/180)*end.latitude;  
          
        double lon1 = (Math.PI/180)*start.longitude;  
        double lon2 = (Math.PI/180)*end.longitude;  
          
//      double Lat1r = (Math.PI/180)*(gp1.getLatitudeE6()/1E6);  
//      double Lat2r = (Math.PI/180)*(gp2.getLatitudeE6()/1E6);  
//      double Lon1r = (Math.PI/180)*(gp1.getLongitudeE6()/1E6);  
//      double Lon2r = (Math.PI/180)*(gp2.getLongitudeE6()/1E6);  
          
        //地球半径  
        double R = 6371;  
          
        //两点间距离 km，如果想要米的话，结果*1000就可以了  
        double d =  Math.acos(Math.sin(lat1)*Math.sin(lat2)+Math.cos(lat1)*Math.cos(lat2)*Math.cos(lon2-lon1))*R;  
          
        return d*1000;  
    }  
     */  
    public final static double EARTH_RADIUS_KM = 6378.137;
    public static double getDistance(double lng1, double lat1, double lng2,
            double lat2) {
	    double radLat1 = Math.toRadians(lat1);
	    double radLat2 = Math.toRadians(lat2);
	    double radLng1 = Math.toRadians(lng1);
	    double radLng2 = Math.toRadians(lng2);
	    double deltaLat = radLat1 - radLat2;
	    double deltaLng = radLng1 - radLng2;
	    double distance = 2 * Math.asin(Math.sqrt(Math.pow(
	                    Math.sin(deltaLat / 2), 2)
	                    + Math.cos(radLat1)
	                    * Math.cos(radLat2)
	                    * Math.pow(Math.sin(deltaLng / 2), 2)));
	    distance = distance * EARTH_RADIUS_KM;
//	    distance = Math.round(distance * 10000) / 10000;
	    distance = Math.round(distance * 1000);
	    return distance;
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		double mLat1 = 39.882807; // point1纬度
        double mLon1 = 116.340523; // point1经度
        double mLat2 = 39.88289;// point2纬度
        double mLon2 = 116.343038;// point2经度
        double distance = BaiduMapUtil.GetShortDistance(mLon1, mLat1, mLon2, mLat2);
        System.out.println(distance);
        
//        System.out.println(getDistance(39.88253, 116.339777, 39.882018, 116.340613));
        System.out.println(getDistance(116.340523, 39.882807, 116.343038, 39.88289));
	}
}
