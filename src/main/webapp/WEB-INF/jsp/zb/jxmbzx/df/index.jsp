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

<title>绩效目标执行监测-计划值管理</title>

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
<script type="text/javascript" src="<%=basePath %>static/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src="<%=basePath %>static/service/jxmbzxdf.js"></script>

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
					<td >年份 ：</td>
					<td width="100px"><input id="s_year" class="easyui-numberspinner" data-options="min:2009,max:2100" style="width: 100px" data-options="valueField: 'value',textField: 'name'"></td>
					<td><a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
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

			<fieldset style="margin-top: 10px">
				<legend>绩效目标执行监测信息</legend>
				<table width="100%">
					<tr>
						<td><label for="name">年度:</label>
						</td>
						<td><input id="year" name="year" class="easyui-numberspinner" 
         data-options="required:true,min:2009,max:2100" style="width: 100px" >
						</td>
					</tr>

					<tr>
						<td><label for="name">培训计划:</label>
						</td>
						<td><input maxlength="10" id="jh" name="jh" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" >
						</td>
					</tr>
					<tr>
						<td><label for="name">培训计划（新员工）:</label>
						</td>
						<td><input maxlength="10" id="xygjh" name="xygjh" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" >
						</td>
					</tr>
					<tr>
						<td><label for="name">培训计划（短训班）:</label>
						</td>
						<td><input maxlength="10" id="dxbjh" name="dxbjh" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" >
						</td>
					</tr>
					<tr>
						<td><label for="name">培训人次:</label>
						</td>
						<td><input maxlength="10" id="rc" name="rc" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训人次（新员工）:</label>
						</td>
						<td><input maxlength="10" id="xygrc" name="xygrc" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训人次（短训班/团青）:</label>
						</td>
						<td><input maxlength="10" id="dxbrc" name="dxbrc" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训人数:</label>
						</td>
						<td><input maxlength="10" id="rs" name="rs" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训人数（新员工）:</label>
						</td>
						<td><input maxlength="10" id="xygrs" name="xygrs" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训人数（短训班/团青）:</label>
						</td>
						<td><input maxlength="10" id="dxbrs" name="dxbrs" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训人天数:</label>
						</td>
						<td><input maxlength="10" id="rts" name="rts" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训人天数（新员工）:</label>
						</td>
						<td><input maxlength="10" id="xygrts" name="xygrts" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训人天数（短训班/团青）:</label>
						</td>
						<td><input maxlength="10" id="dxbrts" name="dxbrts" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
<!-- 					<tr>
						<td><label for="name">培训工作量:</label>
						</td>
						<td><input maxlength="10" id="gzl" name="gzl" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训工作量（新员工）:</label>
						</td>
						<td><input maxlength="10" id="xyggzl" name="xyggzl" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr>
					<tr>
						<td><label for="name">培训工作量（短训班/团青）:</label>
						</td>
						<td><input maxlength="10" id="dxbgzl" name="dxbgzl" class="easyui-numberspinner" 
         data-options="min:0" style="width: 330px" ></td>
					</tr> -->



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
