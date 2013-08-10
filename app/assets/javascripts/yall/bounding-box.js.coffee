$ ->
  class paper.BoundingBox
    constructor: (item) ->
      @selection = item
      
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
      @box = g

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

    remove: ->
      @selection.remove()


