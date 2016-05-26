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

function numFormat(n) {
	if (n < 10) {
		return "0" + n;
	}

	return n;
}