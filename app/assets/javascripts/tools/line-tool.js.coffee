$ ->
  class paper.LineTool extends Tool
    constructor: (point) ->
      super()
      @path = new Path.Line point, point
      @path.type = 'Line'

    onMouseDrag: (point) ->
      @path.segments[1].point = point
