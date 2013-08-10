#= require tools/tool-delegator

$ ->
  class paper.StateMachineTool extends paper.ToolDelegator
    constructor: (states, stateOptions) ->
      @states = states
      @state = stateOptions.initialState
      @hitOptions =
        segment   : true
        fill      : true
        stroke    : true
        tolerance : 5

      @tools = {}

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
      toolName = @meetsPredicate 'mouseMove', @wrapEvent event
      tool = @toolByName toolName

    onMouseDown: ->
      null
    onMouseDrag: ->
      null

    wrapEvent: (event) ->
        event: event
        hitTest: paper.project.hitTest event.point, @hitOptions

    toolByName: (name) ->
      unless @tools[name]
        @tools[name] = new paper[@toolName name]()
      @tools[name]

    toolName: (name) ->
      chars = name.split ''
      chars[0].toUpperCase()
      (chars.join('') + 'Tool')

    meetsPredicate: (name, event) ->
      for toolName, properties of @states[name]
        if properties['predicate'] && properties['predicate'](event)
          return toolName
        else if !properties['predicate']
          return toolName


