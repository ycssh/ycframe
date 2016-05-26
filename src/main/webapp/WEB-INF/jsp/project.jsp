<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head><meta http-equiv = "X-UA-Compatible" content = "IE=edge,chrome=1" /> 
<title>后台管理V-1.0</title>



<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="easyui">
<meta http-equiv="description" content="easyui">


<jsp:include page="inc.jsp"></jsp:include>

<style type="text/css">
.spans{float: left;margin-left: 20px;}
.fenban{background-image: url("static/images/library.png");background-repeat: no-repeat;background-position: center;}
.banji{background-image: url("static/images/banji.png");background-repeat: no-repeat;background-position: center;}
.baodao{background-image: url("static/images/baodao.png");background-repeat: no-repeat;background-position: center;}
.baoming{background-image: url("static/images/baoming.png");background-repeat: no-repeat;background-position: center;}
.fangan{background-image: url("static/images/fangan.png");background-repeat: no-repeat;background-position: center;}
.project{background-image: url("static/images/project.png");background-repeat: no-repeat;background-position: center;}
.rws{background-image: url("static/images/rws.png");background-repeat: no-repeat;background-position: center;}
.abutton{width:50px;height: 50px;line-height: 50px;margin:10px 10px;}
.metrotitle{margin: auto;text-align: center;font:italic bolder;font-size: 0.8em;font-weight: bold;}
.metro-success{background-color: #51a351}
.metro-waring{background-color: #ffe48d}
</style>
</head>
<body>
	
			<div id="tb" style="padding:5px;height:auto;background-color: #F4F4F4;">
			    <div>
				            项目名称:       <input id="param_name" class="" style="">
		            <a href="#" class="easyui-linkbutton" onclick="queryProject()">&nbsp;&nbsp;查询&nbsp;&nbsp;</a>
			    </div>
		            
		    </div>
			<table id="dg"  style="" toolbar="#tb">
				<thead>  
				        <tr>  
							<th field="ck" checkbox="true"></th>
				            <th field="id" width="10%">计划编号</th>  
				            <th field="trainName"  width="40%">计划名称</th>  
				            <th field="planYear"  width="20%">年份</th>  
				            <th field="planMonth"  width="20%">月度</th>  
				        </tr>  
		   		 </thead>  
			</table>

	<div style="border-top: solid 1px #95B8E7;">
		<div class="spans">
			<div class="success abutton project metro-success" id="project" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				立项
			</div>
		</div>
		<div class="spans">
			<div class="success abutton fangan metro-success" id="fangan" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				方案编制
			</div>
		</div>
		<div class="spans">
			<div class="success abutton baoming metro-success" id="baoming" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				报名信息维护
			</div>
		</div>
		<div class="spans">
			<div class="success abutton banji metro-success" id="banji" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				系统分班
			</div>
		</div>
		<div class="spans">
			<div class="success abutton rws metro-success" id="rws" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				任务书编制
			</div>
		</div>
		
		
		<div class="spans">
			<div class="success abutton rws metro-success" id="rws" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				课程表
			</div>
		</div>
		<div class="spans">
			<div class="success abutton baodao metro-success" id="baodao" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				学员报到
			</div>
		</div>
		<div class="spans">
			<div class="success abutton rws metro-success" id="rws" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				学号
			</div>
		</div>
		<div class="spans">
			<div class="success abutton rws metro-success" id="rws" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				证书
			</div>
		</div>
		<div class="spans">
			<div class="success abutton rws metro-success" id="rws" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				成绩
			</div>
		</div>
		<div class="spans">
			<div class="success abutton rws metro-success" id="rws" name="班级信息维护" path="<%=basePath %>banji/index.jsp"></div>
			<div class="metrotitle">
				归档
			</div>
		</div>
	</div>
<script type="text/javascript">


	var clientHeight = document.documentElement.clientHeight;
	var pageSize = Math.floor((gridHeight-210)/22)-1;//向下取整
	if(pageSize<1){
		pageSize=1;
	}
$(function(){
	$('#dg').datagrid({  
        url:'<%=basePath %>monthplan/list',
        height:clientHeight-100,
        width:"98%",
        fit:false,
        pageSize:pageSize,
        pageList:[pageSize,10,20,30,40,50,100],
        fit:false,
        onClickRow:function(rowIndex, rowData){
        	<%-- $.post("<%=basePath %>rest/overview/"+rowData.planId,{},function(data){
        		if(data.banji==0){
        			$("#banji").removeClass("metro-success").addClass("metro-waring");
        		}else{
        			$("#banji").removeClass("metro-waring").addClass("metro-success");
        		}
        	},"json"); --%>
        }
    });  
	
	//快速连接
	$("#banji").click(function(){
		var id = $(this).attr("id");
		var name = $(this).attr("name");
		var path = $(this).attr("path");
		var row = $('#dg').datagrid('getSelected');
		if (row){
			top.planId=row.planId
			var projectUrl="";
			if(path.indexOf("?")<0)
				projectUrl = "?planId="+row.planId
			else{
				projectUrl = "&planId="+row.planId
			}	
			path=path+projectUrl;
			var node = new treenode(id,name,path);
			parent.addTab(node,true);
		}else{
			alert("请先选择项目");
		}
	})
});

var treenode = function(id,name,path){
	this.id=id;
	this.name=name;
	this.path=path;
}
function queryProject(){
	var name = $("#param_name").val();
	$('#dg').datagrid({
		queryParams: {
			name:name
		}
	});
}
</script>
</body>
</html>