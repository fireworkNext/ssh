package org.ptbank.db;

/**
 * 数据连接池的管理
 * @author enjsky
 */
import java.util.Date;
import java.util.Vector;
import java.sql.*;
import java.util.Enumeration;
import java.util.Properties;
import java.io.InputStream;
import java.util.StringTokenizer;
import java.util.Hashtable;
import java.io.IOException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.ptbank.db.DBConnection;
import org.ptbank.declare.*;
import org.ptbank.func.General;


import java.util.List;
import java.util.Iterator;

public class DBConnectionManager {

	static private DBConnectionManager instance;

	static private int clients;

	private static Vector<Driver> drivers = new Vector<Driver>();

	private static Hashtable<String, DBConnectionPool> pools = new Hashtable<String, DBConnectionPool>();

	private static Hashtable ctxTable = new Hashtable();

	/**
	 * 获得连接池管理类的实例
	 * @return DBConnectionManager
	 */
	static synchronized DBConnectionManager getInstance() {
		if (instance == null) {
			instance = new DBConnectionManager();
		}
		clients++;
		return instance;
	}

	private DBConnectionManager() {
		init();
	}

	/**
	 * 连接池管理类的初始化
	 */
	private void init() {
		InputStream isConfig = getClass().getResourceAsStream("connection.ini");
		Properties prop = new Properties();

		try {
			prop.load(isConfig);
		} catch (Exception e) {
			isConfig = getClass().getResourceAsStream(
					"/" + Common.SYSTEM_NAME
							+ "/WEB-INF/classes/org/gzcx/db/connection.ini");
			try {
				prop.load(isConfig);
			} catch (IOException ex) {
				System.err.println("不能读取属性文件. " + "请确保配制文件在指定的路径中");
				return;
			}
		}

		String ds = prop.getProperty("DataSource");
		String isJdbctype = prop.getProperty("JdbcType");
		DBConnection.JDBCTYPE = isJdbctype;
		System.out.println("JDBC类型：" + isJdbctype);
		if (!General.empty(ds)) { //装载WebLogic、WebSphere等应用服务器的数据源
			loadJdbc(prop);
		} 
		else {                     //装载自定义的数据源
			loadDrivers(prop);
			createPools(prop);
		}

	}
	
	 /**
	   * 重启连接池
	   */
	  public void reset()
	  {
		  init();
	  }

	/**
	 * 初始化数据库服务器的驱动
	 * @param props：属性列表
	 */
	private void loadDrivers(Properties props) {
		String driverClasses = props.getProperty("drivers");
		StringTokenizer st = new StringTokenizer(driverClasses);
		while (st.hasMoreElements()) {
			String driverClassName = st.nextToken().trim();
			try {
				Driver driver = (Driver) Class.forName(driverClassName)
						.newInstance();
				DriverManager.registerDriver(driver);
				drivers.addElement(driver);
				System.out.println("成功注册JDBC驱动程序" + driverClassName);
			} catch (Exception e) {
				System.out.println("无法注册JDBC驱动程序: " + driverClassName + ", 错误: " + e);
			}
		}
	}

	
	/**
	 * 初始化Weblogic、WebSphere等定义的数据源
	 * @param props 数据源属性文件
	 */
	private void loadJdbc(Properties props) {

		try {

			// String applicationSerName = props.getProperty("AppSerName");

			String jdname = props.getProperty("DataSource");
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup(jdname);

			DBConnection.DATA_SOURCE = ds;
            
			System.out.println("");
			System.out.println("获取数据源"+jdname+"成功！");
			System.out.println("");

		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("获取数据源失败！");
		}

	}
	
	/**
	 * 初始化Druid连接池
	 * @param props 数据源属性文件
	 */
	private void loadDruid(Properties props) {

		try {

			// String applicationSerName = props.getProperty("AppSerName");

			String jdname = props.getProperty("DataSource");
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup(jdname);

			DBConnection.DATA_SOURCE = ds;
            
			System.out.println("");
			System.out.println("获取数据源"+jdname+"成功！");
			System.out.println("");

		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("获取数据源失败！");
		}

	}

	/**
	 * 初始化连接池
	 * @param props 属性列表
	 * @return 无
	 */
	private void createPools(Properties props) {
		Enumeration propNames = props.propertyNames();
		while (propNames.hasMoreElements()) {
			String name = (String) propNames.nextElement();
			
			if (name.endsWith(".url")) {
				String poolName = name.substring(0, name.lastIndexOf("."));
				String strUrl = props.getProperty(poolName + ".url");
				if (strUrl == null) {
					System.out.println("没有为连接池" + poolName + "指定URL");
					continue;
				}
				String strUser = props.getProperty(poolName + ".user");
				String strPassword = props.getProperty(poolName + ".password");
				String maxconn = props.getProperty(poolName + ".maxconn", "0");
				int max;
				try {
					max = Integer.valueOf(maxconn).intValue();
				} catch (NumberFormatException e) {
					System.out.println("错误的最大连接数限制: " + maxconn + " .连接池: "
							+ poolName);
					max = 0;
				}
				DBConnectionPool pool = new DBConnectionPool(poolName, strUrl,
						strUser, strPassword, max);
				pools.put(poolName, pool);
				System.out.println("成功创建连接池" + poolName + "；共" + pool.maxcon + "个");
			}
		}
	}


	public Context getContext() {
		return getContext("default");
	}

	public Context getContext(String name) {
		Context ctx = (Context) DBConnectionManager.ctxTable.get(name);
		return ctx;
	}

	/**
	 * 获得共有多少已使用的连接
	 * @return int 已使用的连接数
	 */
	public int getUsedCounts() {
		return getUsedCounts(Common.SYSTEM_NAME);
	}

	/**
	 *  获得共有多少已使用的连接
	 * @param strPoolName 连接池名称
	 * @return int 已使用的连接数
	 */
	public int getUsedCounts(String strPoolName) {
		DBConnectionPool pool = (DBConnectionPool) pools.get(strPoolName);

		if (pool != null) {
			return pool.getUsedCounts();
		}
		return 0;
	}

	/**
	 * 获得共有多少未使用的连接
	 * @return int 未使用的连接数
	 */
	public int getFreeCounts() {
		return getFreeCounts(Common.SYSTEM_NAME);
	}

	/**
	 * 获得共有多少未使用的连接
	 * @param strPoolName 连接池名称
	 * @return int 未使用的连接数
	 */
	public int getFreeCounts(String strPoolName) {
		DBConnectionPool pool = (DBConnectionPool) pools.get(strPoolName);

		if (pool != null) {
			return pool.getFreeCounts();
		}
		return 0;
	}

	/**
	 * 返回连接的 url
	 * @param name  连接池名称
	 * @return 无
	 */
	public String getUrl(String name) {
		DBConnectionPool pool = (DBConnectionPool) pools.get(name);
		if (pool != null) {
			return pool.URL;
		}
		return null;
	}

	public void freeConnection(String name, Connection con) {
		DBConnectionPool pool = (DBConnectionPool) pools.get(name);
		if (pool != null) {
			pool.freeConnection(con);
			return;
		} else {
			if (con != null) {
				try {
					if (con != null)
						con.close();
				} catch (SQLException e) {

				}
			}
		}
		con = null;
	}

	/**
	 * 关闭所有连接,撤销驱动程序的注册
	 */
	public synchronized void release() {
		if (--clients != 0) {
			return;
		}
		Enumeration allPools = pools.elements();
		while (allPools.hasMoreElements()) {
			DBConnectionPool pool = (DBConnectionPool) allPools.nextElement();
			if (pool != null) {
				pool.release();
			}
		}
		Enumeration allDrivers = drivers.elements();
		while (allDrivers.hasMoreElements()) {
			Driver driver = (Driver) allDrivers.nextElement();
			try {
				DriverManager.deregisterDriver(driver);
				System.out.println("撤销JDBC驱动程序 " + driver.getClass().getName()
						+ "的注册");
			} catch (SQLException e) {
				System.out.println("无法撤销下列JDBC驱动程序的注册: "
						+ driver.getClass().getName());
			}
		}
	}

	/**
	 * 获得一个可用连接.若没有可用连接,且已有连接数小于最大连接数限制, 则创建并返回新连接.
	 * @param name 连接池名字
	 * @return Connection 可用连接或null
	 */
	public Connection getConnection(String name) {

		DBConnectionPool pool = (DBConnectionPool) pools.get(name);
		if (pool != null) {
			return pool.getConnection();
		}
		return null;

	}

	/**
	 * 获得一个可用连接.若没有可用连接,且已有连接数小于最大连接数限制, 则创建并返回新连接.否则,在指定的时间内等待其它线程释放连接.
	 * @param name 连接池名字
	 * @param time 以毫秒计的等待时间
	 * @return Connection 可用连接或null
	 */
	public Connection getConnectionFromPool(String name, long time) {
		DBConnectionPool pool = (DBConnectionPool) pools.get(name);
		if (pool != null) {
			return pool.getConnection(time);
		}
		return null;
	}

	class DBConnectionPool {
		private String name;

		private String URL;

		private String user;

		private String password;

		private int maxcon;

		private List<Connection> freeConnections = new java.util.LinkedList<Connection>();

		private List<Connection> usedConnections = new java.util.LinkedList<Connection>();

		private int checkout;

		public DBConnectionPool(String name, String URL, String user,
				String password, int maxcon) {
			this.name = name;
			this.URL = URL;
			this.user = user;
			this.password = password;
			this.maxcon = maxcon;
			if (maxcon > 0)
				for (int i = 0; i < maxcon; i++) {
					Connection con = newConnection();
					freeConnections.add(con);
				}
		}

		public synchronized void freeConnection(Connection con) {
			if (con != null) {
				if (usedConnections.remove(con)) {
					freeConnections.add(con);
					this.checkout--;
					notifyAll();
				}
			}
		}

		public synchronized Connection getConnection(long timeout) {
			Connection con = getConnectionex(timeout);
			if (con != null) {
				usedConnections.add(con);
			}
			return con;
		}

		/***********************************************************************
		 * 获得连接
		 * @return Connetion 连接
		 **********************************************************************/
		public synchronized Connection getConnection() {
			Connection con = getConnectionex();
			if (con == null) {
				con = getConnectionex(3000);
			}
			if (con != null) {
				usedConnections.add(con);
				this.checkout++;
			}
			return con;
		}

		/**
		 * 获得共有多少已使用的连接
		 * @return int 已使用的连接数
		 */
		public synchronized int getUsedCounts() {
			return usedConnections.size();
		}

		/**
		 * 获得共有多少未使用的连接
		 * @return int 未使用的连接数
		 */
		public synchronized int getFreeCounts() {
			return freeConnections.size();
		}

		/**
		 * 从连接池获得一个可用连接.如没有空闲的连接且当前连接数小于最大连接 数限制,则创建新连接.如原来登记为可用的连接不再有效,则从向量删除之,
		 * 然后递归调用自己以尝试新的可用连接.
		 */
		private synchronized Connection getConnectionex() {

			Connection con = null;

			if (freeConnections.size() > 0) {
				con = (Connection) freeConnections.get(0);
				freeConnections.remove(0);

				try {
					if (con != null) {
						if (con.isClosed()) {
							System.out.println("从连接池" + name + "新建一个连接");
							con = newConnection();
						}
					}
				} catch (SQLException e) {
					//System.out.println("从连接池" + name + "删除一个无效连接");
					con = getConnectionex();
				}

			}
			return con;
		}

		/***********************************************************************
		 * 获得连接
		 * @param timeout 超时数
		 * @return Connetion 连接
		 **********************************************************************/
		private synchronized Connection getConnectionex(long timeout) {
			Connection con;
			long startTime = new Date().getTime();

			while (((con = getConnectionex()) == null)) {
				try {
					wait(timeout);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				if (new Date().getTime() - startTime > timeout) {
					return null;
				}
			}
			return con;
		}

		/***********************************************************************
		 * 释放所有连接
		 **********************************************************************/
		public synchronized void release() {
			Iterator allconnections = freeConnections.iterator();

			while (allconnections.hasNext()) {

				Connection con = (Connection) allconnections.next();
				try {
					con.close();
					System.out.println("关闭连接池" + name + "中的一个连接");
				} catch (SQLException e) {
					System.out.println("无法关闭连接池" + name + "中的连接,错误为："
							+ e.getMessage());
				}
			}
			freeConnections.clear();
			usedConnections.clear();
		}

		/***********************************************************************
		 * 创建新的连接
		 * @return Connection 新建连接
		 **********************************************************************/
		private Connection newConnection() {
			Connection con = null;

			try {
				if (user == null) {
					con = DriverManager.getConnection(this.URL);
				} else {
					con = DriverManager.getConnection(this.URL, this.user,
							this.password);
				}
			} catch (Exception e) {
				System.out.println("无法创建下列URL的连接" + URL + "，原因如下："
						+ e.getMessage());
				return null;
			}
			return con;
		}
	}
}
