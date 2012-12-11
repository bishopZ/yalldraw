$ ->
  canvas    = $('canvas')
  return if !canvas.length
  rawCanvas = canvas[0]
  context   = rawCanvas.getContext('2d')
  w         = canvas.parent().width()
  h         = canvas.parent().height()
  rawCanvas.style.width   = rawCanvas.width  = w
  rawCanvas.style.height  = rawCanvas.height = h
