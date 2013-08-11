class paper.ResizeTool extends paper.Tool
  constructor: ->

  onMouseMove: (event)->
    $('canvas').css 'cursor', event.hitTest.item.handle + '-resize'

  onMouseDown: (event) ->
    @direction = event.hitTest.item.handle

  onMouseDrag: (event) ->
    @resize @direction, paper.hardSelection.group, new paper.Point(event.event.layerX, event.event.layerY)

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

