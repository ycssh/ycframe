$(function(){
	
	initComponent();
	
	$("#login_form_login").click(doLogin);
	
	$("#valicode").click(remakeValicode);
});

function initComponent(){
	
	initLoginForm();
}

function remakeValicode(){
	$(this).attr("src","user/valicode.do?_r="+new Date().getTime())
}

function initLoginForm(){
	$('#login_form').form({
		url : "user/login.do",
		onSubmit : function(param) {
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); // hide progress bar while the
												// form is invalid
			}
			return isValid; // return false will stop the form submission
		},
		success : function(data) {

			var data = eval('(' + data + ')'); // change the JSON string to
												// javascript object
			if (data.success) {
				
				window.self.location.href = 'console/main.jsp';
			} else {
				alert(data.msg);
				$("#valicode").click();
			}
		}
	});
}

function doLogin(){
	$('#login_form').form("submit");
}