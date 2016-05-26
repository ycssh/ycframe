$ns("login.views");
login.views.MainViewLogin = function()
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
