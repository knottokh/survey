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
//= require select2-full
//= require jquery.dataTables
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
    $(".alert,.notice-alert" ).fadeOut(10000);
    $(window).scroll(function(){
        if ($(this).scrollTop() > 400) {
            $(".scrollToTop").fadeIn(1000);
            $(".from-save-fix").addClass("save-fixed")
        } else {
            $(".scrollToTop").fadeOut(1000);
            $(".from-save-fix").removeClass("save-fixed")
        }
    });

    //Click event to scroll to top
    $(".scrollToTop").click(function(){
        $('html, body').animate({scrollTop : 0},500);
        return false;
    });
    /* $('#ajax-example').select2({
            placeholder: "Search for a teen",
            theme: "bootstrap",
            minimumInputLength: 1,
            ajax: {
              url: "/allschools",
              dataType: "json",
              quietMillis: 300,
              data: function (search, page) {
                    return {
                        term: search,
                        page_limit: 10,
                        page: page,
                    };
              },
              success: function(data, page) {
                  console.log(data)
                return { 
                  results: $.map( data, function(school, i) { 
                    return { id: school.id, text: school.school_name+" "+school.ministry_code } 
                  } )
                }
              }
            }
          });*/
    /* $('#mySelect2').select2({
          placeholder: "Search for a teen",
            theme: "bootstrap",
          ajax: {
            url: '/allschools',
            success: function(result,pages){
                console.log(pages)
                console.log(result)
            },
            processResults: function (data) {
                console.log(data)
              // Tranforms the top-level key of the response object from 'items' to 'results'
              return {
                results: (typeof data != "undefined")?data.schools : []
              };
            }
          }
        });    */ 
        $('.school_search').select2({
          ajax: {
                url: '/allschools',
                dataType: 'json',
                delay: 250,
                data: function(params) {
                    return {
                        term: params.term,
                        page: params.page,
                        page_limit: 30
                    };
                },
                processResults: function(data, page) {
                    //console.log(data)
                    return {
                        results: data.schools
                    };
                },
                cache: true
            },
            escapeMarkup: function(markup) {
                return markup;
            },
            allowClear: true,
            templateResult: function(school) {
                if(typeof school.ministry_code !== "undefined" && typeof school.school_name !== "undefined")
                
                    return school.ministry_code +" "+ school.school_name
                
                return school.school_name || school.ministry_code;
            },
            templateSelection: function(school) {
                if(typeof school.ministry_code !== "undefined" && typeof school.school_name !== "undefined")
                
                    return school.ministry_code +" "+ school.school_name
                
                return 'Type for search company categories'
            }
        });
   
    /*function formatExample(person) {
        console.log(person)
        var originalOption = $(person.element);
        return "555 " + person.text;
    }          
    $('#ajax-example').select2({
        placeholder: "Search for a teen",
        minimumInputLength: 1,
        ajax: {
            url: "/allschools",
            dataType: 'json',
            quietMillis: 300,
            data: function (search, page) {
                return {
                    term: search,
                    page_limit: 10,
                    page: page,
                };
            },
            results: function (data, page) {
                console.log(data)
            var more = (page * 10) < data.total;                
              return {results: data.schools, more: more};
            }
        },
        formatResult: formatExample,
        formatSelection: formatExample, 
        //dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
    });*/
    $.ajax({url: "/allschools",data: {
                    search: 'เศรษ',
                    page_limit: 10,
                    page: 1,
                },dataType: 'json', success: function(result,pages){
        console.log(pages)
        console.log(result)
    }});
})
function setOtherShowHide(val,elm){
    //console.log(val);
    var $otherinput = $(elm).parent().find("input:last");
    if(val == "อื่นๆ (โปรดระบุ)") {
       
      $otherinput.val('');      
      $otherinput.show();
    }else{
      $otherinput.val(val);
      $otherinput.hide();
    }
}
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