<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
			        url:'<%=basePath%>sign/list'
			    });  
			});
			function queryPlan(){
				var id = $("#id").val();
				var trainName = $("#trainName").val();
				$('#dg').datagrid({
					queryParams: {
						id:id,
						trainName:trainName
					}
				});
			}
		</script>

	</head>
	<body>
			<div id="tb" style="padding:5px;background-color: #F4F4F4;">
				<div style="margin-bottom:5px">    
			    </div>    
			    <div>
				           姓名:<input id="name" class="" style="">
				            管理部门:<input id="manageDept" class="" style="">
		            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryTeacher()">查询</a>
			    </div>
		            
		    </div>
			<table id="dg"  style="" toolbar="#tb">
				<thead>  
				        <tr>  
							<th field="ck" checkbox="true"></th>
				            <th field="id" >id</th>  
				            <th field="projectId" >项目编号</th>  
				            <th field="projectName" >项目名称</th>  
				            <th field="name" >姓名</th>  
				            <th field="idCard" >身份证号码</th>  
				            <th field="sex" >性别</th>  
				            <th field="major" >专业</th>  
				        </tr>  
		   		 </thead>  
			</table>
	</body>
</html>