#= require tools/tool-delegator

$ ->
  class paper.StateMachineTool extends paper.Tool
    constructor: (states, stateOptions) ->
      @states = states
      @state = stateOptions.initialState
      @hitOptions =
        segment   : true
        fill      : true
        stroke    : true
        tolerance : 5

      @tools = {}

      super()

    transition: (state, properties) ->
      if @canTransition state
        @states[this.state].off && this.states[this.state].off properties
        @state = state
        @states[this.state].on && this.states[this.state].on properties
        true
      else
        false

    canTransition: (state) ->
      @states[state] && this.states[this.state][state]

    onMouseMove: (event)->
      toolName = @toolForEvent 'mouseMove', @wrapEvent event
      if toolName
        tool = @toolByName toolName
        tool.onMouseMove @wrapEvent event

    onMouseDown: (event)->
      toolName = @toolForEvent 'mouseDown', @wrapEvent event
      if toolName
        tool = @toolByName toolName
        tool.onMouseDown @wrapEvent event

    onMouseDrag: (event) ->
      toolName = @toolForEvent 'mouseDrag', @wrapEvent event
      if toolName
        tool = @toolByName toolName
        tool.onMouseDrag @wrapEvent event

    toolForEvent: (eventName, event) ->
      @meetsPredicate eventName, event

    wrapEvent: (event) ->
        event: event.event
        hitTest: paper.project.hitTest event.point, @hitOptions

    toolByName: (name) ->
      unless @tools[name]
        @tools[name] = new paper[@toolName name]()
      @tools[name]

    toolName: (name) ->
      chars = name.split ''
      chars[0] = chars[0].toUpperCase()
      (chars.join('') + 'Tool')

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


