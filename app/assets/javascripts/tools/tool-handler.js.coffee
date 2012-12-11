$ ->
  class paper.ToolHandler extends paper.ToolDelegator
    constructor: (style) ->
      super()
      @style = style
      @addListeners = []
      @toolClass = 'CircleTool'

    styleChange: (style) ->
      @style = style

    onMouseDown: (e) ->
      @tool = new paper[@toolClass] e.point if @toolClass
      @assignStyle @style

    onMouseDrag: (e) ->
      super e
      @assignStyle @style

    assignStyle: (style)->
      @tool.path.style = style if @tool?.path

    onMouseUp: (e) ->
      super e
      @trigger 'add', @tool.path

    switchTool: (name) ->
      capitalName = name.substr(0, 1).toUpperCase() + name.substr 1
      className = capitalName + 'Tool'
      @toolClass = className if paper[className]

    bind: (event, listener) ->
      this[event + 'Listeners'].push listener

    trigger: (event, path) ->
      listener path for listener in this[event + 'Listeners']
