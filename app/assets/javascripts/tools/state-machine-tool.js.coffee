#= require tools/tool-delegator

$ ->
  class paper.StateMachineTool extends paper.Tool
    constructor: (states, stateOptions) ->
      @states = states
      @state = stateOptions.initialState
      @lastTool = null
      @lastEvent = null
      @hitOptions =
        segment   : true
        fill      : true
        stroke    : true
        tolerance : 5
      @hitOptionsDistant =
        segment   : true
        fill      : true
        stroke    : true
        tolerance : 55

      @tools = {}

      super()

    onMouseMove: (event) -> @on 'onMouseMove', event
    onMouseDown: (event) -> @on 'onMouseDown', event
    onMouseDrag: (event) -> @on 'onMouseDrag', event

    on: (eventName, event) ->
      if eventName == @lastEvent
        if @lastTool && @toolByName(@lastTool)[eventName + 'Sticky']
          toolName = @lastTool
      else
        @lastEvent = null

      toolName = toolName || @toolForEvent eventName, @wrapEvent event

      if toolName
        @lastEvent = eventName
        @lastTool = toolName
        tool = @toolByName toolName
        tool[@eventName eventName] @wrapEvent event


    toolForEvent: (eventName, event) ->
      @meetsPredicate eventName, event

    wrapEvent: (event) ->
        event: event.event
        hitTest: paper.project.hitTest event.point, @hitOptions
        hitTestDistant: paper.project.hitTest event.point, @hitOptionsDistant

    toolByName: (name) ->
      unless @tools[name]
        @tools[name] = new paper[@toolName name]()
      @tools[name]

    eventName: (name) ->
      name

    toolName: (name) ->
      chars = name.split ''
      chars[0] = chars[0].toUpperCase()
      chars.join('') + 'Tool'

    meetsPredicate: (eventName, event) ->
      last = null

      for toolName in @states[eventName]
        last = toolName
        tool = @toolByName(toolName)

        if tool && tool[eventName + 'Predicate'] && tool[eventName + 'Predicate'](new EventPredicate event)
          return toolName

      last unless @states[last] && @states[last]['Predicate']

  class EventPredicate
    constructor: (event) ->
      @event = event

    hasHardSelection: ->
      paper.hardSelection?.group?.children.length

    hitsItem: ->
      @event.hitTest?.item

    hitsHandle: ->
      @event.hitTest?.item?.handle

    pastHandle: ->
      ht = @event.hitTestDistant
      return false unless ht?.item?.handle
      mouseX = event.offsetX
      mouseY = event.offsetY
      handle = ht.item.handle
      item = ht.item

      # probably can do paper.hardSelection.inBounds? mouse
      if 'w' == handle
        return mouseX < item.bounds.left
      else if 'nw' == handle
        return mouseX < item.bounds.left && mouseY < item.bounds.top
      else if 'n' == handle
        return mouseY < item.bounds.top
      else if 'ne' == handle
        return mouseX > item.bounds.left && mouseY < item.bounds.top
      else if 'e' == handle
        return mouseX > item.bounds.left
      else if 'se' == handle
        return mouseX > item.bounds.left && mouseY > item.bounds.top
      else if 's' == handle
        return mouseY > item.bounds.top
      else if 'sw' == handle
        return mouseX < item.bounds.left && mouseY > item.bounds.top
