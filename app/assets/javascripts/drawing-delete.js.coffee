$ ->
  $('button.drawing-delete').click ->
    $.ajax
      url: "/drawings/#{$(this).data('drawing')}",
      type: 'delete'
      success: =>
        $(this).parents('tr').fadeOut ->
          $(this).remove()
          reorder()

  reorder = ->
    $('table#drawings td.count').each (i, val) ->
      $(val).text i + 1

