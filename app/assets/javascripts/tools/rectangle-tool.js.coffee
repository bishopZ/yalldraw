$ ->
  class paper.RectangleTool extends paper.Tool
    constructor: (point) ->
      @point = point
      @path = new paper.Path.Rectangle point, point
      @path.type = 'Rectangle'

    onMouseDrag: (point) ->
      @path.segments[1].point.x = point.x
      @path.segments[2].point.x = point.x
      @path.segments[2].point.y = point.y
      @path.segments[2].point.y = point.y
      @path.segments[3].point.y = point.y
