// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
//= require select2
//= require ckeditor/init
//= require social-share-button
//= require social-share-button/wechat
//= require bootstrap-wysihtml5
//= require bootstrap-wysihtml5/locales/zh-CN
//= require_tree .

//navbar 相关代码
$(document).ready(function(){
    $(".dropdown").hover(            
        function() {
            $('.dropdown-menu', this).not('.in .dropdown-menu').stop(true,true).slideDown("400");
            $(this).toggleClass('open');        
        },
        function() {
            $('.dropdown-menu', this).not('.in .dropdown-menu').stop(true,true).slideUp("400");
            $(this).toggleClass('open');       
        }
    );
});

//navbar 由透明变其他颜色的相关代码
$(window).scroll(function () {
    if ($(this).scrollTop() > 550) {
        $('#navbar').addClass('show_bgcolor') 
    } else {
        $('#navbar').removeClass('show_bgcolor')
    }
})


// 图片自适应大小支持代码块
// 在很多页面中，对img图片用这一格式进行校正
// 让图片在大于div宽度时自动缩小不而溢出，确保版面的公正和美观
function ReImgSize(){
  for (j=0;j<document.images.length;j++)
  {
    document.images[j].width=(document.images[j].width>420)?"420":document.images[j].width;
  }
}

// 首页轮播图
$(document).ready(function() {
	var imagebox=$(".showbox").children('.imagebox')[0],//获得图片容器
		icobox=$(".showbox").children('.icobox')[0],//获得图标容器
		ico=$(icobox).children('span'),//获得图标数组
		imagenum=$(imagebox).children().size(),//获得图片数量
		imageboxWidth=$(imagebox).width(),//获得图片容器的宽度
		imagewidth=imageboxWidth*imagenum,//获得图片的总宽度
		activeID = parseInt($($(icobox).children(".active")[0] ).attr("rel")),//获得激活的图标ID
		nextID=0,//下一个图标的ID
		intervalID,//setInterval()函数的ID
		delaytime=4000,//延迟的时间
		speed=700;//执行速度
	    $(imagebox).css({'width' : imagewidth + "px"});

		var rotate=function(clickID) { //图片滑动函数
			if (clickID+1){
				nextID=clickID;
			}else{
				nextID=(activeID+1)%4;
			};
			$(ico[activeID]).removeClass('active');
			$(ico[nextID]).addClass('active');
			$(imagebox).animate({left:"-"+nextID*imageboxWidth+"px"}, speed);//jQuery中的animate函数
			activeID=nextID;
		}

		intervalID=setInterval(rotate,delaytime);//循环函数

		$.each(ico, function(index, val) {
			$(this).click(function(event) {
				clearInterval(intervalID);//清楚之前的定时任务
				 var clickID = index;
				 rotate(clickID);//运行一次带参数的rotate函数
				 intervalID = setInterval(rotate,delaytime);
			});
		});

});

// 网址导航页面的提示信息
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip()
})

// 首页搜索区域
function showSearch(whichsearch){
  var data_holder = whichsearch.getAttribute("data-placeholder");
  var link = whichsearch.getAttribute("data-search-link");
  var homeSearch = document.getElementById("homeSearch");
  var homeSearchInput = document.getElementById("homeSearchInput");
  homeSearch.setAttribute("action",link);
  homeSearchInput.setAttribute("placeholder",data_holder);
}