// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require popper
//= require bootstrap-sprockets
// require bootstrap
//= require bootstrap-select
// require cocoon
//= require rails.validations
//= require rails.validations.simple_form
//= require_tree .

$(function(){
    $(".active-border").each(function(index,elm){
        var per = parseInt($(elm).find(".prec").text(),10)
        //console.log(per)
        showdegree($(elm),per*3.6);
    })
    $(".bar-active-border").each(function(index,elm){
        var per = parseInt($(elm).find(".bar-prec").text(),10)
        //console.log(100-per)
        $(this).find(".bar").css('height',(100-per)+'%')
    })
})
function showdegree(elm,i){
	/*if (i<=180){
	    //f4f2f2
        elm.css('background-image','linear-gradient(' + (90+i) + 'deg, transparent 50%, #f4f2f2 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
    }
    else{
        //39B4CC
        elm.css('background-image','linear-gradient(' + (i-90) + 'deg, transparent 50%, #39B4CC 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
    }*/
    if (i<=180){
	    //f4f2f2
        elm.css('background-image','linear-gradient(' + (90+i) + 'deg, transparent 50%, #f4f2f2 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
        elm.css('background-color','#dc3545')
    }
    else if (i > 180 && i<=306){
        elm.css('background-image','linear-gradient(' + (i-90) + 'deg, transparent 50%, #fd7e14 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
        elm.css('background-color','#fd7e14')
        
    }
    else if (i === 360){
        elm.css('background-image','linear-gradient(' + (i-90) + 'deg, transparent 50%, #28a745 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
        elm.css('background-color','#28a745')
        
    }
    else{
        //39B4CC
        elm.css('background-image','linear-gradient(' + (i-90) + 'deg, transparent 50%, #ffc107 50%),linear-gradient(90deg, #f4f2f2 50%, transparent 50%)');
        elm.css('background-color','#ffc107')
        
    }
   

}