package org.ptbank.cache;

import java.util.*;

import java.sql.*;

import org.ptbank.db.DBConnection;
import org.ptbank.db.DataStorage;
import org.ptbank.declare.*;
import org.ptbank.func.*;

public class SpellCache implements java.io.Serializable
{
  private static final long serialVersionUID = -8208755962314651055L;
  private static SpellCache obj_SpellCache;

  static ArrayList<Spell> arr_Spell = null;

  /**
   * 实例初始化
   */
  private SpellCache()
  {
    try
    {
      if(obj_SpellCache==null)
        init();
    }
    catch(Exception e)
    {
      e.printStackTrace();
      obj_SpellCache = null;
    }
  }
  
  /**
   * 获得拼音缓存的实例
   * @return 拼音缓存的实例
   */
  public static synchronized SpellCache getInstance()
  {
    if(obj_SpellCache == null)
    {
      obj_SpellCache = new SpellCache();
    }

    return obj_SpellCache;
  }
  
  /**
   * 拼音缓存内容的初始化
   */
  private void init() throws Exception
  {
    DBConnection dbc = new DBConnection();
	ResultSet rst = null;
	try
	{
      /// 查询出拼音内容
      String str_SQL = Common.SELECT  + Field.WORD   + Common.COMMA +
                                        Field.SPELL  + Common.COMMA +
                                        Field.ASPELL +
                       Common.S_FROM  + Table.SPELL  +
                       Common.S_ORDER + Field.WORD;

      /// 查询
      rst = dbc.excuteQuery(str_SQL);

      /// 初始化 arr_Spell
      arr_Spell = new ArrayList<Spell>();

      while(rst.next())
      {  
        char chr_Word     = rst.getString(Field.WORD).charAt(0);
        char chr_Spell    = rst.getString(Field.SPELL).charAt(0);
        String str_ASpell = rst.getString(Field.ASPELL);

        arr_Spell.add(new Spell(chr_Word, chr_Spell, str_ASpell));
      }
      
      rst.close();
      
      System.out.println("缓存中已载入" + arr_Spell.size() + "个拼音");
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
    finally
    {
    	rst.close();
    	dbc.freeConnection();
    }
  }

  /**
   * 获得拼音的总数
   * @return int               拼音的总数
   */
  public synchronized int getCount()
  {
    return arr_Spell.size();
  }
  
  /**
   * 获得单个拼音对象
   * @param chrWord           字符
   * @return Spell             单个拼音缓存对象
   */
  public Spell getObject(char chrWord)
  {
    Iterator it = arr_Spell.iterator();

    while(it.hasNext())
    {
      Spell obj_Spell = (Spell)it.next();

      if (obj_Spell.equals(chrWord)) return obj_Spell;
    }
    return null;
  }
  
  /**
   * 获得字符的拼音头
   * @param chrWord           字符
   * @return String            拼音头
   */
  public String getSpell(char chrWord)
  {
    Spell obj_Spell = getObject(chrWord);

    if(obj_Spell==null) return null;

    return String.valueOf(obj_Spell.getSpell());
  }
  
  /**
   * 获得字符的全拼
   * @param chrWord           字符
   * @return String            全拼
   */
  public String getASpell(char chrWord)
  {
    Spell obj_Spell = getObject(chrWord);

    if(obj_Spell==null) return null;

    return String.valueOf(obj_Spell.getASpell());
  }
  
  /**
   * 获得字符串的拼音头
   * @param strWord           字符串
   * @return String            拼音头
   */
  public String getSpell(String strWord)
  {
    if(strWord==null) return null;
    if(strWord.equals("")) return null;

    char[] chr_Single = strWord.toCharArray();

    String str_Spell = "";

    for(int i=0; i<chr_Single.length; i++)
    {
      str_Spell += getSpell(chr_Single[i]);
    }

    return str_Spell;
  }
  
  /**
   * 获得字符串的全拼
   * @param strWord           字符串
   * @return String            全拼
   */
  public String getASpell(String strWord)
  {
    if(strWord==null) return null;
    if(strWord.equals("")) return null;

    char[] chr_Single = strWord.toCharArray();

    String str_ASpell = "";

    for(int i=0; i<chr_Single.length; i++)
    {
      str_ASpell += getASpell(chr_Single[i]);
    }

    return str_ASpell;
  }
  
  /**
   * 更新拼音
   * @param chrWord              字符
   * @param chrSpell             拼音头
   * @param strASpell            全拼
   */
  public synchronized void update(char chrWord,
                                  char chrSpell,
                                  String strASpell) throws Exception
  {
    update(new Spell(chrWord, chrSpell, strASpell));
    return;
  }
 
  /**
   * 更新拼音
   * @param objSpell              单个拼音对象
   */
  public synchronized void update(Spell objSpell) throws Exception
  {
    try
    {
      Spell obj_Spell = getObject(objSpell.getWord());

      DataStorage obj_DS = new DataStorage();
      
      /// 拼音缓存存在，更新
      if (obj_Spell!=null)
      {
        obj_Spell.setSpell(objSpell.getSpell());
        obj_Spell.setASpell(objSpell.getASpell());

        String str_Spell  = String.valueOf(objSpell.getSpell());
        String str_ASpell = String.valueOf(objSpell.getASpell());
        String str_Word   = String.valueOf(objSpell.getWord());

        String str_SQL = Common.UPDATE  + Table.SPELL  +
                         Common.S_SET   + Field.SPELL  + Common.EQUAL + General.addQuotes(str_Spell)  + Common.COMMA +
                                          Field.ASPELL + Common.EQUAL + General.addQuotes(str_ASpell) +
                         Common.S_WHERE + Field.WORD   + Common.EQUAL + General.addQuotes(str_Word);

        obj_DS.addSQL(str_SQL);
        obj_DS.runSQL();
      }

      /// 拼音缓存不存在，添加
      else
      {
        arr_Spell.add(objSpell);

        String str_SQL = Common.INSERT   + Table.SPELL      +
                           General.addBracket(Field.WORD    + Common.COMMA +
                                              Field.SPELL   + Common.COMMA +
                                              Field.ASPELL) +
                         Common.S_VALUES +
                           General.addBracket(General.addQuotes(String.valueOf(objSpell.getWord()))  + Common.COMMA +
                                              General.addQuotes(String.valueOf(objSpell.getSpell())) + Common.COMMA +
                                              General.addQuotes(objSpell.getASpell()));

        obj_DS.addSQL(str_SQL);
        obj_DS.runSQL();
      }

      return;
    }
    catch(Exception e)
    {
      throw new Exception(e.getMessage());
    }
  }
  
}
class Spell implements java.io.Serializable
{
  private static final long serialVersionUID = 8537233176930218357L;
  private char m_chr_Word;
  private char m_chr_Spell;
  private String m_str_ASpell;
  
  public Spell()
  {
  }
  
  public Spell(char chrWord, char chrSpell, String strASpell)
  {
    m_chr_Word = chrWord;
    m_chr_Spell = chrSpell;
    m_str_ASpell = strASpell;
  }

  public String getASpell()
  {
    return m_str_ASpell;
  }

  public void setASpell(String strASpell)
  {
    m_str_ASpell = strASpell;
  }

  public char getSpell()
  {
    return m_chr_Spell;
  }

  public void setSpell(char chrSpell)
  {
    m_chr_Spell = chrSpell;
  }

  public char getWord()
  {
    return m_chr_Word;
  }

  public void setWord(char chrWord)
  {
    m_chr_Word = chrWord;
  }

  public boolean equals(char chrValue)
  {
    if(m_chr_Word==chrValue) return true;
    return false;
  }
}
