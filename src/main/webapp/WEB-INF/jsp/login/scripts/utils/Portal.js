$ns("login.utils");

$import("mx.rpc.RESTClient");
$import("login.utils.AESUtil");

/**
 * 提供门户、登陆用户等相关信息的统一封装。该类在运行时唯一静态实例是 <b>workbench.Portal</b> 对象。
 */
login.PortalClass = function() {
	var me = this;

	me.ANONYMOUS_USER_ID = "U0878F4094545FDDC001";

	/**
	 * 获取一个 JSON 对象，表示当前登陆用户对象。
	 * 
	 * @example <code language="JavaScript">
	 * alert("当前登陆用户唯一标识: " + workbench.Portal.currentUser.id);
	 * alert("当前登陆用户名: " + workbench.Portal.currentUser.name);
	 * </code>
	 */
	me.currentUser = null;

	/**
	 * 获取系统标识。
	 */
	me.appID = null;

	me.preUserName = null;

	/**
	 * 获取登录页地址。
	 */
	me.loginPath = null;

	var _client = null;
	var _key = "c32ad1415f6c89fee76d8457c31efb4b";

	/**
	 * 使用指定的用户名、密码进行异步登陆。
	 * 
	 * @param p_userName
	 *            用户的登录名。
	 * @param p_password
	 *            用户的密码。
	 * @param p_options
	 *            保留参数，暂未使用。
	 * @param [p_callback]
	 *            一个 Function 对象，即回调方法。当服务端应答后，客户端将通过调用 p_callback 返回响应结果。
	 * 
	 * @example <code language="JavaScript">
	 * function _login_callback(p_context)
	 * {
	 *     if (p_context.successful)
	 *     {
	 *         alert("登陆成功。当前用户为 " + workbench.Portal.currentUser.name);
	 *     }
	 *     else
	 *     {
	 *         alert("登陆失败，请参考: " + p_context.error.message);
	 *         // 或$showerror(p_context);
	 *     }
	 * }
	 * 
	 * workbench.Portal.login("admin", "abc123", null, _login_callback);
	 * </code>
	 */
	me.login = function(p_userName, p_password, p_options, p_callback) {
		var params = {
			params : {
				userName : p_userName,
				password : login.utils.AESUtil.encrypt(_key, p_password)
			}
		};
		
		return _getClient().post(
				//isc
				"~/../iscintegrate/common/loginuser/validate",
				JSON.stringify(params), function(p_context) {
					if (p_context.successful) {
						me.currentUser = p_context.resultValue;
					}
					if ($isFunction(p_callback)) {
						p_callback(p_context);
					}
				});
	};
	me.aesPassword = function(p_password){
		return login.utils.AESUtil.encrypt(_key, p_password);
	};
	me.aesJiePassword = function(p_password){
		return login.utils.AESUtil.decrypt(_key, p_password);
	};
	/**
	 * 注销当前登陆用户。
	 */
	me.logoff = function(str) {
		var params = {
			params : {
				userName : me.currentUser.name
			}
		};
		if(str==1){
		_getClient().post(
				"~/../iscintegrate/common/loginuser/loginout",
				JSON.stringify(params),
				function(p_context) {
					me.currentUser = null;
					window.location.href = login.mappath("~/login/resources/skins/login.html");
				});
		}else{
			_getClient().post(
					"~/../iscintegrate/common/loginuser/loginout",
					JSON.stringify(params),
					function(p_context) {
						me.currentUser = null;
						window.location.href = login.mappath("~/login/index.jsp");
					});
		}
	};

	/**
	 * 返回一个 Boolean 值。如果为 true，当前登陆用户为匿名用户，即尚未登陆；如果为 false，则为已登陆。
	 */
	me.isAnonymous = function() {
		return me.currentUser == null
				|| me.currentUser.id == me.ANONYMOUS_USER_ID;
	};

	/**
	 * 返回一个 Boolean 值。表示是否已登录。
	 */
	me.isLogin = function() {
		var result = _getClient().getSync("/isanonymous");
		if (result != null && result.successful
				&& typeof (result.resultValue.isAnonymous) != "undefined") {
			me.currentUser = (result.resultValue.isAnonymous || result.resultValue.isAnonymous == "true") ? null
					: result.resultValue.user;
			me.appID = result.resultValue.appID;
			me.loginPath = result.resultValue.loginPath;
		} else {
			return false;
		}
		return !result.resultValue.isAnonymous;
	};

	function _getClient() {
		if (_client == null) {
			_client = new mx.rpc.RESTClient( {
				baseUrl : "~/../workbench/portal",
				timeout : 60000
			});
		}
		return _client;
	}

	/**
	 * @ignore
	 */
	me.toString = function() {
		var result = "";
		if (me.currentUser != null
				&& typeof (me.currentUser.name) != "undefined") {
			result += me.currentUser.name;
		}
		return result;
	};

	return me;
};

login.utils.Portal = new login.PortalClass();