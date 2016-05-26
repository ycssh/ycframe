<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<jsp:include page="../inc.jsp"></jsp:include>

</head>
<body >
<table id="table"  >
    <thead>
        <tr>
            <th data-options="field:'name'" width="20%">类型</th>
            <th data-options="field:'value'" width="20%">值</th>
            <th data-options="field:'unit'" width="20%">单位</th>
            <th data-options="field:'type'" width="30%">代码</th>
            <th data-options="field:'id'" width="20%" style="display: none">id</th>
        </tr>
    </thead>
	    <tbody>
	        <c:forEach items="${inits}" var="init">
	            <tr data-tt-id='${init.id}'>
	                <td>${init.name}</td>
	                <td>${init.value}</td>
            		<td>${init.unit}</td>
            		<td>${init.type}</td>
            		<td  style="display: none">${init.id }</td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	
	<div id="updateDiv"></div>
	<div id="window" style="display: none;">
			<input type="hidden" id="id" name="id"/>
			<table>
				<tr >
		    		<td width="40%">类型:</td>
		    		<td width="60%"><span id="name"></span></td>
	    		</tr>
				<tr >
		    		<td width="40%">值:</td>
		    		<td width="60%"><input maxlength="5" class="easyui-numberspinner" 
         data-options="min:1" id="value" name="value" style="width: 250px" data-options="required:true"/></td>
	    		</tr>
	    		<tr>
		    		<td>单位:</td>
		    		<td><span id="unit"></span></td>
		    	</tr>
	    		<tr>
		    		<td>代码:</td>
		    		<td><span id="type"></span></td>
		    	</tr>
				<tr>
					<td align="right"><a id="save" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a></td>
			    		<td></td>
				</tr>
			</table>
	</div>
	
	<script type="text/javascript">
		$(function(){
			$('#table').datagrid({
				toolbar: [
					{  
			            text: '修改',  
			            iconCls: 'icon-edit',  
			            handler: function() {  
			            	edit();
			            }  
			        }
				],
				pagination:false
			});
			$("#table").datagrid('hideColumn', "id");
			$("#save").click(function(){

				var row = $('#table').datagrid('getSelected');
				var value = $('#value').numberbox('getValue');
				if(row.type=="sessionTimeout"){
					if(value<1||value>30){
						alert("session超时时间只能为1-30之间");
						return false;
					}
				}
				if(row.type=="pwdCount"){
					if(value<1||value>10){
						alert("输入错误密码次数锁定账号只能为1-10之间");
						return false;
					}
				}
				if(row.type=="pwdTime"){
					if(value<20||value>50){
						alert("输入错误密码锁定账号时间只能为20-50之间");
						return false;
					}
				}
				if(row.type=="maxOnlineCount"){
					if(value<1||value>10000){
						alert("系统最大在线用户数量只能为1-10000之间");
						return false;
					}
				}
				if(row.type=="pwdValidTime"){
					if(value<1||value>365){
						alert("密码有效期只能为1-365之间");
						return false;
					}
				}				
				$.ajax({
	                type: "POST",
	                contentType: "application/json",
	                url: "<c:url value='/sysinit/update/'/>"+$("#id").val()+"/"+value,
	                dataType: 'json',
	                timeout: 600000,
	                success: function (data) {
	                	alert("操作成功");
						window.location.reload();
	                },
	                error: function (e) {
	                }
	            }); 
			})
		});
		function edit(){
			var row = $('#table').datagrid('getSelected');
			if(!row){
		    	$.messager.alert('提示','请选择要编辑的记录');
		    	return ;
			}
			$("#window").window({
				title : "修改",
				width : 700,
				height : 320,
				modal : true
			}).show();
			$('#value').numberbox('setValue', row.value);
			$("#id").val(row.id); 
			$("#name").text(row.name); 
			$("#type").text(row.type); 
			$("#unit").text(row.unit); 
		}
	</script>
</body>
</html>