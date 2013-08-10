var yall = (function(my) {
  var tool = null;

  my.initTool = function () {
    toolHandler = new paper.ToolHandler(this.style && this.style());
    tool = toolHandler
    //tool.bind('add', yall.persister.add);

    var colorOptions = {
      realtime: true,
      invertControls: false,
      controlStyle: 'raised',
      alpha: false
    };

    $('input#fg-color').colorpicker(colorOptions);
    $('input#bg-color').colorpicker(colorOptions);

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

    $('.btn-group button').on('click', function(e) {
      toolName = $(this).text().toLowerCase();

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
