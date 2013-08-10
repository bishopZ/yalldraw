$ ->
  class paper.HoverTool extends paper.Tool
    constructor: ->

    onMouseMove: (event)->
      paper.hoverSelection.add event.hitTest.item

    onMouseDown: (event) ->

    onMouseDrag: (event) ->
