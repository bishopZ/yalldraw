$ ->
  class paper.ArrowTool extends Tool
    constructor: (point) ->
      super()
      @modifyListeners = []
      @removeListeners = []
      @selectListeners = []
      @hitOptions =
        segment   : true
        stroke    : true
        tolerance : 5

    onMouseDown: (e) ->
      console.log 'mouseDown'
      hitTest = project.hitTest e.point, @hitOptions
      if hitTest
        @softSelected = hitTest.item
        @point    = e.point

    onMouseDrag:  (e) ->
      if !@softSelected
        return

      if @p
        @softSelected.translate @p.negate()
      @p = e.point.subtract @point
      @softSelected.translate @p
      refresh()

    onMouseMove: (e) ->
      hitTest = project.hitTest e.point, @hitOptions
      if hitTest
        noSelect()
        hitTest.item.selected = true
        @keySelection = hitTest.item
      else
        noSelect()

    onMouseUp: (e) ->
      if @hardSelected
        console.log 'dont know what to do'
      else if @softSelected
        @trigger 'modify', @softSelected if @softSelected
        @softSelected = @point = @p = null

    onKeyDown:  (e) ->
     if @keySelection and e.key == 'delete'
       @keySelection.remove()
       @trigger 'remove', @keySelection
       refresh()

    noSelect = ->
      v.selected = false for v in project.selectedItems

    refresh = ->
      paper.view.draw()

    bind: (event, listener) ->
      this[event + 'Listeners'].push listener

    trigger: (event, path) ->
      listener path for listener in this[event + 'Listeners']
