<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>运行监控系统－国网技术学院</title>
<link href="${pageContext.request.contextPath}/static/css/style_1.css" rel="stylesheet" type="text/css" id="css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/components/core.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/rollups/aes.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/CryptoJS/rollups/md5.js"></script>
 <!--[if IE 6]>
	<script type="text/javascript" src="DD_belatedPNG.js" ></script>
	<script type="text/javascript">
	DD_belatedPNG.fix('.logo,.nav,.login_form,.notice,a');
	</script>
 <![endif]-->
 
 <script type="text/javascript">
	 $(function(){
		 if("${error}"){
			 $("#txt_pwd").val("");
		 }
		 $("#jcaptcha").click(function(){
			 $("#jcaptcha").attr("src","${pageContext.request.contextPath}/jcaptcha.jpg?time="+new Date());
		 });
	 });
		var aesKey; 
		function sub_mit(){
			var userName = $.trim($("#txt_name").val());
			var passWord = $.trim($("#txt_pwd").val());
			
			if(userName==""||passWord==""){
				alert("请输入用户名和密码！");
				return false;
			}
			if($("#jcaptcha").size()>0&&$("#jcaptchaCode").val()==""){
				alert("请输入验证码！");
				return false;
			}
			 $.ajax({
	                type: "POST",
	                url: "<c:url value='/login/aes'/>",
	                timeout: 600000,
	                success: function (data) {
	                	aesKey=data;
	                },
	                async:false
	            }); 
            $("#txt_pwd").val(Encrypt(passWord));
			var hash = CryptoJS.MD5($("#txt_pwd").val());
			$("#md5").val(hash);
		    return true;
		}
		 function Encrypt(word){
			 var key = CryptoJS.enc.Utf8.parse(aesKey);	
			 var iv  = CryptoJS.enc.Utf8.parse(aesKey);	
			 var srcs = CryptoJS.enc.Utf8.parse(word);
			 var encrypted = CryptoJS.AES.encrypt(srcs, key, { iv: iv,mode:CryptoJS.mode.CBC});
		     return encrypted.toString();
		}
		function load(){
		    if (window.parent && window.parent.length>0 && window.top.document.URL!=document.URL){  
		        window.top.location= document.URL;   
		    }  
		}
	</script>
</head>

<body class="login" onload="load()">
<div class="header">
	<div class="header_block">
      <div class="logo">&nbsp;</div>        
    </div>
</div>
<div class="main_login">
  <div class="login_form">
  <form action="" method="post" id="loginForm" onsubmit="return sub_mit()">
	    	<input type="hidden" name="md5" id="md5">
    <div class="form_list">
      <p>
        <input type="text" size="17" name="username" id="txt_name" /><span class="loginError tip13" id="hint_msg_name"></span>
      </p>
      <p>
        <input type="password" size="17" name="password" id="txt_pwd" /><span class="loginError tip11" id="hint_msg_pwd"></span>
       </p>
		<c:if test="${jcaptchaEbabled}">  
      <p style="margin: 0;margin-top: -20px;margin-bottom: -20px;">
        <input type="text" size="2" name="jcaptchaCode" id="jcaptchaCode" style="height: 20px;line-height: 20px;"/>
        <img id="jcaptcha" src="${pageContext.request.contextPath}/jcaptcha.jpg" style="position:absolute;+margin-top:1px;margin-left: 5px;"  title="点击更换验证码"/>  
      </p>
		</c:if>   
      <p class="btn">
        <input name="input"  type="image" src="${pageContext.request.contextPath}/static/images/loign_btn.gif" width="88" height="30" align="middle" alt="登录系统" style="border:none; width:88px; height:30px" />
        <!-- <input name="rememberMe" value="true" type="checkbox"  style="border:none; padding:3px" />
        自动登录 </p> -->
        </p>
        <p><span style="color:red">
											${error}
											<c:if test="${not empty param.kickout}">您的账号已在其他地点登陆。</c:if>
											<c:if test="${not empty param.maxonline}">在线用户已经达到最大值，请联系管理员。</c:if>
										</span> <span class="loginError tip11" id="hint_msg_checkcode"></span> </p>
    </div>
    </form>
  </div>
  <div class="footer_login">	
技术支持：国网信通产业集团安徽继远软件有限公司
</div>
</div>

</body>
</html>
