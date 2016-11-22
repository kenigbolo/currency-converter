(function($) {
	"use strict";

		/*====================================
		 Bootstrap Fix For WinPhone 8 And IE10
		======================================*/

		if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
			var msViewportStyle = document.createElement("style");
			msViewportStyle.appendChild(
				document.createTextNode(
					"@-ms-viewport{width:auto!important}"
				)
			);
			document.getElementsByTagName("head")[0].
				appendChild(msViewportStyle);
		}


		/*====================================
					Android stock browser
		======================================*/

		$(function () {
		  var nua = navigator.userAgent
		  var isAndroid = (nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1 && nua.indexOf('Chrome') === -1)
		  if (isAndroid) {
			$('select.form-control').removeClass('form-control').css('width', '100%')
		  }
		})



		/*====================================
					Preloader
		======================================*/

		$(window).load(function() {

			var preloaderDelay = 350,
				preloaderFadeOutTime = 800;

			function hidePreloader() {
				var loadingAnimation = $('#loading-animation'),
					preloader = $('#preloader');

				loadingAnimation.fadeOut();
				preloader.delay(preloaderDelay).fadeOut(preloaderFadeOutTime);
			}

			hidePreloader();

		});



		/*====================================
					Background
		======================================*/

		//Image Background
		$(".image-background").backstretch("assets/image-bg.jpg");



		//Parallax Background
		if($('body').hasClass('parallax-background')) {

		$.parallaxify({
			positionProperty: 'transform',
			responsive: true,
			motionType: 'natural',
			mouseMotionType: 'performance',
			motionAngleX: 70,
			motionAngleY: 70,
			alphaFilter: 0.5,
			adjustBasePosition: true,
			alphaPosition: 0.025,
		});
	    }



		/*====================================
					Clock Countdown
		======================================*/
		var date = new Date();
		var this_year = date.setDate(date.getDate()+280);
		var year = new Date(this_year).getFullYear().toString();
		var month = new Date(this_year).getMonth().toString();
		var day = new Date(this_year).getDate().toString();
		var countdown_date = year.concat('/',month,'/',day,' 12:00:00');

		$('#clock-countdown').countdown(countdown_date).on('update.countdown', function(event) {
			var $this = $(this).html(event.strftime(''
				+ '<div class="counter-container"><div class="counter-box first"><div class="number">%-D</div><span>Day%!d</span></div>'
				+ '<div class="counter-box"><div class="number">%H</div><span>Hours</span></div>'
				+ '<div class="counter-box"><div class="number">%M</div><span>Minutes</span></div>'
				+ '<div class="counter-box last"><div class="number">%S</div><span>Seconds</span></div></div>'
			));
		});



		/*====================================
					Flexslider
		======================================*/

		$('.flexslider').flexslider({
			animation: "fade",
			animationLoop: true,
			slideshowSpeed: 7000,
			animationSpeed: 600,
			controlNav: false,
			directionNav: false,
			keyboard: false,
			start: function(slider){
			$('body').removeClass('loading');
			}
		});



		/*====================================
					Flexslider
		======================================*/

		$(document).ready(function() {

		  $("#owl-demo").owlCarousel({

			  autoPlay: 3000, //Set AutoPlay to 3 seconds

			  items : 4,
			  itemsDesktop : [1199,3],
			  itemsDesktopSmall : [979,3]

		  });

		});

		/*====================================
					Nice Scroll
		======================================*/

		$("html").niceScroll({
			cursorcolor: '#ccc',
			cursoropacitymin: '0',
			cursoropacitymax: '1',
			cursorwidth: '3px',
			zindex: 10000,
			horizrailenabled: false,
		});



		/*====================================
					Animated.css
		======================================*/

		$('.animated').appear(function() {
			var element = $(this),
				animation = element.data('animation'),
				animationDelay = element.data('animation-delay');
				if ( animationDelay ) {

					setTimeout(function(){
						element.addClass( animation + " visible");
					}, animationDelay);

				} else {
					element.addClass( animation + " visible");
				}
		});



})(jQuery);
