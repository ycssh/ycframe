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
<table id="table"  class="easyui-datagrid">
    <thead>
        <tr>
            <th data-options="field:'username'" width="30%">用户名</th>
            <th data-options="field:'name'" width="30%">姓名</th>
            <th data-options="field:'id'" width="40%">解锁</th>
        </tr>
    </thead>
	    <tbody>
	        <c:forEach items="${users}" var="user">
	            <tr data-tt-id='${user.username}'>
	                <td>${user.username}</td>
	                <td>${user.name}</td>
            		<td><span id="${user.username}" style="cursor: pointer;" class="unlock">解锁 <img src="<c:url value='/static/images/iconfont-unlock.png'/>"/></span></td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	
	<script type="text/javascript">
		$(function(){
			$(".unlock").click(function(){
				if(confirm("确定解锁该用户吗?")){
					$.ajax({
		                type: "POST",
		                contentType: "application/json",
		                url: "<c:url value='/passwordRetry/unlock/'/>"+$(this).attr("id"),
		                dataType: 'json',
		                timeout: 600000,
		                success: function (data) {
		                	alert("解锁成功");
							window.location.reload();
		                },
		                error: function (e) {
		                	alert("error");
		                }
		            });
				}
			})
		})
	</script>
</body>
</html>