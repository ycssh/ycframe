<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
		<jsp:include page="../inc.jsp"></jsp:include>
		<script type="text/javascript">
			var datagrid;
			$(function() {
				$('#dg').datagrid({  
			        url:'<%=basePath%>daily/list',
			        toolbar:"#tb"
			    }); 
				$("#dg").datagrid('hideColumn', "id");
				$('#grid').datagrid('hideColumn','列field');
				$("#search").bind("click",doSearch);
				$("#save").bind("click",saveItem);
				$("#reset").bind("click",resetForm);
				$("#reset2").bind("click",function(){
					$("#dates").datebox("setValue","");
				});
				initForm();
				$("#download").click(function(){
					var row = $('#dg').datagrid('getSelected');
					if(!row){
				    	$.messager.alert('提示','请选择要下载的记录');
				    	return ;
					}
					window.open("<%=basePath%>daily/download/"+row.id);
				})
			});

			function saveItem(){
				$('#form').submit();
			}

			function resetForm(){
				$('#form').form('reset');
			}
			function doSearch(){
				var dates = $("#dates").datebox("getValue");
				$('#dg').datagrid({
					queryParams: {
						filter:"dates="+dates
					}
				});
			}

			function adds(){
				$("#window").window({
					title : "新增",
					width : 600,
					height : 300,
					modal : true
				}).show();
				$('#form').form('reset');
			}

			function deletes(){
				var row = $('#dg').datagrid('getSelected');
				if(!row){
			    	$.messager.alert('提示','请选择要删除的记录');
			    	return ;
				}
				if(confirm("确定删除?")){
					$.post("<%=basePath%>daily/remove/"+row.id,{},function(data){
						$.messager.alert('提示','删除成功！');
				    	$('#dg').datagrid('reload');
				    	doSearch();
					},"json");
				}
			}

			function refreshItem(){
				$("#dg").datagrid('reload');
			}

			function initForm(){
				$('#form').form({
					onSubmit : function(param) {
						var isValid = $(this).form('validate');
						if (!isValid) {
							$.messager.progress('close'); // hide progress bar while the
						}
						/* if($("#formdates").datebox("getValue")==""){
							alert("请选择日期");
							isValid = false;
						} */
						var exists = false;
						
						$.ajax({
						   type: "POST",
						   url: "<%=basePath%>daily/exists/"+$('#formdates').datebox("getValue"),
						   success: function(data){
							   if(data==1){
								  exists = true; 
							   }
						   },
						   async: false
						});
						if(exists){
							alert("该日期已存在日报，不可上传")
							isValid = false;
						}
						return isValid; // return false will stop the form submission
					},
					success : function(data) {
						var result = $.parseJSON(data);
						if(!result.result){
							$.messager.alert("错误",result.msg);
						}else{
							$.messager.alert("提示","保存成功！");
							$("#window").window('close');
							refreshItem();
						}
					}
				});
			}
		</script>

	</head>
	<body>
			<div id="tb" style="padding:5px;background-color: #F4F4F4;">
			<shiro:hasPermission name="daily:add">
				<a href="#" class="easyui-linkbutton" onclick="adds()" data-options="iconCls:'icon-add',plain:true">添加</a>
				<a href="#" class="easyui-linkbutton" onclick="deletes()" data-options="iconCls:'icon-remove',plain:true">删除</a>
			</shiro:hasPermission>
				<a href="#" class="easyui-linkbutton" id="download" data-options="iconCls:'icon-import',plain:true">下载</a>
			    <div>
				           日期:<input class="easyui-datebox" editable="false" type="text" onClick="WdatePicker()" id="dates"></input>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-search" id="search">查询</a>
		            <a href="#" class="easyui-linkbutton" iconCls="icon-reset" id="reset2">重置</a>
			    </div>
		            
		    </div>
			<table id="dg"  style="">
				<thead>  
				        <tr>  
							<th field="ck" checkbox="true"></th>
				            <th field="id" >编号</th>  
				            <th field="dates"  width="10%">日期</th>  
				            <th field="fileName" width="20%">文件名称</th>  
				            <th field="remark" width="70%">备注</th>  
				        </tr>  
		   		 </thead>  
			</table>
<!-- Window -->
	<div id="window" style="display: none;">
		<form id="form" method="post" action="<%=basePath%>daily/upload" enctype="multipart/form-data">
			<fieldset style="margin-top: 10px">
				<legend>日报上传</legend>
				<table width="100%">
					<tr>
						<td><label for="name">日期:</label><input class="easyui-datebox" editable="false" required  id="formdates" type="text" onClick="WdatePicker()" name="dates" ></input></td>
					</tr>
					<tr>
						<td><label for="file">附件:</label><input id="file" name="file" type="file" class="easyui-validatebox" style="width: 330px" data-options="required:true"></td>
					</tr>
					<tr>
						<td><label for="remark">备注:</label><input id="remark" class="easyui-validatebox" validType="length[0,50]" invalidMessage="不能超过50个字符！" name="remark" style="width: 330px"></td>
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
<script src="<%=basePath %>static/new/javascript/WdatePicker/WdatePicker.js" charset="UTF-8" type="text/javascript"></script>
	</body>
</html>