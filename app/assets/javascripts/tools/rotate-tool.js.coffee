class paper.RotateTool extends paper.Tool
  onMouseMovePredicate: (event) ->
    event.pastHandle()

  onMouseMove: (event) -> true

  onMouseDown: (event) ->
    @od = @originalRotation = @rotation event
    console.log @originalRotation

  onMouseDownPredicate: (event) -> event.pastHandle()

  onMouseDragPredicate: (event) ->
    event.pastHandle()

  onMouseDrag: (event) ->
    item = paper.hardSelection.group
    r = @rotation event

    d = r
    console.log 'rotate: ' + Math.round(r * 100) + ' ' + Math.round(@originalRotation * 100) + ' ' + Math.round(d * 100)
    item.rotate @od * -1
    paper.hardSelection.boundingBox.box.rotate @od * -1

    paper.view.draw()

    item.rotate d
    paper.hardSelection.boundingBox.box.rotate d
    @od = d

  rotation: (event) ->
    item = paper.hardSelection.group

    dx = event.event.offsetX - item.bounds.centerX
    dy = event.event.offsetY - item.bounds.centerY

    Math.atan2(dy, dx)

  onMouseDragSticky: -> true

