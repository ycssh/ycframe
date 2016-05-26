<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
		<base href="<%=basePath%>">

		<link rel="stylesheet"
			href="<%=basePath%>static/jcrop/css/jquery.Jcrop.css" type="text/css" />
		<title>上传图像</title>
	</head>

	<body>
		<p class="col-hints">
			当前头像
			<img onerror="this.src='<c:url value='/temp/1361792500_60496.ico'/>'" src="<c:url value='/user/getavatar'/>?time=<%=System.currentTimeMillis() %>" width="50px">
			<span id="J_err" style="margin-left: 15px;">支持JPG、PNG、GIF、BMP格式的图片文件，文件大小小于1M</span>
		</p>
		<form action="<c:url value='/user/avatar'/>" id="user-face-form" method="POST" enctype="multipart/form-data">
			<input type="file" name="avatar" id="user-acatar-big">
			<input type="button" class="btn btn-success" value="上传" onclick="return false;" id="user-face-submit">
			<input type="button" class="btn btn-success" value="裁剪并保存" style="display: none" onclick="return false;" id="user-face-save">
		</form>
		<img alt="" src="" id="user-face-img" style="display: none;">
		<form id='form_save' action="<c:url value='/user/saveimg'/>" method="POST" style='display:none;'>
			<input type='hidden' id='img_left' name='left' value='0'/>
			<input type='hidden' id='img_top' name='top' value='0'/>
			<input type='hidden' id='img_width' name='width' value='0'/>
			<input type='hidden' id='img_height' name='height' value='0'/>
			<input type='hidden' id='img_type' name='img_type'/>
		</form>
			<script type="text/javascript">
				/**
     * 保存大图
     */
	$("#user-face-submit").live("click",function(){
		if($("#user-acatar-big").val()==""){
			art.dialog.alert("请选择文件");
			return;
		}
		$("#user-face-submit").attr("disabled","disabled")
		$("#user-face-form").ajaxSubmit({
			success:function(data){
				$("#user-face-submit").removeAttr("disabled");
				var msg = eval("(" + data + ")");
				if("N"==msg.result){
					top.art.dialog.tips(msg.message);
				}else{
					$('#user-face-img').css("width",msg.width+"px");
	                $('#user-face-img').css("height",msg.height+"px");
	                $('#img_type').val(msg.file_type);
	                $('#user-face-img').show();
	                $("#user-face-save").show();
	                $("#user-face-submit").hide();
					$("#user-face-img").attr("src",_BASE_PATH+msg.path);
					var api = jQuery.Jcrop('#user-face-img',{
		                setSelect: [ 10, 10, 200, 200 ],
		                aspectRatio: 1,
		                onChange: showCoords,
		                onSelect: showCoords
		            });
				}
			}
		});
	})
	
	/*保存大图片之后显示在页面*/
	function showCoords(c){
		    $('#img_left').val(c.x);
		    $('#img_top').val(c.y);
		    $('#img_width').val(c.w);
		    $('#img_height').val(c.h);
		  };
		  
	$("#user-face-save").live("click",function(){
		$("#form_save").ajaxSubmit({
			success:function(){
				$(".main").load(formatUrl("user/face?time="+Date.parse(new Date())+" #user-face"));
			}
		})
	})
			</script>
	</body>
</html>
