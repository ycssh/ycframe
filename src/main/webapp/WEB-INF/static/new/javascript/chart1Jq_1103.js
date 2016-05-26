function initChart1Jq() {
	// 左侧nav的jquery事件
	var $wrapNav = $('.wrapNav');
	var dt = $wrapNav.find('dt');
	dt.on("click",function(){
		var $i = $(this).children('i');
		if ($i.hasClass('open')) {
			$i.removeClass('open');
			$(this).siblings('dd').css('display', 'none');
		} else {
			$i.addClass('open');
			$(this).siblings('dd').css('display', 'block');

		}
	});
	var dd = dt.siblings('dd');
	dd.on("click",function() {
		if (!$(this).hasClass('active')) {
			dd.removeClass('active');
			$(this).addClass('active');

		}
	});

	// 自定义select事件
	var $selectDiy = $('.selectDiy');

	$selectDiy.each(function() {
		var $selectCont = $(this).children('.selectCont');
		var $selectUl = $(this).children('ul');
		var $selectLi = $selectUl.children('li');
		$(this).click(function() {
			$selectUl.toggle();
		});
		$selectLi.click(function() {
			var showCon = $(this).html();
			$selectCont.html(showCon);
		});
	});

	// 自定义select事件
	var $selectDiy = $('.selectDiy1');

	$selectDiy.each(function() {
		var $selectCont = $(this).children('.selectCont');
		var $selectUl = $(this).children('ul');
		var $selectLi = $selectUl.children('li');
		$(this).click(function() {
			$selectUl.toggle();
		});
		$selectLi.click(function() {
			var showCon = $(this).html();
			$selectCont.html(showCon);
			chartXyg();
		});
	});
	
	// 两个chart之间tab切换
	$(".chartTopTab").each(function(j,n){
		$(n).find("li").each(function(i,domEle){
			$(domEle).bind("click",function(){
			  $(domEle).parent().find("li").removeClass('active');
			  $(domEle).addClass('active');
			  $(domEle).parent().parent().nextAll("div").hide();
			  $(domEle).parent().parent().parent().find(".chartBody").eq(i).show();
			})
		})
	})
	// jq控制td的宽度跟对应的th的宽度一样

	var $thTable = $('.thTable');

	$thTable.each(function() {

		var scrollWidth = 0;
		var $tableBodyDiv = $(this).siblings('.tableBody');
		var $tableBody = $tableBodyDiv.find('table');
		var heightO = $tableBodyDiv.height();
		var heightN = $tableBody.outerHeight();
		if (heightO < heightN) {
			scrollWidth = 19;
		}
		;
		var $ths = $(this).find('th');
		$ths.each(function() {
			var index = $(this).index();
			$thBody = $(this).parents('.thTable').siblings('.tableBody').find(
					'th');
			var thWidth = $(this).width();
			if (index < $ths.length - 1) {
				$thBody.eq(index).width(thWidth);
			} else {
				$thBody.eq(index).width(thWidth - scrollWidth);
			}
		})
	});

	// 自定义radio选中与否状态与对应input对应
	var $radioDiv = $('.radioDiv');
	var $radioLabels = $radioDiv.find('label');
	$radioLabels.click(function() {
		var $thisRadio = $(this).prev('input[type=radio]');
		$(this).siblings('label').removeClass('checked');
		$thisRadio.prop('checked', 'true');
		$(this).addClass('checked');
	})

}