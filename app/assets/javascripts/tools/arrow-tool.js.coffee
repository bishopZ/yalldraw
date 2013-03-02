$ ->
  class paper.ArrowTool extends paper.Tool
    constructor: (point) ->
      super()
      @selection = null
      @modifyListeners = []
      @removeListeners = []
      @selectListeners = []
      @resizeDirection
      @hitOptions =
        segment   : true
        stroke    : true
        tolerance : 5

    styleChange: (s) ->
      @selection.children.filter((e) -> e.type).map( (e) -> e.style = s )

    onMouseDown: (e) ->
      hitTest = paper.project.hitTest e.point, @hitOptions
      return if @selection and hitTest and @selection.isChild hitTest.item
      @unSelect() unless hitTest

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
        refresh()

    resizeBoxes: ->
      boxes = @selection.children.filter((e) -> e.box)[0].children
      boxes.map (e) ->
        e.bounds.width = e.bounds.height = 10

    onMouseMove: (e) ->
      hitTest = paper.project.hitTest e.point, @hitOptions
      noHoverSelect()
      @setCursor hitTest && hitTest.item
      return if !hitTest || (@selection and @selection.isChild hitTest.item)
      unless @isBox hitTest.item
        hitTest.item.selected = true
        @keySelection = hitTest.item

    onMouseUp: (e) ->
      if @selection
        for s in @selection.children
          @trigger 'modify', s unless s.box
      @resizeDirection = @point = @p = null

    onKeyDown:  (e) ->
      if @keySelection and e.key == 'delete'
        @keySelection.remove()
        @trigger 'remove', @keySelection
        refresh()

    resize: (e) ->
      bounds = null
      if @resizeDirection == 'n'
        bounds = @selection.bounds.setTop e.point.y
      else if @resizeDirection == 's'
        bounds = @selection.bounds.setBottom e.point.y
      else if @resizeDirection == 'w'
        bounds = @selection.bounds.setLeft e.point.x
      else if @resizeDirection == 'e'
        bounds = @selection.bounds.setRight e.point.x
      else if @resizeDirection == 'ne'
        bounds = @selection.bounds.setTopRight e.point
      else if @resizeDirection == 'se'
        bounds = @selection.bounds.setBottomRight e.point
      else if @resizeDirection == 'nw'
        bounds = @selection.bounds.setTopLeft e.point
      else if @resizeDirection == 'sw'
        bounds = @selection.bounds.setBottomLeft e.point



      @selection.setBounds bounds

    setCursor: (item) ->
      if item and item.handle
        $('canvas').css('cursor', item.handle + '-resize')
      else if item
        $('canvas').css('cursor', 'move')
      else
        $('canvas').css('cursor', 'auto')

    unSelect: ->
      return if !@selection
      while @selection.children.length > 1
        paper.project.activeLayer.addChild @selection.children[0] unless @selection.children[0].handle
      @selection.remove()
      @selection = null

    isBox: (item) ->
      return false if !@selection
      return true if item.handle
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

      nE.handle = 'nw'
      n.handle = 'n'
      nW.handle = 'ne'
      w.handle = 'e'
      sW.handle = 'se'
      s.handle = 's'
      sE.handle = 'sw'
      e.handle = 'w'

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
