# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@setrowclass = (variable) ->
  num = parseFloat(variable,10)
  if num == 100
    return "table-success"
  else if num > 85 && num < 100
    return "table-warning"
  else if num > 50 && num <= 85  
    return "table-middle"
  else if num > 0 && num <= 50 
    return "table-danger"
  else
    return ""
$ ->
  $('#schools-table').dataTable
    processing: true
    serverSide: true
    ajax: $('#schools-table').data('source')
    pagingType: 'full_numbers'
    columns: [
      {data: 'school_name'}
      {data: 'ministry_code'}
      {data: 'percent_all',searchable: false}
      {data: 'percent_1',searchable: false}
      {data: 'percent_2',searchable: false}
      {data: 'percent_3',searchable: false}
      {data: 'percent_4',searchable: false}
      {data: 'userinscool',searchable: false}
      {data: 'id' ,searchable: false}
    ]
    order: [[ 2, "desc" ]]
    createdRow:  (row, data, index) ->
        #console.log(data)
        rowclass = setrowclass(data.percent_all)
        $(row).addClass(rowclass)
    