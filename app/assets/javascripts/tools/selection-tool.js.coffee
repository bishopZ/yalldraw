#= require tools/state-machine-tool
$ ->
  class paper.SelectionTool extends paper.StateMachineTool
    constructor: () ->
      super(
        'mouseMove':
          'resize':
            'predicate': (event) ->
              event.hitsHandle()
          'hard':
            'predicate': (event) ->
              event.hitsHandle() && event.hasHardSelection()
          'hover':
            'predicate': (event) ->
              event.hitsItem() && !event.hasHardSelection()
          'none': {}

        'mouseDown':
          'resize':
            'predicate': (event) ->
              event.hitsHandle()
          'hard':
            'predicate': (event) ->
              event.hitsItem()
          'none': {}

        'mouseDrag':
          'resize':
            'predicate': (event) ->
              event.hasHardSelection() && event.hitsHandle()
            'sticky': 'true'
          'hard':
            'predicate': (event) ->
              event.hasHardSelection()
          'none': {}
      ,'none'
      )

    styleChange: (style) ->
      paper.hardSelection.group.children.filter((e) -> e.type).map( (e) -> e.style = style )

