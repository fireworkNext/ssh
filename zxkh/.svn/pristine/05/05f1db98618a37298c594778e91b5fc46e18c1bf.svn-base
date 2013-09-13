/*
 * extjs中的grid显示实际行号扩展
 */
Ext.grid.PageRowNumberer = Ext.extend(Ext.grid.RowNumberer, {
	width : 40,
	renderer : function(value, cellmeta, record, rowIndex, columnIndex, store) {
		if (store.lastOptions.params != null) {
			var pageindex = store.lastOptions.params.start;
			return pageindex + rowIndex + 1;
		} else {
			return rowIndex + 1;
		}
	}
});

/*
 * 重载RowNumberer方法支持行号自增
 */

Ext.grid.RowNumberer = Ext.extend(Ext.grid.RowNumberer, {
	width : 40,
	renderer : function(value, cellmeta, record, rowIndex, columnIndex, store) {
		if (store.lastOptions.params != null) {
			var pageindex = store.lastOptions.params.start;
			return pageindex + rowIndex + 1;
		} else {
			return rowIndex + 1;
		}
	}
});
