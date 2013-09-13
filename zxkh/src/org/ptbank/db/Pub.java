package org.ptbank.db;

import javax.naming.*;
import java.sql.*;
import javax.transaction.UserTransaction;

public class Pub
{
  public static Context getContext()
  {
    try
    {
      return DBConnectionManager.getInstance().getContext();
    }
    catch(Exception e)
    {
      e.printStackTrace();
    }
    return null;
  }
  
  public static UserTransaction getTransaction()
  {
    try 
    {
      return (UserTransaction) getContext().lookup("javax.transaction.UserTransaction");
    }
    catch (Exception ex)
    {
      ex.printStackTrace(System.out);
      return null;
    }
  }
  
  public static String executeProcedure(Connection con,
                                        String procName,
                                        Object[] para,
                                        int[] outIndex) throws Exception
  {
    CallableStatement proc = null;
    int len = 0;
    len = para.length;

    StringBuffer Statement = new StringBuffer("{ call " + procName + "(");

    for (int i=0; i<len; i++)
    {
      if (i==len-1)
      {
        Statement.append("?)}");
      }
      else
      {
        Statement.append("?,");
      }
    }
    
    try
    {
      proc = con.prepareCall(Statement.toString());
    
      if (outIndex!=null)
      {  
        for (int i=0; i<outIndex.length; i++)
        {
          proc.registerOutParameter(outIndex[i], Types.VARCHAR);
        }
      }
      
      for (int i=0; i<len; i++)
      {
        if (para[i]==null)
          proc.setNull(i + 1, Types.VARCHAR);
        else
          proc.setObject(i + 1, para[i]);
      }
      
      proc.execute();

      if (outIndex!=null)
      {  
        for(int i=0; i<outIndex.length; i++)
        {
          para[outIndex[i]-1] = proc.getString(outIndex[i]);
        }
      }
    }
    catch (SQLException ex)
    {
      try
      {
        if (proc != null)
          proc.close();
      }
      catch (SQLException ex1)
      {
      }

      throw ex;
    }

    return null;
  }

}
