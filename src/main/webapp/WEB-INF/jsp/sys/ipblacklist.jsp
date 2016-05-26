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
            <th data-options="field:'ip'" width="30%">ip地址</th>
            <th data-options="field:'id'" width="40%">解锁</th>
        </tr>
    </thead>
	    <tbody>
	        <c:forEach items="${list}" var="blacklist">
	            <tr data-tt-id='${blacklist.id}'>
	                <td>${blacklist.ip}</td>
	                <td>${blacklist.id}</td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
	
	<div id="window" style="display: none;">
			<input type="hidden" id="id" name="id"/>
			<table>
				<tr >
		    		<td width="40%">ip:</td>
		    		<td width="60%"><input maxlength="15" type="text" id="ip" name="ip" style="width: 250px"/></td>
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
			            text: '新增',  
			            iconCls: 'icon-add',  
			            handler: function() {  
			            	edit();
			            }  
			        },{  
			            text: '删除',  
			            iconCls: 'icon-remove',  
			            handler: function() {  
			            	remove();
			            }  
			        }
				],
				pagination:false
			});
			$("#table").datagrid('hideColumn', "id");
			
			$("#save").click(function(){
				if($("#ip").val()==""){
					alert("请输入ip地址");
					return false;
				}
				var re =  /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/ ;
				if(!re.test($("#ip").val())){
					alert("请输入正确的ip地址");
					return false;
				}
				$.ajax({
	                type: "POST",
	                url: "<c:url value='/ipblacklist/add'/>",
	                data:"ip="+$("#ip").val(),
	                dataType: 'json',
	                timeout: 600000,
	                success: function (data) {
	                	if(data==1){
		                	alert("操作成功");
							window.location.reload();
	                	}else{
		                	alert("该ip地址已存在");
	                	}
	                },
	                error: function (e) {
	                }
	            }); 
			})
		})
		function remove(){
			var row = $('#table').datagrid('getSelected');
			if(!row){
		    	$.messager.alert('提示','请选择要删除的记录');
		    	return ;
			}
			if(confirm("确定删除吗?")){
				$.ajax({
	                type: "POST",
	                contentType: "application/json",
	                url: "<c:url value='/ipblacklist/delete/'/>"+row.id,
	                dataType: 'json',
	                timeout: 600000,
	                success: function (data) {
	                	alert("操作成功");
						window.location.reload();
	                },
	                error: function (e) {
	                }
	            }); 
			}
		}
		function edit(){
			$("#window").window({
				title : "修改",
				width : 700,
				height : 320,
				modal : true
			}).show();
		}
	</script>
</body>
</html>