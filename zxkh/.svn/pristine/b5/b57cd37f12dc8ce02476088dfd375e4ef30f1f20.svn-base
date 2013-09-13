package org.ptbank.db;

import java.sql.*;
import java.util.regex.Pattern;

import javax.sql.DataSource;

import org.ptbank.declare.Common;

public class DBConnection implements java.io.Serializable {
	private static final long serialVersionUID = 7951045108660549719L;

	private Connection m_cnn_Self = null;

	private Statement m_stm = null;

	public static DataSource DATA_SOURCE;

	public static String JDBCTYPE;

	// / 获得连接管理类
	static DBConnectionManager connMgr = DBConnectionManager.getInstance();

	/**
	 * 对象实例化，从数据库连接池中获得连接
	 */
	public DBConnection() {
		try {
			if (DATA_SOURCE != null)
				m_cnn_Self = DATA_SOURCE.getConnection();
			else
				m_cnn_Self = connMgr.getConnection(Common.SYSTEM_NAME);

			m_stm = m_cnn_Self.createStatement();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 对象实例化，从数据库连接池中获得连接
	 * 
	 * @param strPoolName
	 *            连接池名称
	 */
	public DBConnection(String strPoolName) {
		try {
			m_cnn_Self = connMgr.getConnection(strPoolName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 获得连接
	 * 
	 * @return Connection 连接或 null
	 */
	public Connection getConnection() {
		try {
			ResultSet rs;
			if (JDBCTYPE.equals("2")) {
				rs = m_stm.executeQuery("SELECT 1 FROM DUAL");
				rs.close();
			} else if (JDBCTYPE.equals("3")) {
				rs = m_stm.executeQuery("SELECT 1");
				rs.close();
			} else if (JDBCTYPE.equals("4")) {
				rs = m_stm.executeQuery("SELECT 1");
				rs.close();
			}
		} catch (Exception ex) // 异常重新创建连接池
		{
			System.out.println("数据库连接异常，重新建立链接。");
			connMgr = DBConnectionManager.getInstance();
			connMgr.reset();
			try {
				if (DATA_SOURCE != null) {
					m_cnn_Self = DATA_SOURCE.getConnection();
				} else
					m_cnn_Self = connMgr.getConnection(Common.SYSTEM_NAME);

				m_stm = m_cnn_Self.createStatement();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return m_cnn_Self;
	}

	/**
	 * 获得连接池中已使用的连接数
	 * 
	 * @return int 已使用的连接数
	 */
	public int getUsedCounts() {
		return connMgr.getUsedCounts();
	}

	/**
	 * 获得连接池中已使用的连接数
	 * 
	 * @param strPoolName
	 *            连接池名称
	 * @return int 已使用的连接数
	 */
	public int getUsedCounts(String strPoolName) {
		return connMgr.getUsedCounts(strPoolName);
	}

	/**
	 * 获得连接池中未连接的连接数
	 * 
	 * @return int 未连接的连接数
	 */
	public int getFreeCounts() {
		return connMgr.getFreeCounts();
	}

	/**
	 * 获得连接池中未连接的连接数
	 * 
	 * @param strPoolName
	 *            连接池名称
	 * @return int 未连接的连接数
	 */
	public int getFreeCounts(String strPoolName) {
		return connMgr.getFreeCounts(strPoolName);
	}

	/**
	 * 释放连接
	 */
	public void freeConnection() {
		if (DATA_SOURCE != null) {
			try {
				if (m_stm != null)
					m_stm.close();

				if (m_cnn_Self != null)
					m_cnn_Self.close();
			} catch (Exception e) {
			}
		} else {
			try {
				if (m_stm != null)
					m_stm.close();
			} catch (Exception e) {
			}
			freeConnection(Common.SYSTEM_NAME);
		}
	}

	/**
	 * 释放连接
	 * 
	 * @param strPoolName
	 *            连接池名称
	 */
	public void freeConnection(String strPoolName) {
		try {
			if (m_cnn_Self != null) {
				connMgr.freeConnection(strPoolName, m_cnn_Self);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 关闭连接池中的所有连接，撤销驱动程序的注册
	 */
	public void releaseConnection() {
		connMgr.release();
	}

	/**
	 * strSQL 语句
	 * 
	 * @return String 空 执行成功 其他 返回错误信息
	 */
	public String excuteSql(String strSQL) throws Exception {
		String stringRtn = null;

		try {

			PreparedStatement stmt = m_cnn_Self.prepareStatement(strSQL);

			stmt.executeUpdate();

			stmt.close();
			m_cnn_Self.commit();
			// return null;
		} catch (Exception e) {
			e.printStackTrace();
			stringRtn = "发生错误：" + e.getMessage();

			try {
				m_cnn_Self.rollback();
			} catch (SQLException ex) {
				stringRtn += ex.getMessage();
			}
		} finally {
			this.freeConnection();
		}
		return stringRtn;
	}

	/**
	 * 执行查询
	 * 
	 * @param strSQL
	 *            查询语句
	 * @return 结果集 或 null
	 */
	public ResultSet excuteQuery(String strSQL) throws Exception {
		ResultSet resultSet;

		try {
			resultSet = m_stm.executeQuery(strSQL);
			return resultSet;
		} catch (Exception e) {
			throw e;

		} finally {
			// statement.close();
		}
	}

	/**
	 * 返回查询记录数
	 * 
	 * @param strSQL
	 *            查询语句
	 * @return 结果集 或 null
	 */
	public int getRowCount(String strSQL) throws Exception {
		ResultSet resultSet;
		int iCount = 0;
		String regex = "select((.)+)from";
		Pattern p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
		String[] s = p.split(strSQL);
		String newSql = "select count(1) as total from " + s[1];
		try {
			resultSet = m_stm.executeQuery(newSql);
			if (resultSet.next()) {
				iCount = resultSet.getInt("total");
			}
			resultSet.close();
			return iCount;
		} catch (Exception e) {
			throw e;

		} finally {
			// statement.close();
		}
	}

	/**
	 * 对象回收
	 * 
	 * @return 无
	 */
	protected void finalize() {
		freeConnection();
	}
}
