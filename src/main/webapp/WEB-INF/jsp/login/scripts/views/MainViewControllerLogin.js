$ns('login.views');

login.views.MainViewControllerLogin = function()
{
    var me = $extend(mx.views.ViewController);
    var base = {};
    var client = new mx.rpc.RESTClient();
    
    
    me.getView = function()
    {
        if (me.view == null)
        {
            me.view = new login.views.MainViewLogin({ controller: me });
            _btnLoginClick();
        }
        return me.view;
    };
    me._refreshDataGrid = function(e)
	{
		me.view.getDetailWindow().hide();
	}
   
    
    me._initHtmlEvent = function(e){
    		e.target.$e.find("#logBtn").on("click",_btnLoginClick);
    }
    me.inithomepage = function(){}
    me.onlogin = null;
    function _btnLoginClick()
    {
		var userName = $("#username").val();
    	var password = $("#password").val();
			login.utils.Portal.login(userName, password, null,function(p_context){
    			if (p_context.successful)
            	{
    				var client = new mx.rpc.RESTClient();
    				client.get("~/main/menu/userin/", function(p_context) // 回调函数
    				{
    					window.open(getRootPathByIp()+"/yxjk/yj/index.jsp?id="+login.utils.Portal.currentUser.id+"&name="+login.utils.Portal.currentUser.name+"&appID="+login.utils.Portal.appID,"_self");
    				});
            	}else{
            		/*window.open(mx.mappath("~/main/login/resources/skins/error.html") ,
            				"显示窗口", "height=800, width=1200, top=0, left=0, toolbar=yes, menubar=yes, scrollbars=yes, " +
            				 "resizable=yes, location=yes, status=yes"
            				);*/
            	}
    		});
		
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