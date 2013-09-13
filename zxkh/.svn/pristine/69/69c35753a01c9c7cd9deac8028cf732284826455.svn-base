package org.ptbank.base;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.ptbank.declare.Common;
import org.ptbank.func.General;

/**
 * 用于对标准查询结构XML文档进行分析处理
 */
public class QueryDoc implements java.io.Serializable {
	private static final long serialVersionUID = -1981973515297855263L;

	private Document m_doc_Self = null;
	private int intPageSize;
	private int intCurrentPage;

	/**
	 * 实例初始化
	 * 
	 * @param objDoc
	 *            Document XML 文档对象
	 */
	public QueryDoc(Document objDoc) throws Exception {
		this.m_doc_Self = objDoc;
	}

	/**
	 * 实例初始化
	 */
	public QueryDoc(String strXML) throws Exception {
		this(DocumentHelper.parseText(strXML));

		Element ele_Condition = this.getCondition();

		// // 获得每页记录数
		String str_Return = ele_Condition.attributeValue(Common.XML_PROP_RECORDSPERPAGE);
		this.setIntPageSize(str_Return == null ? 10 : Integer.parseInt(str_Return));

		// / 获得当前待查询页码
		str_Return = ele_Condition.attributeValue(Common.XML_PROP_CURRENTPAGENUM);
		this.setIntCurrentPage(str_Return == null ? 1 : Integer.parseInt(str_Return));

	}

	/**
	 * 获得解析好的T-SQL查询Where语句
	 * 
	 * @return String 解析好的T-SQL查询Where语句
	 */
	public String getConditions() throws Exception {
		Element ele_Root = m_doc_Self.getRootElement();
		Element ele_Conditions = ele_Root.element(Common.XDOC_QUERYCONDITION);
		if (ele_Conditions == null) {
			return null;
		}
		return parseConditions(ele_Conditions);
	}

	/**
	 * 根据 XML 文档解析得到T-SQL查询Where语句
	 * 
	 * @return String 解析好的T-SQL查询Where语句
	 */
	private String parseConditions(Element ele) throws Exception {
		Iterator it_Condition = ele.elementIterator(Common.XDOC_CONDITION);
		Iterator it_Conditions = ele.elementIterator(Common.XDOC_CONDITIONS);

		String str_Where = "";
		String str_Type = "";

		str_Type = ele.elementText(Common.XDOC_TYPE);
		str_Type = General.empty(str_Type) ? "" : str_Type.trim().toUpperCase();

		int int_Count = 0;

		while (it_Condition.hasNext()) {
			// / 获得查询节点
			if (!General.empty(str_Where)) {
				if (General.empty(str_Type))
					throw new Exception("QueryDoc.parseConditions.77.未提供类型");

				str_Where += Common.SPACE + str_Type + Common.SPACE;
			}

			int_Count++;

			Element ele_Condition = (Element) it_Condition.next();

			String str_Alias = ele_Condition.attributeValue(Common.XML_PROP_ALIAS);
			String str_DataType = ele_Condition.attributeValue(Common.XML_PROP_DATATYPE);
			int int_DataType = General.empty(str_DataType) ? 0 : Integer.parseInt(str_DataType);

			String str_FieldName = ele_Condition.elementText(Common.XDOC_FIELDNAME);
			str_FieldName = General.empty(str_Alias) ? str_FieldName : str_Alias + Common.DOT + str_FieldName;

			// / +
			// / 如果是查询出生日期，则获得该字典的 sv 属性，用来确定是否是按照年龄来查询的
			// / 如果是 AGERANGE 则说明是按照年龄来查询
			// / 如果是 空，则说明是按照出生日期来查询
			String str_Sv = ele_Condition.attributeValue(Common.XDOC_FIELDNAME, Common.XML_PROP_SV);
			String str_Operation = ele_Condition.elementText(Common.XDOC_OPERATION);
			String str_DataValue = ele_Condition.elementText(Common.XDOC_VALUE);

			str_Operation = str_Operation.trim().toUpperCase();

			// / 单独处理日期类型的字段
			if (int_DataType == 3) {
				// / 按年龄来进行查询
				if (str_Sv.equals(Common.XML_AGERANGE)) {
					str_Where += General.opYearDate(str_FieldName, str_DataValue, str_Operation);
				} else {
					str_Where += General.opDate(str_FieldName, str_DataValue, str_Operation);
				}
			} else {
				if (int_DataType == Common.IDT_BINARY)
					throw new Exception("QueryDoc.parseConditions.函数不能处理二进制类型的数据");

				if (str_Operation.toUpperCase().equals("IN") || str_Operation.toUpperCase().equals("NOT IN") || str_Operation.toUpperCase().equals("IS") || str_Operation.toUpperCase().equals("IS NOT")) {
					str_Where += str_FieldName + Common.SPACE + str_Operation + Common.SPACE + str_DataValue;
				} else {
					str_Where += str_FieldName + Common.SPACE + str_Operation + Common.SPACE + General.converType(int_DataType, str_DataValue, str_FieldName, null);
				}

			}
		}

		while (it_Conditions.hasNext()) {
			int_Count++;

			Element ele_Conditions = (Element) it_Conditions.next();

			// / 获得查询节点
			if (!General.empty(str_Where)) {
				if (General.empty(str_Type))
					throw new Exception("QueryDoc.parseConditions.137.未提供类型");

				str_Where += Common.SPACE + str_Type + Common.SPACE;
			}

			str_Where += parseConditions(ele_Conditions);
		}

		return int_Count > 1 ? General.addBracket(str_Where) : str_Where;
	}

	/**
	 * 返回文档的 XML 字符串
	 * 
	 * @return String 当前Document文档的XML 字符串
	 */
	public String getXML() throws Exception {
		return m_doc_Self.asXML();
	}

	/**
	 * 返回文档的XML文档对象
	 * 
	 * @return Document 当前文档的XML文档对象
	 */
	public Document getDocument() {
		return this.m_doc_Self;
	}

	/**
	 * 从文档中获得查询节点
	 * 
	 * @return Element 查询节点
	 */
	public Element getCondition() {
		Element ele_Condition = (Element) this.m_doc_Self.selectSingleNode(Common.XDOC_ROOT + Common.BAR + Common.XDOC_QUERYCONDITION);
		return ele_Condition;
	}

	public int getIntCurrentPage() {
		return intCurrentPage;
	}

	public void setIntCurrentPage(int intCurrentPage) {
		this.intCurrentPage = intCurrentPage;
	}

	public int getIntPageSize() {
		return intPageSize;
	}

	public void setIntPageSize(int intPageSize) {
		this.intPageSize = intPageSize;
	}

	public Map<String, String> getConditionMap(String strXML) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		// 解析查询条件
		Document doc = DocumentHelper.parseText(strXML);
		List nodeList = doc.selectNodes("//CONDITION");
		for (int i = 0; i < nodeList.size(); i++) {
			Element ele = (Element) nodeList.get(i);
			String sFieldName = ele.elementText(Common.XDOC_FIELDNAME);
			String sDataValue = ele.elementText(Common.XDOC_VALUE);
			map.put(sFieldName, sDataValue);
		}

		return map;
	}

}
