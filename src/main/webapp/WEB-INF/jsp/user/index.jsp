<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<jsp:include page="../inc.jsp"></jsp:include>
<link rel="stylesheet" href="<%=basePath%>static/zTree3.5/css/zTreeStyle/zTreeStyle.css"></link>
<script src="<%=basePath%>static/zTree3.5/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/components/core.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/rollups/aes.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/rollups/md5.js"></script>
<script type="text/javascript">
//全局变量：
var organizationId;//部门ID

//初始化函数
$(function() {
	//实例化其他函数
	initForm();
	
	//绑定弹出层 保存和重置按钮
	$("#save").bind("click",saveItem);
	$("#reset").bind("click",resetForm);
	
	
	//左侧部门树加载函数
	$.fn.zTree.init($("#tree"), setting);
	
	//加载表格显示按钮
	tableLoad();
		
	//绑定工具栏点击事件
	$('#table-add').unbind('click').click(function(){userAdd();});//添加
	$('#table-edit').unbind('click').click(function(){userEdit();});//修改
	$('#table-remove').unbind('click').click(function(){userDelete();});//删除
	$('#table-ok').unbind('click').click(function(){role();});//分配用户角色
	$('#table-reset').unbind('click').click(function(){resetPassword();});//重置密码
	$('#table-colse').unbind('click').click(function(){colse();});//锁/解锁
	$('#table-canNot').unbind('click').click(function(){canNot();});//注销


	$('#tableSearchButton').unbind('click').click(function(){tableLoad();});//查询按钮
	$('#tableResetButton').unbind('click').click(function(){tableResetButton();});//重置按钮
	
});

//重置按钮函数
var tableResetButton =function(){
	//登录账号
	$('#loginName').val("");
	//姓名
	$('#realName').val("");
	//账号状态
	$('#locked').combobox("setValue","");
	//角色分配状态
	$('#syURoleId').combobox("setValue","");
	//表格显示函数
	tableLoad();
};

/**
 * 表格展示函数
 */
var tableLoad = function(){

	//获取登录账号
	var loginName = $.trim($('#loginName').val());
	//获取姓名
	var realName = $.trim($('#realName').val());
	//获取账号状态
	var locked = $.trim($('#locked').combobox('getValue'));
	//获取角色分配状态
	var syURoleId = $.trim($('#syURoleId').combobox('getValue'));
	//获取部门ID(按照需求 ，当点击 部门树中的跟组织，则查询所有部门)
	var nowOrganizationId = organizationId == 0 ? null:organizationId;
	
	//表格内容加载
	$('#dg').datagrid({
		url : '<%=basePath%>user/list',
		queryParams:{
			isSelect:'1',//是否查询，用于组织easy-ui重复查询
			username: loginName,//登陆账号
			name: realName,//姓名
			locked: locked,//账户状态
			organizationId: nowOrganizationId//部门ID
	    },
		method:'post',
		onRowContextMenu:onRowContextMenu
	});
	
	$("#dg").datagrid('hideColumn', "id");
};

//锁/解锁    激活 -》锁定    锁定->激活
var colse = function(){
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要操作的记录');
    	return ;
	}
	//获取账号状态
	var lockedId = row.locked;
	if( !(lockedId==0 || lockedId == 1) ){
		$.messager.alert('提示','账号需为激活或锁定状态');
    	return ;
	}
	//根据状态判断题提示语
	var mes = "";
	if(lockedId==0){
		mes = "锁定";
	}else{
		mes = "激活";
	}
	lockedId = lockedId=='0'?'1':'0';
	//锁定/激活操作
	if(confirm("确定"+mes+"?")){
		$.ajax({
			url:"<%=basePath%>user/state/"+lockedId+"/"+row.username,
			success:function(data){
				$.messager.alert('提示',mes+'成功');
		    	$('#dg').datagrid('reload');
			},
			error:function(data){
				$.messager.alert('提示',data.responseText)
			},
			type : 'post'
		})
		
	}
		
};


//注销操作 激活-》注销
var canNot = function(){
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要上要审核的记录');
    	return ;
	}

	if(row.loginName=="sgtc_sjgl"||row.loginName=="sgtc_sfgl"||row.loginName=="sgtc_shgl"||row.loginName=="sgtc_ywgl"||row.loginName=="sgtc_xtgl"){
    	$.messager.alert('提示','管理员账号不可操作');
    	return ;
	}
	//获取账号状态
	var lockedId = row.locked;
	if( !(lockedId==0) ){
		$.messager.alert('提示','账号需为激活状态');
    	return ;
	}
	
	//注销操作
	if(confirm("确定注销?")){
		$.post("<%=basePath%>user/canNot",{userId:row.userId})	
			.done(function(data){
				$.messager.alert('提示','注销成功');
		    	$('#dg').datagrid('reload');
			})
			.faile(function(){
				alert("操作失败");
			});
	}
	
};


//左侧部门数加载函数
var setting = {
	async : {
		enable : true,
		url : "<%=basePath%>organization/ajaxtree",
		dataType : "json",
		type : 'get',
		autoParam : [ "id" ]
	},
	callback : {
		onClick : zTreeOnClick,
		onAsyncSuccess: zTreeOnAsyncSuccess
	},
	data : {
		key:{
			name:"name"
		},
		simpleData : {
			enable : true,
			idKey : "id",
			pIdKey : "parentId",
			rootPId : 0
		}
	},
	edit:{
		enable:true,
		showRemoveBtn:false,
		showRenameBtn:false
	}
};
/**Tree单击事件*/
function zTreeOnClick(event, treeId, treeNode) {
	organizationId = treeNode.id;
	//加载表格显示函数
	tableLoad();
}
/**
 * 加载树的根节点的时候展开，并查询
 */
function zTreeOnAsyncSuccess(event, treeId, treeNode){
	if(treeNode==null){
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var node = treeObj.getNodeByParam("id", 0, null);
		organizationId = node.id;
		treeObj.expandNode(node, true);
		//加载表格显示函数
		tableLoad();
	}
}

//添加按钮
function userAdd(){
	if(organizationId==null || organizationId==0){
    	$.messager.alert('提示','请现在左侧选择部门');
    	return;
	}
	$("#window").window({
		title : "新增",
		width : 700,
		height : 320,
		modal : true
	}).show();
	
	//当前表单类型置为1 表示为添加
	$('#isAddOrUpdate').val('1');
	
	$('#form').form('reset');
	
	$("#passwordTr").show();
	$("#passwordaTr").show();
	$("#organizationId").val(organizationId);
	$("#username").removeAttr("readonly");
	$("#usernameTips").hide();
}

//修改按钮
function userEdit(){
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要编辑的记录');
    	return ;
	}
	$("#window").window({
		title : "修改",
		width : 700,
		height : 320,
		modal : true
	}).show();
	
	//当前表单类型置为0 表示为修改
	$('#isAddOrUpdate').val('0');
	
	$('#form').form('reset');
	$("#form").form('load',row);
	
	$("#name").val(row.name);
	$("#username").val(row.username);
	$("#username").attr("readonly","readonly");
	$("#usernameTips").show();
		
	$("#password").val("password");
	$("#passworda").val("password"); 
	$("#passwordTr").hide();
	$("#passwordaTr").hide();

}

//删除按钮
function userDelete(){
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要上删除的记录');
    	return ;
	}
	if(confirm("确定删除?")){
		$.post("<%=basePath%>user/delete/"+row.id)
			.done(function(){
				$.messager.alert('提示','删除成功');
		    	$('#dg').datagrid('reload');
			})
			.faile(function(){});
	}
}
function Encrypt(word){
	 var key = CryptoJS.enc.Utf8.parse(aesKey);	
	 var iv  = CryptoJS.enc.Utf8.parse(aesKey);	
	 var srcs = CryptoJS.enc.Utf8.parse(word);
	 var encrypted = CryptoJS.AES.encrypt(srcs, key, { iv: iv,mode:CryptoJS.mode.CBC});
    return encrypted.toString();
}

var aesKey = "<%=session.getAttribute("aesKey")%>";
//保存按钮
function saveItem(){
	
	var row = $('#dg').datagrid('getSelected');
	
	//由于无法传探究往后台传输用户ID，故运用AJAX传输。
	//若为修改页面，这重置页面的时候不是全置为空，而是职位所选内容
	if($('#isAddOrUpdate').val() == 0 && row){
		//用户ID
		var userId = row.id;
		//修改后的姓名
		var name =$("#name").val() ;
		//获取用户登录账号
		var username =$("#username").val();
		//修改用户姓名
		$.ajax({
			type : 'post',  
            url : '<%=basePath%>user/create',   
            data:{id:userId,name:name},
            contentType: "application/json; charset=utf-8",
            async: false,//禁止ajax的异步操作，使之顺序执行。  
            dataType : 'json',  
			success:function(data){
				if(data==""){
					$.messager.alert('提示','操作成功');
					$("#window").dialog('close');
					$('#dg').datagrid('reload');
				}else{
					alert(data);
				}
			},
			error:function(data){
				$.messager.alert('提示',data.responseText)
			}
		});
		
	}else{
		if($.trim($("#password").val())!=$.trim($("#passworda").val())){
			$.messager.alert("提示","重复密码不一致！");
			return false;
		}
		
		if($.trim($("#username").val())==$.trim($("#passworda").val())){
			$.messager.alert("提示","账号名称与密码不能一致！");
			return false;
		}
		var now=$("#passworda").val();
		var reg = /^(?=.*\d.*)(?=.*[a-zA-Z].*).{8,20}$/;
		if(reg.test(now)){
	            $("#password").val(Encrypt($("#password").val()));
	            $("#passworda").val(Encrypt($("#passworda").val()));
				var hash = CryptoJS.MD5($("#password").val());
				$("#md5").val(hash);
		}else{
			alert("密码必须包含数字和字母的8-20位字符");
			return false;
		};		
		$('#form').form('submit', {
		    success:function(d){
		    	if(d==""){
			    	$.messager.alert('提示','操作成功');
					$("#appendChild").dialog('close');
			    	$('#dg').datagrid('reload');
		    	}else{
			    	$.messager.alert('提示',d);
		    	}
		    },
		    error:function(){
		    	$.messager.alert('提示','操作失败');
		    }
		});
	}
}

//重置按钮
function resetForm(){
	
	var id = $("#id").val();
	var row = $('#dg').datagrid('getSelected');
	
	//若为修改页面，这重置页面的时候不是全置为空，而是职位所选内容
	if($('#isAddOrUpdate').val() == 0 && row){
		$("#name").val(row.realName);
		$("#username").val(row.loginName);
	}else{
		$('#form').form('reset');
	}

	
	if(id&&id.length>0){
		var r = $("#dg").datagrid('getChecked');
		
		if(r&&r.length==1){
			$("#form").form('load',r[0]);
			
			$("#password").val("password");
			$("#passworda").val("password");
		}
	}
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

function reload(){
	$.fn.zTree.init($("#tree"), setting);
}

function refreshItem(){
	
	$("#dg").datagrid('reload');
}

function initForm(){
	
	$('#form').form({
		url : "create.do",
		onSubmit : function(param) {
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); // hide progress bar while the
												// form is invalid
			}
			
			return isValid; // return false will stop the form submission
		},
		success : function(data) {
			// alert(data)

			var data = eval('(' + data + ')'); // change the JSON string to
												// javascript object
			if (data.success) {

				$.messager.alert("提示","保存用户成功！");
				$("#window").window('close');
				refreshItem();
			} else {
				alert(data.msg);
			}
		}
	});
}


function role(){
		var row = $('#dg').datagrid('getSelected');
		if(!row){
	    	$.messager.alert('提示','请选择要上编辑的记录');
	    	return ;
		}
		$("#appendChild").window({
		    title: '编辑角色',
		    width: 600,
		    height:350,
		    cache: false,
			href : "<%=basePath%>user/role/"+row.id,
		    onBeforeClose:function(){
		    	$('#dg').datagrid('reload');
		    }
		});
}

function resetPassword()
{
	var row = $('#dg').datagrid('getSelected');
	if(!row){
    	$.messager.alert('提示','请选择要重置密码的记录');
    	return ;
	}
	var createDiv = "<div id='resetpwds'><div/>";
	$(createDiv).dialog({
		title: '密码设置',
		width: 350,
		height: 250,
		closed: false,
		cache: false,
		href: '${pageContext.request.contextPath}/user/resetPassword/'+row.id,
		modal : true,
		onClose : function() {
		$(this).dialog('destroy');
	} 
	});
}

</script>

</head>
<body class="easyui-layout">
	<!-- 左侧 部门树 -->
	<div
		data-options="region:'west',split:true,title:'部门树',tools : [ {
						iconCls : 'icon-reload',
						handler : reload
					}]"
		style="width: 200px; padding: 10px;">
		<ul id="tree" class="ztree" style="margin-top: 5px;"></ul>
	</div>

	<!-- 显示的表格 -->
	<div data-options="region:'center',href:'',title:'用户列表'"
		style="overflow: hidden;" id="center">
		<table id="dg"  data-options="toolbar:'#tb'">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'id'" align="center">用户Id</th>
					<th data-options="field:'username'" width="20%" align="center">用户名</th>
					<th data-options="field:'locked',formatter:function(value,row,index){return value=='0'?'正常':'锁定';}" width="20%" align="center">用户状态</th>
					<th data-options="field:'name'" width="20%" align="center">姓名</th>
					<th
						data-options="field:'roleName'"
						width="20%" align="center">角色名称</th>
				</tr>
			</thead>
		</table>
	</div>
<!-- 表格工具栏 -->
<div id="tb" style="padding:5px;">
	<div style="margin-bottom:5px">

	<shiro:hasPermission name="admin:user:edit">
			<a href="javascript:void(0);" id ="table-add" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:void(0);" id ="table-edit" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:void(0);" id ="table-remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
			<a href="javascript:void(0);" id ="table-reset" class="easyui-linkbutton" iconCls="icon-reset" plain="true">重置密码</a> 
			<a href="javascript:void(0);" id ="table-colse" class="easyui-linkbutton" iconCls="icon-remove" plain="true">锁/解锁</a>
	</shiro:hasPermission>	
					
	<shiro:hasPermission name="admin:user:setRole">					
			<a href="javascript:void(0);" id ="table-ok" class="easyui-linkbutton" iconCls="icon-ok" plain="true">分配用户角色</a>
	</shiro:hasPermission>
			
	</div> 

		<div>
			登陆账号: <input id="loginName" class="easyui-textbox"
				style="line-height: 17px; width: 100px; border: 1px solid #ccc">
			&nbsp;姓名: <input id="realName" class="easyui-textbox"
				data-options="min:1,max:12"
				style="line-height: 17px; width: 100px; border: 1px solid #ccc">
			&nbsp;账户状态: <select id="locked" class="easyui-combobox"
				panelHeight="auto" style="width: 100px" editable="false">
				<option value="">不限</option>
				<option value="0">激活</option>
				<option value="1">锁定</option>
				<option value="2">注销</option>
				<option value="3">未激活</option>
				<option value="4">待删除</option>
			</select> &nbsp;角色分配状态: <select id="syURoleId" class="easyui-combobox"
				panelHeight="auto" style="width: 100px" editable="false">
				<option value="">不限</option>
				<option value="0">生效</option>
				<option value="1">无效</option>
				<option value="100">其他</option>
			</select> &nbsp; <a id="tableSearchButton" href="javascript:void(0);"
				class="easyui-linkbutton" iconCls="icon-search">查询</a> <a
				id="tableResetButton" href="javascript:void(0);"
				class="easyui-linkbutton" iconCls="icon-reload">重置</a>

		</div>
	</div>


	<div id="appendChild"></div>


	<!-- Window -->
	<div id="window" style="display: none;">

		<form id="form" method="post">

			<input class="easyui-validatebox" type="text" id="id" name="id"
				style="width: 350; display: none;" /> <input
				class="easyui-validatebox" type="text" id="organizationId"
				name="organizationId" style="width: 350; display: none;" />

			<fieldset style="margin-top: 10px">
				<legend>用户信息</legend>
				<table width="100%">
					<tr>
						<td width="40%">姓名:</td>
						<td width="60%"><input maxlength="50"
							class="easyui-validatebox" validType="length[0,12]"
							invalidMessage="不能超过12个字符！" type="text" id="name" name="name"
							style="width: 250px" data-options="required:true" /></td>
					</tr>
					<tr>
						<td>登录帐号:</td>
						<td><input maxlength="50" class="easyui-validatebox"
							type="text" validType="length[0,12]" invalidMessage="不能超过12个字符！"
							id="username" name="username" style="width: 250px"
							data-options="required:true" /><font id="usernameTips"
							color="red" size="2">用户名不允许修改！</font></td>
					</tr>

					<tr id="passwordTr">
						<td>登录密码:</td>
						<td><input maxlength="50" class="easyui-validatebox"
							type="password" id="password" 
							name="password" style="width: 250px" data-options="required:true" /></td>
					</tr>
					<tr id="passwordaTr">
						<td>重复登录密码:</td>
						<td><input maxlength="50" class="easyui-validatebox"
							type="password" id="passworda" name="passworda"
							style="width: 250px" data-options="required:true" /></td>
					</tr>

				</table>
				<input type="hidden" name="md5" id="md5"/>
			</fieldset>

			<table width="100%">
				<tr>
					<td align="center"><a id="save" href="#"
						class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>
						<a id="reset" href="#" class="easyui-linkbutton"
						data-options="iconCls:'icon-reset'">重置</a></td>
				</tr>
			</table>

		</form>

		<!--用于判断 当前弹出框为添加还是修改；默认为1：为添加   ；  0：为修改  -->
		<div id="isAddOrUpdate" Style="display: none;">1</div>

	</div>
</body>
</html>