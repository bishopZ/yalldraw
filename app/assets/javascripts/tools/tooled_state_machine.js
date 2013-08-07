var TooledStateMachine = function (states, stateOptions) {
  this.states = states;
  this.state = stateOptions.initialState;

  this.transition = function (state, properties) {
    if (this.canTransition(state)) {
      this.states[this.state].off && this.states[this.state].off(properties);
      this.state = state;
      this.states[this.state].on && this.states[this.state].on(properties);
      return true;
    } else {
      return false;
    }
  }

  this.canTransition = function (state) {
    return this.states[state] && this.states[this.state][state];
  }
}
