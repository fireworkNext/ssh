package org.ptbank.func;


public class Convertion {

  /**
   * 当前的存储位宽
   */
  private int bitWidth;

  /**
   * 构造函数，设置当前系统的位宽。
   * @param bitWidth int 位宽
   */
  public Convertion(int bitWidth) {
    this.bitWidth = bitWidth * 8;
  }
  public Convertion() {
    this.bitWidth = 1 * 8;
  }
  
  /**
   * 十六进制到十进制的转化。注意：
   * 

十六进制没有小数，只能为整数；
   * 
转化后的最大值为Long.MAX_VALUE，大于这个值的任何数都被转化这个值；
   * 
如果值大于Double.MAX_VALUE时，将会抛出异常。
   * @param strHex String 需要转化的十六进制数字符串
   * @return String  转化后的十进制数字符串
   * @throws Exception
   */
  public String hexToDecimal(String strHex) throws Exception{
    //定义转化结果
    String strDec = ""; 

    //输入为空，返回空字符串
    if(strHex.length() == 0)
      return "";

    //转化
    String strBin = hexToBinary(strHex);
    strDec = binaryToDecimal(strBin);

    //返回结果
    return strDec;
  }

public String hexToString(String strHex) throws Exception
{
//定义转化结果
  String strDec = ""; 

  //输入为空，返回空字符串
  if(strHex.length() == 0)
    return "";

 //转化为字符数组
  char[] arrHex = strHex.toLowerCase().toCharArray();
  String strBin = "";
  //得到二进制字符串
  for(int i = 0; i < arrHex.length; i++) {
    strBin += getBinstrFromHexchar(arrHex[i]);
  }
  int len = strBin.length();
  for(int i=0;i<len;i=i+8)
  {
    String strTemp1 = strBin.substring(i,i+8);
    String strTemp2 = "";
    int i2 = 0;
    for(int j=0;j<8;j++)
    {
      strTemp2 = strTemp1.substring(j,j+1);
      i2 += Integer.parseInt(strTemp2) * (int)Math.pow(2,8-(j+1));
    }
    strDec += "" + (char)i2;
  }
  
  //System.out.println(strBin);
  
  return strDec;
}
  
  /**
   * 将十六进制转化为二进制。
   * @param strHex String 十六进制数字符串
   * @return String 二进制数字符串
   * @throws Exception
   */
  public String hexToBinary(String strHex) throws Exception {
    //定义转化结果
    String strBin = "";

    //输入为空，返回空字符串
    if(strHex.length() <= 0) {
      return "";
    }

    //转化为字符数组
    char[] arrHex = strHex.toLowerCase().toCharArray();
    //得到二进制字符串
    for(int i = 0; i < arrHex.length; i++) {
      strBin += getBinstrFromHexchar(arrHex[i]);
    }

    //删除开头的0
    while(strBin.charAt(0) == '0') {
      strBin = strBin.substring(1);
    }

    return strBin;
  }

  /**
   * 将十进制数字符串转化为对应二进制数字符串。
   * 


   * 
只能对于Long.MAX_VALUE的数值进行转化
   * 
只能对整数进行转化，输入小数时，就会只取小数点前面的数字。
   * 
对于负数，转化后的最高位表示符号位，1表示负，0表示负，求解过程：求其绝对值的二进制；
   * 各位求反；最后一位加1，即可得到负数的二进制数，例如：-5 设位宽为8位 5的二进制：101，求反：010，加1：
   * 011，结果为11111011。
   * 

   * @param strDec String 十进制数字符串
   * @return String 二进制数字符串
   * @throws Exception 输入参数不合法
   */
  public String decimalToBinary(String strDec) throws Exception {
    //定义转化结果
    String strBin = "";
    //是否为负数
    boolean isNegative = false; 


    //输入为空，返回空字符串
    if(strDec.length() <= 0) {
      return "";
    }

    //截取小数点以前的部分
    if(strDec.indexOf(".") != -1)
      strDec = strDec.substring(0, strDec.indexOf("."));

    //如果是负数，则去掉符号
    if(strDec.indexOf("-") != -1 && strDec.indexOf("-") == 0) {
      strDec = strDec.substring(1);
      isNegative = true;
    }
      

    //得到二进制数
    try {
      long num = Long.parseLong(strDec);
      long mod = 0;
      while (num != 0) {
        mod = num % 2;
        num /= 2;
        strBin = mod + strBin;
      }
    } catch(Exception e) {
      System.err.print(e.getMessage());
      throw new Exception("");
    }

    //判断是否为负数
    if(isNegative) {
      //将字符串前加0补长,使其长度达到位宽，并且最高位为1--表示负数
      int difference = bitWidth - strBin.length();
      while(difference > 1) {
        strBin = "0" + strBin;
        difference--;
      }
      strBin = difference == 1 ? ("1" + strBin) : strBin;

      StringBuffer sbBinTemp = new StringBuffer(strBin);
      //除最高位外各位求反
      int index  = 1;
      while(index < sbBinTemp.length()) {
        if(sbBinTemp.charAt(index) == '1') {
          sbBinTemp.setCharAt(index, '0');
        } else {
          sbBinTemp.setCharAt(index, '1');
        }
        index++;
      }

      //求补，即在最后一位加1
      index--;
      while(index > 0) {
        if(sbBinTemp.charAt(index) == '1') {
          sbBinTemp.setCharAt(index, '0');
        } else {
          sbBinTemp.setCharAt(index, '1');
          break;
        }
        index--;
      }

      strBin = sbBinTemp.toString();
    }

    return strBin;
  }

  /**
   * 将二进制数转化为十六进制数。
   * @param strBin String 二进制字符串
   * @return String 十六进制字符串
   * @throws Exception
   */
  public String binaryToHex(String strBin) throws Exception {
    //定义转化结果
    String strHex = "";

    //输入为空，返回空字符串
    if(strBin.length() <= 0) {
      return "";
    }

    //将字符串前面补0，使长度成为4的整倍数
    int lengthOfBin = strBin.length();
    for(int i = 0; i < (4 - lengthOfBin % 4) && (lengthOfBin % 4) != 0; i++) {
      strBin = "0" + strBin;
    }

    //转化为十六进制数--将二进制数按照斯位划分，将四位转化为十进制数，
    //再得到十进制数对应的十六进制字符
    for(int i = 0; i < strBin.length(); i += 4) {
      String strDec = binaryToDecimal(strBin.substring(i, i + 4));
      strHex += getHexcharFromDecnum(Integer.parseInt(strDec));
    }

    //返回结果
    return strHex;

  }

  /**
   * 将二进制数转化为十进制数，转化结果不能超过Long.MAX_VALUE。
   * 特殊情况：
   * 

如果二进制长度达到系统位宽，并且最高位1的话，将会被转为负数，例如：位宽是8，
   * 则 11111011 --> -5
   * @param strBin String 二进制数字符串
   * @return String 十进制数字符串
   * @throws Exception
   */
  public String binaryToDecimal(String strBin) throws Exception {
    //定义转化结果
    long dec = 0;
    //标记是否为负数
    boolean isNegative = false; 

    //输入为空，返回空字符串
    if(strBin.length() <= 0) {
      return "";
    }

    //判断正负数
    if(strBin.length() == bitWidth && strBin.charAt(0) == '1') {
      //将符号为去掉
      strBin = strBin.substring(1);
      isNegative = true;

      StringBuffer sbBinTemp = new StringBuffer(strBin);
      //减1
      int index = strBin.length() - 1;
      while(index >= 0) {
        if (sbBinTemp.charAt(index) == '1') {
          sbBinTemp.setCharAt(index, '0');
          break;
        } else {
          sbBinTemp.setCharAt(index, '1');
          index--;
        }
      }

      //求反
      for(index = 0; index < sbBinTemp.length(); index++) {
        if (sbBinTemp.charAt(index) == '1') {
          sbBinTemp.setCharAt(index, '0');
        } else {
          sbBinTemp.setCharAt(index, '1');
        }
      }
      strBin = sbBinTemp.toString();
    }

    //转化
    
    //java.lang.Math mathCompute = new java.lang.Math();
    if(strBin.indexOf("1") == -1) {
      dec = (long)Math.pow(2, strBin.length());
    } else {
    for(int i = 0; i < strBin.length(); i++) {
      try {
        dec += Long.parseLong(strBin.substring(i, i + 1)) *
          Math.pow(2, strBin.length() - i - 1);
      } catch (Exception e) {
        throw e;
      }
    }
    }

    //返回结果
    String strDec = String.valueOf(dec);
    if(isNegative) strDec = "-" + strDec;
    return strDec;
  }

  /**
   * 根据不同的十六进制字符，得到其对应的二进制字符串。
   * @param cHex char 十六进制字符
   * @return String  二进制字符串
   */
  private String getBinstrFromHexchar(char cHex) {
    String strBin = "";

    //获取不同的二进制字符串
    switch (cHex) {
      case '0':
        strBin = "0000"; 
        break;
      case '1':
        strBin = "0001";
        break;
      case '2':
        strBin = "0010";
        break;
      case '3':
        strBin = "0011";
        break;
      case '4':
        strBin = "0100";
        break;
      case '5':
        strBin = "0101";
        break;
      case '6':
        strBin = "0110";
        break;
      case '7':
        strBin = "0111";
        break;
      case '8':
        strBin = "1000";
        break;
      case '9':
        strBin = "1001";
        break;
      case 'a':
        strBin = "1010";
        break;
      case 'b':
        strBin = "1011";
        break;
      case 'c':
        strBin = "1100";
        break;
      case 'd':
        strBin = "1101";
        break;
      case 'e':
        strBin = "1110";
        break;
      case 'f':
        strBin = "1111";
        break;
    }

    return strBin;
  }

  /**
   * 根据十进制数得到相对应的十六进制字符。
   * @param iDec int 十进制数
   * @return char 十六进制字符
   */
  private char getHexcharFromDecnum(int iDec) {
    char cHex = 'x';

    //得到十进制字符
    switch (iDec) {
      case 0:
        cHex = '0';
        break;
      case 1:
        cHex = '1';
        break;
      case 2:
        cHex = '2';
        break;
      case 3:
        cHex = '3';
        break;
      case 4:
        cHex = '4';
        break;
      case 5:
        cHex = '5';
        break;
      case 6:
        cHex = '6';
        break;
      case 7:
        cHex = '7';
        break;
      case 8:
        cHex = '8';
        break;
      case 9:
        cHex = '9';
        break;
      case 10:
        cHex = 'A';
        break;
      case 11:
        cHex = 'B';
        break;
      case 12:
        cHex = 'C';
        break;
      case 13:
        cHex = 'D';
        break;
      case 14:
        cHex = 'E';
        break;
      case 15:
        cHex = 'F';
        break;
    }

    return cHex;
  }
  
  public  static void main(String[] args) throws Exception
  {
  }
}

