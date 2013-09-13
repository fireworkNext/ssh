package org.ptbank.bo;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentFactory;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.ptbank.base.CommonQuery;
import org.ptbank.base.DataDoc;
import org.ptbank.base.QueryDoc;
import org.ptbank.base.ReturnDoc;
import org.ptbank.base.XmlFunc;
import org.ptbank.cache.DicCache;
import org.ptbank.cache.SpellCache;
import org.ptbank.cache.UserLogonInfo;
import org.ptbank.db.DBConnection;
import org.ptbank.db.DataStorage;
import org.ptbank.db.Pub;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.func.DateTimeUtil;
import org.ptbank.func.Encrypt;
import org.ptbank.func.Excel;
import org.ptbank.func.FusionChartsUtil;
import org.ptbank.func.General;
import org.ptbank.func.PageCommon;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class GzcxBO {
	/***************************************************************************
	 * 工资查询用户登录
	 * 
	 * @param doc
	 *            XML 数据文档
	 * @return UserLogonInfo 返回信息
	 **************************************************************************/
	public static WageUser loginOn(Document doc) throws Exception {
		String strUserSfzhm = XmlFunc.getNodeValue(doc, Common.XDOC_LOGININFO + Common.BAR + "USERSFZHM");
		String strUserName = XmlFunc.getNodeValue(doc, Common.XDOC_LOGININFO + Common.BAR + "USERNAME");
		String strUserPasswd = XmlFunc.getNodeValue(doc, Common.XDOC_LOGININFO + Common.BAR + "USERPASSWD");

		// 单条语句执行
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		// 多条语句执行
		DataStorage ds = new DataStorage();

		WageUser wageUser = new WageUser();
		try {
			String strSQL = "select sfzhm,nvl(name,'') name,nvl(dwmc,'') dwmc,nvl(bmmc,'') bmmc,passwd,flag from t_wage_user where sfzhm=" + General.addQuotes(strUserSfzhm);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取用户信息失败");
			}

			if (rst.next() && rst.getRow() > 0) {
				wageUser.setSfzhm(rst.getString("sfzhm"));
				wageUser.setName(rst.getString("name"));
				wageUser.setDwmc(rst.getString("dwmc"));
				wageUser.setBmmc(rst.getString("bmmc"));
				wageUser.setPasswd(rst.getString("passwd"));
				wageUser.setFlag(rst.getString("flag"));

				if (!wageUser.getName().equals(strUserName)) {
					throw new Exception("姓名不符,请检查输入是否正确！");
				}
				if (!wageUser.getPasswd().equals(strUserPasswd)) {
					throw new Exception("密码错误,请检查输入是否正确！");
				}
				// 更新登录时间
				ds.addSQL("update t_wage_user set lst_log_dt=TO_CHAR(SYSDATE,'YYYYMMDD'),lst_log_tm=TO_CHAR(SYSDATE,'HH24:MI:SS') where sfzhm=" + General.addQuotes(strUserSfzhm));
				ds.addSQL("update t_wage_detail set see_dt=TO_CHAR(SYSDATE,'YYYYMMDD'),see_tm=TO_CHAR(SYSDATE,'HH24:MI:SS') where see_tm is null and sfzhm=" + General.addQuotes(strUserSfzhm));
				ds.addSQL("update t_prize_detail set see_dt=TO_CHAR(SYSDATE,'YYYYMMDD'),see_tm=TO_CHAR(SYSDATE,'HH24:MI:SS') where see_tm is null and sfzhm=" + General.addQuotes(strUserSfzhm));
				ds.runSQL();
			} else
				throw new Exception("该用户信息不存在,请检查输入是否正确！");

		} finally {
			if (rst != null)
				rst.close();
			dbc.freeConnection();
		}
		return wageUser;
	}

	/***************************************************************************
	 * 查询薪酬明细列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String salaryList(String strXML, UserLogonInfo user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// 获取查询条件map
		// Map<String,String> map = obj_Query.getConditionMap(strXML);
		// 获得模版数据库字段历史列表
		// String strDbfldList = getHisDbfld(map.get("TPL"),map.get("YEAR"),map.get("MONTH"),user);

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "*";

		String str_From = "T_SALARY_DETAIL S";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		// System.out.println("str_Where:"+str_Where);

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "dwbm,to_number(YEAR),to_number(MONTH)", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/***************************************************************************
	 * 查询业务发展奖励列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String RewardsList(String strXML, UserLogonInfo user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "ROWID REWID,S.YEAR YEAR,S.MONTH MONTH,S.SFZHM SFZHM,S.BXDM BXDM,S.DW DW,S.XM XM,S.ZJ ZJ,S.ZDW ZDW,S.GW GW,S.YWZL YWZL,S.YWSR YWSR,S.JLBZ JLBZ,S.SF SF,S.SFJL SFJL,S.DETAIL DETAIL,S.VALID VALID";

		String str_From = "T_REWARDS" + " " + "S";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// 按照登录用户的身份证号获取记录
		// str_Where =
		// Common.WHERE+"SFZHM="+General.addQuotes(user.getIDCard());
		// 根据保险代码获取记录
		str_Where = Common.WHERE + "BXDM=" + General.addQuotes(user.getBxdm());
		// str_Where = General.empty(str_Where) ? Common.ORDER +
		// Field.EVENTTYPEID : str_Where + Common.S_ORDER + Field.EVENTTYPEID;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "YEAR,MONTH DESC", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询绩效工资细信息
	 * 
	 * @param SALID
	 *            绩效工资ID
	 * @return XML 标准查询返回结构
	 */
	public static String salaryDetail(String strXML) throws Exception {
		// QueryDoc obj_Query = new QueryDoc(strXML);
		String str_Select = "ROWID SALID,S.YEAR,S.MONTH,S.SFZHM,S.BXDM,S.DW,S.XM,S.ZJ,S.ZDW,S.GW,S.SAL1,S.SAL2,S.SAL3,S.SAL4,S.SAL5,S.SAL6,S.SAL7,S.SAL8,S.SAL9,S.SAL10,S.SAL11,S.SAL12,S.SAL13,S.SAL14,S.SAL15,S.DETAIL,S.VALID";

		String str_From = "T_SALARY" + " " + "S";

		// String str_Where = obj_Query.getConditions();

		String str_Where = Common.WHERE + Common.SPACE + "ROWID" + Common.EQUAL + General.addQuotes(strXML);
		// System.out.println(str_Where);
		// str_Where = General.empty(str_Where) ? Common.ORDER +
		// Field.EVENTTYPEID : str_Where + Common.S_ORDER + Field.EVENTTYPEID;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "SALID", null, null, null, 1, 1, 1, 1, 0, true, "SALARY");
	}

	/**
	 * 查询业务发展奖励细信息
	 * 
	 * @param REWID
	 *            业务发展奖励ID
	 * @return XML 标准查询返回结构
	 */
	public static String rewardsDetail(String strXML) throws Exception {
		// QueryDoc obj_Query = new QueryDoc(strXML);
		String str_Select = "ROWID REWID,S.YEAR YEAR,S.MONTH MONTH,S.SFZHM SFZHM,S.BXDM BXDM,S.DW DW,S.XM XM,S.ZJ ZJ,S.ZDW ZDW,S.GW GW,S.YWZL YWZL,S.YWSR YWSR,S.JLBZ JLBZ,S.SF SF,S.SFJL SFJL,S.DETAIL DETAIL,S.VALID VALID";

		String str_From = "T_REWARDS" + " " + "S";

		// String str_Where = obj_Query.getConditions();

		String str_Where = Common.WHERE + Common.SPACE + "ROWID" + Common.EQUAL + General.addQuotes(strXML);
		// System.out.println(str_Where);
		// str_Where = General.empty(str_Where) ? Common.ORDER +
		// Field.EVENTTYPEID : str_Where + Common.S_ORDER + Field.EVENTTYPEID;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "REWID", null, null, null, 1, 1, 1, 1, 0, true, "REWARDS");
	}

	/*
	 * 功能：根据处理日期执行导入数据操作，如果导入的是同一个月的数据，则会进行覆盖。
	 */
	public static int impData(String tpl, String expdate, String fileName, StringBuffer sbMsg, UserLogonInfo userSession) {
		String sqlStr = "", sqlStr1 = "", strRtn = null;
		String sCellValue = "";
		int iCount = 0, cols = 0, rows = 0, dbFldRows = 0;
		int i = 0, j = 0, m = 0, n = 0, posDwbm = -1, posYear = -1, posMonth = -1, posSfzhm = -1;
		boolean isDwbm = false, isYear = false, isMonth = false;
		String sDwbm = "", sYear = "", sMonth = "", sDwbmFirst = "";
		int year = DateTimeUtil.getCurrentYear(), month = DateTimeUtil.getCurrentMonth();
		DataStorage dataStorage = new DataStorage();
		DBConnection dbc = new DBConnection();
		if (!General.empty(expdate)) {
			expdate = expdate.replace("-", "");
			year = Integer.parseInt(expdate.substring(0, 4));
			month = Integer.parseInt(expdate.substring(4, 6));
		}
		DecimalFormat df = new DecimalFormat("#");
		DicCache dic = DicCache.getInstance();
		// System.out.println(fileName);
		try {
			// 准备导入
			Excel excelData = new Excel(fileName);
			// 先将数据导入list中
			List<List> ll = excelData.excelToListList(0);
			// 根据模版和单位取出导入字段列表
			String sDbfld = getImpDbfldString(tpl, userSession);
			dbFldRows = sDbfld.split(",").length;
			// 取得导出的数据的日期,暂时不使用
			String sImpDate = "";
			// 判断是否含有单位编码,年度,月份等字段
			List first = ll.get(0);
			cols = first.size();
			if (dbFldRows != cols) {
				strRtn = "导入文件数据列数[" + cols + "]与本单位模版列数[" + dbFldRows + "]不一致,请检查!";
				sbMsg.append("交易失败,原因:" + strRtn);
				return -1;
			}
			if (first != null) {
				for (m = 0; m < first.size(); m++) {
					sCellValue = (String) first.get(m);
					if (sCellValue != null) {
						if (sCellValue.equals(dic.getText("DIC_DBFLD", "DWBM"))) {
							isDwbm = true;
							posDwbm = m;
						}
						if (sCellValue.equals(dic.getText("DIC_DBFLD", "YEAR"))) {
							isYear = true;
							posYear = m;
						}
						if (sCellValue.equals(dic.getText("DIC_DBFLD", "MONTH"))) {
							isMonth = true;
							posMonth = m;
						}
						if (sCellValue.equals(dic.getText("DIC_DBFLD", "SFZHM"))) {
							posSfzhm = m;
						}
						if (sCellValue.equals(dic.getText("DIC_DBFLD", "SAL1"))) {
							n = m;
						}
					}
				}
			}
			for (i = 1; i < ll.size(); i++) {
				List l = ll.get(i);
				sqlStr = "insert into t_salary_detail_ls(" + sDbfld;
				if (!isDwbm)
					sqlStr += ",dwbm";
				if (!isYear)
					sqlStr += ",year";
				if (!isMonth)
					sqlStr += ",month";
				sqlStr += ",tpl,imp_date";
				sqlStr += ") values('";
				for (j = 0; (j < l.size()) && (j < cols); j++) {
					if (l.get(j) == null)
						sqlStr += "0" + "','";
					else {
						if (j == posDwbm) {
							if ((l.get(j).toString()).contains("A"))
								sDwbm = (String) l.get(j);
							else
								sDwbm = df.format((Double) l.get(j));
							if (i == 1) {
								sDwbmFirst = sDwbm;
							} else {
								if (!(sDwbm.equals(sDwbmFirst))) {
									throw new Exception("导入文件有超过两个以上单位编码,请检查!");
								}
							}
							sqlStr += sDwbm + "','";
						} else if (j == posYear) {
							sYear = df.format((Double) l.get(j));
							sqlStr += sYear + "','";
						} else if (j == posMonth) {
							sMonth = df.format((Double) l.get(j));
							sqlStr += sMonth + "','";
						} else if (j == posSfzhm) {
							if (General.empty(l.get(j).toString().trim()) || General.empty(l.get(j).toString().trim().replaceAll("\r|\n|\t", "")))
								continue;
						}else {
							if (General.empty(l.get(j).toString().trim()) || General.empty(l.get(j).toString().trim().replaceAll("\r|\n|\t", "")))
								sqlStr += "0" + "','";
							else
								sqlStr += l.get(j) + "','";
						}
					}
				}
				while (j < cols) {
					sqlStr += "0" + "','";
					j++;
				}
				sqlStr = sqlStr.substring(0, sqlStr.length() - 2);
				if (!isDwbm)
					sqlStr += "," + General.addQuotes(userSession.getUnitID());
				if (!isYear)
					sqlStr += ",'" + year + "'";
				if (!isMonth)
					sqlStr += ",'" + month + "'";
				sqlStr += "," + General.addQuotes(tpl);
				sqlStr += ",sysdate";
				sqlStr += ")";
				//System.out.println(sqlStr);
				dataStorage.addSQL(sqlStr);
				iCount++;
			}
			// 执行导入前首先按单位编码清理临时表
			if (isDwbm) {
				sqlStr1 = "delete from t_salary_detail_ls where dwbm=" + General.addQuotes(sDwbm);
			} else {
				sqlStr1 = "delete from t_salary_detail_ls where dwbm=" + General.addQuotes(userSession.getUnitID());
			}
			dbc.excuteSql(sqlStr1);
			dbc.freeConnection();
			// 执行批量插入
			strRtn = dataStorage.runSQL();
			dataStorage.clear();
			// 导入成功以后,进行数据处理
			dbc = new DBConnection();
			Object[] para = new Object[4];
			if (isDwbm) {
				para[0] = sDwbm;
			} else {
				para[0] = userSession.getUnitID();
			}
			para[1] = tpl;
			if (isYear) {
				para[2] = sYear;
			} else {
				para[2] = Integer.toString(year);
			}
			if (isMonth) {
				para[3] = sMonth;
			} else {
				para[3] = Integer.toString(month);
			}
			Pub.executeProcedure(dbc.getConnection(), "p_upd_wage_tot", para, null);

			if (strRtn == null) {
				sbMsg.append("交易成功，共导入" + iCount + "条");
				// 刷新用户字典缓存
				dic.refresh("USERLIST");
				return 0;
			} else {
				sbMsg.append("交易失败,原因:" + strRtn);
				return -1;
			}
		} catch (Exception e) {
			sbMsg.append("交易失败,第[" + i + "]行,第[" + j + "]列,原因:" + e.toString());
			return -1;
		} finally {
			dbc.freeConnection();
		}
	}

	/*
	 * 取得应发合计
	 * 
	 * @param sSfzhm 身份证号码
	 * 
	 * @param sYear 查询年度
	 * 
	 * @param sType 工资或者奖金
	 */
	public static ArrayList getYfhj(String sSfzhm, String sYear, String sType) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		WageUser wageUser = new WageUser();
		double dYkhjTot = 0.00;
		int i, iCnt = 0;
		String strSQL = "";
		try {
			if ("1".equals(sType))
				strSQL = "select month,sal1 from t_wage_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year=" + General.addQuotes(sYear) + "order by to_number(month)";
			else if ("2".equals(sType))
				strSQL = "select month,sal1 from t_prize_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year=" + General.addQuotes(sYear) + "order by to_number(month)";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			if (rst.next()) {
				if (rst.getInt("month") > 1) {
					for (i = 1; i < rst.getInt("month"); i++) {
						al.add(0.00);
						iCnt++;
					}
				}
				al.add(rst.getDouble("sal1"));
				iCnt++;
				dYkhjTot += rst.getDouble("sal1");
			}

			while (rst.next()) {
				al.add(rst.getDouble("sal1"));
				iCnt++;
				dYkhjTot += rst.getDouble("sal1");
			}
			for (i = 0; i < 13 - iCnt; i++)
				al.add(0.00);
			al.add(dYkhjTot);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 取得应扣合计
	 * 
	 * @param sSfzhm 身份证号码
	 * 
	 * @param sYear 查询年度
	 * 
	 * @param sType 工资或者奖金
	 */
	public static ArrayList getYkhj(String sSfzhm, String sYear, String sType) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		WageUser wageUser = new WageUser();
		double dYkhjTot = 0.00;
		int i, iCnt = 0;
		String strSQL = "";
		try {
			if ("1".equals(sType))
				strSQL = "select month,sal2 from t_wage_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year=" + General.addQuotes(sYear) + "order by to_number(month)";
			else if ("2".equals(sType))
				strSQL = "select month,sal2 from t_prize_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year=" + General.addQuotes(sYear) + "order by to_number(month)";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}
			if (rst.next()) {
				if (rst.getInt("month") > 1) {
					for (i = 1; i < rst.getInt("month"); i++) {
						al.add(0.00);
						iCnt++;
					}
				}
				al.add(rst.getDouble("sal2"));
				iCnt++;
				dYkhjTot += rst.getDouble("sal2");
			}

			while (rst.next()) {
				al.add(rst.getDouble("sal2"));
				iCnt++;
				dYkhjTot += rst.getDouble("sal2");
			}
			for (i = 0; i < 13 - iCnt; i++)
				al.add(0.00);
			al.add(dYkhjTot);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 取得实发合计
	 * 
	 * @param sSfzhm 身份证号码
	 * 
	 * @param sYear 查询年度
	 * 
	 * @param sType 工资或者奖金
	 */
	public static ArrayList getSfhj(String sSfzhm, String sYear, String sType) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		WageUser wageUser = new WageUser();
		double dYkhjTot = 0.00;
		int i, iCnt = 0;
		String strSQL = "";
		try {
			if ("1".equals(sType))
				strSQL = "select month,sal3 from t_wage_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year=" + General.addQuotes(sYear) + "order by to_number(month)";
			else if ("2".equals(sType))
				strSQL = "select month,sal3 from t_prize_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year=" + General.addQuotes(sYear) + "order by to_number(month)";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}
			if (rst.next()) {
				if (rst.getInt("month") > 1) {
					for (i = 1; i < rst.getInt("month"); i++) {
						al.add(0.00);
						iCnt++;
					}
				}
				al.add(rst.getDouble("sal3"));
				iCnt++;
				dYkhjTot += rst.getDouble("sal3");
			}

			while (rst.next()) {
				al.add(rst.getDouble("sal3"));
				iCnt++;
				dYkhjTot += rst.getDouble("sal3");
			}
			for (i = 0; i < 13 - iCnt; i++)
				al.add(0.00);
			al.add(dYkhjTot);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 查询薪酬的可查询年度
	 * 
	 * @param sTpl 模版
	 */
	public static ArrayList getCxnd(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select year||'年' cxnd from t_salary_detail where tpl=" + General.addQuotes(sTpl) + " and sfzhm=" + General.addQuotes(userSession.getIDCard()) + " group by year order by to_number(year) desc";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("getCxnd:获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getString("cxnd"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 查询工资的可查询年度月份
	 * 
	 * @param sType
	 */
	public static ArrayList getCxndyf(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select year||'年'||month||'月' cxnd from t_salary_detail where tpl=" + General.addQuotes(sTpl) + " and sfzhm=" + General.addQuotes(userSession.getIDCard()) + " group by year,month order by to_number(year) desc,to_number(month) desc";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getString("cxnd"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 取得工资发放明细
	 * 
	 * @param sSfzhm 身份证号码
	 * 
	 * @param sYear 查询年度月份
	 */
	public static ArrayList getWageDetail(String sSfzhm, String sYear) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		WageUser wageUser = new WageUser();
		int i, iCnt = 0;
		try {
			String strSQL = "select * from t_wage_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year||month=" + General.addQuotes(sYear) + "order by to_number(year||month)";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);
			ResultSetMetaData rsMetaData = rst.getMetaData();

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				for (i = 1; i < rsMetaData.getColumnCount(); i++) {
					al.add(rst.getObject(i));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 取得月奖发放明细
	 * 
	 * @param sSfzhm 身份证号码
	 * 
	 * @param sYear 查询年度月份
	 */
	public static ArrayList getPrizeDetail(String sSfzhm, String sYear) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		WageUser wageUser = new WageUser();
		int i, iCnt = 0;
		try {
			String strSQL = "select * from t_prize_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year||month=" + General.addQuotes(sYear) + "order by to_number(year||month)";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);
			ResultSetMetaData rsMetaData = rst.getMetaData();

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				for (i = 1; i < rsMetaData.getColumnCount(); i++) {
					al.add(rst.getObject(i));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/***************************************************************************
	 * 设置用户口令
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 **************************************************************************/
	public static String modPasswd(String strXml) throws Exception {
		Document document = PageCommon.getDefaultXML();
		String nodePath = Common.XDOC_ROOT;
		XmlFunc.setNodeDOM(document, nodePath, strXml);
		DataDoc doc = new DataDoc(document.asXML());
		// 创建执行对象
		DataStorage storage = new DataStorage();
		Element ele = (Element) doc.getDataNode("USERLIST", 0);
		Node node = ele.selectSingleNode("USERPASSWORD");
		node.setText(Encrypt.e(node.getText()));
		// System.out.println(ele.asXML());
		// 解析sql语句
		storage.addSQL(SQLAnalyse.analyseXMLSQL(ele.asXML()));
		// 执行
		String strReturn = storage.runSQL();
		ReturnDoc returndoc = new ReturnDoc();
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		return returndoc.getXML();
	}

	/***************************************************************************
	 * 查询工资列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String wageDetailList(String strXML, WageUser user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "DWMC,BMMC,YEAR,RYLB,MONTH,SFZHM,NAME,SAL1,SAL2,SAL3,SAL4,SAL5,SAL6,SAL7,SAL8,SAL9,SAL10,SAL11,SAL12,SAL13,SAL14,SAL15,SAL16,SAL17,SAL18,SAL19,SAL20,SAL21,SAL22,SAL23,SAL24,SAL25,SAL26,SAL27,SAL28,SAL29,SAL30,SAL31,SAL32,SAL33,SAL34,SAL35,SAL36,SAL37,SAL38,SAL39,SAL40,SAL41,SAL42,SAL43,SAL44,SAL45,SAL46,SAL47,SAL48,SAL49,SAL50,MESG,REMARK,SEE_DT,SEE_TM";

		String str_From = "T_WAGE_DETAIL S";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// System.out.println(str_Where);
		// 按照登录用户的身份证号获取记录
		// str_Where =
		// Common.WHERE+"SFZHM="+General.addQuotes(user.getIDCard());
		// 根据保险代码获取记录
		// str_Where = Common.WHERE + "BXDM=" +
		// General.addQuotes(user.getBxdm());
		// str_Where = General.empty(str_Where) ? Common.ORDER +
		// Field.EVENTTYPEID : str_Where + Common.S_ORDER + Field.EVENTTYPEID;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "YEAR,MONTH DESC", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/***************************************************************************
	 * 查询月奖列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String prizeDetailList(String strXML, WageUser user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "DWMC,BMMC,YEAR,RYLB,MONTH,SFZHM,NAME,SAL1,SAL2,SAL3,SAL4,SAL5,SAL6,SAL7,SAL8,SAL9,SAL10,SAL11,SAL12,SAL13,SAL14,SAL15,SAL16,SAL17,SAL18,SAL19,SAL20,SAL21,SAL22,SAL23,SAL24,SAL25,SAL26,SAL27,SAL28,SAL29,SAL30,SAL31,SAL32,SAL33,SAL34,SAL35,SAL36,SAL37,SAL38,SAL39,SAL40,SAL41,SAL42,SAL43,SAL44,SAL45,SAL46,SAL47,SAL48,SAL49,SAL50,MESG,REMARK,SEE_DT,SEE_TM";

		String str_From = "T_PRIZE_DETAIL S";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// System.out.println(str_Where);
		// 按照登录用户的身份证号获取记录
		// str_Where =
		// Common.WHERE+"SFZHM="+General.addQuotes(user.getIDCard());
		// 根据保险代码获取记录
		// str_Where = Common.WHERE + "BXDM=" +
		// General.addQuotes(user.getBxdm());
		// str_Where = General.empty(str_Where) ? Common.ORDER +
		// Field.EVENTTYPEID : str_Where + Common.S_ORDER + Field.EVENTTYPEID;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "YEAR,MONTH DESC", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/***************************************************************************
	 * 更新相关费用说明
	 * 
	 * @param strXML
	 *            XML 数据文档
	 * @param user
	 *            登录用户
	 * @return string
	 **************************************************************************/
	public static String updCostMaintain(String strXML, UserLogonInfo user) throws Exception {
		Document doc = DocumentHelper.parseText(strXML);
		String sDwbm = XmlFunc.getNodeValue(doc, "//DWBM");
		String sTpl = XmlFunc.getNodeValue(doc, "//TPL");
		String sSfzhm = XmlFunc.getNodeValue(doc, "//SFZHM");
		String sType = XmlFunc.getNodeValue(doc, "//TYPE");
		String sMesg = XmlFunc.getNodeValue(doc, "//REMARK");
		String sYear = XmlFunc.getNodeValue(doc, "//YEAR");
		String sMonth = XmlFunc.getNodeValue(doc, "//MONTH");
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		DataStorage obj_Storage = new DataStorage();
		String strSQL = "";
		try {
			if ("1".equals(sType)) {
				strSQL = "update t_salary_detail set remark=" + General.addQuotes(sMesg) + " where year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth) + " and sfzhm=" + General.addQuotes(sSfzhm);
				if (!General.empty(sTpl)) {
					strSQL += " and tpl=" + General.addQuotes(sTpl);
				}
				if (!General.empty(sDwbm)) {
					strSQL += " and dwbm=" + General.addQuotes(sDwbm);
				}
			} else if ("2".equals(sType)) {
				strSQL = "update t_salary_detail set remark=" + General.addQuotes(sMesg) + " where year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth);
				if (!General.empty(sTpl)) {
					strSQL += " and tpl=" + General.addQuotes(sTpl);
				}
				if (!General.empty(sDwbm)) {
					strSQL += " and dwbm in " + sDwbm;
				}
			}
			obj_Storage.addSQL(strSQL);
			String str_Return = obj_Storage.runSQL();
			if (!General.empty(str_Return)) {
				obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
				obj_ReturnDoc.setFuncErrorInfo(str_Return);
			} else {
				obj_ReturnDoc.addErrorResult(Common.RT_SUCCESS);
			}
		} catch (Exception e) {
			obj_ReturnDoc.addErrorResult(Common.RT_FUNCERROR);
			obj_ReturnDoc.setFuncErrorInfo(e.getMessage());
		}
		return obj_ReturnDoc.getXML();
	}

	/***************************************************************************
	 * 用户列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String wageUserList(String strXML, WageUser user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "DWMC,BMMC,SFZHM,NAME,FLAG,LST_LOG_DT,LST_LOG_TM";

		String str_From = "T_WAGE_USER S";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// System.out.println(str_Where);
		// 按照登录用户的身份证号获取记录
		// str_Where =
		// Common.WHERE+"SFZHM="+General.addQuotes(user.getIDCard());
		// 根据保险代码获取记录
		// str_Where = Common.WHERE + "BXDM=" +
		// General.addQuotes(user.getBxdm());
		// str_Where = General.empty(str_Where) ? Common.ORDER +
		// Field.EVENTTYPEID : str_Where + Common.S_ORDER + Field.EVENTTYPEID;

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "DWMC,BMMC DESC", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/***************************************************************************
	 * 初始化用户密码
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 **************************************************************************/
	public static String initPasswd(String strXml) throws Exception {
		Document doc = DocumentHelper.parseText(strXml);
		// 创建执行对象
		DataStorage storage = new DataStorage();
		// 解析sql语句
		Element ele = (Element) doc.selectSingleNode("//T_WAGE_USER");
		storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
		// 执行
		String strReturn = storage.runSQL();
		ReturnDoc returndoc = new ReturnDoc();
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		return returndoc.getXML();
	}

	/*
	 * 取得收入合计
	 * 
	 * @param sSfzhm 身份证号码
	 */
	public static ArrayList getSrhjTot(String sYear) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		double dYfhjWageTot = 0.00;
		double dYfhjPrizeTot = 0.00;
		double dWxyjTot = 0.00;
		String strSQL = "";
		try {
			strSQL = "select bmmc,name,sfzhm from t_wage_user";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				dYfhjWageTot = 0.00;
				dYfhjPrizeTot = 0.00;
				dWxyjTot = 0.00;
				Map map = new HashMap();
				map.put("bmmc", rst.getString("bmmc"));
				map.put("name", rst.getString("name"));
				map.put("sfzhm", rst.getString("sfzhm"));
				ArrayList al1 = new ArrayList();
				for (int i = 1; i < 14; i++) {
					ArrayList al2 = getSrhj(rst.getString("sfzhm"), sYear, new Integer(i).toString());
					for (int j = 0; j < al2.size(); j++) {
						al1.add(al2.get(j));
					}
					dYfhjWageTot += (Double) al2.get(0);
					dYfhjPrizeTot += (Double) al2.get(1);
					dWxyjTot += (Double) al2.get(2);
				}
				al1.add(dYfhjWageTot);
				al1.add(dYfhjPrizeTot);
				al1.add(dWxyjTot);
				map.put("arrlist", al1);
				al.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 取得收入合计
	 * 
	 * @param sSfzhm 身份证号码
	 */
	public static ArrayList getSrhj(String sSfzhm, String sYear, String sMonth) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		double dYfhjWage = 0.00;
		double dYfhjPrize = 0.00;
		double dWxyj = 0.00;
		String strSQL = "";
		try {
			strSQL = "select month,sal1,sal18 from v_wage_tot where sfzhm=" + General.addQuotes(sSfzhm) + " and year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth) + " order by to_number(month),sal18 desc";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				if ("13".equals(rst.getString("month"))) {
					dYfhjWage = 0.00;
					dYfhjPrize = rst.getDouble("sal1");
					dWxyj = 0.00;
				} else {
					if (rst.getDouble("sal18") == -1) {
						dYfhjPrize = rst.getDouble("sal1");
					} else {
						dYfhjWage = rst.getDouble("sal1");
						dWxyj = rst.getDouble("sal18");
					}
				}
			}
			al.add(dYfhjWage);
			al.add(dYfhjPrize);
			al.add(dWxyj);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名获取数据库字段
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sYear 年份
	 * 
	 * @param sMonth 月份
	 * 
	 * @param userSession 当前用户
	 */
	public static String getHisDbfld(String sTpl, String sYear, String sMonth, UserLogonInfo userSession) {
		String strDbfld = "[]";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select dbfld from t_unit_tpl_his where tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + " and year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth);
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				strDbfld = rst.getString("dbfld");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strDbfld;
	}

	/*
	 * 根据模版名获取字段值为0的数据库字段
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sYear 年份
	 * 
	 * @param sMonth 月份
	 * 
	 * @param userSession 当前用户
	 */
	public static String getZeroDbfld(String sTpl, String sYear, String sMonth, UserLogonInfo userSession) {
		String strDbfld = "[";
		String strField = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		int i = 0;
		try {
			strSQL = "select * from t_salary_detail where sfzhm=" + General.addQuotes(userSession.getIDCard());
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTpl);
			if (!General.empty(sYear))
				strSQL += " and year=" + General.addQuotes(sYear);
			if (!General.empty(sMonth))
				strSQL += " and month=" + General.addQuotes(sMonth);
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			ResultSetMetaData rstmd = rst.getMetaData();
			int iColCount = rstmd.getColumnCount();
			while (rst.next()) {
				for (i = 1; i <= iColCount; i++) {
					strField = rst.getString(i);
					if (!General.empty(strField) && strField.equals("0")) {
						if (strDbfld.indexOf(rstmd.getColumnName(i)) == -1) {
							strDbfld += "\"" + rstmd.getColumnName(i) + "\",";
						}
					}
				}
			}
			if (!General.empty(strDbfld) && strDbfld.length() > 1) {
				strDbfld = strDbfld.substring(0, strDbfld.length() - 1) + "]";
			} else {
				strDbfld = strDbfld + "]";
			}
			// System.out.println(strDbfld);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strDbfld;
	}

	/*
	 * 根据模版名获取需要显示的字段值的数据库字段
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sYear 年份
	 * 
	 * @param sMonth 月份
	 * 
	 * @param userSession 当前用户
	 */
	public static String getNoZeroDbfld(String sTpl, String sYear, String sMonth, UserLogonInfo userSession) {
		String strDbfld = "[";
		String strField = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		int i = 0;
		try {
			strSQL = "select * from t_salary_detail where sfzhm=" + General.addQuotes(userSession.getIDCard());
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTpl);
			if (!General.empty(sYear))
				strSQL += " and year=" + General.addQuotes(sYear);
			if (!General.empty(sMonth))
				strSQL += " and month=" + General.addQuotes(sMonth);
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			ResultSetMetaData rstmd = rst.getMetaData();
			int iColCount = rstmd.getColumnCount();
			while (rst.next()) {
				for (i = 1; i <= iColCount; i++) {
					strField = rst.getString(i);
					if (!General.empty(strField)) {
						if (!(strField.equals("0"))) {
							if (strDbfld.indexOf("\"" + rstmd.getColumnName(i) + "\"") == -1) {
								strDbfld += "\"" + rstmd.getColumnName(i) + "\",";
							}
						}
					}
				}
			}
			if (!General.empty(strDbfld) && strDbfld.length() > 1) {
				strDbfld = strDbfld.substring(0, strDbfld.length() - 1) + "]";
			} else {
				strDbfld = strDbfld + "]";
			}
			// System.out.println(strDbfld);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strDbfld;
	}

	/*
	 * 根据模版名获取数据库字段显示名称
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sYear 年份
	 * 
	 * @param sMonth 月份
	 * 
	 * @param userSession 当前用户
	 */
	public static String getHisFldname(String sTpl, String sYear, String sMonth, UserLogonInfo userSession) {
		String strFldname = "[]";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select fldname from t_unit_tpl_his where tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + " and year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				strFldname = rst.getString("fldname");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strFldname;
	}

	/*
	 * 根据模版名获取数据库字段显示宽度
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sYear 年份
	 * 
	 * @param sMonth 月份
	 * 
	 * @param userSession 当前用户
	 */
	public static String getHisFldwidth(String sTpl, String sYear, String sMonth, UserLogonInfo userSession) {
		String strFldwidth = "[]";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select fldwidth from t_unit_tpl_his where tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + " and year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				strFldwidth = rst.getString("fldwidth");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strFldwidth;
	}

	/*
	 * 根据模版名获取当前数据库字段
	 * 
	 * @param sTpl 模版名
	 */
	public static ArrayList getCurDbfld(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select dbfld from v_unit_tpl where flag='1' and tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + "order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getString("dbfld"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名获取当前数据库字段字符串
	 * 
	 * @param sTpl 模版名
	 */
	public static String getImpDbfldString(String sTpl, UserLogonInfo userSession) {
		String sDbfld = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select dbfld from v_unit_tpl where flag='1' and impflag='1' and tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + "order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				sDbfld += rst.getString("dbfld") + ",";
			}
			// System.out.println(sDbfld);
			sDbfld = sDbfld.substring(0, sDbfld.length() - 1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return sDbfld;
	}

	/*
	 * 根据模版名获取当前数据库字段名称
	 * 
	 * @param sTpl 模版名
	 */
	public static ArrayList getCurFldname(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select fldname from v_unit_tpl where flag='1' and tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + "order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getString("fldname"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名获取当前数据库字段宽度
	 * 
	 * @param sTpl 模版名
	 */
	public static ArrayList getCurFldwidth(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select fldwidth from v_unit_tpl where flag='1' and tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + "order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getInt("fldwidth"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名和字段名获取工资或奖金的应发、应扣和实发
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sDbfld 字段名
	 */
	public static ArrayList getSumFldvalue(String sSum, String sYear, String sTpl, String sTplDetail, String sMonth, String sSfzhm) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select sum(" + sSum + ") from t_salary_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year=" + General.addQuotes(sYear) + " and month=" + General.addQuotes(sMonth.substring(1));
			if (!"salarytottpl".equalsIgnoreCase(sTpl) && !General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTplDetail);
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			if (rst.next()) {
				al.add(rst.getDouble(1));
			} else {
				al.add(0.00);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名、查询年度和种类获取统计数据
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sDbfld 字段名
	 */
	public static String getTotal(String sTpl, String sTplDetail, String sCxnd, UserLogonInfo userSession) {
		String sDbfld = "";
		String sFldname = "";
		DecimalFormat df = new DecimalFormat("##.00");

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select dbfld,fldname from v_unit_tpl where flag='1' and dbfld like 'SUM%' and tpl=" + General.addQuotes(sTplDetail) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + " order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);
			ReturnDoc rtnDoc = new ReturnDoc();
			// 创建数据返回节点
			if (!rtnDoc.createDataInfoNode()) {
				throw new Exception("GzcxBO.getTotal.创建数据返回节点时发生错误");
			}

			if (rst == null) {
				throw new Exception("getTotal:获取数据失败");
			}

			while (rst.next()) {
				sDbfld = rst.getString("dbfld");
				sFldname = rst.getString("fldname");
				Element ele = getSum(sDbfld, sFldname, sTpl, sTplDetail, sCxnd, userSession);
				rtnDoc.addNodeToDataInfo(ele);
			}
			Document doc = rtnDoc.getDocument();
			Element element = (Element) doc.selectSingleNode("//DATAINFO");
			return element.asXML();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return null;
	}

	public static Element getSum(String sSum, String sSumName, String sTpl, String sTplDetail, String sCxnd, UserLogonInfo userSession) {
		String sDbfld = "";
		double dTot = 0.00;
		Element ele = null;
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		DicCache dicCache = DicCache.getInstance();
		DecimalFormat df = new DecimalFormat("##.00");

		// 根据sSum取单行记录
		ele = DocumentHelper.createElement("ROW");
		String strSQL = "";
		try {
			strSQL = "select dbfld,fldname from v_unit_tpl where flag='1' and dwbm=" + General.addQuotes(userSession.getUnitID());
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTpl);
			strSQL += " order by fldord";
			rst = dbc.excuteQuery(strSQL);
			if (rst == null) {
				throw new Exception("getSum:获取数据失败");
			}

			while (rst.next()) {
				sDbfld = rst.getString("dbfld");
				if ("PRJ".equalsIgnoreCase(sDbfld)) {
					Element elePrj = DocumentHelper.createElement("PRJ");
					elePrj.setText(sSumName);
					ele.add(elePrj);
				} else if ("TOT".equalsIgnoreCase(sDbfld)) {
					Element eleTot = DocumentHelper.createElement("TOT");
					eleTot.setText(df.format(dTot));
					ele.add(eleTot);
				} else {
					ArrayList al = getSumFldvalue(sSum, sCxnd, sTpl, sTplDetail, sDbfld, userSession.getIDCard());
					Element eleTmp = DocumentHelper.createElement(sDbfld);
					eleTmp.setText(al.get(0).toString());
					ele.add(eleTmp);
					dTot = dTot + (Double) al.get(0);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}

		return ele;
	}

	/*
	 * 根据模版名、查询年度和种类获取统计数据
	 * 
	 * @param map 参数
	 * 
	 * @param userSession 登录用户信息
	 */
	public static String getTotalAll(Map map, UserLogonInfo userSession) {
		String sDbfld = "";
		String sFldname = "";
		String sTpl = (String) map.get("TPL");
		String sTplDetail = (String) map.get("TPLDETAIL");
		String sYear = (String) map.get("YEAR");
		String sMonth = (String) map.get("MONTH");
		String sSfzhm = (String) map.get("SFZHM");
		String sDwbm = (String) map.get("DWBM");
		String sName = (String) map.get("NAME");
		DecimalFormat df = new DecimalFormat("##.00");

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select dbfld,fldname,fldord from v_unit_tpl where flag='1' and dbfld like 'SUM%'";
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTplDetail);
			if (!General.empty(sDwbm))
				strSQL += " and dwbm in " + sDwbm;
			strSQL += " group by dbfld,fldname,fldord order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);
			ReturnDoc rtnDoc = new ReturnDoc();
			// 创建数据返回节点
			if (!rtnDoc.createDataInfoNode()) {
				throw new Exception("GzcxBO.getTotal.创建数据返回节点时发生错误");
			}

			if (rst == null) {
				throw new Exception("getTotal:获取数据失败");
			}

			while (rst.next()) {
				sDbfld = rst.getString("dbfld");
				sFldname = rst.getString("fldname");
				Element ele = getSumAll(sDbfld, sFldname, map);
				rtnDoc.addNodeToDataInfo(ele);
			}
			Document doc = rtnDoc.getDocument();
			Element element = (Element) doc.selectSingleNode("//DATAINFO");
			return element.asXML();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return null;
	}

	public static Element getSumAll(String sSum, String sSumName, Map map) {
		String sDbfld = "";
		String sTpl = (String) map.get("TPL");
		String sTplDetail = (String) map.get("TPLDETAIL");
		String sYear = (String) map.get("YEAR");
		String sMonth = (String) map.get("MONTH");
		String sSfzhm = (String) map.get("SFZHM");
		String sDwbm = (String) map.get("DWBM");
		String sName = (String) map.get("NAME");
		double dTot = 0.00;
		Element ele = null;
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		DicCache dicCache = DicCache.getInstance();
		DecimalFormat df = new DecimalFormat("##.00");

		// 根据sSum取单行记录
		ele = DocumentHelper.createElement("ROW");
		String strSQL = "";
		try {
			strSQL = "select dbfld,fldname,fldord from v_unit_tpl where flag='1'";
			if (!General.empty(sDwbm))
				strSQL += " and dwbm in " + sDwbm;
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTpl);
			strSQL += " group by dbfld,fldname,fldord order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);
			if (rst == null) {
				throw new Exception("getSum:获取数据失败");
			}

			while (rst.next()) {
				sDbfld = rst.getString("dbfld");
				if ("PRJ".equalsIgnoreCase(sDbfld)) {
					Element elePrj = DocumentHelper.createElement("PRJ");
					elePrj.setText(sSumName);
					ele.add(elePrj);
				} else if ("TOT".equalsIgnoreCase(sDbfld)) {
					Element eleTot = DocumentHelper.createElement("TOT");
					eleTot.setText(df.format(dTot));
					ele.add(eleTot);
				} else {
					ArrayList al = getSumFldvalueAll(sSum, sDbfld, map);
					Element eleTmp = DocumentHelper.createElement(sDbfld);
					eleTmp.setText(df.format((Double)al.get(0)));
					ele.add(eleTmp);
					dTot = dTot + (Double) al.get(0);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}

		return ele;
	}

	/*
	 * 根据模版名和字段名获取工资或奖金的应发、应扣和实发
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sDbfld 字段名
	 */
	public static ArrayList getSumFldvalueAll(String sSum, String sDbfld, Map map) {
		ArrayList al = new ArrayList();
		String sTpl = (String) map.get("TPL");
		String sTplDetail = (String) map.get("TPLDETAIL");
		String sYear = (String) map.get("YEAR");
		String sMonth = (String) map.get("MONTH");
		String sSfzhm = (String) map.get("SFZHM");
		String sDwbm = (String) map.get("DWBM");
		String sName = (String) map.get("NAME");

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select sum(" + sSum + ") from t_salary_detail where month=" + General.addQuotes(sDbfld.substring(1));
			if (!General.empty(sDwbm))
				strSQL += " and dwbm in " + sDwbm;
			if (!"salarytottpl".equalsIgnoreCase(sTpl) && !General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTplDetail);
			if (!General.empty(sYear))
				strSQL += " and year=" + General.addQuotes(sYear);
			if (!General.empty(sSfzhm))
				strSQL += " and sfzhm=" + General.addQuotes(sSfzhm);
			if (!General.empty(sName))
				strSQL += " and name like '%" + sName + "%'";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			if (rst.next()) {
				al.add(rst.getDouble(1));
			} else {
				al.add(0.00);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名和字段名获取字段值
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sDbfld 字段名
	 */
	public static ArrayList getDbfldvalue(String sTpl, String sDbfld, String sCxnd, String sSfzhm) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select " + sDbfld + " from t_salary_detail where sfzhm=" + General.addQuotes(sSfzhm) + " and year||month=" + General.addQuotes(sCxnd);
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			if (rst.next()) {
				al.add(rst.getString(sDbfld));
			} else {
				al.add("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名、查询年度和种类获取明细数据
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param sDbfld 字段名
	 */
	public static String getDetail(String sTpl, String sCxnd, String sSfzhm, String sType) {
		String sDbfld = "";
		Map map1 = new HashMap();
		Map map2 = new HashMap();
		Map map3 = new HashMap();
		double dYftot = 0.00;
		double dYktot = 0.00;
		double dSftot = 0.00;
		DecimalFormat df = new DecimalFormat("##.00");

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select dbfld,fldname from v_unit_tpl where flag='1' and tpl=" + General.addQuotes(sTpl) + " order by fldord";

			rst = dbc.excuteQuery(strSQL);
			ReturnDoc rtnDoc = new ReturnDoc();
			// 创建数据返回节点
			if (!rtnDoc.createDataInfoNode()) {
				throw new Exception("GzcxBO.getDetail.创建数据返回节点时发生错误");
			}

			Element ele1 = null;
			if (rst == null) {
				throw new Exception("getTotal:获取数据失败");
			}

			ele1 = DocumentHelper.createElement("ROW");
			while (rst.next()) {
				sDbfld = rst.getString("dbfld");
				ArrayList al = getDbfldvalue(sTpl, sDbfld, sCxnd, sSfzhm);
				Element ele2 = DocumentHelper.createElement(sDbfld);
				if (al.get(0) != null) {
					ele2.setText(al.get(0).toString());
				} else {
					ele2.setText("");
				}
				ele1.add(ele2);
			}
			rtnDoc.addNodeToDataInfo(ele1);
			Document doc = rtnDoc.getDocument();
			Element element = (Element) doc.selectSingleNode("//DATAINFO");
			return element.asXML();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return null;
	}

	/***************************************************************************
	 * 模版列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String tplList(String strXML, UserLogonInfo user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "*";

		String str_From = "V_TPL";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// System.out.println(str_Where);

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "TPL,FLDORD", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询模版的详细信息
	 * 
	 * @param sPid
	 * 
	 * 
	 * @return XML 标准查询返回结构
	 */
	public static String tplDetail(String sPid, UserLogonInfo user) throws Exception {
		String str_Select = "*";

		String str_From = "V_TPL" + Common.SPACE;

		String str_Where = Common.WHERE + Common.SPACE + "PID" + Common.EQUAL + General.addQuotes(sPid);
		// System.out.println(str_Where);
		String[] str_DateList = {};
		String[] str_DateTimeList = {};

		String requery = CommonQuery.basicListQuery(str_Select, str_From, str_Where, "", null, null, str_DateList, str_DateTimeList, 1, 1, 1, 1, 0, true, "T_TPL");

		return requery;
	}

	/**
	 * 工资模版定义增删改
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String dealWithXmlTpl(String strXml, UserLogonInfo user) throws Exception {
		// 增加<efsframe>标准头
		Document document = PageCommon.getDefaultXML();
		String nodePath = Common.XDOC_ROOT;
		XmlFunc.setNodeDOM(document, nodePath, strXml);
		// 处理XML
		DataDoc doc = new DataDoc(document.asXML());
		// 创建数据层执行对象
		DataStorage storage = new DataStorage();
		// 创建标准返回结构Dom类对象
		ReturnDoc returndoc = new ReturnDoc();
		String strId = "";
		try {
			int size = doc.getDataNum("T_TPL");

			// 解析sql语句
			for (int i = 0; i < size; i++) {
				Element ele = (Element) doc.getDataNode("T_TPL", i);
				// System.out.println(SQLAnalyse.analyseXMLSQL(ele));
				storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));
			}
			// 执行SQL
			String strReturn = storage.runSQL();
			if (!General.empty(strReturn)) {
				// 执行失败，返回异常描述
				returndoc.addErrorResult(Common.RT_FUNCERROR);
				returndoc.setFuncErrorInfo(strReturn);
			} else
				// 执行成功，返回成功节点
				returndoc.addErrorResult(Common.RT_SUCCESS);
		} catch (Exception e) {
			// 发生异常，返回异常描述
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(e.getMessage());
		}
		// 标准的返回XML结构文档
		return returndoc.getXML();
	}

	/**
	 * 返回工资模版字典xml字符串
	 * 
	 * @param strXml
	 * @throws SQLException
	 */
	public static String dicTpl(String strXml) {
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strRtn = "";
		try {
			Document domresult = DocumentFactory.getInstance().createDocument();
			Element root = domresult.addElement("data");
			SpellCache spellcache = SpellCache.getInstance();
			rst = dbc.excuteQuery("select tpl,tplname from t_tpl group by tpl,tplname order by tplname");
			while (rst.next()) {
				String sCode = rst.getString(1);
				String sText = rst.getString(2);

				String spell = spellcache.getSpell(sText);
				String aspell = spellcache.getASpell(sText);
				Element elerow = DocumentHelper.createElement(Common.XML_PROP_ROW);
				elerow.addAttribute(Field.DIC_CODE, sCode);
				elerow.addAttribute(Field.DIC_TEXT, sText);
				elerow.addAttribute(Field.DIC_SPELL, spell);
				elerow.addAttribute(Field.DIC_ASPELL, aspell);
				root.add(elerow);
			}
			rst.close();
			dbc.freeConnection();
			strRtn = domresult.asXML();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strRtn;
	}

	/***************************************************************************
	 * 数据库字段列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String dbfldList(String strXML, UserLogonInfo user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "*";

		String str_From = "T_DBFLD";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// System.out.println(str_Where);

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询模版的详细信息
	 * 
	 * @param sRid
	 * 
	 *            txtAcc_input
	 * @return XML 标准查询返回结构
	 */
	public static String dbfldDetail(String sPid, UserLogonInfo user) throws Exception {
		String str_Select = "*";

		String str_From = "T_DBFLD" + Common.SPACE;

		String str_Where = Common.WHERE + Common.SPACE + "PID" + Common.EQUAL + General.addQuotes(sPid);
		// System.out.println(str_Where);
		String[] str_DateList = {};
		String[] str_DateTimeList = {};

		String requery = CommonQuery.basicListQuery(str_Select, str_From, str_Where, "", null, null, str_DateList, str_DateTimeList, 1, 1, 1, 1, 0, true, "T_DBFLD");

		return requery;
	}

	/**
	 * 根据传入参数创建数据字典
	 * 
	 * @param sDicName
	 * @param sTableName
	 * @return XML 标准结果返回结构
	 */
	public static String createDicFile(String sDicName, String sTableName) {
		String sSQL = "";
		String strReturn = "";
		String strRetXml = "";
		try {
			if (sTableName.equalsIgnoreCase("T_DBFLD")) {
				sSQL = "select dbfld,fldname from " + sTableName + " where fldname is not null";
				General.createDicFileSQL(sSQL, sDicName);
			} else {
				strReturn = "表名不存在";
			}
		} catch (Exception e) {
			strReturn = e.getMessage();
		} finally {
			try {
				ReturnDoc returndoc = new ReturnDoc();
				if (!General.empty(strReturn)) {
					returndoc.addErrorResult(Common.RT_FUNCERROR);
					returndoc.setFuncErrorInfo(strReturn);
				} else {
					returndoc.addErrorResult(Common.RT_SUCCESS);
				}
				strRetXml = returndoc.getXML();
			} catch (Exception e) {

			}
			return strRetXml;
		}
	}

	/***************************************************************************
	 * 单位模版列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String unitTplList(String strXML, UserLogonInfo user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "*";

		String str_From = "V_UNIT_TPL";

		String str_Where = obj_Query.getConditions();

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// System.out.println(str_Where);

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "TPL,FLDORD", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/**
	 * 查询模版的详细信息
	 * 
	 * @param sPid
	 * 
	 * 
	 * @return XML 标准查询返回结构
	 */
	public static String unitTplDetail(String sPid, UserLogonInfo user) throws Exception {
		String str_Select = "*";

		String str_From = "V_UNIT_TPL" + Common.SPACE;

		String str_Where = Common.WHERE + Common.SPACE + "PID" + Common.EQUAL + General.addQuotes(sPid);
		// System.out.println(str_Where);
		String[] str_DateList = {};
		String[] str_DateTimeList = {};

		String requery = CommonQuery.basicListQuery(str_Select, str_From, str_Where, "", null, null, str_DateList, str_DateTimeList, 1, 1, 1, 1, 0, true, "T_TPL");

		return requery;
	}

	/***************************************************************************
	 * 可供选择的模版列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String chooseTplList(Map<String, Object> map, UserLogonInfo user) throws Exception {

		QueryDoc obj_Query = new QueryDoc((String) map.get("txtXML"));
		Element ele_Condition = obj_Query.getCondition();

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "*";

		String str_From = "V_TPL";

		String str_Where = obj_Query.getConditions();

		// 组合条件
		String sTj = " flag='1' and tpl=" + General.addQuotes((String) map.get("tpl")) + " and pid not in (select tplpid from t_unit_tpl where dwbm=" + General.addQuotes((String) map.get("dwbm")) + ")";

		// 构建标准的查询条件
		str_Where = General.empty(str_Where) ? sTj : str_Where + " AND" + sTj;

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;
		// System.out.println(str_Where);

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, "TPL,FLDORD", null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}

	/***************************************************************************
	 * 创建grid所需信息
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return json
	 **************************************************************************/
	public static String createGridJson(String sTpl, String sCxnd, String sZeroFlag, UserLogonInfo userSession) {
		String strSQL = "";
		int iSalCount = 0;
		Map<String, String> map = new HashMap<String, String>();
		String sYear = sCxnd.substring(0, 4);
		String sMonth = sCxnd.substring(4, sCxnd.length());
		// 多条语句执行
		DataStorage ds = new DataStorage();
		iSalCount = getSalaryCount(sTpl, sYear, sMonth, userSession);
		if (iSalCount > 1 || Integer.parseInt(sYear)<2013) {
			map.put("nodeAry", getDbfld(sTpl, userSession));
			map.put("headerAry", getFldname(sTpl, userSession));
			map.put("colmWidAry", getFldwidth(sTpl, userSession));
			if (sZeroFlag.equals("0")) {
				map.put("zeroAry", "[]");
			} else {
				map.put("zeroAry", getNoZeroDbfld(sTpl, sYear, sMonth, userSession));
			}
		} else if (iSalCount == 1) {
			// 获取月份
			if (General.empty(sMonth)) {
				sMonth = getSalaryMonth(sTpl, sYear, userSession);
			}
			map.put("nodeAry", getHisDbfld(sTpl, sYear, sMonth, userSession));
			map.put("headerAry", getHisFldname(sTpl, sYear, sMonth, userSession));
			map.put("colmWidAry", getHisFldwidth(sTpl, sYear, sMonth, userSession));
			if (sZeroFlag.equals("0")) {
				map.put("zeroAry", "[]");
			} else {
				map.put("zeroAry", getNoZeroDbfld(sTpl, sYear, sMonth, userSession));
			}
		} else {
			map.put("nodeAry", "[]");
			map.put("headerAry", "[]");
			map.put("colmWidAry", "[]");
			map.put("zeroAry", "[]");
		}
		// 更新个人查询日期时间
		strSQL = "update t_salary_detail set see_dt=TO_CHAR(SYSDATE,'YYYYMMDD'),see_tm=TO_CHAR(SYSDATE,'HH24:MI:SS') where sfzhm=" + General.addQuotes(userSession.getIDCard());
		if (!General.empty(sTpl))
			strSQL += " and tpl=" + General.addQuotes(sTpl);
		if (!General.empty(sYear))
			strSQL += " and year=" + General.addQuotes(sYear);
		if (!General.empty(sMonth))
			strSQL += " and month=" + General.addQuotes(sMonth);
		ds.addSQL(strSQL);
		ds.runSQL();
		return JSON.toJSONString(map, SerializerFeature.UseSingleQuotes).replace("'", "");
	}

	/***************************************************************************
	 * 当前创建grid所需信息
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return json
	 **************************************************************************/
	public static String createGridJsonCur(String sTpl, String sCxnd, UserLogonInfo userSession) {
		Map<String, String> map = new HashMap<String, String>();
		String sYear = sCxnd.substring(0, 4);
		ArrayList al1 = getCurDbfld(sTpl, userSession);
		ArrayList al2 = getCurFldname(sTpl, userSession);
		ArrayList al3 = getCurFldwidth(sTpl, userSession);
		String sNodeAry = "[";
		String sHeaderAry = "[";
		String sColmWidAry = "[";
		int i = 0;
		for (i = 0; i < al1.size(); i++) {
			sNodeAry += sNodeAry + "\"" + (String) al1.get(i) + "\",";
		}
		sNodeAry = sNodeAry.substring(0, sNodeAry.length() - 1) + "]";

		for (i = 0; i < al2.size(); i++) {
			sHeaderAry += sHeaderAry + "\"" + (String) al2.get(i) + "\",";
		}
		sHeaderAry = sHeaderAry.substring(0, sHeaderAry.length() - 1) + "]";

		for (i = 0; i < al3.size(); i++) {
			sColmWidAry += sColmWidAry + al3.get(i) + ",";
		}
		sColmWidAry = sColmWidAry.substring(0, sColmWidAry.length() - 1) + "]";

		map.put("nodeAry", sNodeAry);
		map.put("headerAry", sHeaderAry);
		map.put("colmWidAry", sColmWidAry);
		return JSON.toJSONString(map, SerializerFeature.UseSingleQuotes).replace("'", "");
	}

	/***************************************************************************
	 * 当前创建grid所需信息
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return json
	 **************************************************************************/
	public static String createGridJsonAll(String sTpl, UserLogonInfo userSession) {
		Map<String, String> map = new HashMap<String, String>();

		map.put("nodeAry", getAllDbfld(sTpl, userSession));
		map.put("headerAry", getAllFldname(sTpl, userSession));
		map.put("colmWidAry", getAllFldwidth(sTpl, userSession));
		return JSON.toJSONString(map, SerializerFeature.UseSingleQuotes).replace("'", "");
	}

	/*
	 * 根据模版名获取不显示的数据库字段的列表
	 * 
	 * @param sTpl 模版名
	 */
	public static ArrayList getNoShowDbfld(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();

		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select dbfld from v_tpl where showflag='0' and tpl=" + General.addQuotes(sTpl) + "order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getString("dbfld"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名获取数据库字段
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getDbfld(String sTpl, UserLogonInfo userSession) {
		String strDbfld = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select dbfld from v_tpl where flag='1' and tpl=" + General.addQuotes(sTpl) + "order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}
			strDbfld = "[";
			while (rst.next()) {
				strDbfld += "\"" + rst.getString(1) + "\",";
			}
			if (!General.empty(strDbfld))
				strDbfld = strDbfld.substring(0, strDbfld.length() - 1) + "]";

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strDbfld;
	}

	/*
	 * 根据模版名获取数据库字段显示名称
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getFldname(String sTpl, UserLogonInfo userSession) {
		String strFldname = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select fldname from v_tpl where flag='1' and tpl=" + General.addQuotes(sTpl) + "order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			strFldname = "[";
			while (rst.next()) {
				strFldname += "\"" + rst.getString(1) + "\",";
			}
			if (!General.empty(strFldname))
				strFldname = strFldname.substring(0, strFldname.length() - 1) + "]";

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strFldname;
	}

	/*
	 * 根据模版名获取数据库字段显示宽度
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getFldwidth(String sTpl, UserLogonInfo userSession) {
		String strFldwidth = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select fldwidth from v_tpl where flag='1' and tpl=" + General.addQuotes(sTpl) + "order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			strFldwidth = "[";
			while (rst.next()) {
				strFldwidth += rst.getString(1) + ",";
			}
			if (!General.empty(strFldwidth))
				strFldwidth = strFldwidth.substring(0, strFldwidth.length() - 1) + "]";

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strFldwidth;
	}

	/*
	 * 根据模版名获取工资明细记录数
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static int getSalaryCount(String sTpl, String sYear, String sMonth, UserLogonInfo userSession) {
		int iCount = 0;
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select nvl(count(*),0) cnt from t_salary_detail where sfzhm=" + General.addQuotes(userSession.getIDCard());
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTpl);
			if (!General.empty(sYear))
				strSQL += " and year=" + General.addQuotes(sYear);
			if (!General.empty(sMonth))
				strSQL += " and month=" + General.addQuotes(sMonth);
			rst = dbc.excuteQuery(strSQL);
			// System.out.println(strSQL);
			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				iCount = rst.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return iCount;
	}

	/*
	 * 根据模版名获取工资明细月份
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getSalaryMonth(String sTpl, String sYear, UserLogonInfo userSession) {
		String sMonth = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select month from t_salary_detail where sfzhm=" + General.addQuotes(userSession.getIDCard());
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTpl);
			if (!General.empty(sYear))
				strSQL += " and year=" + General.addQuotes(sYear);
			rst = dbc.excuteQuery(strSQL);
			// System.out.println(strSQL);
			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				sMonth = rst.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return sMonth;
	}

	/*
	 * 根据模版名获取数据库字段
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getAllDbfld(String sTpl, UserLogonInfo userSession) {
		String strDbfld = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select dbfld from v_tpl where tpl=" + General.addQuotes(sTpl) + "order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}
			strDbfld = "[";
			while (rst.next()) {
				strDbfld += "\"" + rst.getString(1) + "\",";
			}
			if (!General.empty(strDbfld))
				strDbfld = strDbfld.substring(0, strDbfld.length() - 1) + "]";

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strDbfld;
	}

	/*
	 * 根据模版名获取数据库字段
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static ArrayList getAllDbfldList(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select dbfld from v_tpl where tpl=" + General.addQuotes(sTpl) + "order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}
			while (rst.next()) {
				al.add(rst.getString(1));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名获取数据库字段显示名称
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getAllFldname(String sTpl, UserLogonInfo userSession) {
		String strFldname = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select fldname from v_tpl where tpl=" + General.addQuotes(sTpl) + "order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			strFldname = "[";
			while (rst.next()) {
				strFldname += "\"" + rst.getString(1) + "\",";
			}
			if (!General.empty(strFldname))
				strFldname = strFldname.substring(0, strFldname.length() - 1) + "]";

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strFldname;
	}

	/*
	 * 根据模版名获取数据库字段显示名称
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static ArrayList getAllFldnameList(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select fldname from v_tpl where tpl=" + General.addQuotes(sTpl) + "order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getString(1));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名获取数据库字段显示宽度
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getAllFldwidth(String sTpl, UserLogonInfo userSession) {
		String strFldwidth = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select fldwidth from v_tpl where tpl=" + General.addQuotes(sTpl) + "order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			strFldwidth = "[";
			while (rst.next()) {
				strFldwidth += rst.getString(1) + ",";
			}
			if (!General.empty(strFldwidth))
				strFldwidth = strFldwidth.substring(0, strFldwidth.length() - 1) + "]";

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strFldwidth;
	}

	/*
	 * 根据模版名获取数据库字段显示宽度
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static ArrayList getAllFldwidthList(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select fldwidth from v_tpl where tpl=" + General.addQuotes(sTpl) + "order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getString(1));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/*
	 * 根据模版名获取数据库字段显示宽度
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static ArrayList getSalaryData(String strXML, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		try {
			QueryDoc obj_Query = new QueryDoc(strXML);
			String sTpl = obj_Query.getConditionMap(strXML).get("TPL");
			String sYear = obj_Query.getConditionMap(strXML).get("YEAR");
			String sMonth = obj_Query.getConditionMap(strXML).get("MONTH");
			String sDwbm = obj_Query.getConditionMap(strXML).get("DWBM");
			String sSfzhm = obj_Query.getConditionMap(strXML).get("SFZHM");
			String sName = obj_Query.getConditionMap(strXML).get("NAME");

			String sDbfld = getAllDbfld(sTpl, userSession);
			String strSQL = "select " + sDbfld.substring(1, sDbfld.length() - 1).replaceAll("\"", "") + " from t_salary_detail where 1=1";
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTpl);
			if (!General.empty(sYear))
				strSQL += " and year=" + General.addQuotes(sYear);
			if (!General.empty(sMonth))
				strSQL += " and month=" + General.addQuotes(sMonth);
			if (!General.empty(sDwbm))
				strSQL += " and dwbm in " + sDwbm;
			if (!General.empty(sSfzhm))
				strSQL += " and sfzhm=" + General.addQuotes(sSfzhm);
			if (!General.empty(sName))
				strSQL += " and name like '%" + sName + "%'";

			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}
			int colCount = rst.getMetaData().getColumnCount();
			while (rst.next()) {
				ArrayList list = new ArrayList();
				for (int i = 1; i <= colCount; i++) {
					String colName = rst.getMetaData().getColumnName(i);
					if (colName.equals("YEAR") || colName.equals("MONTH")) {
						list.add(rst.getInt(i));
					} else if (colName.equals("DWBM")) {
						if (rst.getString(i).contains("A")) {
							list.add(rst.getString(i));
						} else {
							list.add(rst.getInt(i));
						}
					} else if (colName.startsWith("SAL") || colName.startsWith("SUM")) {
						list.add(rst.getDouble(i));
					} else {
						list.add(rst.getString(i));
					}
				}
				al.add(list);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	/***************************************************************************
	 * 设置用户登录名
	 * 
	 * @param strXml
	 *            XML 数据信息
	 * @return XML 返回信息
	 **************************************************************************/
	public static String modUserTitle(String strXml, UserLogonInfo userSession) throws Exception {
		Document document = PageCommon.getDefaultXML();
		String nodePath = Common.XDOC_ROOT;
		XmlFunc.setNodeDOM(document, nodePath, strXml);
		DataDoc doc = new DataDoc(document.asXML());
		// 创建执行对象
		DataStorage storage = new DataStorage();
		Element ele = (Element) doc.getDataNode("USERLIST", 0);
		// System.out.println(ele.asXML());
		// 解析sql语句
		storage.addSQL(SQLAnalyse.analyseXMLSQL(ele.asXML()));
		// 执行
		String strReturn = storage.runSQL();
		ReturnDoc returndoc = new ReturnDoc();
		if (!General.empty(strReturn)) {
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(strReturn);
		} else {
			returndoc.addErrorResult(Common.RT_SUCCESS);
		}

		return returndoc.getXML();
	}

	/*
	 * 校验用户登录名是否存在
	 * 
	 * @param sUserTitle 用户登录名
	 * 
	 * @param userSession 当前用户
	 */
	public static String validUserTitle(String sUserTitle, UserLogonInfo userSession) {
		String strCount = "0";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select nvl(count(*),0) cnt from userlist where usertitle=" + General.addQuotes(sUserTitle);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			while (rst.next()) {
				strCount = rst.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strCount;
	}

	/*
	 * 按模版查询薪酬项目
	 * 
	 * @param sTpl 模版
	 */
	public static ArrayList getSum(String sTpl, UserLogonInfo userSession) {
		ArrayList al = new ArrayList();
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select dbfld||'|'||fldname from v_unit_tpl where flag='1' and dbfld like 'SUM%' and tpl=" + General.addQuotes(sTpl) + " and dwbm=" + General.addQuotes(userSession.getUnitID()) + " order by fldord";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("getPrj:获取数据失败");
			}

			while (rst.next()) {
				al.add(rst.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return al;
	}

	public static String getCharts(Map map, UserLogonInfo userSession) {
		String sDbfld = "";
		String sFldname = "";
		String sTpl = (String) map.get("TPL");
		String sTplDetail = (String) map.get("TPLDETAIL");
		String sYear = (String) map.get("YEAR");
		String sDwbm = (String) map.get("DWBM");
		String sSfzhm = (String) map.get("SFZHM");
		String tmpStr = (String) map.get("SUM");
		String sSum = tmpStr.substring(0, tmpStr.indexOf('|'));
		String sSumName = tmpStr.substring(tmpStr.indexOf('|') + 1);
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		DecimalFormat df = new DecimalFormat("##.00");
		String[] colors = { "AFD8F8", "F6BD0F", "8BBA00", "FF8E46", "008E8E", "D64646", "8E468E", "588526", "B3AA00", "008ED6", "9D080D", "A186BE", "00FF00", "0000FF", "FF0000" };
		int i = 0;

		// 初始化图表
		FusionChartsUtil fcu = new FusionChartsUtil();
		Map graphAttrs = new LinkedHashMap();
		graphAttrs.put("caption", sSumName + "柱形图");
		graphAttrs.put("xAxisName", "月份");
		graphAttrs.put("yAxisName", sSumName);
		graphAttrs.put("showNames", "1");
		graphAttrs.put("decimalPrecision", "2");
		graphAttrs.put("formatNumberScale", "0");
		Document docGraph = fcu.initGraph(graphAttrs);
		// 根据sSum取单行记录
		String strSQL = "";
		try {
			strSQL = "select dbfld,fldname,fldord from v_unit_tpl where flag='1' and showflag='1'";
			if (!General.empty(sDwbm))
				strSQL += " and dwbm in " + sDwbm;
			if (!General.empty(sTpl))
				strSQL += " and tpl=" + General.addQuotes(sTpl);
			strSQL += " group by dbfld,fldname,fldord order by fldord";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);
			if (rst == null) {
				throw new Exception("getCharts:获取数据失败");
			}

			while (rst.next()) {
				sDbfld = rst.getString("dbfld");
				sFldname = rst.getString("fldname");
				if ("PRJ".equalsIgnoreCase(sDbfld)) {

				} else if ("TOT".equalsIgnoreCase(sDbfld)) {

				} else {
					ArrayList al = getSumFldvalue(sSum, sYear, sTpl, sTplDetail, sDbfld, sSfzhm);
					Map data = new LinkedHashMap();
					data.put("name", sFldname);
					data.put("value", al.get(0).toString());
					data.put("color", colors[i]);
					i++;
					fcu.addSingleSet(docGraph, data);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}

		return docGraph.asXML();
	}

	/**
	 * 删除导入数据
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @return XML 标准查询返回结构
	 */
	public static String delImpData(String strXml, UserLogonInfo user) throws Exception {
		String strSQL = "";
		// 增加<efsframe>标准头
		Document document = PageCommon.getDefaultXML();
		String nodePath = Common.XDOC_ROOT;
		XmlFunc.setNodeDOM(document, nodePath, strXml);
		// 处理XML
		DataDoc doc = new DataDoc(document.asXML());
		// 创建数据层执行对象
		DataStorage storage = new DataStorage();
		// 创建标准返回结构Dom类对象
		ReturnDoc returndoc = new ReturnDoc();
		String strId = "";
		try {
			int size = doc.getDataNum("T_SALARY_DETAIL");

			// 解析sql语句
			for (int i = 0; i < size; i++) {
				Element ele = (Element) doc.getDataNode("T_SALARY_DETAIL", i);
				String sDwbm = ele.selectSingleNode("DWBM").getText();
				String sTpl = ele.selectSingleNode("TPL").getText();
				String sYear = ele.selectSingleNode("YEAR").getText();
				String sMonth = ele.selectSingleNode("MONTH").getText();
				strSQL = "delete from t_salary_detail where 1=1";
				if(!General.empty(sDwbm))
					strSQL += " and dwbm in "+sDwbm;
				if(!General.empty(sTpl))
					strSQL += " and tpl="+General.addQuotes(sTpl);
				if(!General.empty(sYear))
					strSQL += " and year="+General.addQuotes(sYear);
				if(!General.empty(sMonth))
					strSQL += " and month="+General.addQuotes(sMonth);
				//System.out.println(strSQL);
				storage.addSQL(strSQL);
			}
			// 执行SQL
			String strReturn = storage.runSQL();
			if (!General.empty(strReturn)) {
				// 执行失败，返回异常描述
				returndoc.addErrorResult(Common.RT_FUNCERROR);
				returndoc.setFuncErrorInfo(strReturn);
			} else
				// 执行成功，返回成功节点
				returndoc.addErrorResult(Common.RT_SUCCESS);
		} catch (Exception e) {
			// 发生异常，返回异常描述
			returndoc.addErrorResult(Common.RT_FUNCERROR);
			returndoc.setFuncErrorInfo(e.getMessage());
		}
		// 标准的返回XML结构文档
		return returndoc.getXML();
	}
	
	/***************************************************************************
	 * 当前创建grid所需信息
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return json
	 **************************************************************************/
	public static String objectCreateGridJsonAll(Map<String,String> paraMap, UserLogonInfo userSession) {
		Map<String, String> map = new HashMap<String, String>();
		String sSqltype = paraMap.get("SQLTYPE");
		String sSql = paraMap.get("SQL");
		String sObjectName = paraMap.get("OBJECT_NAME");
		String sWhere = paraMap.get("WHERE");
		String sOrder = paraMap.get("ORDER");
		
		if(sSqltype.equals("SELECT")) {
			String sNodeString = getObjectAllDbfld(sObjectName, userSession);
			String sColmWidAry = getObjectAllFldwidth(sObjectName, userSession);
			map.put("nodeAry", sNodeString);
			map.put("headerAry", sNodeString);
			map.put("colmWidAry", sColmWidAry);
			return JSON.toJSONString(map, SerializerFeature.UseSingleQuotes).replace("'", "");
		}else if(sSqltype.equals("UPDATE")){
			// 多条语句执行
			DataStorage ds = new DataStorage();
			// Windows 下换行是 \r\n, Linux 下是 \n
			String[] sSqlArr = sSql.split("(;\\s*\\r\\n)|(;\\s*\\n)"); 
			for(int i=0;i<sSqlArr.length;i++){
				String sql = sSqlArr[i].replaceAll("--.*", "").replaceAll(";", "").trim();
				//System.out.println(i+":"+sql);
				if (!sql.equals("")) {
					ds.addSQL(sql);
				}
			}
			
			String sRet = ds.runBatchSQL();
			if(General.empty(sRet)){
				sRet = "执行成功";
			}
			return sRet;
		}
		return "1";
	}
	
	/*
	 * 根据模版名获取数据库字段
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getObjectAllDbfld(String sObjectName, UserLogonInfo userSession) {
		String strDbfld = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;
		String strSQL = "";
		try {
			strSQL = "select column_name from user_tab_columns where table_name=" + General.addQuotes(sObjectName.toUpperCase()) + " order by column_id";
			// System.out.println(strSQL);
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}
			strDbfld = "[\"SROWID\",";
			while (rst.next()) {
				strDbfld += "\"" + rst.getString(1) + "\",";
			}
			if (!General.empty(strDbfld))
				strDbfld = strDbfld.substring(0, strDbfld.length() - 1) + "]";

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strDbfld;
	}
	
	/*
	 * 根据模版名获取数据库字段显示宽度
	 * 
	 * @param sTpl 模版名
	 * 
	 * @param userSession 当前用户
	 */
	public static String getObjectAllFldwidth(String sObjectName, UserLogonInfo userSession) {
		String strFldwidth = "";
		DBConnection dbc = new DBConnection();
		ResultSet rst = null;

		String strSQL = "";
		try {
			strSQL = "select data_length from user_tab_columns where table_name=" + General.addQuotes(sObjectName.toUpperCase()) + " order by column_id";
			rst = dbc.excuteQuery(strSQL);

			if (rst == null) {
				throw new Exception("获取数据失败");
			}

			strFldwidth = "[";
			while (rst.next()) {
				strFldwidth += rst.getString(1) + ",";
			}
			if (!General.empty(strFldwidth))
				strFldwidth = strFldwidth.substring(0, strFldwidth.length() - 1) + "]";

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rst != null)
				try {
					rst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			dbc.freeConnection();
		}
		return strFldwidth;
	}
	
	/***************************************************************************
	 * 查询数据对象列表（列表返回）
	 * 
	 * @param strXML
	 *            标准查询条件结构
	 * @param user
	 *            登录用户信息
	 * @return XML 标准查询返回结构
	 **************************************************************************/
	public static String dbobjectList(String strXML, UserLogonInfo user) throws Exception {
		QueryDoc obj_Query = new QueryDoc(strXML);
		Element ele_Condition = obj_Query.getCondition();

		// 获取查询条件map
		Map<String,String> paraMap = obj_Query.getConditionMap(strXML);
		// 获得模版数据库字段历史列表
		// String strDbfldList = getHisDbfld(map.get("TPL"),map.get("YEAR"),map.get("MONTH"),user);

		// / 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		int int_PageSize = str_Return == null ? 5 : Integer.parseInt(str_Return);

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		int int_CurrentPage = str_Return == null ? 1 : Integer.parseInt(str_Return);

		// / 获得记录总数
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDS);
		int int_TotalRecords = str_Return == null ? 0 : Integer.parseInt(str_Return);

		int int_CountTotal = int_TotalRecords > 0 ? 1 : 0;

		int int_TotalPages = 0;

		String str_Select = "ROWID SROWID,S.*";

		String str_From = paraMap.get("OBJECT_NAME")+" S";

		String str_Where = paraMap.get("WHERE");

		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE + str_Where;

		String str_Order = paraMap.get("ORDER");
		// System.out.println("str_Where:"+str_Where);

		return CommonQuery.basicListQuery(str_Select, str_From, str_Where, str_Order, null, null, null, int_TotalRecords, int_TotalPages, int_PageSize, int_CurrentPage, int_CountTotal);
	}
}
