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

<title>新员工培训各培训地点平均成绩排名</title>

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

<script type="text/javascript" src="<%=basePath %>static/service/pxddcj.js"></script>

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
					<td >项目名称：</td>
					<td><input id="s_projectId" class="easyui-combobox" style="width: 350px" data-options="valueField: 'id',textField: 'name',
					onSelect: function(rec){
			        	
			        }"> </td>
			        <td>成绩类型：</td>
					<td><input id="s_scoreType" name="s_scoreType"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'name',
        textField: 'name',
        value:'学员结业成绩',
        data:[{name:'企业文化和主营业务认知'},{name:'专业技能过程考核成绩'},{name:'技能笔试成绩'},{name:'技能操作成绩'},{name:'军训成绩'},{name:'月度综合素质成绩'},{name:'月度成绩'},{name:'学员结业成绩'}]"></td>
					<td>月份：</td>
					<td><input id="s_month" name="s_month"  class="easyui-numberspinner" 
         data-options="min:1,max:12" style="width: 350px" ></td>
					
				</tr>
				<tr>
					
					<td >培训地点：</td>
					<td colspan="5"><input id="s_campus" name="s_campus"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name'"> <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
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
						<td><label for="name">项目名称:</label>
						</td>
						<td><input id="projectId" name="projectId"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'name',
        required:true,
        url: 'project/find.do?filter=type=1',
        onSelect: function(rec){
        	$('#classId').combobox('setValue', '');
            var url = 'class/find.do?filter=projectId='+rec.id;
            $('#classId').combobox('reload', url);
        },
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					
					<tr>
						<td><label for="name">培训地点:</label>
						</td>
						<td><input id="campus" name="campus"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        url: 'zbDict/findByType.do?type=campus',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">成绩类型:</label>
						</td>
						<td><input id="scoreType" name="scoreType"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'name',
        textField: 'name',
        required:true,
        data:[{name:'企业文化和主营业务认知'},{name:'专业技能过程考核成绩'},{name:'技能笔试成绩'},{name:'技能操作成绩'},{name:'军训成绩'},{name:'月度综合素质成绩'},{name:'月度成绩'},{name:'学员结业成绩'}]">
						</td>
					</tr>
					
					<tr>
						<td><label for="name">送培人数:</label>
						</td>
						<td><input id="perNum" name="perNum" required="required" class="easyui-numberspinner" 
         data-options="min:0" style="width: 350px" ></td>
					</tr>
					
					<tr>
						<td><label for="name">月份:</label>
						</td>
						<td><input id="month" name="month"  class="easyui-numberspinner" 
         data-options="min:1,max:12" style="width: 350px" ></td>
					</tr>
					
					<tr>
						<td><label for="name">平均成绩:</label>
						</td>
						<td><input id="score" name="score" required="required" class="easyui-numberspinner" 
         data-options="min:0,precision:1" style="width: 350px" ></td>
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
