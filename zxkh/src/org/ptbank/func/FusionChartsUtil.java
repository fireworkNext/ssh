package org.ptbank.func;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.junit.Test;
import org.ptbank.declare.Common;

public class FusionChartsUtil implements java.io.Serializable {
	private final long serialVersionUID = -249703229042437619L;

	public static String createSingle(Map graphAttrs, String[] colors, Map dataSets) {
		String str = "";
		Document doc = null;
		int i = 0;
		try {
			doc = DocumentHelper.parseText(Common.XML_HEADINFO + "<" + "graph" + "/>");
			for (Object dataKey : graphAttrs.keySet()) {
				doc.getRootElement().addAttribute((String) dataKey, (String) graphAttrs.get(dataKey));
			}
			for (Object dataKey : dataSets.keySet()) {
				Element ele = DocumentHelper.createElement("set");
				ele.addAttribute("name", (String) dataKey);
				ele.addAttribute("value", (String) dataSets.get(dataKey));
				if (colors[i] != null) {
					ele.addAttribute("color", colors[i]);
					i++;
				}
				doc.getRootElement().add(ele);
			}
			if (doc != null)
				str = doc.asXML();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return str;
	}

	public Document initGraph(Map graphAttrs) {
		Document doc = null;
		try {
			doc = DocumentHelper.parseText(Common.XML_HEADINFO + "<" + "graph" + "/>");
			for (Object dataKey : graphAttrs.keySet()) {
				doc.getRootElement().addAttribute((String) dataKey, (String) graphAttrs.get(dataKey));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return doc;
	}

	public void addSingleSet(Document docGraph, Map data) {
		Element graphEle = (Element)docGraph.selectSingleNode("//graph");
		if (graphEle != null) {
			Element ele = DocumentHelper.createElement("set");
			for (Object dataKey : data.keySet()) {
				ele.addAttribute((String) dataKey, (String) data.get(dataKey));
			}
			graphEle.add(ele);
		}
	}

	public void addSingleSet(Document docGraph, String setName, String setValue, String setColor) {
		Element graphEle = (Element)docGraph.selectSingleNode("//graph");
		if (graphEle != null) {
			if (!General.empty(setValue)) {
				Element ele = DocumentHelper.createElement("set");
				if (!General.empty(setName))
					ele.addAttribute("name", setName);

				ele.addAttribute("value", setValue);
				if (!General.empty(setColor))
					ele.addAttribute("color", setColor);
				graphEle.add(ele);
			}
		}
	}

	public void addCategories(Document docGraph, Map data) {
		Element graphEle = (Element)docGraph.selectSingleNode("//graph");
		if (graphEle != null) {
			Element ele = DocumentHelper.createElement("categories");
			for (Object dataKey : data.keySet()) {
				ele.addAttribute((String) dataKey, (String) data.get(dataKey));
			}
			graphEle.add(ele);
		}
	}
	
	public void addCategory(Document docGraph, Map data) {
		Element  categoriesEle= (Element)docGraph.selectSingleNode("//categories");
		if (categoriesEle != null) {
			Element ele = DocumentHelper.createElement("category");
			for (Object dataKey : data.keySet()) {
				ele.addAttribute((String) dataKey, (String) data.get(dataKey));
			}
			categoriesEle.add(ele);
		}
	}

	public void addDataset(Document docGraph, Map data) {
		Element graphEle = (Element)docGraph.selectSingleNode("//graph");
		if (graphEle != null) {
			Element ele = DocumentHelper.createElement("dataset");
			for (Object dataKey : data.keySet()) {
				ele.addAttribute((String) dataKey, (String) data.get(dataKey));
			}
			graphEle.add(ele);
		}
	}
	
	public void addMultSet(Document docGraph, String seriesname,Map data) {
		List nodes = docGraph.selectNodes("//dataset");
		Element datasetEle=null;
		for(int i=0;i<nodes.size();i++){
			Element tempEle=(Element)nodes.get(i);
			String tempText=tempEle.attributeValue("seriesname");
			if(tempText.equals(seriesname)){
				datasetEle=tempEle;
			}
		}
		if (datasetEle != null) {
			Element ele = DocumentHelper.createElement("set");
			for (Object dataKey : data.keySet()) {
				ele.addAttribute((String) dataKey, (String) data.get(dataKey));
			}
			datasetEle.add(ele);
		}
	}
	
	
	@Test
	public void test() {
		String[] colors = { "AFD8F8", "F6BD0F", "8BBA00", "FF8E46", "008E8E", "D64646", "8E468E", "588526", "B3AA00", "008ED6", "9D080D", "A186BE" };
		Map map = new LinkedHashMap();
		map.put("caption", "工资柱形图");
		map.put("xAxisName", "月份");
		map.put("yAxisName", "月工资");
		map.put("showNames", "1");
		map.put("decimalPrecision", "2");
		map.put("formatNumberScale", "0");
		Map dataMap = new LinkedHashMap();
		dataMap.put("一月", "462");
		dataMap.put("二月", "857");
		System.out.println(createSingle(map, colors, dataMap));
		//测试分步创建single
		Document docGraph = initGraph(map);
		Map setMap1 = new LinkedHashMap();
		setMap1.put("name", "一月");
		setMap1.put("value", "462");
		setMap1.put("color", "AFD8F8");
		addSingleSet(docGraph,setMap1);
		addSingleSet(docGraph,"二月","857","F6BD0F");
		System.out.println(docGraph.asXML());
		//测试分布创建mult
		Map graphMap = new LinkedHashMap();
		graphMap.put("caption", "分析");
		graphMap.put("xAxisName", "地区");
		graphMap.put("yAxisName", "数量");
		graphMap.put("showNames", "1");
		graphMap.put("decimalPrecision", "2");
		graphMap.put("formatNumberScale", "0");
		Document docGraph1 = initGraph(graphMap);
		Map catesMap = new LinkedHashMap();
		catesMap.put("fontSize", "11");
		catesMap.put("fontColor", "000000");
		addCategories(docGraph1,catesMap);
		Map catMap1= new LinkedHashMap();
		catMap1.put("name", "America");
		addCategory(docGraph1,catMap1);
		Map catMap2=new LinkedHashMap();
		Map datasetMap1 = new LinkedHashMap();
		datasetMap1.put("seriesname", "Wheat");
		datasetMap1.put("color", "56B9F9");
		datasetMap1.put("showValues", "1");
		datasetMap1.put("alpha","100");
		addDataset(docGraph1,datasetMap1);
		Map multSet1 = new LinkedHashMap();
		multSet1.put("value", "67");
		addMultSet(docGraph1,"Wheat",multSet1);
		System.out.println(docGraph1.asXML());
	}

}
