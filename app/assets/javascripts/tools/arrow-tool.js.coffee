$ ->
  class paper.ArrowTool extends paper.Tool
    constructor: (point) ->
      super()
      @selection = null
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
        @point = e.point
        @addSelection hitTest.item
      else
        @selection = null

    onMouseDrag:  (e) ->
      return if !@selection
      if @p and @selection
        @selection.translate @p.negate()
      @p = e.point.subtract @point
      @selection.translate @p if @selection
      refresh()

    onMouseMove: (e) ->
      hitTest = paper.project.hitTest e.point, @hitOptions
      noHoverSelect()
      return if !hitTest or @isBox hitTest.item

      hitTest.item.selected = true
      @keySelection = hitTest.item

    onMouseUp: (e) ->
      if @selection
        for s in @selection.children
          @trigger 'modify', s unless s.box
      @point = @p = null

    onKeyDown:  (e) ->
      if @keySelection and e.key == 'delete'
        @keySelection.remove()
        @trigger 'remove', @keySelection
        refresh()

    isBox: (item) ->
      return false if !@selection
      @selection.isChild item

    addSelection: (item) ->
      item.selected = false

      if @selection
        @selection.addChild(item)
        @selection.lastChild = @boundingBox @selection
      else
        @selection = new paper.Group()
        @selection.addChild item
        @selection.addChild @boundingBox item
      @selection.lastChild.style.strokeColor = 'black'
      @selection.lastChild.style.fillColor = 'white'
      refresh()

    boundingBox: (item) ->
      size = 10
      nE = paper.Path.Rectangle item.bounds.topLeft.clone(), size
      n = paper.Path.Rectangle item.bounds.topCenter.clone(), size
      nW = paper.Path.Rectangle item.bounds.topRight.clone(), size
      w = paper.Path.Rectangle item.bounds.rightCenter.clone(), size
      sW = paper.Path.Rectangle item.bounds.bottomRight.clone(), size
      s = paper.Path.Rectangle item.bounds.bottomCenter.clone(), size
      sE = paper.Path.Rectangle item.bounds.bottomLeft.clone(), size
      e = paper.Path.Rectangle item.bounds.leftCenter.clone(), size
      points = [nE, n, nW, w, sW, s, sE, e]
      g = new paper.Group points
      g.box = true
      g.translate(new paper.Point(size * -.5, size * -.5))
      g

    noHoverSelect = ->
      v.selected = false for v in paper.project.selectedItems

    refresh = ->
      paper.view.draw()

    bind: (event, listener) ->
      this[event + 'Listeners'].push listener

    trigger: (event, path) ->
      listener path for listener in this[event + 'Listeners']
