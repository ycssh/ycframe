<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
</head>
<body>
	<style type="text/css">
		select{width:100%;height:100%;border: #95B8E7 solid 1px;;}
		#left{float: left;width:40%;height:70%}
		#middle{float:left;width:20%;height:70%;margin: auto;text-align: center;line-height: 70%;min-width: 40px;display: table;}
		#right{float: left;width:40%;height:70%}
		#middlechild{display: table-cell;vertical-align: middle;}
		
		#lefttop{float: left;width:40%;text-align: center;margin: 5px 0;}
		#middletop{float:left;width:20%;margin: auto;text-align: center;min-width: 40px;height:1px;margin: 5px 0;}
		#righttop{float: left;width:40%;text-align: center;margin: 5px 0;}
		#content{height: :100%;margin: auto;width: 70%;}
		input{width:40px;}
	</style>
	
	<div class="easyui-panel">
		<div id="dlg-toolbar" class="easyui-linkbutton-backcolor" style="padding:2px 0;">
		<table cellpadding="0" cellspacing="0" style="width:100%;border: #95B8E7 solid 1px;">
			<tr><td style="padding-left:2px"><a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="submitForm()">保存</a></td></tr></table>
		</div>
		<div id="content">
			<div id="top">
					<div id="lefttop">已分配角色</div>
					<div id="middletop"></div>
					<div id="righttop">待分配角色</div>
			</div>
		<div style="clear: both;"></div>
			<div style="display: block;">
				<div id="left">
					<select multiple="multiple" id="select2">
						<c:forEach var="role" items="${roles }">
							<option value="${role.id }">${role.name }</option>
						</c:forEach>
					</select>
				</div>
				
					<div id="middle">
						<div id="middlechild">
							<div id= "add_all"><input type="button" value="<<"></div>
							<div id= "add"><input type="button" value="<"></div>
							<div id= "remove"><input type="button" value=">"></div>
							<div id= "remove_all"><input type="button" value=">>"></div>
						</div>
					</div>
				
				<div id="right">
					<select multiple="multiple" id="select1">
						<c:forEach var="role" items="${notIn }">
							<option value="${role.id }">${role.name }</option>
						</c:forEach>
					</select>
				</div>
			</div>
		<div style="clear: both;"></div>
			<div style="height:30px;width: 100%"></div>
		</div>
	</div>
	
	<script type="text/javascript">
	$(function(){
	    //移到右边
	    $('#add').click(function() {
	    //获取选中的选项，删除并追加给对方
	        $('#select1 option:selected').appendTo('#select2');
	    });
	    //移到左边
	    $('#remove').click(function() {
	        $('#select2 option:selected').appendTo('#select1');
	    });
	    //全部移到右边
	    $('#add_all').click(function() {
	        //获取全部的选项,删除并追加给对方
	        $('#select1 option').appendTo('#select2');
	    });
	    //全部移到左边
	    $('#remove_all').click(function() {
	        $('#select2 option').appendTo('#select1');
	    });
	    //双击选项
	    $('#select1').dblclick(function(){ //绑定双击事件
	        //获取全部的选项,删除并追加给对方
	        $("option:selected",this).appendTo('#select2'); //追加给对方
	    });
	    //双击选项
	    $('#select2').dblclick(function(){
	       $("option:selected",this).appendTo('#select1');
	    });
	});

	function submitForm(){
		var roles= new Array();
		var options = $("#select2").find("option");
		$.each(options,function(i,option){
			roles[roles.length+1]=$(this).val();
		})
		var role=roles.join(",");
		$.post("<%=basePath%>user/saverole/${userId}",
			{"roles":role},function(data){
	    	$.messager.alert('提示','操作成功');
			$("#appendChild").dialog('close');
	    	$('#dg').datagrid('reload');
		},"json").error(function(data){
			$.messager.alert('提示',data.responseText)
		});
	}
	</script>
	
</body>
</html>