$ ->
  class HardSelection
    constructor: ->
      @items = []
      @selection = null

    add: (item) ->
      @selection.remove() if @selection

      if item.isAbove @selection
        @selection.addChild item
      else
        @selection.insertChild 0, item

    clear: ->
      @selection=  new paper.Group()

  paper.hardSelection = new HardSelection()
