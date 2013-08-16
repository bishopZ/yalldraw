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

      hitsHandle: ->
        @event.hitTest?.item?.handle

      hitsItem: ->
        @event.hitTest?.item



