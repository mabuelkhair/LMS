# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('.best_in_place').best_in_place()
  $.datepicker.setDefaults
	  minDate: new Date(1965, 1 - 1, 1)
	  maxDate: new Date(2010, 1 - 1, 1)