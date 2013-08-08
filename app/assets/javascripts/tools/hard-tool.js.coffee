class paper.HardTool extends paper.Tool
  constructor: ->

  onMouseMove: (event)->
    $('canvas').css 'cursor', 'move'

  onMouseDown: (event) ->
    paper.hoverSelection.clear()
    paper.hardSelection.clear() if !event.mouse.shiftKey
    paper.hardSelection.add event.hitTest.item


  onMouseDrag: (event) ->
    paper.hardSelection.item.translate event.mouse.delta

