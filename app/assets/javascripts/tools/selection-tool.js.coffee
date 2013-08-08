#= require tools/state-machine-tool
$ ->
  class paper.SelectionTool extends paper.StateMachineTool
    constructor: () ->
      super(
        new StateMachineTool
          'none'
            'mouseMove': [
              'resize':
                'predicate': (event) ->
                  event.hitTest.item.handle
              'hard':
                'predicate': (event) ->
                  event.hitTest.item = paper.hardSelection.item
              'hover':
                'predicate': (event) ->
                  event.hitTest.item
              'none'
            ]

            'mouseDown': [
              'resize'
                'predicate': (event) ->
                  event.hitTest.item.handle
                'persist': (event) ->
                  'selectedBox': event.hitTest.item
              'hard'
                'predicate' : (event) ->
                  event.hitTest
              'none'
            ]

            'mouseDrag': [
              'resize':
                'predicate': (event) ->
                  event.hardSelection.items.length &&
                    event.hitTest.item.handle
              'hard':
                'predicate': (event) ->
                   paper.hardSelection.items.length
            ]
            , 'none'
          )


