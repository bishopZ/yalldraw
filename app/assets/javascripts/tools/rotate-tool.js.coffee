class paper.RotateTool extends paper.Tool

  onMouseMovePredicate: (event) ->
    event.pastHandle()

  onMouseMove: (event) ->
    console.log 'rotating'

