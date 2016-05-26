<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
String isFirstLogin = (String)session.getAttribute("isFirstLogin");
String pwdValidTime = (String)session.getAttribute("pwdValidTime");
String userRealName = (String)session.getAttribute("userRealNameForIndexPage");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>运行监控系统－国网技术学院</title>


<link href="${pageContext.request.contextPath}/static/css/style_1.css" rel="stylesheet" type="text/css" id="css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css" />

<!--  new  -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/new/stylesheets/screen.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.11.0.min.js"></script>
<script src="${pageContext.request.contextPath}/static/new/javascript/echarts-allForIndex.js" charset="UTF-8" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/new/javascript/chart1JqForOld.js" charset="UTF-8" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/new/javascript/mapIndex.js" charset="UTF-8" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/static/new/javascript/WdatePicker/WdatePicker.js" charset="UTF-8" type="text/javascript"></script>

<!--  old  -->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/easyui-lang-zh_CN.js"></script>
<%-- <script type="text/javascript" src="${pageContext.request.contextPath}/static/hcharts/js/themes/green.js"></script> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/specialCharacter.js"></script>

<script type="text/javascript">
	// Navigation Menu
	var clientHeight = document.documentElement.clientHeight;
	var firstArr = new Array();
	var secondArr = new Array();
	var leftClicked = false;
	var currPanel = null;
	var tabsMenu,centerTabs;
	$(function() {
		//绑定待办任务点击事件
		messageClickFunction();
	
		initMenu();
		
		initTab();

		$(document).on("click",".left_menu_dt",function(){
			var $i = $(this).children('i');
			if ($i.hasClass('open')) {
				$i.removeClass('open');
				$(this).siblings('dd').css('display', 'none');
			} else {
				$i.addClass('open');
				$(this).siblings('dd').css('display', 'block');

			}
		});
		$("#left_menu_t").click(leftTreeTitleClicked);
		
		$("#mainTab").tabs({
			onSelect:tabSelected,
			onBeforeClose:tabClosed
		});
		$("#resetpwd").bind("click",function (){
			var createDiv = "<div id='resetpwds'><div/>";
			$(createDiv).dialog({
				title: '密码设置',
				width: 300,
				height: 250,
				closed: false,
				cache: false,
				href: '${pageContext.request.contextPath}/user/changePassword',
				modal : false,
				onClose : function() {
					$(this).dialog('destroy');
				} 
			});
		});
		if('<%=isFirstLogin%>' == '0')
		{
			changePwd('检测到你正在使用初始密码,请修改密码.');
		}
		if('<%=pwdValidTime%>' == '0')
		{
			changePwd('密码有效期已过,请修改密码.');
		}		
	});
	
	
	//绑定待办任务点击事件
	var messageClickFunction = function(){
		$('#messageInfo').unbind('click').click(function(){
			//点击综合管理
			 $('.nav5').trigger('click');
			 //待办任务管理
			 $('#left_menu_t_568').trigger('click');
			 //待办任务管理
			 $('#thirdNode681').trigger('click');
		});
	};
	
	
	
	function initTab(){
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
					//alert(opt.title+"~~~~~"+curTabTitle+"~~~~"+(opt.title != curTabTitle));
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
	
		centerTabs = $('#mainTab').tabs({
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
	}
	
	function tabSelected(title,index){
		
		//alert(title+"--"+index)
		var tab = $("#mainTab").tabs('getTab',title);
		
		var tabId = tab.panel('options').id;
		//alert(tabId)
	}
	
	function tabClosed(title,index){
		
		var tab = $("#mainTab").tabs('getTab',title);
		var tabId = tab.panel('options').id;
		if($("#thirdNode"+tabId)[0]){
			$("#thirdNode"+tabId).removeClass("cur");
		}
		currPanel = null;
	}
	
	function leftTreeTitleClicked(){
			if(!leftClicked){
				$("#left_menu li").slideUp(50);
				$(this).removeClass('left_menu_t').addClass('left_menu_t_clicked');
				leftClicked = true;
			}else{
				$("#left_menu li").slideDown(50);
				$(this).removeClass('left_menu_t_clicked').addClass('left_menu_t');
				leftClicked = false;
			}
	}
	
	function initMenu(){
		
		$.post("user/resources",{},function(data){
			
			drawTopNav(data,5);
		},"JSON");
	}
	
	function firstNodeClicked(){
		var id = $(this).attr("id");
		id = id.substring("firstNode".length);
		
		var sArr = firstArr[id].children;
		var html = [];
		for(var i=0;i<sArr.length;i++){
			html.push('<dl><dt style="cursor: pointer;" class="left_menu_dt"  id="left_menu_t_'+sArr[i].id+'">'+sArr[i].name+'<i class="icons-traUp"></i></dt>');
			for(var j=0;j<sArr[i].children.length;j++){
				html.push('<dd style="display: none; cursor: pointer;" id="thirdNode'+sArr[i].children[j].id+'" class="thirdNode" url="'+sArr[i].children[j].url+'"><i class="icons-navTip"></i>'+sArr[i].children[j].name+'</dd>');
			}
			html.push('</dl>');
		}
		$("#wrapNav").empty().html(html.join(''));
		
		$(".left_menu_t").bind("click",function(){
			var id = $(this).attr("id").substring("left_menu_t_".length);
			if($("ul#left_menu_"+id).is(":hidden")){
				$("ul#left_menu_"+id).show();
			}else{
				$("ul#left_menu_"+id).hide();
			}
		});
		
		$(".thirdNode").bind("click",thirdNodeClicked);
	}
	
	function drawTopNav(data,fNum){
		var html = [];
		
		for(var i=0;i<data.length&&i<fNum;i++){
			
			html.push('<li class="firstNode" id="firstNode'+data[i].id+'"><a href="'+(!data[i].url||data[i].url=='null'?'javascript:void(0);':data[i].url)+'" class="nav'+(i+1)+'">'+data[i].name+'</a>');
			firstArr[data[i].id] = data[i];
		}
		
		$("#nav").html(html.join(''));
		
		$(".firstNode").bind("click",firstNodeClicked);
		
		$(".firstNode").first().click();
	}
	
	function secondNodeClicked(){
		
		var id = this.id.substring("secondNode".length);
		if(!secondArr[id]){
			return;
		}
		
		$("#left_menu_t").html(secondArr[id].name);
		
		var html = [];
		for(var i=0;i<secondArr[id].children.length;i++){
			html.push('<li><a href="javascript:void(0)" id="thirdNode'+secondArr[id].children[i].id+'" class="thirdNode" url="'+secondArr[id].children[i].url+'">'+secondArr[id].children[i].name+'</a></li>');
		}
		$("#left_menu").html(html.join(''));
		
		$(".thirdNode").bind("click",thirdNodeClicked);
		
		if(secondArr[id].children.length==0){
			if(secondArr[id].url){
				addTab(secondArr[id].id,secondArr[id].name,secondArr[id].url);
			}
		}
	}
	
	function thirdNodeClicked(){
		if(currPanel){
			currPanel.removeClass('cur');
		}
		$(this).addClass("cur");
		currPanel = $(this);
		
		var url = $(this).attr('url');
		var name = $(this).text();
		var id = this.id.substring("thirdNode".length);
		if(url&&url!='null'){
		
			addTab(id,name,url);
		}
	}
	
	function addTab(id,name,url){
		name = name+"<span style=\"display:none\">"+id+"</span>";
		var tab = $('#mainTab').tabs('getTab', name);
			if(tab){
				$('#mainTab').tabs('select',name);
				return;
			}
	
		$('#mainTab').tabs('add',{
			    title:name,
			    content:'<iframe src="${pageContext.request.contextPath}' + url + '" frameborder="0" style="border:0;width:100%;min-height:100%;"></iframe>',
			    closable:true,
			    id:id,
			    tools:[{
			        iconCls:'icon-mini-refresh',
			        handler:function(){
			            refreshTab(name);
			        }
			    }]
			});
	}
	
	function refreshTab(title) {
		var tab = $('#mainTab').tabs('getTab', title);
		tab.panel('refresh');
	}
	
	function changePwd(title){
		var createDiv = "<div id='resetpwds'><div/>";
		$(createDiv).dialog({
			title: title,
			width: 300,
			height: 250,
			closed: false,
			cache: false,
			href: '${pageContext.request.contextPath}/user/changePassword',
			modal : false,
			closable: false
			/*onClose : function() {
				$(this).dialog('destroy');
			} */
		});
	}
</script>

<style type="">
	.layout-panel{
		overflow: visible;
	}
	.left_menu ul{
		margin: 1px 0;
		height: auto;
	}
	.left_menu_t{
		margin: 2px 0;
		cursor: pointer;
		background: url(static/images/b_2.png) 4px -70px no-repeat #A3DCD5;
	}
	.left_menu_t:HOVER{
		background-color: rgb(9,123,111);
		color: white;
		
	}
	ul.left_menu{
		display: none;
	}
</style>
<style>
 body{zoom:0.9;-ms-zoom:1;} 
</style>
</head>

<body class="easyui-layout" >

	<div class="header" data-options="region:'north',split:true,collapsible:false"
		style="overflow: visible; ">
		<div class="header_block">
			<div class="logo">&nbsp;</div>
			<div class="nav">
				<ul id="nav">
				</ul>
				
			</div>
			<div class="sys_menu" style= 'margin: 20px 0 0 0;'>
			<table>
				<tr>
				<td style="padding-left: 157px;padding-bottom: 20px;">欢迎您：<%=userRealName %></td>
			</tr>
			<tr>
				<td>
					<a href="#" id = "messageInfo" onclick="javascript:void(0)" style = "background: url(static/images/message.gif) left no-repeat;">待办任务:(<span id = "messageNum"></span>)</a>
					<a href="#" onclick="javascript:void(0)" id="resetpwd" style="background-position: left;background-image: url('${pageContext.request.contextPath}/static/images/iconfont-mima.png');">修改密码</a>
					<a href="${pageContext.request.contextPath}/logout" class="exit">退出</a>

				</td>
			</tr>
			</table>
			</div>
			<br clear="all" />
		</div>
		<div class="top_info"><!-- 
			<div class="notice">
				<span class="f_left">系统通知：</span>
				<marquee behavior="scroll" direction="left" scrolldelay="100"
					scrollamount="2" width="240" height="24" onmouseover="this.stop();"
					onmouseout="this.start()"> <a href="#">系统中任务筛选的SQL查询组合语句…</a> </marquee>
			</div> -->
		</div>
	</div>


	<div class="main" data-options="region:'center'" style="overflow: visible;">

		<div class="easyui-layout" data-options="fit:true">

			<div class="right_side" data-options="region:'center'">
				<div id="mainTab" class="easyui-tabs">
					<div class="content" title="首页" style ="margin-left:0px;" >	
					<div class="content_notUse" style="height:100%;">
							  					  
					<!-- 首页显示内容   begin -->	  
					<iframe src="${pageContext.request.contextPath}/indexMap/index"  frameborder="0" style="border:0;width:100%;min-height:100%;"></iframe>
					<!-- 首页显示内容   end -->
							        						        
					 </div>	
					</div>
				</div>
				
				<div id="tabsMenu" style="width: 120px;display:none;">
					<div id="refresh">刷新</div>
					<div class="menu-sep"></div>
					<div id="close">关闭</div>
					<div id="closeOther">关闭其他</div>
					<div id="closeAll">关闭所有</div>
				</div>
				
			</div>
			<div class="left_side" style="width: 247px" data-options="region:'west',split:true,title:'系统菜单'" >
				<!-- <div class="left_menu" id="second_left_menu">
				</div> -->

				<div class="wrapNav" id="wrapNav">
				</div>
				<!-- <div class="announcement">
					<p class="title">系统公告</p>
					<p>管理系统升级公告尊敬的客户: 您好! 为了给您提供更加优质便捷的服务,系统将开展测试……</p>
				</div> -->
			</div>
			
			<div data-options="region:'south'" style="overflow-y: hidden">
				<div class="clearboth"></div>
				<div class="footer">版权所有2015国网技术学院。Copyright @2015 State Grid Technology College. All rights reserved.</div>
			</div>
		</div>

	</div>

</body>
</html>
