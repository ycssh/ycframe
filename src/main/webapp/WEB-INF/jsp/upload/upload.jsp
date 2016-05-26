<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /><meta http-equiv="X-UA-Compatible" content="IE=EDGE,chrome=1"/> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body style="font-family: 微软雅黑;">
<style>

</style>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.form.js" charset="utf-8"></script>

<div class="easyui-panel">
		<div id="dlg-toolbar" class="easyui-linkbutton-backcolor"
			style="padding:2px 0;">
			<table cellpadding="0" cellspacing="0" style="width:100%">
				<tr>
					<td style="padding-left:2px;font-family: 微软雅黑;"><a href="javascript:void(0)"
						class="easyui-linkbutton"
						data-options="iconCls:'icon-save',plain:true"
						onclick="submitForm()">导入</a></td>
				</tr>
			</table>
		</div>
		<div style="padding:0px 0px 0px 0px;height:382px">
			<form id="uploadForm" enctype="multipart/form-data" method="post" >
				<span style="margin-left:10px;font-family: 微软雅黑;">请选择文件:</span>
				<input type=file name=file id=file>
			<!-- 	<input name=ye style="color: blue;border: 1px solid blue"> 
				<input type=button value="浏览" onclick=file.click() style="border: 1px solid blue">		 -->		
			</form>
		</div>
	</div>
<script>
	function submitForm(){
		if(!$("#uploadForm").form('validate')){
			return ;
		};
		var file = $("#file").val();
		if(file==""){
			$.messager.alert('提示','请选择要导入的excel');
			return;
		}
		
		var index = file.indexOf(".xls");
		if(index!=file.length-4){
			$.messager.alert('提示','请上传xls文件');
			return;
		}
		$.messager.progress({"text":"<span style='text-align:center'>数据加载中，请稍后...</span>"});
	
		$("#uploadForm").ajaxSubmit({
			type : "post",
			dataType : "text",
			url:'<%=basePath%>upload/excelImp.action?type=${uploadType}',
			success : function(data) {
				$.messager.progress('close');
				var success = data.substring(data.length-6,data.length-1);
				var msg = data.substring(8,data.length-17);
				//var data = $.parseJSON(data);
				if(success==="true"){
					
					$("#mainGrid").datagrid('reload');
				}else{
					$.messager.alert('提示',msg);
				}
				
				
				$(".panel-tool-close").trigger('click');
				$.messager.alert('提示',msg);

				

			},
			error : function() {
				$.messager.progress('close');
				$.messager.alert('提示','导入失败,请检查网络');
			}
		}); 
	
}
</script>
</body>

</html>