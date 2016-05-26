
$(function(){
	var date=getNowFormatDate();
	$("#wantTime").val(date);
	searchAll();
  //页面总检索
   $("#searchAll").unbind('click').bind("click",searchAll);
  //新员工检索
   $("#nsearch").unbind('click').bind("click",searchNewBanji);
  //短训班检索
   $("#ssearch").unbind('click').bind("click",searchShortBanji);
  //导出
  $("#export").unbind('click').bind("click",exportSched);
  //点击班级
  //$("className").unbind('click').bind("click",classOnclick);
  clickNewFunction();
  clickShtFunction();
  


  
});
 
 function searchNewBanji(){
	 var date = $("#wantTime").val();
	 var banji = $("#nbanji").val();
	 if(date==null||date==""){
		 alert("请选择日期");
	 }
	 //与后台交互
	 $.post('jxssjc/querynew?date='+date+'&banji='+banji)
		.done(function (data){
			
			//今日办班新员工
			var newClassList = data["newClassList"];
			//今日课程表新员工
			var newSchedList = data["newSchedList"];
			
			fillnew(newClassList,newSchedList);
			
	
		}).fail(function () {alert('获取数据失败');});
	 
 }
 
 function searchNewBanjiSch(className){
	 var banji = className;
	 var date = $("#wantTime").val();
	 if(date==null||date==""){
		 alert("请选择日期");
	 }
	 //与后台交互
	 $.post('jxssjc/querynew?date='+date+'&banji='+banji)
		.done(function (data){
			
			//今日办班新员工
			//var newClassList = data["newClassList"];
			//今日课程表新员工
			var newSchedList = data["newSchedList"];
			
			fillnewSch(newSchedList);
			
	
		}).fail(function () {alert('获取数据失败');});
	 
 }
 
 function searchShortBanji(){
	 var date = $("#wantTime").val();
	 var banji = $("#sbanji").val();
	 if(date==null||date==""){
		 alert("请选择日期");
	 }
	 //与后台交互
	 $.post('jxssjc/queryshortForS?date='+date+'&banji='+banji)
		.done(function (data){
			
			//今日办班短训班
			var shortClassList = data["shortClassList"];
			//今日课程表短训班
			var shortSchedList = data["shortSchedList"];
			
			fillshort(shortClassList,shortSchedList);
			
	
		}).fail(function () {alert('获取数据失败');});
	 
 }
 
 function searchShortBanjiSch(projectId){//20151105修改成根据projectId去检索
	 var projectId = projectId;
	 var date = $("#wantTime").val();
	 if(date==null||date==""){
		 alert("请选择日期");
	 }
	 //与后台交互
	 $.post('jxssjc/queryshort?date='+date+'&banji='+projectId)
		.done(function (data){
			
			
			//今日课程表短训班
			var shortSchedList = data["shortSchedList"];
			
			fillshortSch(shortSchedList);
			
	
		}).fail(function () {alert('获取数据失败');});
	 
 }
 
 function searchAll(){
	 var date = $("#wantTime").val();
	 if(date==null||date==""){
		 alert("请选择日期");
	 }
	//与后台交互
		$.post('jxssjc/queryall?date='+date)
			.done(function (data){
				
				//统计数据的渲染
				var newCount = data["newCount"];
				var newCountClass=newCount["newCount"]["countNewClass"];
				var newCountPerson=newCount["newCount"]["countNewPerson"];
				var shortCount = data["shortCount"];
				var shrtCountClass=shortCount["shortCount"]["countShortClass"];
				var shrtCountPerson=shortCount["shortCount"]["countShortPerson"];
				//给页面回填相应统计数据
				$("#cnclass").html(newCountClass);
				$("#cnperson").html(newCountPerson);
				$("#csclass").html(shrtCountClass);
				$("#csperson").html(shrtCountPerson);
				
				//今日办班新员工
				var newClassList = data["newClassList"];
			
				//今日办班短训班
				var shortClassList = data["shortClassList"];
				//今日课程表新员工
				var newSchedList = data["newSchedList"];
				//今日课程表短训班
				var shortSchedList = data["shortSchedList"];
				fillnew(newClassList,newSchedList);
				fillshort(shortClassList,shortSchedList);
		
			}).fail(function () {alert('获取数据失败');});
 }
 
 //新员工信息回填
 function fillnew(newClassList,newSchedList){
	 //今日办班回填
	 var htmlStrnc="";
	 var htmlStrns="";
	 for(var i=0;i<newClassList.length;i++){
		 var projectName = newClassList[i]["projectName"];
		 var pxdd = newClassList[i]["pxdd"];
		 var className = newClassList[i]["className"];
		 var pernum = newClassList[i]["pernum"];
		 htmlStrnc =htmlStrnc+"<tr><td><a style='text-decoration:none;' title='"+projectName+"'>"+projectName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+pxdd+"'>"+pxdd+"</a></td>"+
 		"<td><a class='newcl' href='javascript:;' style='text-decoration:underline;' title='"+className+"'>"+className+"</a></td>"+
 		"<td>"+pernum+"</td></tr>";
 		
	 }
	 //今日课表回填
	 for(var i=0;i<newSchedList.length;i++){
		 var courserName = newSchedList[i]["courserName"];
		 var period = newSchedList[i]["period"];
		 var groupName = newSchedList[i]["groupName"];
		 var teacherName = newSchedList[i]["teacherName"];
		 var place = newSchedList[i]["place"];
		 var trinType = newSchedList[i]["trinType"];
		 if(groupName==null){
			 groupName=" ";
		 }
		 htmlStrns = htmlStrns+"<tr><td><a style='text-decoration:none;'  title='"+courserName+"'>"+courserName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+period+"''>"+period+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+groupName+"'>"+groupName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+teacherName+"'>"+teacherName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+place+"'>"+place+"</a></td>"+
         "<td>"+trinType+"</td></tr>";
		
	 }
		
	    $("#tbody_nclass").html(htmlStrnc);
		$("#tbody_nsched").html(htmlStrns);
		clickNewFunction();
	   
 }
 
 //新员工课表信息回填
 function fillnewSch(newSchedList){
	 var htmlStrns="";
	 
	 //今日课表回填
	 for(var i=0;i<newSchedList.length;i++){
		 var courserName = newSchedList[i]["courserName"];
		 var period = newSchedList[i]["period"];
		 var groupName = newSchedList[i]["groupName"];
		 var teacherName = newSchedList[i]["teacherName"];
		 var place = newSchedList[i]["place"];
		 var trinType = newSchedList[i]["trinType"];
		 if(groupName==null){
			 groupName=" ";
		 }
		 htmlStrns = htmlStrns+"<tr><td><a style='text-decoration:none;'  title='"+courserName+"'>"+courserName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+period+"''>"+period+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+groupName+"'>"+groupName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+teacherName+"'>"+teacherName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+place+"'>"+place+"</a></td>"+
         "<td>"+trinType+"</td></tr>";
		
	 }
		
		$("#tbody_nsched").html(htmlStrns);
 }
 
 var clickNewFunction = function(){

	  $('#tbody_nclass').each(function(){
		  $('.newcl').unbind('click').click(function(){
			 // alert($(this).html());
			  searchNewBanjiSch($(this).html());
		  });
	  });
 };
 
 
//短训班信息回填
 function fillshort(shortClassList,shortSchedList){
	 //今日办班回填
	 var htmlStrnss="";
	 var htmlStrnsc="";
	 for(var i=0;i<shortClassList.length;i++){
		 var projectName = shortClassList[i]["projectName"];
		 var projectId= shortClassList[i]["projectId"];
		 var pxdd = shortClassList[i]["pxdd"];
		 //var className = shortClassList[i]["className"];
		 var dept = shortClassList[i]["dept"];
		 var pernum = shortClassList[i]["pernum"];
		 htmlStrnsc = htmlStrnsc+" <tr><td><a class='shtcl' href='javascript:;' style='text-decoration:underline;' id='"+projectId+"'  title='"+projectName+"'>"+projectName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+pxdd+"'>"+pxdd+"</a></td>";
         //"<td><a style='text-decoration:none;'  title='"+dept+"'>"+dept+"</a></td>";
         htmlStrnsc+="<td><a style='text-decoration:none;'  title='"+dept+"'>"+dept+"</a></td>";
         htmlStrnsc+="<td>"+pernum+"</td></tr>";
	 }
	
	 //今日课表回填
	 for(var i=0;i<shortSchedList.length;i++){
		 var courserName = shortSchedList[i]["courserName"];
		 var period = shortSchedList[i]["period"];
		 var groupName = shortSchedList[i]["groupName"];
		 var teacherName = shortSchedList[i]["teacherName"];
		 var place = shortSchedList[i]["place"];
		 var trinType = shortSchedList[i]["trinType"];
		 if(groupName==null){
			 groupName=" ";
		 }
		 htmlStrnss = htmlStrnss+"<tr><td><a style='text-decoration:none;'  title='"+courserName+"'>"+courserName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+period+"'>"+period+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+groupName+"'>"+groupName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+teacherName+"'>"+teacherName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+place+"'>"+place+"</a></td>"+
         "<td>"+trinType+"</td></tr>";
	 }
	   $("#tbody_sclass").html(htmlStrnsc);
	   $("#tbody_ssched").html(htmlStrnss);
	   clickShtFunction();
 }
 
//短训班kebiao信息回填
 function fillshortSch(shortSchedList){
	
	 var htmlStrnss="";
	
	
	 //今日课表回填
	 for(var i=0;i<shortSchedList.length;i++){
		 var courserName = shortSchedList[i]["courserName"];
		 var period = shortSchedList[i]["period"];
		 var groupName = shortSchedList[i]["groupName"];
		 var teacherName = shortSchedList[i]["teacherName"];
		 var place = shortSchedList[i]["place"];
		 var trinType = shortSchedList[i]["trinType"];
		 if(groupName==null){
			 groupName=" ";
		 }
		 htmlStrnss = htmlStrnss+"<tr><td><a style='text-decoration:none;'  title='"+courserName+"'>"+courserName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+period+"'>"+period+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+groupName+"'>"+groupName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+teacherName+"'>"+teacherName+"</a></td>"+
         "<td><a style='text-decoration:none;'  title='"+place+"'>"+place+"</a></td>"+
         "<td>"+trinType+"</td></tr>";
	 }
	
	   $("#tbody_ssched").html(htmlStrnss);
	 
 }
 
 var clickShtFunction = function(){

	  $('#tbody_sclass').each(function(){
		  $('.shtcl').unbind('click').click(function(){
			  //alert($(this).attr("id"));
			  searchShortBanjiSch($(this).attr("id"));
		  });
	  });
};

function getNowFormatDate() {
	var date = new Date();
	var seperator1 = "-";
	var month = date.getMonth() + 1;
	var strDate = date.getDate();
	if (month >= 1 && month <= 9) {
	month = "0" + month;
	}
	if (strDate >= 0 && strDate <= 9) {
	strDate = "0" + strDate;
	}
	var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
	return currentdate;
	}
