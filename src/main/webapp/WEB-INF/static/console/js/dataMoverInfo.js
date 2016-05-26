$(function() {

	$("#tbety_opr_add").click(tbetyAddClicked);

	$("#tbety_form_save").click(saveTbetyForm);

	$("#tbety_opr_refresh").click(refreshTbetyGrid);

	$("#tbety_opr_edit").click(tbetyEditClicked);

	$("#tbety_form_reset").click(tbetyFormReset);

	$("#tbety_opr_delete").click(tbetyDeleteClicked);
	
	$("#tbety_opr_run").click(tbetyTaskRun);

	initTbetyComponents();
});

function tbetyTaskRun(){
	var _r = $("#tbety_grid").datagrid("getSelections");

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
	
	$.post("datamovertask/runByIds", {
		ids : ids.join(",")
	}, function(data) {

		// var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		var data = eval(data);
		if (data.success) {
			alert("操作成功！");

			refreshTbetyGrid();
		} else {
			alert(data.msg);
		}

	}, "JSON");
}

function tbetyDeleteClicked() {

	var _r = $("#tbety_grid").datagrid("getSelections");

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

	$.post("datamovertask/delete", {
		ids : ids.join(",")
	}, function(data) {

		// var data = eval('(' + data + ')'); // change the JSON string to
		// javascript object
		var data = eval(data);
		if (data.success) {
			alert("删除成功！");

			refreshTbetyGrid();
		} else {
			alert(data.msg);
		}

	}, "JSON");
}

function tbetyFormReset() {

	$("#tbety_form").form("reset");
}

function tbetyEditClicked() {

	var _r = $("#tbety_grid").datagrid("getSelected");

	if (_r == null) {
		alert("请选择一条待修改的记录!");
		return false;
	}

	initTbetyWin("修改迁移任务");
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

function refreshTbetyGrid() {

	var isDap = $("input[name='isDap']").val();
	if(isDap=="true"){
		$("#dapmgt_grid").datagrid('reload');
	}else{
		$("#tbety_grid").datagrid('reload');
	}
	
}

function initTbetyComponents() {
	initTbetyForm();

	initTbetyGrid();

	initTbetyEvent();

	// initTbetyWin();
}

function initTbetyEvent() {

	/*
	 * $("input[name='beanName']").change(function(){
	 * if($.trim($(this).val())==""){ $("#tbrwxxFieldset").hide(); }else{
	 * $("#tbrwxxFieldset").show(); } });
	 */

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

	$("#tbety_grid").datagrid({
		onCheck : tbetyGridCheckChange,
		onUncheck : tbetyGridCheckChange
	});
}

function tbetyGridCheckChange(rowIndex, rowData) {

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

function initTbetyWin(t) {

	$("#tbety_win").window({
		title : t || "新增迁移任务",
		width : 600,
		height : 500,
		modal : true
	});
}

function initTbetyForm() {
	$('#tbety_form').form({
		url : "datamovertask/save",
		onSubmit : function(param) {
			var isValid = $(this).form('validate');
			if (!isValid) {
				$.messager.progress('close'); // hide progress bar while the
												// form is invalid
			}
			return isValid; // return false will stop the form submission
		},
		success : function(data) {
			// alert(data)

			var data = eval('(' + data + ')'); // change the JSON string to
												// javascript object
			if (data.success) {
				alert("保存成功！");

				$("#tbety_win").window('close');
				refreshTbetyGrid();
			} else {
				alert(data.msg);
			}
		}
	});
}

function initTbetyGrid() {

	$('#tbety_grid').datagrid({
		url : 'datamovertask/findAll',
		toolbar : "#tbety_toolbar",
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

function tbetyAddClicked() {

	initTbetyWin();
	$("#tbety_win").show();

	$("#tbety_form").form("reset");
	
	$("#tbrwxxFieldset").hide();
	$("#stChooseTime").hide();
	
	$("input[name='isDap']").val(false);
}

function saveTbetyForm() {

	// submit the form
	$('#tbety_form').submit();
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
