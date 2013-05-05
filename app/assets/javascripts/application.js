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
//= require jquery.tokeninput
//= require pnotify
//= require raphael
//= require morris
//= require_tree .


$(window).ready(function(){
    KS_Init();

});

function KS_Init() {

    // $("table.students tbody tr").hover(function(){
    //     $(this).find('td:last-child .btn-group').fadeToggle("fast", "linear")
    // });

    if ( $('.system_guests-table').length > 0 ){


        $('[rel=tooltip]').tooltip({
            placement:'left'
        });

        
    }
    

    if ( $('.alert.alert-success').length > 0 ){
        $('.alert.alert-success').hide();
        var alert_text = $('.alert.alert-success').text();
        
        $.pnotify({
        title: 'Success',
        text: alert_text,
        type: 'success',
        sticker: false
        });
    }

    if ( $('.alert.alert-error').length > 0 ){
        $('.alert.alert-error').hide();
        var alert_text = $('.alert.alert-error').text();

        $('.alert.alert-success')
        $.pnotify({
        title: 'Error',
        text: alert_text,
        type: 'error',
        sticker: false
        });
    }

    // if ( $('.alert.alert-success, .alert.alert-error').length > 0 ){
    //     $('.alert.alert-success, .alert.alert-error').delay(5000).slideUp(500);
    // }

    $("table.students tbody tr, table.lectors tbody tr, table.admins tbody tr").hover(function(){
        $(this).find('td:last-child .btn-group > a').addClass("btn-info");
        $(this).css("font-weight","bolder").css("color","#2f96b4");
    },function(){
        $(this).find('td:last-child .btn-group > a').removeClass("btn-info");
        $(this).css("font-weight","normal").css("color","black");
    });

    $("table.templates tbody tr, table.courses tbody tr, table.seminars tbody tr, table.lessons tbody tr, table.labs tbody tr, table.system_hosts tbody tr, table.operating_systems tbody tr").hover(function(){
        $(this).find('td:last-child .btn-group > a,td:last-child .btn-group > button').addClass("btn-info");
    },function(){
        $(this).find('td:last-child .btn-group > a,td:last-child .btn-group > button').removeClass("btn-info");
    });

    $("#admins_search,#lectors_search,#students_search").focus(function() {
            var placeholder = $(this).attr("data-query_type");        
            $(this).animate({width: '200px'}).attr("placeholder",placeholder);
        })
        .on("keyup", function() {
            var value = $(this).val();
            var table = $(this).attr("data-table_type");
            $("table."+table+" tbody tr").each(function(index) {
                $row = $(this);
                var id = $row.find("td:first").text();
                if (id.indexOf(value) !== 0) {
                    $row.hide();
                }
                else {
                    $row.show();
                }
            });
        })
        .blur(function() {
             $(this).animate({width: '70px'},300).attr("placeholder","Find...");
             $('.icon-search').show();
    });

    var path = $("#seminar_users").attr("data-url");
    $("#seminar_users").tokenInput(path, {
        crossDomain: false,
        prePopulate: $("#seminar_users").data("pre"),
        theme: "facebook"
    });

    $('#course_info span').hover(function(){
        $(this).css("font-weight","bolder").css("color","#2f96b4");
    },function(){
        $(this).css("font-weight","normal").css("color","black");
    });

	$('.basic_seach_query').focus(function() {
        var placeholder = $('.search-query').attr("data-query_type");
	    $('.search-query').animate({width: '200px'}).attr("placeholder",placeholder);
        $('.form-search button.btn').addClass('btn-info');
	});
	$('.search-query').blur(function() {
	     $('.search-query').animate({width: '70px'}).attr("placeholder","Find...");
         $('.icon-search').show();
         $('.form-search button.btn').removeClass('btn-info')
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
        // $('form * ').show(); // Show forms
        $('.span6 *').show();
        $('.span4 *').show();
        $('form div').show();
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

    $('.timepicker').timepicker({
        showMeridian: false,
        minuteStep: 10,
        defaultTime: '12:00'
    });

    var starts_at = ($('.timepicker_start').attr("data-starts-at"));
    var ends_at = ($('.timepicker_end').attr("data-ends-at"));
    $('.timepicker_start').timepicker({
        showMeridian: false,
        minuteStep: 10,
        defaultTime: starts_at
    });
    $('.timepicker_end').timepicker({
        showMeridian: false,
        minuteStep: 10,
        defaultTime: ends_at
    });

    Morris.Donut({
        element: 'days-graph',
        data: [
        {label: "Monday", value: 12},
        {label: "Thuesday", value: 30},
        {label: "Wednesday", value: 20},
        {label: "Thursday", value: 50},
        {label: "Friday", value: 60},
        ],
        colors: ['#2f96b4','#F20A21','#8a4b7e','#2f9887','#2f9000'],
    });

    Morris.Bar({
      element: 'courses-graph',
      data: [
        { y: '2006', a: 100, b: 90 },
        { y: '2007', a: 75,  b: 65 },
        { y: '2008', a: 50,  b: 40 },
        { y: '2009', a: 75,  b: 65 },
        { y: '2010', a: 50,  b: 40 },
        { y: '2011', a: 75,  b: 65 },
        { y: '2012', a: 100, b: 90 },
      ],
      xkey: 'y',
      ykeys: ['a', 'b'],
      labels: ['Active courses', 'Inactive Courses'],
      hideHover: 'auto',
      barColors: ['#2f96b4','#F20A21'],
    });


}