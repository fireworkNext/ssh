package org.ptbank.db;

/**
 * 数据处理层组件，对批量T-SQL进行统一事务封装处理
 * @author enjsky
 * {@link www.efsframe.cn}
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedList;

import org.ptbank.base.NumAssign;
import org.ptbank.declare.Common;
import org.ptbank.func.General;

public class DataStorage {
	private LinkedList<String> m_lst_SQL; // / 存储 SQL 语句

	/**
	 * 对象实例化
	 */
	public DataStorage() {
		this.m_lst_SQL = new LinkedList<String>();
	}

	/**
	 * 将一个 SQL 语句添加到存储对象中
	 * 
	 * @param strSQL
	 *            待加入集合的 SQL 语句
	 * @return int 在存储集合中的索引 如果添加失败则返回 -1
	 */
	public int addSQL(String strSQL) {
		if (this.m_lst_SQL.add(strSQL)) {
			return this.m_lst_SQL.size() - 1;
		}
		return -1;
	}

	/**
	 * 获得存储中的 SQL 语句
	 * 
	 * @param intIndex
	 *            存储集合中的索引号
	 * @return String SQL 语句 如果索引号不正确，则返回 null
	 */
	public String getSQL(int intIndex) {
		if (!valIndex(intIndex)) {
			return null;
		}

		return this.m_lst_SQL.get(intIndex);
	}

	/**
	 * 获得存储中的 SQL 语句的索引
	 * 
	 * @param strSQL
	 *            SQL语句
	 * @return int SQL 语句的在存储集合中的索引号
	 */
	public int getSQLIndex(String strSQL) {
		return this.m_lst_SQL.indexOf(strSQL);
	}

	/**
	 * 更新存储的 SQL 语句
	 * 
	 * @param strSQL
	 *            SQL 语句
	 * @param intIndex
	 *            在存储集合中的索引号
	 */
	public void setSQL(String strSQL, int intIndex) {
		if (!valIndex(intIndex)) {
			return;
		}

		this.m_lst_SQL.set(intIndex, strSQL);
	}

	/**
	 * 删除存储的 SQL 语句
	 * 
	 * @param intIndex
	 *            在存储集合中的索引号
	 */
	public void deleteSQL(int intIndex) {
		if (!valIndex(intIndex)) {
			return;
		}

		this.m_lst_SQL.remove(intIndex);
	}

	/**
	 * 清空存储的 SQL 语句
	 */
	public void clear() {
		this.m_lst_SQL.clear();
	}

	/**
	 * 检验传入的索引号是否在存储集合的有效范围内
	 * 
	 * @param intIndex
	 * @return boolean 合法为true;非法为false
	 */
	public boolean valIndex(int intIndex) {
		boolean b1 = (0 - intIndex) > 0 ? false : true;
		boolean b2 = (intIndex - this.m_lst_SQL.size()) >= 0 ? false : true;
		return b1 & b2;
	}

	/**
	 * 执行存储中的 SQL 语句
	 * 
	 * @return String 空 函数执行成功 其他 返回错误信息
	 */
	public String runSQL() {
		int i = 1, j = 1;
		String sSql = "";
		// / 获得连接
		DBConnection dbc = new DBConnection();
		Connection conn = dbc.getConnection();

		try {
			conn.setAutoCommit(false);
			Iterator<String> it = this.m_lst_SQL.iterator();

			while (it.hasNext()) {
				String str_SQL = it.next();
				sSql = str_SQL;
				PreparedStatement stmt = conn.prepareStatement(str_SQL);

				stmt.executeUpdate();

				stmt.close();
				i++;
			}

			conn.commit();

			return null;
		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("错误行："+i+",错误SQL："+sSql);
			try {
				conn.rollback();

				// 将错误的SQL封装到 SQLSTORAGE 表中，便于查询分析
				conn.setAutoCommit(false);
				Iterator<String> it = this.m_lst_SQL.iterator();
				String strObjID = NumAssign.assignID_B("000011", General.curYear2() + General.curMonth() + General.curDay());

				while (it.hasNext()) {
					String str_SQL = it.next();
					if (DBConnection.JDBCTYPE.equals("3")) // Ms Sql
						str_SQL = "INSERT INTO SQLSTORAGE(OBJID,SQLSCRIPT) VALUES ('" + strObjID + "','" + str_SQL.replaceAll(Common.QUOTE, Common.MARK) + "')";
					else if (DBConnection.JDBCTYPE.equals("2")) // Oralce
						str_SQL = "INSERT INTO SQLSTORAGE(SQLID,OBJID,SQLSCRIPT) VALUES (SEQ_SQLID.NEXTVAL,'" + strObjID + "','" + str_SQL.replaceAll(Common.QUOTE, "''") + "')";
					else if (DBConnection.JDBCTYPE.equals("4")) // MySql
						str_SQL = "INSERT INTO SQLSTORAGE(OBJID,SQLSCRIPT) VALUES ('" + strObjID + "','" + str_SQL.replaceAll(Common.QUOTE, Common.MARK) + "')";

					PreparedStatement stmt = conn.prepareStatement(str_SQL);

					stmt.executeUpdate();

					stmt.close();
					j++;
					if (j >= (i + 1)) {
						break;
					}
				}

				conn.commit();

			} catch (SQLException ex) {
				return ex.getMessage();
			}
			return "错误行：" + i + ",错误信息：" + e.getMessage() + ",错误SQL：" + sSql;
		} finally {
			dbc.freeConnection();
		}

	}
	
	/*
	 * 批量执行sql语句	
	 */
	public String runBatchSQL(){
		// / 获得连接
		DBConnection dbc = new DBConnection();
		Connection conn = dbc.getConnection();
		Statement stmt = null;
		try {
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			Iterator<String> it = this.m_lst_SQL.iterator();

			while (it.hasNext()) {
				String str_SQL = it.next();
				stmt.addBatch(str_SQL);
			}
			int[] rows = stmt.executeBatch();
			conn.commit();

			return null;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			return e.getMessage();
		} finally {
			if(stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			dbc.freeConnection();
		}
	}
}
