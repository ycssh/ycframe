<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
    <title>没有权限</title>
    <style>.error{color:red;}</style>
</head>
<body>

<div class="error">您没有权限[${exception.message}]</div>
</body>
</html>