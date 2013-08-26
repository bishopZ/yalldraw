var yall = (function(my) {
  my.style = function () {
    return {
      strokeColor: $('#fg-color div').css('background-color'),
      strokeWidth:  $('#brush-size-text').val(),
      fillColor:    $('#bg-color div').css('background-color')
    };
  };

  my.updateStyle = function () {
    if (paper.tool && paper.tool.selection) {
      paper.tool.styleChange(my.style());
    }

    if (my.getTool()) {
      my.getTool().styleChange(my.style());
    }
  };

  return my;
})(yall || {});
