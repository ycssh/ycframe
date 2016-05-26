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
			        url:'<%=basePath%>class/list'
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
			 <div id="tb" style="padding:5px;height:auto;background-color: #F4F4F4;">
			    <div>
				           计划编号:<input id="id" class="" style="">
				            计划名称:<input id="trainName" class="" style="">
		            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryPlan()">查询</a>
			    </div>
		            
		    </div>
			<table id="dg"  style="width: 100%" toolbar="#tb">
				<thead>  
				        <tr>  
							<th field="ck" checkbox="true"></th>
				            <th field="id" >编号</th>  
				            <th field="name" >班级名称</th>  
				            <th field="major" >所属专业</th>  
				            <th field="campus" >所属校区</th>  
				            <th field="projectId" >所属项目</th>  
				            <th field="actualno" >实际人数</th>  
				            <th field="bzr" >班主任</th>  
				            <th field="fdy" >辅导员</th>  
				            <th field="zxs" >自习室</th>  
				        </tr>  
		   		 </thead>  
			</table>
	</body>
</html>