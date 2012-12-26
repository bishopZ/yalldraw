var yall = (function(my) {
  var tool = null;

  my.initTool = function () {
    tool = new paper.ToolHandler(this.style());
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
      }
    });

    $('.btn-group button').on('click', function(e) {
      toolName = $(e.currentTarget).text().toLowerCase();

      if (toolName === 'arrow') {
        paper.tool = new paper.ArrowTool();
        paper.tool.bind('remove', yall.persister.remove);
        paper.tool.bind('modify', yall.persister.modify);
      } else {
        yall.getTool().switchTool(toolName);
        paper.tool = yall.getTool();
      }
    });
  };

  my.getTool = function() { return tool; };

  paper.tool = my.getTool();
  return my;
})(yall || {});
