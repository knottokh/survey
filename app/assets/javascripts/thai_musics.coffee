# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".addNewOtherMusic").on "click", ->
    $(this).parent().find(".musicOtherSet").append  $(this).parent().find(".new_music_form").html()

  $(".removeMusic").on "click", ->
    $(this).closest('.OherMusicForm').remove()