package org.ptbank.test;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import org.junit.Test;

import com.alibaba.druid.pool.DruidDataSource;

public class TestDruid {
	@Test
	public void Test() {
		try {
			InputStream isConfig = getClass().getResourceAsStream("connection.ini");
			Properties prop = new Properties();
			prop.load(isConfig);
			//DataSource ds = DruidDataSourceFactory.createDataSource(prop);
			DruidDataSource ds = new DruidDataSource();
			ds.setDriverClassName("oracle.jdbc.driver.OracleDriver");  
	        ds.setUsername("gzcx");  
	        ds.setPassword("gzcx");  
	        ds.setUrl("jdbc:oracle:thin:@127.0.0.1:1521:ora10g");  
	        ds.setInitialSize(5); // 初始的连接数；  
	        ds.setMaxActive(100);  
	        ds.setMaxIdle(30);  
	        ds.setMaxWait(10000);  
			Connection conn = null;  
	        Statement stmt = null;  
	        ResultSet rs = null;  
	  
	        try {   
	        	conn = ds.getConnection();
	            stmt = conn.createStatement();  
	            rs = stmt.executeQuery("select count(*) cnt from dual ");  
	            System.out.println("Results:");  
	            int numcols = rs.getMetaData().getColumnCount();  
	            while (rs.next()) {
	                for (int i = 1; i <= numcols; i++) {  
	                    System.out.print("\t" + rs.getString(i) + "\t");  
	                }
	                System.out.println("");  
	            }  
	        } catch (SQLException e) {  
	            e.printStackTrace();  
	        } finally {  
	            try {  
	                if (rs != null)  
	                    rs.close();  
	                if (stmt != null)  
	                    stmt.close();  
	                if (conn != null)  
	                    conn.close();  
	                if (ds != null)  
	                	ds.close();  
	            } catch (Exception e) {  
	                e.printStackTrace();  
	            }  
	        }  
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
