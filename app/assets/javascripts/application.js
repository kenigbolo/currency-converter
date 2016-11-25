// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require Chart.bundle
//= require highcharts.js
//= require chartkick
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

/*==========================================
 Use Javascript to disable Calculate button
============================================*/
$( document ).ready(function() {
    $('input').keyup(function() {

        var empty = false;
        $('input').each(function() {
            if ($(this).val() == '') {
                empty = true;
            }
        });

        if (empty) {
            $('#calculate').attr('disabled', 'disabled');
        } else {
            $('#calculate').removeAttr('disabled');
        }
    });
})()
