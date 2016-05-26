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
			        url:'<%=basePath%>monthplan/list'
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
				            <th field="id" >计划编号</th>  
				            <th field="planYear" >年份</th>  
				            <th field="planMonth" >月份</th>  
				            <th field="companyType" >主办单位</th>  
				            <th field="planSource" >计划来源</th>  
				            <th field="trainType" >培训类别</th>  
				            <th field="trainName" >培训班名称</th>  
				            <th field="trainContent" >培训内容</th>  
				        </tr>  
		   		 </thead>  
			</table>
	</body>
</html>