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
                'on': (event) ->
                  $('canvas').css 'cursor', event.hitTest.item + '-resize'
              'hard':
                'predicate': (event) ->
                  event.hitTest.item = paper.hardSelection.item
                'on': (event) ->
                  $('canvas').css('cursor', 'move')
              'hover':
                'predicate': (event) ->
                  event.hitTest.item
                'on': (event) ->
                  paper.hoverSelection.add event.hitTest.item
                  event.hitTest.item.selected = true
              'none': ->
                'on': ->
                  $('canvas').css('cursor', 'auto');
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
                'on': (event) ->
                  paper.hoverSelection.clear()
                  paper.hardSelection.clear() if !event.mouse.shiftKey
                  paper.hardSelection.add event.hitTest.item

              'none'
                'on': ->
                  paper.hardSelection.clear()
                  paper.hoverSelection.clear()
            ]

            'mouseDrag': [
              'resize':
                'predicate': (event) ->
                  event.hardSelection.items.length &&
                    event.hitTest.item.handle
              'hard':
                'predicate': (event) ->
                   paper.hardSelection.items.length
                'on':
                  paper.hardSelection.item.translate event.mousse.delta
            ]
            , 'none'
          )


