$(function() {

	$("#dapmgt_opr_add").click(dapmgtAddClicked);

	$("#dapmgt_form_save").click(savedapmgtForm);

	$("#dapmgt_opr_refresh").click(refreshdapmgtGrid);

	$("#dapmgt_opr_edit").click(dapmgtEditClicked);

	$("#dapmgt_form_reset").click(dapmgtFormReset);

	$("#dapmgt_opr_delete").click(dapmgtDeleteClicked);
	
	$("#dapmgt_opr_run").click(dapmgtTaskRun);

	initdapmgtComponents();
});

function dapmgtTaskRun(){
	var _r = $("#dapmgt_grid").datagrid("getSelections");

	if (_r == null || _r.length == 0) {
		alert("请选择待执行的记录!");
		return false;
	}

	if (!confirm("你确认要执行选中的记录吗？")) {
		return;
	}

	var ids = [];

	for ( var i = 0; i < _r.length; i++) {
		
		if(!_r[i].beanName){
			alert("实体【"+_r[i].name+"】未配置迁移器bean，操作终止！");
			return;
		}
		ids.push(_r[i].id);
	}
	
	$.post("datamovertask/runByIds.do", {
		ids : ids.join(",")
	}, function(data) {

		// var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		var data = eval(data);
		if (data.success) {
			alert("操作成功！");

			refreshdapmgtGrid();
		} else {
			alert(data.msg);
		}

	}, "JSON");
}

function dapmgtDeleteClicked() {

	var _r = $("#dapmgt_grid").datagrid("getSelections");

	if (_r == null || _r.length == 0) {
		alert("请选择待删除的记录!");
		return false;
	}

	if (!confirm("你确认要删除该条记录吗？")) {
		return;
	}

	var ids = [];

	for ( var i = 0; i < _r.length; i++) {
		ids.push(_r[i].id);
	}

	$.post("datamovertask/delete.do", {
		ids : ids.join(",")
	}, function(data) {

		// var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		var data = eval(data);
		if (data.success) {
			alert("删除成功！");

			refreshdapmgtGrid();
		} else {
			alert(data.msg);
		}

	}, "JSON");
}

function dapmgtFormReset() {

	$("#dapmgt_form").form("reset");
}

function dapmgtEditClicked() {

	var _r = $("#dapmgt_grid").datagrid("getSelected");

	if (_r == null) {
		alert("请选择一条待修改的记录!");
		return false;
	}

	initdapmgtWin("修改迁移任务");
	$("#tbety_win").show();

	$("#tbety_form").form("reset");

	$("#tbety_form").form("load", _r);

	if(_r.type==1){
		$("#tbrwxxFieldset").hide();
	}else if(_r.type==2){
		$("#tbrwxxFieldset").show();
	}
	
	if(_r.startTime==null){
		$("#stStartTimeField").combobox('setValue',1);
		$("#stChooseTime").hide();
	}else{
		$("#stStartTimeField").combobox('setValue',2);
		$("#stChooseTime").show();
		
		var d = new Date(_r.startTime);
		d = dateFormat(d);
		$("#chooseTimeValue").datetimebox({value:d});
	}
}

function refreshdapmgtGrid() {

	$("#dapmgt_grid").datagrid('reload');
}

function initdapmgtComponents() {
	initdapmgtGrid();

	initdapmgtEvent();

	// initdapmgtWin();
}

function initdapmgtEvent() {

	$("#sxtTypeField").combobox({
		onSelect : function(record) {

			if (record.value == 1) {
				$("#tbrwxxFieldset").hide();
			} else if (record.value == 2) {
				$("#tbrwxxFieldset").show();
			}
		}
	});

	$("#stStartTimeField").combobox({
		onSelect : function(record) {

			if (record.value == 1) {
				$("#stChooseTime").hide();
			} else if (record.value == 2) {
				$("#stChooseTime").show();
			}
		}
	});

	$("#dapmgt_grid").datagrid({
		onCheck : dapmgtGridCheckChange,
		onUncheck : dapmgtGridCheckChange
	});
}

function dapmgtGridCheckChange(rowIndex, rowData) {

	// alert($(this).datagrid("getChecked").length);

	var _records = $(this).datagrid("getChecked");

	var _ids = [];

	for ( var i = 0; i < _records.length; i++) {
		_ids.push(_records[i].name);
	}

	$('#tasklog_grid').datagrid({
		queryParams : {
			filter : 'taskIds=' + _ids.join(",")
		}
	});
}

function initdapmgtWin(t) {

	$("#tbety_win").window({
		title : t || "新增迁移任务",
		width : 600,
		height : 500,
		modal : true
	}).show();
}

/*function initdapmgtForm() {
	$('#tbety_form').form({
		url : "datamovertask/save.do",
		onSubmit : function(param) {
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); // hide progress bar while the
												// form is invalid
			}
			param.isDap = true;
			return isValid; // return false will stop the form submission
		},
		success : function(data) {
			// alert(data)

			var data = eval('(' + data + ')'); // change the JSON string to
												// javascript object
			if (data.success) {
				alert("保存成功！");

				$("#dapmgt_win").window('close');
				refreshdapmgtGrid();
			} else {
				alert(data.msg);
			}
		}
	});
}*/

function initdapmgtGrid() {

	$('#dapmgt_grid').datagrid({
		url : 'datamovertask/findAll.do',
		queryParams:{
			"filter":"isDap=true"
		},
		toolbar : "#dapmgt_toolbar",
		columns : [ [ {
			field : 'id',
			title : 'ID',
			width : 100,
			checkbox : true
		}, {
			field : 'name',
			title : '表名',
			width : 120
		}, {
			field : 'descr',
			title : '描述',
			width : 120
		}, {
			field : 'beanName',
			title : '迁移器',
			width : 120
		}, {
			field : 'isWork',
			title : '是否生效',
			width : 80,
			hidden:true
		}, {
			field : 'hasDone',
			title : '是否已执行',
			width : 80,
			hidden:true
		}, {
			field : 'type',
			title : '任务类型',
			width : 80,
			formatter : function(value) {

				if (value) {
					if (value == 1) {
						return "全部任务";
					} else if (value == 2) {
						return "增量任务";
					}
				}

				return value;
			}
		}, {
			field : 'startTime',
			title : '开始同步时间',
			width : 150,
			formatter : dateFormater
		}, {
			field : 'period',
			title : '同步间隔（毫秒）',
			width : 100
		}, {
			field : 'crTime',
			title : '更新时间',
			width : 150,
			align : 'right',
			formatter : dateFormater
		} ] ],
		rownumbers : true,
		fitColumns : true,
		singleSelect : false
	});
}

function dateFormater(value, row, index) {
	if (value) {
		var d = new Date(value);

		return dateFormat(d);
	} else {
		return "立即执行";
	}
}

function dapmgtAddClicked() {

	initdapmgtWin();
	$("#dapmgt_win").show();

	$("#tbety_form").form("reset");
	
	$("#tbrwxxFieldset").hide();
	$("#stChooseTime").hide();
	
	$("input[name='isDap']").val(true);
}

function savedapmgtForm() {

	// submit the form
	$('#dapmgt_form').submit();
}

function dateFormat(d) {
	var y = d.getFullYear();
	var m = d.getMonth() + 1;
	var dt = d.getDate();
	var h = d.getHours();
	var mi = d.getMinutes();
	var s = d.getSeconds();

	return y + "-" + numFormat(m) + "-" + numFormat(dt) + " " + numFormat(h)
			+ ":" + numFormat(mi) + ":" + numFormat(s);
}

function numFormat(n) {
	if (n < 10) {
		return "0" + n;
	}

	return n;
}
