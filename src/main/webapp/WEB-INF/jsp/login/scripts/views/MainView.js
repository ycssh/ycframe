$ns("login.views");
$include("~/login/resources/skins/style.css");

login.views.MainView = function()
{
    var me = $extend(mx.views.View);
    var base = {};
    
    me.menuTree = null;
   
    var htmlContainer = null;
    var htmlContainerLogin = null;
    var homeView = null;
    var _detailWin = null;
    var bodyWidth = null;
    var bodyHeight = null;
    me.getHomeView = function(){
    	return homeView;
    }
    
    base.init = me.init;
    me.init = function()
    {
        base.init();
        me.$e.addClass("divlogpage");
        _initControls();
    };

    function _initControls()
    {
  	    _check();
        me.on("activate", me.controller._onactivate);
    }
   
    function _check(){
    	if (!login.utils.Portal.isLogin())
        {
    		_initLoginWindow();
        }
        else
        {
        	window.open(getRootPathByIp()+"/yxjk/yj/index.jsp?id="+login.utils.Portal.currentUser.id+"&name="+login.utils.Portal.currentUser.name+"&appID="+login.utils.Portal.appID,"_self");
        }
    }
    var ButtContainer0 = null;
    var ButtContainer1 = null;
    var ButtContainer10 = null;
    var ButtContainer100 = null;
    var ButtContainer11 = null;
    var ButtContainer2 = null;
    var ButtContainer3 = null;
    var ButtContainer4 = null;
    var TextEditorUsername=null;
    var TextEditorPassword = null;
    var TextButton = null;
    /**
     * 初始化登录界面
     */
    function _initLoginWindow(){
    	bodyWidth = window.screen.availWidth;
    	bodyHeight = window.screen.availHeight;
    	/*if(htmlContainer == null){
    		htmlContainer=new mx.containers.HtmlContainer({
        		url:"~/login/resources/skins/login.html",
        		type:"ajax",
        		//position:"absolute"
        		onload:me.controller._initHtmlEvent
        	});
    	}*/
    	htmlContainer = new mx.containers.HSplit({
			rows : "auto,0",
			id : "htmlContainer",
			borderThick : 0,
			width:bodyWidth+"px",
			height:bodyHeight+"px"
		});
    	htmlContainerLogin = new mx.containers.Container({
    		id : "htmlContainerLogin",
			borderThick : 0,
			width:bodyWidth+"px",
			height:bodyHeight+"px"
		});
    	ButtContainer0 = new mx.containers.Container({
			id : "headerlogin",
			borderThick : 0,
			height:"89px",
			width:bodyWidth+"px"
		});
    	ButtContainer1 = new mx.containers.Container({
			id : "mainlogin",
			borderThick : 0,
			width:bodyWidth+"px",
			height:bodyHeight+"px"
		});
    	ButtContainer10 = new mx.containers.Container({
			id : "login_formlogin",
			borderThick : 0,
			height:"327px",
			width:"521px"
		});
    	ButtContainer100 = new mx.containers.Container({
			id : "posterlogin",
			borderThick : 0,
			height:"98px",
			width:"260px"
		});
    	ButtContainer11 = new mx.containers.Container({
			id : "form_listlogin",
			borderThick : 0,
			width:"179px",
			height:"132px"
		});
    	var welcomeLabels1 = new mx.controls.Label({
			id : "logologin",
			text : "",
			alias : "",
			textAlign : "left",
			verticalAlign : "middle",
			width : "326px",
			height : "76px",
			css:{"background":"url(resources/skins/images/logo_login.gif) center top no-repeat","margin-left":"18px"}
		});
    	var welcomeLabels2 = new mx.controls.Label({
			id : "sgtclogin",
			text : "",
			alias : "",
			textAlign : "left",
			verticalAlign : "middle",
			width : "110px",
			height : "76px"
			//css:{"background":"url(resources/skins/images/155_login.gif) center top no-repeat","margin-left":"18px"}
		});
    	var imgpti = "<embed src=\"resources/skins/images/kh.swf\" width=\"260\" height=\"98\" quality=\"high\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" type=\"application/x-shockwave-flash\" wmode=\"transparent\"></embed>";
    	TextEditorUsername = mx.editors.TextEditor({
    		id:"userNameText",
    		text:"",
    		alias : "",
			textAlign : "left",
			verticalAlign : "middle",
			width : "150px",
			height : "29px"
    	});
    	TextEditorPassword = mx.editors.TextEditor({
    		id:"passwordText",
    		text:"",
    		alias : "",
			textAlign : "left",
			verticalAlign : "middle",
			width : "150px",
			height : "29px",
			textMode :"password"
    	});
    	TextButton = new mx.controls.Label({
    		id:"buttonlogin",
			width : "86px",
			height : "29px"
    	});
    	var TextLabel1 = new mx.controls.Label({
    		id:"TextLabel1",
    		text:" 国网技术学院 国家电网公司团校 山东电力高等专科学校 版权所有 Copyright 2013",
    		textAlign : "center",
    		width:bodyWidth+"px",
			height : "29px",
			css:{"font-size":"12px","color":"#D4E7E5","top":"90px"}
    	});
    	var TextLabel2 = new mx.controls.Label({
    		id:"TextLabel2",
    		text:" 技术支持：国网信通产业集团安徽继远软件有限公司",
    		textAlign : "center",
    		width:bodyWidth+"px",
			height : "29px",
			css:{"font-size":"12px","color":"#D4E7E5","top":"85px"}
    	});
    	var TextLabel3 = new mx.controls.Label({
    		id:"TextLabel3",
    		text:" 帮助热线：0531-82999074，0531-82995071",
    		textAlign : "center",
    		width:bodyWidth+"px",
			height : "29px",
			css:{"font-size":"12px","color":"#D4E7E5","top":"80px"}
    	});
    	//按钮登录
    	TextButton.on("click", function()
    			{
    					me.controller._initHtmlEvent(TextEditorUsername.value,TextEditorPassword.value);
    			});
    	///回车登录
    	document.onkeydown=function(e){
    		var keycode=document.all?event.keyCode:e.which;
    		if(keycode==13){
    			setTimeout(function(){me.controller._initHtmlEvent(TextEditorUsername.value,TextEditorPassword.value)},1000);
    			//me.controller._initHtmlEvent(TextEditorUsername.value,TextEditorPassword.value)
    		};
    	}
    	ButtContainer11.addControl(TextEditorUsername);
    	ButtContainer11.addControl(TextEditorPassword);
    	ButtContainer11.addControl(TextButton);
    	ButtContainer100.$e.append(imgpti);
    	ButtContainer10.addControl(ButtContainer100);
    	ButtContainer10.addControl(ButtContainer11);
    	ButtContainer0.addControl(welcomeLabels1);
    	ButtContainer0.addControl(welcomeLabels2);
    	ButtContainer1.addControl(ButtContainer10);
    	htmlContainerLogin.addControl(ButtContainer0);
    	htmlContainerLogin.addControl(ButtContainer1);
    	ButtContainer1.addControl(TextLabel1);
    	ButtContainer1.addControl(TextLabel2);
    	ButtContainer1.addControl(TextLabel3);
    	htmlContainer.addControl(htmlContainerLogin);
    	me.addControl(htmlContainer);
    }
    function getRootPathByIp() {
	    //获取当前网址，如： http://localhost:8080/ems/Pages/Basic/Person.jsp
	    var curWwwPath = window.document.location.href;
	    //获取主机地址之后的目录，如： /ems/Pages/Basic/Person.jsp
	    var pathName = window.document.location.pathname;
	    var pos = curWwwPath.indexOf(pathName);
	    //获取主机地址，如： http://localhost:8080
	    var localhostPath = curWwwPath.substring(0, pos);
	    //获取带"/"的项目名，如：/ems
	    //var projectName = localhostPath.substring(0, localhostPath.indexOf('PXGL'));
	    var projectName = localhostPath;
	    return projectName;
	};
	me.endOfClass(arguments);
    return me;
}
