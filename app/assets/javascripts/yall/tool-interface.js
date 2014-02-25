var yall = (function(my) {
  var tool = null;

  my.initTool = function () {
    toolHandler = new paper.ToolHandler(this.style && this.style());
    tool = toolHandler;

    $('#fg-color').ColorPicker({
      onChange: function (hsb, hex, rgb) {
        $('#fg-color div').css('backgroundColor', '#' + hex);
        yall.updateStyle();
      }
    });

    $('#bg-color').ColorPicker({
      onChange: function (hsb, hex, rgb) {
        $('#bg-color div').css('backgroundColor', '#' + hex);
        yall.updateStyle();
      }
    });

    $('#brush-size-slider').slider({
      min: 0,
      max: 10,
      step: .1,
      value: 6,
      slide: function() {
        $('#brush-size-text').val($('#brush-size-slider').slider('value'))
        $('#brush-size-text').trigger('change');
      }
    });

    $('input#brush-size-text').change(function() {
      my.updateStyle();
    });

    $('.tool-btn').click(function(e) {
      paper.hardSelection.clear()
      toolName = $(this).data('tool');

      if (toolName === 'arrow') {
        // SelectionTool should not be delegated from ToolHandler because ToolHandler aims to just send one time events, SelectionTool has to manage state
        tool = new paper.SelectionTool();
        tool.activate()
        //paper.tool.bind('remove', yall.persister.remove);
        //paper.tool.bind('modify', yall.persister.modify);
      } else {
        if (paper.tool && paper.tool.unSelect)
          paper.tool.unSelect();

        tool = toolHandler
        my.refresh();
        yall.getTool().switchTool(toolName);
        yall.getTool().activate()
      }
    });
  };

  my.getTool = function() { return tool; };

  paper.tool = my.getTool();
  return my;
})(yall || {});
