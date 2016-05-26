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
			        url:'<%=basePath%>project/list'
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
			    <div>
				           计划编号:<input id="id" class="" style="">
				            计划名称:<input id="trainName" class="" style="">
		            <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="queryPlan()">查询</a>
			    </div>
		            
		    </div>
			<table id="dg"  style="" toolbar="#tb">
				<thead>  
				        <tr>  
							<th field="ck" checkbox="true"></th>
				            <th field="id" >编号</th>  
				            <th field="name" >名称</th>  
				            <th field="type" >类型</th>  
				            <th field="planSource" >计划来源</th>  
				            <th field="trainObj" >培训对象</th>  
				            <th field="beginTime" >开始时间</th>  
				            <th field="endTime" >结束时间</th>  
				            <th field="zbdw" >主办单位</th>  
				            <th field="manageDept" >承办部门</th>  
				            <th field="campus" >培训地点</th>  
				        </tr>  
		   		 </thead>  
			</table>
	</body>
</html>