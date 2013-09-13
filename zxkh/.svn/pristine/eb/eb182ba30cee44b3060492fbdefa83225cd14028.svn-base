<%@ page language="java" pageEncoding="UTF-8"%>
<!-- window开始 -->
<div iconCls="icon-panel" id="ProWin" xtype="window" width="300" height="200" title="修改学生" resizable="true" modal="true">
  <div region="center" xtype="panel" title="" border="false" autoScroll="true">
    <div xtype="tbar">
      <div text="->"></div>
      <div iconCls="icon-ok2" id="cmdOK" text="确  定" onEfsClick="doEditSub()"></div>
    </div>
    <form id="frmData" class="efs-box" method="post" url="" onEfsSuccess="frmPostSubBack(true)" onEfsFailure="frmPostSubBack(false)">
      <TABLE class="formArea">
        <tr>
          <td labelFor="ptype">商品类型</td>
          <td><input type="text" kind="dic" src="DIC_PTYPE" fieldname="PRODUCT/PTYPE" id="ptype" must="true"></td>
        </tr>
        <tr>
          <td labelFor="pname">商品名称</td>
          <td><input type="text" kind="text" fieldname="PRODUCT/PNAME" id="pname" must="true"></td>
        </tr>
        <tr>
          <td>商品价格</td>
          <td><input type="text" kind="float" fieldname="PRODUCT/PRICE" datatype="1"></td>
        </tr>
        <tr>
          <td>商品数量</td>
          <td><input type="text" kind="int" fieldname="PRODUCT/PNUM" datatype="1"></td>
        </tr>
      </TABLE>
      <input type="hidden" kind="text" fieldname="PRODUCT/PID" operation="1" state="5">
    </form>            
  </div>
</div>
<!-- window结束 -->
