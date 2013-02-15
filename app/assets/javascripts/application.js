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
//= require_tree .


$(window).ready(function(){
    KS_Init();

});

function KS_Init() {

	$('table.table-striped tbody tr').hover(function(){
		$(this).find('td').toggleClass('hover')
	});

	$('.dropdown-toggle').dropdown();

	$('th input:checkbox').click(function(e) {
		var table = $(e.target).parents('table:first');
		$('td input:checkbox', table).attr('checked', e.target.checked);
	});

}