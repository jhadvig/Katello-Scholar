// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-1.8.3
//= require bootstrap
//= require bootstrap-timepicker
//= require_tree .


$(window).ready(function(){
    KS_Init();

});

function KS_Init() {

	$('.timepicker').timepicker({
		showMeridian: false,
		minuteStep: 10
	});

	$('.search-query').focus(function() {
	     $('.search-query').animate({width: '200px'}).attr("placeholder","Course code or name");
	});
	$('.search-query').blur(function() {
	     $('.search-query').animate({width: '70px'}).attr("placeholder","");
	});


    $(".nav-tabs li:first").addClass("active"); // Activate first tab
    $(".tab-content div:first").addClass("active"); // Show first tab content
    
    $('.nav-tabs a').click(function(e) {
        e.preventDefault();
        if ($(this).closest("li").attr("class") == "active"){ //detection for current tab
        	return       
        }
        else{             
        $(".tab-content div").hide(); //Hide all content
        $(".nav-tabs li").attr("class",""); //Reset id's
        $(this).parent().attr("class","active"); // Activate this
        $($(this).attr('href')).fadeIn();
        $($(this).attr('href')).children().fadeIn(); // Show content for current tab
        $('.table-action-button').show(); // Show buttons in tables
        $('form > div').show(); // Show forms
        console.log($(this).attr('href'));
        }
    });

	$('table.table-striped tbody tr').hover(function(){
		$(this).find('td').toggleClass('hover')
	});

	$('a.btn.disabled').click(function(e) {
        e.preventDefault();
    });

    $('input[title]').tooltip({
    	placement:'right',
    	trigger:'hover focus'});

	$('.dropdown-toggle').dropdown();

	$('th input:checkbox').click(function(e) {
		var table = $(e.target).parents('table:first');
		$('td input:checkbox', table).attr('checked', e.target.checked);
	});

}