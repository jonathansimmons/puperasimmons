// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.min.js
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-formhelpers.js
//= require jquery.ioslist.min.js
//= require_tree .


$(document).ready(function(){

	$('.tooltip-it').tooltip();

	$("#activities_list").ioslist();


	$(document).on('change', '.complete-form .checkbox input', function(){
		$(this).closest('form').submit();
	});

	$(document).on('change', '#assigned_to, #sort_by', function(){
		$(this).closest('form').submit();
	});

	if ($(".comment-scroll").length > 0) {
		setTimeout(function(){
			$('.comment-scroll').scrollTop($('.commentbas-scroll').prop('scrollHeight'));
		},300)
	}

	$(document).on('change', '#contact_contact_type', function(){
		console.log($(this).val())
		if ($(this).val() == 'vendor') {
			$('.vendor-fields').removeClass('hide')
		} else {
			$('.vendor-fields').addClass('hide')
		}
		if ($(this).val() == 'client') {
			$('.client-fields').removeClass('hide')
		} else {
			$('.client-fields').addClass('hide')
		}
	});


	if ($('#assigned_to').val() != "") {
		$('#assigned_to option:first-child').text("Anyone")
	}
	$(document).on('focus', '#assigned_to', function(){
		$('#assigned_to option:first-child').text("Anyone")
	});

	$(document).on('blur', '#assigned_to', function(){
		if ($(this).val() == "") {
			$('#assigned_to option:first-child').text("Assigned To")
		}
	});

	if ($('#sort_by').val() != "") {
		$('#sort_by option:first-child').text("Clear Sort")
	}

	$(document).on('click', '.cancel-edit', function(e){
		e.preventDefault();
		$('#right_sidebar, body').removeClass('editing');
		$('#form_container').html(" ");
	});

	$(document).on('click', '.show-comments', function(e){
		e.preventDefault();
		console.log('comments')
		$(this).parent().siblings('#comments').toggleClass('hide');
	});


	$(document).on('click', '.cancel-comment-edit', function(e){
		e.preventDefault();
		$("#comments ul").removeClass('editing');
		$(this).parent().parent().addClass('hide');
		$(body).focus()
	});

});

