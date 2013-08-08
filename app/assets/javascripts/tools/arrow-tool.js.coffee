$ ->
  class paper.ArrowTool extends paper.Tool
    constructor: (point) ->
      super()
      @selection = null
      @box = null
      @resizeDirection
      @hitOptions =
        segment   : true
        fill      : true
        stroke    : true
        tolerance : 5

    styleChange: (s) ->
      @selection.children.filter((e) -> e.type).map( (e) -> e.style = s )

    onMouseDown: (e) ->
      hitTest = paper.project.hitTest e.point, @hitOptions

      if hitTest
        if hitTest.item.handle
          state.transition 'resize', e, hitTest
        else
          state.transition 'hard', e, hitTest
      else
        state.transition 'none'

      if hitTest and hitTest.item.handle
        @resizeDirection = hitTest.item.handle
      else if hitTest
        @unSelect() if !e.event.shiftKey
        @point = e.point
        @addSelection hitTest.item

    onMouseDrag:  (e) ->
      if @resizeDirection
        @resize e
        @resizeBoxes()
      else if @selection
        @selection.translate e.delta
        @resizeBoxes()
      refresh()

    onMouseMove: (e) ->
      hitTest = paper.project.hitTest e.point, @hitOptions
      noHoverSelect()
      @setCursor hitTest && hitTest.item
      return if !hitTest || (@selection and @selection.isChild hitTest.item)
      unless @isBox hitTest.item
        hitTest.item.selected = true
        @keySelection = hitTest.item

    onKeyDown:  (e) ->
      if @keySelection and e.key == 'delete'
        @keySelection.remove()
        @trigger 'remove', @keySelection
        refresh()

    unSelect: ->
      return if !@selection
      children = @selection.children.sort (a, b)->
        a.index > b.index

      i = 0
      limit = @selection.children.length
      while i++ < limit
        paper.project.activeLayer.insertChild children[children.length - 1].oldIndex, children[children.length - 1]

      @selection.remove()
      @box.remove()
      @box = @selection = null

    addSelection: (item) ->
      item.selected = false

      if @selection
        @box.remove()

        if item.isAbove @selection
          @selection.addChild item
        else
          @selection.insertChild 0, item

        @box = @boundingBox @selection
        paper.project.layers[0].addChild @box
      else
        @selection = new paper.Group()
        paper.project.activeLayer.insertChild item.index, @selection
        nextHighest = item.nextSibling
        item.oldIndex = item.index
        @selection.insertChild item.index, item
        @box = @boundingBox @selection

      @box.style.strokeColor = 'black'
      @box.style.fillColor = 'white'
      refresh()
