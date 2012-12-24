$ ->
  class paper.ToolDelegator extends paper.Tool
    onMouseDrag: (e) ->
      return if !@tool or !@tool.onMouseDrag
      @tool.onMouseDrag e.point

    onMouseMove: (e) ->
      return if !@tool or !@tool.onMouseMove
      @tool.onMouseMove e.point

    onMouseUp: (e) ->
      return unless @tool
      @tool.onMouseUp e.point if @tool.onMouseUp

    onKeyDown: (e) ->
      return if !@tool or !@tool.onKeyDown
      return unless @tool
      @tool.onKeyDown e.point

    onKeyUp: (e) ->
      return if !@tool or !@tool.onKeyUp
      return unless @tool
      @tool.onKeyUp e.point
