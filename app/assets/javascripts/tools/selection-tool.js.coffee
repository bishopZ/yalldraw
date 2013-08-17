#= require tools/state-machine-tool
$ ->
  class paper.SelectionTool extends paper.StateMachineTool
    constructor: () ->
      super(
        'onMouseMove': [
          'resize'
          'rotate'
          'hard'
          'hover'
          'none'
        ]
        'onMouseDown': [
          'resize'
          'hard'
          'none'
        ]
        'onMouseDrag': [
          'resize'
          'hard'
          'none'
        ]
      ,'none'
      )

    styleChange: (style) ->
      paper.hardSelection.group.children.filter((e) -> e.type).map( (e) -> e.style = style )

