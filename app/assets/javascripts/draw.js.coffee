paper.install window

$ ->
  canvas    = $ 'canvas'
  return if !canvas.length
  rawCanvas = canvas[0]

  return
  drawing_id = -> $('body').data 'drawing-id'

  remove = (path) ->
    $.ajax location.pathname + '/remove',
      type: 'delete'
      data:
        graphic_id: path.graphic_id
        drawing_id: drawing_id()

  save = (path) ->
    $.post(
      location.pathname + '/add',
        value: JSON.stringify serializePath path
        drawing_id: drawing_id(),
      (data) ->
        path.graphic_id = data.id
    )

  modify = (path) ->
    $.ajax(
      location.pathname,
        type: 'put'
        data:
          value: JSON.stringify serializePath path
          drawing_id: drawing_id(),
          graphic_id: path.graphic_id
          z: 1
    )

  @toolHandler.bind 'add', (path) =>
    save path if path

  @arrowTool.bind 'modify', (path) =>
    modify path

  @arrowTool.bind 'remove', (path) =>
    remove path


  for v in vectors
    path = new Path()
    path.style = v.style
    path.graphic_id = v.graphic_id
    path.closed = true if v.type

    for s in v.points
      ps = s
      point = new Point ps[0], ps[1]
      handleIn = new Point ps[2], ps[3]
      handleOut = new Point ps[4], ps[5]
      path.add new Segment point, handleIn, handleOut

    refresh()
