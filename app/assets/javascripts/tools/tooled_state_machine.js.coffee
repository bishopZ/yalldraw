$ ->
  class paper.TooledStateMachine extends paper.Tool
    constructor: (states, stateOptions) ->
      @states = states
      @state = stateOptions.initialState

    transition: (state, properties) ->
      if @canTransition state
        @states[this.state].off && this.states[this.state].off properties
        @state = state
        @states[this.state].on && this.states[this.state].on properties
        true
      else
        false

    @canTransition: (state) ->
      @states[state] && this.states[this.state][state]
