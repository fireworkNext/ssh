package org.ptbank.classes;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.ptbank.base.CommonQuery;
import org.ptbank.base.NumAssign;
import org.ptbank.base.QueryDoc;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.Common;
import org.ptbank.declare.Field;
import org.ptbank.declare.Table;
import org.ptbank.func.General;


public class ClassesBO {
	/**
	 * 获取表节点
	 * 
	 * @param strXml
	 * @return 表节点元素
	 * @throws DocumentException
	 */
	private Element getTabNoe(String strXml) throws DocumentException {
		Document doc = DocumentHelper.parseText(strXml);

		Element ele = (Element) doc.selectSingleNode("//DATAINFO/" + Table.CLASSES);

		return ele;
	}

	/**
	 * 新增班级
	 * 
	 * @param strXml
	 *            DATAINFO为根节点的xml数据
	 * @return null或者错误信息
	 */
	public String add(String strXml) {
		String strRet = null;
		try {
			// 获取表节点
			Element ele = getTabNoe(strXml);
			// 设置编号
			String strId = NumAssign.assignID_A("100000");
			ele.element("CID").setText(strId);

			// 创建执行对象
			DataStorage storage = new DataStorage();
			storage.addSQL(SQLAnalyse.analyseXMLSQL(ele));

			strRet = storage.runSQL();
      
      General.createDicFileSQL("SELECT CID,CNAME FROM CLASSES ORDER BY CID", "DIC_CLASSES");

		}
    catch (Exception e) {
			strRet = "" + e.getMessage();
		}

		return strRet;
	}

	public String list(String strXml) throws Exception {
		// 构造标准查询XML接口分析类对象
		QueryDoc obj_Query = new QueryDoc(strXml);
		int int_PageSize = obj_Query.getIntPageSize();

		int int_CurrentPage = obj_Query.getIntCurrentPage();

		// 查询字典
		String str_Select = "s.CID CID,s.CNAME CNAME,s.CMEMO CMEMO";
		// 查询表
		String str_From = Table.CLASSES + Common.SPACE + Table.S;
		// 构建标准的查询条件
		String str_Where = obj_Query.getConditions();
		str_Where = General.empty(str_Where) ? str_Where : Common.WHERE
				+ str_Where;

		// 标准的、统一的分页查询接口
		return CommonQuery.basicListQuery(str_Select, str_From, str_Where,"CID", null, int_PageSize, int_CurrentPage);
	}

	/**
	 * 根据班级编号查询班级详细信息
	 * @param cid 班级编号
	 * @return 详细信息
	 * @throws Exception
	 */
	public String detail(String cid) throws Exception {
		String str_Select = "s.CID CID,s.CNAME CNAME,s.CMEMO CMEMO";
		// 查询表
		String str_From = Table.CLASSES + Common.SPACE + Table.S;
		// 构建标准的查询条件
		String str_Where = Common.WHERE + "cid = '" + cid + "'";
		
		return CommonQuery.basicListQuery(str_Select, 
                str_From, 
                str_Where,
                "CID",
                null, 
                null, null, 1, 1, 1, 1, 0, true,
                Table.CLASSES);
	}

	/**
	 * 含班级编号的学生列表
	 * @param strXml
	 * @return
	 * @throws Exception
	 */
	public String personList(String strXml) throws Exception {
	      // 构造标准查询XML接口分析类对象
	      QueryDoc obj_Query = new QueryDoc(strXml);
	      int int_PageSize = obj_Query.getIntPageSize();

	      int int_CurrentPage = obj_Query.getIntCurrentPage();

	      // 查询字典
	      String str_Select = "s.PERSONID PERSONID,s.NAME NAME,s.IDCARD IDCARD,s.SEX SEX,s.PLACECODE PLACECODE,s.BIRTHDAY BIRTHDAY,s.TEL TEL,r.cid cid";
	      // 查询表
	      String str_From   = Table.PERSON + Common.SPACE + Table.S + ",classesref r";
	      // 构建标准的查询条件
	      String str_Where = obj_Query.getConditions();
	      
	      str_Where ="where s.personid=r.personid(+) and (r.cid is null or " + str_Where + ")";
	      
	      // 日期型字段列表
	      String[] str_DateList  = {Field.BIRTHDAY};
	      
	      // 标准的、统一的分页查询接口
	      return CommonQuery.basicListQuery(str_Select,
	                                        str_From,
	                                        str_Where,
	                                        "s." + Field.PERSONID,
	                                        str_DateList,
	                                        int_PageSize,
	                                        int_CurrentPage);
	}

}
