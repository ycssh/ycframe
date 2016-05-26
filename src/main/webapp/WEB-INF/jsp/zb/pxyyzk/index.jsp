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

<title>新员工培训运营状况监测</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
table td{
	font-size: 12px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>

<script type="text/javascript" src="<%=basePath %>static/service/pxyyzk.js"></script>

</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<div id="add" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">新增</div>
			<div id="edit" class="easyui-linkbutton"
				data-options="iconCls:'icon-edit',plain:true">修改</div>
			<div id="delete" class="easyui-linkbutton"
				data-options="iconCls:'icon-remove',plain:true">删除</div>
		</div>
		<div>
			<table id="searchTable">
				
				<tr>
					<td>项目名称：</td>
					<td><input id="s_projectId" class="easyui-combobox" data-options="valueField: 'id',textField: 'name'" style="width: 350px"></td>
					<td>专业培训部：</td>
					<td><input id="s_deptId" class="easyui-combobox" data-options="valueField: 'value',textField: 'name'"></td>
					<td>专业名称：</td>
					<td><input id="s_majorId" class="easyui-combobox" data-options="valueField: 'value',textField: 'name'"> <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
					
				</tr>
			</table>
			
		</div>
		
	</div>
	<table id="mainGrid"></table>
	
	<!-- Window -->
	<div id="window" style="display: none;">

		<form id="form" method="post">

			<input class="easyui-validatebox" type="text" id="id" name="id"
				style="width:350;display: none;" />
			<input class="easyui-validatebox" type="text" id="type" name="type"
				style="width:350;display: none;" value="1" />

			<fieldset style="margin-top: 10px">
				<legend>信息</legend>
				<table width="100%">
					
					<tr>
						<td><label for="name">专业培训部:</label>
						</td>
						<td><input id="deptId" name="deptId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        url: 'zbDict/findByType.do?type=dept',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">项目名称:</label>
						</td>
						<td><input id="projectId" name="projectId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'name',
        required:true,
        url: 'project/find.do?filter=type=1',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">专业名称:</label>
						</td>
						<td><input id="majorId" name="majorId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        url: 'zbDict/findByType.do?type=major',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">班级名称:</label>
						</td>
						<td><input id="classId" name="classId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'name',
        required:true,
        url: 'class/find.do?filter=type=1',
        onSelect: function(rec){
        },
        onLoadSuccess:function(rec){
        	
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">培训方案编制:</label>
						</td>
						<td><input id="solution" name="solution"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					
					<tr>
						<td><label for="name">课程表编制:</label>
						</td>
						<td><input id="kcb" name="kcb"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">晚自习教室安排:</label>
						</td>
						<td><input id="wzx" name="wzx"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">班主任/辅导员安排:</label>
						</td>
						<td><input id="bzr" name="bzr"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">学员报到:</label>
						</td>
						<td><input id="bd" name="bd"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">企业文化和主营业务成绩报送:</label>
						</td>
						<td><input id="qywh" name="qywh"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">技能竞赛笔试成绩报送:</label>
						</td>
						<td><input id="jsbs" name="jsbs"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">技能竞赛操作成绩报送:</label>
						</td>
						<td><input id="jscz" name="jscz"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">军训成绩报送:</label>
						</td>
						<td><input id="jx" name="jx"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">月度成绩报送:</label>
						</td>
						<td><input id="yd" name="yd"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">结业成绩报送:</label>
						</td>
						<td><input id="jy" name="jy"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">优秀学员评选:</label>
						</td>
						<td><input id="yxxy" name="yxxy"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
					<tr>
						<td><label for="name">优秀学员干部评选:</label>
						</td>
						<td><input id="yxgb" name="yxgb"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        data:[{value:1,name:'已完成'},{value:2,name:'预警'},{value:3,name:'告警'},{value:4,name:'未开始'}]"></td>
					</tr>
				</table>
			</fieldset>

			<table width="100%">
				<tr>
					<td align="center"><a id="save" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						<a id="reset" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-reset'">重置</a></td>
				</tr>
			</table>

		</form>

	</div>
	
</body>
</html>
