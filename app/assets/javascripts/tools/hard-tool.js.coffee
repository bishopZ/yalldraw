$ ->
  class paper.HardTool extends paper.Tool
    constructor: ->
      console.log 'hard'

    onMouseMove: (event)->
      $('canvas').css 'cursor', 'move'

    onMouseDown: (event) ->
      paper.hoverSelection.clear()
      paper.hardSelection.put event.hitTest.item, !!event?.mouse?.shiftKey


    onMouseDrag: (event) ->
      paper.hardSelection.item.translate event.mouse.delta

