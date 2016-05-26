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
			        url:'<%=basePath%>assignflat/list'
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
		<div>
			<div id="tb" style="padding:5px;height:auto;background-color: #F4F4F4;">
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
				            <th field="name" >楼宇名称</th>  
				            <th field="type" >类型</th>  
				            <th field="campus" >所属校区</th>  
				        </tr>  
		   		 </thead>  
			</table>
		</div>

	</body>
</html>