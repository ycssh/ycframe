<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
		<jsp:include page="../inc.jsp"></jsp:include>
		<script type="text/javascript">
			var editingId;
			function edit(){
				var row = $('#tg').treegrid('getSelected');
				if (row){
					editingId = row.id;
					$("#dlg").dialog({
					    title: '资源编辑',
					    closed: false,
					    cache: false,
					    width:600,
					    height:450,
					    href: "<%=basePath%>resource/edit/"+editingId,
					    modal: true,
					    onBeforeClose:function(){
					    	$("#tg").treegrid('reload');
					    }
					});
				}
			}
			function add(){
				var row = $('#tg').treegrid('getSelected');
				if (row){
					editingId = row.id;
					$("#dlg").dialog({
					    title: '新增菜单',
					    closed: false,
					    cache: false,
					    width:600,
					    height:450,
					    href: "<%=basePath%>resource/add/"+editingId,
					    modal: true,
					    onBeforeClose:function(){
					    	$("#tg").treegrid('reload');
					    }
					});
				}
			}
			
			function addRoot(){
				$("#dlg").dialog({
					    title: '新增根节点',
					    closed: false,
					    cache: false,
					    width:600,
					    height:450,
					    href: "<%=basePath%>resource/addRoot",
					    modal: true,
					    onBeforeClose:function(){
					    	$("#tg").treegrid('reload');
					    }
					});
			}
			
			function _delete(){
				var row = $('#tg').treegrid('getSelections');
				if (row&&row.length>0){
					
					var ids = [];
					for(var i=0;i<row.length;i++){
						ids.push(row[i].id);
					}
					
					if(confirm("确定删除？")){
						
						$.post("<%=basePath%>resource/remove/",{ids:ids.join(',')},function(data){
							
							if (data.success) {
								alert('删除成功！');
					
								$("#tg").treegrid('reload');
							} else {
								alert(data.msg);
							}
						},"JSON");
						
					}
				}
			}
			
			function uploadPic(){
				var row = $('#tg').treegrid('getSelected');
				if (row){
					editingId = row.id;
					$("#dlg").dialog({
					    title: '上传菜单图标',
					    closed: false,
					    cache: false,
					    width:600,
					    height:450,
					    href: "<%=basePath%>resource/uploadPic/"+editingId,
					    modal: true,
					    onBeforeClose:function(){
					    	$("#tg").treegrid('reload');
					    }
					});
				}
			}

		</script>
	</head>
	<body style="padding-top: 0px">
		<div style="margin:20px 0;">
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="edit()">编辑</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="add()">新增子节点</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="_delete()">删除</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="uploadPic()">添加图标</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="addRoot()">添加根节点</a>
		</div>
			<table title="菜单树"  class="easyui-treegrid" id="tg" 
					data-options="
						url: '<%=basePath %>resource/tree',
						method: 'get',
						rownumbers: true,
						idField: 'id',
						fitColumns : true,
						treeField: 'name',
						singleSelect:true
					">
				<thead>
					<tr>
						<th data-options="field:'name'" width="220">Name</th>
						<th data-options="field:'url'" width="200" align="right">url</th>
						<th data-options="field:'type'" width="150">类型</th>
						<th data-options="field:'permission'" width="150">权限字符串</th>
						<th data-options="field:'showInFront',formatter: function(value,row,index){
				if (row.showInFront=='1'){
					return '是';
				} else {
					return '否';
				}
			}" width="150">是否展示在前台</th>
						<th data-options="field:'picName',formatter: function(value,row,index){
				if (value&&value.indexOf('\\')>=0){
					value = value.substring(value.lastIndexOf('\\')+1);
				}
				return value;
			}" width="150">图标</th>
					</tr>
				</thead>
			</table>
			
			<div id="dlg" data-options="iconCls:'icon-save'" style="width:400px;height:200px;padding:10px;">
			</div>
	</body>
</html>