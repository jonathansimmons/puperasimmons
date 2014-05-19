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
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-typeahead
//= require mention
//= require_tree .


$(document).ready(function(){

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


	$(document).on('click', '.cancel-edit', function(){
		$('#right_sidebar, body').removeClass('editing-contact');
		$('#contact_form').html(" ");
	});

	$(document).on('click', '.view-details', function(){
		$('li').not($(this).closest('li')).removeClass('open');
		$('.glyphicon').not($(this).children('.glyphicon')).removeClass('rotated')
		$(this).children('.glyphicon').toggleClass('rotated');
		$(this).closest('li').toggleClass('open')

	});

});

