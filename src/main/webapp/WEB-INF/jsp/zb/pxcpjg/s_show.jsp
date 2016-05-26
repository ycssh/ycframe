<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String beginTime = request.getAttribute("beginTime") == null
			? ""
			: request.getAttribute("beginTime").toString();
	String endTime = request.getAttribute("endTime") == null
			? ""
			: request.getAttribute("endTime").toString();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<base href="<%=basePath%>">

<title>短训班/团青培训测评结果监测</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style type="text/css">
table td {
	font-size: 12px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>static/easyui/themes/icon.css">
<script type="text/javascript"
	src="<%=basePath%>static/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>static/easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>static/js/common.js"></script>

<script type="text/javascript">
var clientHeight = document.documentElement.clientHeight;
var columnList = [
	        {field:'deptName',title:'专业培训部',width:40},
	        {field:'projectName',title:'项目',width:80},
	        {field:'className',title:'班级',width:80},
	        {field:'cpsj',title:'测评时间',width:30,formatter:function(v){
	        	var d = new Date(v);
	        	var y = d.getFullYear();
	        	var m = d.getMonth()+1;
	        	var dt = d.getDate();
	        	
	        	if(m<10){
	        		m = '0'+m;
	        	}
	        	if(dt<10){
	        		dt = '0'+dt;
	        	}
	        	return y+''+m+''+dt;
	        }},
	        {field:'pxzlpj',title:'培训质量评价',width:60,formatter:percentFormatter},
	        {field:'jxfw',title:'教学服务评价',width:60,formatter:percentFormatter},
	        {field:'zhfwpj',title:'后勤服务评价',width:60,formatter:percentFormatter},
	        {field:'ztpj',title:'总体评价',width:60,formatter:percentFormatter}
	    ];
var endTime = "<%=endTime%>";
var beginTime = "<%=beginTime%>";
	$(function() {
		$("#beginTime").datebox("setValue", beginTime);
		$("#endTime").datebox("setValue", endTime);
		initGrid();
		$("#search").bind("click",search1);
		$("#export").bind("click",export1);
	});

	function initGrid() {

		$('#mainGrid').datagrid(
				{
					url : 'pxcpjg/findAll.do?rows=1000',
					toolbar : "#toolbar",
					queryParams : {
						filter : "type=2&beginTime=" + beginTime + "&endTime="
								+ endTime
					},
					columns : [ columnList ],
					singleSelect : false,
					autoRowHeight : true,
					height:clientHeight-20,
					fitColumns : true,
					rowStyler : function(index, row) {
						//alert(index);
					},
					onLoadSuccess : function(data) {
						var rows = data.rows;
						var majorMergeList = new Array();

						var bo = null;
						var mIsFirst = true, dIsFirst = true;
						var mIndex = null, dIndex = null;
						var mNum = 1, dNum = 1;
						for ( var i = 0; i < rows.length; i++) {
							var o = rows[i];
							if (bo == null) {
								bo = o;
								continue;
							}

							if (o.projectId == bo.projectId) {
								if (mIsFirst) {
									mIndex = i > 0 ? (i - 1) : 0;
									mIsFirst = false;
								}
								mNum++;
							} else {
								if (!mIsFirst) {
									majorMergeList.push({
										index : mIndex,
										rowspan : mNum,
										field : 'majorName'
									});
								}
								mIsFirst = true;
								mNum = 1;
							}

							if (o.deptId == bo.deptId) {
								if (dIsFirst) {
									dIndex = i > 0 ? (i - 1) : 0;
									dIsFirst = false;
								}
								dNum++;
							} else {
								if (!dIsFirst) {
									majorMergeList.push({
										index : dIndex,
										rowspan : dNum,
										field : 'deptName'
									});
								}
								dIsFirst = true;
								dNum = 1;
							}
							bo = o;

							if (i == rows.length - 1) {
								if (mNum > 1) {
									majorMergeList.push({
										index : mIndex,
										rowspan : mNum,
										field : 'projectName'
									});
								}
								if (dNum > 1) {
									majorMergeList.push({
										index : dIndex,
										rowspan : dNum,
										field : 'deptName'
									});
								}
							}

						}

						for ( var i = 0; i < majorMergeList.length; i++) {
							$(this).datagrid('mergeCells', {
								index : majorMergeList[i].index,
								field : majorMergeList[i].field,
								rowspan : majorMergeList[i].rowspan
							});
						}

					}
				});
	}

	function percentFormatter(v) {

		if (!v || v == '' || v == 'null') {
			return v;
		}
		return v + '%';
	}

	function filterWarning(rec) {
		rec = rec.id;

		$('#mainGrid')
				.datagrid(
						{
							loadFilter : function(data) {
								var rows = data.rows;
								if (rec == '') {
									return data;
								}

								for ( var i = 0; i < rows.length; i++) {
									for ( var j = 0; j < columnList.length; j++) {
										var fv = rows[i][columnList[j].field];
										if (isNaN(fv)
												|| parseFloat(fv) > 100
												|| columnList[j].field == 'ztpj') {
											continue;
										}

										var nv = parseFloat(fv);
										if (rec == 't') {
											if (nv >= 95
													&& columnList[j].field == 'pxzlpj') {
												rows[i][columnList[j].field] = '';
											} else if (nv >= 90
													&& (columnList[j].field == 'jxfw' || columnList[j].field == 'zhfwpj')) {
												rows[i][columnList[j].field] = '';
											}
										} else if (rec == 'f') {
											if (nv < 95
													&& columnList[j].field == 'pxzlpj') {
												rows[i][columnList[j].field] = '';
											} else if (nv < 90
													&& (columnList[j].field == 'jxfw' || columnList[j].field == 'zhfwpj')) {
												rows[i][columnList[j].field] = '';
											}
										}
									}
								}

								return data;
							}
						});
	}
	function export1() {
		var projectId = $('#s_projectId').combobox('getValue');
		var beginTime = $('#beginTime').datebox('getValue');
		var endTime = $('#endTime').datebox('getValue');
		var tag = $('#tag').combobox('getValue');
		var commark = $('#commark').combobox('getValue');
		if (beginTime == '' || endTime == '') {
			if (projectId == '') {
				$.messager.alert("警告信息", "请选择开始时间和结束时间", "warning");
				return;
			}
		}
		window.open("pxcpjg/s_export/projectId=" + projectId + "&beginTime="
				+ beginTime + "&endTime=" + endTime + "&tag=" + tag
				+ "&commark=" + commark);

		$('#tag').combobox('setValue', '');
		$('#commark').combobox('setValue', '');
	}

	function search1() {
		var projectId = $('#s_projectId').combobox('getValue');
		var beginTime = $('#beginTime').datebox('getValue');
		var endTime = $('#endTime').datebox('getValue');
		var tag = $('#tag').combobox('getValue');
		var commark = $('#commark').combobox('getValue');

		if(beginTime!=""&&endTime!=""){
			var arr1 = beginTime.split("-");
			var starttimes = new Date(arr1[0], arr1[1], arr1[2]);
			var arr2 = endTime.split("-");
			var endtimes = new Date(arr2[0], arr2[1], arr2[2]);
			 if (starttimes > endtimes) {
				 alert("开始时间不能大于结束时间")
		         return false;
		     }
		}
		$('#mainGrid').datagrid(
				'load',
				{
					filter : "type=2&projectId=" + projectId + "&beginTime="
							+ beginTime + "&endTime=" + endTime + "&tag=" + tag
							+ "&commark=" + commark
				});
		var gid = $('#s_gj').combobox('getValue');
		filterWarning(gid);
	}
</script>

</head>

<body>

	<!-- Grid -->
	<div id="toolbar">
		<!-- <div>
			<div id="add" class="easyui-linkbutton"
			data-options="iconCls:'icon-add',plain:true">导出</div>
		</div> -->
		<div>
			<table id="searchTable">
				<tr>
					<td>项目名称：</td>
					<td><input id="s_projectId" name="s_projectId"
						style="width: 350px" class="easyui-combobox"
						data-options="
        valueField: 'id',
        textField: 'name',
        url: 'project/find.do?filter=type=2',
        onSelect: function(rec){
        	$('#mainGrid').datagrid('load',{
				filter:'type=2&projectId='+rec.id
			});
        },
        onLoadSuccess:function(rec){
        	//rec.push({id:'',name:'全部'});
        	
        	$(this).combobox('setValue','');
        }"></td>
					<td>告警：</td>
					<td><input id="s_gj" class="easyui-combobox"
						data-options="editable:false,valueField: 'id',textField: 'name',data:[{id:'',name:'全部'},{id:'t',name:'是'},{id:'f',name:'否'}],
					onSelect: function(rec){
        				filterWarning(rec);
        			}">
					</td>
					<td>计划来源:</td>
					<td><input id="tag" name="tag"
						style="width: 100px; height: auto" class="easyui-combobox"
						data-options="
				        valueField: 'value',
				        textField: 'name',
				        url: 'zbDict/findByType.do?type=plantype',
				        onSelect: function(rec){
                            if(rec.value =='C001'){
                            	var url='zbDict/findByType.do?type=comtag';
                            	$('#commark').combobox({
                            	url:url,
				        		valueField: 'value',
				        		textField: 'name'                            	
                            	}).combobox('clear');
                            }else
                            {
                                var url='zbDict/findByType.do?type=commark';
                            	$('#commark').combobox({
                            	url:url,
				       			valueField: 'value',
				        		textField: 'name'                            	
                            	}).combobox('clear');
                            }
				        
				        }"></td>
					<td>公司标志:</td>
					<td><input id="commark" name="commark"
						style="width: 100px; height: auto" class="easyui-combobox"
						data-options="
				        valueField: 'value',
				        textField: 'name',
				        url: 'zbDict/findByType.do?type=commark',
				        onLoadSuccess:function(rec){
        				$(this).combobox('setValue','');
     	   }"></td>
				</tr>
				<tr>
					<td>开始时间:</td>
					<td><input id="beginTime" class="easyui-datebox" data-options="editable:false"></input></td>
					<td>结束时间:</td>
					<td><input id="endTime" class="easyui-datebox" data-options="editable:false"></input></td>
					<td>&nbsp;&nbsp; <a id="search" class="easyui-linkbutton"
										iconCls="icon-search" >检索</a> 
					</td>
					<td>&nbsp;&nbsp; 
					<a id="export" href="#" class="easyui-linkbutton" iconCls="icon-reset">导出</a>
					</td>
				</tr>
			</table>

		</div>

	</div>
	<table id="mainGrid"></table>


</body>
</html>
