<%-- <%@page import="com.sgcc.util.DictUtils"%> --%>
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
			        url:'<%=basePath%>classschedule/list'
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
				            <th field="projectName" >项目名称</th>  
				            <th field="classId" >班级</th>  
				            <th field="courseId" >课程</th>  
				            <th field="kcdate" >日期</th>  
				            <th field="period" >时段</th>  
				            <th field="classroomId" >教室</th>  
				            <th field="groupname" >组名</th>  
				            <th field="teachers" >教师</th>  
				        </tr>  
		   		 </thead>  
			</table>

	</body>
</html>