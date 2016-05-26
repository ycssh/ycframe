<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<jsp:include page="../inc.jsp"></jsp:include>
<script type="text/javascript">

//初始化函数
$(function() {
	
	//表格加载函数
	tableLoad();
	
	//绑定工具栏点击事件
	$('#table-add').unbind('click').click(function(){roleAdd();});//添加
	$('#table-edit').unbind('click').click(function(){roleEdit();});//修改
	$('#table-remove').unbind('click').click(function(){roleDelete();});//删除
	$('#table-resource-ok').unbind('click').click(function(){resources();});//分配资源
	$('#table-role-ok').unbind('click').click(function(){roleOk();});//角色审核
	
	$('#tableSearchButton').unbind('click').click(function(){tableLoad();});//查询按钮
	$('#tableResetButton').unbind('click').click(function(){tableResetButton();});//重置按钮
	
});

//工具栏中的重置按钮函数
var tableResetButton =function(){
	//角色代码
	$('#role').val("");
	//角色名称
	$('#name').val("");
	//表格显示函数
	tableLoad();
};

/**
 * 表格展示函数
 */
var tableLoad = function(){
	//角色代码
	var role = $.trim($('#role').val());
	//角色名称
	var name = $.trim($('#name').val());
	
	//表格内容加载
	$('#dg').datagrid({
		url : '<%=basePath%>role/list',
		queryParams:{
			isSelect:'1',//是否查询，用于阻止easy-ui重复查询
			role: role,//角色代码
			name: name//角色名称
	    },
		method:'post',
		onRowContextMenu:onRowContextMenu
	});
	
	$("#dg").datagrid('hideColumn', "id");
};

//角色增加
function roleAdd(){
	$("#appendChild").dialog({
	    title: '新增角色',
	    width: 400,
	    closed: false,
	    cache: false,
	    href: "<%=basePath%>role/add",
	    modal: true,
	    onBeforeClose:function(){
	    	//表格显示函数
	    	tableLoad();
	    }
	});
}

//角色修改
function roleEdit(){
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要编辑的记录');
    	return ;
	}
	$("#appendChild").dialog({
	    title: '编辑角色',
	    width: 400,
	    closed: false,
	    cache: false,
	    href: "<%=basePath%>role/edit/"+row.id,
	    modal: true,
	    onBeforeClose:function(){
	    	//表格显示函数
	    	tableLoad();
	    }
	});
}

//删除角色操作
function roleDelete(){
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要删除的记录');
    	return ;
	}
	if(confirm("确定删除?")){
		$.post("<%=basePath%>role/delete/"+row.id,{},function(data){
	    	$.messager.alert('提示','删除成功');
	    	//表格显示函数
	    	tableLoad();
		},"json");
	}
}

	//分配资源
	function resources(){
		//获取所选记录
		var row = $('#dg').datagrid('getSelected');	
		//判断是否勾选记录
		if(!row){
	    	$.messager.alert('提示','请选择要分配的角色记录');
	    	return ;
		}
					$("#resources").window({
						title: '分配资源',
						width: 400,
						height:300,
						cache: false,
						href: "<%=basePath%>role/editresources/"+row.id,
						onBeforeClose:function(){
					    	//表格显示函数
					    	tableLoad();
						}
					});
	}
	
	
	//分配资源
	function roleOk(){
		//获取所选记录
		var row = $('#dg').datagrid('getSelected');	
		//判断是否勾选记录
		if(!row){
	    	$.messager.alert('提示','请选择要审核的角色记录');
	    	return ;
		}
		//获取当前用户 角色编码 ，根据不同的用户编码显示不同的资源
		$.post('<%=basePath%>role/nowUserRoleCode')
			.done(function(data){
				//获取用户显示资源权限	
				if(data == null || data.length ==0 || data =='no'){
					$.messager.alert('提示','无权限进行操作');
					return ;
				}else{
					$("#resources").window({
						title: '审核角色',
						width: 400,
						height:300,
						cache: false,
						href: "<%=basePath%>role/rolePass/"+row.id,
						onBeforeClose:function(){
					    	//表格显示函数
					    	tableLoad();
						}
					});
				}
			})
			.fail(function(){
				$.messager.alert('提示','操作错误');
		    	return ;
			});
	}
	
	
	
	function onRowContextMenu(e,row){
	var rm = $('#rm_organization');
	e.preventDefault();
	rm.menu({
		onClick:function(item){
		     if(item.text=='刷新'){
		        datagrid.datagrid('reload');
		     }
		 }
	});
	rm.menu('show',{
		left: (e.pageX+20),
		top: (e.pageY-20)
	});
	};

	
</script>

</head>
<body class="easyui-layout">

	<!-- 显示的表格 -->
	<div data-options="region:'center',href:'',title:'权限列表'" style="overflow: hidden;" id="center">
		<table id="dg" data-options="toolbar:'#tb'">
					<thead>  
							<tr>  
								<th field="ck" checkbox="true"></th>
								<th field="id" >角色编号</th>  
								<th field="role" >角色编码</th> 
								<th field="name" >角色名称</th>   
							</tr>  
					 </thead>  
		</table>
	</div>
			
	
	<!-- 表格工具栏 -->
	<div id="tb" style="padding:5px;">
		<div style="margin-bottom:5px">
			<a href="javascript:void(0);" id ="table-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:void(0);" id ="table-edit" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:void(0);" id ="table-remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
			<a href="javascript:void(0);" id ="table-resource-ok" class="easyui-linkbutton" iconCls="icon-ok" plain="true">分配资源</a>
		</div> 

		<div>
			角色代码:
			<input id="role" class="easyui-textbox" style="line-height:17px;width:100px;border:1px solid #ccc">
			&nbsp;角色名称:
			<input id="name" class="easyui-textbox" data-options="min:1,max:12" style="line-height:17px;width:100px;border:1px solid #ccc">
			
			&nbsp;
			<a id ="tableSearchButton" href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-search">查询</a>
			<a id ="tableResetButton" href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-reload">重置</a>
			
		</div>
	</div>
			
			
			
			
			
			
	<div id="appendChild"></div>
	<div id="resources"></div>
</body>
</html>