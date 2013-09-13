package org.ptbank.cache;

import java.sql.ResultSet;

import org.ptbank.declare.Field;


public class MUnitInfo implements java.io.Serializable
{
  private static final long serialVersionUID = 4241548952626305398L;

  private String m_str_Valid;
  private String m_str_MUnitName;
  private String m_str_MUnitID;
  private String m_str_MType;
  private String m_str_MSUnitID;
  private String m_str_MLevel;
  private String m_str_MDes;

  public String getMDes()
  {
    return m_str_MDes;
  }

  public void setMDes(String strMDes)
  {
    m_str_MDes = strMDes;
  }

  public String getMLevel()
  {
    return m_str_MLevel;
  }

  public void setMLevel(String strMLevel)
  {
    m_str_MLevel = strMLevel;
  }

  public String getMSUnitID()
  {
    return m_str_MSUnitID;
  }

  public void setMSUnitID(String strMSUnitID)
  {
    m_str_MSUnitID = strMSUnitID;
  }

  public String getMType()
  {
    return m_str_MType;
  }

  public void setMType(String strMType)
  {
    m_str_MType = strMType;
  }

  public String getMUnitID()
  {
    return m_str_MUnitID;
  }

  public void setMUnitID(String strMUnitID)
  {
    m_str_MUnitID = strMUnitID;
  }

  public String getMUnitName()
  {
    return m_str_MUnitName;
  }

  public void setMUnitName(String strMUnitName)
  {
    m_str_MUnitName = strMUnitName;
  }


  public String getValid()
  {
    return m_str_Valid;
  }

  public void setValid(String strValid)
  {
    m_str_Valid = strValid;
  }
  
  public void setValueByKey(String strKey, String strColumnValue)
  {
    if (strKey.equalsIgnoreCase(Field.MUNITID))
    {
      setMUnitID(strColumnValue);
    }
    if(strKey.equalsIgnoreCase(Field.MUNITNAME))
    {
      setMUnitName(strColumnValue);
    }
    if(strKey.equalsIgnoreCase(Field.MTYPE))
    {
      setMType(strColumnValue);
    }
    if(strKey.equalsIgnoreCase(Field.MDES))
    {
      setMDes(strColumnValue);
    }
    if(strKey.equalsIgnoreCase(Field.MSUNITID))
    {
      setMSUnitID(strColumnValue);
    }
    if(strKey.equalsIgnoreCase(Field.VALID))
    {
    setValid(strColumnValue);
    }
    if(strKey.equalsIgnoreCase(Field.MLEVEL))
    {
    setMLevel(strColumnValue);
    }
  } 
  
  public void setValueByResult(ResultSet rst)
  {
    try
    {
      String str_ColumnName;
      String str_ColumnValue;

      for(int i=1; i<=rst.getMetaData().getColumnCount(); i++)
      {
        str_ColumnName = rst.getMetaData().getColumnName(i).toLowerCase(); 
        str_ColumnValue = rst.getString(i)==null ? "" : rst.getString(i).toString();
        setValueByKey(str_ColumnName, str_ColumnValue);
      }
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
  }
}
