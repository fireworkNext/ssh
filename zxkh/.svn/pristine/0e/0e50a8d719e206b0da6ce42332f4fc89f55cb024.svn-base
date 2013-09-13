package org.ptbank.base;

import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.ptbank.db.DataStorage;
import org.ptbank.db.SQLAnalyse;
import org.ptbank.declare.Common;
import org.ptbank.func.General;

/**
 * 标准业务操作型XML处理统一接口类 能方便快捷的将标准的业务操作型XML文档分析处理成T-SQL并封装事务执行 并按照标准的返回XML结构构造相关处理结果信息
 */
public class Operation {
	/**
	 * 基本业务操作，可以处理通用型的，不需要任何业务数据修改的[添加]和[修改]类业务
	 * 
	 * @param objDataDoc
	 *            Document XML 文档对象
	 * @param strTbName
	 *            待处理的业务表名称
	 * @return String 标准 XML 返回文档字符串
	 */
	public static String addOrEdit(DataDoc objDataDoc, String strTbName) throws Exception {

		// / 创建执行对象
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		try {

			int int_Size = objDataDoc.getDataNum(strTbName);

			// / 解析 SQL 语句
			for (int i = 0; i < int_Size; i++) {
				Element ele_Temp = (Element) objDataDoc.getDataNode(strTbName, i);
				obj_Storage.addSQL(SQLAnalyse.analyseXMLSQL(ele_Temp));
			}

			// / 执行
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

	/**
	 * 基本业务操作，可以处理通用型的，不需要任何业务数据修改的[添加]和[修改]类业务
	 * 
	 * @param strXML
	 *            Document XML 文档字符串
	 * @param strTbName
	 *            待处理的业务表名称
	 * @return String 标准 XML 返回文档字符串
	 */
	public static String addOrEdit(String strXML, String strTbName) throws Exception {
		DataDoc obj_DataDoc = new DataDoc(strXML);

		return addOrEdit(obj_DataDoc, strTbName);
	}

	/**
	 * 统一处理标准的业务操作型XML文档，将文档分析称T-SQL封装到DataStorage类中作为一个事务执行
	 * 
	 * @param strXML
	 *            标准业务操作型XML文档
	 * @return String 标准 XML 返回文档字符串
	 */
	public static String dealWithXml(String strXML) throws Exception {
		// / 创建执行对象
		DataStorage obj_Storage = new DataStorage();
		ReturnDoc obj_ReturnDoc = new ReturnDoc();
		try {
			Document obj_Doc = DocumentHelper.parseText(strXML);
			List lst_Temp = obj_Doc.getRootElement().selectNodes("//*[@operation][@operation!='']");
			Iterator it_Temp = lst_Temp.iterator();

			while (it_Temp.hasNext()) {
				Element ele_Temp = (Element) it_Temp.next();
				Node node = ele_Temp.selectSingleNode("PID");
				if(node!=null){
					//20121216增加id的判断，使之更通用
					if (node.getName().equalsIgnoreCase("pid") && General.empty(node.getText()))
						node.setText(UUID.randomUUID().toString());
				}
				// 创建插入数据的XML
				String str_SQL = SQLAnalyse.analyseXMLSQL(ele_Temp);

				//System.out.println(str_SQL);

				obj_Storage.addSQL(str_SQL);
			}

			// / 执行
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

}
