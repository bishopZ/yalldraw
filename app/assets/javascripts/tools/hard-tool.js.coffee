$ ->
  class paper.HardTool extends paper.Tool
    constructor: ->

    onMouseMovePredicate: (event)->
      event.hitsHandle() && event.hasHardSelection()

    onMouseMove: (event)->
      $('canvas').css 'cursor', 'move'

    onMouseDownPredicate: (event) ->
      event.hitsItem()

    onMouseDown: (event) ->
      paper.hoverSelection.clear()
      paper.hardSelection.put event.hitTest.item, !!event.event?.shiftKey
      @oldPoint = null

    onMouseDragPredicate: (event) ->
      event.hasHardSelection()

    onMouseDragPredicate: (event) ->
      event.hasHardSelection()

    onMouseDrag: (event) ->
      # TODO: what happened to event.delta ??
      if @oldPoint
        delta = @createPoint(event).subtract @oldPoint
        paper.hardSelection?.group?.translate delta
        paper.hardSelection.boundingBox.resizeBoxes()

      @oldPoint = @createPoint event

    createPoint: (event) ->
      new paper.Point event.event.x, event.event.y

