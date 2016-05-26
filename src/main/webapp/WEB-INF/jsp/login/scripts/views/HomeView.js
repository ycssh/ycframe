$ns("login.views");

$import("mx.containers.HSplit");
$import("mx.containers.VSplit");
$import("mx.controls.Label");
$import("mx.containers.TabControl");

login.views.HomeView = function() {
	var me = $extend(mx.views.View);
	var base = {};

	base.init = me.init;
	me.init = function() {
		base.init();
		_initControls();
	};
	var hsplit = null;
	var vsplit = null;
	var tabControl = null;

	function _initControls() {
		hsplit = new mx.containers.HSplit({
			rows : "10%, 90%"
		});
		me.addControl(hsplit);

		vsplit = new mx.containers.VSplit({
			cols : "20%, 80%"
		});
		hsplit.addControl(vsplit, "1");

		tabControl = new mx.containers.TabControl({
			pages : [ {
				text : "首页",
				name : "homepage"
			} ]
		});
		vsplit.addControl(tabControl, "1");
		me.on("activate", me.controller._onactivate);
	}
	me.getHsplit = function() {
		return hsplit;
	}
	me.getVsplit = function() {
		return vsplit;
	}
	me.getTabControl = function() {
		return tabControl;
	}

	me.endOfClass(arguments);
	return me;
}