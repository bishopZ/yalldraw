$ ->
  class paper.NoneTool extends paper.Tool
    constructor: ->
    onMouseMove: ->
      paper.hoverSelection.clear()
      $('canvas').css 'cursor', 'auto'

    onMouseDown: ->
      paper.hardSelection.clear()
      paper.hoverSelection.clear()

    onMouseDrag: ->
