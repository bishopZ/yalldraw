$ ->
  class paper.CircleTool extends Tool
    constructor: (point) ->
      super()
      @point = point

    onMouseDrag: (point) ->
      @path.remove() if @path
      @path = new Path.Circle @point, point.getDistance @point
      @path.type = 'Circle'
