<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>运行监控系统－国网技术学院</title>
<link href="${pageContext.request.contextPath}/static/new/stylesheets/login.css" rel="stylesheet" type="text/css" id="css" />
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
	  $(function() {
	    	  var $srollUl = $("#srollUl"),
	          scrollTimer;
		      scrollTimer = setInterval(function() {
		          scrollNews($srollUl);
		      }, 50);
	  })
	
	  function scrollNews(obj) {
	      var $self = obj.find("ul:first");
	      var lineHeight = $self.find("li:first").width() + 9; //获取行宽
	
	      var marginLeftNum = parseInt($self.css("marginLeft"));
	      $self.css("marginLeft", marginLeftNum - 1 + 'px');
	      if (marginLeftNum <= -lineHeight) {
	          $self.css("marginLeft", "0px");
	          $self.find("li:first").appendTo($self);
	      }
	  }
    </script>
 
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
    <div class="main">
        <div class="topWrap">
            <div class="topTitle"></div>
        </div>
    <div class="mainBody">

        <div class="loginWrap">
            <p class="loginTitle"></p>
            <div class="loginBox">
            
                <form action="" method="post" id="loginForm" onsubmit="return sub_mit()" class="loginForm">
                
                    <div class="required">
                        <label for="user">用户名：</label>
                        <input type="text" size="17" name="username" id="txt_name" /><span class="loginError tip13" id="hint_msg_name"></span>
                    </div>
                    <div class="required">
                        <label for="pwd">密&nbsp;&nbsp;&nbsp;码：</label>
                        <input type="password" size="17" name="password" id="txt_pwd" /><span class="loginError tip11" id="hint_msg_pwd"></span>
                    </div>


                    <c:if test="${jcaptchaEbabled}">
                    <div class="required" class="checkWrap">
                        <label for="checkMa">验证码：</label>
                        <input type="text" name="jcaptchaCode" id="jcaptchaCode" class="shortInput" />
                        <span class="shortCheckWrap"><img id="jcaptcha" src="${pageContext.request.contextPath}/jcaptcha.jpg" style="margin-top:1px;margin-left: 5px;"  title="点击更换验证码"/></span>
                    </div>
                    </c:if>
                    
          
                    <button class="loginBtn">登录</button>
                    
                    
                    <div style ="margin-left:68px;margin-top:10px;">
	                    <p><span style="color:red">
							${error}
							<c:if test="${not empty param.kickout}">您的账号已在其他地点登陆。</c:if>
							<c:if test="${not empty param.maxonline}">在线用户已经达到最大值，请联系管理员。</c:if>
						</span> <span class="loginError tip11" id="hint_msg_checkcode"></span> </p>
					</div>
                    
                </form>
                
                
            </div>
        </div>
        
        
        
   
        <div class="bottomWrap"  id="srollUl">
            <ul>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg1.png"/>
					<span class="info">产业孵化楼</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg2.png"/>
					<span class="info">教学楼</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg3.png"/>
					<span class="info">满园春色</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg4.png"/>
					<span class="info">喷泉</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg5.png"/>
					<span class="info">实训场地</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg6.png"/>
					<span class="info">泰山新区</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg7.png"/>
					<span class="info">图书馆</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg8.png"/>
					<span class="info">雪后初雯</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg9.png"/>
					<span class="info">樱花广场</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg10.png"/>
					<span class="info">日月同辉</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg11.png"/>
					<span class="info">泰山校区</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg12.png"/>
					<span class="info">学生公寓</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg13.png"/>
					<span class="info">樱花校园</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg14.png"/>
					<span class="info">樱花广场</span>
				</li>
				<li>
					<img src="${pageContext.request.contextPath}/static/new/images/login/scrollImg15.png"/>
					<span class="info">图书馆</span>
				</li>
            </ul>
        </div>
        
        
    </div>
    </div>
</body>
</html>
