<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
	    <title></title>
	    

	</head>
	
<body>
	<div id="dlg-toolbar" class="easyui-linkbutton-backcolor" style="padding:2px 0;">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" id="saveButton">保存</a>
	</div>
	<form action="<%=basePath%>resource/uploadPic/upload" id="saveform" method="post" enctype="multipart/form-data">
    	<input type="hidden" value="${resId }" name="id" id="id">
       <table>
       	<tr><td>上传菜单图标</td><td>
        <input id="fileupload" type="file"  name="impFile" > <br>
       		</td></tr>
       </table>
    </form>
	<script type="text/javascript" src="<%=basePath%>static/js/jquery.form.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#type").val("${resource.type}")
		$("#saveButton").bind("click",function(){
		
			var fileName = $("#fileupload").val();
			if(fileName){
				if(fileName.indexOf(".")<0){
					alert('图片无法识别，请选择后缀名是png或者jpg格式的图片！');
					return;
				}
			
				var fileExt = fileName.substring(fileName.lastIndexOf(".")+1);
				if(fileExt!='png'&&fileExt!='jpg'){
					alert('图片格式不支持！仅支持png和jpg格式。');
					return;
				}
			}else{
				alert('请选择图标！');
				return;
			}
		
			$("#saveform").ajaxSubmit({
				type : "post",
				dataType:"json",
				success : function(data) {
					
					//var data = eval('(' + data + ')'); // change the JSON string to
					// javascript object
					if (data.success) {
						alert('上传成功！');
			
					} else {
						alert(data.msg);
					}
		
					$("#dlg").dialog("close");
				}
			})
		})
	})
		
	</script>


</body>

</html>