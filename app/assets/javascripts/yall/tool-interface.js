var yall = (function(my) {
  var tool = null;

  my.initTool = function () {
    tool = new paper.ToolHandler(this.style());

    $('.btn-group button').on('click', function(e) {
      toolName = $(e.srcElement).text().toLowerCase();

      if (toolName === 'arrow') {
        paper.tool = new paper.ArrowTool();
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
