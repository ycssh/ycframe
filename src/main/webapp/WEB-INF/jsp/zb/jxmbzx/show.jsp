<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
    <base href="<%=basePath%>">
    
    <title>绩效目标执行监测</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript"
	src="<%=basePath%>static/js/jquery-1.11.0.min.js"></script>
	
	<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/easyui-lang-zh_CN.js"></script>
	
<script type="text/javascript">
$(function(){

	initGrid();
	
	$("#export").bind("click",doExport);
});

function doExport(){
	window.open('jxmbzx/export.do?filter=year='+ $.trim($("#s_year").combobox('getValue')));
}


function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'jxmbzx/findShowData.do',
	    toolbar:"#toolbar",
	    queryParams:{
//	    	filter:"zbname="+$.trim($("#s_zbname").val())+"&field="+$.trim($("#s_field").val())
	    },
	    columns:[[
	        {field:'name',title:'',width:300},
	        {field:'finished',title:'年累计值',width:150},
	        {field:'percent',title:'年计划完成率',width:500,formatter:percentFormater},
	        {field:'plan',title:'年度目标值',width:150},
	        {field:'minus',title:'与目标差距',width:150}
	    ]],
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true
	});
}

function reDraw(y){

	var year = $.trim($("#s_year").combobox('getValue'));
	
	$("#mainGrid").datagrid("load",{
		filter:"year="+year
	});
}

function percentFormater(a,b,c,d,e,f,g){

	a = a.toFixed(2);
	
	return "<div style='width:250px'><img src='static/images/bg.png' align='middle' title='"+a+"%'  height='20px' width='"+(a>100?100:a)+"%' alt='aaa' /><img src='static/images/"+(a>100?"overbg":"unbg")+".png' align='middle' title='"+a+"%'   height='20px' width='"+((100-a)<0?(a-100):(100-a))+"%' alt='aaa' /> &nbsp;（"+a+"%）</div>";
}

</script>
  </head>
  
  <body>
  	<div>
  		<span style="font-size: 12px;">请选择年份：</span><input id="s_year" name="s_year"  style="width: 350px" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        required:true,
        value:2015,
        url: 'jxmbzx/findShowYears.do',
        onSelect: function(rec){
            
            reDraw(rec.value);
        }">
        <!-- <div id="export" class="easyui-linkbutton"
			data-options="iconCls:'icon-ok',plain:true">导出</div> -->
  	</div>
  	<p>
    
    <table id="mainGrid"></table>
  </body>
</html>
