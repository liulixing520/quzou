package org.ofbiz.tools.rest;


	import java.io.IOException;
import java.io.ObjectOutput;
import java.io.ObjectOutputStream;
import java.io.Serializable;   
import java.util.Map;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.cache.JdbmRecordManager;
	  
	import jdbm.RecordManager;   
import jdbm.RecordManagerFactory;   
import jdbm.helper.FastIterator;
import jdbm.htree.HTree;
import jdbm.recman.BaseRecordManager;
	  
	public class Test2 {   
	  
		
		 private static String fileStore = "/Users/user/workspace/ytb2b/"+"runtime/data/utilcache";
		 
		 private static final ConcurrentMap<String, BaseRecordManager> fileManagers = new ConcurrentHashMap<String, BaseRecordManager>();

		   
	    public static void main(String[] args){   
	        try{   
	        //	ss();
	        	ss2();
	        	
	        	
	        	
	        }catch(Exception e){   
	            e.printStackTrace();   
	        }   
	    }   
	 
	    public static String getPropertyParam(String[] propNames, String parameter) {
	    	System.out.println(propNames.length);
	            for (String propName: propNames) {
	            	System.out.println(propName);
//	            if(res.containsKey(propName+ '.' + parameter)) {
//	                try {
//	                return res.getString(propName + '.' + parameter);
//	                } catch (MissingResourceException e) {}
//	            }
	            }
	            // don't need this, just return null
	            //if (value == null) {
	            //    throw new MissingResourceException("Can't find resource for bundle", res.getClass().getName(), Arrays.asList(propNames) + "." + parameter);
	            //}
	        
	        return null;
	    }
	
	public static void ss() throws IOException{
		//创建RecordManager实例对象   
		BaseRecordManager recman = fileManagers.get(fileStore);
        if (recman == null) {
          // recman = RecordManagerFactory.createRecordManager(fileStore);
           recman =  new BaseRecordManager(fileStore);
           fileManagers.put(fileStore, recman);
        }
        //插入   
        Person person1 = new Person();   
        person1.setAge(24);   
        person1.setName("ttitfly");   
        long recid = recman.insert(person1);   
        recman.commit();   
        System.out.println(recid);   
           
        //也可以为插入的记录设置一个别名，方便通过这个别名来取这条数据。   
        recman.setNamedObject("othername",recid);    
        //查询   
        Person person2 = (Person)recman.fetch(recid);   
        System.out.println(person2.getName());   
        System.out.println(person2.getAge());   

        //通过别名查询   
        long recid3 = recman.getNamedObject("othername");    
        Person person3 = (Person)recman.fetch(recid3);   
        System.out.println(person3.getName());   
        System.out.println(person3.getAge());   
   
        //更新   
        Person person4 = new Person();   
        person4.setAge(25);   
        person4.setName("test update");   
        recman.update(recid, person4);   
        recman.commit();   
        Person person5 = (Person)recman.fetch(recid);   
        System.out.println(person5.getAge());   
        System.out.println(person5.getName());   

	}
	
	
	
	public static void ss1() throws IOException{
		//创建RecordManager实例对象   
		BaseRecordManager recman = fileManagers.get(fileStore);
        if (recman == null) {
          // recman = RecordManagerFactory.createRecordManager(fileStore);
           recman =  new BaseRecordManager(fileStore);
           fileManagers.put(fileStore, recman);
        }
        
        //通过别名查询   
        long recid31 = recman.getNamedObject("othername");    
        Person person31 = (Person)recman.fetch(recid31);   
        System.out.println("ss2 name="+person31.getName());   
        System.out.println("ss2 age ="+person31.getAge()); 
        
        
        
     

	}
	
	public static void ss2() throws IOException{
		//创建RecordManager实例对象   
		BaseRecordManager recman =  new BaseRecordManager(fileStore);
        
		
        //通过别名查询   
        long recid = recman.getNamedObject("fileCache");
        
   //     HTree fileTable = (HTree) recman.fetch(recid);
//        jdbm.htree.HashDirectory person31 = (jdbm.htree.HashDirectory)recman.fetch(recid);   
//        System.out.println("ss2 name="+person31);   
//        System.out.println("ss2 age ="+person31); 
        
        
        System.out.println("s001="+recid); 
        HTree fileTable = HTree.load( recman, recid );
        System.out.println("s001="+fileTable.get("s001"));
        System.out.println("map004="+fileTable.get("map004"));
        System.out.println("ss004="+fileTable.get("ss004"));
        System.out.println("ss0041="+fileTable.get("ss0041"));
        Map map004 =(Map) fileTable.get("map004");
//        map004.put("ss0042", "146");
//        
//        fileTable.put("s003", "145");
//        recman.commit();
//       
        
        
        
//        FastIterator<Object> iter = fileTable.keys();
//        Object value = iter.next();
//        while (value != null) {
//            
//        	System.out.println("value="+value); 
//        }

	}
	
	
	
	}
	
	class Person implements Serializable{   
	    public String name;   
	    public int age;   
	    public int getAge() {   
	        return age;   
	    }   
	    public void setAge(int age) {   
	        this.age = age;   
	    }   
	    public String getName() {   
	        return name;   
	    }   
	    public void setName(String name) {   
	        this.name = name;   
	    }   
	       
	}   

	
	