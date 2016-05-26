function dateFormater(value, row, index) {
	if (value) {
		var d = new Date(value);

		return dateFormat(d);
	} 
	
	return null;
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


function dateFormater3(value, row, index) {
	if (value) {
		var d = new Date(value.substring(0,10));
		return dateFormat3(d);
	} 
	
	return null;
}

function dateFormat3(d) {
	var y = d.getFullYear();
	var m = d.getMonth() + 1;
	var dt = d.getDate();
	var h = d.getHours();
	var mi = d.getMinutes();
	var s = d.getSeconds();
	return y + "-" + numFormat(m) + "-" + numFormat(dt) ;
}





function dateFormat2(d) {
	var y = d.getFullYear();
	var m = d.getMonth() + 1;
	var dt = d.getDate();
	var h = d.getHours();
	var mi = d.getMinutes();
	var s = d.getSeconds();

	return  numFormat(m) + "/" + numFormat(dt) +"/"+y+ " " + numFormat(h)
			+ ":" + numFormat(mi) ;
}

function numFormat(n) {
	if (n < 10) {
		return "0" + n;
	}

	return n;
}

$.extend($.fn.datagrid.defaults,{
	onLoadError:function(a,b,c,d,e,f){
    	
		if(b=='error'&&c=='Unauthorized'){
			alert('权限不足！');
			return;
		}
    }
});
