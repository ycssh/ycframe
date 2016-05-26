<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>新员工培训运营状况监测</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
table td{
	font-size: 12px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>

<script type="text/javascript">
var clientHeight = document.documentElement.clientHeight;
$(function(){
	initGrid();
	initTotalGrid();
	$("#search").bind("click",doSearch);
	$("#s_reset").bind("click",resetSearchBox);
});


function resetSearchBox(){
	
	$("#s_deptId").combobox('setValue',null);
	$("#s_projectId").combobox('setValue',null);
	$("#s_majorId").combobox('setValue',null);
}

function doSearch(){
	var projectId = $.trim($("#s_projectId").combobox('getValue'));
	if(projectId =='' || projectId == null)
	{
		alert("请选择项目");
		return;
	}
	var deptId = $.trim($("#s_deptId").combobox('getValue'));
	
	
	var majorId = $.trim($("#s_majorId").combobox('getValue'));
	$("#mainGrid").datagrid("load",{
		filter:"type=1&deptId="+deptId+"&projectId="+projectId+"&majorId="+majorId
	});
	
	$("#totalGrid").datagrid("load",{
		filter:"type=1&projectId="+projectId+"&deptId="+deptId
	});
}


function initGrid(){
	
	$('#mainGrid').datagrid({
	    url:'pxyyzk/findAllXyg.do',
	    toolbar:"#toolbar",
	    fit:false,
	    height:clientHeight-190,
	    queryParams:{
	    	filter:"type=1"
	    },
	    columns:[[
	        {field:'deptName',title:'专业培训部',width:80},
	        {field:'majorName',title:'专业',width:80},
	        {field:'className',title:'班级',width:100},
	        {field:'solution',title:'方案编制',width:50,formatter:zkFormatter,align:'center'},
	        {field:'kcb',title:'课表编制',width:50,formatter:zkFormatter,align:'center'},
	        {field:'wzx',title:'教室安排',width:50,formatter:zkFormatter,align:'center'},
	        {field:'bzr',title:'班主任安排',width:50,formatter:zkFormatter,align:'center'},
	        {field:'bd',title:'学员报到',width:50,formatter:zkFormatter,align:'center'},
	        {field:'qywh',title:'企业文化和主营业务成绩报送',width:50,formatter:zkFormatter,align:'center'},
/* 	        {field:'jsbs',title:'技能竞赛笔试成绩报送',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jscz',title:'技能竞赛操作成绩报送',width:50,formatter:zkFormatter,align:'center'}, */
	        {field:'jx',title:'军训成绩',width:50,formatter:zkFormatter,align:'center'},
	        {field:'yd',title:'月度成绩',width:50,formatter:zkFormatter,align:'center'},
	        {field:'jy',title:'结业成绩',width:50,formatter:zkFormatter,align:'center'},
	        {field:'yxxy',title:'优秀学员',width:50,formatter:zkFormatter,align:'center'},
	        {field:'yxgb',title:'优秀干部',width:50,formatter:zkFormatter,align:'center'}
	    ]],
	    rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true,
		pageSize:20,
	    pagination:true,
		onLoadSuccess:function(data){
			var rows = data.rows;
			var majorMergeList = new Array();
			
			var bo = null;
			var mIsFirst = true,dIsFirst = true;
			var mIndex = null,dIndex = null;
			var mNum = 1,dNum = 1;
			for(var i=0;i<rows.length;i++){
				var o = rows[i];
				if(bo==null){
					bo = o;
					continue;
				}
				
				if(o.majorName==bo.majorName){
					if(mIsFirst){
						mIndex = i>0?(i-1):0;
						mIsFirst = false;
					}
					mNum++;
				}else{
					if(!mIsFirst){
						majorMergeList.push({index:mIndex,rowspan:mNum,field:'majorName'});
					}
					mIsFirst = true;
					mNum = 1;
				}
				
				if(o.deptName==bo.deptName){
					if(dIsFirst){
						dIndex = i>0?(i-1):0;
						dIsFirst = false;
					}
					dNum++;
				}else{
					if(!dIsFirst){
						majorMergeList.push({index:dIndex,rowspan:dNum,field:'deptName'});
					}
					dIsFirst = true;
					dNum = 1;
				}
				bo = o;
				
				if(i==rows.length-1){
					if(mNum>1){
						majorMergeList.push({index:mIndex,rowspan:mNum,field:'majorName'});
					}
					if(dNum>1){
						majorMergeList.push({index:dIndex,rowspan:dNum,field:'deptName'});
					}
				}
				
			}
			
			for(var i=0;i<majorMergeList.length;i++){
				$(this).datagrid('mergeCells',{
                    index: majorMergeList[i].index,
                    field: majorMergeList[i].field,
                    rowspan: majorMergeList[i].rowspan
                });
			}
			
		}	    
	});
}

function initTotalGrid()
{
	$('#totalGrid').datagrid({
	    url:'pxyyzk/total.do',
	    fit:false,
	    height:clientHeight*0.2,
	    queryParams:{
	    	filter:"type=1"
	    },	    
	    columns:[[
	        {field:'deptName',title:'专业培训部',width:80,align:'center'},
	        {field:'solution',title:'方案编制',width:50,align:'center'},
	        {field:'kcb',title:'课表编制',width:50,align:'center'},
	        {field:'wzx',title:'教室安排',width:50,align:'center'},
	        {field:'bzr',title:'班主任安排',width:60,align:'center'},
	        {field:'bd',title:'学员报到',width:50,align:'center'},
	        {field:'qywh',title:'企业文化和主营业务成绩',width:125,align:'center'},
	       /*  {field:'jsbs',title:'技能竞赛笔试成绩',width:100,align:'center'},
	        {field:'jscz',title:'技能竞赛操作成绩',width:100,align:'center'}, */
	        {field:'jx',title:'军训成绩',width:50,align:'center'},
	        {field:'yd',title:'月度成绩',width:50,align:'center'},
	        {field:'jy',title:'结业成绩',width:50,align:'center'},
	        {field:'yxxy',title:'优秀学员',width:50,align:'center'},
	        {field:'yxgb',title:'优秀干部',width:50,align:'center'}
	    ]],
	    //rownumbers:true,
	    singleSelect:false,
	    autoRowHeight:true,
		fitColumns : true	
	});	
}

function zkFormatter(val,row,index){
	return '<img src="static/images/yyzk'+val+'.png" width="20" />';
}
</script>
</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<div>
			<table id="searchTable">
				
				<tr>
					<td>项目名称：</td>
					<td><input id="s_projectId" class="easyui-combobox" data-options="
        valueField: 'id',
        textField: 'name',
        url: 'project/find.do?filter=type=1',
        onLoadSuccess:function(rec){
        $('#s_projectId').combobox('select',rec[0].id);
        doSearch();
        	
        }" style="width: 350px"></td>
					<td>专业培训部：</td>
					<td><input id="s_deptId" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        url: 'zbDict/findByType.do?type=dept',
        onLoadSuccess:function(rec){
        }" ></td>
					<td>专业名称：</td>
					<td><input id="s_majorId" class="easyui-combobox" data-options="
        valueField: 'value',
        textField: 'name',
        url: 'zbDict/findByType.do?type=major',
        onLoadSuccess:function(rec){
        	$('#s_'+this.id).combobox('loadData',rec);
        }"> <a id="search" href="#" class="easyui-linkbutton" iconCls="icon-search">检索</a>
					<a id="s_reset" href="#" class="easyui-linkbutton" iconCls="icon-reset">重置</a></td>
					
				</tr>
			</table>
			
		</div>
		
	</div>
	<table id="mainGrid"></table>
	<table id="totalGrid"></table>
	
	
</body>
</html>
