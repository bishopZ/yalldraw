class paper.ResizeTool extends paper.Tool
  constructor: ->

  onMouseMove: (event)->
    $('canvas').css 'cursor', event.hitTest.item.handle + '-resize'

  onMouseDown: (event) ->

  onMouseDrag: (event) ->
