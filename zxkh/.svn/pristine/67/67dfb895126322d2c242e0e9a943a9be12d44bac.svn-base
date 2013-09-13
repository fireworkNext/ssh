package org.ptbank.func;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

public class JsonUtil {
	/**
	 * 从一个JSON 对象字符格式中得到一个java对象
	 * 
	 * @param jsonString
	 * @param pojoCalss
	 * @return
	 */
	public static Object getObjectFromJson(String jsonString, Class pojoCalss) {
		Object pojo;
		JSONObject jsonObject = JSONObject.fromObject(jsonString);
		pojo = JSONObject.toBean(jsonObject, pojoCalss);
		return pojo;
	}

	/**
	 * 从json HASH表达式中获取一个map，改map支持嵌套功能
	 * 
	 * @param jsonString
	 * @return
	 */
	public static Map getMapFromJson(String jsonString) {
		JSONObject jsonObject = JSONObject.fromObject(jsonString);
		Iterator keyIter = jsonObject.keys();
		String key;
		Object value;
		Map valueMap = new HashMap();

		while (keyIter.hasNext()) {
			key = (String) keyIter.next();
			value = jsonObject.get(key);
			valueMap.put(key, value);
		}

		return valueMap;
	}

	/**
	 * 从json数组中得到相应java数组
	 * 
	 * @param jsonString
	 * @return
	 */
	public static Object[] getObjectArrayFromJson(String jsonString) {
		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		return jsonArray.toArray();

	}

	/**
	 * 从json对象集合表达式中得到一个java对象列表
	 * 
	 * @param jsonString
	 * @param pojoClass
	 * @return
	 */
	public static List getListFromJson(String jsonString, Class pojoClass) {

		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		JSONObject jsonObject;
		Object pojoValue;

		List list = new ArrayList();
		for (int i = 0; i < jsonArray.size(); i++) {

			jsonObject = jsonArray.getJSONObject(i);
			pojoValue = JSONObject.toBean(jsonObject, pojoClass);
			list.add(pojoValue);

		}
		return list;

	}

	/**
	 * 从json数组中解析出java字符串数组
	 * 
	 * @param jsonString
	 * @return
	 */
	public static String[] getStringArrayFromJson(String jsonString) {

		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		String[] stringArray = new String[jsonArray.size()];
		for (int i = 0; i < jsonArray.size(); i++) {
			stringArray[i] = jsonArray.getString(i);

		}

		return stringArray;
	}

	/**
	 * 从json数组中解析出javaLong型对象数组
	 * 
	 * @param jsonString
	 * @return
	 */
	public static Long[] getLongArrayFromJson(String jsonString) {

		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		Long[] longArray = new Long[jsonArray.size()];
		for (int i = 0; i < jsonArray.size(); i++) {
			longArray[i] = new Long(jsonArray.getLong(i));

		}
		return longArray;
	}

	/**
	 * 从json数组中解析出java Integer型对象数组
	 * 
	 * @param jsonString
	 * @return
	 */
	public static Integer[] getIntegerArrayFromJson(String jsonString) {

		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		Integer[] integerArray = new Integer[jsonArray.size()];
		for (int i = 0; i < jsonArray.size(); i++) {
			integerArray[i] = new Integer(jsonArray.getInt(i));

		}
		return integerArray;
	}

	/**
	 * 从json数组中解析出java Date 型对象数组，使用本方法必须保证日期格式正确
	 * 
	 * @param jsonString
	 * @return
	 */
	public static Date[] getDateArrayFromJson(String jsonString)
			throws ParseException {

		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		Date[] dateArray = new Date[jsonArray.size()];
		String dateString;
		Date date;

		for (int i = 0; i < jsonArray.size(); i++) {
			dateString = jsonArray.getString(i);
			date = parseDate(dateString);
			dateArray[i] = date;
		}
		return dateArray;
	}

	/**
	 * 从json数组中解析出java Double型对象数组
	 * 
	 * @param jsonString
	 * @return
	 */
	public static Double[] getDoubleArrayFromJson(String jsonString) {

		JSONArray jsonArray = JSONArray.fromObject(jsonString);
		Double[] doubleArray = new Double[jsonArray.size()];
		for (int i = 0; i < jsonArray.size(); i++) {
			doubleArray[i] = new Double(jsonArray.getDouble(i));

		}
		return doubleArray;
	}

	/**
	 * 将java对象转换成json字符串
	 * 
	 * @param javaObj
	 * @return
	 */
	public static String getJsonFromObject(Object javaObj) {

		JSONObject json = getJsonObjectFromObject(javaObj);
		return json.toString();
	}

	public static JSONObject getJsonObjectFromObject(Object javaObj) {
		JSONObject json;
		json = JSONObject.fromObject(javaObj);
		return json;
	}
	
	/**
	 * 将java对象转换成json对象,并设定日期格式
	 * 
	 * @param javaObj
	 * @param dateFormat
	 * @return
	 */
	public static JSONObject getJsonObjectFromObject(Object javaObj,
			String dateFormat) {
		JSONObject json;
		JsonConfig jsonConfig = configJson(dateFormat);
		json = JSONObject.fromObject(javaObj, jsonConfig);
		return json;
	}

	/**
	 * 调用getJsonObjectFromObject(Object,Object),返回json字符串
	 * 
	 * @param javaObj
	 * @param dateFormat
	 * @return
	 */
	public static String getJsonFromObject(Object javaObj,
			String dateFormat) {
		JSONObject json = getJsonObjectFromObject(javaObj,dateFormat);
		return json.toString();
	}

	/**
	 * JSON 时间解析器具
	 * 
	 * @param datePattern
	 * @return
	 */
	public static JsonConfig configJson(String datePattern) {
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "" });
		jsonConfig.setIgnoreDefaultExcludes(false);
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		jsonConfig.registerJsonValueProcessor(Date.class,
				new DateJsonValueProcessor(datePattern));

		return jsonConfig;
	}

	/**
	 * 
	 * @param excludes
	 * @param datePattern
	 * @return
	 */
	public static JsonConfig configJson(String[] excludes, String datePattern) {
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(excludes);
		jsonConfig.setIgnoreDefaultExcludes(false);
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		jsonConfig.registerJsonValueProcessor(Date.class,
				new DateJsonValueProcessor(datePattern));

		return jsonConfig;
	}
	
	/**
	 * 将java对象转换成json字符串
	 * 
	 * @param javaObj
	 * @return
	 */
	public static String getJsonFromObject(String[] excludes, Object javaObj) {

		JSONObject json = getJsonObjectFromObject(excludes,javaObj);
		return json.toString();
	}

	public static JSONObject getJsonObjectFromObject(String[] excludes,Object javaObj) {
		JSONObject json;
		JsonConfig jsonConfig = configJson(excludes,"");
		json = JSONObject.fromObject(javaObj, jsonConfig);
		return json;
	}
	
	/**
	 * 解析日期格式为："yyyy-MM-dd".
	 */
	public static Date parseDate(String d) {
		try {
			return new SimpleDateFormat("yyyy-MM-dd").parse(d);
		} catch (ParseException e) {
		}
		return null;
	}
}
