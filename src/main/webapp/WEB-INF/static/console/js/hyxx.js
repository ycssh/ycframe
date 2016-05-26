$(function(){
	initHyxxComponent();
	
	$("#hyxx_opr_addUser").click(hyxxAddUser);
	
	$("#addUser_form_ok").click(doAddUser);
	
	$("#hyxx_opr_logout").click(doLogoutUser);
});

function initHyxxComponent(){
	
	initAddUserForm();
}

function doLogoutUser(){
	
	$.post("user/logout",{},function(data){
		
		//var data = eval('(' + data + ')');  // change the JSON string to javascript object
		var data = eval(data);
        if (data.success){
            //alert("操作成功！");
            
        	window.self.location.reload();
        }else{
        	alert(data.msg);
        }
        
	},"JSON");
}

function initAddUserForm(){
	$('#addUser_form').form({
		url : "user/save",
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
				alert("保存成功！");

				$("#addUser_win").window('close');
			} else {
				alert(data.msg);
			}
		}
	});
}

function hyxxAddUser(){
	
	$("#addUser_win").window({
		title:"添加用户",
		width:600,
	    height:500,
	    modal:true
	}).show();
	
	$("#addUser_form").form("reset");
}

function doAddUser(){
	var password = $.trim($("input[name='password']").val());
	var passworda = $.trim($("input[name='passworda']").val());
	if(password!=passworda){
		alert("密码不一致，请重新输入！");
		return;
	}
	
	$('#addUser_form').form("submit");
}