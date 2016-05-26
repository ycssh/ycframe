$ns('login.views');


login.views.MainViewController = function()
{
    var me = $extend(mx.views.ViewController);
    var base = {};
    var client = new mx.rpc.RESTClient();
    
    
    me.getView = function()
    {
        if (me.view == null)
        {
            me.view = new login.views.MainView({ controller: me });
        }
        return me.view;
    };
    me._refreshDataGrid = function(e)
	{
		me.view.getDetailWindow().hide();
	}
   
    me._initHtmlEvent = function(name,pass){
    	if(name!=null&&name.length>0&&pass!=null&&pass.length>0){
    		//e.target.$e.find("#logBtn").on("click",_btnLoginClick);
    		_btnLoginClick(name,pass);
    	}else{
    		mx.indicate("info","用户名和密码不能为空!");
    	}
    }
    me.inithomepage = function(){}
    me.onlogin = null;
    function _btnLoginClick(userName,password)
    {
		//var userName = $("#userNameText",me.view.$e).val();
    	//var password = $("#passwordText",me.view.$e).val();
			login.utils.Portal.login(userName, password, null,function(p_context){
				debugger;
    			if (p_context.successful)
            	{
    				debugger;
    					window.open(getRootPathByIp()+"/yxjk/yj/index.jsp?id="+login.utils.Portal.currentUser.id+"&name="+login.utils.Portal.currentUser.name+"&appID="+login.utils.Portal.appID,"_self");
            	}else{
            		mx.indicate("info","用户名或密码错误!");
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