$ ->
  class HoverSelection
    constructor: ->
      @items = []

    add: (item) ->
      @clear()
      @items.push item
      @setSelected @items, true

    clear: ->
      @setSelected @items, false
      @items = []

    setSelected: (list, selected) ->
      i.selected = selected for i in list

  paper.hoverSelection = new HoverSelection()
