$ ->
  class HardSelection
    constructor: ->
      @items = []
      @selection = null
      @boundingBox = null

    put: (item, alongside) ->
      unless @selection?.isChild item
        @clear() if alongside
        @add item

    add: (item) ->
      if @selection
        @boundingBox.remove()

        if item.isAbove @selection
          @selection.addChild item
        else
          @selection.insertChild 0, item
      else
        @selection = new paper.Group()
        paper.project.activeLayer.insertChild item.index, @selection
        nextHighest = item.nextSibling
        item.oldIndex = item.index
        @selection.insertChild item.index, item

      @boundingBox = new paper.BoundingBox @selection unless @boundingBox

    clear: ->
      @unSelect()
      @boundingBox.remove() if @boundingBox
      @boundingBox = null

    unSelect: ->
      return if !@selection
      children = @selection.children.sort (a, b)->
        a.index > b.index

      i = 0
      limit = @selection.children.length
      while i++ < limit
        paper.project.activeLayer.insertChild children[children.length - 1].oldIndex, children[children.length - 1]

      @selection.remove()
      @selection = null


  paper.hardSelection = new HardSelection()
