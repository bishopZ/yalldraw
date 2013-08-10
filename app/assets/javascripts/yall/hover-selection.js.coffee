$ ->
  class HoverSelection
    constructor: ->
      @items = []

    add: (item) ->
      @items.push item
      @setSelected @items, true

    clear: ->
      @setSelected @items, false

    setSelected: (list, selected) ->
      i.selected = selected for i in list

  paper.hoverSelection = new HoverSelection()
