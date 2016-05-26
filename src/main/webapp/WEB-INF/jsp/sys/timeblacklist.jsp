<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<jsp:include page="../inc.jsp"></jsp:include>

</head>
<body>
	<table id="table" >
		<thead>
			<tr>
				<th data-options="field:'startHour'" width="30%">开始(时)</th>
				<th data-options="field:'startMin'" width="30%">开始(分)</th>
				<th data-options="field:'endHour'" width="30%">结束(时)</th>
				<th data-options="field:'endMin'" width="30%">结束(分)</th>
				<th data-options="field:'id'" width="40%">id</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="time">
				<tr data-tt-id='${time.id}'>
					<td>${time.startHour}</td>
					<td>${time.startMin}</td>
					<td>${time.endHour}</td>
					<td>${time.endMin}</td>
					<td>${time.id}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- Window -->
	<div id="window" style="display: none;">
		<form id="form" method="post" action="<%=basePath%>timeblacklist/add">
			<fieldset style="margin-top: 10px">
				<legend>新增</legend>
				<table width="100%">
					<tr>
						<td><label for="name">开始(时):</label><input id="startHour"
							name="startHour" required="required" class="easyui-numberspinner"
							data-options="min:0,max:23"></input></td>
					</tr>
					<tr>
						<td><label for="name">开始(分):</label><input id="startMin"
							name="startMin" required="required" class="easyui-numberspinner"
							data-options="min:0,max:59"></input></td>
					</tr>
					<tr>
						<td><label for="name">结束(时):</label><input id="endHour"
							name="endHour" required="required" class="easyui-numberspinner"
							data-options="min:0,max:23"></input></td>
					</tr>
					<tr>
						<td><label for="name">结束(分):</label><input id="endMin"
							name="endMin" required="required" class="easyui-numberspinner"
							data-options="min:0,max:59"></input></td>
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
	<script type="text/javascript">
		function initForm() {
			$('#form').form({
				onSubmit : function(param) {
					var isValid = $(this).form('validate');
					if (!isValid) {
						$.messager.progress('close'); // hide progress bar while the
					}
					return isValid; // return false will stop the form submission
				},
				success : function(data) {
					var result = $.parseJSON(data);
					if (!result.result) {
						$.messager.alert("错误", result.msg);
					} else {
						$.messager.alert("提示", "保存成功！");
						$("#window").window('close');
						window.location.reload();
					}
				}
			});
		}
		$(function() {
			$('#table').datagrid({
				toolbar : [ {
					text : '新增',
					iconCls : 'icon-add',
					handler : function() {
						add();
					}
				}, {
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
						remove();
					}
				} ],
				pagination:false
			});
			$("#table").datagrid('hideColumn', "id");
			initForm();

			$("#save").bind("click", saveItem);
		})

		function saveItem() {
			$('#form').submit();
		}
		function remove() {
			var row = $('#table').datagrid('getSelected');
			if (!row) {
				$.messager.alert('提示', '请选择要删除的记录');
				return;
			}
			if (confirm("确定删除吗?")) {
				$.ajax({
					type : "POST",
					contentType : "application/json",
					url : "<c:url value='/timeblacklist/delete/'/>" + row.id,
					dataType : 'json',
					timeout : 600000,
					success : function(data) {
						alert("操作成功");
						window.location.reload();
					},
					error : function(e) {
					}
				});
			}
		}

		function add() {
			$("#window").window({
				title : "新增",
				width : 600,
				height : 300,
				modal : true
			}).show();
			$('#form').form('reset');
		}
	</script>
</body>
</html>