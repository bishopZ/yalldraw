$ ->
  class HardSelection
    constructor: ->
      @group = null
      @boundingBox = null

    put: (item, alongside) ->
      unless @group?.isChild item
        @clear() if alongside
        @add item

    add: (item) ->
      if @group
        @boundingBox.remove()

        if item.isAbove @group
          @group.addChild item
        else
          @group.insertChild 0, item
      else
        @group = new paper.Group()
        paper.project.activeLayer.insertChild item.index, @group
        nextHighest = item.nextSibling
        item.oldIndex = item.index
        @group.insertChild item.index, item

      @boundingBox = new paper.BoundingBox @group unless @boundingBox

    clear: ->
      @unSelect()
      @boundingBox.remove() if @boundingBox
      @boundingBox = null
      @items = []

    unSelect: ->
      return if !@group
      children = @group.children.sort (a, b)->
        a.index > b.index

      i = 0
      limit = @group.children.length
      while i++ < limit
        paper.project.activeLayer.insertChild children[children.length - 1].oldIndex, children[children.length - 1]

      @group.remove()
      @group = null


  paper.hardSelection = new HardSelection()
