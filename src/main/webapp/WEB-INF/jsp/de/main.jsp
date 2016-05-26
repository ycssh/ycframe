<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<base href="<%=basePath%>">
<title>数据交换接口控制台</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.11.0.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/jui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/jui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/console/css/main.css">
<%-- <script type="text/javascript" src="<%=basePath %>static/jui/jquery.min.js"></script> --%>
<script type="text/javascript" src="<%=basePath %>static/jui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/easyui-lang-zh_CN.js"></script>

<script type="text/javascript" src="<%=basePath %>static/console/js/dataMoverInfo.js"></script>
<script type="text/javascript" src="<%=basePath %>static/console/js/taskLog.js"></script>
<script type="text/javascript" src="<%=basePath %>static/console/js/st.js"></script>
<script type="text/javascript" src="<%=basePath %>static/console/js/tasklogstat.js"></script>
<script type="text/javascript" src="<%=basePath %>static/console/js/taskrunning.js"></script>
<script type="text/javascript" src="<%=basePath %>static/console/js/taskstoped.js"></script>
<script type="text/javascript" src="<%=basePath %>static/console/js/tableinfo.js"></script>
<script type="text/javascript" src="<%=basePath %>static/console/js/kjcz.js"></script>

<script type="text/javascript" src="<%=basePath %>static/console/js/dist.js"></script>
</head>

<body class="easyui-layout">

	<div data-options="region:'north',split:true" style="height:250px;"
		style="padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
		
		
		
			<div data-options="region:'east',split:true,title:'任务监控'"
				title="East" style="width:900px;padding:5px">

				<!-- ToolBar -->
				<!-- <a href="javascript:void(0)" id="mb" class="easyui-menubutton"
					data-options="menu:'#mm',iconCls:'icon-edit'">操作</a> -->
				<div id="tbety_toolbar">
					<div id="tbety_opr_add" class="easyui-linkbutton"
						data-options="iconCls:'icon-add',plain:true">新增</div>
					<div id="tbety_opr_edit" class="easyui-linkbutton"
						data-options="iconCls:'icon-edit',plain:true">修改</div>
					<div id="tbety_opr_delete" class="easyui-linkbutton"
						data-options="iconCls:'icon-remove',plain:true">删除</div>
					<div id="tbety_opr_refresh" class="easyui-linkbutton"
						data-options="iconCls:'icon-reload',plain:true">刷新</div>
					<div id="tbety_opr_run" class="easyui-linkbutton"
						data-options="iconCls:'icon-ok',plain:true">立即执行</div>
				</div>

				<!-- DataGrid -->
				<table id="tbety_grid"></table>
			</div>
			
			
			
			<div data-options="region:'center',split:true,title:'实体监控'"
				title="West" style="width:50px;padding:5px;">
				<!-- ToolBar -->
				<div id="st_toolbar">
					<div id="st_opr_refresh" class="easyui-linkbutton"
						data-options="iconCls:'icon-reload',plain:true">刷新</div>
				</div>
				<!-- DataGrid -->
				<table id="st_grid"></table>
			</div>
			
			
		</div>
	</div>
	<div data-options="region:'south',split:true" style="height:20px;"></div>
	<div data-options="region:'east',split:true" title="快捷操作"
		style="width:100px;">
		<div id="kjcz_opr_startAllIncre" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok',plain:true,iconAlign:'top'">启动所有增量任务</div>
		<div id="kjcz_opr_clearAllEntities" class="easyui-linkbutton"
			data-options="iconCls:'icon-remove',plain:true,iconAlign:'top'">清空所有实体表信息</div>
		<div id="kjcz_opr_remakeAllEntities" class="easyui-linkbutton"
			data-options="iconCls:'icon-tip',plain:true,iconAlign:'top'">重新生成所有实体表信息</div>
	</div>
	<div data-options="region:'west',split:true" title="欢迎信息"
		style="width:100px;">
		<div style="margin: 5px">
			当前登录用户：<%=SecurityUtils.getSubject().getPrincipal()%></div>
	</div>
	<div data-options="region:'center',split:false" style="padding:5px;">

		<div id="mainShowPanel" class="easyui-tabs"
			data-options="tabPosition:'top'">

			<div title="任务执行日志" style="padding:5px;">
				<div id="leftTabPanel" class="easyui-tabs"
					data-options="tabPosition:'left'">

					<div title="日志详情" style="padding:5px;">
						<!-- ToolBar -->
						<div id="tasklog_toolbar">
							<div id="tasklog_opr_scan" class="easyui-linkbutton"
								data-options="iconCls:'icon-tip',plain:true">查看详细</div>
							<div id="tasklog_opr_delete" class="easyui-linkbutton"
								data-options="iconCls:'icon-remove',plain:true">删除日志</div>
							<div id="tasklog_opr_refresh" class="easyui-linkbutton"
								data-options="iconCls:'icon-reload',plain:true">刷新</div>
							<div id="tasklog_opr_clear" class="easyui-linkbutton"
								data-options="iconCls:'icon-no',plain:true">清空日志</div>
						</div>

						<!-- DataGrid -->
						<table id="tasklog_grid"></table>


					</div>
					<div title="日志统计" style="padding:5px;">
						<!-- ToolBar -->
						<div id="tasklogstat_toolbar">
							<div id="tasklogstat_opr_refresh" class="easyui-linkbutton"
								data-options="iconCls:'icon-reload',plain:true">刷新</div>
						</div>

						<!-- DataGrid -->
						<table id="tasklogstat_grid"></table>


					</div>

					<div title="任务执行监控" style="padding:5px;">
						<div class="easyui-tabs" data-options="tabPosition:'top'">
							<div title="正在运行的任务" style="padding:5px;">

								<!-- ToolBar -->
								<div id="taskrunning_toolbar">
									<div id="taskrunning_opr_refresh" class="easyui-linkbutton"
										data-options="iconCls:'icon-reload',plain:true">刷新</div>
									<div id="taskrunning_opr_stop" class="easyui-linkbutton"
										data-options="iconCls:'icon-no',plain:true">停止任务</div>
									<div id="taskrunning_opr_delete" class="easyui-linkbutton"
										data-options="iconCls:'icon-remove',plain:true">删除任务</div>
								</div>

								<!-- DataGrid -->
								<table id="taskrunning_grid"></table>
							</div>

							<div title="已经停止的任务" style="padding:5px;">
								<!-- ToolBar -->
								<div id="taskstoped_toolbar">
									<div id="taskstoped_opr_refresh" class="easyui-linkbutton"
										data-options="iconCls:'icon-reload',plain:true">刷新</div>
									<div id="taskstoped_opr_run" class="easyui-linkbutton"
										data-options="iconCls:'icon-tip',plain:true">运行任务</div>
									<div id="taskstoped_opr_delete" class="easyui-linkbutton"
										data-options="iconCls:'icon-remove',plain:true">删除任务</div>
								</div>

								<!-- DataGrid -->
								<table id="taskstoped_grid"></table>
							</div>
						</div>

					</div>

					<div title="实体表监控" style="padding:5px;">

						<!-- ToolBar -->
						<div id="tableinfo_toolbar">
							<div id="tableinfo_opr_refresh" class="easyui-linkbutton"
								data-options="iconCls:'icon-reload',plain:true">刷新</div>
							<div id="tableinfo_opr_clear" class="easyui-linkbutton"
								data-options="iconCls:'icon-remove',plain:true">清空表数据</div>
							<div id="tableinfo_opr_remake" class="easyui-linkbutton"
								data-options="iconCls:'icon-tip',plain:true">重新生成表数据</div>
						</div>

						<table id="tableinfo_grid"></table>
					</div>
					
					<div title="数据差异比较" style="padding:5px;">

						<!-- ToolBar -->
						<div id="dist_toolbar">
							<div id="dist_opr_refresh" class="easyui-linkbutton"
								data-options="iconCls:'icon-reload',plain:true">刷新</div>
							<div id="dist_opr_run" class="easyui-linkbutton"
								data-options="iconCls:'icon-remove',plain:true">同步选中项</div>
							<select id="dist_filter" class="easyui-combobox" style="width:200px;">
							    <option value="0">显示全部</option>
							    <option value="1">显示差异项</option>
							    <option value="2">显示一致项</option>
							</select>
						</div>

						<table id="dist_grid"></table>
					</div>

				</div>
			</div>

		</div>



	</div>











	<!-- Window -->
	<div id="tbety_win" style="display: none;">

		<form id="tbety_form" method="post">

			<input class="easyui-validatebox" type="text" name="id"
				style="width:350;display: none;" />
			<input class="easyui-validatebox" type="text" name="isDap"
				style="width:350;display: none;" value="false" />

			<fieldset>
				<legend>实体表信息</legend>
				<table width="100%">
					<tr>
						<td><label for="name">实体表名:</label>
						</td>
						<td><input class="easyui-validatebox" type="text" name="name"
							data-options="required:true" style="width:350" />
						</td>
					</tr>

					<tr>
						<td><label for="descr">实体表中文名（注释）:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="descr" data-options="required:true" style="width:350" />
						</td>
					</tr>

					<tr>
						<td><label for="beanName">迁移器（bean名称）:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="beanName" data-options="required:false" style="width:350" />
						</td>
					</tr>

					<tr>
						<td><label for="type">迁移任务执行频率:</label>
						</td>
						<td><select id="sxtTypeField" class="easyui-combobox"
							name="type" style="width:200px;">
								<option value=1 selected="selected">全部任务</option>
								<option value=2>增量任务</option>
						</select></td>
					</tr>

					<tr>
						<td><label for="isWork">是否生效:</label>
						</td>
						<td><input type="radio" value="false" name="isWork"
							checked="checked">不生效 <input type="radio" value="true"
							name="isWork">生效</td>
					</tr>


				</table>
			</fieldset>

			<fieldset style="display: none;" id="tbrwxxFieldset">
				<legend>同步任务频率信息</legend>
				<table width="100%">
					<tr>
						<td><label for="startTime">开始同步时间:</label>
						</td>
						<td><select id="stStartTimeField" class="easyui-combobox"
							name="startTimeStr" style="width:200px;">
								<option value=1 selected="selected">现在</option>
								<option value=2>指定时间</option>
						</select></td>
					</tr>

					<tr id="stChooseTime" style="display: none;">
						<td><label for="startTime">指定时间:</label>
						</td>
						<td><input class="easyui-datetimebox" type="text"
							name="chooseTimeValue" id="chooseTimeValue"
							data-options="required:false" style="width:350" /></td>
					</tr>

					<tr>
						<td><label for="descr">同步间隔（毫秒）:</label>
						</td>
						<td><input class="easyui-numberspinner" type="text"
							name="period"
							data-options="required:false,increment:1000,min:5000"
							style="width:350" /></td>
					</tr>

				</table>
			</fieldset>
			<table width="100%">
				<tr>
					<td align="center"><a id="tbety_form_save" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						<a id="tbety_form_reset" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-reset'">重写</a></td>
				</tr>
			</table>

		</form>

	</div>











	<!-- Window -->
	<div id="tasklog_win" style="display: none;">

		<form id="tasklog_form" method="post">

			<input class="easyui-validatebox" type="text" name="id"
				style="width:350;display: none;" />

			<fieldset>
				<legend>任务执行日志信息</legend>
				<table width="100%">
					<tr>
						<td><label for="name">实体表名称:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="entityName" readonly="readonly" style="width:350" /></td>
					</tr>

					<tr>
						<td><label for="descr">迁移器:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="beanName" readonly="readonly" style="width:350" /></td>
					</tr>

					<tr>
						<td><label for="beanName">迁移工具:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="toolClass" readonly="readonly" style="width:350" /></td>
					</tr>

					<tr>
						<td><label for="type">执行方法:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="methodName" readonly="readonly" style="width:350" /></td>
					</tr>

					<tr>
						<td><label for="isWork">迁移类型:</label>
						</td>
						<td><input class="easyui-validatebox" type="text" name="type"
							readonly="readonly" style="width:350" />
					</tr>

					<tr>
						<td><label for="isWork">是否成功:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="success" readonly="readonly" style="width:350" />
					</tr>

					<tr>
						<td><label for="isWork">迁移时间:</label>
						</td>
						<td><input class="easyui-validatebox" type="text"
							name="crTime" readonly="readonly" style="width:350" />
					</tr>

					<tr>
						<td><label for="isWork">备注:</label>
						</td>
						<td><textarea rows="10" cols="50" name="addition"
								readonly="readonly"></textarea>
					</tr>


				</table>
				<table width="100%">
					<tr>
						<td align="center"><a id="tasklog_form_close" href="#"
							class="easyui-linkbutton" data-options="iconCls:'icon-close'">关闭</a>
						</td>
					</tr>
				</table>
			</fieldset>

		</form>

	</div>




</body>
</html>
