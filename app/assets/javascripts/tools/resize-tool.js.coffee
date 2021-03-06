class paper.ResizeTool extends paper.Tool
  onMouseMovePredicate: (event) ->
    event.hitsHandle()

  onMouseMove: (event)->
    $('canvas').css 'cursor', event.hitTest.item.handle + '-resize'

  onMouseDownPredicate: (event) ->
    event.hitsHandle()

  onMouseDown: (event) ->
    @direction = event.hitTest.item.handle

  onMouseDragPredicate: (event) ->
    event.hasHardSelection() && event.hitsHandle()

  onMouseDrag: (event) ->
    @resize @direction, paper.hardSelection.group, new paper.Point(event.event.layerX, event.event.layerY)
  onMouseDragSticky: -> true

  resize: (direction, item, point) ->
    bounds = null
    itemBounds = item.bounds

    if direction == 'n'
      itemBounds.setTop point.y
    else if direction == 's'
      itemBounds.setBottom point.y
    else if direction == 'w'
      console.log point.x
      itemBounds.setLeft point.x
    else if direction == 'e'
      itemBounds.setRight point.x
    else if direction == 'ne'
      itemBounds.setTopRight point
    else if direction == 'se'
      itemBounds.setBottomRight point
    else if direction == 'nw'
      itemBounds.setTopLeft point
    else if direction == 'sw'
      itemBounds.setBottomLeft point

    paper.hardSelection.boundingBox.resizeBoxes()

