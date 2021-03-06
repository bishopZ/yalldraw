$ ->
  class paper.CircleTool extends paper.Tool
    constructor: (point) ->
      @point = point

    onMouseDrag: (point) ->
      @path.remove() if @path
      @path = new paper.Path.Circle @point, point.getDistance @point
      @path.type = 'Circle'
