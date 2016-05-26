$(function(){
	
	$("#topMenu-defaultValueMgt").bind("click",defaultValueMgt);
});

function defaultValueMgt(){
	
	addMainTab('阙值管理','defaultValueMgt/index.jsp');
}

function addMainTab(title,url){
	
	//判断tab中是否已经存在
	if(!$("#mainTab").tabs('exists',title)){
		$("#mainTab").tabs("add",{
			title:title,
			closable:true,
			content:'<iframe src="'+url+'" width="100%" height="100%" frameborder="0" scrolling="auto" ></iframe>',
			height:600
		});
	}
	$("#mainTab").tabs('select',title);
	
}