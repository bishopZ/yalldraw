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

    onMouseMove: (event) -> @on 'mouseMove', event
    onMouseDown: (event) -> @on 'mouseDown', event
    onMouseDrag: (event) -> @on 'mouseDrag', event

    on: (eventName, event) ->
      if eventName == @lastEvent
        if @lastTool && @states[eventName][@lastTool]['sticky']
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
      chars = name.split ''
      chars[0] = chars[0].toUpperCase()
      'on' + chars.join('')

    toolName: (name) ->
      chars = name.split ''
      chars[0] = chars[0].toUpperCase()
      chars.join('') + 'Tool'

    meetsPredicate: (eventName, event) ->
      last = null

      for toolName, properties of @states[eventName]
        last = toolName
        # sure would be nice to not preface the condtionals
        if properties && properties['predicate'] && properties['predicate'](event)
          return toolName
        else if properties && !properties['predicate']
          return toolName

      last unless @states[last] && @states[last]['predicate']


