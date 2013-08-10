$ ->
  class paper.HardTool extends paper.Tool
    constructor: ->
      console.log 'hard'

    onMouseMove: (event)->
      $('canvas').css 'cursor', 'move'

    onMouseDown: (event) ->
      paper.hoverSelection.clear()
      paper.hardSelection.put event.hitTest.item, !!event?.mouse?.shiftKey
      @oldPoint = null

    onMouseDrag: (event) ->
      # TODO: what happened to event.delta ??
      if @oldPoint
        delta = @oldPoint.subtract @createPoint event
        delta = @createPoint(event).subtract @oldPoint
        paper.hardSelection.group.translate delta
        paper.hardSelection.boundingBox.resizeBoxes()

      @oldPoint = @createPoint event

    createPoint: (event) ->
      new paper.Point event.event.x, event.event.y

