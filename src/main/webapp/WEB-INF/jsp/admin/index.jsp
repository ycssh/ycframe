<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<title>后台管理V-1.0</title>
<jsp:include page="../inc.jsp"></jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree3.5/css/zTreeStyle/zTreeStyle.css"></link>
<script src="${pageContext.request.contextPath}/static/zTree3.5/js/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript">
var centerTabs;
var tabsMenu;
$(function() {
	tabsMenu = $('#tabsMenu').menu({
		onClick : function(item) {
			var curTabTitle = $(this).data('tabTitle');
			var type = $(item.target).attr('id');
			if (type === 'refresh') {
				refreshTab(curTabTitle);
				return;
			}

			if (type === 'close') {
				var t = centerTabs.tabs('getTab', curTabTitle);
				if (t.panel('options').closable) {
					centerTabs.tabs('close', curTabTitle);
				}
				return;
			}

			var allTabs = centerTabs.tabs('tabs');
			var closeTabsTitle = [];

			$.each(allTabs, function() {
				var opt = $(this).panel('options');
				if (opt.closable && opt.title != curTabTitle && type === 'closeOther') {
					closeTabsTitle.push(opt.title);
				} else if (opt.closable && type === 'closeAll') {
					closeTabsTitle.push(opt.title);
				}
			});

			for ( var i = 0; i < closeTabsTitle.length; i++) {
				centerTabs.tabs('close', closeTabsTitle[i]);
			}
		}
	});

	centerTabs = $('#centerTabs').tabs({
		fit : true,
		border : false,
		onContextMenu : function(e, title) {
			e.preventDefault();
			tabsMenu.menu('show', {
				left : e.pageX,
				top : e.pageY
			}).data('tabTitle', title);
		}
	});
});
function addTab(node) {
	var nodeName = node.name+"-"+node.id;

	if (centerTabs.tabs('exists', nodeName)) {
		centerTabs.tabs('select', nodeName);
	} else {
			var content='<iframe src="${pageContext.request.contextPath}' + node.url + '" frameborder="0" style="border:0;width:100%;height:99.4%;"></iframe>';
			centerTabs.tabs('add', {
				title : nodeName,
				closable : true,
				iconCls : node.iconCls,
				//如果是url就不取项目路径
				content : content,
				tools : [ {
					iconCls : 'icon-reload',
					handler : function() {
						refreshTab(nodeName);
					}
				} ]
			});
	}
}

$(document).ready(function(){
	var content='<iframe src="${pageContext.request.contextPath}/welcome" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>';
	centerTabs.tabs('add', {
		title : "首页",
		//iconCls : node.iconCls,
		//如果是url就不取项目路径
		content : content
	}); 
});

function refreshTab(title) {
	var tab = centerTabs.tabs('getTab', title);
	centerTabs.tabs('update', {
		tab : tab,
		options : tab.panel('options')
	});
}

function pwd(){
	parent.easyui.dialog({
		title: '密码设置',
		url:"<c:url value='/user/changePassword'/>",
		width: 300,
		height: 250,
		closed: false,
		cache: false,
		modal: true
	});
}
var ctrlTree;


var setting = {
	async : {
		enable : true,
		url : "<c:url value='/layout/menus'/>",
		dataType : "json",
		type : 'get',
		autoParam : [ "id" ]
	},
	callback : {
		onClick : zTreeOnClick
	},
	data : {
		key:{
			name:"name"
		},
		simpleData : {
			enable : true,
			idKey : "id",
			pIdKey : "parentId",
			rootPId : 0
		}
	},
	edit:{
		enable:true,
		showRemoveBtn:false,
		showRenameBtn:false
	}
};

/**Tree单击事件*/
function zTreeOnClick(event, treeId, treeNode) {
	if(treeNode.open==false){
		if(treeNode.url){
			addTab(treeNode);
		}
	}
}

$(function() {
	$.fn.zTree.init($("#ctrlTree"), setting);
});
</script>
</head>

<body class="easyui-layout">
	<div data-options="region:'north'" style="height:78px;background:#B3DFDA;padding:0px">
		<div class="easyui-layout" data-options="fit:true,border:false">
			<table border='0' height="100%" width="100%" style="background: url('${pageContext.request.contextPath}login/images/logo_bg.png');">
				<tr>
					<td><p style="font-size: 25px;font-weight: bold;color: #FFFFFF;font-family: 黑体;">培训调度运行监控平台</p></td>
					<td width="260px" valign="top">
						<div style="height:  25px; font-size: 12px;color: #FFFFFF;margin-top: 0px;text-align:right;"><span>欢迎你：[<shiro:principal/>]</span><span style="margin-left: 10px;cursor: pointer;" onclick="pwd()">[修改密码]</span>
						
						<span style="margin-left: 10px;cursor: pointer;">[<a href="${pageContext.request.contextPath}/logout">退出</a>]</span></div>
						<div style="height:  25px; font-size: 12px;color: #FFFFFF;text-align:right;"><span></span></div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div data-options="region:'west',split:true,title:' '" style="width:200px;padding:10px;">
		<div title="系统菜单" data-options="isonCls:'icon-save',tools : [ {
						iconCls : 'icon-reload',
						handler : function() {
							 ctrlTree.tree('reload');
						}
					}]">
				<ul id="ctrlTree"  class="ztree" style="margin-top: 5px;"></ul>
		</div>
	</div>
	<div data-options="region:'center'" style="overflow: hidden;">
		<div id="centerTabs"></div>
		<div id="tabsMenu" style="width: 120px;display:none;">
			<div id="refresh">刷新</div>
			<div class="menu-sep"></div>
			<div id="close">关闭</div>
			<div id="closeOther">关闭其他</div>
			<div id="closeAll">关闭所有</div>
		</div>
	</div>
	</body>
</html>