class paper.HoverTool extends paper.Tool
  constructor: ->

  onMouseMove: (event)->
    paper.hoverSelection.add event.hitTest.item
    event.hitTest.item.selected = true

  onMouseDown: (event) ->

  onMouseDrag: (event) ->

