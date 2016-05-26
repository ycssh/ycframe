$import("login.views.MainViewController");
$import("login.views.MainViewControllerLogin");
$import("login.views.MainViewLogin");
$import("mx.utils.EncryptUtil");
$import("mx.controls.Label");
$import("mx.editors.TextEditor");
$import("mx.controls.Button");
$import("mx.containers.HtmlContainer");
$import("mx.controls.MainMenu");
$import("mx.editors.PictureEditor");
$import("mx.controls.IconTray");
$import("mx.datacontainers.TreeEntityContainer");
$import("mx.datacontrols.DataTree");
$import("mx.containers.Container");
$import("login.utils.Portal");
$import('login.views.MainView');
mx.weblets.WebletManager.register({
    id: "login",
    name: "登陆",
    requires:[],
    onload: function(e)
    {
    	//$import("login.views.HomeView");	
    },
    onstart: function(e)
    {
    	var mvc = null;
    	if($("#type").val()=='1'){
    		mvc = new login.views.MainViewControllerLogin();
    	}else{
    		mvc = new login.views.MainViewController();
    	}
    	e.context.rootViewPort.setViewController(mvc);
    }
});