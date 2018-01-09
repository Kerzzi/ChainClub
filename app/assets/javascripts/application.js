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


//navbar 由透明变其他颜色的相关代码
$(window).scroll(function () {
    if ($(this).scrollTop() > 125) {
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