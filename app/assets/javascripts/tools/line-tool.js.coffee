$ ->
  class paper.LineTool extends paper.Tool
    constructor: (point) ->
      @path = new paper.Path.Line point, point
      @path.type = 'Line'

    onMouseDrag: (point) ->
      @path.segments[1].point = point
