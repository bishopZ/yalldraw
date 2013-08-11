#= require tools/state-machine-tool
$ ->
  class paper.SelectionTool extends paper.StateMachineTool
    constructor: () ->
      super(
        'mouseMove':
          'resize':
            'predicate': (event) ->
              event.hitTest?.item?.handle
          'hard':
            'predicate': (event) ->
              event.hitTest?.item && paper.hardSelection?.group?.children.length
          'hover':
            'predicate': (event) ->
              event.hitTest?.item && !(paper.hardSelection?.group?.children.length)
          'none': {}

        'mouseDown':
          'resize':
            'predicate': (event) ->
              event.hitTest?.item?.handle
            'persist': (event) ->
              'selectedBox': event.hitTest.item
          'hard':
            'predicate': (event) ->
              event.hitTest?.item
          'none': {}

        'mouseDrag':
          'resize':
            'predicate': (event) ->
              paper.hardSelection?.group?.children.length &&
                event.hitTest?.item?.handle
            'sticky': 'true'
          'hard':
            'predicate': (event) ->
               paper.hardSelection?.group?.children.length
          'none': {}
      ,'none'
      )

