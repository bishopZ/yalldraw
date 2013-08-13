#= require tools/state-machine-tool
$ ->
  class paper.SelectionTool extends paper.StateMachineTool
    constructor: () ->
      hasHardSelection = ->
        paper.hardSelection?.group?.children.length

      hitsHandle = (event) ->
        event.hitTest?.item?.handle

      hitsItem = (event) ->
        event.hitTest?.item

      super(
        'mouseMove':
          'resize':
            'predicate': (event) ->
              hitsHandle event
          'hard':
            'predicate': (event) ->
              hitsHandle(event) && hasHardSelection()
          'hover':
            'predicate': (event) ->
              hitsItem(event) && !(hasHardSelection())
          'none': {}

        'mouseDown':
          'resize':
            'predicate': (event) ->
              hitsHandle(event)
          'hard':
            'predicate': (event) ->
              hitsItem(event)
          'none': {}

        'mouseDrag':
          'resize':
            'predicate': (event) ->
              hasHardSelection() && hitsHandle(event)
            'sticky': 'true'
          'hard':
            'predicate': (event) ->
              hasHardSelection()
          'none': {}
      ,'none'
      )

    styleChange: (style) ->
      paper.hardSelection.group.children.filter((e) -> e.type).map( (e) -> e.style = style )

