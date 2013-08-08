class paper.NoneTool extends paper.Tool
  constructor: ->
  onMouseMove: ->
    $('canvas').css 'cursor', 'auto'

  onMouseDown: ->
    paper.hardSelection.clear()
    paper.hoverSelection.clear()

  onMouseDrag: ->
