$ ->
  class paper.HoverTool extends paper.Tool
    onMouseMovePredicate: (event)->
      event.hitsItem() && !event.hasHardSelection()

    onMouseMove: (event)->
      paper.hoverSelection.add event.hitTest.item
