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

    $('.repository_group > .checkbox > input:checkbox').click(function(e) {
        console.log('pipise')
        $(this).closest('.repository_group').find(':checkbox').prop('checked', this.checked);
    });

    if ( $('form.new_repository_group').length > 0 ){
        var repoFields = 1;

        $('.add_repository_field').on('click', function(){
            var fields = '';
            fields += "<div class='added_field'>";
            fields += "<div class='repository_name control-group'>";
            fields += '<label for="repository_name_' + repoFields + '">Repository name</label>';
            fields += '<input id="repository_name_' + repoFields + '" name="repository_name_' + repoFields + '" type="text"></div>';

            fields += "<div class='repository_url control-group'>";
            fields += '<label for="repository_url_' + repoFields + '">Repository url</label>';
            fields += '<input id="repository_url_' + repoFields + '" name="repository_url_' + repoFields + '"  type="text"></div>';
            fields += "<ul class='nav nav-tabs'></ul></div>";
            repoFields++;
            // $(this).before(fields);
            if ( $('.added_field').length > 0 ){
                $('.added_field:last').after(fields).hide().slideDown('slow');
            }
            else {
                $('.initial_field').after(fields).hide().slideDown('slow');
            }
        });

        $('.remove_repository_field').on('click',function(){
            $('.added_field').last().slideUp('slow',function(){
                $(this).remove();
            });
        });
    }



    if ( $('#repositories').length > 0 ){
        $('[rel=tooltip]').tooltip({
            placement:'right'
        });
    }

    $('#template_operating_system_id').change(function() {
        var selectVal = $('#template_operating_system_id :selected').val();
        $.getJSON('http://localhost:3000/operating_systems/' + selectVal, function(data) {
            console.log(data);
            $('#template_operating_system_id').popover({
                content: data
            });
        });
    });



    $('.brand').hover(function(){
        $('.navigation-title').attr("src", "/assets/ks-blue.png");
        },function(){
        $('.navigation-title').attr("src", "/assets/ks.png");
    })

    $('.puppet_group > .checkbox > input:checkbox').click(function(e) {
        $(this).closest('.puppet_group').find(':checkbox').prop('checked', this.checked);
    });

    function toggleChecked(status){
        $(".puppet_classes input").each( function() {
        $(this).attr("checked",status);
        })
    }



    if ( $('.system_guests-table').length > 0 ){
        $('[rel=tooltip]').tooltip({
            placement:'top'
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

    $('.nav-tabs.lesson a, .nav-tabs.course a').click(function(e) {
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
        $('div .puppet_classes').show();
        $('form div').show();
        }
    });

    $('.nav-tabs.template a').click(function(e) {
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
        $('div .puppet_classes').show();
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

    if( $('.dashboard').length > 0 ){

        $.getJSON('http://localhost:3000/dashboard/', function(data) {
            var day_lessons = data.day_lessons;
            var os_family_count = data.os_family_count

            Morris.Donut({
                element: 'days-graph',
                data: [
                {label: "Monday", value: day_lessons[0]},
                {label: "Thuesday", value: day_lessons[1]},
                {label: "Wednesday", value: day_lessons[2]},
                {label: "Thursday", value: day_lessons[3]},
                {label: "Friday", value: day_lessons[4]},
                {label: "Weekend", value: day_lessons[5]},
                ],
                colors: ['#2f96b4','#F20A21','#8a4b7e','#2f9887','#2f9000','#2f4fa0'],
            });

            Morris.Bar({
              element: 'courses-graph',
              data: [
                { y: 'Archlinux', a: os_family_count[0] },
                { y: 'Debian', a: os_family_count[1] },
                { y: 'RedHat', a: os_family_count[2] },
                { y: 'Solaris', a: os_family_count[3] },
                { y: 'Suse', a: os_family_count[4] },
              ],
              xkey: 'y',
              ykeys: ['a'],
              labels: ['Lessons using'],
              hideHover: 'auto',
              barColors: ['#5bc0de'],
              gridTextSize: '12',
            });
        });
    }


}