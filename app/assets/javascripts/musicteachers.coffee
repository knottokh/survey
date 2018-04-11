# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".addteachercount").on "click", ->
    num = parseInt($(this).parent().find("input").val(),10)
    childcount =  $(this).closest(".row").find(".musicOtherSet").children().length
    childcountdb =  $(this).closest(".row").find(".dbTeacherSet").children().length
    #console.log(childcount)
    if !isNaN(num) 
        diff = num - childcountdb - childcount
        if diff > 0
            for i in [0...diff]
                $(this).closest(".row").find(".musicOtherSet").append  $(this).closest(".row").find(".new_music_form").html()
    else
        $(this).parent().find("input").val("")
    