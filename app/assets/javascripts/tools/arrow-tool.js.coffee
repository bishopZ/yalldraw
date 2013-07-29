$ ->
  class paper.ArrowTool extends paper.Tool
    constructor: (point) ->
      super()
      @selection = null
      @modifyListeners = []
      @box = null
      @removeListeners = []
      @selectListeners = []
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

      # do nothing if you click on whats already selected
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
        @resizeBoxes()
      refresh()

    resizeBoxes: ->
      return unless @box
      ne = @box.children.filter((b) -> b.handle == 'nw')[0]
      n = @box.children.filter((b) -> b.handle == 'n')[0]
      nw = @box.children.filter((b) -> b.handle == 'ne')[0]
      e = @box.children.filter((b) -> b.handle == 'w')[0]
      se = @box.children.filter((b) -> b.handle == 'sw')[0]
      s = @box.children.filter((b) -> b.handle == 's')[0]
      sw = @box.children.filter((b) -> b.handle == 'se')[0]
      w = @box.children.filter((b) -> b.handle == 'e')[0]

      nw.setPosition @selection.bounds.getTopRight()
      n.setPosition @selection.bounds.getTopCenter()
      ne.setPosition @selection.bounds.getTopLeft()
      w.setPosition @selection.bounds.getRightCenter()
      sw.setPosition @selection.bounds.getBottomRight()
      s.setPosition @selection.bounds.getBottomCenter()
      se.setPosition @selection.bounds.getBottomLeft()
      e.setPosition @selection.bounds.getLeftCenter()


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
      children = @selection.children.sort (a, b)->
        a.index > b.index

      i = 0
      limit = @selection.children.length
      while i++ < limit
        paper.project.activeLayer.insertChild children[children.length - 1].oldIndex, children[children.length - 1]

      #while @selection.children.length
        #paper.project.activeLayer.insertChild @selection.children[0].oldIndex, @selection.children[0]

      @selection.remove()
      @box.remove()
      @box = @selection = null

    isBox: (item) ->
      return false if !@selection
      return true if item.handle
      return @selection.isChild item

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

    boundingBox: (item) ->
      size = Math.min 10, Math.sqrt(Math.min @selection.strokeBounds.width, @selection.strokeBounds.height)
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
