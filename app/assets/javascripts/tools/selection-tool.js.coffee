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
          'rotate'
          'hard'
          'none'
        ]
        'onMouseDrag': [
          'resize'
          'rotate'
          'hard'
          'none'
        ]
      ,'none'
      )

    styleChange: (style) ->
      paper.hardSelection.group.children.filter((e) -> e.type).map( (e) -> e.style = style )

