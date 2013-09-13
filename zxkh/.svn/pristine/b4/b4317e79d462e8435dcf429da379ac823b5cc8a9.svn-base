package org.ptbank.test;

import java.io.FileInputStream;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.junit.Test;
import org.ptbank.func.Excel;

public class TestPOI {
	@Test
	public void test() {
		try {
			FileInputStream ETreadFile = new FileInputStream("D:/MyEclipse10/work/gzcx/src/org/gzcx/test/test.et");
			// 指定要读取的文件，本例使用之前生成的ETExample.et
			HSSFWorkbook wb = new HSSFWorkbook(ETreadFile);
			// 创建一个工作表对象，从指定的文件流中创建，即上面指定了的文件流
			HSSFSheet st = wb.getSheetAt(0);
			// 获得总行数
			int rowNum = st.getPhysicalNumberOfRows();
			// 获得总列数
			int colNum = st.getRow(0).getPhysicalNumberOfCells();
			// System.out.println("rowNum:"+rowNum+" colNum:"+colNum);
			// 获取名称为"表格工作表第1页"的工作表，可以用getSheetAt(int)方法取得Sheet
			HSSFRow row = st.getRow(0);
			// 获得第一行，同上，如果此行没有被创建过则抛出异常
			HSSFCell cell = row.getCell(0);
			// 获取第一个单元格，如果没有被创建过则抛出异常
			// System.out.println(cell.getRichStringCellValue());
			// 把cell中的内容按字符串方式读取出来，并显示在控制台上
			ETreadFile.close(); // 记得关闭流

			// 测试Excel类
			Excel excel = new Excel("D:/MyEclipse10/work/gzcx/src/org/gzcx/test/test.et");
			List<List> l = excel.excelToListList(0);
			int i = 0, j = 0;
			for (i = 0; i < l.size(); i++) {
				List ll = l.get(i);
				for (j = 0; j < ll.size(); j++) {
					System.out.println(ll.get(j));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void Test1() {
		String str = "35110B00";
		System.out.println(Pattern.compile("(?i)[a-z]").matcher(str).find());

		String s = "'sds gdasda"+"\t" + "123" + "\n" + "edaeafd'";
		System.out.println("转换前：" + s);
		s = s.replaceAll("\r|\n|\t", "");
		System.out.println("转换后：" + s);
		
		System.out.println("　");
	}

}
