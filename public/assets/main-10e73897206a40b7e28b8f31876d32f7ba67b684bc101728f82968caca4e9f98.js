!function(e){"use strict";if(navigator.userAgent.match(/IEMobile\/10\.0/)){var a=document.createElement("style");a.appendChild(document.createTextNode("@-ms-viewport{width:auto!important}")),document.getElementsByTagName("head")[0].appendChild(a)}e(function(){var a=navigator.userAgent,t=a.indexOf("Mozilla/5.0")>-1&&a.indexOf("Android ")>-1&&a.indexOf("AppleWebKit")>-1&&a.indexOf("Chrome")===-1;t&&e("select.form-control").removeClass("form-control").css("width","100%")}),e(window).load(function(){function a(){var a=e("#loading-animation"),n=e("#preloader");a.fadeOut(),n.delay(t).fadeOut(o)}var t=350,o=800;a()}),e(".image-background").backstretch("/assets/image-bg-94e9ab7a5ab4bac2378ea37d2f37d398c11b691d9ee6cc81cef785c3916f571e.jpg"),e("body").hasClass("parallax-background")&&e.parallaxify({positionProperty:"transform",responsive:!0,motionType:"natural",mouseMotionType:"performance",motionAngleX:70,motionAngleY:70,alphaFilter:.5,adjustBasePosition:!0,alphaPosition:.025});var t=new Date,o=t.setDate(t.getDate()+280),n=new Date(o).getFullYear().toString(),i=new Date(o).getMonth().toString(),s=new Date(o).getDate().toString(),d=n.concat("/",i,"/",s," 12:00:00");e("#clock-countdown").countdown(d).on("update.countdown",function(a){e(this).html(a.strftime('<div class="counter-container"><div class="counter-box first"><div class="number">%-D</div><span>Day%!d</span></div><div class="counter-box"><div class="number">%H</div><span>Hours</span></div><div class="counter-box"><div class="number">%M</div><span>Minutes</span></div><div class="counter-box last"><div class="number">%S</div><span>Seconds</span></div></div>'))}),e(".flexslider").flexslider({animation:"fade",animationLoop:!0,slideshowSpeed:7e3,animationSpeed:600,controlNav:!1,directionNav:!1,keyboard:!1,start:function(){e("body").removeClass("loading")}}),e(document).ready(function(){e("#owl-demo").owlCarousel({autoPlay:3e3,items:4,itemsDesktop:[1199,3],itemsDesktopSmall:[979,3]})}),e("html").niceScroll({cursorcolor:"#ccc",cursoropacitymin:"0",cursoropacitymax:"1",cursorwidth:"3px",zindex:1e4,horizrailenabled:!1}),e(".animated").appear(function(){var a=e(this),t=a.data("animation"),o=a.data("animation-delay");o?setTimeout(function(){a.addClass(t+" visible")},o):a.addClass(t+" visible")})}(jQuery);