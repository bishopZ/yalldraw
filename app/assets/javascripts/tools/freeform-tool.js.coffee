$ ->
  class paper.FreeformTool extends Tool
    constructor: (point) ->
      super()
      @path = new Path point
      @path.type = 'Freeform'

    onMouseDrag: (point) ->
      @path.add point

    onMouseUp:  (point) ->
      segs = @path.segments
      @path.simplify(100)
      if segs[0].point.getDistance(point) < 10
        @path.add new Point segs[0].point
        @path.closed = true

