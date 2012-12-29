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
      @unSelect() unless hitTest
      return if @selection and @selection.isChild hitTest.item
      @unSelect() if !e.event.shiftKey
      if hitTest
        @point = e.point
        @addSelection hitTest.item

    onMouseDrag:  (e) ->
      return if !@selection

      @selection.translate e.delta
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

    unSelect: ->
      return if !@selection
      while @selection.children.length > 1
        paper.project.activeLayer.addChild @selection.children[0] unless @selection.children[0].box
      @selection.remove()
      @selection = null

    isBox: (item) ->
      return false if !@selection
      return true if item.box
      return @selection.isChild item

    addSelection: (item) ->
      return false if @selection and @selection.isChild(item)
      item.selected = false

      if @selection
        @selection.lastChild.remove()
        @selection.addChild item
        @selection.addChild @boundingBox @selection
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
      p.box = true for p in points
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
