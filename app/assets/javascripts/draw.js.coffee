paper.install window

$ ->
  canvas    = $ 'canvas'
  return if !canvas.length
  rawCanvas = canvas[0]
  context   = rawCanvas.getContext '2d'

  refresh = ->
    paper.view.draw()

  serializeColor = (color) ->
    return null if !color?
    red: color.red
    green: color.green
    blue: color.blue

  serializeStyle = (item) ->
    return null if !item?
    fillColor: serializeColor item.fillColor
    miterLimit: item.miterLimit
    strokeColor: serializeColor item.strokeColor
    strokeCap: item.strokeCap
    strokeJoin: item.strokeJoin
    strokeWidth: item.strokeWidth

  drawing_id = -> $('body').data 'drawing-id'

  remove = (path) ->
    $.post '/drawing/remove'
      graphic_id: path.graphic_id
      drawing_id: drawing_id()

  style = ->
      strokeColor:  $('input#fg-color').val()
      strokeWidth:  $('#brush-size-text').val()
      fillColor:    $('input#bg-color').val()

  updateStyle = =>
    @toolHandler.styleChange style()

  $.colorpicker.setDefaults
    onSelect: => updateStyle()
  $('.ui-slider').slider
    change: =>
      updateStyle()

  serializePath = (path) ->
    segs = []
    for s in path.segments
      segs.push [s.point.x, s.point.y,
          s.handleIn.x, s.handleIn.y,
          s.handleOut.x, s.handleOut.y]

    'points': segs
    'style' : serializeStyle path.style
    'graphic_id' : path.graphic_id
    'type' : path.type

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
        value: JSON.stringify serializePath path
        data:
          drawing_id: drawing_id(),
          graphic_id: path.graphic_id
          z: 1
    )

  paper.setup rawCanvas

  $('.btn-group button').on 'click', (e)=>
    toolName = $(e.srcElement).text().toLowerCase()

    if toolName == 'arrow'
      paper.tool = @arrowTool
    else
      @toolHandler.switchTool toolName
      paper.tool = @toolHandler

  @toolHandler = new paper.ToolHandler style()
  @arrowTool = new paper.ArrowTool()

  paper.tool = @toolHandler

  pathEvent = (e, path) =>
    console.log 'new'

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
