$ ->
  colorOptions =
    realtime: true
    invertControls: false
    controlStyle: 'raised'
    alpha: false

  $('input#fg-color').colorpicker colorOptions
  $('input#bg-color').colorpicker colorOptions

  $('#brush-size-slider').slider
    min   : 0
    max   : 10
    step  : .1
    value : 6
    slide : (e, ui)->
      $('#brush-size-text').val($('#brush-size-slider').slider('value'))
