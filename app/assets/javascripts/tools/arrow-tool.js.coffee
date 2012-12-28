$ ->
  class paper.ArrowTool extends paper.Tool
    constructor: (point) ->
      super()
      @selectedItems = []
      @modifyListeners = []
      @removeListeners = []
      @selectListeners = []
      @hitOptions =
        segment   : true
        stroke    : true
        tolerance : 5

    onMouseDown: (e) ->
      hitTest = paper.project.hitTest e.point, @hitOptions
      if hitTest
        @selected = [hitTest.item]
        @point = e.point

    onMouseDrag:  (e) ->
      return if !@selected.length

      if @p
        s.translate @p.negate() for s in @selected
      @p = e.point.subtract @point
      s.translate @p for s in @selected
      refresh()

    onMouseMove: (e) ->
      hitTest = paper.project.hitTest e.point, @hitOptions
      if hitTest
        noSelect()
        hitTest.item.selected = true
        @keySelection = hitTest.item
      else
        noSelect()

    onMouseUp: (e) ->
      @trigger 'modify', s for s in @selected
      @point = @p = null
      @selected = []

    onKeyDown:  (e) ->
      if @keySelection and e.key == 'delete'
        @keySelection.remove()
        @trigger 'remove', @keySelection
        refresh()

    noSelect = ->
      v.selected = false for v in paper.project.selectedItems

    refresh = ->
      paper.view.draw()

    bind: (event, listener) ->
      this[event + 'Listeners'].push listener

    trigger: (event, path) ->
      listener path for listener in this[event + 'Listeners']
