class paper.RotateTool extends paper.Tool
  onMouseMovePredicate: (event) ->
    event.pastHandle()

  onMouseMove: (event) ->
    console.log 'rotating'

  onMouseDown: (event) ->
    console.log 'DownRotating'

  onMouseDownPredicate: (event) -> event.pastHandle()

  onMouseDragPredicate: (event) ->
    event.pastHandle()

  onMouseDrag: (event) ->
    item = paper.hardSelection.group
    dx = event.event.offsetX - item.bounds.centerX
    dy = event.event.offsetY - item.bounds.centerY
    d = Math.atan2(dy, dx)
    console.log 'rotate: ' + Math.round(dx) + ' ' + Math.round(dy)

    item.rotate d
    paper.hardSelection.boundingBox.box.rotate d

  onMouseDragSticky: -> true

