package org.ptbank.declare;

/**
 * 定义表名常量
 */
public class Table
{
  
  /// 系统字典表名称定义
  /// 
  /// 系统字典都是从系统的相关数据表中虚拟出来的字典表，可以实现普通字典的翻译功能
  public static final String DIC_MANAGEUNIT                 = "MANAGEUNIT";                   /// 管理单位字典
  public static final String DIC_AFFAIRTYPE                 = "AFFAIRTYPE";                   /// 事务类型字典
  public static final String DIC_EVENTTYPE                  = "EVENTTYPE";                    /// 事件类型字典
  public static final String DIC_USERLIST                   = "USERLIST";                     /// 用户姓名字典

  /// 普通字典表名称定义
  public static final String DIC_ABLE                       = "DIC_ABLE";                     /// 能否
  public static final String DIC_CODE                       = "DIC_CODE";                     /// 行政区划
  public static final String DIC_DUTY                       = "DIC_DUTY";                     /// 职务
  public static final String DIC_EDUCATION                  = "DIC_EDUCATION";                /// 文化程度
  public static final String DIC_GENDER                     = "DIC_GENDER";                   /// 性别
  public static final String DIC_LOCUSAREA                  = "DIC_LOCUSAREA";                /// 所在地区
  public static final String DIC_LOGOUT_STATUS              = "DIC_LOGOUT_STATUS";            /// 注销状态表
  public static final String DIC_MARRIAGE                   = "DIC_MARRIAGE";                 /// 婚姻状况
  public static final String DIC_NATIVE                     = "DIC_NATIVE";                   /// 民族
  public static final String DIC_OCCUPATION                 = "DIC_OCCUPATION";               /// 职业
  public static final String DIC_TRUEFALSE                  = "DIC_TRUEFALSE";                /// 是否
  public static final String DIC_TYPE_FLAG                  = "DIC_TYPE_FLAG";                /// 人员分类表(按区域)
  public static final String DIC_USERTYPE                   = "DIC_USERTYPE";                 /// 用户类型
  public static final String DIC_VALID                      = "DIC_VALID";                    /// 有效
  public static final String DIC_YESORNO                    = "DIC_YESORNO";                  /// 是否
  public static final String DIC_CASESTATE                  = "DIC_CASESTATE";                /// 案件状态
  public static final String DIC_CLAN                       = "DIC_CLAN";                     /// 政治面貌 
  public static final String DIC_STREAMTYPE                 = "DIC_STREAMTYPE";               /// 工作流类型
  public static final String DIC_TASKSTATE                  = "DIC_TASKSTATE";                /// 任务状态
  public static final String DIC_AFFAIRTYPEMODE             = "DIC_AFFAIRTYPEMODE";           /// 任务状态
  public static final String DIC_OPERATIONTYPE              = "DIC_OPERATIONTYPE";            /// 任务状态
  public static final String DIC_MLEVEL                     = "DIC_MLEVEL";                   /// 单位级别
  public static final String DIC_MTYPE                      = "DIC_MTYPE";                    /// 单位类型
  public static final String DIC_DICEDITABLE                = "DIC_DICEDITABLE";              /// 字典是否可修改
  public static final String DIC_IDPARA                     = "DIC_IDPARA";                   /// 编码规则字典
  
  /// 视图定义
  public static final String VW_USERRIGHT                   = "VW_USERRIGHT";                 /// 用户实际权限视图
  public static final String VW_USERRIGHTTREE               = "VW_USERRIGHTTREE";             /// 用户功能树视图
  public static final String VW_EVENTTYPE                   = "VW_EVENTTYPE";                 /// 事件类型视图
  public static final String VW_ROLEPOWER                   = "VW_ROLEPOWER";                 /// 角色权限视图
  public static final String VW_ROLEUSER                    = "VW_ROLEUSER";                  /// 角色用户视图
  public static final String VW_USERLIST                    = "VW_USERLIST";                  /// 用户视图
  public static final String VW_WF_CONFIG                   = "VW_WF_CONFIG";                 /// 工作流配置视图
  public static final String VW_TASKSTATE                   = "VW_TASKSTATE";                 /// 任务信息视图
      

  /// 数据表别名定义
  public static final String S                              = "s";
  
  /// 数据表定义
  public static final String MAXID                          = "MAXID";                        /// 最大编号分配表
  public static final String MAXIDTYPE                      = "MAXIDTYPE";                    /// 最大编号定义表
  public static final String SPELL                          = "SPELL";                        /// 拼音表
  public static final String SYSPARA                        = "SYSPARA";                      /// 系统参数表
  public static final String SYSPARA1                       = "SYSPARA1";                     /// 系统参数表
  public static final String ERRLOG                         = "ERRLOG";                       /// 错误日志表
  public static final String SYSLOG                         = "SYSLOG";                       /// 系统日志表

  public static final String AFFAIRTYPE                     = "AFFAIRTYPE";                   /// 事务类型
  public static final String EVENTTYPE                      = "EVENTTYPE";                    /// 事件类型
  public static final String WF_DEFINE                      = "WF_DEFINE";                    /// 工作流模板定义表
  public static final String WF_TEMPLATE                    = "WF_TEMPLATE";                  /// 工作流模板表
  public static final String WF_CONFIG                      = "WF_CONFIG";                    /// 工作流配置表
  
  public static final String ROLEBASIC                      = "ROLEBASIC";                    /// 角色信息表
  public static final String USERLIST                       = "USERLIST";                     /// 用户信息表
  public static final String ROLEPOWER                      = "ROLEPOWER";                    /// 角色权限表
  public static final String ROLEUSER                       = "ROLEUSER";                     /// 角色用户关系表

  public static final String AFFAIR                         = "AFFAIR";                       /// 事务信息表
  public static final String EVENT                          = "EVENT";                        /// 事件信息表
  public static final String TASKSTATE                      = "TASKSTATE";                    /// 任务信息表
  public static final String MSGINFO                        = "MSGINFO";                      /// 用户消息表
  public static final String SQLSTORAGE                     = "SQLSTORAGE";                   /// 事件数据操作语句

  public static final String DICLIST                        = "DICLIST";                      /// 普通字典定义表
  public static final String DICDATA                        = "DICDATA";                      /// 普通字典数据表

  public static final String MANAGEUNIT                     = "MANAGEUNIT";                   /// 管理单位表


  public static final String EVENTSTREAM                    = "EVENTSTREAM";                   ///   事件流
  public static final String BAR                            = "BAR";                           ///   间隔条
  public static final String EVENTSTREAMGROUP               = "EVENTSTREAMGROUP";              ///   事件流组 

  public static final String PERSON                         = "PERSON";                        ///  学生档案表
  public static final String CLASSES 						            = "CLASSES";					   ///  班级信息表
  public static final String SBJBXX                         = "SBJBXX";                        ///  设备基本信息表
  public static final String SBKZXX                         = "SBKZXX";                        ///  设备扩展信息表
  public static final String SBJBXXKZXX                         = "SBJBXXKZXX";                        ///  设备基本信息扩展信息表
}
