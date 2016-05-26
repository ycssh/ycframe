(function($) {
  

  var placeholderfriend = {
    focus: function(s) {
      s = $(s).hide().prev().show().focus();
      var idValue = s.attr("id");
      if (idValue) {
        s.attr("id", idValue.replace("placeholderfriend", ""));
      }
      var clsValue = s.attr("class");
	  if (clsValue) {
        s.attr("class", clsValue.replace("placeholderfriend", ""));
      }
    }
  }

  //判断是否支持placeholder
  function isPlaceholer() {
    var input = document.createElement('input');
    return "placeholder" in input;
  }
  //不支持的代码
  if (!isPlaceholer()) {
    $(function() {

      var form = $(this);

      var elementsPass = form.find("input[type='password'][placeholder]");
      elementsPass.each(function(i) {
        var s = $(this);
        var pValue = s.attr("placeholder");
		var sValue = s.val();
        if (pValue) {
          if (sValue == '') {
            var html = this.outerHTML || "";
            html = html.replace(/\s*type=(['"])?password\1/gi, " type=text placeholderfriend").replace(/\s*(?:value|on[a-z]+|name)(=(['"])?\S*\1)?/gi, " ").replace(/\s*placeholderfriend/, " placeholderfriend value='" + pValue + "' " + "onfocus='placeholderfriendfocus(this);' ");
            var idValue = s.attr("id");
            if (idValue) {
              s.attr("id", idValue + "placeholderfriend");
            }
            var clsValue = s.attr("class");
			if (clsValue) {
              s.attr("class", clsValue + "placeholderfriend");
            }
            s.hide();
            s.after(html);
          }
        }
      });

      elementsPass.blur(function() {
        var s = $(this);
        var sValue = s.val();
        if (sValue == '') {
          var idValue = s.attr("id");
          if (idValue) {
            s.attr("id", idValue + "placeholderfriend");
          }
          var clsValue = s.attr("class");
		  if (clsValue) {
            s.attr("class", clsValue + "placeholderfriend");
          }
          s.hide().next().show();
        }
      });

    });
  }
  window.placeholderfriendfocus = placeholderfriend.focus;
  $(function(){   
    //判断浏览器是否支持placeholder属性
    supportPlaceholder='placeholder'in document.createElement('input'),

    placeholder=function(input){
 
        var text = input.attr('placeholder'),
         defaultValue = input.defaultValue;
 
         if(!defaultValue){
 
             input.val(text).addClass("phcolor");
         }
 
         input.focus(function(){
 
             if(input.val() == text){
     
                 $(this).val("");
             }
         });
 
  
         input.blur(function(){
 
             if(input.val() == ""){
             
                 $(this).val(text).addClass("phcolor");
             }
         });
 
         //输入的字符不为灰色
         input.keydown(function(){
   
             $(this).removeClass("phcolor");
         });
     };
 
     //当浏览器不支持placeholder属性时，调用placeholder函数
     if(!supportPlaceholder){
 
         $('input').each(function(){
 
             text = $(this).attr("placeholder");
 
             if($(this).attr("type") == "text"){
 
                 placeholder($(this));
             }
         });
     }
 });
})(jQuery);
/*$(function(){   
    //判断浏览器是否支持placeholder属性
    supportPlaceholder='placeholder'in document.createElement('input'),

    placeholder=function(input){
 
        var text = input.attr('placeholder'),
         defaultValue = input.defaultValue;
 
         if(!defaultValue){
 
             input.val(text).addClass("phcolor");
         }
 
         input.focus(function(){
 
             if(input.val() == text){
     
                 $(this).val("");
             }
         });
 
  
         input.blur(function(){
 
             if(input.val() == ""){
             
                 $(this).val(text).addClass("phcolor");
             }
         });
 
         //输入的字符不为灰色
         input.keydown(function(){
   
             $(this).removeClass("phcolor");
         });
     };
 
     //当浏览器不支持placeholder属性时，调用placeholder函数
     if(!supportPlaceholder){
 
         $('input').each(function(){
 
             text = $(this).attr("placeholder");
 
             if($(this).attr("type") == "text"){
 
                 placeholder($(this));
             }
         });
     }
 });*/