$ ->
  class paper.FreeformTool extends paper.Tool
    constructor: (point) ->
      super()
      @path = new paper.Path point
      @path.type = 'Freeform'

    onMouseDrag: (point) ->
      @path.add point

    onMouseUp:  (point) ->
      segs = @path.segments
      @path.simplify(100)
      if segs[0].point.getDistance(point) < 10
        @path.add new paper.Point segs[0].point
        @path.closed = true
