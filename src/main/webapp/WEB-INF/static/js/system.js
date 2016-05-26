/**
 * 包含easyui的扩展和常用的方法
 */

var easyui = $.extend({}, easyui);/* 定义全局对象，类似于命名空间或包的作用 */
/**
 * dialog扩展
 */
easyui.dialog = function(options) {
	var opts = $.extend({
		modal : true,
		onClose : function() {
			$(this).dialog('destroy');
		}
	}, options);
	var createDiv = "<div id='"+Math.random()*100+"'><div/>";
	return $(createDiv).dialog(opts);
};
/**
 * datagrid 设置默认属性
 */
var gridHeight = document.documentElement.clientHeight;
var pageSize = Math.floor((gridHeight-140)/22)-1;//向下取整
if(pageSize<1){
	pageSize=1;
}
//$.fn.datagrid.defaults.multiSort=true;
$.fn.datagrid.defaults.scrollbarSize=0;
$.fn.datagrid.defaults.pagination=true;
//$.fn.datagrid.defaults.sortable=true;
$.fn.datagrid.defaults.pageSize=pageSize;
$.fn.datagrid.defaults.pageList=[pageSize,10,20,30,40,50,100];
$.fn.datagrid.defaults.fitColumns=true;
$.fn.datagrid.defaults.rownumbers=true;
$.fn.datagrid.defaults.singleSelect=true;
$.fn.datagrid.defaults.fit=true;
$.fn.datagrid.defaults.checkbox=true;
$.fn.datagrid.defaults.method='post';
//$.fn.datagrid.defaults.loadMsg='加载中....';
//开启右键事件菜单-页面中右键事件菜单div的id必须为rm
//$.fn.datagrid.defaults.onRowContextMenu=onRowContextMenu;
//$.fn.treegrid.defaults.onContextMenu=onRowContextMenu;
$.fn.datagrid.defaults.onHeaderContextMenu=createGridHeaderContextMenu;
$.fn.treegrid.defaults.onHeaderContextMenu=createGridHeaderContextMenu;

$.fn.treegrid.defaults.scrollbarSize=0;
$.fn.treegrid.defaults.pagination=true;
$.fn.treegrid.defaults.sortable=true;
$.fn.treegrid.defaults.pageSize=10;
$.fn.treegrid.defaults.pageList=[10,10,20,30,40,50,100];

/**
 * 右键按钮事件
 */

//列表头部事件菜单
function onHeaderContextMenu(e, field){
	e.preventDefault();
	if (!cmenu){
		createColumnMenu();
	}
	cmenu.menu('show', {
		left:e.pageX,
		top:e.pageY
	});
};
//扩展分页默认菜单
/*$.fn.pagination.defaults.buttons=[{
	iconCls:'icon-excel',
	text:'导出',
	handler:function(){
	}
}];*/

/**
* 为datagrid、treegrid增加表头菜单，用于显示或隐藏列，注意：冻结列不在此菜单中
*/
function createGridHeaderContextMenu (e, field) {
	e.preventDefault();
	var grid = $(this);/* grid本身 */
	var headerContextMenu = this.headerContextMenu;/* grid上的列头菜单对象 */
	if (!headerContextMenu) {
		var tmenu = $('<div style="width:100px;"></div>').appendTo('body');
		var fields = grid.datagrid('getColumnFields');
		for ( var i = 0; i < fields.length; i++) {
			if(fields[i].toString()!="ck"){//checkbox框默认没有
				var fildOption = grid.datagrid('getColumnOption', fields[i]);
				if (!fildOption.hidden) {
					$('<div iconCls="icon-ok" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
				} else {
					$('<div iconCls="icon-empty" field="' + fields[i] + '"/>').html(fildOption.title).appendTo(tmenu);
				}	
			}
		}
		headerContextMenu = this.headerContextMenu = tmenu.menu({
			onClick : function(item) {
				if(!item.checkbox){
					var field = $(item.target).attr('field');
					if (item.iconCls == 'icon-ok') {
						grid.datagrid('hideColumn', field);
						$(this).menu('setIcon', {
							target : item.target,
							iconCls : 'icon-empty'
						});
					} else {
						grid.datagrid('showColumn', field);
						$(this).menu('setIcon', {
							target : item.target,
							iconCls : 'icon-ok'
						});
					}
				}
			}
		});
	}
	headerContextMenu.menu('show', {
		left : e.pageX,
		top : e.pageY
	});
};
/**
 * 扩展窗口移动事件
 */
var easyuiPanelOnMove = function(left, top) {
	var l = left;
	var t = top;
	if (l < 1) {
		l = 1;
	}
	if (t < 1) {
		t = 1;
	}
	var width = parseInt($(this).parent().css('width')) + 14;
	var height = parseInt($(this).parent().css('height')) + 14;
	var right = l + width;
	var buttom = t + height;
	var browserWidth = $(window).width();
	var browserHeight = $(window).height();
	if (right > browserWidth) {
		l = browserWidth - width;
	}
	if (buttom > browserHeight) {
		t = browserHeight - height;
	}
	$(this).parent().css({/* 修正面板位置 */
		left : l,
		top : t
	});
};

$.fn.dialog.defaults.onMove = easyuiPanelOnMove;
$.fn.window.defaults.onMove = easyuiPanelOnMove;
$.fn.panel.defaults.onMove = easyuiPanelOnMove;


/**
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 * 扩展validatebox，添加验证两次密码功能
 */
$.extend($.fn.validatebox.defaults.rules, {
	eqPassword : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '密码不一致！'
	}
});


/**
 * panel关闭时回收内存，主要用于layout使用iframe嵌入网页时的内存泄漏问题
 * 
 * @author 孙宇
 * 
 * @requires jQuery,EasyUI
 * 
 */
$.extend($.fn.panel.defaults, {
	onBeforeDestroy : function() {
		var frame = $('iframe', this);
		try {
			if (frame.length > 0) {
				for (var i = 0; i < frame.length; i++) {
					frame[i].src = '';
					frame[i].contentWindow.document.write('');
					frame[i].contentWindow.close();
				}
				frame.remove();
				if (navigator.userAgent.indexOf("MSIE") > 0) {// IE特有回收内存方法
					try {
						CollectGarbage();
					} catch (e) {
					}
				}
			}
		} catch (e) {
		}
	}
});

$.extend($.fn.datagrid.defaults, {
	loadMsg : '数据加载中....'
});
/** 页面显示操作信息*/
function creater(value,row,index){
	var updateInfo = row.updateInfo;
	return updateInfo.creater;
}
function createTime(value,row,index){
	var updateInfo = row.updateInfo;
	return updateInfo.createTime;
}
function lastOperator(value,row,index){
	var updateInfo = row.updateInfo;
	return updateInfo.lastOperator;
}
function modifyTime(value,row,index){
	var updateInfo = row.updateInfo;
	return updateInfo.modifyTime;
}

