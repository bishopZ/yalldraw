var yall = (function(my) {
  var tool = null;

  my.initTool = function () {
    tool = new paper.ToolHandler(this.style && this.style());
    tool.bind('add', yall.persister.add);

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
        paper.tool = new paper.SelectTool();
        paper.tool.bind('remove', yall.persister.remove);
        paper.tool.bind('modify', yall.persister.modify);
      } else {
        if (paper.tool && paper.tool.unSelect)
          paper.tool.unSelect();
          my.refresh()
        yall.getTool().switchTool(toolName);
        paper.tool = yall.getTool();
      }
    });
  };

  my.getTool = function() { return tool; };

  paper.tool = my.getTool();
  return my;
})(yall || {});
