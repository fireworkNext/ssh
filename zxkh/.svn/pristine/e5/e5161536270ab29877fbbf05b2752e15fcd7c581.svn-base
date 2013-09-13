package org.ptbank.bo;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.ptbank.db.DBConnection;
import org.ptbank.func.General;

public class Rptgzcx {
	// 空构造函数
	public Rptgzcx() {
	}

	/*
	 * 根据查询条件进行员工查询工资的统计
	 */
	public ArrayList getWageDetail(String sYear, String sMonth, String sSfzhm, String sName, String sIsSee) {
		DBConnection db = new DBConnection();
		ResultSet rs = null;
		String str_SQL = "";
		ArrayList al = new ArrayList();
		try {
			if ("0".equals(sIsSee))
				str_SQL = "select year,month,nvl(bmmc,' ') bmmc,sfzhm,name,nvl(see_dt,' ') see_dt,nvl(see_tm,' ') see_tm from t_wage_detail where year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth);
			else if ("1".equals(sIsSee))
				str_SQL = "select year,month,nvl(bmmc,' ') bmmc,sfzhm,name,nvl(see_dt,' ') see_dt,nvl(see_tm,' ') see_tm from t_wage_detail where year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth) + " and see_dt is not null";
			else if ("2".equals(sIsSee))
				str_SQL = "select year,month,nvl(bmmc,' ') bmmc,sfzhm,name,nvl(see_dt,' ') see_dt,nvl(see_tm,' ') see_tm from t_wage_detail where year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth) + " and see_dt is null";
			// System.out.println(str_SQL);
			rs = db.excuteQuery(str_SQL);
			while (rs.next()) {
				WageDetail wageDetail = new WageDetail();
				wageDetail.setYear(rs.getString("year"));
				wageDetail.setMonth(rs.getString("month"));
				wageDetail.setBmmc(rs.getString("bmmc"));
				wageDetail.setSfzhm(rs.getString("sfzhm"));
				wageDetail.setName(rs.getString("name"));
				wageDetail.setSee_dt(rs.getString("see_dt"));
				wageDetail.setSee_tm(rs.getString("see_tm"));
				al.add(wageDetail);
			}
		} catch (Exception e) {
			System.err.println("getWageDetail:" + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			db.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名导出模版到excel文件
	 */
	public ArrayList getTplList(String sTpl) {
		DBConnection db = new DBConnection();
		ResultSet rs = null;
		String str_SQL = "";
		ArrayList al = new ArrayList();
		try {
			str_SQL = "select fldname from v_tpl where flag='1' and impflag='1' and tpl=" + General.addQuotes(sTpl) + " order by fldord";
			// System.out.println(str_SQL);
			rs = db.excuteQuery(str_SQL);
			while (rs.next()) {
				al.add(rs.getString(1));
			}
		} catch (Exception e) {
			System.err.println("getTplList:" + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			db.freeConnection();
		}
		return al;
	}

	/*
	 * 根据单位编码和模版名导出模版到excel文件
	 */
	public ArrayList getUnitTplList(String sDwbm, String sTpl) {
		DBConnection db = new DBConnection();
		ResultSet rs = null;
		String str_SQL = "";
		ArrayList al = new ArrayList();
		
		try {
			str_SQL = "select dbfld,fldname from v_unit_tpl where flag='1' and impflag='1' and tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(sDwbm) + " order by fldord";
			// System.out.println(str_SQL);
			rs = db.excuteQuery(str_SQL);
			while (rs.next()) {
				Tpl tpl = new Tpl();
				tpl.setDbfld(rs.getString("dbfld"));
				tpl.setFldname(rs.getString("fldname"));
				al.add(tpl);
			}
		} catch (Exception e) {
			System.err.println("getUnitTplList:" + e.getMessage());
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			db.freeConnection();
		}
		return al;
	}
}
